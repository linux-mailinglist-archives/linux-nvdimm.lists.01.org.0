Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BF22ECE43
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Jan 2021 11:54:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 77EB5100EAB48;
	Thu,  7 Jan 2021 02:54:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A0959100EAB48
	for <linux-nvdimm@lists.01.org>; Thu,  7 Jan 2021 02:54:17 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 314C5ACAF;
	Thu,  7 Jan 2021 10:54:16 +0000 (UTC)
Date: Thu, 7 Jan 2021 11:54:09 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2] nvdimm: Avoid race between probe and reading device
 attributes
Message-ID: <20210107105408.GA4072@kitsune.suse.cz>
References: <20200615074723.12163-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615074723.12163-1-rpalethorpe@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Message-ID-Hash: 5YVFAYZ2TMHHFMELLXLENHYRCGIHAMDS
X-Message-ID-Hash: 5YVFAYZ2TMHHFMELLXLENHYRCGIHAMDS
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Richard Palethorpe <rpalethorpe@suse.com>, linux-kernel@vger.kernel.org, Coly Li <colyli@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5YVFAYZ2TMHHFMELLXLENHYRCGIHAMDS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ping?

On Mon, Jun 15, 2020 at 08:47:23AM +0100, Richard Palethorpe wrote:
> It is possible to cause a division error and use-after-free by querying the
> nmem device before the driver data is fully initialised in nvdimm_probe. E.g
> by doing
> 
> (while true; do
>      cat /sys/bus/nd/devices/nmem*/available_slots 2>&1 > /dev/null
>  done) &
> 
> while true; do
>      for i in $(seq 0 4); do
> 	 echo nmem$i > /sys/bus/nd/drivers/nvdimm/bind
>      done
>      for i in $(seq 0 4); do
> 	 echo nmem$i > /sys/bus/nd/drivers/nvdimm/unbind
>      done
>  done
> 
> On 5.7-rc3 this causes:
> 
> [   12.711578] divide error: 0000 [#1] SMP KASAN PTI
> [   12.712321] CPU: 0 PID: 231 Comm: cat Not tainted 5.7.0-rc3 #48
> [   12.713188] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [   12.714857] RIP: 0010:nd_label_nfree+0x134/0x1a0 [libnvdimm]
> [   12.715772] Code: ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 14 11 84 d2 74 05 80 fa 03 7e 52 8b 73 08 31 d2 89 c1 48 83 c4 08 5b 5d <f7> f6 31 d2 41 5c 83 c0 07 c1 e8 03 48 8d 84 00 8e 02 00 00 25 00
> [   12.718311] RSP: 0018:ffffc9000046fd08 EFLAGS: 00010282
> [   12.719030] RAX: 0000000000000000 RBX: ffffffffc0073aa0 RCX: 0000000000000000
> [   12.720005] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888060931808
> [   12.720970] RBP: ffff88806609d018 R08: 0000000000000001 R09: ffffed100cc0a2b1
> [   12.721889] R10: ffff888066051587 R11: ffffed100cc0a2b0 R12: ffff888060931800
> [   12.722744] R13: ffff888064362000 R14: ffff88806609d018 R15: ffffffff8b1a2520
> [   12.723602] FS:  00007fd16f3d5580(0000) GS:ffff88806b400000(0000) knlGS:0000000000000000
> [   12.724600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.725308] CR2: 00007fd16f1ec000 CR3: 0000000064322006 CR4: 0000000000160ef0
> [   12.726268] Call Trace:
> [   12.726633]  available_slots_show+0x4e/0x120 [libnvdimm]
> [   12.727380]  dev_attr_show+0x42/0x80
> [   12.727891]  ? memset+0x20/0x40
> [   12.728341]  sysfs_kf_seq_show+0x218/0x410
> [   12.728923]  seq_read+0x389/0xe10
> [   12.729415]  vfs_read+0x101/0x2d0
> [   12.729891]  ksys_read+0xf9/0x1d0
> [   12.730361]  ? kernel_write+0x120/0x120
> [   12.730915]  do_syscall_64+0x95/0x4a0
> [   12.731435]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [   12.732163] RIP: 0033:0x7fd16f2fe4be
> [   12.732685] Code: c0 e9 c6 fe ff ff 50 48 8d 3d 2e 12 0a 00 e8 69 e9 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> [   12.735207] RSP: 002b:00007ffd3177b838 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   12.736261] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fd16f2fe4be
> [   12.737233] RDX: 0000000000020000 RSI: 00007fd16f1ed000 RDI: 0000000000000003
> [   12.738203] RBP: 00007fd16f1ed000 R08: 00007fd16f1ec010 R09: 0000000000000000
> [   12.739172] R10: 00007fd16f3f4f70 R11: 0000000000000246 R12: 00007ffd3177ce23
> [   12.740144] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
> [   12.741139] Modules linked in: nfit libnvdimm
> [   12.741783] ---[ end trace 99532e4b82410044 ]---
> [   12.742452] RIP: 0010:nd_label_nfree+0x134/0x1a0 [libnvdimm]
> [   12.743167] Code: ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 14 11 84 d2 74 05 80 fa 03 7e 52 8b 73 08 31 d2 89 c1 48 83 c4 08 5b 5d <f7> f6 31 d2 41 5c 83 c0 07 c1 e8 03 48 8d 84 00 8e 02 00 00 25 00
> [   12.745709] RSP: 0018:ffffc9000046fd08 EFLAGS: 00010282
> [   12.746340] RAX: 0000000000000000 RBX: ffffffffc0073aa0 RCX: 0000000000000000
> [   12.747209] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888060931808
> [   12.748081] RBP: ffff88806609d018 R08: 0000000000000001 R09: ffffed100cc0a2b1
> [   12.748977] R10: ffff888066051587 R11: ffffed100cc0a2b0 R12: ffff888060931800
> [   12.749849] R13: ffff888064362000 R14: ffff88806609d018 R15: ffffffff8b1a2520
> [   12.750729] FS:  00007fd16f3d5580(0000) GS:ffff88806b400000(0000) knlGS:0000000000000000
> [   12.751708] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.752441] CR2: 00007fd16f1ec000 CR3: 0000000064322006 CR4: 0000000000160ef0
> [   12.821357] ==================================================================
> [   12.822284] BUG: KASAN: use-after-free in __mutex_lock+0x111c/0x11a0
> [   12.823084] Read of size 4 at addr ffff888065c26238 by task reproducer/218
> [   12.823968]
> [   12.824183] CPU: 2 PID: 218 Comm: reproducer Tainted: G      D           5.7.0-rc3 #48
> [   12.825167] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [   12.826595] Call Trace:
> [   12.826926]  dump_stack+0x97/0xe0
> [   12.827362]  print_address_description.constprop.0+0x1b/0x210
> [   12.828111]  ? __mutex_lock+0x111c/0x11a0
> [   12.828645]  __kasan_report.cold+0x37/0x92
> [   12.829179]  ? __mutex_lock+0x111c/0x11a0
> [   12.829706]  kasan_report+0x38/0x50
> [   12.830158]  __mutex_lock+0x111c/0x11a0
> [   12.830666]  ? ftrace_graph_stop+0x10/0x10
> [   12.831193]  ? is_nvdimm_bus+0x40/0x40 [libnvdimm]
> [   12.831820]  ? mutex_trylock+0x2b0/0x2b0
> [   12.832333]  ? nvdimm_probe+0x259/0x420 [libnvdimm]
> [   12.832975]  ? mutex_trylock+0x2b0/0x2b0
> [   12.833500]  ? nvdimm_probe+0x259/0x420 [libnvdimm]
> [   12.834122]  ? prepare_ftrace_return+0xa1/0xf0
> [   12.834724]  ? ftrace_graph_caller+0x6b/0xa0
> [   12.835269]  ? acpi_label_write+0x390/0x390 [nfit]
> [   12.835909]  ? nvdimm_probe+0x259/0x420 [libnvdimm]
> [   12.836558]  ? nvdimm_probe+0x259/0x420 [libnvdimm]
> [   12.837179]  nvdimm_probe+0x259/0x420 [libnvdimm]
> [   12.837802]  nvdimm_bus_probe+0x110/0x6b0 [libnvdimm]
> [   12.838470]  really_probe+0x212/0x9a0
> [   12.838954]  driver_probe_device+0x1cd/0x300
> [   12.839511]  ? driver_probe_device+0x5/0x300
> [   12.840063]  device_driver_attach+0xe7/0x120
> [   12.840623]  bind_store+0x18d/0x230
> [   12.841075]  kernfs_fop_write+0x200/0x420
> [   12.841606]  vfs_write+0x154/0x450
> [   12.842047]  ksys_write+0xf9/0x1d0
> [   12.842497]  ? __ia32_sys_read+0xb0/0xb0
> [   12.843010]  do_syscall_64+0x95/0x4a0
> [   12.843495]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [   12.844140] RIP: 0033:0x7f5b235d3563
> [   12.844607] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> [   12.846877] RSP: 002b:00007fff1c3bc578 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   12.847822] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f5b235d3563
> [   12.848717] RDX: 0000000000000006 RSI: 000055f9576710d0 RDI: 0000000000000001
> [   12.849594] RBP: 000055f9576710d0 R08: 000000000000000a R09: 0000000000000000
> [   12.850470] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
> [   12.851333] R13: 00007f5b236a3500 R14: 0000000000000006 R15: 00007f5b236a3700
> [   12.852247]
> [   12.852466] Allocated by task 225:
> [   12.852893]  save_stack+0x1b/0x40
> [   12.853310]  __kasan_kmalloc.constprop.0+0xc2/0xd0
> [   12.853918]  kmem_cache_alloc_node+0xef/0x270
> [   12.854475]  copy_process+0x485/0x6130
> [   12.854945]  _do_fork+0xf1/0xb40
> [   12.855353]  __do_sys_clone+0xc3/0x100
> [   12.855843]  do_syscall_64+0x95/0x4a0
> [   12.856302]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [   12.856939]
> [   12.857140] Freed by task 0:
> [   12.857522]  save_stack+0x1b/0x40
> [   12.857940]  __kasan_slab_free+0x12c/0x170
> [   12.858464]  kmem_cache_free+0xb0/0x330
> [   12.858945]  rcu_core+0x55f/0x19f0
> [   12.859385]  __do_softirq+0x228/0x944
> [   12.859869]
> [   12.860075] The buggy address belongs to the object at ffff888065c26200
> [   12.860075]  which belongs to the cache task_struct of size 6016
> [   12.861638] The buggy address is located 56 bytes inside of
> [   12.861638]  6016-byte region [ffff888065c26200, ffff888065c27980)
> [   12.863084] The buggy address belongs to the page:
> [   12.863702] page:ffffea0001970800 refcount:1 mapcount:0 mapping:0000000021ee3712 index:0x0 head:ffffea0001970800 order:3 compound_mapcount:0 compound_pincount:0
> [   12.865478] flags: 0x80000000010200(slab|head)
> [   12.866039] raw: 0080000000010200 0000000000000000 0000000100000001 ffff888066c0f980
> [   12.867010] raw: 0000000000000000 0000000080050005 00000001ffffffff 0000000000000000
> [   12.867986] page dumped because: kasan: bad access detected
> [   12.868696]
> [   12.868900] Memory state around the buggy address:
> [   12.869514]  ffff888065c26100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   12.870414]  ffff888065c26180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   12.871318] >ffff888065c26200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   12.872238]                                         ^
> [   12.872870]  ffff888065c26280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   12.873754]  ffff888065c26300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   12.874640]
> ==================================================================
> 
> This can be prevented by setting the driver data after initialisation is
> complete.
> 
> Fixes: 4d88a97aa9e8 ("libnvdimm, nvdimm: dimm driver and base libnvdimm device-driver infrastructure")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Coly Li <colyli@suse.com>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
> 
> V2:
> + Reviewed by Coly and removed unecessary lock
> 
>  drivers/nvdimm/dimm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
> index 7d4ddc4d9322..3d3988e1d9a0 100644
> --- a/drivers/nvdimm/dimm.c
> +++ b/drivers/nvdimm/dimm.c
> @@ -43,7 +43,6 @@ static int nvdimm_probe(struct device *dev)
>  	if (!ndd)
>  		return -ENOMEM;
>  
> -	dev_set_drvdata(dev, ndd);
>  	ndd->dpa.name = dev_name(dev);
>  	ndd->ns_current = -1;
>  	ndd->ns_next = -1;
> @@ -106,6 +105,8 @@ static int nvdimm_probe(struct device *dev)
>  	if (rc)
>  		goto err;
>  
> +	dev_set_drvdata(dev, ndd);
> +
>  	return 0;
>  
>   err:
> -- 
> 2.26.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

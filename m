Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CBD23E2FC
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 22:16:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E46B12B4133C;
	Thu,  6 Aug 2020 13:16:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7906012AE3231
	for <linux-nvdimm@lists.01.org>; Thu,  6 Aug 2020 13:16:08 -0700 (PDT)
IronPort-SDR: aHutCA9ZP2ErG1e8EOqkA9MFfXTI3ei5wwS3B0/BnLds33y+7ZzPhlbFHr9alBjrH0GzI9Pwzs
 mE+En8Im7WFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="150373827"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800";
   d="scan'208";a="150373827"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 13:16:03 -0700
IronPort-SDR: 934THzK4hBYWjY3UHdW0T8pK7rKBr4Yd8c1yf3mST6KJmH0a94XMGBosd3B90jomjD2WTSfLnv
 yhVu9sfQJqhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800";
   d="scan'208";a="275180110"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 06 Aug 2020 13:16:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Aug 2020 13:16:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Aug 2020 13:16:02 -0700
Received: from orsmsx612.amr.corp.intel.com ([10.22.229.25]) by
 ORSMSX612.amr.corp.intel.com ([10.22.229.25]) with mapi id 15.01.1713.004;
 Thu, 6 Aug 2020 13:16:02 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>, "willy@infradead.org"
	<willy@infradead.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Remove nrexceptional tracking
Thread-Topic: [PATCH 0/4] Remove nrexceptional tracking
Thread-Index: AQHWanrcgiyE+gZ1T06GDixOiuOZv6kr8b+AgAALYAA=
Date: Thu, 6 Aug 2020 20:16:02 +0000
Message-ID: <ee26fdf05127b7aea69db9d025d6ba5e677479bb.camel@intel.com>
References: <20200804161755.10100-1-willy@infradead.org>
	 <898e058f12c7340703804ed9d05df5ead9ecb50d.camel@intel.com>
In-Reply-To: <898e058f12c7340703804ed9d05df5ead9ecb50d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.254.22.71]
Content-ID: <D3ADC84205E77545B8CCB528A1E2B768@intel.com>
MIME-Version: 1.0
Message-ID-Hash: P3LGP2AMA445HR2BI6EB63WWFK4MV73I
X-Message-ID-Hash: P3LGP2AMA445HR2BI6EB63WWFK4MV73I
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P3LGP2AMA445HR2BI6EB63WWFK4MV73I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-08-06 at 19:44 +0000, Verma, Vishal L wrote:
> > 
> > I'm running xfstests on this patchset right now.  If one of the DAX
> > people could try it out, that'd be fantastic.
> > 
> > Matthew Wilcox (Oracle) (4):
> >   mm: Introduce and use page_cache_empty
> >   mm: Stop accounting shadow entries
> >   dax: Account DAX entries as nrpages
> >   mm: Remove nrexceptional from inode
> 
> Hi Matthew,
> 
> I applied these on top of 5.8 and ran them through the nvdimm unit test
> suite, and saw some test failures. The first failing test signature is:
> 
>   + umount test_dax_mnt
>   ./dax-ext4.sh: line 62: 15749 Segmentation fault      umount $MNT
>   FAIL dax-ext4.sh (exit status: 139)
> 
> The line is: https://github.com/pmem/ndctl/blob/master/test/dax.sh#L79
> And the failing umount happens right after 'run_test', which calls this:
> https://github.com/pmem/ndctl/blob/master/test/dax-pmd.c
> 
> 
And here is the associated kernel splat:

[   89.570142] EXT4-fs (pmem4): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[   89.573407] EXT4-fs (pmem4): mounted filesystem with ordered data mode. Opts: dax
[   90.450644] Injecting memory failure for pfn 0x148900 at process virtual address 0x7f2ec9b00000
[   90.452421] Memory failure: 0x148900: Sending SIGBUS to dax-pmd:16886 due to hardware memory corruption
[   90.454067] Memory failure: 0x148900: recovery action for dax page: Recovered
[   91.656624] ------------[ cut here ]------------
[   91.657822] kernel BUG at fs/inode.c:530!
[   91.658850] invalid opcode: 0000 [#1] SMP PTI
[   91.659883] CPU: 4 PID: 16891 Comm: umount Tainted: G           O      5.8.0-00004-g6161e2d6ac48 #38
[   91.661861] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[   91.664920] RIP: 0010:clear_inode+0x78/0x90
[   91.665934] Code: 00 a8 20 74 2b a8 40 75 29 48 8b 93 f0 01 00 00 48 8d 83 f0 01 00 00 48 39 c2 75 18 48 c7 83 e0 00 00 00 60 00 00 00 5b 5d c3 <0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00
[   91.669979] RSP: 0018:ffffc9000212fd98 EFLAGS: 00010002
[   91.671151] RAX: 0000000000000004 RBX: ffff88810e33d470 RCX: 8c6318c6318c6319
[   91.672689] RDX: ffff888110b48040 RSI: 0000000000000004 RDI: 0000000000000046
[   91.674208] RBP: ffff88810e33d6b8 R08: 0000000000000000 R09: 0000000000000001
[   91.675760] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88810e33d6b0
[   91.677332] R13: ffff88811014c828 R14: ffff88811014c9c0 R15: ffff88810e3398c0
[   91.678940] FS:  00007f86a7e74c80(0000) GS:ffff888117c00000(0000) knlGS:0000000000000000
[   91.680745] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.682001] CR2: 000055bcfb4c3008 CR3: 0000000110b7c000 CR4: 00000000000006e0
[   91.683581] Call Trace:
[   91.684268]  ext4_clear_inode+0x16/0x80
[   91.685298]  ext4_evict_inode+0x5f/0x610
[   91.686245]  evict+0xcf/0x1f0
[   91.687017]  dispose_list+0x48/0x70
[   91.687937]  evict_inodes+0x152/0x190
[   91.688918]  generic_shutdown_super+0x37/0x100
[   91.689880]  kill_block_super+0x21/0x50
[   91.690784]  deactivate_locked_super+0x36/0xa0
[   91.691790]  cleanup_mnt+0x12d/0x190
[   91.692658]  task_work_run+0x5c/0xa0
[   91.694739]  __prepare_exit_to_usermode+0x1b6/0x1c0
[   91.695806]  do_syscall_64+0x5e/0xb0
[   91.696656]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   91.697798] RIP: 0033:0x7f86a80c694b
[   91.698650] Code: 15 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1d 15 0c 00 f7 d8 64 89 01 48
[   91.702545] RSP: 002b:00007ffd49a8cb98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   91.704204] RAX: 0000000000000000 RBX: 00007f86a81ee204 RCX: 00007f86a80c694b
[   91.705732] RDX: ffffffffffffff78 RSI: 0000000000000000 RDI: 000055bcfb4bf2a0
[   91.707207] RBP: 000055bcfb4bafa0 R08: 0000000000000000 R09: 00007f86a8188a40
[   91.708809] R10: 000055bcfb4c1550 R11: 0000000000000246 R12: 0000000000000000
[   91.710040] R13: 000055bcfb4bf2a0 R14: 000055bcfb4bb0b0 R15: 000055bcfb4bb1d0
[   91.711193] Modules linked in: nd_e820(O) nd_blk(O) nfit(O) kmem nd_pmem(O) nd_btt(O) dax_pmem(O) dax_pmem_core(O) libnvdimm(O) device_dax(O) nfit_test_iomap(O) [last unloaded: nfit_test_iomap]
[   91.714154] ---[ end trace 016cb116e8654993 ]---
[   91.715011] RIP: 0010:clear_inode+0x78/0x90
[   91.715803] Code: 00 a8 20 74 2b a8 40 75 29 48 8b 93 f0 01 00 00 48 8d 83 f0 01 00 00 48 39 c2 75 18 48 c7 83 e0 00 00 00 60 00 00 00 5b 5d c3 <0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00
[   91.718950] RSP: 0018:ffffc9000212fd98 EFLAGS: 00010002
[   91.719976] RAX: 0000000000000004 RBX: ffff88810e33d470 RCX: 8c6318c6318c6319
[   91.721187] RDX: ffff888110b48040 RSI: 0000000000000004 RDI: 0000000000000046
[   91.722473] RBP: ffff88810e33d6b8 R08: 0000000000000000 R09: 0000000000000001
[   91.723633] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88810e33d6b0
[   91.724838] R13: ffff88811014c828 R14: ffff88811014c9c0 R15: ffff88810e3398c0
[   91.726109] FS:  00007f86a7e74c80(0000) GS:ffff888117c00000(0000) knlGS:0000000000000000
[   91.727575] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.728596] CR2: 000055bcfb4c3008 CR3: 0000000110b7c000 CR4: 00000000000006e0
[   91.729794] note: umount[16891] exited with preempt_count 1
[   91.730746] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
[   91.732304] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 16891, name: umount
[   91.733764] INFO: lockdep is turned off.
[   91.734476] irq event stamp: 6192
[   91.735067] hardirqs last  enabled at (6191): [<ffffffff81c7a974>] _raw_spin_unlock_irq+0x24/0x40
[   91.736641] hardirqs last disabled at (6192): [<ffffffff81c7ab27>] _raw_spin_lock_irq+0x17/0x80
[   91.738141] softirqs last  enabled at (6120): [<ffffffff8134b3b8>] bdi_split_work_to_wbs+0x248/0x580
[   91.739752] softirqs last disabled at (6116): [<ffffffff81347a5d>] wb_queue_work+0x4d/0x180
[   91.741297] CPU: 4 PID: 16891 Comm: umount Tainted: G      D    O      5.8.0-00004-g6161e2d6ac48 #38
[   91.742940] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[   91.744887] Call Trace:
[   91.745401]  dump_stack+0x92/0xc8
[   91.745987]  ___might_sleep.cold+0xb6/0xc6
[   91.746716]  exit_signals+0x1c/0x2d0
[   91.747355]  do_exit+0xc0/0xba0
[   91.747942]  ? __prepare_exit_to_usermode+0x1b6/0x1c0
[   91.748821]  rewind_stack_do_exit+0x17/0x20
[   91.749619] RIP: 0033:0x7f86a80c694b
[   91.750330] Code: 15 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1d 15 0c 00 f7 d8 64 89 01 48
[   91.753544] RSP: 002b:00007ffd49a8cb98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   91.754902] RAX: 0000000000000000 RBX: 00007f86a81ee204 RCX: 00007f86a80c694b
[   91.756176] RDX: ffffffffffffff78 RSI: 0000000000000000 RDI: 000055bcfb4bf2a0
[   91.757746] RBP: 000055bcfb4bafa0 R08: 0000000000000000 R09: 00007f86a8188a40
[   91.759034] R10: 000055bcfb4c1550 R11: 0000000000000246 R12: 0000000000000000
[   91.760166] R13: 000055bcfb4bf2a0 R14: 000055bcfb4bb0b0 R15: 000055bcfb4bb1d0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

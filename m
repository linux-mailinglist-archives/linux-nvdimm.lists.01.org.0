Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEDF3312
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 16:30:01 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73597100EA630;
	Thu,  7 Nov 2019 07:32:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com; envelope-from=wkyo.choe@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 70DBB100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 07:32:23 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c184so2896929pfb.0
        for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pHqogWuUgF8mOXbzu1svmuSP3gmZ+4405ycS4QnMtPw=;
        b=UsUV5Z8mmM4pi+YKlS/cguX1ifx+UWngjLwimWo7AFEOUGBOEE+R6EPmbcYW5s1wM5
         I4vU44+qRk3zgHa2gVqTLmX+vfve6EBhkV9W83I4nX+va///rao0j96ej5psKjLaHs85
         cK+O3uY+16W4SyoZiBQo6XWhoD8+rPCV6FUw4gKJiDIWsq8gIcNrX/aiD4iiMIK0UBDG
         zUlCMMM2ut9r9AiT712cyjUXNBELWGli7MzwZVrfnmYi9graM2k3LqNSzVOiazgA0jHY
         VG3MR1OfH59rY5FQIHtvOiqbi1Fj/D2+cXVWJw2vvnfi91BQcTd2F5RTLhC9c29UdXvZ
         7xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pHqogWuUgF8mOXbzu1svmuSP3gmZ+4405ycS4QnMtPw=;
        b=mbACJCx8QRCGy8uWpAGgrd77lbbnJNzXTpM4FKLDjnudA1vTXKz6vyxSV753VFnA4Z
         J4bfSwEgjqkMdePUu2lXZa9Rd0E1Up7ev5Qz5XYpI+3FoL8YugI6LJnZN2IjHGGzqqSR
         OPEOqHyriEvym1lCh+jdsIZYML4NrBztbKhyuiqhUI9BX9gmh4ZSvxw3AdhJ/iE0hCXW
         8tNnmM+MfOmvUUF2i5T4cHvtREFGbZJdEZ6aNqyIzu8YJF5QkZ+vSqR/Uz4U1LWndogu
         l5NKH91G2f7pl48tYauTHuo8CKf68VYpf0U0vAsJP/55wU+FucJH5apGBz2bI15SXWZq
         oX5w==
X-Gm-Message-State: APjAAAVifquVt2NFyZu/A94lFluHk50xGh7MzEo+H6jzlCvqdAWcB3wc
	clXWIbxnsZpDKvgjA5cnvh+cxF9g
X-Google-Smtp-Source: APXvYqz7vZW4zcDcfdehyu0/5MqnwMOEGiIFghn/DCcNMcgTp4MnGoCm8HM5SfuI/DnFNoxdgcQhuA==
X-Received: by 2002:a17:902:9a8d:: with SMTP id w13mr4347641plp.330.1573140596729;
        Thu, 07 Nov 2019 07:29:56 -0800 (PST)
Received: from swarm07 ([210.107.197.31])
        by smtp.gmail.com with ESMTPSA id j6sm2679279pfa.124.2019.11.07.07.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 07:29:55 -0800 (PST)
Date: Fri, 8 Nov 2019 00:29:52 +0900
From: Won-Kyo Choe <wkyo.choe@gmail.com>
To: linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com
Subject: [QUESTION] Error on initializing dax by using different struct page
 size
Message-ID: <20191107152952.GA2053@swarm07>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Message-ID-Hash: CUUKANWW4KTIXP7M5QTL7565DKB7K4PT
X-Message-ID-Hash: CUUKANWW4KTIXP7M5QTL7565DKB7K4PT
X-MailFrom: wkyo.choe@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CUUKANWW4KTIXP7M5QTL7565DKB7K4PT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, there. I'm using Opatne DC memory to use it a volatile memory. Recently,
I found that if sizeof(struct page) is above 64 bytes (e.g. 128 byes),
`device_dax` cannot be initialized when system boots. I am aware that
for some reason there is a function, `__mm_zero_struct_page`, which limits
the size of struct page when it exceeds 80 bytes. However, due to the
research purpose, I do not use that constraint and I'm quite certain
that using different page size is usable in main memory. So, I'm
wondering why this is not possible in persistent memory and which
patches are related to this problem.

I will attach the system log for clarification. The test is run in
linux-5.3.9 and linuxt-5.3-rc5

[   23.493230] WARNING: CPU: 23 PID: 890 at arch/x86/mm/init_64.c:852 add_pages+0x5d/0x70
[   23.493231] Modules linked in: device_dax(+) nd_pmem dax_pmem nd_btt dax_pmem_core skx_edac(+) rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache ipmi_ssif x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm nls_iso8859_1 irqbypass intel_cstate intel_rapl_perf input_leds joydev ioatdma mei_me lpc_ich mei dca ipmi_si ipmi_devintf ipmi_msghandler nfit acpi_power_meter acpi_pad mac_hid sch
_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core sunrpc iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid hid ast i2c_algo_bit drm_vram_helper ttm drm_kms_helper crct10dif_pclmul crc32_pclmul ghash_clmulni_intel syscopyarea sysfillrect aesni_intel sysimgblt fb_sys_fops aes_x86_64 crypto_simd drm i40e nvme cryptd ptp glue_helper nvme_core ahci pps_core libahci wmi
[   23.493271] CPU: 23 PID: 890 Comm: systemd-udevd Not tainted 5.3.9 #1
[   23.493272] Hardware name: Supermicro Super Server/X11DPH-T, BIOS 3.1 05/22/2019
[   23.493275] RIP: 0010:add_pages+0x5d/0x70
[   23.493277] Code: 2e c0 01 76 20 48 89 15 69 2e c0 01 48 89 15 72 2e c0 01 48 c1 e2 0c 48 03 15 8f 5a 36 01 48 89 15 18 09 c0 01 5b 41 5c 5d c3 <0f> 0b eb ba 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
[   23.493278] RSP: 0018:ffff9d75c7d73a18 EFLAGS: 00010282
[   23.493280] RAX: 00000000fffffff4 RBX: 0000000000880000 RCX: 0000000000000000
[   23.493281] RDX: 0000000000000020 RSI: 0000000000000020 RDI: 0000000000000282
[   23.493282] RBP: ffff9d75c7d73a28 R08: ffff91c7c0200000 R09: 0000000000000000
[   23.493283] R10: ffff9d75c7d73830 R11: 0000000000000000 R12: 0000000003f00000
[   23.493283] R13: 0000000000000000 R14: ffff9d75c7d73a78 R15: 000000000000003e
[   23.493285] FS:  00007fb03c99b680(0000) GS:ffff920ebfbc0000(0000) knlGS:0000000000000000
[   23.493286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.493287] CR2: 000000c420be7010 CR3: 000000083fd82002 CR4: 00000000007606e0
[   23.493288] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.493289] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   23.493289] PKRU: 55555554
[   23.493290] Call Trace:
[   23.493295]  arch_add_memory+0x41/0x50
[   23.493300]  devm_memremap_pages+0x460/0x600
[   23.493304]  dev_dax_probe+0x6a/0x180 [device_dax]
[   23.493307]  really_probe+0xf5/0x3e0
[   23.493309]  driver_probe_device+0x11b/0x130
[   23.493311]  device_driver_attach+0x58/0x60
[   23.493312]  __driver_attach+0xa3/0x140
[   23.493314]  ? device_driver_attach+0x60/0x60
[   23.493315]  ? device_driver_attach+0x60/0x60
[   23.493320]  bus_for_each_dev+0x74/0xb0
[   23.493322]  ? kmem_cache_alloc_trace+0x1ff/0x210
[   23.493324]  driver_attach+0x1e/0x20
[   23.493325]  bus_add_driver+0x147/0x220
[   23.493327]  ? 0xffffffffc0e36000
[   23.493329]  driver_register+0x60/0x100
[   23.493330]  ? 0xffffffffc0e36000
[   23.493333]  __dax_driver_register+0x6c/0xa0
[   23.493336]  dax_init+0x23/0x1000 [device_dax]
[   23.493343]  do_one_initcall+0x4a/0x1fa
[   23.493347]  ? _cond_resched+0x19/0x40
[   23.493349]  ? kmem_cache_alloc_trace+0x3f/0x210
[   23.493352]  do_init_module+0x5f/0x227
[   23.493360]  load_module+0x244f/0x2c10
[   23.493365]  __do_sys_finit_module+0xfc/0x120
[   23.493367]  ? __do_sys_finit_module+0xfc/0x120
[   23.493370]  __x64_sys_finit_module+0x1a/0x20
[   23.493372]  do_syscall_64+0x5a/0x130
[   23.493377]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   23.493378] RIP: 0033:0x7fb03c4b1839
[   23.493380] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[   23.493381] RSP: 002b:00007ffe4422f458 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   23.493382] RAX: ffffffffffffffda RBX: 000055fcfc92b130 RCX: 00007fb03c4b1839
[   23.493383] RDX: 0000000000000000 RSI: 00007fb03c190145 RDI: 0000000000000007
[   23.493384] RBP: 00007fb03c190145 R08: 0000000000000000 R09: 00007ffe4422f570
[   23.493385] R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
[   23.493386] R13: 000055fcfc91a830 R14: 0000000000020000 R15: 000055fcfc92b130
[   23.493388] ---[ end trace 0a14fa412f3d5c6d ]---
[   23.542919] device_dax: probe of dax0.0 failed with error -12

...

[   23.564220] [ffffdbb6a7680000-ffffdbb6a77fffff] potential offnode page_structs
[   23.564230] [ffffdbb6a7d80000-ffffdbb6a7dfffff] potential offnode page_structs
[   23.564235] [ffffdbb6a8100000-ffffdbb6a81fffff] potential offnode page_structs
[   23.564240] [ffffdbb6a8480000-ffffdbb6a85fffff] potential offnode page_structs
[   23.598937] device_dax: probe of dax1.0 failed with error -12

Thanks,
Won-Kyo Choe
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

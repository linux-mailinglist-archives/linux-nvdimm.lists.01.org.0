Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07698370502
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 May 2021 04:28:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8766D100EB325;
	Fri, 30 Apr 2021 19:28:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=yizhan@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C7DF4100EB835
	for <linux-nvdimm@lists.01.org>; Fri, 30 Apr 2021 19:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619836079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=wm5oZozwcLWb/RDZoLUeSbx+MRjXOf9SZvHTGNW8z8A=;
	b=BHPDVp4KDe+t2wSpC42K4ddFSN+S8BiaN26y2di5cdCWDr3IX1auXzIo30YWLWs8IUemML
	4EBu//JrUVlex7Nh+MuE7a6ved1MECyBGm0zLdTb3pmIbjHNXMZLVcK/X9IzAkIpzDK01F
	psqoPfKO8drXHpCIgZx8X4fi487898k=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-2I0QRhNmNlqMxqm6iZIIVQ-1; Fri, 30 Apr 2021 22:27:56 -0400
X-MC-Unique: 2I0QRhNmNlqMxqm6iZIIVQ-1
Received: by mail-yb1-f197.google.com with SMTP id z8-20020a2566480000b02904e0f6f67f42so429303ybm.15
        for <linux-nvdimm@lists.01.org>; Fri, 30 Apr 2021 19:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wm5oZozwcLWb/RDZoLUeSbx+MRjXOf9SZvHTGNW8z8A=;
        b=tt3b1xwmUBhBkzbprQ+v3Ag9rQ7dtLB3VbL8wKjtHnnZnFLHZQx5pmBzMoOSZMVIJJ
         mban+X7MS9eaCmTOlPi4KtblbfXYnZAz9iXuLTdILgIpR6MJMTzj7slOlQZqDLMTazmx
         pj5pflqOs0pEl3Ha0y0WpD9RijeVvcjLmmm6Pw+qrgSZ6X8rLG2nhPPRnqiRvays/RsA
         HQtakaemw+0DpbUaJWPVdnaS24uePakrj8gYTUf29rkKkdsRQZPXiLx9kwKD/BtfYgoV
         i+ni6nxgh95FXmLbp2v9KDrgKquaEihkSFLTVGrx9OdFWugJDfPonOA42D9M2eMS4JwX
         3szA==
X-Gm-Message-State: AOAM532oQTPfZRjp4WK2oC3lN0JGeAV3Fcz3r3ipTJDp6cvfuVzgYu+m
	TVL8TbhoK95wHtLYdnZheImLhmTkgJ5t04bH20iBP9UmaI7hSf/wGXDAQTSXZ45y+RvtdmXl507
	2notDeb0neWausExHzWBM5aoZTv/La2rOaZS7
X-Received: by 2002:a25:ba92:: with SMTP id s18mr12493328ybg.438.1619836076127;
        Fri, 30 Apr 2021 19:27:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBigO/7yzfEgtwnBl8iKcxO1eqpyCPhcdRLpfpZwv1GPZU+ahe5B/kBYxbg67GJ3c4whdA+gnDndvfohVQg3M=
X-Received: by 2002:a25:ba92:: with SMTP id s18mr12493293ybg.438.1619836075720;
 Fri, 30 Apr 2021 19:27:55 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 1 May 2021 10:27:44 +0800
Message-ID: <CAHj4cs9s25EqRhL6_D5Rg_7j14N5UVODJ0ps4=4n7sZ6zE5U3w@mail.gmail.com>
Subject: [bug report] system panic at nfit_get_smbios_id+0x6e/0xf0 [nfit]
 during boot
To: linux-nvdimm@lists.01.org
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: IKX6OASEN7VEMOJQ7XUR5624COED27OF
X-Message-ID-Hash: IKX6OASEN7VEMOJQ7XUR5624COED27OF
X-MailFrom: yizhan@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IKX6OASEN7VEMOJQ7XUR5624COED27OF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

With the latest Linux tree, my DCPMM server boot failed with the
bellow panic log, pls help check it, let me know if you need any test
for it.

[   15.882889] BUG: unable to handle page fault for address: ffffffffffffffa8
[   15.889761] #PF: supervisor read access in kernel mode
[   15.894900] #PF: error_code(0x0000) - not-present page
[   15.900039] PGD fc2813067 P4D fc2813067 PUD fc2815067 PMD 0
[   15.905697] Oops: 0000 [#1] SMP NOPTI
[   15.909364] CPU: 22 PID: 1024 Comm: systemd-udevd Tainted: G
  I       5.12.0+ #1
[   15.917448] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.10.0 11/12/2020
[   15.925013] RIP: 0010:nfit_get_smbios_id+0x6e/0xf0 [nfit]
[   15.930413] Code: b1 f3 49 8b 84 24 c0 00 00 00 49 8d 8c 24 c0 00
00 00 48 8d 50 a0 48 39 c1 75 0f eb 49 48 8b 42 60 48 8d 50 a0 48 39
c1 74 3c <48> 8b 42 08 48 85 c0 75 04 48 8b 42 10 39 58 04 75 e1 0f b7
50 2c
[   15.949160] RSP: 0018:ffff9c28c284bb10 EFLAGS: 00010286
[   15.954383] RAX: 0000000000000000 RBX: 0000000000000020 RCX: ffff897b832d8cd8
[   15.961507] RDX: ffffffffffffffa0 RSI: ffff9c28c284bb46 RDI: ffff897b832d8c98
[   15.968631] RBP: ffff9c28c284bb46 R08: ffffffffc08c982c R09: ffff9c28c284bb6c
[   15.975763] R10: 0000000000000058 R11: ffff897b4bfb0aee R12: ffff897b832d8c18
[   15.982888] R13: ffff897b832d8c98 R14: ffff897b4bfb0038 R15: ffff897b4bfb1800
[   15.990021] FS:  00007fa1960ab180(0000) GS:ffff898a7ff80000(0000)
knlGS:0000000000000000
[   15.998107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.003854] CR2: ffffffffffffffa8 CR3: 00000001086ac004 CR4: 00000000007706e0
[   16.010984] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.018119] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.025249] PKRU: 55555554
[   16.027954] Call Trace:
[   16.030407]  skx_get_nvdimm_info+0x56/0x130 [skx_edac]
[   16.035546]  skx_get_dimm_config+0x1f5/0x213 [skx_edac]
[   16.040770]  skx_register_mci+0x132/0x1c0 [skx_edac]
[   16.045737]  ? skx_show_retry_rd_err_log+0x190/0x190 [skx_edac]
[   16.051657]  skx_init+0x344/0xe87 [skx_edac]
[   16.055930]  ? skx_adxl_get+0x179/0x179 [skx_edac]
[   16.060722]  do_one_initcall+0x41/0x1d0
[   16.064560]  ? __cond_resched+0x15/0x30
[   16.068399]  ? kmem_cache_alloc_trace+0x3d/0x420
[   16.073019]  do_init_module+0x5a/0x240
[   16.076771]  load_module+0x1b5f/0x1c40
[   16.080525]  ? __kernel_read+0x14a/0x2c0
[   16.084450]  ? __do_sys_finit_module+0xad/0x110
[   16.088982]  __do_sys_finit_module+0xad/0x110
[   16.093343]  do_syscall_64+0x39/0x80
[   16.096921]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   16.101975] RIP: 0033:0x7fa194c8852d
[   16.105554] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 79 2c 00 f7 d8 64 89
01 48
[   16.124298] RSP: 002b:00007fff5daec098 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   16.131864] RAX: ffffffffffffffda RBX: 000055ccd2937dc0 RCX: 00007fa194c8852d
[   16.138996] RDX: 0000000000000000 RSI: 00007fa1957fc86d RDI: 000000000000001c
[   16.146129] RBP: 00007fa1957fc86d R08: 0000000000000000 R09: 00007fff5daec1c0
[   16.153260] R10: 000000000000001c R11: 0000000000000246 R12: 0000000000000000
[   16.160392] R13: 000055ccd2838c30 R14: 0000000000020000 R15: 0000000000000000
[   16.167527] Modules linked in: skx_edac(+) x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel ipmi_ssif mgag200 i2c_algo_bit kvm
drm_kms_helper iTCO_wdt iTCO_vendor_support syscopyarea sysfillrect
sysimgblt fb_sys_fops drm irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel acpi_ipmi rapl ipmi_si mei_me intel_cstate
intel_uncore mei i2c_i801 pcspkr wmi_bmof ipmi_devintf
intel_pch_thermal i2c_smbus lpc_ich ipmi_msghandler acpi_power_meter
ip_tables xfs libcrc32c sd_mod t10_pi sg ahci libahci libata tg3
megaraid_sas crc32c_intel nfit wmi libnvdimm dm_mirror dm_region_hash
dm_log dm_mod
[   16.220349] CR2: ffffffffffffffa8
[   16.223674] ---[ end trace 3e1fbf6e28c10643 ]---
[   16.231424] RIP: 0010:nfit_get_smbios_id+0x6e/0xf0 [nfit]
[   16.236822] Code: b1 f3 49 8b 84 24 c0 00 00 00 49 8d 8c 24 c0 00
00 00 48 8d 50 a0 48 39 c1 75 0f eb 49 48 8b 42 60 48 8d 50 a0 48 39
c1 74 3c <48> 8b 42 08 48 85 c0 75 04 48 8b 42 10 39 58 04 75 e1 0f b7
50 2c
[   16.255568] RSP: 0018:ffff9c28c284bb10 EFLAGS: 00010286
[   16.260794] RAX: 0000000000000000 RBX: 0000000000000020 RCX: ffff897b832d8cd8
[   16.267925] RDX: ffffffffffffffa0 RSI: ffff9c28c284bb46 RDI: ffff897b832d8c98
[   16.275057] RBP: ffff9c28c284bb46 R08: ffffffffc08c982c R09: ffff9c28c284bb6c
[   16.282189] R10: 0000000000000058 R11: ffff897b4bfb0aee R12: ffff897b832d8c18
[   16.289313] R13: ffff897b832d8c98 R14: ffff897b4bfb0038 R15: ffff897b4bfb1800
[   16.296440] FS:  00007fa1960ab180(0000) GS:ffff898a7ff80000(0000)
knlGS:0000000000000000
[   16.304525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.310271] CR2: ffffffffffffffa8 CR3: 00000001086ac004 CR4: 00000000007706e0
[   16.317401] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.324526] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.331660] PKRU: 55555554
[   16.334370] Kernel panic - not syncing: Fatal exception
[   16.755349] Kernel Offset: 0x32600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   16.769170] ---[ end Kernel panic - not syncing: Fatal exception ]---
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

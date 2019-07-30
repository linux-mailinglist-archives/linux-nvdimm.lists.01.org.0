Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC617A126
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jul 2019 08:16:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C360621A070B6;
	Mon, 29 Jul 2019 23:19:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=jencce.kernel@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4321B21A07094
 for <linux-nvdimm@lists.01.org>; Mon, 29 Jul 2019 23:19:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f5so20663609pgu.5
 for <linux-nvdimm@lists.01.org>; Mon, 29 Jul 2019 23:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=sSoUk3kooJnUBYyOI6TNvGzOTWP0rgOyGLq2HINd9W0=;
 b=AvjhsZSOeQHNWXvAZq3yDbejcBxJsOmW1k9+LJSiyh+7Vm+YzKrwYr8WLL9w+sTm5V
 kZA05taJG8EOcTThf2/gJPIitVdO1ZcZke5HZfOllZYE827n+xiUKS12faJWhGNej1O2
 b5ZSSuX+bRwT+2Mw+k2LWq+0PB/2HZd2qwVnWGnXGBSUaBBYOUyEKVooE6qPrdFF23ud
 zWNJd1vIw/V47R2FhEaGszrVhAvwTea2HUlfvTEkJHDIZQ0tJfwro1gSNmYDUOmuD6kC
 aRPjzeLO2hz+VW4rSRa/Ock9UMNbmVa6DK9gRxYCjwU8HwOJnPfaAl5YOyOdKlxJW9wj
 zBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=sSoUk3kooJnUBYyOI6TNvGzOTWP0rgOyGLq2HINd9W0=;
 b=bhNgInY6wO/Z1vlOOm+P3njiRlzk2eLw+zeeDidvop8n/9O875eZodtiPgdlvxdzeH
 JWa7hW1qpoLvESaEtstnxdYQ5lTK40K0QJDf9FzOGGG0QqgYmPQ4U8K6AQVwcQ4Et1+J
 AV65+ixxT8JWMEoHCSfCpNO+XEs95uR3SmPErMZLrGpCA9B+2OHtTXL7dtTLnnqqkjca
 wPHNin+ECxoUvhKskXCR9avfpynwRd8/TVpc1BbXn4vEcad+7co/NTtbjRkO6h9uOMSP
 rpfFrOv++7PFfzoNzcAKwDVbaoXPeMlRegv8wf2unJ/RGF2BYNebFB/6H6Ok25nuVuL/
 TztQ==
X-Gm-Message-State: APjAAAWjSXdSAZ/z+HWdrme5JFRlicpaW2bkga0hQtiVuNc5N32p4DxN
 mrqwIXYp2bEDt6k3Vqadc9ROjKHr
X-Google-Smtp-Source: APXvYqzEAqZyXvdivhq+aBm8Yzi2GXPkdoyL0+RbXfJTmFWZIySgaywBnsyy8WkDdQRsGxVeKmMg3w==
X-Received: by 2002:a62:6dc2:: with SMTP id i185mr40883193pfc.40.1564467394384; 
 Mon, 29 Jul 2019 23:16:34 -0700 (PDT)
Received: from localhost ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t9sm49804692pgj.89.2019.07.29.23.16.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 23:16:33 -0700 (PDT)
Date: Tue, 30 Jul 2019 14:16:26 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
To: linux-nvdimm@lists.01.org, pagupta@redhat.com
Subject: [regression] panic at __dax_synchronous after synchronous dax enabled
Message-ID: <20190730061626.zwfottkdmab7vj3n@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, snitzer@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi,

Hit this panic when running xfstests generic/108 on pmem ramdisk.

This test is simulating partial disk error when calling fsync():
  create a lvm vg which consists of 2 disks:
    one scsi_debug disk; one other disk I specified, pmem ramdisk in this case.
  create lv in this vg and write to it, make sure writing across 2 disks;
  offline scsi_debug disk;
  write again to allocated area;
  expect fsync: IO error.

If one of the disks is pmem ramdisk, it reproduces every time on my setup,
on v5.3-rc2+.

The mount -o dax option is not required to reproduce this panic.

Bisect points to this:

	commit 2e9ee0955d3c2d3db56aa02ba6f948ba35d5e9c1
	Author: Pankaj Gupta <pagupta@redhat.com>
	Date:   Fri Jul 5 19:33:25 2019 +0530
	
	    dm: enable synchronous dax

Reverting this commit "fixes" this panic. I can send a revert patch if needed..

Thanks,
M

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 7u 5.3.0-rc2-master-2a11c76+ #155 SMP Tue Jul 30 11:29:05 CST 2019
MKFS_OPTIONS  -- -f -f -b size=4096 /dev/pmem1
MOUNT_OPTIONS -- -o dax -o context=system_u:object_r:root_t:s0 /dev/pmem1 /test1

generic/108 5s ...      [00:17:34]

[ 1984.878208] BUG: kernel NULL pointer dereference, address: 00000000000002d0
[ 1984.882546] #PF: supervisor read access in kernel mode
[ 1984.885664] #PF: error_code(0x0000) - not-present page
[ 1984.888626] PGD 0 P4D 0
[ 1984.890140] Oops: 0000 [#1] SMP PTI
[ 1984.892345] CPU: 17 PID: 3321 Comm: lvm Not tainted 5.3.0-rc2-master-2a11c76+ #155
[ 1984.896864] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[ 1984.900460] RIP: 0010:__dax_synchronous+0x5/0x20
[ 1984.903161] Code: ff ff ff c3 90 66 66 66 66 90 48 8b 87 d0 02 00 00 48 d1 e8 83 e0 01 c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 <48> 8b 87 d0 02 00 00 48 c1 e8 02 83 e0 01 c3 66 90 66 2e 0f 1f 84
[ 1984.912987] RSP: 0018:ffffad06503a7b38 EFLAGS: 00010246
[ 1984.915722] RAX: ffff9a248c7c2200 RBX: 0000000000000000 RCX: 0000000000046000
[ 1984.919417] RDX: 0000000000000800 RSI: ffff9a2493486d18 RDI: 0000000000000000
[ 1984.923182] RBP: ffff9a248c7c2200 R08: 0000000000000000 R09: 0000000000000000
[ 1984.926644] R10: 0000000000000003 R11: ffffad06503a7a28 R12: ffffad0640109040
[ 1984.930214] R13: 0000000000000000 R14: ffffffffc03d3ed0 R15: 0000000000000000
[ 1984.933648] FS:  00007f4dbf87d880(0000) GS:ffff9a2498640000(0000) knlGS:0000000000000000
[ 1984.937494] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1984.940273] CR2: 00000000000002d0 CR3: 000000046be80000 CR4: 00000000000006e0
[ 1984.943682] Call Trace:
[ 1984.945007]  device_synchronous+0xe/0x20 [dm_mod]
[ 1984.947328]  stripe_iterate_devices+0x48/0x60 [dm_mod]
[ 1984.949947]  ? dm_set_device_limits+0x130/0x130 [dm_mod]
[ 1984.952516]  dm_table_supports_dax+0x39/0x90 [dm_mod]
[ 1984.954989]  dm_table_set_restrictions+0x248/0x5d0 [dm_mod]
[ 1984.957685]  dm_setup_md_queue+0x66/0x110 [dm_mod]
[ 1984.960280]  table_load+0x1e3/0x390 [dm_mod]
[ 1984.962491]  ? retrieve_status+0x1c0/0x1c0 [dm_mod]
[ 1984.964910]  ctl_ioctl+0x1d3/0x550 [dm_mod]
[ 1984.967006]  ? path_lookupat+0xf4/0x200
[ 1984.968890]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
[ 1984.970920]  do_vfs_ioctl+0xa9/0x630
[ 1984.972701]  ksys_ioctl+0x60/0x90
[ 1984.974335]  __x64_sys_ioctl+0x16/0x20
[ 1984.976221]  do_syscall_64+0x5b/0x1d0
[ 1984.978091]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1984.980552] RIP: 0033:0x7f4dbe49f2f7
[ 1984.982304] Code: 44 00 00 48 8b 05 79 1b 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 49 1b 2d 00 f7 d8 64 89 01 48
[ 1984.991519] RSP: 002b:00007ffd2b70d578 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1984.995203] RAX: ffffffffffffffda RBX: 00005612727d5680 RCX: 00007f4dbe49f2f7
[ 1984.998685] RDX: 000056127483c860 RSI: 00000000c138fd09 RDI: 0000000000000004
[ 1985.002145] RBP: 00007f4dbec07503 R08: 00007f4dbec08040 R09: 00007ffd2b70d4a0
[ 1985.005667] R10: 0000000000000003 R11: 0000000000000246 R12: 000056127483c860
[ 1985.009147] R13: 00007f4dbec07503 R14: 000056127481a700 R15: 00007f4dbec07503
[ 1985.012670] Modules linked in: scsi_debug sunrpc snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep crct10dif_pclmul crc32_pclmul snd_seq ghash_clmulni_intel snd_seq_device snd_pcm snd_timer aesni_intel snd dax_pmem_compat crypto_simd device_dax cryptd soundcore sg glue_helper dax_pmem_core pcspkr virtio_balloon joydev i2c_piix4 ip_tables xfs libcrc32c qxl drm_kms_helper syscopyarea sysfillrect sysimgblt sd_mod fb_sys_fops ttm ata_generic pata_acpi drm virtio_console ata_piix 8139too libata virtio_pci crc32c_intel 8139cp nd_pmem serio_raw virtio_ring virtio floppy mii dm_mirror dm_region_hash dm_log dm_mod
[ 1985.040136] CR2: 00000000000002d0
[ 1985.042038] ---[ end trace db9a39c3773bb6fd ]---
[ 1985.044378] RIP: 0010:__dax_synchronous+0x5/0x20
[ 1985.046697] Code: ff ff ff c3 90 66 66 66 66 90 48 8b 87 d0 02 00 00 48 d1 e8 83 e0 01 c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 <48> 8b 87 d0 02 00 00 48 c1 e8 02 83 e0 01 c3 66 90 66 2e 0f 1f 84
[ 1985.055931] RSP: 0018:ffffad06503a7b38 EFLAGS: 00010246
[ 1985.058525] RAX: ffff9a248c7c2200 RBX: 0000000000000000 RCX: 0000000000046000
[ 1985.062065] RDX: 0000000000000800 RSI: ffff9a2493486d18 RDI: 0000000000000000
[ 1985.065441] RBP: ffff9a248c7c2200 R08: 0000000000000000 R09: 0000000000000000
[ 1985.068699] R10: 0000000000000003 R11: ffffad06503a7a28 R12: ffffad0640109040
[ 1985.071930] R13: 0000000000000000 R14: ffffffffc03d3ed0 R15: 0000000000000000
[ 1985.075169] FS:  00007f4dbf87d880(0000) GS:ffff9a2498640000(0000) knlGS:0000000000000000
[ 1985.078966] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1985.081619] CR2: 00000000000002d0 CR3: 000000046be80000 CR4: 00000000000006e0
[ 1985.084802] Kernel panic - not syncing: Fatal exception
[ 1985.156962] Kernel Offset: 0x3c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1985.161249] ---[ end Kernel panic - not syncing: Fatal exception ]---


bisect log:

git bisect start
# bad: [f8c3500cd137867927bc080f4a6e02e0222dd1b8] Merge tag 'libnvdimm-for-5.3' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect bad f8c3500cd137867927bc080f4a6e02e0222dd1b8
# good: [2ae048e16636afd7521270acacb08d9c42fd23f0] Merge tag 'sound-fix-5.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 2ae048e16636afd7521270acacb08d9c42fd23f0
# good: [913b187d12962fe8d9fa93c959f2f71ac16597ec] watchdog: stmp3xxx_rtc_wdt: drop warning after registering device
git bisect good 913b187d12962fe8d9fa93c959f2f71ac16597ec
# good: [4d1c6a0ec2d98e51f950127bf9299531caac53e1] watchdog: introduce watchdog.open_timeout commandline parameter
git bisect good 4d1c6a0ec2d98e51f950127bf9299531caac53e1
# good: [7fb832ae72949c883da52d6316ff08f03c75d300] watchdog: digicolor_wdt: Remove unused variable in dc_wdt_probe
git bisect good 7fb832ae72949c883da52d6316ff08f03c75d300
# bad: [2e9ee0955d3c2d3db56aa02ba6f948ba35d5e9c1] dm: enable synchronous dax
git bisect bad 2e9ee0955d3c2d3db56aa02ba6f948ba35d5e9c1
# good: [c5d4355d10d414a96ca870b731756b89d068d57a] libnvdimm: nd_region flush callback support
git bisect good c5d4355d10d414a96ca870b731756b89d068d57a
# good: [fefc1d97fa4b5e016bbe15447dc3edcd9e1bcb9f] libnvdimm: add dax_dev sync flag
git bisect good fefc1d97fa4b5e016bbe15447dc3edcd9e1bcb9f
# first bad commit: [2e9ee0955d3c2d3db56aa02ba6f948ba35d5e9c1] dm: enable synchronous dax
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

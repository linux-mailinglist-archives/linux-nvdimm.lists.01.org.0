Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242B213A106
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jan 2020 07:34:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9DB4110097E0A;
	Mon, 13 Jan 2020 22:37:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=34madxgkbabe9fg1r22v8r66zu.x55x2vb9v8t54av4a.t53@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 63AB510097E04
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jan 2020 22:37:30 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id w6so9696556ill.12
        for <linux-nvdimm@lists.01.org>; Mon, 13 Jan 2020 22:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AsoDybWiu9oeeZIYozVRkA2K+tw442FbkqUUZ2+BDk4=;
        b=Q0m0bNGQ2wG6vL9a7a9kHGZQYSUaKQiR+fUWMYhFdaaZFnDH8FfH+Wue6cQO94Y5NV
         2Qn+8aYJe7cBK4bLmB5y18s9xjwYYQQTGeGbeL9fyReibO0CZapgIM89I5UwhNqWXfcE
         reJv1DqcZISWsX1oFpw9apXN9ufzoI5WO3D+Qgc2dxsvaXl9KLrM1MD2rf3kcz6rMZpI
         RZAbOb9fJaBx7K3eRSxBNHpURPbmRMiBG9Y2esg/38OuNY8pTnZNl6mGj6FavQjc9fNI
         l8sfmxt2nHttR8OYdCwinsMcZnTSjfWOt+ZCRTjQa8+hpEOQbjmDQptmSFXjrwphUv5e
         Uuug==
X-Gm-Message-State: APjAAAWIIgVIIg2Ul/Y1KMLWH6tmCWeXyvDoLB0RoIIL22ag0VgBj1XB
	Pa1VHdjzZq+9P6EZU3emu0Lc5catIlKqMcaMtNSc7y1ynkVG
X-Google-Smtp-Source: APXvYqwgTdOp85AttTjzBrnZD7gxdOtH9RZ0rYYksQSDiYgMzGVwR5CKnEeGUOuZFCV7CKvHoAtRchuXup6x4gmDCairIf8TIA24
MIME-Version: 1.0
X-Received: by 2002:a5d:8a0c:: with SMTP id w12mr15667659iod.194.1578983650674;
 Mon, 13 Jan 2020 22:34:10 -0800 (PST)
Date: Mon, 13 Jan 2020 22:34:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009acfef059c13c771@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in acpi_nfit_ctl
From: syzbot <syzbot+002f559bf34c2c7467d0@syzkaller.appspotmail.com>
To: dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com,
	vishal.l.verma@intel.com
Message-ID-Hash: UKUZ2FF7MAMLBC54OKPCUV5KNJNSH4OO
X-Message-ID-Hash: UKUZ2FF7MAMLBC54OKPCUV5KNJNSH4OO
X-MailFrom: 34mAdXgkbABE9FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UKUZ2FF7MAMLBC54OKPCUV5KNJNSH4OO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: 7bit

Hello,

syzbot found the following crash on:

HEAD commit:    040a3c33 Merge tag 'iommu-fixes-v5.5-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120a5d8ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
dashboard link: https://syzkaller.appspot.com/bug?extid=002f559bf34c2c7467d0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+002f559bf34c2c7467d0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in test_bit  
include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x47f/0x1840  
drivers/acpi/nfit/core.c:495
Read of size 8 at addr ffffc90002ddbbb8 by task syz-executor.1/5941

CPU: 3 PID: 5941 Comm: syz-executor.1 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS  
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
  acpi_nfit_ctl+0x47f/0x1840 drivers/acpi/nfit/core.c:495
  __nd_ioctl drivers/nvdimm/bus.c:1152 [inline]
  nd_ioctl.isra.0+0xfe2/0x1580 drivers/nvdimm/bus.c:1230
  bus_ioctl+0x59/0x70 drivers/nvdimm/bus.c:1242
  compat_ptr_ioctl+0x6e/0xa0 fs/ioctl.c:788
  __do_compat_sys_ioctl fs/compat_ioctl.c:214 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:142 [inline]
  __ia32_compat_sys_ioctl+0x233/0x610 fs/compat_ioctl.c:142
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f37a39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5d330cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000000560a
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


Memory state around the buggy address:
  ffffc90002ddba80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90002ddbb00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
> ffffc90002ddbb80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                                         ^
  ffffc90002ddbc00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90002ddbc80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

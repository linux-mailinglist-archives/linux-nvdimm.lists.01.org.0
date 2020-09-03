Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5FF25C975
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Sep 2020 21:24:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A6A3A139F60E8;
	Thu,  3 Sep 2020 12:24:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA1EC13C52508
	for <linux-nvdimm@lists.01.org>; Thu,  3 Sep 2020 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599161078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=hA5BHxGnyIpr07k13xquxSqh/5t1ipENL7Z2gKNlLvk=;
	b=UoqkUtPL6ivTC2jQXQwNzLMmTrGtK5JeaODw7J0Ch+BF9I3/48mKnmnCpSy2ehWqJiC3AN
	aqxcxS/GHXnmCkDKyH3w+GqFs5/joFuYnU4nbn32VMmLvnAZw1EA/N5BRxGjEQ3kHl+o+P
	/o886PDL1KS/N0//nfA1S87XCIuZZ3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-ZZCQTtvfOfiixfzAj-ch5w-1; Thu, 03 Sep 2020 15:24:34 -0400
X-MC-Unique: ZZCQTtvfOfiixfzAj-ch5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A65881F000;
	Thu,  3 Sep 2020 19:24:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DD3EF5C1C2;
	Thu,  3 Sep 2020 19:24:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 083JOSW3017461;
	Thu, 3 Sep 2020 15:24:28 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 083JOR69017457;
	Thu, 3 Sep 2020 15:24:27 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Thu, 3 Sep 2020 15:24:27 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: a crash when running strace from persistent memory
Message-ID: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: G23E3HY22E4XCD62PTDMUATCTSMG2GWZ
X-Message-ID-Hash: G23E3HY22E4XCD62PTDMUATCTSMG2GWZ
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G23E3HY22E4XCD62PTDMUATCTSMG2GWZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

There's a bug when you run strace from dax-based filesystem.

-- create real or emulated persistent memory device (/dev/pmem0)
mkfs.ext2 /dev/pmem0
-- mount it
mount -t ext2 -o dax /dev/pmem0 /mnt/test
-- copy the system to it (well, you can copy just a few files that are 
   needed for running strace and ls)
cp -ax / /mnt/test
-- bind the system directories
mount --bind /dev /mnt/test/dev
mount --bind /proc /mnt/test/proc
mount --bind /sys /mnt/test/sys
-- run strace on the ls command
chroot /mnt/test/ strace /bin/ls

You get this warning and ls is killed with SIGSEGV.

I bisected the problem and it is caused by the commit 
17839856fd588f4ab6b789f482ed3ffd7c403e1f (gup: document and work around 
"COW can break either way" issue). When I revert the patch (on the kernel 
5.9-rc3), the bug goes away.

Mikulas


[   84.190961] ------------[ cut here ]------------
[   84.191504] WARNING: CPU: 6 PID: 1350 at mm/memory.c:2486 wp_page_copy.cold+0xdb/0xf6
[   84.192398] Modules linked in: ext2 uvesafb cfbfillrect cfbimgblt cn cfbcopyarea fb fbdev ipv6 tun autofs4 binfmt_misc configfs af_packet mousedev virtio_balloon virtio_rng evdev rng_core pcspkr button raid10 raid456 async_raid6_recov async_memcpy async_pq raid6_pq async_xor xor async_tx libcrc32c raid1 raid0 md_mod sd_mod t10_pi virtio_scsi virtio_net psmouse net_failover scsi_mod failover
[   84.196301] CPU: 6 PID: 1350 Comm: strace Not tainted 5.9.0-rc3 #6
[   84.197020] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   84.197685] RIP: 0010:wp_page_copy.cold+0xdb/0xf6
[   84.198231] Code: ff ff ff 0f 00 eb 8e 48 8b 3c 24 48 8b 74 24 08 ba 00 10 00 00 e8 33 87 1f 00 85 c0 74 1f 48 c7 c7 a7 2b ba 81 e8 cc b6 f0 ff <0f> 0b 48 8b 3c 24 e8 08 82 1f 00 41 be 01 00 00 00 eb ae 41 be 01
[   84.200410] RSP: 0018:ffff88940c1dba58 EFLAGS: 00010282
[   84.201035] RAX: 0000000000000006 RBX: ffff88940c1dbb00 RCX: 0000000000000000
[   84.201842] RDX: 0000000000000003 RSI: ffffffff81b9c0fa RDI: 00000000ffffffff
[   84.202650] RBP: ffffea004f0e4d80 R08: 0000000000000000 R09: 0000000000000000
[   84.203460] R10: 0000000000000046 R11: 0000000000000000 R12: 0000000000000000
[   84.204265] R13: ffff88940aa86318 R14: 00000000f7fac000 R15: ffff8893c8db3c40
[   84.205083] FS:  00007fd8a8320740(0000) GS:ffff88940fb80000(0000) knlGS:0000000000000000
[   84.206000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.206664] CR2: 00000000f7fac000 CR3: 00000013c93a6000 CR4: 00000000000006a0
[   84.207481] Call Trace:
[   84.207883]  do_wp_page+0x172/0x6a0
[   84.208285]  handle_mm_fault+0xd0b/0x1540
[   84.208753]  __get_user_pages+0x21a/0x6c0
[   84.209213]  __get_user_pages_remote+0xc8/0x2a0
[   84.209735]  process_vm_rw_core.isra.0+0x1ac/0x440
[   84.210318]  ? __might_fault+0x26/0x40
[   84.210758]  ? _copy_from_user+0x6a/0xa0
[   84.211208]  ? __might_fault+0x26/0x40
[   84.211642]  ? _copy_from_user+0x6a/0xa0
[   84.212091]  process_vm_rw+0xd1/0x100
[   84.212511]  ? _copy_to_user+0x69/0x80
[   84.212946]  ? ptrace_get_syscall_info+0x9b/0x180
[   84.213484]  ? find_held_lock+0x2b/0x80
[   84.213926]  ? __x64_sys_ptrace+0x106/0x140
[   84.214405]  ? fpregs_assert_state_consistent+0x19/0x40
[   84.215002]  ? exit_to_user_mode_prepare+0x2d/0x120
[   84.215556]  __x64_sys_process_vm_readv+0x22/0x40
[   84.216103]  do_syscall_64+0x2d/0x80
[   84.216518]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   84.217098] RIP: 0033:0x7fd8a84896da
[   84.217512] Code: 48 8b 15 b9 f7 0b 00 f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 18 f0 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 36 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 06 c3 0f 1f 44 00 00 48 8b 15 81 f7 0b 00 f7
[   84.219618] RSP: 002b:00007ffd08c3c678 EFLAGS: 00000246 ORIG_RAX: 0000000000000136
[   84.220563] RAX: ffffffffffffffda RBX: 00000000f7fac000 RCX: 00007fd8a84896da
[   84.221380] RDX: 0000000000000001 RSI: 00007ffd08c3c680 RDI: 0000000000000549
[   84.222194] RBP: 00007ffd08c3c760 R08: 0000000000000001 R09: 0000000000000000
[   84.222999] R10: 00007ffd08c3c690 R11: 0000000000000246 R12: 00000000f7faca80
[   84.223804] R13: 0000000000000580 R14: 0000000000000549 R15: 00005589a50eee80
[   84.223804] R13: 0000000000000580 R14: 0000000000000549 R15: 00005589a50eee80
[   84.224612] ---[ end trace d8dbf2da5dc1b7ca ]---
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

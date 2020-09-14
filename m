Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3F269099
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Sep 2020 17:49:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B71F813FE8184;
	Mon, 14 Sep 2020 08:49:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6AB8413FE817D
	for <linux-nvdimm@lists.01.org>; Mon, 14 Sep 2020 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600098548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=q5uu+9zgSI+3J6UgTm2of7/UUjg838VIzjmmVE/Rcso=;
	b=W0HMCjHxJpiLB0XwMtCXXdrBx4l49/5vpa5w1gX4AVyXlKCHbdf2u2FNjP0u18LUNaLV9I
	lWoGUfohKnSMAyGQ3hjxzpk6xLLOfW2eOR3CO23LTfzWmJ3OukB9aC1Q8ZTfKzfDGCdtCg
	cyajFSz6FoCy056KCocY/5ojU0zULPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-bSMVXuDOOQWaRLXnbQrIXA-1; Mon, 14 Sep 2020 11:49:03 -0400
X-MC-Unique: bSMVXuDOOQWaRLXnbQrIXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0951E10BBEC1;
	Mon, 14 Sep 2020 15:49:02 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE9C27BD0;
	Mon, 14 Sep 2020 15:48:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08EFmwQb005450;
	Mon, 14 Sep 2020 11:48:58 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08EFmvFc005446;
	Mon, 14 Sep 2020 11:48:57 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Mon, 14 Sep 2020 11:48:57 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Coly Li <colyli@suse.de>, Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: regression caused by patch 6180bb446ab624b9ab8bf201ed251ca87f07b413
 ("dax: fix detection of dax support for non-persistent memory block
 devices")
Message-ID: <alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mpatocka@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Message-ID-Hash: OOZGFY3RNQGTGJJCH52YXCSYIDXMOPXO
X-Message-ID-Hash: OOZGFY3RNQGTGJJCH52YXCSYIDXMOPXO
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.com>, Adrian Huang <ahuang12@lenovo.com>, Mike Snitzer <snitzer@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OOZGFY3RNQGTGJJCH52YXCSYIDXMOPXO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

The patch 6180bb446ab624b9ab8bf201ed251ca87f07b413 ("dax: fix detection of 
dax support for non-persistent memory block devices") causes crash when 
attempting to mount the ext4 filesystem on /dev/pmem0 ("mkfs.ext4 
/dev/pmem0; mount -t ext4 /dev/pmem0 /mnt/test"). The device /dev/pmem0 is 
emulated using the "memmap" kernel parameter.

The patch causes infinite recursion and double-fault exception:

__generic_fsdax_supported
bdev_dax_supported
__bdev_dax_supported
dax_supported
dax_dev->ops->dax_supported
generic_fsdax_supported
__generic_fsdax_supported

Mikulas



[   17.500619] traps: PANIC: double fault, error_code: 0x0
[   17.500619] double fault: 0000 [#1] PREEMPT SMP
[   17.500620] CPU: 0 PID: 1326 Comm: mount Not tainted 5.9.0-rc1-bisect #10
[   17.500620] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   17.500621] RIP: 0010:__generic_fsdax_supported+0x6a/0x500
[   17.500622] Code: ff ff ff ff ff 7f 00 48 21 f3 48 01 c3 48 c1 e3 09 f6 c7 0e 0f 85 fa 01 00 00 48 85 ff 49 89 fd 74 11 be 00 10 00 00 4c 89 e7 <e8> b1 fe ff ff 84 c0 75 11 31 c0 48 83 c4 48 5b 5d 41 5c 41 5d 41
[   17.500623] RSP: 0018:ffff88940b4fdff8 EFLAGS: 00010286
[   17.500624] RAX: 0000000000000000 RBX: 00000007fffff000 RCX: 0000000000000000
[   17.500625] RDX: 0000000000001000 RSI: 0000000000001000 RDI: ffff88940b34c300
[   17.500625] RBP: 0000000000000000 R08: 0000000004000000 R09: 8080808080808080
[   17.500626] R10: 0000000000000000 R11: fefefefefefefeff R12: ffff88940b34c300
[   17.500626] R13: ffff88940b3dc000 R14: ffff88940badd000 R15: 0000000000000001
[   17.500627] FS:  00000000f7c25780(0000) GS:ffff88940fa00000(0000) knlGS:0000000000000000
[   17.500628] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   17.500628] CR2: ffff88940b4fdfe8 CR3: 000000140bd15000 CR4: 00000000000006b0
[   17.500628] Call Trace:
[   17.500629] Modules linked in: uvesafb cfbfillrect cfbimgblt cn cfbcopyarea fb fbdev ipv6 tun autofs4 binfmt_misc configfs af_packet virtio_rng rng_core mousedev evdev pcspkr virtio_balloon button raid10 raid456 async_raid6_recov async_memcpy async_pq raid6_pq async_xor xor async_tx libcrc32c raid1 raid0 md_mod sd_mod t10_pi virtio_scsi virtio_net net_failover psmouse scsi_mod failover
[   17.500638] ---[ end trace 3c877fcb5b865459 ]---
[   17.500638] RIP: 0010:__generic_fsdax_supported+0x6a/0x500
[   17.500639] Code: ff ff ff ff ff 7f 00 48 21 f3 48 01 c3 48 c1 e3 09 f6 c7 0e 0f 85 fa 01 00 00 48 85 ff 49 89 fd 74 11 be 00 10 00 00 4c 89 e7 <e8> b1 fe ff ff 84 c0 75 11 31 c0 48 83 c4 48 5b 5d 41 5c 41 5d 41
[   17.500640] RSP: 0018:ffff88940b4fdff8 EFLAGS: 00010286
[   17.500641] RAX: 0000000000000000 RBX: 00000007fffff000 RCX: 0000000000000000
[   17.500641] RDX: 0000000000001000 RSI: 0000000000001000 RDI: ffff88940b34c300
[   17.500642] RBP: 0000000000000000 R08: 0000000004000000 R09: 8080808080808080
[   17.500642] R10: 0000000000000000 R11: fefefefefefefeff R12: ffff88940b34c300
[   17.500643] R13: ffff88940b3dc000 R14: ffff88940badd000 R15: 0000000000000001
[   17.500643] FS:  00000000f7c25780(0000) GS:ffff88940fa00000(0000) knlGS:0000000000000000
[   17.500644] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   17.500644] CR2: ffff88940b4fdfe8 CR3: 000000140bd15000 CR4: 00000000000006b0
[   17.500645] Kernel panic - not syncing: Fatal exception in interrupt
[   17.500941] Kernel Offset: disabled
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B84DC26A545
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 14:34:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 09F821412E99A;
	Tue, 15 Sep 2020 05:34:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AE1FF1412E997
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600173290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4519MBa/X1sl/QK2gxX8FNaV3scXLpDGnOIe66gW2JE=;
	b=ZIBS/07GFIsdj1M/sJ6DyABontgIdsj1ifi8lIEmqeA/6ln6uxF/3GEiNCHo2HEkUmID5y
	+swaJw8Qd8mOgUa1M/TruQMan9vSNsmSv7R8KvUrpWmL/21QyggYZ8havhPCgYZNqnby9d
	wLX1lTj3gvjXt6lqocJT1GxKbuZ2mZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-4pyk1GQ8Nuy-9_ZgAQpwbw-1; Tue, 15 Sep 2020 08:34:46 -0400
X-MC-Unique: 4pyk1GQ8Nuy-9_ZgAQpwbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03FC881F007;
	Tue, 15 Sep 2020 12:34:44 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BBAAF19C4F;
	Tue, 15 Sep 2020 12:34:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08FCYhSA004603;
	Tue, 15 Sep 2020 08:34:43 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08FCYfFY004600;
	Tue, 15 Sep 2020 08:34:41 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Tue, 15 Sep 2020 08:34:41 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>
Subject: [RFC] nvfs: a filesystem for persistent memory
Message-ID: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: OH4VBE4KQEVTPS5IIKNEHRU4CR6PXQW3
X-Message-ID-Hash: OH4VBE4KQEVTPS5IIKNEHRU4CR6PXQW3
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OH4VBE4KQEVTPS5IIKNEHRU4CR6PXQW3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

I am developing a new filesystem suitable for persistent memory - nvfs. 
The goal is to have a small and fast filesystem that can be used on 
DAX-based devices. Nvfs maps the whole device into linear address space 
and it completely bypasses the overhead of the block layer and buffer 
cache.

In the past, there was nova filesystem for pmem, but it was abandoned a 
year ago (the last version is for the kernel 5.1 - 
https://github.com/NVSL/linux-nova ). Nvfs is smaller and performs better.

The design of nvfs is similar to ext2/ext4, so that it fits into the VFS 
layer naturally, without too much glue code.

I'd like to ask you to review it.


tarballs:
	http://people.redhat.com/~mpatocka/nvfs/
git:
	git://leontynka.twibright.com/nvfs.git
the description of filesystem internals:
	http://people.redhat.com/~mpatocka/nvfs/INTERNALS
benchmarks:
	http://people.redhat.com/~mpatocka/nvfs/BENCHMARKS


TODO:

- programs run approximately 4% slower when running from Optane-based 
persistent memory. Therefore, programs and libraries should use page cache 
and not DAX mapping.

- when the fsck.nvfs tool mmaps the device /dev/pmem0, the kernel uses 
buffer cache for the mapping. The buffer cache slows does fsck by a factor 
of 5 to 10. Could it be possible to change the kernel so that it maps DAX 
based block devices directly?

- __copy_from_user_inatomic_nocache doesn't flush cache for leading and 
trailing bytes.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

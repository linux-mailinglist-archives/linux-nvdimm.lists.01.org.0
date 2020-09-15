Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F06DC26A640
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 15:24:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A33FB13D5CB7F;
	Tue, 15 Sep 2020 06:24:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1EFCC13D4EA0E
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600176253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgU4TZhvG3KpN9lJZj8ZqRXmFgzWt5CrSbPFJksfUsw=;
	b=H9AE6oGxwqTRiJcfxgK+78pcaSyKtgAfSpCINDbTGuqa1G3aZDvApCAoWJLBr6Yz5Dyd34
	KzBr3wN1fJMMnulMRpZl6JB6kczgbtM8LIGV5ad5O8LvabSIxzX2Bm66piT7XxV1ZpzPjr
	tsPwGiNAdCT7oqGrCXaux17h2wyqaOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-Q3X7or1cPDKRDui_raGheg-1; Tue, 15 Sep 2020 09:24:09 -0400
X-MC-Unique: Q3X7or1cPDKRDui_raGheg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6792E1084D64;
	Tue, 15 Sep 2020 13:24:07 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3913960BE2;
	Tue, 15 Sep 2020 13:24:07 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08FDO6xQ009380;
	Tue, 15 Sep 2020 09:24:06 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08FDO6nw009376;
	Tue, 15 Sep 2020 09:24:06 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Tue, 15 Sep 2020 09:24:06 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
In-Reply-To: <20200915130012.GC5449@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2009150911570.8228@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <20200915130012.GC5449@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: RTI2PTACN4RNF23YNFNQ2KBDBMT43CKI
X-Message-ID-Hash: RTI2PTACN4RNF23YNFNQ2KBDBMT43CKI
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RTI2PTACN4RNF23YNFNQ2KBDBMT43CKI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 15 Sep 2020, Matthew Wilcox wrote:

> On Tue, Sep 15, 2020 at 08:34:41AM -0400, Mikulas Patocka wrote:
> > - when the fsck.nvfs tool mmaps the device /dev/pmem0, the kernel uses 
> > buffer cache for the mapping. The buffer cache slows does fsck by a factor 
> > of 5 to 10. Could it be possible to change the kernel so that it maps DAX 
> > based block devices directly?
> 
> Oh, because fs/block_dev.c has:
>         .mmap           = generic_file_mmap,
> 
> I don't see why we shouldn't have a blkdev_mmap modelled after
> ext2_file_mmap() with the corresponding blkdev_dax_vm_ops.

Yes, that's possible - and we whould also have to rewrite methods 
read_iter and write_iter on DAX block devices, so that they are coherent 
with mmap.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D945272B97
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 18:19:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 795F014545474;
	Mon, 21 Sep 2020 09:19:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83BDC1454546F
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600705155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmFjVvOWAAxGsKnBKa5OzPqNgYQ+Dx+Zm77T3IL8Os4=;
	b=MMoWsS84lEG1iYVY2XK3Nv2Y/eG7iDB6yi0J9GkQp6MhxCHP7A115y+LFZDSMKsy9vZkKr
	q/oYroyIPPiGa5SejZnaZYoSdEG74XMKuaLfuK/eDFW000ndISS2/kUfo6Aexg+eDAuOqT
	bFaOu4JJn7kKm/2p7NZUUkwQEf8sMa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-VnG3BKQDNH25JjLQQZjOew-1; Mon, 21 Sep 2020 12:19:13 -0400
X-MC-Unique: VnG3BKQDNH25JjLQQZjOew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0746C801F99;
	Mon, 21 Sep 2020 16:19:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BF186115F;
	Mon, 21 Sep 2020 16:19:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08LGJ9Iq006331;
	Mon, 21 Sep 2020 12:19:09 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08LGJ7Y4006327;
	Mon, 21 Sep 2020 12:19:08 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Mon, 21 Sep 2020 12:19:07 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
In-Reply-To: <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2009211133190.15623@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: WXMAV4UYO5JHQGFQ5GPNWSRJNSLBAUWU
X-Message-ID-Hash: WXMAV4UYO5JHQGFQ5GPNWSRJNSLBAUWU
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WXMAV4UYO5JHQGFQ5GPNWSRJNSLBAUWU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 15 Sep 2020, Dan Williams wrote:

> > TODO:
> >
> > - programs run approximately 4% slower when running from Optane-based
> > persistent memory. Therefore, programs and libraries should use page cache
> > and not DAX mapping.
> 
> This needs to be based on platform firmware data f(ACPI HMAT) for the
> relative performance of a PMEM range vs DRAM. For example, this
> tradeoff should not exist with battery backed DRAM, or virtio-pmem.

Hi

I have implemented this functionality - if we mmap a file with 
(vma->vm_flags & VM_DENYWRITE), then it is assumed that this is executable 
file mapping - the flag S_DAX on the inode is cleared on and the inode 
will use normal page cache.

Is there some way how to test if we are using Optane-based module (where 
this optimization should be applied) or battery backed DRAM (where it 
should not)?

I've added mount options dax=never, dax=auto, dax=always, so that the user 
can override the automatic behavior.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

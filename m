Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F37C826AA26
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 18:59:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A84AF13DCA2DB;
	Tue, 15 Sep 2020 09:58:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 35D9E13D6FB91
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600189134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=walQ61YYGzyVqfuTJ3FRBx41wBNDB3XgqTy7en19sog=;
	b=AiTLTSfgnicP3KYFgSBdyn/KDwvSHwiRuHFm3OTUXPAV99DkdWDrPXC0OWkOyfGtgu9um9
	LSFDoqxx2IGAkJQIsnrp3jX7C8nlkfEMZemltXkrP7A8XjqE7TDCPr64NAVpUEfy3eYJ0X
	tt77+b6BE8Bji1FGzjYu5VtQtN914N0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-c5pfAVJMMm2Wno7Kl1o0YA-1; Tue, 15 Sep 2020 12:58:52 -0400
X-MC-Unique: c5pfAVJMMm2Wno7Kl1o0YA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77D1D18BFECB;
	Tue, 15 Sep 2020 16:58:49 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 237865DC17;
	Tue, 15 Sep 2020 16:58:49 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08FGwmjQ031604;
	Tue, 15 Sep 2020 12:58:48 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08FGwkUQ031600;
	Tue, 15 Sep 2020 12:58:47 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Tue, 15 Sep 2020 12:58:46 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
In-Reply-To: <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: M2H7WODXZFO2NAWNXE4LYLNR3P5ET77W
X-Message-ID-Hash: M2H7WODXZFO2NAWNXE4LYLNR3P5ET77W
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M2H7WODXZFO2NAWNXE4LYLNR3P5ET77W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 15 Sep 2020, Dan Williams wrote:

> > - when the fsck.nvfs tool mmaps the device /dev/pmem0, the kernel uses
> > buffer cache for the mapping. The buffer cache slows does fsck by a factor
> > of 5 to 10. Could it be possible to change the kernel so that it maps DAX
> > based block devices directly?
> 
> We've been down this path before.
> 
> 5a023cdba50c block: enable dax for raw block devices
> 9f4736fe7ca8 block: revert runtime dax control of the raw block device
> acc93d30d7d4 Revert "block: enable dax for raw block devices"

It says "The functionality is superseded by the new 'Device DAX' 
facility". But the fsck tool can't change a fsdax device into a devdax 
device just for checking. Or can it?

> EXT2/4 metadata buffer management depends on the page cache and we
> eliminated a class of bugs by removing that support. The problems are
> likely tractable, but there was not a straightforward fix visible at
> the time.

Thinking about it - it isn't as easy as it looks...

Suppose that the user mounts an ext2 filesystem and then uses the tune2fs 
tool on the mounted block device. The tune2fs tool reads and writes the 
mounted superblock directly.

So, read/write must be coherent with the buffer cache (otherwise the 
kernel would not see the changes written by tune2fs). And mmap must be 
coherent with read/write.

So, if we want to map the pmem device directly, we could add a new flag 
MAP_DAX. Or we could test if the fd has O_DIRECT flag and map it directly 
in this case. But the default must be to map it coherently in order to not 
break existing programs.

> > - __copy_from_user_inatomic_nocache doesn't flush cache for leading and
> > trailing bytes.
> 
> You want copy_user_flushcache(). See how fs/dax.c arranges for
> dax_copy_from_iter() to route to pmem_copy_from_iter().

Is it something new for the kernel 5.10? I see only __copy_user_flushcache 
that is implemented just for x86 and arm64.

There is __copy_from_user_flushcache implemented for x86, arm64 and power. 
It is used in lib/iov_iter.c under
#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE - so should I use this?

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

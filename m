Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C021DD653
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 20:52:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E667F11683462;
	Thu, 21 May 2020 11:49:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC8A011683461
	for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1590087159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=883OxgyIbKrW9ooCfLLJO2xMMuisLeBSxvMPqRQrt1Q=;
	b=Nll6p/w83XsbjlgI+DhGWELFUhpidf3z/XclE0JEus+iUQDrXjzEzv5waNyxkQoEawJ8b9
	EjZgGKuREkOIeESDEecdJ8UIqeQDqYqPUwynWKtYtPyrrJ48LccQcsP92lLzHjEo/ggarv
	X8+8o6ZtU/ZF9P8er/B0DTR1XSt0a/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-6u0kVfTLPoKxu6clnMfNEQ-1; Thu, 21 May 2020 14:52:35 -0400
X-MC-Unique: 6u0kVfTLPoKxu6clnMfNEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37222107B789;
	Thu, 21 May 2020 18:52:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 20C4760C87;
	Thu, 21 May 2020 18:52:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 04LIqVEb025350;
	Thu, 21 May 2020 14:52:31 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 04LIqUGs025334;
	Thu, 21 May 2020 14:52:30 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Thu, 21 May 2020 14:52:30 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
In-Reply-To: <CAPcyv4iG9GC42s5DaWWegH=Mi7XHgJoUghgOM9qMRrCg4wuMig@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2005211442290.22894@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200513034705.172983-1-aneesh.kumar@linux.ibm.com> <20200513034705.172983-3-aneesh.kumar@linux.ibm.com> <CAPcyv4iAdrdMiSzVr1UL9Naya+Rq70WVuKqCCNFHe1C4n+E6Tw@mail.gmail.com> <87v9kspk3x.fsf@linux.ibm.com> <CAPcyv4g+oE305Q5bYWkNBKFifB9c0TZo6+hqFQnqiFqU5QFrhQ@mail.gmail.com>
 <87d070f2vs.fsf@linux.ibm.com> <CAPcyv4jZhYXEmYGzqGPjPtq9ZWJNtQyszN0V0Xcv0qtByK_KCw@mail.gmail.com> <x49o8qh9wu5.fsf@segfault.boston.devel.redhat.com> <ba91c061-41ef-5c54-8e9b-7b22e44577cd@linux.ibm.com>
 <CAPcyv4iG9GC42s5DaWWegH=Mi7XHgJoUghgOM9qMRrCg4wuMig@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: 45IZBQQ2BKG46MQMVZP25SY5ZQICIUVL
X-Message-ID-Hash: 45IZBQQ2BKG46MQMVZP25SY5ZQICIUVL
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, alistair@popple.id.au, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/45IZBQQ2BKG46MQMVZP25SY5ZQICIUVL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 21 May 2020, Dan Williams wrote:

> On Thu, May 21, 2020 at 10:03 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
> >
> > > Moving on to the patch itself--Aneesh, have you audited other persistent
> > > memory users in the kernel?  For example, drivers/md/dm-writecache.c does
> > > this:
> > >
> > > static void writecache_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
> > > {
> > >       if (WC_MODE_PMEM(wc))
> > >               wmb(); <==========
> > >          else
> > >                  ssd_commit_flushed(wc, wait_for_ios);
> > > }
> > >
> > > I believe you'll need to make modifications there.
> > >
> >
> > Correct. Thanks for catching that.
> >
> >
> > I don't understand dm much, wondering how this will work with
> > non-synchronous DAX device?
> 
> That's a good point. DM-writecache needs to be cognizant of things
> like virtio-pmem that violate the rule that persisent memory writes
> can be flushed by CPU functions rather than calling back into the
> driver. It seems we need to always make the flush case a dax_operation
> callback to account for this.

dm-writecache is normally sitting on the top of dm-linear, so it would 
need to pass the wmb() call through the dm core and dm-linear target ... 
that would slow it down ... I remember that you already did it this way 
some times ago and then removed it.

What's the exact problem with POWER? Could the POWER system have two types 
of persistent memory that need two different ways of flushing?

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

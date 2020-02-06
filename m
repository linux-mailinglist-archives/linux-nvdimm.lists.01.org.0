Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C2154647
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Feb 2020 15:34:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CBC11007A82F;
	Thu,  6 Feb 2020 06:38:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D25391007A82E
	for <linux-nvdimm@lists.01.org>; Thu,  6 Feb 2020 06:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1580999692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q96osyoFE6MDAYmksdUx62XK0qXSrPhY82lgZlCCHPg=;
	b=YKwTv23ahORNy/6mS29OmC1L6nQ7Wto7+cQVbM0ZuLC3pcC7wOTcjaBuoJ4sc9+pQwiPJW
	L7sp6UmIGXvGxwxitpTTQp+cm693RX370GwLpUSeWLv/W6KhDOAZjiRsBU8q/OWlxNsKQp
	TSvs074MHX6nxGn0dFbxGx3O5NUAxMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-69_fBUTJOnuI4O45hP3NQQ-1; Thu, 06 Feb 2020 09:34:47 -0500
X-MC-Unique: 69_fBUTJOnuI4O45hP3NQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D35211083E95;
	Thu,  6 Feb 2020 14:34:46 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4B50089F00;
	Thu,  6 Feb 2020 14:34:44 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id D3A482202E9; Thu,  6 Feb 2020 09:34:43 -0500 (EST)
Date: Thu, 6 Feb 2020 09:34:43 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200206143443.GB12036@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org>
 <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: XZ6IP43BS2ES2VWL2NZGZPIJT6Y2CITI
X-Message-ID-Hash: XZ6IP43BS2ES2VWL2NZGZPIJT6Y2CITI
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XZ6IP43BS2ES2VWL2NZGZPIJT6Y2CITI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
> On Wed, Feb 5, 2020 at 12:03 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Feb 05, 2020 at 10:30:50AM -0800, Christoph Hellwig wrote:
> > > > +   /*
> > > > +    * There are no users as of now. Once users are there, fix dm code
> > > > +    * to be able to split a long range across targets.
> > > > +    */
> > >
> > > This comment confused me.  I think this wants to say something like:
> > >
> > >       /*
> > >        * There are now callers that want to zero across a page boundary as of
> > >        * now.  Once there are users this check can be removed after the
> > >        * device mapper code has been updated to split ranges across targets.
> > >        */
> >
> > Yes, that's what I wanted to say but I missed one line. Thanks. Will fix
> > it.
> >
> > >
> > > > +static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> > > > +                               unsigned int offset, size_t len)
> > > > +{
> > > > +   int rc = 0;
> > > > +   phys_addr_t phys_pos = pgoff * PAGE_SIZE + offset;
> > >
> > > Any reason not to pass a phys_addr_t in the calling convention for the
> > > method and maybe also for dax_zero_page_range itself?
> >
> > I don't have any reason not to pass phys_addr_t. If that sounds better,
> > will make changes.
> 
> The problem is device-mapper. That wants to use offset to route
> through the map to the leaf device. If it weren't for the firmware
> communication requirement you could do:
> 
> dax_direct_access(...)
> generic_dax_zero_page_range(...)
> 
> ...but as long as the firmware error clearing path is required I think
> we need to do pass the pgoff through the interface and do the pgoff to
> virt / phys translation inside the ops handler.

Hi Dan,

Drivers can easily convert offset into dax device (say phys_addr_t) to
pgoff and offset into page, isn't it?

pgoff_t = phys_addr_t/PAGE_SIZE;
offset = phys_addr_t & (PAGE_SIZE - 1);

And pgoff can easily be converted into sectors which dm/md can use for
mapping and come up with pgoff in target device.

Anyway, I am fine with anything.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

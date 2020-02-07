Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2254B155C61
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Feb 2020 18:02:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B86FC10FC3584;
	Fri,  7 Feb 2020 09:05:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 147DF10FC341E
	for <linux-nvdimm@lists.01.org>; Fri,  7 Feb 2020 09:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581094917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnKyslaJEYi2vmej8z10FakIQgGWGqomW+jH0AD5b90=;
	b=McIgACo7tcnTwfVXFJXMtEMgbZMY5bbpbAnglTafrHrj78FtcDChWrK8Faw3Iim4J2mtzk
	8l8Lim27JlwUygBdZ3Q91ZGikxOHN2CVN71Gwowl5x6s+Y9zoZfIvgEpq+O2ddC/5gUsgt
	QAFyoC0JnQtABbTbstecwFV06u8fZ5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-gJz5zF4zOu6tl1jFnS3N5A-1; Fri, 07 Feb 2020 12:01:54 -0500
X-MC-Unique: gJz5zF4zOu6tl1jFnS3N5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB031084426;
	Fri,  7 Feb 2020 17:01:53 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B56C7859A5;
	Fri,  7 Feb 2020 17:01:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 46A67220A24; Fri,  7 Feb 2020 12:01:50 -0500 (EST)
Date: Fri, 7 Feb 2020 12:01:50 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200207170150.GC11998@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org>
 <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
 <20200206074142.GB28365@infradead.org>
 <CAPcyv4iTBTOuKjQX3eoojLM=Eai_pfARXmzpMAtgi5OWBHXvzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iTBTOuKjQX3eoojLM=Eai_pfARXmzpMAtgi5OWBHXvzQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: PES3542OHFZCRNVGPQIGV4B7CA4TA74S
X-Message-ID-Hash: PES3542OHFZCRNVGPQIGV4B7CA4TA74S
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PES3542OHFZCRNVGPQIGV4B7CA4TA74S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 07, 2020 at 08:57:39AM -0800, Dan Williams wrote:
> On Wed, Feb 5, 2020 at 11:41 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
> > > > I don't have any reason not to pass phys_addr_t. If that sounds better,
> > > > will make changes.
> > >
> > > The problem is device-mapper. That wants to use offset to route
> > > through the map to the leaf device. If it weren't for the firmware
> > > communication requirement you could do:
> > >
> > > dax_direct_access(...)
> > > generic_dax_zero_page_range(...)
> > >
> > > ...but as long as the firmware error clearing path is required I think
> > > we need to do pass the pgoff through the interface and do the pgoff to
> > > virt / phys translation inside the ops handler.
> >
> > Maybe phys_addr_t was the wrong type - but why do we split the offset
> > into the block device argument into a pgoff and offset into page instead
> > of a single 64-bit value?
> 
> Oh, got it yes, that looks odd for sub-page zeroing. Yes, let's just
> have one device relative byte-offset.

So what's the best type to represent this offset. "u64" or "phys_addr_t"
or "loff_t" or something else.  I like phys_addr_t followed by u64.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

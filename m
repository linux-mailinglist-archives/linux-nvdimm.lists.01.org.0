Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59172D3B7E
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 07:34:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E4E0100EC1F3;
	Tue,  8 Dec 2020 22:34:12 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE59F100EC1F3
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 22:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+CpRBRSCNa0eicUgRiha4jJ2Xs6QCN3aamgew32OI0A=; b=Vny5zMI3uLth9IyKowG/frEUBr
	Y0KpowoLqfAO8EGLmna1WvkVLwyEZehA/IjWDslQ2YZNaxCgMD4+OawdkO9Ie1bOXEcaB0G07NAWB
	XOu6OF8v+LHOlzkkLxB+o7EGuV60XTyqOaK4Le2azuuNivmj7E6WNRX7cwQ5UzyCDBLrKSGB6oq6r
	8iGcm1RnUA+VOoSnvS4ZDgzToUvBlcAceDLjSZMDcaRKly7Wvk9Az4cj+u46Uj6aw3eIp7cc8MSee
	doJVPvU5aqt1NxIvCdydn0Bz9Tmcmrhw+JoaLFmxSe9UXVd+sn+aWd62y75UyHutlkMKBCkd+aLsm
	leoSHe3g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmt2s-0006QH-Ns; Wed, 09 Dec 2020 06:33:50 +0000
Date: Wed, 9 Dec 2020 06:33:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound
 pages
Message-ID: <20201209063350.GO7338@casper.infradead.org>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com>
 <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
Message-ID-Hash: KD553V6XKD55GSPUA2JNVNA2SBCONHAL
X-Message-ID-Hash: KD553V6XKD55GSPUA2JNVNA2SBCONHAL
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KD553V6XKD55GSPUA2JNVNA2SBCONHAL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 08, 2020 at 09:59:19PM -0800, John Hubbard wrote:
> On 12/8/20 9:28 AM, Joao Martins wrote:
> > Add a new flag for struct dev_pagemap which designates that a a pagemap
> 
> a a
> 
> > is described as a set of compound pages or in other words, that how
> > pages are grouped together in the page tables are reflected in how we
> > describe struct pages. This means that rather than initializing
> > individual struct pages, we also initialize these struct pages, as
> 
> Let's not say "rather than x, we also do y", because it's self-contradictory.
> I think you want to just leave out the "also", like this:
> 
> "This means that rather than initializing> individual struct pages, we
> initialize these struct pages ..."
> 
> Is that right?

I'd phrase it as:

Add a new flag for struct dev_pagemap which specifies that a pagemap is
composed of a set of compound pages instead of individual pages.  When
these pages are initialised, most are initialised as tail pages
instead of order-0 pages.

> > For certain ZONE_DEVICE users, like device-dax, which have a fixed page
> > size, this creates an opportunity to optimize GUP and GUP-fast walkers,
> > thus playing the same tricks as hugetlb pages.

Rather than "playing the same tricks", how about "are treated the same
way as THP or hugetlb pages"?

> > +	if (pgmap->flags & PGMAP_COMPOUND)
> > +		percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
> > +			- pfn_first(pgmap, range_id)) / PHYS_PFN(pgmap->align));
> 
> Is there some reason that we cannot use range_len(), instead of pfn_end() minus
> pfn_first()? (Yes, this more about the pre-existing code than about your change.)
> 
> And if not, then why are the nearby range_len() uses OK? I realize that range_len()
> is simpler and skips a case, but it's not clear that it's required here. But I'm
> new to this area so be warned. :)
> 
> Also, dividing by PHYS_PFN() feels quite misleading: that function does what you
> happen to want, but is not named accordingly. Can you use or create something
> more accurately named? Like "number of pages in this large page"?

We have compound_nr(), but that takes a struct page as an argument.
We also have HPAGE_NR_PAGES.  I'm not quite clear what you want.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

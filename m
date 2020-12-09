Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE92D48AB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 19:14:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 47C74100EBBC6;
	Wed,  9 Dec 2020 10:14:20 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F263D100EBBBA
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lmGQgLGBhUH4rw9Xmb/x5bRo9Xb/oJgVLDZw+v+WbG8=; b=l4Gb5dTjEl4jTOb9r1drPUCMb8
	EI+DUBz5nXgVqQ4+RIF7b9wFOcdEn35oPB7MFeCOb7VB1aSQ2leMN1lcd82W/egzjAo8NcH0A9QJF
	uzNNWQ4W6dTGzgm13wTb6XkYE7FNeEaGgafZn051CMIixzlkO1dwkXq8pr8sh4pKgD5PW8T0OLWM4
	Lk2IXh1g22BWtZQoWLXIXXrYYh6hGsa1NzHMswvoerBibJq/IOx4zF2nXvB3PAkWlm6/Ll6B7N5Gq
	PRey6/BaANKDA+DyzKCUmcgqIehF9ghmad/JsbCQ6lklwoKB4mdCdbE5LbZJzr4F6wqsigaNzLHbd
	EF18VXjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn3yY-00080O-Qu; Wed, 09 Dec 2020 18:14:06 +0000
Date: Wed, 9 Dec 2020 18:14:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH RFC 6/9] mm/gup: Grab head page refcount once for group
 of subpages
Message-ID: <20201209181406.GQ7338@casper.infradead.org>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-8-joao.m.martins@oracle.com>
 <20201208194905.GQ5487@ziepe.ca>
 <b7f5fe44-f2f5-aea6-57b3-7e14a9ef624d@oracle.com>
 <20201209151505.GV5487@ziepe.ca>
 <a035661f-a979-c68b-d149-ef3892a5a1ea@oracle.com>
 <20201209162438.GW5487@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209162438.GW5487@ziepe.ca>
Message-ID-Hash: RMDC6LXC7VKQTLC3ABQ2IFBVQVOGKM3M
X-Message-ID-Hash: RMDC6LXC7VKQTLC3ABQ2IFBVQVOGKM3M
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RMDC6LXC7VKQTLC3ABQ2IFBVQVOGKM3M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 09, 2020 at 12:24:38PM -0400, Jason Gunthorpe wrote:
> On Wed, Dec 09, 2020 at 04:02:05PM +0000, Joao Martins wrote:
> 
> > Today (without the series) struct pages are not represented the way they
> > are expressed in the page tables, which is what I am hoping to fix in this
> > series thus initializing these as compound pages of a given order. But me
> > introducing PGMAP_COMPOUND was to conservatively keep both old (non-compound)
> > and new (compound pages) co-exist.
> 
> Oooh, that I didn't know.. That is kind of horrible to have a PMD
> pointing at an order 0 page only in this one special case.

Uh, yes.  I'm surprised it hasn't caused more problems.

> Still, I think it would be easier to teach record_subpages() that a
> PMD doesn't necessarily point to a high order page, eg do something
> like I suggested for the SGL where it extracts the page order and
> iterates over the contiguous range of pfns.

But we also see good performance improvements from doing all reference
counts on the head page instead of spread throughout the pages, so we
really want compound pages.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

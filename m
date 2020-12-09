Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0AA2D3CDB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 09:05:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AE61D100EB84C;
	Wed,  9 Dec 2020 00:05:57 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+e0880fbf4cc9d17ed03f+6317+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EDD5B100EBBB9
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 00:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4hfTv8EUe0KsPWmE2eRd4b2JnwYY+QPsnZBZ4Qx1KNs=; b=LlzutYCflnlSNZasF4C5o5YnzV
	xfQEjDBfr7n1d8JcX6HcuELmy0Pktq2arxGfWtnZvjaNuXebwhXC4U74OwkNl+r9AqglHmf9BM5ul
	lwcE/FI4gVsmvMVsTWfN388NoGSDYz4fP1stYwhMVyCPSPNOdn7vhmUuEatamxBttLu16IDA82vg/
	vq6o1uFcG8zP6nFljjB/SoOwNp9ZQ7/0EQMc27R7hoJCqVby7kNdA2gi2HEzBy03OvzfzDVWr6XOj
	IZIGPQTM/hFcPYSR3j+GZ8TL2l/GRsUQOOoD0avQDxPIJldmrXM4Wh0SLjjC5LMlQeZoKPxYsI78O
	DspufR7g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmuTj-0003sX-ET; Wed, 09 Dec 2020 08:05:39 +0000
Date: Wed, 9 Dec 2020 08:05:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH RFC 9/9] mm: Add follow_devmap_page() for devdax vmas
Message-ID: <20201209080539.GA12507@infradead.org>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-11-joao.m.martins@oracle.com>
 <20201208195754.GR5487@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208195754.GR5487@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: QAKSKWWI35BQUBG4GAN6VT73O3BB6IC7
X-Message-ID-Hash: QAKSKWWI35BQUBG4GAN6VT73O3BB6IC7
X-MailFrom: BATV+e0880fbf4cc9d17ed03f+6317+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QAKSKWWI35BQUBG4GAN6VT73O3BB6IC7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 08, 2020 at 03:57:54PM -0400, Jason Gunthorpe wrote:
> What we've talked about is changing the calling convention across all
> of this to something like:
> 
> struct gup_output {
>    struct page **cur;
>    struct page **end;
>    unsigned long vaddr;
>    [..]
> }
> 
> And making the manipulator like you saw for GUP common:
> 
> gup_output_single_page()
> gup_output_pages()
> 
> Then putting this eveywhere. This is the pattern that we ended up with
> in hmm_range_fault, and it seems to be working quite well.
> 
> fast/slow should be much more symmetric in code than they are today,
> IMHO.. I think those differences mainly exist because it used to be
> siloed in arch code. Some of the differences might be bugs, we've seen
> that a few times at least..

something like this:

http://git.infradead.org/users/hch/misc.git/commitdiff/c3d019802dbde5a4cc4160e7ec8ccba479b19f97

from this old and not fully working series:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/gup-bvec
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

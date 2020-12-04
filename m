Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B12CE6AE
	for <lists+linux-nvdimm@lfdr.de>; Fri,  4 Dec 2020 04:48:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E08F6100EC1F9;
	Thu,  3 Dec 2020 19:48:57 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 446E4100EF275
	for <linux-nvdimm@lists.01.org>; Thu,  3 Dec 2020 19:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OT2ToLvxm9ndZrO1bmPA6HE3oC3Xt6abE/tQXRQLEts=; b=jAo5OOywuNxNDCnoGaqkj6LsZQ
	Ozk6UNEBW9M3HIr4RqpVuqcuC8+RXowF3z/ChJamXyKDZPGryrkIHA/gZx8WRtDLFAo/4XmafgJSV
	1YIRVjEKJ0epCG1rb7SLiCIm55jPAebywdX7xoXEN0mt09oLfq5dO6107wG83qsunmWqq1Oo3DgC9
	Gh3UjDNQJq0TSIky5HUoOctUzrZHq5UVS5J11yzkRkjWhqggeHbWT1gAwDyfRVf4QnwPuOkR1mLyh
	ejQk4d0cz/5Zcd06RxNnsOadzubHqwgAAPxMqESrUOQOkzou+ztraS+Si+g8lgHz4iHUUBWucLllk
	K7HCev+g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kl25L-0002pU-3H; Fri, 04 Dec 2020 03:48:43 +0000
Date: Fri, 4 Dec 2020 03:48:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: PATCH] fs/dax: fix compile problem on parisc and mips
Message-ID: <20201204034843.GM11935@casper.infradead.org>
References: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
Message-ID-Hash: UHG5FSGMOB3G2GQCOWI5634ZWSWCKASU
X-Message-ID-Hash: UHG5FSGMOB3G2GQCOWI5634ZWSWCKASU
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UHG5FSGMOB3G2GQCOWI5634ZWSWCKASU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 03, 2020 at 04:33:10PM -0800, James Bottomley wrote:
> These platforms define PMD_ORDER in asm/pgtable.h

I think that's the real problem, though.

#define PGD_ORDER       1 /* Number of pages per pgd */
#define PMD_ORDER       1 /* Number of pages per pmd */
#define PGD_ALLOC_ORDER (2 + 1) /* first pgd contains pmd */
#else
#define PGD_ORDER       1 /* Number of pages per pgd */
#define PGD_ALLOC_ORDER (PGD_ORDER + 1)

That should clearly be PMD_ALLOC_ORDER, not PMD_ORDER.  Or even
PAGES_PER_PMD like the comment calls it, because I really think
that doing an order-3 (8 pages) allocation for the PGD is wrong.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

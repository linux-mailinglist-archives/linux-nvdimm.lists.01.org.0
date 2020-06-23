Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB68206716
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 00:18:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EA9DE10FC3C35;
	Tue, 23 Jun 2020 15:18:01 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 615B2100AA7BA
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3egdp4RVlEJCsjDBp+CYLL76S7TREvsG7dPXmZBA5+c=; b=qpCdw1i+WMeFgdZfl0ovqFf2XJ
	shChag/t7rhG6VuffsRfRpaO5X07EuN+hCKr4uMumxDZAcSuvyUYIzj6E41O3VKS9mMqiGBt28nTp
	hiErvx+ifVQp4UNmg1LY649irsHe7/R8OQ0E8EmlMn0HwzoCtferFlbTz6gFev03ZnnYc7ZcpeZn/
	c7VZ7Bk+NFU0MBBBrB+oMhi6F9/PpDpNOMzEbKXEG9dRSockejS+BfVWqOzaU8eJCfk+ZRVZJ7jl7
	FMvmyJF4p/sYKkqbGhXwgFBCtLxbnByi8GCyPWTvbCnDFP2MHvB0dh1UhLw38xigw4YVsr84bV/R8
	30sGdYOw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnrEb-0000ZF-H2; Tue, 23 Jun 2020 22:17:42 +0000
Date: Tue, 23 Jun 2020 23:17:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
Message-ID: <20200623221741.GH21350@casper.infradead.org>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
Message-ID-Hash: CHSOA5DKSOPMKZWW6AG6AXCPOABVD26J
X-Message-ID-Hash: CHSOA5DKSOPMKZWW6AG6AXCPOABVD26J
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-edac@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, "Darrick J. Wong" <darrick.wong@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CHSOA5DKSOPMKZWW6AG6AXCPOABVD26J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 23, 2020 at 03:04:12PM -0700, Luck, Tony wrote:
> On Tue, Jun 23, 2020 at 09:17:45PM +0100, Matthew Wilcox wrote:
> > Hardware actually tells us the blast radius of the error, but we ignore
> > it and take out the entire page.  We've had a customer request to know
> > exactly how much of the page is damaged so they can avoid reconstructing
> > an entire 2MB page if only a single cacheline is damaged.
> > 
> > This is only a strawman that I did in an hour or two; I'd appreciate
> > architectural-level feedback.  Should I just convert memory_failure() to
> > always take an address & granularity?  Should I create a struct to pass
> > around (page, phys, granularity) instead of reconstructing the missing
> > pieces in half a dozen functions?  Is this functionality welcome at all,
> > or is the risk of upsetting applications which expect at least a page
> > of granularity too high?
> 
> What is the interface to these applications that want finer granularity?
> 
> Current code does very poorly with hugetlbfs pages ... user loses the
> whole 2 MB or 1GB. That's just silly (though I've been told that it is
> hard to fix because allowing a hugetlbfs page to be broken up at an arbitrary
> time as the result of a mahcine check means that the kernel needs locking
> around a bunch of fas paths that currently assume that a huge page will
> stay being a huge page).
> 
> For sub-4K page usage, there are different problems. We can't leave the
> original page with the poisoned cache line mapped to the user as they may
> just access the poison data and trigger another machine check. But if we
> map in some different page with all the good bits copied, the user needs
> to be aware which parts of the page no longer have their data.

This is specifically for DAX.  The interface we were hoping to use to
fix the error is to leave the mapping in place and call

	fallocate(fd, FALLOC_FL_ZERO_RANGE, offset, len);

The application will then take care of writing actual data that isn't
zeroes to the file.  Or leave it as zeroes if that's what the application
wants to be its error indicator.

The fallocate path doesn't work quite right today, but there's no point
in trying to fix that up if we can't sort out the delivery of the actual
error range.

It might also be nice to have an madvise() MADV_ZERO option so the
application doesn't have to look up the fd associated with that memory
range, but we haven't floated that idea with the customer yet; I just
thought of it now.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

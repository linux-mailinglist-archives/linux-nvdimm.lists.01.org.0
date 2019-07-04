Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B05F97E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jul 2019 15:58:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E2CA212B0817;
	Thu,  4 Jul 2019 06:58:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C80DD212B0811
 for <linux-nvdimm@lists.01.org>; Thu,  4 Jul 2019 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/RLAY7zRxS6FP4wLWk1a+mxOsYYdecRt8hhGgB9GW4M=; b=nf1/g8o8E65eZqwz1hsFwCPcU
 MBhwLZirPk/vxTpaggeMfdAROG8JpB00Rj6iiyRqEOQApcd1+J/mLDVIXT4EV/PuEYg2phrQHywIQ
 9bztNfHZywQ2ABH4jnMjnJ8vuukFS0jb4MSlY0QCLjMraK2KjUDTM7z0J5ilmg8poMPmJ9SXKwzmh
 iQKIP77O6i2PNUBBSwUR7QvppXdrJTr4lRMqEVBgd/OaM7fy/QdHnSAcGafKBFvF1TOK9I+R0vvId
 b2s9evEN1sD+tCOKAqNbdSzQHl+EVFwGBqM6BgNQzCRhbVR0Zu9hKIPbPsCXsgrGUNKfGuwBO7sEe
 xNz/Er2kQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hj2FQ-0002ZJ-Vt; Thu, 04 Jul 2019 13:58:04 +0000
Date: Thu, 4 Jul 2019 06:58:04 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Boaz Harrosh <openosd@gmail.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
Message-ID: <20190704135804.GL1729@bombadil.infradead.org>
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
 <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org>
 <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
 <f23a1c71-d1b1-b279-c922-ce0f48cb4448@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f23a1c71-d1b1-b279-c922-ce0f48cb4448@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Seema Pandit <seema.pandit@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jul 04, 2019 at 04:00:00PM +0300, Boaz Harrosh wrote:
> On 04/07/2019 06:27, Matthew Wilcox wrote:
> > On Wed, Jul 03, 2019 at 02:28:41PM -0700, Dan Williams wrote:
> >>> +#ifdef CONFIG_XARRAY_MULTI
> >>> +       unsigned int sibs = xas->xa_sibs;
> >>> +
> >>> +       while (sibs) {
> >>> +               order++;
> >>> +               sibs /= 2;
> >>> +       }
> >>
> >> Use ilog2() here?
> > 
> > Thought about it.  sibs is never going to be more than 31, so I don't
> > know that it's worth eliminating 5 add/shift pairs in favour of whatever
> > the ilog2 instruction is on a given CPU.  In practice, on x86, sibs is
> > going to be either 0 (PTEs) or 7 (PMDs).  We could also avoid even having
> > this function by passing PMD_ORDER or PTE_ORDER into get_unlocked_entry().
> > 
> > It's probably never going to be noticable in this scenario because it's
> > the very last thing checked before we put ourselves on a waitqueue and
> > go to sleep.
> 
> Matthew you must be kidding an ilog2 in binary is zero clocks
> (Return the highest bit or something like that)

You might want to actually check the documentation instead of just
making shit up.

https://www.agner.org/optimize/instruction_tables.pdf

I think in this instance what we want is BSR (aka ffz) since the input is
going to be one of 0, 1, 3, 7, 15 or 31 (and we want 0, 1, 2, 3, 4, 5 as
results).

> In any way. It took me 5 minutes to understand what you are doing
> here. And I only fully got it when Dan gave his comment. So please for
> the sake of stupid guys like me could you please make it ilog2() so
> to make it easier to understand?
> (And please don't do the compiler's job. If in some arch the loop
>  is the fastest let the compiler decide?)

The compiler doesn't know the range of 'sibs'.  Unless we do the
profile-feedback thing.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

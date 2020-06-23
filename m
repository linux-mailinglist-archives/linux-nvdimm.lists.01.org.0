Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783B72066CE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 00:04:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DBD4D100978D9;
	Tue, 23 Jun 2020 15:04:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=tony.luck@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4CF6010112D6F
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 15:04:14 -0700 (PDT)
IronPort-SDR: U9kv5chmiQUqqkGERxmi9CujktzHSVnEAxE7LOog2Ax+ZEPEOv92a7E8yn/pWCesAUYOVhCmul
 QUzoHVNYx4SA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="144275920"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800";
   d="scan'208";a="144275920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 15:04:13 -0700
IronPort-SDR: U6/VHjLAHIDc7wJRSFOh4hSGDw0bnpwNPm+jz2L51Xa0Aqu/d+FkkroMJB2muFI0l5naqfsMkJ
 WAGdzb25lOxA==
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800";
   d="scan'208";a="478904509"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 15:04:13 -0700
Date: Tue, 23 Jun 2020 15:04:12 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] Make the memory failure blast radius more precise
Message-ID: <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
References: <20200623201745.GG21350@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200623201745.GG21350@casper.infradead.org>
Message-ID-Hash: F3VU6STVQCH77WKKC3X5ANCPHJS4NW6V
X-Message-ID-Hash: F3VU6STVQCH77WKKC3X5ANCPHJS4NW6V
X-MailFrom: tony.luck@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-edac@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, "Darrick J. Wong" <darrick.wong@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F3VU6STVQCH77WKKC3X5ANCPHJS4NW6V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 23, 2020 at 09:17:45PM +0100, Matthew Wilcox wrote:
> 
> Hardware actually tells us the blast radius of the error, but we ignore
> it and take out the entire page.  We've had a customer request to know
> exactly how much of the page is damaged so they can avoid reconstructing
> an entire 2MB page if only a single cacheline is damaged.
> 
> This is only a strawman that I did in an hour or two; I'd appreciate
> architectural-level feedback.  Should I just convert memory_failure() to
> always take an address & granularity?  Should I create a struct to pass
> around (page, phys, granularity) instead of reconstructing the missing
> pieces in half a dozen functions?  Is this functionality welcome at all,
> or is the risk of upsetting applications which expect at least a page
> of granularity too high?

What is the interface to these applications that want finer granularity?

Current code does very poorly with hugetlbfs pages ... user loses the
whole 2 MB or 1GB. That's just silly (though I've been told that it is
hard to fix because allowing a hugetlbfs page to be broken up at an arbitrary
time as the result of a mahcine check means that the kernel needs locking
around a bunch of fas paths that currently assume that a huge page will
stay being a huge page).

For sub-4K page usage, there are different problems. We can't leave the
original page with the poisoned cache line mapped to the user as they may
just access the poison data and trigger another machine check. But if we
map in some different page with all the good bits copied, the user needs
to be aware which parts of the page no longer have their data.

-Tony
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

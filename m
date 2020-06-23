Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534F220672C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 00:27:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C5C210FC3C35;
	Tue, 23 Jun 2020 15:27:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=tony.luck@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CBD6910FC38BC
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 15:27:01 -0700 (PDT)
IronPort-SDR: fzj6VtHKTTdWExXXfTIyeW98bZHx1fKCIHcB6mhbBU0vUFvf7zN4B0QbF8qRBPiZwAQRoXTO7U
 XlbFClt/YKrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="131656674"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800";
   d="scan'208";a="131656674"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 15:27:00 -0700
IronPort-SDR: KivnWswfxnKY5P1q74x/ixCXTK2rkkNhH6XanVYnObNm5mLI9agHtMWJH61xmoW0H6+WKH/5At
 LcGyHppLm1kA==
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800";
   d="scan'208";a="452411863"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 15:27:00 -0700
Date: Tue, 23 Jun 2020 15:26:58 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] Make the memory failure blast radius more precise
Message-ID: <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200623221741.GH21350@casper.infradead.org>
Message-ID-Hash: 6P5YXT75GJ6I4PV3A66JKEFYEUWN3PMP
X-Message-ID-Hash: 6P5YXT75GJ6I4PV3A66JKEFYEUWN3PMP
X-MailFrom: tony.luck@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-edac@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, "Darrick J. Wong" <darrick.wong@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6P5YXT75GJ6I4PV3A66JKEFYEUWN3PMP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 23, 2020 at 11:17:41PM +0100, Matthew Wilcox wrote:
> It might also be nice to have an madvise() MADV_ZERO option so the
> application doesn't have to look up the fd associated with that memory
> range, but we haven't floated that idea with the customer yet; I just
> thought of it now.

So the conversation between OS and kernel goes like this?

1) machine check
2) Kernel unmaps the 4K page surroundinng the poison and sends
   SIGBUS to the application to say that one cache line is gone
3) App says madvise(MADV_ZERO, that cache line)
4) Kernel says ... "oh, you know how to deal with this" and allocates
   a new page, copying the 63 good cache lines from the old page and
   zeroing the missing one. New page is mapped to user.

Do you have folks lined up to use that?  I don't know that many
folks are even catching the SIGBUS :-(

-Tony
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

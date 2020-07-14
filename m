Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640B21FDBF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 21:49:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7AB3911812921;
	Tue, 14 Jul 2020 12:49:42 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8BECE1167EB2C
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q7NrJBulspMdgxi2cducPGZ39YVyw0D0jNEe7CHNFek=; b=pR+q0ltz9wN4EMOYLJfOx0i96Z
	fflfRrIqJ/FjDcRjkjnXWWtoHOwwXb5VsxdrGuZS+CvUr+oUVlTyCv7gRGycAnTBa73nx/ZZzxraY
	82iJarBVL45tJXSN9iBukFBmkrK9TjFwkyynR9lgHVj3P/pTN95GAdES3IngOKWCc/IT/AJeExrws
	B1iS+MFHhiV2wqkcQPS+4cu4PIVmyzJ5wPbo1+MD1rYtVpUtTpPR4NAyL3Qe+F1StOpbl5ZlMwm/d
	zltUaTYbLueeel/jU/1kBjn+57c1OiyIkuqs9kUC5wGlwJjyFjRHU5uwW598uj7Fo2AqOiGYpCTQs
	STKoB0Qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvQva-0008SY-R4; Tue, 14 Jul 2020 19:49:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA5909817E0; Tue, 14 Jul 2020 21:49:21 +0200 (CEST)
Date: Tue, 14 Jul 2020 21:49:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 12/15] kmap: Add stray write protection for device
 pages
Message-ID: <20200714194921.GJ5523@worktop.programming.kicks-ass.net>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-13-ira.weiny@intel.com>
 <20200714084451.GQ10769@hirez.programming.kicks-ass.net>
 <20200714190615.GC3008823@iweiny-DESK2.sc.intel.com>
 <20200714192930.GH5523@worktop.programming.kicks-ass.net>
 <50d472d8-e4d9-dd35-f31f-268aa69c76e2@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50d472d8-e4d9-dd35-f31f-268aa69c76e2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: AMR4XXOQ2JUHOCHRBTDRPMZM5BLZPU3O
X-Message-ID-Hash: AMR4XXOQ2JUHOCHRBTDRPMZM5BLZPU3O
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AMR4XXOQ2JUHOCHRBTDRPMZM5BLZPU3O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 14, 2020 at 12:42:11PM -0700, Dave Hansen wrote:
> On 7/14/20 12:29 PM, Peter Zijlstra wrote:
> > On Tue, Jul 14, 2020 at 12:06:16PM -0700, Ira Weiny wrote:
> >> On Tue, Jul 14, 2020 at 10:44:51AM +0200, Peter Zijlstra wrote:
> >>> So, if I followed along correctly, you're proposing to do a WRMSR per
> >>> k{,un}map{_atomic}(), sounds like excellent performance all-round :-(
> >> Only to pages which have this additional protection, ie not DRAM.
> >>
> >> User mappings of this memory is not affected (would be covered by User PKeys if
> >> desired).  User mappings to persistent memory are the primary use case and the
> >> performant path.
> > Because performance to non-volatile memory doesn't matter? I think Dave
> > has a better answer here ...
> 
> So, these WRMSRs are less evil than normal.  They're architecturally
> non-serializing instructions,

Excellent, that should make these a fair bit faster than regular MSRs.

> But, either way, this *will* make accessing PMEM more expensive from the
> kernel.  No escaping that. 

There's no free lunch, it's just that regular MSRs are fairly horrible.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

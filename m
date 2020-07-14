Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A401221FC08
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 21:06:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70D3A116BF620;
	Tue, 14 Jul 2020 12:06:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 05A13116BF61C
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 12:06:16 -0700 (PDT)
IronPort-SDR: fPFGtQJPmOOJJOt3yHS7DZIYDE1zj7SgrH8P0v7m2l9EX35fwuCA9GubniwewsVSUo3w7UvQ17
 l/hT4SxEOt3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="137143188"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800";
   d="scan'208";a="137143188"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 12:06:16 -0700
IronPort-SDR: 372ah54Muur1nzmIJ6WpFVvasq6EKc/XBygmqwb4njk9NqFeHdl/Vb7u58xf0Grd72pTvNiTPg
 ndEouPAOrQ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800";
   d="scan'208";a="324632815"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2020 12:06:16 -0700
Date: Tue, 14 Jul 2020 12:06:16 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 12/15] kmap: Add stray write protection for device
 pages
Message-ID: <20200714190615.GC3008823@iweiny-DESK2.sc.intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-13-ira.weiny@intel.com>
 <20200714084451.GQ10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714084451.GQ10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 3FO3AYA45NMLBSJ72QOE6YVREAU7N53M
X-Message-ID-Hash: 3FO3AYA45NMLBSJ72QOE6YVREAU7N53M
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3FO3AYA45NMLBSJ72QOE6YVREAU7N53M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 14, 2020 at 10:44:51AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 14, 2020 at 12:02:17AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Device managed pages may have additional protections.  These protections
> > need to be removed prior to valid use by kernel users.
> > 
> > Check for special treatment of device managed pages in kmap and take
> > action if needed.  We use kmap as an interface for generic kernel code
> > because under normal circumstances it would be a bug for general kernel
> > code to not use kmap prior to accessing kernel memory.  Therefore, this
> > should allow any valid kernel users to seamlessly use these pages
> > without issues.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  include/linux/highmem.h | 32 +++++++++++++++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> > index d6e82e3de027..7f809d8d5a94 100644
> > --- a/include/linux/highmem.h
> > +++ b/include/linux/highmem.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/hardirq.h>
> > +#include <linux/memremap.h>
> >  
> >  #include <asm/cacheflush.h>
> >  
> > @@ -31,6 +32,20 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> >  
> >  #include <asm/kmap_types.h>
> >  
> > +static inline void enable_access(struct page *page)
> > +{
> > +	if (!page_is_access_protected(page))
> > +		return;
> > +	dev_access_enable();
> > +}
> > +
> > +static inline void disable_access(struct page *page)
> > +{
> > +	if (!page_is_access_protected(page))
> > +		return;
> > +	dev_access_disable();
> > +}
> 
> So, if I followed along correctly, you're proposing to do a WRMSR per
> k{,un}map{_atomic}(), sounds like excellent performance all-round :-(

Only to pages which have this additional protection, ie not DRAM.

User mappings of this memory is not affected (would be covered by User PKeys if
desired).  User mappings to persistent memory are the primary use case and the
performant path.

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

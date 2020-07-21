Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7C12285B6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 18:31:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A856B1235CFE4;
	Tue, 21 Jul 2020 09:31:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AF0C41235CFE3
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 09:31:52 -0700 (PDT)
IronPort-SDR: JUTR08ZO/bBSgTNWOAmrj5Mlf3+zK8rn4TzJdPRdT8TUAPlAHpoS8Yg0sV6rOq+xvnEkMRyWbg
 LQRFPBNrlkcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="235032413"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800";
   d="scan'208";a="235032413"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 09:31:52 -0700
IronPort-SDR: QIqyg569mkeyzGevueJJ0WqfJG1wbbgWKT8l7gfSm5T3TqYGXngLSHY7sbeaPpwcZZol3ESKK7
 P6/eMlyR/hZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800";
   d="scan'208";a="270482086"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2020 09:31:52 -0700
Date: Tue, 21 Jul 2020 09:31:52 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V2 13/17] kmap: Add stray write protection for device
 pages
Message-ID: <20200721163151.GA643353@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-14-ira.weiny@intel.com>
 <20200717092139.GC10769@hirez.programming.kicks-ass.net>
 <20200719041319.GA478573@iweiny-DESK2.sc.intel.com>
 <20200720091740.GP10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200720091740.GP10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: RLOKKRKL34DFKT4PX2XEYGMIK6TSOW5K
X-Message-ID-Hash: RLOKKRKL34DFKT4PX2XEYGMIK6TSOW5K
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RLOKKRKL34DFKT4PX2XEYGMIK6TSOW5K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2020 at 11:17:40AM +0200, Peter Zijlstra wrote:
> On Sat, Jul 18, 2020 at 09:13:19PM -0700, Ira Weiny wrote:
> > On Fri, Jul 17, 2020 at 11:21:39AM +0200, Peter Zijlstra wrote:
> > > On Fri, Jul 17, 2020 at 12:20:52AM -0700, ira.weiny@intel.com wrote:
> > > > @@ -31,6 +32,20 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> > > >  
> > > >  #include <asm/kmap_types.h>
> > > >  
> > > > +static inline void enable_access(struct page *page)
> > > > +{
> > > > +	if (!page_is_access_protected(page))
> > > > +		return;
> > > > +	dev_access_enable();
> > > > +}
> > > > +
> > > > +static inline void disable_access(struct page *page)
> > > > +{
> > > > +	if (!page_is_access_protected(page))
> > > > +		return;
> > > > +	dev_access_disable();
> > > > +}
> > > 
> > > These are some very generic names, do we want them to be a little more
> > > specific?
> > 
> > I had them named kmap_* but Dave (I think it was Dave) thought they did not
> > really apply strictly to kmap_*.
> > 
> > They are static to this file which I thought may be sufficient to 'uniqify'
> > them?
> 
> They're static to a .h, which means they're all over the place ;-)

I've thought about it a bit.  I think I agree with both you and Dave.

How about:

dev_page_{en,dis}able_access()

??

I've made that change for now.

Thanks,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

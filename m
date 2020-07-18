Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD5D22491A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Jul 2020 07:51:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2B2DB12021BCE;
	Fri, 17 Jul 2020 22:51:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 59FB4116C0805
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 22:51:05 -0700 (PDT)
IronPort-SDR: 8HF7DKubAco/oCh4kIuP4+ZrYx0BYap5vIXKTQnJv5SfHFG0WOpYJkggXfYamSQ4nd8j8KyGlN
 yw+SVDtSsCag==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="129798717"
X-IronPort-AV: E=Sophos;i="5.75,365,1589266800";
   d="scan'208";a="129798717"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 22:51:04 -0700
IronPort-SDR: Bc8yS/Mga/P/JELyDS9maVNQZIck4wfEmlGO3VkOyOrNQb8SVgJAdVZL/lTq/KBuOwtXK2wrMt
 piSYLWsQeJ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,365,1589266800";
   d="scan'208";a="282993538"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2020 22:51:04 -0700
Date: Fri, 17 Jul 2020 22:51:03 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V2 12/17] memremap: Add zone device access protection
Message-ID: <20200718055103.GU3008823@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-13-ira.weiny@intel.com>
 <20200717091718.GA10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717091718.GA10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: GYGTICOCBNW3DRKT27RXBHXXXPUOKNYD
X-Message-ID-Hash: GYGTICOCBNW3DRKT27RXBHXXXPUOKNYD
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GYGTICOCBNW3DRKT27RXBHXXXPUOKNYD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 11:17:18AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:51AM -0700, ira.weiny@intel.com wrote:
> > +void dev_access_disable(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	if (!static_branch_unlikely(&dev_protection_static_key))
> > +		return;
> > +
> > +	local_irq_save(flags);
> > +	current->dev_page_access_ref--;
> > +	if (current->dev_page_access_ref == 0)
> 
> 	if (!--current->dev_page_access_ref)

It's not my style but I'm ok with it.

> 
> > +		pks_update_protection(dev_page_pkey, PKEY_DISABLE_ACCESS);
> > +	local_irq_restore(flags);
> > +}
> > +EXPORT_SYMBOL_GPL(dev_access_disable);
> > +
> > +void dev_access_enable(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	if (!static_branch_unlikely(&dev_protection_static_key))
> > +		return;
> > +
> > +	local_irq_save(flags);
> > +	/* 0 clears the PKEY_DISABLE_ACCESS bit, allowing access */
> > +	if (current->dev_page_access_ref == 0)
> > +		pks_update_protection(dev_page_pkey, 0);
> > +	current->dev_page_access_ref++;
> 
> 	if (!current->dev_page_access_ref++)

Sure.

> 
> > +	local_irq_restore(flags);
> > +}
> > +EXPORT_SYMBOL_GPL(dev_access_enable);
> 
> 
> Also, you probably want something like:
> 
> static __always_inline devm_access_disable(void)

Yes that is better.

However, again Dan and I agree devm is not the right prefix here.

I've updated.

Thanks!
Ira

> {
> 	if (static_branch_unlikely(&dev_protection_static_key))
> 		__devm_access_disable();
> }
> 
> static __always_inline devm_access_enable(void)
> {
> 	if (static_branch_unlikely(&dev_protection_static_key))
> 		__devm_access_enable();
> }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

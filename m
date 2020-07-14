Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE121FCA1
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 21:10:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E9DBD116BF62B;
	Tue, 14 Jul 2020 12:10:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8898B116BF62A
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 12:10:48 -0700 (PDT)
IronPort-SDR: nJ4nGdD5EYccYTv3EL2yLtto77FhbKn2hTaiO3x92vhGnZAHaq5s+ds9HCBJeY318QlzcguCWa
 MWZSQrUJQ/BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="210552138"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800";
   d="scan'208";a="210552138"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 12:10:48 -0700
IronPort-SDR: ynd6Lt5TNvbdI+beUCIxuy6WUQInSo1MvaulrgHmRMdJk8pzs6c5iZa/GKm6K4HDRY3ph5QM5F
 8i7mRSpTTt1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800";
   d="scan'208";a="390568284"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jul 2020 12:10:47 -0700
Date: Tue, 14 Jul 2020 12:10:47 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 11/15] memremap: Add zone device access protection
Message-ID: <20200714191047.GE3008823@iweiny-DESK2.sc.intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-12-ira.weiny@intel.com>
 <20200714084057.GP10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714084057.GP10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: GFWI5ALXODRWDLXSVV6PUDHRGE3JUMUA
X-Message-ID-Hash: GFWI5ALXODRWDLXSVV6PUDHRGE3JUMUA
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GFWI5ALXODRWDLXSVV6PUDHRGE3JUMUA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 14, 2020 at 10:40:57AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 14, 2020 at 12:02:16AM -0700, ira.weiny@intel.com wrote:
> 
> > +static pgprot_t dev_protection_enable_get(struct dev_pagemap *pgmap, pgprot_t prot)
> > +{
> > +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> > +		pgprotval_t val = pgprot_val(prot);
> > +
> > +		mutex_lock(&dev_prot_enable_lock);
> > +		dev_protection_enable++;
> > +		/* Only enable the static branch 1 time */
> > +		if (dev_protection_enable == 1)
> > +			static_branch_enable(&dev_protection_static_key);
> > +		mutex_unlock(&dev_prot_enable_lock);
> > +
> > +		prot = __pgprot(val | _PAGE_PKEY(dev_page_pkey));
> > +	}
> > +	return prot;
> > +}
> > +
> > +static void dev_protection_enable_put(struct dev_pagemap *pgmap)
> > +{
> > +	if (pgmap->flags & PGMAP_PROT_ENABLED && dev_page_pkey != PKEY_INVALID) {
> > +		mutex_lock(&dev_prot_enable_lock);
> > +		dev_protection_enable--;
> > +		if (dev_protection_enable == 0)
> > +			static_branch_disable(&dev_protection_static_key);
> > +		mutex_unlock(&dev_prot_enable_lock);
> > +	}
> > +}
> 
> That's an anti-pattern vs static_keys, I'm thinking you actually want
> static_key_slow_{inc,dec}() instead of {enable,disable}().

Thanks.  I'll go read the doc for those as I'm not familiar with them.

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

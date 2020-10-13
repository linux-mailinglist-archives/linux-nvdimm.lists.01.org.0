Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528528D73A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Oct 2020 01:57:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5AE1B15E58960;
	Tue, 13 Oct 2020 16:57:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 46A9A15E58047
	for <linux-nvdimm@lists.01.org>; Tue, 13 Oct 2020 16:57:01 -0700 (PDT)
IronPort-SDR: ZgPhv/YajyBADeA8SLXIny/A5qoxyAdiWTP5WH/N/TeHnWpTEcWlY5LNGrcDzjgccTSC5kNtPJ
 ZSFRVXn1dcEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="183498630"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400";
   d="scan'208";a="183498630"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 16:57:00 -0700
IronPort-SDR: lCvdsHw4cNTMWJa/vna7fQPxd5RyrFTF13wYh2AkHf4SXv0mM4ELq6g5e3ZAT7t1A0eXxCnwi8
 qz1MFAWCB0PA==
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400";
   d="scan'208";a="463687969"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 16:56:59 -0700
Date: Tue, 13 Oct 2020 16:56:59 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V3 2/9] x86/fpu: Refactor arch_set_user_pkey_access()
 for PKS support
Message-ID: <20201013235658.GL2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-3-ira.weiny@intel.com>
 <7ed91cb5-93e5-67ad-ad35-8489d16d283f@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7ed91cb5-93e5-67ad-ad35-8489d16d283f@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: SA5LKRYHRP3MW7TFYFXLK2OVLVTL6MO4
X-Message-ID-Hash: SA5LKRYHRP3MW7TFYFXLK2OVLVTL6MO4
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SA5LKRYHRP3MW7TFYFXLK2OVLVTL6MO4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 10:50:05AM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> > +/*
> > + * Update the pk_reg value and return it.
> 
> How about:
> 
> 	Replace disable bits for @pkey with values from @flags.

Done.

> 
> > + * Kernel users use the same flags as user space:
> > + *     PKEY_DISABLE_ACCESS
> > + *     PKEY_DISABLE_WRITE
> > + */
> > +u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
> > +{
> > +	int pkey_shift = pkey * PKR_BITS_PER_PKEY;
> > +
> > +	pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);
> > +
> > +	if (flags & PKEY_DISABLE_ACCESS)
> > +		pk_reg |= PKR_AD_BIT << pkey_shift;
> > +	if (flags & PKEY_DISABLE_WRITE)
> > +		pk_reg |= PKR_WD_BIT << pkey_shift;
> 
> I still think this deserves two lines of comments:
> 
> 	/* Mask out old bit values */
> 
> 	/* Or in new values */

Sure, done.
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

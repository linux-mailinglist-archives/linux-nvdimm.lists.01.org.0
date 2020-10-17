Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA6E290EA1
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Oct 2020 05:32:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 496001577DEFC;
	Fri, 16 Oct 2020 20:32:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8282D1577DEFB
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 20:32:05 -0700 (PDT)
IronPort-SDR: GyIPods/KT1UkyoqiZzRWmFKEb5oOp1YAHIsf1zq6GeTLw3D0RkViPYG9RSR5RiXY1Y86E9PxW
 ks3QAPfp2g5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="166856166"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400";
   d="scan'208";a="166856166"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 20:32:03 -0700
IronPort-SDR: kvyfzP2MmHEewAuij6J97fqoPkF27+6ntcl4pUo67Y0ey7WhiD8GVW1pnB6mjR8DSQp0w+kBVn
 R3ZScB5JlEAA==
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400";
   d="scan'208";a="521393708"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 20:32:03 -0700
Date: Fri, 16 Oct 2020 20:32:03 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V3 2/9] x86/fpu: Refactor arch_set_user_pkey_access()
 for PKS support
Message-ID: <20201017033202.GV2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-3-ira.weiny@intel.com>
 <20201016105743.GK2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016105743.GK2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: FXK3KRYGOUZDINKDX3DHOYXZ3SFVYUNN
X-Message-ID-Hash: FXK3KRYGOUZDINKDX3DHOYXZ3SFVYUNN
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FXK3KRYGOUZDINKDX3DHOYXZ3SFVYUNN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2020 at 12:57:43PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 12:42:51PM -0700, ira.weiny@intel.com wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > Define a helper, update_pkey_val(), which will be used to support both
> > Protection Key User (PKU) and the new Protection Key for Supervisor
> > (PKS) in subsequent patches.
> > 
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> >  arch/x86/include/asm/pkeys.h |  2 ++
> >  arch/x86/kernel/fpu/xstate.c | 22 ++++------------------
> >  arch/x86/mm/pkeys.c          | 21 +++++++++++++++++++++
> >  3 files changed, 27 insertions(+), 18 deletions(-)
> 
> This is not from Fenghua.
> 
>   https://lkml.kernel.org/r/20200717085442.GX10769@hirez.programming.kicks-ass.net
> 
> This is your patch based on the code I wrote.

Ok, I apologize.  Yes the code below was all yours.

Is it ok to add?

Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>

?

Thanks,
Ira

> 
> > diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> > index f5efb4007e74..3cf8f775f36d 100644
> > --- a/arch/x86/mm/pkeys.c
> > +++ b/arch/x86/mm/pkeys.c
> > @@ -208,3 +208,24 @@ static __init int setup_init_pkru(char *opt)
> >  	return 1;
> >  }
> >  __setup("init_pkru=", setup_init_pkru);
> > +
> > +/*
> > + * Update the pk_reg value and return it.
> > + *
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
> > +
> > +	return pk_reg;
> > +}
> > -- 
> > 2.28.0.rc0.12.gb6a658bd00c9
> > 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

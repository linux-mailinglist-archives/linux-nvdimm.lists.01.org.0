Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05815290F6A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Oct 2020 07:37:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4190715CAD5C6;
	Fri, 16 Oct 2020 22:37:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5046015CAD5C4
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 22:37:35 -0700 (PDT)
IronPort-SDR: qxllmEbw+SboATGoEsRL8TGG8csOBXwl/pcjVEGzYHYDZy4dBg2sRCUc9/NZeh8uO1DFfPo6vO
 DQF8hLAGrGZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="163282082"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400";
   d="scan'208";a="163282082"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:37:34 -0700
IronPort-SDR: Ty1fM6Vbx2+YqgAFSfiZo7vOUTz9OdV+8hAXKYG3AIQEYKvwVWfnceXqF2oJSEM79KD2hC0opy
 pucoh92Qu6uQ==
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400";
   d="scan'208";a="531984870"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:37:33 -0700
Date: Fri, 16 Oct 2020 22:37:33 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201017053733.GA3702775@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
 <20201016110636.GL2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016110636.GL2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: WL655S4WZDFUPUUYVZ5ZWBM5YXKPLQ5J
X-Message-ID-Hash: WL655S4WZDFUPUUYVZ5ZWBM5YXKPLQ5J
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WL655S4WZDFUPUUYVZ5ZWBM5YXKPLQ5J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2020 at 01:06:36PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 12:42:53PM -0700, ira.weiny@intel.com wrote:
> 
> > @@ -644,6 +663,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
> >  
> >  	if ((tifp ^ tifn) & _TIF_SLD)
> >  		switch_to_sld(tifn);
> > +
> > +	pks_sched_in();
> >  }
> >  
> 
> You seem to have lost the comment proposed here:
> 
>   https://lkml.kernel.org/r/20200717083140.GW10769@hirez.programming.kicks-ass.net
> 
> It is useful and important information that the wrmsr normally doesn't
> happen.

Added back in here.

> 
> > diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> > index 3cf8f775f36d..30f65dd3d0c5 100644
> > --- a/arch/x86/mm/pkeys.c
> > +++ b/arch/x86/mm/pkeys.c
> > @@ -229,3 +229,31 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
> >  
> >  	return pk_reg;
> >  }
> > +
> > +DEFINE_PER_CPU(u32, pkrs_cache);
> > +
> > +/**
> > + * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
> > + * serializing but still maintains ordering properties similar to WRPKRU.
> > + * The current SDM section on PKRS needs updating but should be the same as
> > + * that of WRPKRU.  So to quote from the WRPKRU text:
> > + *
> > + * 	WRPKRU will never execute transiently. Memory accesses
> > + * 	affected by PKRU register will not execute (even transiently)
> > + * 	until all prior executions of WRPKRU have completed execution
> > + * 	and updated the PKRU register.
> 
> (whitespace damage; space followed by tabstop)

Fixed thanks.

> 
> > + */
> > +void write_pkrs(u32 new_pkrs)
> > +{
> > +	u32 *pkrs;
> > +
> > +	if (!static_cpu_has(X86_FEATURE_PKS))
> > +		return;
> > +
> > +	pkrs = get_cpu_ptr(&pkrs_cache);
> > +	if (*pkrs != new_pkrs) {
> > +		*pkrs = new_pkrs;
> > +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
> > +	}
> > +	put_cpu_ptr(pkrs);
> > +}
> 
> looks familiar that... :-)

Added you as a co-developer if that is ok?

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

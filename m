Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0BE28E8CE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Oct 2020 00:36:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F39E91594D307;
	Wed, 14 Oct 2020 15:36:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5387C1594D305
	for <linux-nvdimm@lists.01.org>; Wed, 14 Oct 2020 15:36:48 -0700 (PDT)
IronPort-SDR: lvhz+RqRpy7kU2IwGE4lQdz+a3hS0L+BIrhfrBj14lhGMMSdc8avhPVRIDikAGkXofjC5E0fWd
 yhsMB4xr00EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="250902095"
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400";
   d="scan'208";a="250902095"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 15:36:47 -0700
IronPort-SDR: hlP7s+Gr/Rc5V3W88BvFKe6EIiWdd3DK6aubfzWryOw3NIX1vtjOIln2dH/BqVvMF6khwk9JWw
 v4tFUtvP1LbA==
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400";
   d="scan'208";a="531020083"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 15:36:42 -0700
Date: Wed, 14 Oct 2020 15:36:42 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201014223642.GN2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
 <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: H4Y5NYIVLF5LBZO6TLO2SOY5WWNW5FOD
X-Message-ID-Hash: H4Y5NYIVLF5LBZO6TLO2SOY5WWNW5FOD
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H4Y5NYIVLF5LBZO6TLO2SOY5WWNW5FOD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 11:31:45AM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The PKRS MSR is defined as a per-logical-processor register.  This
> > isolates memory access by logical CPU.  Unfortunately, the MSR is not
> > managed by XSAVE.  Therefore, tasks must save/restore the MSR value on
> > context switch.
> > 
> > Define a saved PKRS value in the task struct, as well as a cached
> > per-logical-processor MSR value which mirrors the MSR value of the
> > current CPU.  Initialize all tasks with the default MSR value.  Then, on
> > schedule in, check the saved task MSR vs the per-cpu value.  If
> > different proceed to write the MSR.  If not avoid the overhead of the
> > MSR write and continue.
> 
> It's probably nice to note how the WRMSR is special here, in addition to
> the comments below.

Sure,

> 
> >  #endif /*_ASM_X86_PKEYS_INTERNAL_H */
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 97143d87994c..da2381136b2d 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -18,6 +18,7 @@ struct vm86;
> >  #include <asm/cpufeatures.h>
> >  #include <asm/page.h>
> >  #include <asm/pgtable_types.h>
> > +#include <asm/pkeys_common.h>
> >  #include <asm/percpu.h>
> >  #include <asm/msr.h>
> >  #include <asm/desc_defs.h>
> > @@ -542,6 +543,11 @@ struct thread_struct {
> >  
> >  	unsigned int		sig_on_uaccess_err:1;
> >  
> > +#ifdef	CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > +	/* Saved Protection key register for supervisor mappings */
> > +	u32			saved_pkrs;
> > +#endif
> 
> Could you take a look around thread_struct and see if there are some
> other MSRs near which you can stash this?  This seems like a bit of a
> lonely place.

Are you more concerned with aesthetics or the in memory struct layout?

How about I put it after error_code?

	unsigned long           error_code;                                     
+                                                                               
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS                                        
+       /* Saved Protection key register for supervisor mappings */             
+       u32                     saved_pkrs;                                     
+#endif                                                                         
+                                                                               

?

> 
> ...
> >  void flush_thread(void)
> >  {
> >  	struct task_struct *tsk = current;
> > @@ -195,6 +212,8 @@ void flush_thread(void)
> >  	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
> >  
> >  	fpu__clear_all(&tsk->thread.fpu);
> > +
> > +	pks_init_task(tsk);
> >  }
> >  
> >  void disable_TSC(void)
> > @@ -644,6 +663,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
> >  
> >  	if ((tifp ^ tifn) & _TIF_SLD)
> >  		switch_to_sld(tifn);
> > +
> > +	pks_sched_in();
> >  }
> >  
> >  /*
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
> > 
> 
> It bugs me a *bit* that this is being called in a preempt-disabled
> region, but we still bother with the get/put_cpu jazz.  Are there other
> future call-sites for this that aren't in preempt-disabled regions?

I'm not specifically disabling preempt before calling write_pkrs except in the
next patch (which is buggy because I meant to have it around the modification
of thread.saved_pkrs as well).  But that was to protect the thread variable not
the percpu cache vs MSR.

My thought above was it is safer for this call to ensure the per-cpu variable
is consistent with the register.  The other calls to write_pkrs() may require
preemption disable but for reasons unrelated to write_pkrs' state.

After some research I've now fully confused myself if this is needed in patch
7/9 where write_pkrs() is called from the exception handing code.  But I think
it is needed there.  Isn't it?

Since preempt_disable() is nestable I think this is ok correct?

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

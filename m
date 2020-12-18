Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 010D32DDD95
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 05:05:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 13EDE100EB327;
	Thu, 17 Dec 2020 20:05:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2A856100EBB9C
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 20:05:14 -0800 (PST)
IronPort-SDR: k5xO8TZTAgKl8fAZzj+7DjXOD9Kq05v2qvuV1j789OzZLDGOaIcbQTzOo8Y5CsKhQ/GvEpPcE4
 XCHayErVc6BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="154600171"
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400";
   d="scan'208";a="154600171"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 20:05:13 -0800
IronPort-SDR: xIoOx2WpcZxg9TNJeBrK9pp65pNqSH24P4QCVBEy2TUxNOaoO6EtP7aXnm5z0CkkqILtQnRU4v
 IrQ4dja/d1Jg==
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400";
   d="scan'208";a="388089677"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 20:05:13 -0800
Date: Thu, 17 Dec 2020 20:05:13 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
Message-ID: <20201218040513.GB2506510@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201106232908.364581-5-ira.weiny@intel.com>
 <871rfoscz4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871rfoscz4.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 3I44RLHJHUONMV2VDYYQ7UNOZFLHWXSA
X-Message-ID-Hash: 3I44RLHJHUONMV2VDYYQ7UNOZFLHWXSA
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3I44RLHJHUONMV2VDYYQ7UNOZFLHWXSA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 17, 2020 at 03:50:55PM +0100, Thomas Gleixner wrote:
> On Fri, Nov 06 2020 at 15:29, ira weiny wrote:
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -43,6 +43,7 @@
> >  #include <asm/io_bitmap.h>
> >  #include <asm/proto.h>
> >  #include <asm/frame.h>
> > +#include <asm/pkeys_common.h>
> >  
> >  #include "process.h"
> >  
> > @@ -187,6 +188,27 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
> >  	return ret;
> >  }
> >  
> > +#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > +DECLARE_PER_CPU(u32, pkrs_cache);
> > +static inline void pks_init_task(struct task_struct *tsk)
> 
> First of all. I asked several times now not to glue stuff onto a
> function without a newline inbetween. It's unreadable.

Fixed.

> 
> But what's worse is that the declaration of pkrs_cache which is global
> is in a C file and not in a header. And pkrs_cache is not even used in
> this file. So what?

OK, this was just a complete rebase/refactor mess up on my part.  The
global'ness is not required until we need a global update of the pkrs which was
not part of this series.

I've removed it from this patch.  And cleaned it up in patch 6/10 as well.  And
cleaned it up in the global pkrs patch which you found in my git tree.

> 
> > +{
> > +	/* New tasks get the most restrictive PKRS value */
> > +	tsk->thread.saved_pkrs = INIT_PKRS_VALUE;
> > +}
> > +static inline void pks_sched_in(void)
> 
> Newline between functions. It's fine for stubs, but not for a real implementation.

Again my apologies.

Fixed.

> 
> > diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> > index d1dfe743e79f..76a62419c446 100644
> > --- a/arch/x86/mm/pkeys.c
> > +++ b/arch/x86/mm/pkeys.c
> > @@ -231,3 +231,34 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
> >  
> >  	return pk_reg;
> >  }
> > +
> > +DEFINE_PER_CPU(u32, pkrs_cache);
> 
> Again, why is this global?

In this patch it does not need to be.  I've changed it to static.

> 
> > +void write_pkrs(u32 new_pkrs)
> > +{
> > +	u32 *pkrs;
> > +
> > +	if (!static_cpu_has(X86_FEATURE_PKS))
> > +		return;
> > +
> > +	pkrs = get_cpu_ptr(&pkrs_cache);
> 
> So this is called from various places including schedule and also from
> the low level entry/exit code. Why do we need to have an extra
> preempt_disable/enable() there via get/put_cpu_ptr()?
> 
> Just because performance in those code paths does not matter?

Honestly I don't recall the full history at this point.  The
preempt_disable/enable() is required when this is called from
pks_update_protection()  AKA when a user is trying to update the protections of
their key.  What I do remember is that this was originally not preempt safe and we
had a comment to that effect in the early patches.[1]

Somewhere along the line the preempt discussion lead us to make write_pkrs()
'self contained' with the preemption protection here.  I just did not think
about any performance issues.  It is safe to call preempt_disable() from a
preempt disabled region, correct?  I seem to recall asking that and the answer
was 'yes'.

I will audit the calls again and adjust the preemption disable as needed.

[1] https://lore.kernel.org/lkml/20200717072056.73134-5-ira.weiny@intel.com/#t

> 
> > +	if (*pkrs != new_pkrs) {
> > +		*pkrs = new_pkrs;
> > +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
> > +	}
> > +	put_cpu_ptr(pkrs);
> 
> Now back to the context switch:
> 
> > @@ -644,6 +668,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
> >
> >	 if ((tifp ^ tifn) & _TIF_SLD)
> >		 switch_to_sld(tifn);
> > +
> > +	pks_sched_in();
> >  }
> 
> How is this supposed to work? 
> 
> switch_to() {
>    ....
>    switch_to_extra() {
>       ....
>       if (unlikely(next_tif & _TIF_WORK_CTXSW_NEXT ||
> 	           prev_tif & _TIF_WORK_CTXSW_PREV))
> 	   __switch_to_xtra(prev, next);
> 
> I.e. __switch_to_xtra() is only invoked when the above condition is
> true, which is not guaranteed at all.

I did not know that.  I completely missunderstood what __switch_to_xtra()
meant.  I thought it was arch specific 'extra' stuff so it seemed reasonable to
me.

Also, our test seemed to work.  I'm still investigating what may be wrong.

> 
> While I have to admit that I dropped the ball on the update for the
> entry patch, I'm not too sorry about it anymore when looking at this.
> 
> Are you still sure that this is ready for merging?

Nope...

Thanks for the review,
Ira

> 
> Thanks,
> 
>         tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

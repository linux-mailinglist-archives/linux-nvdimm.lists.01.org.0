Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0892245EC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 23:39:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 82F0711C82AA4;
	Fri, 17 Jul 2020 14:39:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7B95211BB693E
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 14:39:31 -0700 (PDT)
IronPort-SDR: 911QfcInuGBkXj8h10TCnJ5f54e6lcjMezwVPyqrp9h1DYCB7xIcLhuqRylDuQEva7u3gc6Z55
 Esl9GO+qhM9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="234532585"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800";
   d="scan'208";a="234532585"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 14:39:30 -0700
IronPort-SDR: AU7pg9gP52qGosMkjj44f+xwiuRZBXuNXBPORBl/nIscyOnQkujZOX7iJDcTIOdgYz9TXvt9wD
 p6bhZiX9j/bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800";
   d="scan'208";a="460984872"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 14:39:30 -0700
Date: Fri, 17 Jul 2020 14:39:30 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V2 04/17] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200717213929.GR3008823@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-5-ira.weiny@intel.com>
 <20200717083140.GW10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717083140.GW10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 4KDISADPRQNLQHHFG5YSOES5Y4X542RA
X-Message-ID-Hash: 4KDISADPRQNLQHHFG5YSOES5Y4X542RA
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4KDISADPRQNLQHHFG5YSOES5Y4X542RA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 10:31:40AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:43AM -0700, ira.weiny@intel.com wrote:
> 
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index f362ce0d5ac0..d69250a7c1bf 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -42,6 +42,7 @@
> >  #include <asm/spec-ctrl.h>
> >  #include <asm/io_bitmap.h>
> >  #include <asm/proto.h>
> > +#include <asm/pkeys_internal.h>
> >  
> >  #include "process.h"
> >  
> > @@ -184,6 +185,36 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
> >  	return ret;
> >  }
> >  
> > +/*
> > + * NOTE: We wrap pks_init_task() and pks_sched_in() with
> > + * CONFIG_ARCH_HAS_SUPERVISOR_PKEYS because using IS_ENABLED() fails
> > + * due to the lack of task_struct->saved_pkrs in this configuration.
> > + * Furthermore, we place them here because of the complexity introduced by
> > + * header conflicts introduced to get the task_struct definition in the pkeys
> > + * headers.
> > + */
> 
> I don't see anything much useful in that comment.

I'm happy to delete.  Internal reviews questioned the motive here so I added
the comment to inform why this style was chosen rather than the preferred
IS_ENABLED().

I've deleted it now.

> 
> > +#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > +DECLARE_PER_CPU(u32, pkrs_cache);
> > +static inline void pks_init_task(struct task_struct *tsk)
> > +{
> > +	/* New tasks get the most restrictive PKRS value */
> > +	tsk->thread.saved_pkrs = INIT_PKRS_VALUE;
> > +}
> > +static inline void pks_sched_in(void)
> > +{
> > +	u64 current_pkrs = current->thread.saved_pkrs;
> > +
> > +	/* Only update the MSR when current's pkrs is different from the MSR. */
> > +	if (this_cpu_read(pkrs_cache) == current_pkrs)
> > +		return;
> > +
> > +	write_pkrs(current_pkrs);
> 
> Should we write that like:
> 
> 	/*
> 	 * PKRS is only temporarily changed during specific code paths.
> 	 * Only a preemption during these windows away from the default
> 	 * value would require updating the MSR.
> 	 */
> 	if (unlikely(this_cpu_read(pkrs_cache) != current_pkrs))
> 		write_pkrs(current_pkrs);
> 
> ?

Yes I think the unlikely is better.

Thanks,
Ira

> 
> > +}
> > +#else
> > +static inline void pks_init_task(struct task_struct *tsk) { }
> > +static inline void pks_sched_in(void) { }
> > +#endif
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34B2DD342
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 15:51:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0CBF8100EB827;
	Thu, 17 Dec 2020 06:51:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E3810100ED4A6
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 06:50:57 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1608216656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VA4CgUr+mddzE5W5XW9xxSKHdRVWkhVu9Ou7VaYBRBs=;
	b=x8YQjbsn8YubrCEDl0qhTSqp7psA5Cd6Hcsqd6nPGmOKkR4V3QV6au+wuNiZ7qXnSqXxrh
	pHl+HVLKuH/NQrLPX+SBnCxVKjKz4KY9NGvsbLDIguCeKiwS0WVyMaaieLw2qaowM92I+v
	AOu83+LgNoQtBcOH4v4HANgrFaxI66gNG0k0wizSwWzdOkg1aXgLEoo8LJ5Abil4dSH97g
	LlvLd6o+i/ALJXAtSNNYH+yIhVe2vxmfXVuuIlY1jBObQ37+MdgawY4Cp01Gj58Mt9CyAy
	JklATQ+uU8bAY28yrrUKjmnYeC6hjxb0UQqdPzcYoYDMWKALZ6gJQN1y4PCu6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1608216656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VA4CgUr+mddzE5W5XW9xxSKHdRVWkhVu9Ou7VaYBRBs=;
	b=zuop8u3nFEivs4Yrh4v+upsEEA6+NJTeUPgODNyRqWXHhC8ikax+nyK5d9aFM+tUmTqDLA
	kfxhlxbeOeHvM0Bw==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
In-Reply-To: <20201106232908.364581-5-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com>
Date: Thu, 17 Dec 2020 15:50:55 +0100
Message-ID: <871rfoscz4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: MB2P4EKSCRT2MCXWJKBJRCK7KFXHTA6N
X-Message-ID-Hash: MB2P4EKSCRT2MCXWJKBJRCK7KFXHTA6N
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MB2P4EKSCRT2MCXWJKBJRCK7KFXHTA6N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 06 2020 at 15:29, ira weiny wrote:
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -43,6 +43,7 @@
>  #include <asm/io_bitmap.h>
>  #include <asm/proto.h>
>  #include <asm/frame.h>
> +#include <asm/pkeys_common.h>
>  
>  #include "process.h"
>  
> @@ -187,6 +188,27 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> +DECLARE_PER_CPU(u32, pkrs_cache);
> +static inline void pks_init_task(struct task_struct *tsk)

First of all. I asked several times now not to glue stuff onto a
function without a newline inbetween. It's unreadable.

But what's worse is that the declaration of pkrs_cache which is global
is in a C file and not in a header. And pkrs_cache is not even used in
this file. So what?

> +{
> +	/* New tasks get the most restrictive PKRS value */
> +	tsk->thread.saved_pkrs = INIT_PKRS_VALUE;
> +}
> +static inline void pks_sched_in(void)

Newline between functions. It's fine for stubs, but not for a real implementation.

> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> index d1dfe743e79f..76a62419c446 100644
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -231,3 +231,34 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
>  
>  	return pk_reg;
>  }
> +
> +DEFINE_PER_CPU(u32, pkrs_cache);

Again, why is this global?

> +void write_pkrs(u32 new_pkrs)
> +{
> +	u32 *pkrs;
> +
> +	if (!static_cpu_has(X86_FEATURE_PKS))
> +		return;
> +
> +	pkrs = get_cpu_ptr(&pkrs_cache);

So this is called from various places including schedule and also from
the low level entry/exit code. Why do we need to have an extra
preempt_disable/enable() there via get/put_cpu_ptr()?

Just because performance in those code paths does not matter?

> +	if (*pkrs != new_pkrs) {
> +		*pkrs = new_pkrs;
> +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
> +	}
> +	put_cpu_ptr(pkrs);

Now back to the context switch:

> @@ -644,6 +668,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>
>	 if ((tifp ^ tifn) & _TIF_SLD)
>		 switch_to_sld(tifn);
> +
> +	pks_sched_in();
>  }

How is this supposed to work? 

switch_to() {
   ....
   switch_to_extra() {
      ....
      if (unlikely(next_tif & _TIF_WORK_CTXSW_NEXT ||
	           prev_tif & _TIF_WORK_CTXSW_PREV))
	   __switch_to_xtra(prev, next);

I.e. __switch_to_xtra() is only invoked when the above condition is
true, which is not guaranteed at all.

While I have to admit that I dropped the ball on the update for the
entry patch, I'm not too sorry about it anymore when looking at this.

Are you still sure that this is ready for merging?

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

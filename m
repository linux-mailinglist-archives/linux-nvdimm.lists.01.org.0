Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BAE223709
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 10:32:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 586C811F6E6CB;
	Fri, 17 Jul 2020 01:32:04 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3610F11F6E6CA
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aFEt+zFPrqVQGAdO3RJf1KxQLYdEhDO70E3sDQSJR2I=; b=NAYUD0tRwLcD1cWPXKXDszQUPy
	mQzEmJYNmsTd4lPHX0AEaiE3az4Ot3sQ1ZvLDIGE13hX9Jds8cRERVdr2DZSyWJCpE2VqUEPt5ZYc
	UjvbCMB4kO2sPJdqTsOkgLUOWdAj27RrCTe3SXW5tLnHhIl8mollSFClH0NO7VHqMdTGAGGAocUrH
	2ogmG9mWgV1L/V+N84VlhdwEt8XBL7mlLDgkK1KYxpvPnnf8ru+JrOz6xl85frfohw2XVDowK+lgc
	vdjzRVIpa0KpwRU73+hsFhpGtg1CnBKfr0INMSg3CozV6pnzHBI4oK/qNaYP9/i6oBIS69HJA2ptL
	S2yGqBiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwLmQ-0004NK-L1; Fri, 17 Jul 2020 08:31:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A33083003D8;
	Fri, 17 Jul 2020 10:31:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9580929CF6F49; Fri, 17 Jul 2020 10:31:40 +0200 (CEST)
Date: Fri, 17 Jul 2020 10:31:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V2 04/17] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200717083140.GW10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-5-ira.weiny@intel.com>
Message-ID-Hash: 3OFG5ON5HCOSPJKTTCMVXSAPZZVD5D3L
X-Message-ID-Hash: 3OFG5ON5HCOSPJKTTCMVXSAPZZVD5D3L
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3OFG5ON5HCOSPJKTTCMVXSAPZZVD5D3L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 12:20:43AM -0700, ira.weiny@intel.com wrote:

> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index f362ce0d5ac0..d69250a7c1bf 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -42,6 +42,7 @@
>  #include <asm/spec-ctrl.h>
>  #include <asm/io_bitmap.h>
>  #include <asm/proto.h>
> +#include <asm/pkeys_internal.h>
>  
>  #include "process.h"
>  
> @@ -184,6 +185,36 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
>  	return ret;
>  }
>  
> +/*
> + * NOTE: We wrap pks_init_task() and pks_sched_in() with
> + * CONFIG_ARCH_HAS_SUPERVISOR_PKEYS because using IS_ENABLED() fails
> + * due to the lack of task_struct->saved_pkrs in this configuration.
> + * Furthermore, we place them here because of the complexity introduced by
> + * header conflicts introduced to get the task_struct definition in the pkeys
> + * headers.
> + */

I don't see anything much useful in that comment.

> +#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> +DECLARE_PER_CPU(u32, pkrs_cache);
> +static inline void pks_init_task(struct task_struct *tsk)
> +{
> +	/* New tasks get the most restrictive PKRS value */
> +	tsk->thread.saved_pkrs = INIT_PKRS_VALUE;
> +}
> +static inline void pks_sched_in(void)
> +{
> +	u64 current_pkrs = current->thread.saved_pkrs;
> +
> +	/* Only update the MSR when current's pkrs is different from the MSR. */
> +	if (this_cpu_read(pkrs_cache) == current_pkrs)
> +		return;
> +
> +	write_pkrs(current_pkrs);

Should we write that like:

	/*
	 * PKRS is only temporarily changed during specific code paths.
	 * Only a preemption during these windows away from the default
	 * value would require updating the MSR.
	 */
	if (unlikely(this_cpu_read(pkrs_cache) != current_pkrs))
		write_pkrs(current_pkrs);

?

> +}
> +#else
> +static inline void pks_init_task(struct task_struct *tsk) { }
> +static inline void pks_sched_in(void) { }
> +#endif
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

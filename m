Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7929043F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Oct 2020 13:45:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F3D11607D5D0;
	Fri, 16 Oct 2020 04:45:24 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15D6116073275
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qQg6J3/vlve0eZLFZsQ/w8Q+KfScOGH0GLnAv5sc/KY=; b=eo7Hq+wCBzP7XEdw1lGXEczxvo
	dHgTwmCujf8l62pRsq9CAvIG6QeTBFpsJg/RLp3uRgyQafgAQ2Lb5S+iHFU0WHC7YxwYa+M8eEUSQ
	C0z2hGm7p7VVXonP7uEwdCLuY1+8TuzfNlLSQRT/DI4mF9jnY4YAZLz/qiq2dEgHG2aQpY4yeBgmw
	WCqogcaMqKT9P6kWXcFiPUiT7Wg6to2G0jD7lTiUTCG/QHXqNftwzCh28ph+AVA4W0YLu0TboLEI6
	dE+b0eyG3ZengL6MFYFIoqMEkVnGngDMOx7t/Yv63ulrXUwEmx798AbgimmQPjMrDkgofKS7SMK44
	wTjVyhJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTOAZ-000534-AC; Fri, 16 Oct 2020 11:45:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DF12300DAE;
	Fri, 16 Oct 2020 13:45:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E9112011673A; Fri, 16 Oct 2020 13:45:10 +0200 (CEST)
Date: Fri, 16 Oct 2020 13:45:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V3 6/9] x86/entry: Pass irqentry_state_t by reference
Message-ID: <20201016114510.GO2611@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009194258.3207172-7-ira.weiny@intel.com>
Message-ID-Hash: XLH4PII5RSGGIM5CZFS74UWK3T4O2KLT
X-Message-ID-Hash: XLH4PII5RSGGIM5CZFS74UWK3T4O2KLT
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XLH4PII5RSGGIM5CZFS74UWK3T4O2KLT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 09, 2020 at 12:42:55PM -0700, ira.weiny@intel.com wrote:
> -noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
> +noinstr void idtentry_enter_nmi(struct pt_regs *regs, irqentry_state_t *irq_state)
>  {
> -	bool irq_state = lockdep_hardirqs_enabled();
> +	irq_state->exit_rcu = lockdep_hardirqs_enabled();
>  
>  	__nmi_enter();
>  	lockdep_hardirqs_off(CALLER_ADDR0);
> @@ -222,15 +222,13 @@ noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
>  	trace_hardirqs_off_finish();
>  	ftrace_nmi_enter();
>  	instrumentation_end();
> -
> -	return irq_state;
>  }
>  
> -noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
> +noinstr void idtentry_exit_nmi(struct pt_regs *regs, irqentry_state_t *irq_state)
>  {
>  	instrumentation_begin();
>  	ftrace_nmi_exit();
> -	if (restore) {
> +	if (irq_state->exit_rcu) {
>  		trace_hardirqs_on_prepare();
>  		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>  	}
> @@ -238,7 +236,7 @@ noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
>  
>  	rcu_nmi_exit();
>  	lockdep_hardirq_exit();
> -	if (restore)
> +	if (irq_state->exit_rcu)
>  		lockdep_hardirqs_on(CALLER_ADDR0);
>  	__nmi_exit();
>  }

That's not nice.. The NMI path is different from the IRQ path and has a
different variable. Yes, this works, but *groan*.

Maybe union them if you want to avoid bloating the structure, but the
above makes it really hard to read.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

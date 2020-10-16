Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E402903DA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Oct 2020 13:12:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE93716081AEB;
	Fri, 16 Oct 2020 04:12:42 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 46B2115C25D1E
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wAy2lh21ULGhfKu1lWKdjXSaLAVUcJ27z4IflXzPX1A=; b=MFRxAjkWFnE13dfJ8D+zIoix/z
	nIt9L4wOVDn8LU0pJX766VrtXGM6nVgouteYlsw/9lmgyGsOGIPNxD2iKWoO31fYbwO7lyCa+n63K
	r0PTSyJ8GHYfCGvXK3CZyEjU0Uu84qddnuxSHPLsXCz66lLVy7N0i+x45gcUsroopk4bC/41M3MOE
	qhe7v1QkSXOTyg0Uq+j/RyXAVm+8kagUs7e9F9+awmsnqOS8yvhgJHQZcSmDAdwZoz/shUV4XEcYM
	1A8F/BCloojyeLlbnnSW8LF5mmuf3NpoZg97gfqYsNry9dyernrphRaVWcuoeF2Ns9dJfry1BC3gL
	u0ro6j5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTNeu-00032M-82; Fri, 16 Oct 2020 11:12:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB4833011E6;
	Fri, 16 Oct 2020 13:12:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id D315A2011673A; Fri, 16 Oct 2020 13:12:26 +0200 (CEST)
Date: Fri, 16 Oct 2020 13:12:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201016111226.GN2611@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
 <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
Message-ID-Hash: ZTQBLEPHNQ2K5JGSXTJXEM6QYFLEG3BD
X-Message-ID-Hash: ZTQBLEPHNQ2K5JGSXTJXEM6QYFLEG3BD
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZTQBLEPHNQ2K5JGSXTJXEM6QYFLEG3BD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 11:31:45AM -0700, Dave Hansen wrote:
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

So the previous version had a useful comment that got lost. This stuff
needs to fundamentally be preempt disabled, so it either needs to
explicitly do so, or have an assertion that preemption is indeed
disabled.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

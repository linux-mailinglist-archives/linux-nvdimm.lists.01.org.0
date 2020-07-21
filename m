Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3C2288E7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 21:11:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0559911078326;
	Tue, 21 Jul 2020 12:11:53 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5CA6F100A6D49
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R2zugMccFiI0jJgvQMs0TPnzzQfNHe0PTn5J5IwA7Vg=; b=R19nnLcc1ehZda6baIKpJBp4mk
	QIU+wDYISg1oiFi1U088VyKvy4CooK8rP1aGzRtF9XgpDe7eTIFV5r5689wWdYUJ+kYWCyJFppnHe
	nqnVDpB+MOc7wNPL3u1wcpwcRyUTibeYFoZ5XQDOq5H50e5y/OqubPR0zS217bggT7wpva3a9ANM7
	finoA5pjqRnrzqe5tTkqDI+yyfEltcwPUMKHMM+FcE0XgdWmzuY4QGbHUG0CxVcaj2fo8FJfZoGej
	y8rSdDOLXtpi9uJ1cu34SMbBgoHDTpVf2xUJM8yurQyaUxcOCForZjuAREOFTQHAPuEArGD2e6Sf2
	YkXN9VdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxxfo-00084N-76; Tue, 21 Jul 2020 19:11:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3C7E3011C6;
	Tue, 21 Jul 2020 21:11:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id BEE3D203C9761; Tue, 21 Jul 2020 21:11:29 +0200 (CEST)
Date: Tue, 21 Jul 2020 21:11:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200721191129.GG10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <20200717093041.GF10769@hirez.programming.kicks-ass.net>
 <20200721180134.GB643353@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200721180134.GB643353@iweiny-DESK2.sc.intel.com>
Message-ID-Hash: D44YKWIBGT3NB66YKBOHT46HV3ARYY4H
X-Message-ID-Hash: D44YKWIBGT3NB66YKBOHT46HV3ARYY4H
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D44YKWIBGT3NB66YKBOHT46HV3ARYY4H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 21, 2020 at 11:01:34AM -0700, Ira Weiny wrote:
> On Fri, Jul 17, 2020 at 11:30:41AM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
> > > +static void noinstr idt_save_pkrs(idtentry_state_t state)
> > 
> > noinstr goes in the same place you would normally put inline, that's
> > before the return type, not after it.
> >
> 
> Sorry about that.  But that does not look to be consistent.
> 
> 10:57:35 > git grep 'noinstr' arch/x86/entry/common.c
> ...
> arch/x86/entry/common.c:idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
> arch/x86/entry/common.c:void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
> arch/x86/entry/common.c:void noinstr idtentry_enter_user(struct pt_regs *regs)
> arch/x86/entry/common.c:void noinstr idtentry_exit_user(struct pt_regs *regs)
> ...
> 
> Are the above 'wrong'?  Is it worth me sending a patch?

I think I already fixed all those, please check tip/master.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

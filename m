Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79221FBF7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 21:05:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 585EA116BF61C;
	Tue, 14 Jul 2020 12:05:54 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 73249111B91F4
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QtBDCBQMf3lNrZeLLRepSMPPpVKJmWktHMjNgRkoGLQ=; b=CJdJ83l0vKu7yJJ6u6GOgFQPf7
	ZyfPiLItdxhC20dtPthP4i8qJ/61lUsTGE18T0J74ZDa4lDh3C0V+jx805qUstzgtOGqTSvCPyddn
	WiD8e/7NEHoMqk5+9Wv9wAU5wuHUyNnWxW7gGQfxCaFPp7ztMWMiPX4S6/5dRwZ18IWRYJEXMgesv
	2MoLYqByx8+66mmpjfL59zNQ9FZdqBCuO37lJzU2woGAMsZOOaA7FaGoTUsGEXhqpdUHvJurxFcYq
	AIepEEqyyChZWBIhOp0oJfg/WFsjR9f9TKZ8+xmcmRZAGDaYa/3ew+V/GmF86spyiIawHftDfs0Zp
	Uh+Tti+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvQFJ-0000RD-Qw; Tue, 14 Jul 2020 19:05:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
	id 44E2B9817E0; Tue, 14 Jul 2020 21:05:39 +0200 (CEST)
Date: Tue, 14 Jul 2020 21:05:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH 04/15] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200714190539.GG5523@worktop.programming.kicks-ass.net>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-5-ira.weiny@intel.com>
 <20200714082701.GO10769@hirez.programming.kicks-ass.net>
 <20200714185322.GB3008823@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714185322.GB3008823@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: KACTBOLRKFDCTDHJIBGP3Y2IPKMHFSO7
X-Message-ID-Hash: KACTBOLRKFDCTDHJIBGP3Y2IPKMHFSO7
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KACTBOLRKFDCTDHJIBGP3Y2IPKMHFSO7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 14, 2020 at 11:53:22AM -0700, Ira Weiny wrote:
> On Tue, Jul 14, 2020 at 10:27:01AM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 14, 2020 at 12:02:09AM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The PKRS MSR is defined as a per-core register.  This isolates memory
> > > access by CPU.  Unfortunately, the MSR is not preserved by XSAVE.
> > > Therefore, We must preserve the protections for individual tasks even if
> > > they are context switched out and placed on another cpu later.
> > 
> > This is a contradiction and utter trainwreck.
> 
> I don't understand where there is a contradiction?  Perhaps I should have said
> the MSR is not XSAVE managed vs 'preserved'?

You're stating the MSR is per-*CORE*, and then continue to talk about
per-task state.

We've had a bunch of MSRs have exactly that problem recently, and it's
not fun. We're not going to do that again.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

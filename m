Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0AF2924AC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Oct 2020 11:35:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 54C3415E0258E;
	Mon, 19 Oct 2020 02:35:22 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C8838159835FE
	for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zox4iuTUh5FhfHMfr5Q1+3mfA7F/sioi7RToa5+WOak=; b=1cTRPkWVb54NZZ9RoS/xBCH//y
	bQ8J6UD4Msz4eTlusz0Mg0XUPKXXee9CpA39JXkycYwfkuyW38XvZxx+Ov+bC+orngC/knAgKRe+V
	RSUEzGr/pQne1U7t+uJT4Ysxl9Fpg7ljYx9s0FfTJaon0FQp5khD6hZW6u9s5G0zQWlm88iGLMExl
	F7eXrCeoL/Iljfckg/PyFFE4SBgQQ6pDjaupvcpSCYQez3wm478Lf2zsTglmh+ANgPSXtxSN1OpD6
	gPVw+tJxsfEjTgFZbH/pINcQlGxLK7zMigefRp0S20SP1O49vayTSnvv+EhM8QiQl4oc6BbeVvwcB
	veDuI0Gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kURZL-0005n6-V6; Mon, 19 Oct 2020 09:35:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C3083011E6;
	Mon, 19 Oct 2020 11:35:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4E27A21447780; Mon, 19 Oct 2020 11:35:02 +0200 (CEST)
Date: Mon, 19 Oct 2020 11:35:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC V3 2/9] x86/fpu: Refactor arch_set_user_pkey_access()
 for PKS support
Message-ID: <20201019093502.GH2628@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-3-ira.weiny@intel.com>
 <20201016105743.GK2611@hirez.programming.kicks-ass.net>
 <20201017033202.GV2046448@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201017033202.GV2046448@iweiny-DESK2.sc.intel.com>
Message-ID-Hash: GXE2GF2RGS7YWRVWDQXJNRDYMEHJBI47
X-Message-ID-Hash: GXE2GF2RGS7YWRVWDQXJNRDYMEHJBI47
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GXE2GF2RGS7YWRVWDQXJNRDYMEHJBI47/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2020 at 08:32:03PM -0700, Ira Weiny wrote:
> On Fri, Oct 16, 2020 at 12:57:43PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 09, 2020 at 12:42:51PM -0700, ira.weiny@intel.com wrote:
> > > From: Fenghua Yu <fenghua.yu@intel.com>
> > > 
> > > Define a helper, update_pkey_val(), which will be used to support both
> > > Protection Key User (PKU) and the new Protection Key for Supervisor
> > > (PKS) in subsequent patches.
> > > 
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > > ---
> > >  arch/x86/include/asm/pkeys.h |  2 ++
> > >  arch/x86/kernel/fpu/xstate.c | 22 ++++------------------
> > >  arch/x86/mm/pkeys.c          | 21 +++++++++++++++++++++
> > >  3 files changed, 27 insertions(+), 18 deletions(-)
> > 
> > This is not from Fenghua.
> > 
> >   https://lkml.kernel.org/r/20200717085442.GX10769@hirez.programming.kicks-ass.net
> > 
> > This is your patch based on the code I wrote.
> 
> Ok, I apologize.  Yes the code below was all yours.
> 
> Is it ok to add?
> 
> Co-developed-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> 

Sure, thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

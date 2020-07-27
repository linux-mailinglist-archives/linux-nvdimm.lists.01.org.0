Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2471122FAD7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Jul 2020 22:59:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9CFF91240ED85;
	Mon, 27 Jul 2020 13:59:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B23FA1240ED6C
	for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 13:59:11 -0700 (PDT)
IronPort-SDR: pHV3OYf5WTI5SiJ34gZSfk1ceEXdwDGAJP53Zu3bHFVqPYTzgp370mLP5YyR1er6yBxy5HtDIl
 cO20x0A4uUbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="130673563"
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800";
   d="scan'208";a="130673563"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 13:59:10 -0700
IronPort-SDR: F6x4TaH2xUbkqcHOlkYVCRLa84X160LomB+gQPSLrqqclZ5rkG41zSJgbumVGi5uDGCsUe7wk1
 4OgHP9BbFWkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800";
   d="scan'208";a="320157680"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2020 13:59:10 -0700
Date: Mon, 27 Jul 2020 13:59:09 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200727205909.GP844235@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <87r1t2vwi7.fsf@nanos.tec.linutronix.de>
 <20200723220435.GI844235@iweiny-DESK2.sc.intel.com>
 <87mu3pvly7.fsf@nanos.tec.linutronix.de>
 <874kpwtxlh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874kpwtxlh.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: ETGTAFRFRKZKSWWOGHEV7SKCAOXB5VRB
X-Message-ID-Hash: ETGTAFRFRKZKSWWOGHEV7SKCAOXB5VRB
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ETGTAFRFRKZKSWWOGHEV7SKCAOXB5VRB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 24, 2020 at 11:24:58PM +0200, Thomas Gleixner wrote:
> Ira,
> 
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Ira Weiny <ira.weiny@intel.com> writes:
> >> On Thu, Jul 23, 2020 at 09:53:20PM +0200, Thomas Gleixner wrote:
> >> I think, after fixing my code (see below), using idtentry_state could still
> >> work.  If the per-cpu cache and the MSR is updated in idtentry_exit() that
> >> should carry the state to the new cpu, correct?
> >
> > I'm way too tired to think about that now. Will have a look tomorrow
> > with brain awake.
> 
> Not that I'm way more awake now, but at least I have the feeling that my
> brain is not completely useless.
> 
> Let me summarize what I understood:
> 
>   1) A per CPU cache which shadows the current state of the MSR, i.e. the
>      current valid key. You use that to avoid costly MSR writes if the
>      key does not change.

Yes

> 
>   2) On idtentry you store the key on entry in idtentry_state, clear it
>      in the MSR and shadow state if necessary and restore it on exit.

Yes, but I've subsequently found a bug here but yea that was the intention.
:-D

I also maintain the ref count of the number of nested calls to kmap to ensure
that kmap_atomic() is nestable during an exception independent of the number
of nested calls of the interrupted thread.

>   3) On context switch out you save the per CPU cache value in the task
>      and on context switch in you restore it from there.

yes

> 
> Yes, that works (see below for #2) and sorry for my confusion yesterday
> about storing this in task state.

No problem.

> 
> #2 requires to handle the exceptions which do not go through
> idtentry_enter/exit() seperately, but that's a manageable amount. It's
> the ones which use IDTENTRY_RAW or a variant of it.
> 
> #BP, #MC, #NMI, #DB, #DF need extra local storage as all the kernel
> entries for those use nmi_enter()/exit(). So you just can create
> wrappers around those. Somehting like this
> 
> static __always_inline idtentry_state_t idtentry_nmi_enter(void)
> {
>      	idtentry_state_t state = {};
> 
>         nmi_enter();
>         instrumentation_begin();
>         state.key = save_and_clear_key();
>         instrumentation_end();
> }
> 
> static __always_inline void idtentry_nmi_exit(idtentry_state_t state)
> {
>         instrumentation_begin();
>         restore_key(state.key);
>         instrumentation_end();
>         nmi_exit();
> }
> 

Thanks!

> #UD and #PF are using the raw entry variant as well but still invoke
> idtentry_enter()/exit(). #PF does not need any work. #UD handles
> WARN/BUG without going through idtentry_enter() first, but I don't think
> that's an issue unless a not 0 key would prevent writing to the console
> device. You surely can figure that out.
> 
> Hope that helps.

Yes it does thank you.  I'm also trying to simplify the API per Peters
comments while refactoring this.

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

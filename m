Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6737B22CC14
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jul 2020 19:23:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 670C811897B4A;
	Fri, 24 Jul 2020 10:23:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 24AA911897B49
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jul 2020 10:23:46 -0700 (PDT)
IronPort-SDR: PBYMlp3trMf1j3j1neiG2IYXV0fypVwtlOlq5xzXoS5/mY2htSivBxop9vdagENrpeDiaEKhoL
 bRrE9AVppGQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="148240194"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800";
   d="scan'208";a="148240194"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:23:44 -0700
IronPort-SDR: X1JW4FggRo3qDiJx0NWoLol6p1tsq6DYf4Mj7qGG/ohJuRs2TnDCp10u9BuuIVBIeURlyoIeXD
 g8wFtHdotI8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800";
   d="scan'208";a="311467245"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2020 10:23:45 -0700
Date: Fri, 24 Jul 2020 10:23:44 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <20200717100610.GH10769@hirez.programming.kicks-ass.net>
 <20200722052709.GB478587@iweiny-DESK2.sc.intel.com>
 <87o8o6vvt0.fsf@nanos.tec.linutronix.de>
 <87lfjavvhm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lfjavvhm.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: UHEYZWKFF3F75PTMZIO5YI5UDIL2GJAW
X-Message-ID-Hash: UHEYZWKFF3F75PTMZIO5YI5UDIL2GJAW
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UHEYZWKFF3F75PTMZIO5YI5UDIL2GJAW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 23, 2020 at 10:15:17PM +0200, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > Ira Weiny <ira.weiny@intel.com> writes:
> >> On Fri, Jul 17, 2020 at 12:06:10PM +0200, Peter Zijlstra wrote:
> >>> On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
> >> I've been really digging into this today and I'm very concerned that I'm
> >> completely missing something WRT idtentry_enter() and idtentry_exit().
> >>
> >> I've instrumented idt_{save,restore}_pkrs(), and __dev_access_{en,dis}able()
> >> with trace_printk()'s.
> >>
> >> With this debug code, I have found an instance where it seems like
> >> idtentry_enter() is called without a corresponding idtentry_exit().  This has
> >> left the thread ref counter at 0 which results in very bad things happening
> >> when __dev_access_disable() is called and the ref count goes negative.
> >>
> >> Effectively this seems to be happening:
> >>
> >> ...
> >> 	// ref == 0
> >> 	dev_access_enable()  // ref += 1 ==> disable protection
> >> 		// exception  (which one I don't know)
> >> 			idtentry_enter()
> >> 				// ref = 0
> >> 				_handler() // or whatever code...
> >> 			// *_exit() not called [at least there is no trace_printk() output]...
> >> 			// Regardless of trace output, the ref is left at 0
> >> 	dev_access_disable() // ref -= 1 ==> -1 ==> does not enable protection
> >> 	(Bad stuff is bound to happen now...)
> >
> > Well, if any exception which calls idtentry_enter() would return without
> > going through idtentry_exit() then lots of bad stuff would happen even
> > without your patches.
> >
> >> Also is there any chance that the process could be getting scheduled and that
> >> is causing an issue?
> >
> > Only from #PF, but after the fault has been resolved and the tasks is
> > scheduled in again then the task returns through idtentry_exit() to the
> > place where it took the fault. That's not guaranteed to be on the same
> > CPU. If schedule is not aware of the fact that the exception turned off
> > stuff then you surely get into trouble. So you really want to store it
> > in the task itself then the context switch code can actually see the
> > state and act accordingly.
> 
> Actually thats nasty as well as you need a stack of PKRS values to
> handle nested exceptions. But it might be still the most reasonable
> thing to do. 7 PKRS values plus an index should be really sufficient,
> that's 32bytes total, not that bad.

I've thought about this a bit more and unless I'm wrong I think the
idtentry_state provides for that because each nested exception has it's own
idtentry_state doesn't it?

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

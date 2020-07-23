Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7D22B921
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jul 2020 00:04:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 00A221252DCE0;
	Thu, 23 Jul 2020 15:04:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EA4571252DCDD
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 15:04:37 -0700 (PDT)
IronPort-SDR: WTWy/MhC/UAPfj4MLaPZT8auZ3Dp70IsdAtfl1e2OyyY5VUAwyXAHyHBkv1P6nxCfU49RyUNJP
 e/nDetJE8w+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="138698131"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800";
   d="scan'208";a="138698131"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 15:04:37 -0700
IronPort-SDR: rQG8HKWjqzlmD9H779pxEFgskGYeCSeYgrZ/P8pr4uqKXrnKL8tXK26BHlVCIOsqZcNMAAg4qF
 oNVhQ6xlzj/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800";
   d="scan'208";a="319127920"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2020 15:04:36 -0700
Date: Thu, 23 Jul 2020 15:04:36 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200723220435.GI844235@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <87r1t2vwi7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r1t2vwi7.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: EURJJ3YWDGPU7WJFKY2OM7KIJKKJADKD
X-Message-ID-Hash: EURJJ3YWDGPU7WJFKY2OM7KIJKKJADKD
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EURJJ3YWDGPU7WJFKY2OM7KIJKKJADKD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 23, 2020 at 09:53:20PM +0200, Thomas Gleixner wrote:
> Ira,
> 
> ira.weiny@intel.com writes:
> 
> > ...
> > 	// ref == 0
> > 	dev_access_enable()  // ref += 1 ==> disable protection
> > 		irq()
> > 			// enable protection
> > 			// ref = 0
> > 			_handler()
> > 				dev_access_enable()   // ref += 1 ==> disable protection
> > 				dev_access_disable()  // ref -= 1 ==> enable protection
> > 			// WARN_ON(ref != 0)
> > 			// disable protection
> > 	do_pmem_thing()  // all good here
> > 	dev_access_disable() // ref -= 1 ==> 0 ==> enable protection
> 
> ...
> 
> > First I'm not sure if adding this state to idtentry_state and having
> > that state copied is the right way to go.
> 
> Adding the state to idtentry_state is fine at least for most interrupts
> and exceptions. Emphasis on most.
> 
> #PF does not work because #PF can schedule.


Merging with your other response:

<quote: https://lore.kernel.org/lkml/87o8o6vvt0.fsf@nanos.tec.linutronix.de/>
Only from #PF, but after the fault has been resolved and the tasks is
scheduled in again then the task returns through idtentry_exit() to the
place where it took the fault. That's not guaranteed to be on the same
CPU. If schedule is not aware of the fact that the exception turned off
stuff then you surely get into trouble. So you really want to store it
in the task itself then the context switch code can actually see the
state and act accordingly.
</quote>

I think, after fixing my code (see below), using idtentry_state could still
work.  If the per-cpu cache and the MSR is updated in idtentry_exit() that
should carry the state to the new cpu, correct?

The exception may have turned off stuff but it is a bug if it did not also turn
it back on.

Ie the irq should not be doing:

	kmap_atomic()
	return;

... without a kunmap_atomic().

That is why I put the WARN_ON_ONCE() to ensure the ref count has been properly
returned to 0 by the exception handler.

FWIW the fixed code is working for my tests...

> 
> > It seems like we should start passing this by reference instead of
> > value.  But for now this works as an RFC.  Comments?
> 
> Works as in compiles, right?
> 
> static void noinstr idt_save_pkrs(idtentry_state_t state)
> {
>         state.foo = 1;
> }
> 
> How is that supposed to change the caller state? C programming basics.

<sigh>  I am so stupid.  I was not looking at this particular case but you are
100% correct...  I can't believe I did not see this.

In the above statement I was only thinking about the extra overhead I was
adding to idtentry_enter() and the callers of it.

"C programming basics" indeed... Once again sorry...

> 
> > Second, I'm not 100% happy with having to save the reference count in
> > the exception handler.  It seems like a very ugly layering violation but
> > I don't see a way around it at the moment.
> 
> That state is strict per task, right? So why do you want to store it
> anywhere else that in task/thread storage. That solves your problem of
> #PF scheduling nicely.

The problem is with the kmap code.  If an exception handler calls kmap_atomic()
[more importantly if they nest kmap_atomic() calls] the kmap code will need to
keep track of that re-entrant call.  With a separate reference counter, the
kmap code would have to know it is in irq context or not.

Here I'm attempting to make the task 'current->dev_page_access_ref' counter
serve double duty so that the kmap code is agnostic to the context it is in.

> 
> > Third, this patch has gone through a couple of revisions as I've had
> > crashes which just don't make sense to me.  One particular issue I've
> > had is taking a MCE during memcpy_mcsafe causing my WARN_ON() to fire.
> > The code path was a pmem copy and the ref count should have been
> > elevated due to dev_access_enable() but why was
> > idtentry_enter()->idt_save_pkrs() not called I don't know.
> 
> Because #MC does not go through idtentry_enter(). Neither do #NMI, #DB, #BP.

And the above probably would work if I knew how to code in C...  :-/  I'm so
embarrassed.

> 
> > Finally, it looks like the entry/exit code is being refactored into
> > common code.  So likely this is best handled somewhat there.  Because
> > this can be predicated on CONFIG_ARCH_HAS_SUPERVISOR_PKEYS and handled
> > in a generic fashion.  But that is a ways off I think.
> 
> The invocation of save/restore might be placed in generic code at least
> for the common exception and interrupt entries.

I think you are correct.  I'm testing now...

> 
> > +static void noinstr idt_save_pkrs(idtentry_state_t state)
> 
> *state. See above.

Yep...  :-/

> 
> > +#else
> > +/* Define as macros to prevent conflict of inline and noinstr */
> > +#define idt_save_pkrs(state)
> > +#define idt_restore_pkrs(state)
> 
> Empty inlines do not need noinstr because they are optimized out. If you
> want inlines in a noinstr section then use __always_inline

Peter made the same comment so I've changed to __always_inline.

> 
> >  /**
> >   * idtentry_enter - Handle state tracking on ordinary idtentries
> >   * @regs:	Pointer to pt_regs of interrupted context
> > @@ -604,6 +671,8 @@ idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
> >  		return ret;
> >  	}
> >  
> > +	idt_save_pkrs(ret);
> 
> No. This really has no business to be called before the state is
> established. It's not something horribly urgent and write_pkrs() is NOT
> noinstr and invokes wrmsrl() which is subject to tracing.

I don't understand.  I'm not calling it within intrumentation_{begin,end}() so
does that mean I can remove the noinstr?  I think I can actually.

Or do you mean call it at the end of idtentry_enter()?  Like this:

@@ -672,8 +672,6 @@ idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
                return ret;
        }
 
-       idt_save_pkrs(ret);
-
        /*
         * If this entry hit the idle task invoke rcu_irq_enter() whether
         * RCU is watching or not.
@@ -710,7 +708,7 @@ idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
                instrumentation_end();
 
                ret.exit_rcu = true;
-               return ret;
+               goto done;
        }
 
        /*
@@ -725,6 +723,8 @@ idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
        trace_hardirqs_off();
        instrumentation_end();
 
+done:
+       idt_save_pkrs(&ret);
        return ret;
 }


> 
> > +
> > +	idt_restore_pkrs(state);
> 
> This one is placed correctly.
> 
> Thanks,

No thank you...  I'm really sorry for wasting every ones time on this one.

I'm still processing all your responses so forgive me if I've missed something.
And thank you so much for pointing out my mistake.  That seems to have fixed
all the problems I have seen thus far.  But I want to think on if there may be
more issues.

Thank you,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB029B064
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Oct 2020 15:18:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 709BD1624968B;
	Tue, 27 Oct 2020 07:18:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2186916249688
	for <linux-nvdimm@lists.01.org>; Tue, 27 Oct 2020 07:18:52 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1603808330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bp5AhnmI6jiWnr53CzwF3Og28djxSNnmYmmHL2UuOt8=;
	b=4caFk+lCP6PVdjBxaNFbTnShKMIwXnD+J+z7qE1HQdjW6s3bBKNN3Bs6728AGd9MPL0sTq
	cYISE15GvnXPm9FGyuLiMR+CXo90PPIGeKy4DIMtc3s1N8yEU+cp0JemmMnvP0tmsvjdLD
	Dgt9qUFlO4cIdf888uV1s5K3Wq1JXAGPw04msakKd7SPj/5U5SEsoekRKEZfOjEP+ikZ0v
	roYhgpyqP6twzv+qYS4VFH5HHtA9R8ZukptrIJi9OkB7HMo5cY7HJ0fR8aK5O+PQSYaZkP
	N7NhwIvmvA2WYXJ0FhoK7NEbPHOL9li9UV0eZaQcxedHi6C0wLyEmpV5NFsQmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1603808330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bp5AhnmI6jiWnr53CzwF3Og28djxSNnmYmmHL2UuOt8=;
	b=lTRRlHFYQ0djlr+fFdTRbzmeeMFyKa1T2J8cQAjJqIC+Llz0DlhTmFB4EFQ6PWRoIWCjfH
	dmJid13IGhNMJAAA==
To: Ira Weiny <ira.weiny@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 06/10] x86/entry: Move nmi entry/exit into common code
In-Reply-To: <20201027070750.GM534324@iweiny-DESK2.sc.intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com> <20201022222701.887660-7-ira.weiny@intel.com> <874kmk6298.fsf@nanos.tec.linutronix.de> <20201027070750.GM534324@iweiny-DESK2.sc.intel.com>
Date: Tue, 27 Oct 2020 15:18:50 +0100
Message-ID: <87pn5321md.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: ANWHQXBCQW5RKHIFEO2TMDPR5KMYVZXC
X-Message-ID-Hash: ANWHQXBCQW5RKHIFEO2TMDPR5KMYVZXC
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ANWHQXBCQW5RKHIFEO2TMDPR5KMYVZXC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 27 2020 at 00:07, Ira Weiny wrote:
> On Fri, Oct 23, 2020 at 11:50:11PM +0200, Thomas Gleixner wrote:
>> >  #ifndef irqentry_state
>> >  typedef struct irqentry_state {
>> > -	bool	exit_rcu;
>> > +	union {
>> > +		bool	exit_rcu;
>> > +		bool	lockdep;
>> > +	};
>> >  } irqentry_state_t;
>> >  #endif
>> 
>>   -E_NO_KERNELDOC
>
> Adding: Paul McKenney
>
> I'm happy to write something but I'm very unfamiliar with this code.  So I'm
> getting confused what exactly exit_rcu is flagging.
>
> I can see that exit_rcu is a bad name for the state used in
> irqentry_nmi_[enter|exit]().  Furthermore, I see why 'lockdep' is a better
> name.  But similar lockdep handling is used in irqentry_exit() if exit_rcu is
> true...

No, it's not similar at all. Lockdep state vs. interrupts and regular
exceptions is always consistent.

In the NMI case, that's not guaranteed because of

       local_irq_disable()
         arch_local_irq_disable()
                                        <- NMI race window
         trace_hardirqs_off()

same the other way round

       local_irq_enable()
         trace_hardirqs_on()
                                        <- NMI race window
         arch_local_irq_enable()

IOW, the hardware state and the lockdep state are not consistent.

> /**
>  * struct irqentry_state - Opaque object for exception state storage
>  * @exit_rcu: Used exclusively in the irqentry_*() calls; tracks if the
>  *            exception hit the idle task which requires special handling,
>  *            including calling rcu_irq_exit(), when the exception
>  exits.

calls; signals whether the exit path has to invoke rcu_irq_exit().

>  * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures lockdep
>  *           tracking is maintained if hardirqs were already enabled

   ensures that lockdep state is restored correctly on exit from nmi.

>  *
>  * This opaque object is filled in by the irqentry_*_enter() functions and
>  * should be passed back into the corresponding irqentry_*_exit()
>  functions

s/should/must/

>  * when the exception is complete.
>  *
>  * Callers of irqentry_*_[enter|exit]() should consider this structure
>  opaque

s/should/must/

>  * and all members private.  Descriptions of the members are provided to aid in
>  * the maintenance of the irqentry_*() functions.
>  */
>
> Perhaps Paul can enlighten me on how exit_rcu is used beyond just flagging a
> call to rcu_irq_exit()?

I can do that as well :) The only purpose is to invoke rcu_irq_exit()
conditionally.

> Why do we call lockdep_hardirqs_off() only when in the idle task?  That implies
> that regs_irqs_disabled() can only be false if we were in the idle task to
> match up the lockdep on/off calls.

You're reading the code slightly wrong.

> This does not make sense to me because why do we need the extra check
> for exit_rcu?  I'm still trying to understand when regs_irqs_disabled() is false.

It's false when the interrupted context had interrupts enabled.

So we have the following scenarios:

 Usermode   Idletask   irqs enabled  RCU entry  RCU exit
   Y           N           Y		Y          Y

   N           N           Y            N          N 
   N           N           N            N          N
   N           Y           Y            Y          Y
   N           Y           N            Y          Y                       

Now you might wonder about irqs enabled/disabled. This code is not only
used for interrupts (device, ipi, local timer...) where interrupts are
obviously enabled, it's also used for exception entry/exit. You can have
e.g. pagefaults in interrupt disabled regions.

> Also, the comment in irqentry_enter() refers to irq_enter_from_user_mode() which
> does not seem to exist anymore.  So I'm not sure what careful sequence it is
> referring to.

That was renamed to irqentry_enter_from_user_mode() and the comment was
not updated. Sorry for leaving this hard to solve puzzle around.

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

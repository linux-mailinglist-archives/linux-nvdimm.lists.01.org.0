Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA78F22B6FB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 21:53:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB27D1251F036;
	Thu, 23 Jul 2020 12:53:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8F7DF1251F035
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 12:53:23 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1595534000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X0c32+NIatB9JM6CXey+0z41GiQlbz97j0f7TqXtlAY=;
	b=uFXjXbf4Yp8aNwTNbxJjHuHwYks2TWbYKgxnG7Jr1JWxhF+duZctOadDtngKL2Pntdlcr5
	AvKP6qpAvouuuiV9yCUIMDIlbTkuWxZoD7TQabGmbTA0mjtTK30eJeHRVEjwqxpk03fPUS
	tTHuvjt5xvqU5prBd0+EqsNeg67IAnB6WbSAufCh1h3bnSTSGxuR6+oxKhzw+WygKCqZiO
	DzSskQq90BXIC5ugNwOtkIPpZNUuGtTQ2f/N1n2GVcGCN+TQeOR0jfxYFV4o6wzageqeaB
	yb7Im752qEUzAhYy4YEc/rgs/zaCt1/1hFkXqJTndrZAWzomDhEhunfLRUOtbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1595534000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X0c32+NIatB9JM6CXey+0z41GiQlbz97j0f7TqXtlAY=;
	b=IP9QMcXa1ApuQm3+KZmrUmtJj6z7QxJxyk9fPf+kLhbrZgzz7HlWKdlTZhcyEP2iMZoUqw
	PGdJS5nkBsmndqAQ==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <20200717072056.73134-18-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com>
Date: Thu, 23 Jul 2020 21:53:20 +0200
Message-ID: <87r1t2vwi7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: ZHDKNQD6R5LAZMNWVBVXPLKSLS5GTV7F
X-Message-ID-Hash: ZHDKNQD6R5LAZMNWVBVXPLKSLS5GTV7F
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZHDKNQD6R5LAZMNWVBVXPLKSLS5GTV7F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira,

ira.weiny@intel.com writes:

> ...
> 	// ref == 0
> 	dev_access_enable()  // ref += 1 ==> disable protection
> 		irq()
> 			// enable protection
> 			// ref = 0
> 			_handler()
> 				dev_access_enable()   // ref += 1 ==> disable protection
> 				dev_access_disable()  // ref -= 1 ==> enable protection
> 			// WARN_ON(ref != 0)
> 			// disable protection
> 	do_pmem_thing()  // all good here
> 	dev_access_disable() // ref -= 1 ==> 0 ==> enable protection

...

> First I'm not sure if adding this state to idtentry_state and having
> that state copied is the right way to go.

Adding the state to idtentry_state is fine at least for most interrupts
and exceptions. Emphasis on most.

#PF does not work because #PF can schedule.

> It seems like we should start passing this by reference instead of
> value.  But for now this works as an RFC.  Comments?

Works as in compiles, right?

static void noinstr idt_save_pkrs(idtentry_state_t state)
{
        state.foo = 1;
}

How is that supposed to change the caller state? C programming basics.

> Second, I'm not 100% happy with having to save the reference count in
> the exception handler.  It seems like a very ugly layering violation but
> I don't see a way around it at the moment.

That state is strict per task, right? So why do you want to store it
anywhere else that in task/thread storage. That solves your problem of
#PF scheduling nicely.

> Third, this patch has gone through a couple of revisions as I've had
> crashes which just don't make sense to me.  One particular issue I've
> had is taking a MCE during memcpy_mcsafe causing my WARN_ON() to fire.
> The code path was a pmem copy and the ref count should have been
> elevated due to dev_access_enable() but why was
> idtentry_enter()->idt_save_pkrs() not called I don't know.

Because #MC does not go through idtentry_enter(). Neither do #NMI, #DB, #BP.

> Finally, it looks like the entry/exit code is being refactored into
> common code.  So likely this is best handled somewhat there.  Because
> this can be predicated on CONFIG_ARCH_HAS_SUPERVISOR_PKEYS and handled
> in a generic fashion.  But that is a ways off I think.

The invocation of save/restore might be placed in generic code at least
for the common exception and interrupt entries.

> +static void noinstr idt_save_pkrs(idtentry_state_t state)

*state. See above.

> +#else
> +/* Define as macros to prevent conflict of inline and noinstr */
> +#define idt_save_pkrs(state)
> +#define idt_restore_pkrs(state)

Empty inlines do not need noinstr because they are optimized out. If you
want inlines in a noinstr section then use __always_inline

>  /**
>   * idtentry_enter - Handle state tracking on ordinary idtentries
>   * @regs:	Pointer to pt_regs of interrupted context
> @@ -604,6 +671,8 @@ idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
>  		return ret;
>  	}
>  
> +	idt_save_pkrs(ret);

No. This really has no business to be called before the state is
established. It's not something horribly urgent and write_pkrs() is NOT
noinstr and invokes wrmsrl() which is subject to tracing.

> +
> +	idt_restore_pkrs(state);

This one is placed correctly.

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

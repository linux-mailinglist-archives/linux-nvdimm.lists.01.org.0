Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AFB22D315
	for <lists+linux-nvdimm@lfdr.de>; Sat, 25 Jul 2020 02:09:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C73C12588427;
	Fri, 24 Jul 2020 17:09:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E18C12588426
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jul 2020 17:09:14 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id E06F420768
	for <linux-nvdimm@lists.01.org>; Sat, 25 Jul 2020 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595635754;
	bh=btOIZU1MW+6PlkkqDJUz7DcCUStR/8qT0xAu53GlQ6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sxS88DZLD1Ub3RW0YPgyikY7BDShzwcfepCzbZBjkaqBJP77hyvnz9aXpp551L9Pb
	 zU2WTGc5yM4bV7AnuKssI6OXXS3oITRb+uD4VVa0gWA1nxKyleZhPlLV48Zgna5QtC
	 kYQUX5BdvbpUC+Yv/uFXlOSxeVLIjzbZ7mfuQHwg=
Received: by mail-wm1-f50.google.com with SMTP id 9so9280597wmj.5
        for <linux-nvdimm@lists.01.org>; Fri, 24 Jul 2020 17:09:13 -0700 (PDT)
X-Gm-Message-State: AOAM531jVbI9db/jr/C6hoecRSsYJhd0wfDWJGFxuS7nWarrINNuN3yI
	YRH4ecM53kSrHFsWq4gmx7lDBZYCF3/OKNjfVapfqg==
X-Google-Smtp-Source: ABdhPJzODXWRSR4bEqjZdQmjvnAm94COixhWx/ZHwpxi601Bsr0u6vIlMnxzH7evHcvtBmUNUEDn46VTXFtuOAxUs7I=
X-Received: by 2002:a1c:56c3:: with SMTP id k186mr10711218wmb.21.1595635752371;
 Fri, 24 Jul 2020 17:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com>
 <87r1t2vwi7.fsf@nanos.tec.linutronix.de> <20200723220435.GI844235@iweiny-DESK2.sc.intel.com>
 <87mu3pvly7.fsf@nanos.tec.linutronix.de> <874kpwtxlh.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kpwtxlh.fsf@nanos.tec.linutronix.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 24 Jul 2020 17:09:00 -0700
X-Gmail-Original-Message-ID: <CALCETrXM1q664Udfq-LnU8SaUxSn-S+FkFRP1M9n3Aav9bjChA@mail.gmail.com>
Message-ID: <CALCETrXM1q664Udfq-LnU8SaUxSn-S+FkFRP1M9n3Aav9bjChA@mail.gmail.com>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
To: Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Message-ID-Hash: PDC3THDU3AZDUD5KCBIBKLWXJ7WFKUSQ
X-Message-ID-Hash: PDC3THDU3AZDUD5KCBIBKLWXJ7WFKUSQ
X-MailFrom: luto@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PDC3THDU3AZDUD5KCBIBKLWXJ7WFKUSQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 24, 2020 at 2:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
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
>
>   2) On idtentry you store the key on entry in idtentry_state, clear it
>      in the MSR and shadow state if necessary and restore it on exit.
>
>   3) On context switch out you save the per CPU cache value in the task
>      and on context switch in you restore it from there.
>
> Yes, that works (see below for #2) and sorry for my confusion yesterday
> about storing this in task state.
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
>         idtentry_state_t state = {};
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
> #UD and #PF are using the raw entry variant as well but still invoke
> idtentry_enter()/exit(). #PF does not need any work. #UD handles
> WARN/BUG without going through idtentry_enter() first, but I don't think
> that's an issue unless a not 0 key would prevent writing to the console
> device. You surely can figure that out.

Putting on my mm maintainer hat for a moment, I really think that we
want oopses to print PKRS along with all the other registers when we
inevitably oops due to a page fault.  And we probably also want it in
the nasty nested case where we get infinite page faults and eventually
double fault.

I'm sure it's *possible* to wire this up if we stick it in
idtentry_state, but it's trivial if we stick it in pt_regs.  I'm okay
with doing the save/restore in C (in fact, I prefer that), but I think
that either the value should be stuck in pt_regs or we should find a
way to teach the unwinder to locate idtentry_state.

And, if we go with idtentry_state, we should make a signature change
to nmi_enter() to also provide idtentry_state or some equivalent
object.

--Andy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

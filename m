Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E592DB8C2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 03:09:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D80DC100EF270;
	Tue, 15 Dec 2020 18:09:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6FFE6100EF25F
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 18:09:15 -0800 (PST)
X-Gm-Message-State: AOAM5319KkPpR68pMa/fW7W/CyNOf874jZLmXjimphISO3HudgAMyG1W
	mflgCh+S3Vr58fSfJ0kRMANSXr6veaIk5h3vsVPfUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1608084555;
	bh=lNceg3zsRQIJnHCRAuvzGZav5VoW/sPjJj297FNCEIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OQgvnVaNI74sIqAfu9tmH08B02FGdjlECv5YoeVvShFftLtYz/cLruALfnrNvXjbp
	 Mu9i65y0fvsv0t8FB4dfnHVaXipGvQT80YnYUP9ZpHiAucTpbHUaMQgSKOXxRwzaXx
	 QJQDPuKMG8IjA2mGXjl8ullNqLdoMRqqnWq/r3K/8jxwh4/0f59ApGZKJFwlop9xKk
	 /UHjRKgQ3DOGzxOmQes6i0nGlIa9dGA37ciHhbUXXOI8JSqi14ml4VmeKyqiXviYsz
	 j27PBrLe2PKfLk6Hq1oqx8tgkGTpP1GOLLg5RLdrHVIW9k0cqngQIILI7dARy2KC5O
	 WmMT43NQvGRYw==
X-Google-Smtp-Source: ABdhPJxF4IgLZo1zLMG6fgv3Y/r/6cEkD+J3Xjpg+eE9MJVMRCyPOEp4KttaWYdIQQlTeDz1jvZ23DX6Z/Spj4LR1ck=
X-Received: by 2002:adf:e64b:: with SMTP id b11mr35857878wrn.257.1608084553468;
 Tue, 15 Dec 2020 18:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20201106232908.364581-6-ira.weiny@intel.com> <20201124060956.1405768-1-ira.weiny@intel.com>
 <CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com> <20201216013202.GY1563847@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201216013202.GY1563847@iweiny-DESK2.sc.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 15 Dec 2020 18:09:02 -0800
X-Gmail-Original-Message-ID: <CALCETrWoh5BYnU16adT7i6tsQ77PGaLN_qyZnCy-WfO3UJoykw@mail.gmail.com>
Message-ID: <CALCETrWoh5BYnU16adT7i6tsQ77PGaLN_qyZnCy-WfO3UJoykw@mail.gmail.com>
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
To: Ira Weiny <ira.weiny@intel.com>
Message-ID-Hash: YEWZXVMQE6EXMCB7T3YYPBVR6SC5CZUH
X-Message-ID-Hash: YEWZXVMQE6EXMCB7T3YYPBVR6SC5CZUH
X-MailFrom: luto@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YEWZXVMQE6EXMCB7T3YYPBVR6SC5CZUH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 15, 2020 at 5:32 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Dec 11, 2020 at 02:14:28PM -0800, Andy Lutomirski wrote:
> > On Mon, Nov 23, 2020 at 10:10 PM <ira.weiny@intel.com> wrote:

> > IOW we have:
> >
> > struct extended_pt_regs {
> >   bool rcu_whatever;
> >   other generic fields here;
> >   struct arch_extended_pt_regs arch_regs;
> >   struct pt_regs regs;
> > };
> >
> > and arch_extended_pt_regs has unsigned long pks;
> >
> > and instead of passing a pointer to irqentry_state_t to the generic
> > entry/exit code, we just pass a pt_regs pointer.  And we have a little
> > accessor like:
> >
> > struct extended_pt_regs *extended_regs(struct pt_regs *) { return
> > container_of(...); }
> >
> > And we tell eBPF that extended_pt_regs is NOT ABI, and we will change
> > it whenever we feel like just to keep you on your toes, thank you very
> > much.
> >
> > Does this seem reasonable?
>
> Conceptually yes.  But I'm failing to see how this implementation can be made
> generic for the generic fields.  The pks fields, assuming they stay x86
> specific, would be reasonable to add in PUSH_AND_CLEAR_REGS.  But the
> rcu/lockdep field is generic.  Wouldn't we have to modify every architecture to
> add space for the rcu/lockdep bool?
>
> If not, where is a generic place that could be done?  Basically I'm missing how
> the effective stack structure can look like this:
>
> > struct extended_pt_regs {
> >   bool rcu_whatever;
> >   other generic fields here;
> >   struct arch_extended_pt_regs arch_regs;
> >   struct pt_regs regs;
> > };
>
> It seems more reasonable to make it look like:
>
> #ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> struct extended_pt_regs {
>         unsigned long pkrs;
>         struct pt_regs regs;
> };
> #endif
>
> And leave the rcu/lockdep bool passed by value as before (still in C).

We could certainly do this, but we could also allocate some generic
space.  PUSH_AND_CLEAR_REGS would get an extra instruction like:

subq %rsp, $GENERIC_PTREGS_SIZE

or however this should be written.  That field would be defined in
asm-offsets.c.  And yes, all the generic-entry architectures would
need to get onboard.

If we wanted to be fancy, we could split the generic area into
initialize-to-zero and uninitialized for debugging purposes, but that
might be more complication than is worthwhile.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

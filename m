Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265962DD204
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 14:19:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84D57100EBB8F;
	Thu, 17 Dec 2020 05:19:48 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B599100EBB67
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 05:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ki9FXUcA/jS53jop1ttnv7UISCrAaFpfQpHTD7Zfflc=; b=L8h4Yi/u8flONjvNDbffLQl69p
	AVHTgDEHkjVbzg1ZBlYJikolD2maAnDufsFyn3T0vrw42EF45cq7xWNAAR3TqrmyPYtIq4P8mcrRA
	u7JZLPBNfub/3RPbtAYDLcKM3Vf6OSBtfpuLF2M5d6hZziKU8BSV/1dssN7ZQoMd7x9WSRSgSzcVI
	faug25WQmxTZnjjjcQ1koe4iwrWpbYSJ2D4qk+sp9Wf0NI2CPs82tcFwT7kaTEKuqKEXh61xjXOvl
	yzmSxmiqX6OLALXHsYIXlQUaTeMcaVyGhIMeiTqozXX1r3Q2nMjXP7+f6SXui8dE+xztrdQU6TAlf
	DtE4PMnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kptBm-0005SF-PQ; Thu, 17 Dec 2020 13:19:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F157B300446;
	Thu, 17 Dec 2020 14:19:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5DF3202395D6; Thu, 17 Dec 2020 14:19:24 +0100 (CET)
Date: Thu, 17 Dec 2020 14:19:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
Message-ID: <20201217131924.GW3040@hirez.programming.kicks-ass.net>
References: <20201106232908.364581-6-ira.weiny@intel.com>
 <20201124060956.1405768-1-ira.weiny@intel.com>
 <CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com>
 <878s9wshsa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878s9wshsa.fsf@nanos.tec.linutronix.de>
Message-ID-Hash: OIETYDQD377OZ2UQWTLUM3MYTNBQS7BQ
X-Message-ID-Hash: OIETYDQD377OZ2UQWTLUM3MYTNBQS7BQ
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OIETYDQD377OZ2UQWTLUM3MYTNBQS7BQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 17, 2020 at 02:07:01PM +0100, Thomas Gleixner wrote:
> On Fri, Dec 11 2020 at 14:14, Andy Lutomirski wrote:
> > On Mon, Nov 23, 2020 at 10:10 PM <ira.weiny@intel.com> wrote:
> > After contemplating this for a bit, I think this isn't really the
> > right approach.  It *works*, but we've mostly just created a bit of an
> > unfortunate situation.  Our stack, on a (possibly nested) entry looks
> > like:
> >
> > previous frame (or empty if we came from usermode)
> > ---
> > SS
> > RSP
> > FLAGS
> > CS
> > RIP
> > rest of pt_regs
> >
> > C frame
> >
> > irqentry_state_t (maybe -- the compiler is within its rights to play
> > almost arbitrary games here)
> >
> > more C stuff
> >
> > So what we've accomplished is having two distinct arch register
> > regions, one called pt_regs and the other stuck in irqentry_state_t.
> > This is annoying because it means that, if we want to access this
> > thing without passing a pointer around or access it at all from outer
> > frames, we need to do something terrible with the unwinder, and we
> > don't want to go there.
> >
> > So I propose a somewhat different solution: lay out the stack like this.
> >
> > SS
> > RSP
> > FLAGS
> > CS
> > RIP
> > rest of pt_regs
> > PKS
> > ^^^^^^^^ extended_pt_regs points here
> >
> > C frame
> > more C stuff
> > ...
> >
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
> > entry/exit code, we just pass a pt_regs pointer.
> 
> While I agree vs. PKS which is architecture specific state and needed in
> other places e.g. #PF, I'm not convinced that sticking the existing
> state into the same area buys us anything more than an indirect access.
> 
> Peter?

Agreed; that immediately solves the confusion Ira had as well. While
extending pt_regs sounds scary, I think we've isolated our pt_regs
implementation from actual ABI pretty well, but of course, that would
need an audit. We don't want to leak this into signals for example.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE852DCA05
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 01:38:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 79BFE100EBB62;
	Wed, 16 Dec 2020 16:38:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BEA27100EBBD9
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 16:38:41 -0800 (PST)
IronPort-SDR: CQXYeiAoERI3/iCLVYZk75qc2mIVV/uRafXsB9YUTg5jbfxBnUiJyFjj1GWioICdHK8ozxeb97
 RTN8emK6Ghzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="162905082"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400";
   d="scan'208";a="162905082"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 16:38:36 -0800
IronPort-SDR: NimDuO3JSSCaVpcE48OB6QWQniCI0fiXPNzekJI5l7NmE3AKdZihNJaKV633ov9z2pi3EL+dvK
 tZn+LkRliH4A==
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400";
   d="scan'208";a="369434314"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 16:38:36 -0800
Date: Wed, 16 Dec 2020 16:38:36 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
Message-ID: <20201217003835.GZ1563847@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-6-ira.weiny@intel.com>
 <20201124060956.1405768-1-ira.weiny@intel.com>
 <CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com>
 <20201216013202.GY1563847@iweiny-DESK2.sc.intel.com>
 <CALCETrWoh5BYnU16adT7i6tsQ77PGaLN_qyZnCy-WfO3UJoykw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrWoh5BYnU16adT7i6tsQ77PGaLN_qyZnCy-WfO3UJoykw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: TRK44RITM7JTP5HKMEKPTHMNOFYYWF7V
X-Message-ID-Hash: TRK44RITM7JTP5HKMEKPTHMNOFYYWF7V
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TRK44RITM7JTP5HKMEKPTHMNOFYYWF7V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 15, 2020 at 06:09:02PM -0800, Andy Lutomirski wrote:
> On Tue, Dec 15, 2020 at 5:32 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Fri, Dec 11, 2020 at 02:14:28PM -0800, Andy Lutomirski wrote:
> > > On Mon, Nov 23, 2020 at 10:10 PM <ira.weiny@intel.com> wrote:
> 
> > > IOW we have:
> > >
> > > struct extended_pt_regs {
> > >   bool rcu_whatever;
> > >   other generic fields here;
> > >   struct arch_extended_pt_regs arch_regs;
> > >   struct pt_regs regs;
> > > };
> > >
> > > and arch_extended_pt_regs has unsigned long pks;
> > >
> > > and instead of passing a pointer to irqentry_state_t to the generic
> > > entry/exit code, we just pass a pt_regs pointer.  And we have a little
> > > accessor like:
> > >
> > > struct extended_pt_regs *extended_regs(struct pt_regs *) { return
> > > container_of(...); }
> > >
> > > And we tell eBPF that extended_pt_regs is NOT ABI, and we will change
> > > it whenever we feel like just to keep you on your toes, thank you very
> > > much.
> > >
> > > Does this seem reasonable?
> >
> > Conceptually yes.  But I'm failing to see how this implementation can be made
> > generic for the generic fields.  The pks fields, assuming they stay x86
> > specific, would be reasonable to add in PUSH_AND_CLEAR_REGS.  But the
> > rcu/lockdep field is generic.  Wouldn't we have to modify every architecture to
> > add space for the rcu/lockdep bool?
> >
> > If not, where is a generic place that could be done?  Basically I'm missing how
> > the effective stack structure can look like this:
> >
> > > struct extended_pt_regs {
> > >   bool rcu_whatever;
> > >   other generic fields here;
> > >   struct arch_extended_pt_regs arch_regs;
> > >   struct pt_regs regs;
> > > };
> >
> > It seems more reasonable to make it look like:
> >
> > #ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > struct extended_pt_regs {
> >         unsigned long pkrs;
> >         struct pt_regs regs;
> > };
> > #endif
> >
> > And leave the rcu/lockdep bool passed by value as before (still in C).
> 
> We could certainly do this,

I'm going to start with this basic support.  Because I have 0 experience in
most of these architectures.

> but we could also allocate some generic
> space.  PUSH_AND_CLEAR_REGS would get an extra instruction like:
> 
> subq %rsp, $GENERIC_PTREGS_SIZE
> 
> or however this should be written.  That field would be defined in
> asm-offsets.c.  And yes, all the generic-entry architectures would
> need to get onboard.

What do you mean by 'generic-entry' architectures?  I thought they all used the
generic entry code?

Regardless I would need to start another thread on this topic with any of those
architecture maintainers to see what the work load would be for this.  I don't
think I can do it on my own.

FWIW I think it is a bit unfair to hold up the PKS support in x86 for making
these generic fields part of the stack frame.  So perhaps that could be made a
follow on to the PKS series?

> 
> If we wanted to be fancy, we could split the generic area into
> initialize-to-zero and uninitialized for debugging purposes, but that
> might be more complication than is worthwhile.

Ok, agreed, but this is step 3 or 4 at the earliest.

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

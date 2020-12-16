Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A32DB873
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 02:32:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF1AD100EF276;
	Tue, 15 Dec 2020 17:32:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85BF9100EF274
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 17:32:03 -0800 (PST)
IronPort-SDR: z5ucAPAhx2+zbj7XX7M57RKmEPeFrg4k6FaULRcluFBr/6ZcCkfSKjn3r/1Xyce5hVCQ4d+VTo
 mdZHmVECZB8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="236562435"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400";
   d="scan'208";a="236562435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 17:32:03 -0800
IronPort-SDR: d6lhH0B+2vSUvdB6NEQiIM+Un2oxj5uMBv0Ozu8J9mxlcQ0Z74FISITogfXPZ4MOBeFHSqM+R8
 PmnQn8xXDcPQ==
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400";
   d="scan'208";a="337910276"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 17:32:02 -0800
Date: Tue, 15 Dec 2020 17:32:02 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
Message-ID: <20201216013202.GY1563847@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-6-ira.weiny@intel.com>
 <20201124060956.1405768-1-ira.weiny@intel.com>
 <CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrUHwZPic89oExMMe-WyDY8-O3W68NcZvse3=PGW+iW5=w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 5PMK7OQL2P3CZLDLAHG6I2LADCOUW3N6
X-Message-ID-Hash: 5PMK7OQL2P3CZLDLAHG6I2LADCOUW3N6
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5PMK7OQL2P3CZLDLAHG6I2LADCOUW3N6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 11, 2020 at 02:14:28PM -0800, Andy Lutomirski wrote:
> On Mon, Nov 23, 2020 at 10:10 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Currently struct irqentry_state_t only contains a single bool value
> > which makes passing it by value is reasonable.  However, future patches
> > add information to this struct.  This includes the PKRS thread state,
> > included in this series, as well as information to store kmap reference
> > tracking and PKS global state outside this series.  In total, we
> > anticipate 2 new 32 bit fields and an integer field to be added to the
> > struct beyond the existing bool value.
> >
> > Adding information to irqentry_state_t makes passing by value less
> > efficient.  Therefore, change the entry/exit calls to pass irq_state by
> > reference in preparation for the changes which follow.
> >
> > While at it, make the code easier to follow by changing all the usage
> > sites to consistently use the variable name 'irq_state'.
> 
> After contemplating this for a bit, I think this isn't really the
> right approach.  It *works*, but we've mostly just created a bit of an
> unfortunate situation.

First off please forgive my ignorance on how this code works.

> Our stack, on a (possibly nested) entry looks
> like:
> 
> previous frame (or empty if we came from usermode)
> ---
> SS
> RSP
> FLAGS
> CS
> RIP
> rest of pt_regs
> 
> C frame
> 
> irqentry_state_t (maybe -- the compiler is within its rights to play
> almost arbitrary games here)
> 
> more C stuff
> 
> 
> So what we've accomplished is having two distinct arch register
> regions, one called pt_regs and the other stuck in irqentry_state_t.
> This is annoying because it means that, if we want to access this
> thing without passing a pointer around or access it at all from outer
> frames, we need to do something terrible with the unwinder, and we
> don't want to go there.
> 
> So I propose a somewhat different solution: lay out the stack like this.
> 
> SS
> RSP
> FLAGS
> CS
> RIP
> rest of pt_regs
> PKS
> ^^^^^^^^ extended_pt_regs points here
> 
> C frame
> more C stuff
> ...
> 
> IOW we have:
> 
> struct extended_pt_regs {
>   bool rcu_whatever;
>   other generic fields here;
>   struct arch_extended_pt_regs arch_regs;
>   struct pt_regs regs;
> };
> 
> and arch_extended_pt_regs has unsigned long pks;
> 
> and instead of passing a pointer to irqentry_state_t to the generic
> entry/exit code, we just pass a pt_regs pointer.  And we have a little
> accessor like:
> 
> struct extended_pt_regs *extended_regs(struct pt_regs *) { return
> container_of(...); }
> 
> And we tell eBPF that extended_pt_regs is NOT ABI, and we will change
> it whenever we feel like just to keep you on your toes, thank you very
> much.
> 
> Does this seem reasonable?

Conceptually yes.  But I'm failing to see how this implementation can be made
generic for the generic fields.  The pks fields, assuming they stay x86
specific, would be reasonable to add in PUSH_AND_CLEAR_REGS.  But the
rcu/lockdep field is generic.  Wouldn't we have to modify every architecture to
add space for the rcu/lockdep bool?

If not, where is a generic place that could be done?  Basically I'm missing how
the effective stack structure can look like this:

> struct extended_pt_regs {
>   bool rcu_whatever;
>   other generic fields here;
>   struct arch_extended_pt_regs arch_regs;
>   struct pt_regs regs;
> };

It seems more reasonable to make it look like:

#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
struct extended_pt_regs {
	unsigned long pkrs;
	struct pt_regs regs;
};
#endif

And leave the rcu/lockdep bool passed by value as before (still in C).

Is that what you mean?  Or am I missing something with the way pt_regs is set
up?  Which is entirely possible because I'm pretty ignorant about how this code
works...  :-/

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

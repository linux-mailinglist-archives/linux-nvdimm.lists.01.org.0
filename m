Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C37292F60
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Oct 2020 22:27:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C45E715EF4BFF;
	Mon, 19 Oct 2020 13:27:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A38DA15EF4BFE
	for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 13:26:58 -0700 (PDT)
IronPort-SDR: pqSBKluQB/9XPVe7ThIXF/IDd/MZQu6f/72bQX0/0wgyF9EZUzfL+xb4fwD4lwB9XEf4PH4TJ2
 sg1TIjtHliEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="164484789"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400";
   d="scan'208";a="164484789"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 13:26:48 -0700
IronPort-SDR: SgB75YQa+F2iajmvUwI65OmEVIx+I01kcvx0mKBDuURPbpXUjIoi32NAdRXxv8Fn4Nuvmc21LQ
 OPUZr38TIc1g==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400";
   d="scan'208";a="523235144"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 13:26:48 -0700
Date: Mon, 19 Oct 2020 13:26:47 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC V3 6/9] x86/entry: Pass irqentry_state_t by reference
Message-ID: <20201019202647.GD3713473@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-7-ira.weiny@intel.com>
 <20201016114510.GO2611@hirez.programming.kicks-ass.net>
 <87lfg6tjnq.fsf@nanos.tec.linutronix.de>
 <20201019053639.GA3713473@iweiny-DESK2.sc.intel.com>
 <87k0vma7ct.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k0vma7ct.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: T5MFI4D2BH6XXFNW7GH7O5FBKUUGPBSF
X-Message-ID-Hash: T5MFI4D2BH6XXFNW7GH7O5FBKUUGPBSF
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T5MFI4D2BH6XXFNW7GH7O5FBKUUGPBSF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 19, 2020 at 11:32:50AM +0200, Thomas Gleixner wrote:
> On Sun, Oct 18 2020 at 22:37, Ira Weiny wrote:
> > On Fri, Oct 16, 2020 at 02:55:21PM +0200, Thomas Gleixner wrote:
> >> Subject: x86/entry: Move nmi entry/exit into common code
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> Date: Fri, 11 Sep 2020 10:09:56 +0200
> >> 
> >> Add blurb here.
> >
> > How about:
> >
> > To prepare for saving PKRS values across NMI's we lift the
> > idtentry_[enter|exit]_nmi() to the common code.  Rename them to
> > irqentry_nmi_[enter|exit]() to reflect the new generic nature and store the
> > state in the same irqentry_state_t structure as the other irqentry_*()
> > functions.  Finally, differentiate the state being stored between the NMI and
> > IRQ path by adding 'lockdep' to irqentry_state_t.
> 
> No. This has absolutely nothing to do with PKRS. It's a cleanup valuable
> by itself and that's how it should have been done right away.
> 
> So the proper changelog is:
> 
>   Lockdep state handling on NMI enter and exit is nothing specific to
>   X86. It's not any different on other architectures. Also the extra
>   state type is not necessary, irqentry_state_t can carry the necessary
>   information as well.
> 
>   Move it to common code and extend irqentry_state_t to carry lockdep
>   state.

Ok sounds good, thanks.

> 
> >> --- a/include/linux/entry-common.h
> >> +++ b/include/linux/entry-common.h
> >> @@ -343,6 +343,7 @@ void irqentry_exit_to_user_mode(struct p
> >>  #ifndef irqentry_state
> >>  typedef struct irqentry_state {
> >>  	bool	exit_rcu;
> >> +	bool	lockdep;
> >>  } irqentry_state_t;
> >
> > Building on what Peter said do you agree this should be made into a union?
> >
> > It may not be strictly necessary in this patch but I think it would reflect the
> > mutual exclusivity better and could be changed easy enough in the follow on
> > patch which adds the pkrs state.
> 
> Why the heck should it be changed in a patch which adds something
> completely different?

Because the PKRS stuff is used in both NMI and IRQ state.

> 
> Either it's mutually exclusive or not and if so it want's to be done in
> this patch and not in a change which extends the struct for other
> reasons.

Sorry, let me clarify.  After this patch we have.

typedef union irqentry_state {
	bool	exit_rcu;
	bool	lockdep;
} irqentry_state_t;

Which reflects the mutual exclusion of the 2 variables.

But then when the pkrs stuff is added the union changes back to a structure and
looks like this.

typedef struct irqentry_state {
#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
        u32 pkrs;
        u32 thread_pkrs;
#endif  
	union {
		bool    exit_rcu;
		bool	lockdep;
	};
} irqentry_state_t;

Because the pkrs information is in addition to exit_rcu OR lockdep.

So this is what I meant by 'could be changed easy enough in the follow on
patch'.

Is that clear?

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

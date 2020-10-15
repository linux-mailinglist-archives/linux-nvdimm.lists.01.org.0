Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF6328EBBD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Oct 2020 05:46:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08D79159E6B8D;
	Wed, 14 Oct 2020 20:46:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C83FF159E6B8A
	for <linux-nvdimm@lists.01.org>; Wed, 14 Oct 2020 20:46:46 -0700 (PDT)
IronPort-SDR: hy7zsUm2NS4FS1Ap9tpA4iWc+p50j/cV8YZM08JvD6erh9QGvvdbJhdpE+ZTuf2lFiK3XJi+o/
 GGlDrylhCVjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="163619583"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400";
   d="scan'208";a="163619583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 20:46:45 -0700
IronPort-SDR: frVKPMJAzb1m9jivZ/XfXNx7VCqDkNNADy0hOKKQpIfrYnJ8mOjxbWGy/FPBq9IrrLYbuNMuZF
 XeLLSEBZdFVw==
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400";
   d="scan'208";a="531094057"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 20:46:45 -0700
Date: Wed, 14 Oct 2020 20:46:45 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V3 7/9] x86/entry: Preserve PKRS MSR across exceptions
Message-ID: <20201015034645.GQ2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-8-ira.weiny@intel.com>
 <6006a4c8-32bd-04ca-95cc-b2736a5cef72@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6006a4c8-32bd-04ca-95cc-b2736a5cef72@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: BWP6S6MJUFMMETDOQJW6ZVQYKQYJBNS4
X-Message-ID-Hash: BWP6S6MJUFMMETDOQJW6ZVQYKQYJBNS4
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BWP6S6MJUFMMETDOQJW6ZVQYKQYJBNS4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 11:52:32AM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> > @@ -341,6 +341,9 @@ noinstr void irqentry_enter(struct pt_regs *regs, irqentry_state_t *state)
> >  	/* Use the combo lockdep/tracing function */
> >  	trace_hardirqs_off();
> >  	instrumentation_end();
> > +
> > +done:
> > +	irq_save_pkrs(state);
> >  }
> 
> One nit: This saves *and* sets PKRS.  It's not obvious from the call
> here that PKRS is altered at this site.  Seems like there could be a
> better name.
> 
> Even if we did:
> 
> 	irq_save_set_pkrs(state, INIT_VAL);
> 
> It would probably compile down to the same thing, but be *really*
> obvious what's going on.

I suppose that is true.  But I think it is odd having a parameter which is the
same for every call site.

But I'm not going to quibble over something like this.

Changed,
Ira

> 
> >  void irqentry_exit_cond_resched(void)
> > @@ -362,7 +365,12 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t *state)
> >  	/* Check whether this returns to user mode */
> >  	if (user_mode(regs)) {
> >  		irqentry_exit_to_user_mode(regs);
> > -	} else if (!regs_irqs_disabled(regs)) {
> > +		return;
> > +	}
> > +
> > +	irq_restore_pkrs(state);
> > +
> > +	if (!regs_irqs_disabled(regs)) {
> >  		/*
> >  		 * If RCU was not watching on entry this needs to be done
> >  		 * carefully and needs the same ordering of lockdep/tracing
> > 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

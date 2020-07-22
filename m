Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F81228FA9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jul 2020 07:27:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 635D91247B8F8;
	Tue, 21 Jul 2020 22:27:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B96B41247FDB9
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 22:27:10 -0700 (PDT)
IronPort-SDR: I4nAQaldj7OlW1+ryN267wqKvSymynKGTcxs2kk/jyb1A3I6uKmlPPQVcXG2o3mGVWLfNaNc0w
 isofdoRuN8Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="151600479"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="scan'208";a="151600479"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 22:27:10 -0700
IronPort-SDR: 99GhxGM5RE4/FWZPVc87eqBXDP7QFCYYA1UR13FqqLtQTjcvudNbcYc3VQFdlM1dFySzls+p48
 DehFI7uYAdaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="scan'208";a="288166459"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2020 22:27:09 -0700
Date: Tue, 21 Jul 2020 22:27:09 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200722052709.GB478587@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <20200717100610.GH10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717100610.GH10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 4RPVORYHHDY4E2SB7YEUR226JJ4TBVMQ
X-Message-ID-Hash: 4RPVORYHHDY4E2SB7YEUR226JJ4TBVMQ
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4RPVORYHHDY4E2SB7YEUR226JJ4TBVMQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 12:06:10PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
> > First I'm not sure if adding this state to idtentry_state and having
> > that state copied is the right way to go.  It seems like we should start
> > passing this by reference instead of value.  But for now this works as
> > an RFC.  Comments?
> 
> As long as you keep sizeof(struct idtentry_state_t) <= sizeof(u64) or
> possibly 2*sizeof(unsigned long), code gen shouldn't be too horrid IIRC.
> You'll have to look at what the compiler makes of it.
> 
> > Second, I'm not 100% happy with having to save the reference count in
> > the exception handler.  It seems like a very ugly layering violation but
> > I don't see a way around it at the moment.
> 
> So I've been struggling with that API, all the way from
> pks_update_protection() to that dev_access_{en,dis}able(). I _really_
> hate it, but I see how you ended up with it.
> 
> I wanted to propose something like:
> 
> u32 current_pkey_save(int pkey, unsigned flags)
> {
> 	u32 *lpkr = get_cpu_ptr(&local_pkr);
> 	u32 pkr, saved = *lpkr;
> 
> 	pkr = update_pkey_reg(saved, pkey, flags);
> 	if (pkr != saved)
> 		wrpkr(pkr);
> 
> 	put_cpu_ptr(&local_pkr);
> 	return saved;
> }
> 
> void current_pkey_restore(u32 pkr)
> {
> 	u32 *lpkr = get_cpu_ptr(&local_pkr);
> 	if (*lpkr != pkr)
> 		wrpkr(pkr);
> 	put_cpu_ptr(&local_pkr);
> }
> 
> Together with:
> 
> void pkey_switch(struct task_struct *prev, struct task_struct *next)
> {
> 	prev->pkr = this_cpu_read(local_pkr);
> 	if (prev->pkr != next->pkr)
> 		wrpkr(next->pkr);
> }
> 
> But that's actually hard to frob into the kmap() model :-( The upside is
> that you only have 1 word of state, instead of the 2 you have now.

I'm still mulling over if what you have really helps us.  It seems like we may
be able to remove the percpu pkrs_cache variable...  But I'm hesitant to do so.

Regardless that is not the big issue right now...

> 
> > Third, this patch has gone through a couple of revisions as I've had
> > crashes which just don't make sense to me.  One particular issue I've
> > had is taking a MCE during memcpy_mcsafe causing my WARN_ON() to fire.
> > The code path was a pmem copy and the ref count should have been
> > elevated due to dev_access_enable() but why was
> > idtentry_enter()->idt_save_pkrs() not called I don't know.
> 
> Because MCEs are NMI-like and don't go through the normal interrupt
> path. MCEs are an abomination, please wear all the protective devices
> you can lay hands on when delving into that.

I've been really digging into this today and I'm very concerned that I'm
completely missing something WRT idtentry_enter() and idtentry_exit().

I've instrumented idt_{save,restore}_pkrs(), and __dev_access_{en,dis}able()
with trace_printk()'s.

With this debug code, I have found an instance where it seems like
idtentry_enter() is called without a corresponding idtentry_exit().  This has
left the thread ref counter at 0 which results in very bad things happening
when __dev_access_disable() is called and the ref count goes negative.

Effectively this seems to be happening:

...
	// ref == 0
	dev_access_enable()  // ref += 1 ==> disable protection
		// exception  (which one I don't know)
			idtentry_enter()
				// ref = 0
				_handler() // or whatever code...
			// *_exit() not called [at least there is no trace_printk() output]...
			// Regardless of trace output, the ref is left at 0
	dev_access_disable() // ref -= 1 ==> -1 ==> does not enable protection
	(Bad stuff is bound to happen now...)
...

The ref count ends up completely messed up after this sequence...  and the PKRS
register gets out of sync as well.  This is starting to make some sense of how
I was getting what seemed like random crashes before.

Unfortunately I don't understand the idt entry/exit code well enough to see
clearly what is going on.  Is there any reason idtentry_exit() is not called
after idtentry_enter()?  Perhaps some NMI/MCE or 'not normal' exception code
path I'm not seeing?  In my searches I see a corresponding exit for every
enter.  But MCE is pretty hard to follow.

Also is there any chance that the process could be getting scheduled and that
is causing an issue?

Thanks,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

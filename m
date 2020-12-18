Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C70B2DE9E0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 20:43:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0AC4100EB340;
	Fri, 18 Dec 2020 11:43:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42EF7100EB335
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 11:42:51 -0800 (PST)
IronPort-SDR: hOd/EAz1xzMUFu2WqoKfPAu156FkO61fj2z5jI2ok3wubtanY3RLMhuyPfZbXbv/RnyaghJ/aE
 AxRHWB/UYt3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="155292510"
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400";
   d="scan'208";a="155292510"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 11:42:50 -0800
IronPort-SDR: BBwwrrlwukxd37QDB3Ll9Qrz++BOPT06uR+6+LPcKkVSGjfrA/RdeiXdJcZzBCYtIrqt3eNP4Y
 9u53adH5mp9w==
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400";
   d="scan'208";a="370762824"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 11:42:49 -0800
Date: Fri, 18 Dec 2020 11:42:49 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
Message-ID: <20201218194249.GE1563847@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201106232908.364581-5-ira.weiny@intel.com>
 <871rfoscz4.fsf@nanos.tec.linutronix.de>
 <87mtycqcjf.fsf@nanos.tec.linutronix.de>
 <878s9vqkrk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878s9vqkrk.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: X7YLUGREZQM4DXH4BTZE77UPDBUR6IK6
X-Message-ID-Hash: X7YLUGREZQM4DXH4BTZE77UPDBUR6IK6
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X7YLUGREZQM4DXH4BTZE77UPDBUR6IK6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 18, 2020 at 02:57:51PM +0100, Thomas Gleixner wrote:
> On Thu, Dec 17 2020 at 23:43, Thomas Gleixner wrote:
> > The only use case for this in your tree is: kmap() and the possible
> > usage of that mapping outside of the thread context which sets it up.
> >
> > The only hint for doing this at all is:
> >
> >     Some users, such as kmap(), sometimes requires PKS to be global.
> >
> > 'sometime requires' is really _not_ a technical explanation.
> >
> > Where is the explanation why kmap() usage 'sometimes' requires this
> > global trainwreck in the first place and where is the analysis why this
> > can't be solved differently?
> >
> > Detailed use case analysis please.
> 
> A lengthy conversation with Dan and Dave over IRC confirmed what I was
> suspecting.
> 
> The approach of this whole PKS thing is to make _all_ existing code
> magically "work". That means aside of the obvious thread local mappings,
> the kmap() part is needed to solve the problem of async handling where
> the mapping is handed to some other context which then uses it and
> notifies the context which created the mapping when done. That's the
> principle which was used to make highmem work long time ago.
> 
> IMO that was a mistake back then. The right thing would have been to
> change the code so that it does not rely on a temporary mapping created
> by the initiator. Instead let the initiator hand the page over to the
> other context which then creates a temporary mapping for fiddling with
> it. Water under the bridge...

But maybe not.  We are getting rid of a lot of the kmaps and once the bulk are
gone perhaps we can change this and remove kmap completely?

> 
> Glueing PKS on to that kmap() thing is horrible and global PKS is pretty
> much the opposite of what PKS wants to achieve. It's disabling
> protection systemwide for an unspecified amount of time and for all
> contexts.

I agree.  This is why I have been working on converting kmap() call sites to
kmap_local_page().[1]

> 
> So instead of trying to make global PKS "work" we really should go and
> take a smarter approach.
> 
>   1) Many kmap() use cases are strictly thread local and the mapped
>      address is never handed to some other context, which means this can
>      be replaced with kmap_local() now, which preserves the mapping
>      accross preemption. PKS just works nicely on top of that.

Yes hence the massive kmap->kmap_thread patch set which is now becoming
kmap_local_page().[2]

> 
>   2) Modify kmap() so that it marks the to be mapped page as 'globaly
>      unprotected' instead of doing this global unprotect PKS dance.
>      kunmap() undoes that. That obviously needs some thought
>      vs. refcounting if there are concurrent users, but that's a
>      solvable problem either as part of struct page itself or
>      stored in some global hash.

How would this globally unprotected flag work?  I suppose if kmap created a new
PTE we could make that PTE non-PKS protected then we don't have to fiddle with
the register...  I think I like that idea.

> 
>   3) Have PKS modes:
> 
>      - STRICT:   No pardon
>      
>      - RELAXED:  Warn and unprotect temporary for the current context
> 
>      - SILENT:	 Like RELAXED, but w/o warning to make sysadmins happy.
>                  Default should be RELAXED.
> 
>      - OFF:      Disable the whole PKS thing

I'm not really sure how this solves the global problem but it is probably worth
having in general.

> 
> 
>   4) Have a smart #PF mechanism which does:
> 
>      if (error_code & X86_PF_PK) {
>          page = virt_to_page(address);
> 
>          if (!page || !page_is_globaly_unprotected(page))
>                  goto die;
> 
>          if (pks_mode == PKS_MODE_STRICT)
>          	 goto die;
> 
>          WARN_ONCE(pks_mode == PKS_MODE_RELAXED, "Useful info ...");
> 
>          temporary_unprotect(page, regs);
>          return;
>      }

I feel like this is very similar to what I had in the global patch you found in
my git tree with the exception of the RELAXED mode.  I simply had globally
unprotected or die.

global_pkey_is_enabled() handles the page_is_globaly_unprotected() and
temporary_unprotect().[3]

Anyway, I'm sorry (but not sorry) that you found it.  I've been trying to get
0-day and other testing on it and my public tree was the easiest way to do
that.  Anyway...

The patch as a whole needs work.  You are 100% correct that if a mapping is
handed to another context it is going to suck performance wise.  It has had
some internal review but not much.

Regardless I think unprotecting a global context is the easy part.  The code
you had a problem with (and I see is fully broken) was the restriction of
access.  A failure to update in that direction would only result in a wider
window of access.  I contemplated not doing a global update at all and just
leave the access open until the next context switch.  But the code as it stands
tries to force an update for a couple of reasons:

1) kmap_local_page() removes most of the need for global pks.  So I was
   thinking that global PKS could be a slow path.

2) kmap()'s that are handed to other contexts they are likely to be 'long term'
   and should not need to be updated 'too' often.  I will admit that I don't
   know how often 'too often' is.

But IMO these questions are best left to after the kmaps are converted.  Thus
this patch set was just basic support.  Other uses cases beyond pmem such as
trusted keys or secret mem don't need a global pks feature and could build on
the patch set submitted.  I was trying to break the problem down.

> 
>      temporary_unprotect(page, regs)
>      {
>         key = page_to_key(page);
> 
> 	/* Return from #PF will establish this for the faulting context */
>         extended_state(regs)->pks &= ~PKS_MASK(key);
>      }
> 
>      This temporary unprotect is undone when the context is left, so
>      depending on the context (thread, interrupt, softirq) the
>      unprotected section might be way wider than actually needed, but
>      that's still orders of magnitudes better than having this fully
>      unrestricted global PKS mode which is completely scopeless.

I'm not sure I follow you.  How would we know when the context is left?

> 
>      The above is at least restricted to the pages which are in use for
>      a particular operation. Stray pointers during that time are
>      obviously not caught, but that's not any different from that
>      proposed global thingy.
> 
>      The warning allows to find the non-obvious places so they can be
>      analyzed and worked on.

I could add the warning for sure.

> 
>   5) The DAX case which you made "work" with dev_access_enable() and
>      dev_access_disable(), i.e. with yet another lazy approach of
>      avoiding to change a handful of usage sites.
> 
>      The use cases are strictly context local which means the global
>      magic is not used at all. Why does it exist in the first place?

I'm not following.  What is 'it'?

> 
>      Aside of that this global thing would never work at all because the
>      refcounting is per thread and not global.
> 
>      So that DAX use case is just a matter of:
> 
>         grant/revoke_access(DEV_PKS_KEY, READ/WRITE)
> 
>      which is effective for the current execution context and really
>      wants to be a distinct READ/WRITE protection and not the magic
>      global thing which just has on/off. All usage sites know whether
>      they want to read or write.
>    
>      That leaves the question about the refcount. AFAICT, nothing nests
>      in that use case for a given execution context. I'm surely missing
>      something subtle here.

The refcount is needed for non-global pks as well as global.  I've not resolved
if anything needs to be done with the refcount on the global update since the
following is legal.

kmap()
kmap_local_page()
kunmap()
kunmap_local()

Which would be a problem.  But I don't think it is ever actually done.

Another problem would be if the kmap and kunmap happened in different
contexts...  :-/  I don't think that is done either but I don't know for
certain.

Frankly, my main focus before any of this global support has been to get rid of
as many kmaps as possible.[1]  Once that is done I think more of these
questions can be answered better.

Ira

[1] https://lore.kernel.org/lkml/20201210171834.2472353-1-ira.weiny@intel.com/
[2] https://lore.kernel.org/lkml/20201009195033.3208459-1-ira.weiny@intel.com/
[3] Latest untested patch pushed for reference here because I can't find
    exactly the branch you found.
    https://github.com/weiny2/linux-kernel/commit/37439e91e141be58c13ccc4462f7782311680636

> 
>      Hmm?
> 
> Thanks,
> 
>         tglx
>      
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

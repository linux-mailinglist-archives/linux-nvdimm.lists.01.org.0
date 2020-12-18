Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88182DE38D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 14:58:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D770E100EBB74;
	Fri, 18 Dec 2020 05:58:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A27F0100EBBB8
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 05:57:55 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1608299872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uclnLJa1eSPPl7Rt5PNwz5tb8qoS60bbUxt+aCthgPo=;
	b=3RJU1L1Z1lcSYyJBgUOWyaINTPussKeZKI4WfLwzeyWP6ZigdtxbCgXiLpbLn08RCJ8/SU
	bc1qdPkaEz9G/lZ6Br2rBi05KIBOJnEnBDInFWC6TBBVKYMEqMVHSfmKr4yA4dDjcvc33n
	Nye3/xDUgfoMQvZ81u28FmrJblLusMGjeD+bCOPTcv0y8c3sE92Bq9fpV4rKAsTFCllMjQ
	FjxIC6/FbUtKEwp15gOuprknbYG/dhDs+tB3CfVj6M7avhBupY+g16NzfIgz4jDFD54Deq
	uzX7Mj9fFkh0+MSjraEpqOsRZ0LEJWCZH7uTQmsr7wo94sEwqMaocWfyxN/JgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1608299872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uclnLJa1eSPPl7Rt5PNwz5tb8qoS60bbUxt+aCthgPo=;
	b=Boe/9Lm8Qxp+iYx/THw5rfPHsJrGby3kTRthA6dchBH79sZO6cHhPzfnn6Ia9VhB1UeWNI
	iHUN3iSzL2sBPpBQ==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
In-Reply-To: <87mtycqcjf.fsf@nanos.tec.linutronix.de>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com> <871rfoscz4.fsf@nanos.tec.linutronix.de> <87mtycqcjf.fsf@nanos.tec.linutronix.de>
Date: Fri, 18 Dec 2020 14:57:51 +0100
Message-ID: <878s9vqkrk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: 7AN4ZZXECG7AC2CE6MHRWDAVDT6SNOLN
X-Message-ID-Hash: 7AN4ZZXECG7AC2CE6MHRWDAVDT6SNOLN
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7AN4ZZXECG7AC2CE6MHRWDAVDT6SNOLN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 17 2020 at 23:43, Thomas Gleixner wrote:
> The only use case for this in your tree is: kmap() and the possible
> usage of that mapping outside of the thread context which sets it up.
>
> The only hint for doing this at all is:
>
>     Some users, such as kmap(), sometimes requires PKS to be global.
>
> 'sometime requires' is really _not_ a technical explanation.
>
> Where is the explanation why kmap() usage 'sometimes' requires this
> global trainwreck in the first place and where is the analysis why this
> can't be solved differently?
>
> Detailed use case analysis please.

A lengthy conversation with Dan and Dave over IRC confirmed what I was
suspecting.

The approach of this whole PKS thing is to make _all_ existing code
magically "work". That means aside of the obvious thread local mappings,
the kmap() part is needed to solve the problem of async handling where
the mapping is handed to some other context which then uses it and
notifies the context which created the mapping when done. That's the
principle which was used to make highmem work long time ago.

IMO that was a mistake back then. The right thing would have been to
change the code so that it does not rely on a temporary mapping created
by the initiator. Instead let the initiator hand the page over to the
other context which then creates a temporary mapping for fiddling with
it. Water under the bridge...

Glueing PKS on to that kmap() thing is horrible and global PKS is pretty
much the opposite of what PKS wants to achieve. It's disabling
protection systemwide for an unspecified amount of time and for all
contexts.

So instead of trying to make global PKS "work" we really should go and
take a smarter approach.

  1) Many kmap() use cases are strictly thread local and the mapped
     address is never handed to some other context, which means this can
     be replaced with kmap_local() now, which preserves the mapping
     accross preemption. PKS just works nicely on top of that.

  2) Modify kmap() so that it marks the to be mapped page as 'globaly
     unprotected' instead of doing this global unprotect PKS dance.
     kunmap() undoes that. That obviously needs some thought
     vs. refcounting if there are concurrent users, but that's a
     solvable problem either as part of struct page itself or
     stored in some global hash.

  3) Have PKS modes:

     - STRICT:   No pardon
     
     - RELAXED:  Warn and unprotect temporary for the current context

     - SILENT:	 Like RELAXED, but w/o warning to make sysadmins happy.
                 Default should be RELAXED.

     - OFF:      Disable the whole PKS thing


  4) Have a smart #PF mechanism which does:

     if (error_code & X86_PF_PK) {
         page = virt_to_page(address);

         if (!page || !page_is_globaly_unprotected(page))
                 goto die;

         if (pks_mode == PKS_MODE_STRICT)
         	 goto die;

         WARN_ONCE(pks_mode == PKS_MODE_RELAXED, "Useful info ...");

         temporary_unprotect(page, regs);
         return;
     }

     temporary_unprotect(page, regs)
     {
        key = page_to_key(page);

	/* Return from #PF will establish this for the faulting context */
        extended_state(regs)->pks &= ~PKS_MASK(key);
     }

     This temporary unprotect is undone when the context is left, so
     depending on the context (thread, interrupt, softirq) the
     unprotected section might be way wider than actually needed, but
     that's still orders of magnitudes better than having this fully
     unrestricted global PKS mode which is completely scopeless.

     The above is at least restricted to the pages which are in use for
     a particular operation. Stray pointers during that time are
     obviously not caught, but that's not any different from that
     proposed global thingy.

     The warning allows to find the non-obvious places so they can be
     analyzed and worked on.

  5) The DAX case which you made "work" with dev_access_enable() and
     dev_access_disable(), i.e. with yet another lazy approach of
     avoiding to change a handful of usage sites.

     The use cases are strictly context local which means the global
     magic is not used at all. Why does it exist in the first place?

     Aside of that this global thing would never work at all because the
     refcounting is per thread and not global.

     So that DAX use case is just a matter of:

        grant/revoke_access(DEV_PKS_KEY, READ/WRITE)

     which is effective for the current execution context and really
     wants to be a distinct READ/WRITE protection and not the magic
     global thing which just has on/off. All usage sites know whether
     they want to read or write.
   
     That leaves the question about the refcount. AFAICT, nothing nests
     in that use case for a given execution context. I'm surely missing
     something subtle here.

     Hmm?

Thanks,

        tglx
     
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE5B22BA46
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jul 2020 01:41:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 246EF12532665;
	Thu, 23 Jul 2020 16:41:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D937312532664
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 16:41:24 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1595547681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4EvAkRC4BPL7n1n7Kr+wNjah1Z1o4ZKLr91LS2HGWWY=;
	b=2vwCspbL9kpSyGS1BGvqDAv6arPrdN6uebhNpupdJ/Nn23YX0YiC6tJKrVUbNSQOxVVVmO
	Lph51+YJtFQUbiSISOJmFASMBSiN8PMF0bpewFvN9bAhpTx7krb8X/UfhL7sWBiv548p3Z
	PRPQMeQ7Jy/EXAecfFRdV07zdklINIOfIwMwIpzLnyPvaKuGSXmT819fjboFMWZ7w6n2X6
	Gqp2tDYXDem/r0cGqrEq1egE3thRCzbTOFRUMuHc/UakCIAyd/JFXaXCjUzhHwTQHH+q6+
	H0RYZRgMVUI9n2QrfyjwXRdUgbTYj8df4hTGzLrH/lYUyqxn1eTKhnhzSSkrfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1595547681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4EvAkRC4BPL7n1n7Kr+wNjah1Z1o4ZKLr91LS2HGWWY=;
	b=1i1Qe7Tlu3AEqraTlPmchPk0txy7Maf8ZebbpTycWER2HDP339mkPH7e+5pvMpFo57aUlv
	ZyK7mxLjfcT3B2Aw==
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <20200723220435.GI844235@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com> <87r1t2vwi7.fsf@nanos.tec.linutronix.de> <20200723220435.GI844235@iweiny-DESK2.sc.intel.com>
Date: Fri, 24 Jul 2020 01:41:20 +0200
Message-ID: <87mu3pvly7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: KFQ3FEO3IBRXORI2YMRGSVEOETKERTLB
X-Message-ID-Hash: KFQ3FEO3IBRXORI2YMRGSVEOETKERTLB
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KFQ3FEO3IBRXORI2YMRGSVEOETKERTLB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira,

Ira Weiny <ira.weiny@intel.com> writes:
> On Thu, Jul 23, 2020 at 09:53:20PM +0200, Thomas Gleixner wrote:
> I think, after fixing my code (see below), using idtentry_state could still
> work.  If the per-cpu cache and the MSR is updated in idtentry_exit() that
> should carry the state to the new cpu, correct?

I'm way too tired to think about that now. Will have a look tomorrow
with brain awake.

>> > It seems like we should start passing this by reference instead of
>> > value.  But for now this works as an RFC.  Comments?
>> 
>> Works as in compiles, right?
>> 
>> static void noinstr idt_save_pkrs(idtentry_state_t state)
>> {
>>         state.foo = 1;
>> }
>> 
>> How is that supposed to change the caller state? C programming basics.
>
> <sigh>  I am so stupid.  I was not looking at this particular case but you are
> 100% correct...  I can't believe I did not see this.
>
> In the above statement I was only thinking about the extra overhead I was
> adding to idtentry_enter() and the callers of it.

Fun. That statement immediately caught my attention and made me look at
that function.

> "C programming basics" indeed... Once again sorry...

Don't worry.

One interesting design bug of the human brain is that it tricks you into
seeing what you expect to see no matter how hard you try not to fall for
that. You can spend days staring at the obvious without seeing it. The
saying 'you can't see the forest for the trees' exists for a reason.

Yes, I know it's embarrassing, but that happens and it happens to all of
us no matter how experienced we are. Just search the LKML archives for
'brown paperbag'. You'll find amazing things.

If you show your problem to people who are not involved in that at all
there is a high propability that it immediately snaps for one of
them. But there is no guarantee, just look at this mail thread and the
number of people who did not notice.

Move on and accept the fact that it will happen again :)

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

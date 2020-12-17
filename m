Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1312DDB8E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 23:43:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CEB0B100EB854;
	Thu, 17 Dec 2020 14:43:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 869E4100EBB7E
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 14:43:19 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1608244996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/S3rCsR4wz25bQqtxLvPPE+bxBFLx2igc0E9oZoBixU=;
	b=wRinoYpzeL4ipkhvpMBgUpezoNqnN4BwXIz6yCt/nstpu+1cIIa6AhqenWWWDuIGhiMkOk
	CgBSGq+EQLUSN9blubISX09j3JB1cUFFvM2gc/4yVDkCmqEjWMRmnRN92OKprWuQFH8G+K
	NkwxrRjg1k0PiQEkjqiHBNmoHeasdsNX94jSGQkWfCKi19W1Rbw3cvPUrm9IpD7TwUC+nV
	ACdc6YScpXoHcP5diNMP4a5qX4wgyfeDV4LsY8msOVkwEM82YjXZOFroP2V/QtN6nSvTIX
	30LaegIh2ac27qxKzekW++HDO7k8ZZdzcFJWCHEJnmZDQHdeC3vadvqArXeZTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1608244996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/S3rCsR4wz25bQqtxLvPPE+bxBFLx2igc0E9oZoBixU=;
	b=++W/DH+pERsrf2PJVkJS5SNOxNLygeL5yW5v2CfziX3B5GGLBVUk7yuB5f3LQe/a8v69Ue
	IAySbYQONXjuIgAQ==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
In-Reply-To: <871rfoscz4.fsf@nanos.tec.linutronix.de>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com> <871rfoscz4.fsf@nanos.tec.linutronix.de>
Date: Thu, 17 Dec 2020 23:43:16 +0100
Message-ID: <87mtycqcjf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: 7HMCEGH6BKMDU2TNK6S3OX7A7IWGHJCH
X-Message-ID-Hash: 7HMCEGH6BKMDU2TNK6S3OX7A7IWGHJCH
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7HMCEGH6BKMDU2TNK6S3OX7A7IWGHJCH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 17 2020 at 15:50, Thomas Gleixner wrote:
> On Fri, Nov 06 2020 at 15:29, ira weiny wrote:
>
>> +void write_pkrs(u32 new_pkrs)
>> +{
>> +	u32 *pkrs;
>> +
>> +	if (!static_cpu_has(X86_FEATURE_PKS))
>> +		return;
>> +
>> +	pkrs = get_cpu_ptr(&pkrs_cache);
>
> So this is called from various places including schedule and also from
> the low level entry/exit code. Why do we need to have an extra
> preempt_disable/enable() there via get/put_cpu_ptr()?
>
> Just because performance in those code paths does not matter?
>
>> +	if (*pkrs != new_pkrs) {
>> +		*pkrs = new_pkrs;
>> +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
>> +	}
>> +	put_cpu_ptr(pkrs);

Which made me look at the other branch of your git repo just because I
wanted to know about the 'other' storage requirements and I found this
gem:

> update_global_pkrs()
> ...
>	/*
>	 * If we are preventing access from the old value.  Force the
>	 * update on all running threads.
>	 */
>	if (((old_val == 0) && protection) ||
>	    ((old_val & PKR_WD_BIT) && (protection & PKEY_DISABLE_ACCESS))) {
>		int cpu;
>
>		for_each_online_cpu(cpu) {
>			u32 *ptr = per_cpu_ptr(&pkrs_cache, cpu);
>
>			*ptr = update_pkey_val(*ptr, pkey, protection);
>			wrmsrl_on_cpu(cpu, MSR_IA32_PKRS, *ptr);
>			put_cpu_ptr(ptr);

1) per_cpu_ptr() -> put_cpu_ptr() is broken as per_cpu_ptr() is not
   disabling preemption while put_cpu_ptr() enables it which wreckages
   the preemption count. 

   How was that ever tested at all with any debug option enabled?

   Answer: Not at all

2) How is that sequence:

	ptr = per_cpu_ptr(&pkrs_cache, cpu);
	*ptr = update_pkey_val(*ptr, pkey, protection);
	wrmsrl_on_cpu(cpu, MSR_IA32_PKRS, *ptr);

   supposed to be correct vs. a concurrent modification of the
   pkrs_cache of the remote CPU?

   Answer: Not at all

Also doing a wrmsrl_on_cpu() on _each_ online CPU is insane at best.

  A smp function call on a remote CPU takes ~3-5us when the remote CPU
  is not idle and can immediately respond. If the remote CPU is deep in
  idle it can take up to 100us depending on C-State it is in.

  Even if the remote CPU is not not idle and just has interrupts
  disabled for a few dozen of microseconds this adds up.

  So on a 256 CPU system depending on the state of the remote CPUs this
  stalls the CPU doing the update for anything between 1 and 25ms worst
  case.

  Of course that also violates _all_ CPU isolation mechanisms.

  What for?

  Just for the theoretical chance that _all_ remote CPUs have
  seen that global permission and have it still active?

  You're not serious about that, right?

The only use case for this in your tree is: kmap() and the possible
usage of that mapping outside of the thread context which sets it up.

The only hint for doing this at all is:

    Some users, such as kmap(), sometimes requires PKS to be global.

'sometime requires' is really _not_ a technical explanation.

Where is the explanation why kmap() usage 'sometimes' requires this
global trainwreck in the first place and where is the analysis why this
can't be solved differently?

Detailed use case analysis please.

Thanks,

        tglx


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

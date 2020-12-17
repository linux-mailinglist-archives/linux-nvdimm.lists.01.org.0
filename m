Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E93E2DD428
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 16:28:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B6035100EB82E;
	Thu, 17 Dec 2020 07:28:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7EA55100EB82C
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 07:28:53 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1608218931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EIcpuCdPdjtUIDDq5V1Kd6Nd1DvDsLvtJ/iV0ZcMRgA=;
	b=3/uIVXk04WU6Kuue5KdK/PZzRT3PQRQci3lkMWxtnm0m12Qkt5QmdLW1qQQiqnAFp2hZp5
	QzFq2fC1v1lLeWxspvs7ZktqDZYepiYqq++tBMgUhzKOe2wtg66cawjCw02bRBA1+2Djdc
	4KqVMkPy5/ypITooF8IgTBcIQjsKSpTImchFsyfvoJm7nqCiKy3U5DR28Hag30uG9YGgov
	RUvtLmBoVLaNPRF+SFiF/2wkaVq1oYPqBJmTNbWB4E7TQFmDGdSdnkPdaiSRXTI2qchLhb
	YTBG4YlbqP+sIR9BHSNaYY0o6m7NSpXCZrdp1Gbc1GfXIGh0T78z8Dt66x3VyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1608218931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EIcpuCdPdjtUIDDq5V1Kd6Nd1DvDsLvtJ/iV0ZcMRgA=;
	b=9yQmqCVKnv9+iECxfpPNtEbdep6NKjLzINPHlJVMXIR0uStpoRGsed4or02lEAiC+4QayK
	TZlxdiWrObB1IHAQ==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V3 06/10] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <20201106232908.364581-7-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-7-ira.weiny@intel.com>
Date: Thu, 17 Dec 2020 16:28:51 +0100
Message-ID: <87y2hwqwng.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: MTA5PZTEUKHIL7CYXIYOUUKPK26JJIVY
X-Message-ID-Hash: MTA5PZTEUKHIL7CYXIYOUUKPK26JJIVY
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MTA5PZTEUKHIL7CYXIYOUUKPK26JJIVY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 06 2020 at 15:29, ira weiny wrote:
> +#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> +/*
> + * PKRS is a per-logical-processor MSR which overlays additional protection for
> + * pages which have been mapped with a protection key.
> + *
> + * The register is not maintained with XSAVE so we have to maintain the MSR
> + * value in software during context switch and exception handling.
> + *
> + * Context switches save the MSR in the task struct thus taking that value to
> + * other processors if necessary.
> + *
> + * To protect against exceptions having access to this memory we save the
> + * current running value and set the PKRS value for the duration of the
> + * exception.  Thus preventing exception handlers from having the elevated
> + * access of the interrupted task.
> + */
> +noinstr void irq_save_set_pkrs(irqentry_state_t *irq_state, u32 val)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> +		return;
> +
> +	irq_state->thread_pkrs = current->thread.saved_pkrs;
> +	write_pkrs(INIT_PKRS_VALUE);

Why is this noinstr? Just because it's called from a noinstr function?

Of course the function itself violates the noinstr constraints:

  vmlinux.o: warning: objtool: write_pkrs()+0x36: call to do_trace_write_msr() leaves .noinstr.text section

There is absolutely no reason to have this marked noinstr.

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

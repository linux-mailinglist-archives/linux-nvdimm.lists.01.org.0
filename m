Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4556429792D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Oct 2020 23:56:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A02C1634E069;
	Fri, 23 Oct 2020 14:56:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B257C1632530E
	for <linux-nvdimm@lists.01.org>; Fri, 23 Oct 2020 14:56:36 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1603490194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79rTg2SKZLoa/evVojUPAbe7jLqXBquN2CeaB2ok8dM=;
	b=EetW5+h2WAFfLhHoLTCZ9y+9G7Ei5unrNieHG1oDovYqkcijqZVi/zV19BnVNHeDAYAq1y
	5BPQvOBeenBqLGZsMVj0lxrhTePplE91mlRbpz6CwZlY5ngqViOYE+dIpuSbgEqXN/hk+p
	jZgnfrBD4hxFmjvZv0feO4rHUiJ10r7PGhwlaj55UBGIzybRn6FLG3VxHgQfGbyY8XfR5y
	ZWdJnyBKnvxoeq281PMRil6StYpFCqPQgpfBqwHXqkT9CU72euIqVkVtoVbuIqm2lzXkVL
	8SmRG2kKrV0hOeL1M2wDVZUriXPi0GcVcw6UJ+cQfZoek59YI4kGMXrtfSvuHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1603490194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79rTg2SKZLoa/evVojUPAbe7jLqXBquN2CeaB2ok8dM=;
	b=+wyfQHnakkKyqSE/2uGjxNcZTwxnMUoslSbSCXRrWkS+13bWcBa+tI0OQQwYJbaGoQJY9w
	kc67vWEIFcKYyjAw==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 07/10] x86/entry: Pass irqentry_state_t by reference
In-Reply-To: <20201022222701.887660-8-ira.weiny@intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com> <20201022222701.887660-8-ira.weiny@intel.com>
Date: Fri, 23 Oct 2020 23:56:33 +0200
Message-ID: <87y2jw4ne6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: DO5TRGRFV4TTMY32WGLL7JFQUIS5F2WN
X-Message-ID-Hash: DO5TRGRFV4TTMY32WGLL7JFQUIS5F2WN
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DO5TRGRFV4TTMY32WGLL7JFQUIS5F2WN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 22 2020 at 15:26, ira weiny wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>
> In preparation for adding PKS information to struct irqentry_state_t
> change all call sites and usages to pass the struct by reference
> instead of by value.

This still does not explain WHY you need to do that. 'Preparation' is a
pretty useless information.

What is the actual reason for this? Just because PKS information feels
better that way?

Also what is PKS information? Changelogs have to make sense on their own
and not only in the context of a larger series of changes.

> While we are editing the call sites it is a good time to standardize on
> the name 'irq_state'.

  While at it change all usage sites to consistently use the variable
  name 'irq_state'.

Or something like that. See Documentation/process/...

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

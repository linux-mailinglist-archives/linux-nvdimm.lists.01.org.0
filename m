Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A62B382E
	for <lists+linux-nvdimm@lfdr.de>; Sun, 15 Nov 2020 19:59:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A0303100ED487;
	Sun, 15 Nov 2020 10:59:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7287100ED485
	for <linux-nvdimm@lists.01.org>; Sun, 15 Nov 2020 10:58:57 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1605466732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lM+Tn3Xn9woEdnNA0HLgCq49xITc6UQA2eZ6y/GPCoI=;
	b=xy4LEmo+jlz0Jq+PPQQnClThn2BQPP2VK/gIjQk5I2KRckjCj7Drnsna9lksUk/ITpwuTz
	sVtPgVlXN/2E2E21zA1k079EKJvTIkc7ENv9Jftd7gQE3ubTJ+lhaEDKmxMaSAqzp0Qeap
	v+5xHxFsmZoQ2Q87P28QIuKhRzXpFQXzNYo3nNUHhM6WSWz53AGt9Lsfov+OPHZsGOadaf
	k3qd+kTh6nngia5Ch9pnnaw/EQOevyqIT94eHQHLhmzS7VS3uXOdO+MtcdYkJjDzK6r80k
	kNKu19wadW/FwBvJKeK2w/r0iIoagaFIN0IbDi6oaV3zya4QGqNDLRPDOUbzEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1605466732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lM+Tn3Xn9woEdnNA0HLgCq49xITc6UQA2eZ6y/GPCoI=;
	b=Qd+mE+OpsEvFKxHyQ2CT5n9hPmnIwB1brU84Jw4XCXyD0Jok+oJLKNA01C+Xh8tdkbW36v
	QVxMvbDeCbijnIDw==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V3 05/10] x86/entry: Pass irqentry_state_t by reference
In-Reply-To: <20201106232908.364581-6-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-6-ira.weiny@intel.com>
Date: Sun, 15 Nov 2020 19:58:52 +0100
Message-ID: <87mtzi8n0z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: GILAWBG4TID7TUL2DECWB4MCVXCIQFSJ
X-Message-ID-Hash: GILAWBG4TID7TUL2DECWB4MCVXCIQFSJ
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GILAWBG4TID7TUL2DECWB4MCVXCIQFSJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira,

On Fri, Nov 06 2020 at 15:29, ira weiny wrote:

Subject prefix wants to 'entry:'. This changes generic code and the x86
part is just required to fix the generic code change.

> Currently struct irqentry_state_t only contains a single bool value
> which makes passing it by value is reasonable.  However, future patches
> propose to add information to this struct, for example the PKRS
> register/thread state.
>
> Adding information to irqentry_state_t makes passing by value less
> efficient.  Therefore, change the entry/exit calls to pass irq_state by
> reference.

The PKRS muck needs to add an u32 to that struct. So how is that a
problem?

The resulting struct still fits into 64bit which is by far more
efficiently passed by value than by reference. So which problem are you
solving here?

Thanks

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

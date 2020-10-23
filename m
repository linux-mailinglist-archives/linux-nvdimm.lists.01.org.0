Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E0C297917
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Oct 2020 23:50:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DAC02163660A4;
	Fri, 23 Oct 2020 14:50:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 428CA163660A2
	for <linux-nvdimm@lists.01.org>; Fri, 23 Oct 2020 14:50:15 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1603489811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHZqtXRz0EpqKwmVvrfGdZyZvC7siQQGSvicS0vKKBg=;
	b=0yAkbZnTwDY2ALAbXdGN6vr3ehp2VwpXNIcf51OXNu5rvFRvmCFOCTkkOciH3bsMMB1GTJ
	M49Ooo+35dE2U2EdR4GV6DqIHTyROF7HKJgwhEe+YkykUW9BNC5m+IszzFX1oA8ZEa0XuD
	1d/dCepUNoGiDlYmKWo738FoXRvvngEHtiadyKHOVShEMn5o8bVNUoOmknFSNyw0C29P1y
	lG0GxNgCHxB0lekDN0U72B9z95n6HUAC3ZK2mGWWUMRbEJvRSTaJxxe2QqwdMQCr0LGqOO
	auNEwTjIY0XSihJxFVb3YEpC1IQVLCt4JgLsfilbBuSQ9ygKHpb0dXjIER+lPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1603489811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHZqtXRz0EpqKwmVvrfGdZyZvC7siQQGSvicS0vKKBg=;
	b=1RyBpBn3mRKQKuLJjCvQxmBBrnxabQDijrSaiAdGjc2n/P1b8Vr9dL2Zi4iX0nPaJ9AC7Q
	vT1Rr3Z8/S0zuhCQ==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 06/10] x86/entry: Move nmi entry/exit into common code
In-Reply-To: <20201022222701.887660-7-ira.weiny@intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com> <20201022222701.887660-7-ira.weiny@intel.com>
Date: Fri, 23 Oct 2020 23:50:11 +0200
Message-ID: <874kmk6298.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: ETNKLF4M5SJB3XE7VR4HHQTQGLWL6LTU
X-Message-ID-Hash: ETNKLF4M5SJB3XE7VR4HHQTQGLWL6LTU
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ETNKLF4M5SJB3XE7VR4HHQTQGLWL6LTU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 22 2020 at 15:26, ira weiny wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> Lockdep state handling on NMI enter and exit is nothing specific to X86. It's
> not any different on other architectures. Also the extra state type is not
> necessary, irqentry_state_t can carry the necessary information as well.
>
> Move it to common code and extend irqentry_state_t to carry lockdep
> state.

This lacks something like:

 [ Ira: Made the states a union as they are mutually exclusive and added
        the missing kernel doc ]

Hrm.
 
>  #ifndef irqentry_state
>  typedef struct irqentry_state {
> -	bool	exit_rcu;
> +	union {
> +		bool	exit_rcu;
> +		bool	lockdep;
> +	};
>  } irqentry_state_t;
>  #endif

  -E_NO_KERNELDOC

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

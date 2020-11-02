Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377A12A3746
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 00:41:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56552164C6E91;
	Mon,  2 Nov 2020 15:41:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3275C164C6E8F
	for <linux-nvdimm@lists.01.org>; Mon,  2 Nov 2020 15:41:14 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1604360471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jRvDQIBB8b8SAPT0B0dD6eemT/oEgAx4YjAntCS9bbQ=;
	b=4TF/U7T3YLoTMqN3StcRo2h/phddVV8aM3F/vFj3GZ1c9J98v/ao07Y/guFBkq7kfco6Q5
	nwzblZcW+fWvAPnTM/9Pi3JCFbDH/oee2SNemc40ww1h85qBtsGhyNXu9IaehgxW+38MeI
	jBXZN09HgFcstxGXPmXKg4kAnKExQEpRHdzixm3a7Pyb8tzzmZpcdyXa0LMG83R/WQBBBC
	DNknNZKqOADNmbf7xFJR2xYqn7uHo4jjtpaaOU67VdM8qjkHDMyP40ZjW2+54BSF2i8MzR
	2hf4hAt1eA0wl0EhuwrwdHMsSiI1/VGrodSchj4JVLxkQyr/dc1UASzaeUtcMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1604360471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jRvDQIBB8b8SAPT0B0dD6eemT/oEgAx4YjAntCS9bbQ=;
	b=/B7J+2Rz4YQyBg5LQ8YeydLrxZv4W1kG/5V4+h88nIcwLfXPwJLjC8xz3eJoW5bLR4Bf1T
	8gTlvxwU11pWeGAw==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V2 00/10] PKS: Add Protection Keys Supervisor (PKS) support
In-Reply-To: <871rhb8h73.fsf@nanos.tec.linutronix.de>
References: <20201102205320.1458656-1-ira.weiny@intel.com> <871rhb8h73.fsf@nanos.tec.linutronix.de>
Date: Tue, 03 Nov 2020 00:41:11 +0100
Message-ID: <87y2jj72eg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: IKBNOUNISXTKX2UH5COIXQOL4C5BDR6O
X-Message-ID-Hash: IKBNOUNISXTKX2UH5COIXQOL4C5BDR6O
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IKBNOUNISXTKX2UH5COIXQOL4C5BDR6O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 03 2020 at 00:36, Thomas Gleixner wrote:
> On Mon, Nov 02 2020 at 12:53, ira weiny wrote:
>
> This is the wrong ordering, really.
>
>      x86/entry: Move nmi entry/exit into common code
>
> is a general cleanup and has absolutely nothing to do with PKRS.So this
> wants to go first.
>
> Also:
>
>     x86/entry: Move nmi entry/exit into common code

this should be

     x86/entry: Pass irqentry_state_t by reference

of course. Copy&pasta fail...
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 155122B52B2
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Nov 2020 21:36:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67DA4100EC1CF;
	Mon, 16 Nov 2020 12:36:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8EE59100EC1CC
	for <linux-nvdimm@lists.01.org>; Mon, 16 Nov 2020 12:36:27 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1605558985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXSHVKbd8G8tskYWByySCiOR7/WBbSL8QPOWjVNEWvc=;
	b=iXDImUK3RinKYmmlQOfDDW4hI6pAtsc1AtcOeOZ8UQQ2fBZgWm1Zia9Npot9r5YJ/IVEm7
	/FmfSLTy7hfavoIAbBXp+wh7I7zDMTKofH87R5kGS1pGzuEYbBVufB103vcXwCLIJp8HVq
	DGTJ41tJsAtRK9CxPHkPnRuZU62IcLVInGq+hBPUHZGIAYB+IfzGFyGzBRHiHDB706uvN0
	KY5/G2VChYFgwPjjsQtfvAUEkdUWeBqEAgFpMR4sFeY6tI50WGsO2901uTtixfWL4kPqYw
	tg/uu2fWLw+K5ga4ECaTZd7lpke0jg8ZUwm/ifvsvjTZBg2wGqSqU7nfydd8Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1605558985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXSHVKbd8G8tskYWByySCiOR7/WBbSL8QPOWjVNEWvc=;
	b=IuQwfP8hVspbuZD5CWYGKGeEGWiCjNyd1bMK4ypFeE1jL5NUVm0Phzi/t2Y7+U89FU7CF2
	vOEu5WKh27Fa2wDw==
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH V3 05/10] x86/entry: Pass irqentry_state_t by reference
In-Reply-To: <20201116184916.GA722447@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-6-ira.weiny@intel.com> <87mtzi8n0z.fsf@nanos.tec.linutronix.de> <20201116184916.GA722447@iweiny-DESK2.sc.intel.com>
Date: Mon, 16 Nov 2020 21:36:24 +0100
Message-ID: <87lff1xcmv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: 7AQBCGCAFJFR7IJETUJ5FCD47H7JP62C
X-Message-ID-Hash: 7AQBCGCAFJFR7IJETUJ5FCD47H7JP62C
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7AQBCGCAFJFR7IJETUJ5FCD47H7JP62C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira,

On Mon, Nov 16 2020 at 10:49, Ira Weiny wrote:
> On Sun, Nov 15, 2020 at 07:58:52PM +0100, Thomas Gleixner wrote:
>> > Currently struct irqentry_state_t only contains a single bool value
>> > which makes passing it by value is reasonable.  However, future patches
>> > propose to add information to this struct, for example the PKRS
>> > register/thread state.
>> >
>> > Adding information to irqentry_state_t makes passing by value less
>> > efficient.  Therefore, change the entry/exit calls to pass irq_state by
>> > reference.
>> 
>> The PKRS muck needs to add an u32 to that struct. So how is that a
>> problem?
>
> There are more fields to be added for the kmap/pmem support.  So this will be
> needed eventually.  Even though it is not strictly necessary in the next patch.

if you folks could start to write coherent changelogs with proper
explanations why something is needed and why it's going beyond the
immediate use case in the next patch, then getting stuff sorted would be
way easier.

Sorry my crystalball got lost years ago and I'm just not able to keep up
with the flurry of patch sets which have dependencies in one way or the
other.

>> The resulting struct still fits into 64bit which is by far more
>> efficiently passed by value than by reference. So which problem are you
>> solving here?
>
> I'm getting ahead of myself a bit.  I will be adding more fields for the
> kmap/pmem tracking.
>
> Would you accept just a clean up for the variable names in this patch?  I could
> then add the pass by reference when I add the new fields later.  Or would an
> update to the commit message be ok to land this now?

Can you provide a coherent explanation for the full set of things which
needs to be added here first please?

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

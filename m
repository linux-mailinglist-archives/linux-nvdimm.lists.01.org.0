Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C8A2A373A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 00:36:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DEF921636102A;
	Mon,  2 Nov 2020 15:36:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D2F8716313628
	for <linux-nvdimm@lists.01.org>; Mon,  2 Nov 2020 15:36:20 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1604360177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kn1MrKipST+qlcwJ1zIgvlMXZ9bQBl36MnESiK2hrlI=;
	b=WO4xZRYluSA07JQGA2x48KKqtKPj2AWnFhCX4J0d8fVYBAG/4KfuMoZaJM3qbomnboDi2z
	CNoPbn8hgmPj4tBAxx2T73ZlDljs9QXge+xSx3bZ+PcwOR5lyCNU9REeAlg9L0b+LqMlOJ
	M+nbdv2UCJEEKxD3Vo67CqeXb6qvIcZzQJrF9+2il5iGZKzN+3o8X2F0Gk/EoJjsAsRUR+
	Lt0wWGitJ3ETEGTmjWfa5e52sdgqUPh7KLMFsyHVdGhHUOuP7R2zhChRleod61fGgukIXx
	i4TTKKT/QElFLXZav/sLONz5cABtcUlL8x6e++SDwGhZ6EqbgQJC25ccEH8AkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1604360177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kn1MrKipST+qlcwJ1zIgvlMXZ9bQBl36MnESiK2hrlI=;
	b=bDzdY9iY6ze7qjRQmBLq0m9WmLMx8uKsr4lxx48nJ3PFoOuoYOrQ6mJCbDTbxc7miMSovu
	UMAas1KFWr29U4Dw==
To: ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH V2 00/10] PKS: Add Protection Keys Supervisor (PKS) support
In-Reply-To: <20201102205320.1458656-1-ira.weiny@intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
Date: Tue, 03 Nov 2020 00:36:16 +0100
Message-ID: <871rhb8h73.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: UFIA2BEXYDXQV37SHNGHM6AMZ2XKLM35
X-Message-ID-Hash: UFIA2BEXYDXQV37SHNGHM6AMZ2XKLM35
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UFIA2BEXYDXQV37SHNGHM6AMZ2XKLM35/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 02 2020 at 12:53, ira weiny wrote:
> Fenghua Yu (2):
>   x86/pks: Enable Protection Keys Supervisor (PKS)
>   x86/pks: Add PKS kernel API
>
> Ira Weiny (7):
>   x86/pkeys: Create pkeys_common.h
>   x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
>   x86/pks: Preserve the PKRS MSR on context switch
>   x86/entry: Pass irqentry_state_t by reference
>   x86/entry: Preserve PKRS MSR across exceptions
>   x86/fault: Report the PKRS state on fault
>   x86/pks: Add PKS test code
>
> Thomas Gleixner (1):
>   x86/entry: Move nmi entry/exit into common code

So the actual patch ordering is:

   x86/pkeys: Create pkeys_common.h
   x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
   x86/pks: Enable Protection Keys Supervisor (PKS)
   x86/pks: Preserve the PKRS MSR on context switch
   x86/pks: Add PKS kernel API

   x86/entry: Move nmi entry/exit into common code
   x86/entry: Pass irqentry_state_t by reference

   x86/entry: Preserve PKRS MSR across exceptions
   x86/fault: Report the PKRS state on fault
   x86/pks: Add PKS test code

This is the wrong ordering, really.

     x86/entry: Move nmi entry/exit into common code

is a general cleanup and has absolutely nothing to do with PKRS.So this
wants to go first.

Also:

    x86/entry: Move nmi entry/exit into common code

is a prerequisite for the rest. So why is it in the middle of the
series?

And then you enable all that muck _before_ it is usable:

   Patch 3/N: x86/pks: Enable Protection Keys Supervisor (PKS)

Bisectability is overrrated, right?

Once again: Read an understand Documentation/process/*

Aside of that using a spell checker is not optional.

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

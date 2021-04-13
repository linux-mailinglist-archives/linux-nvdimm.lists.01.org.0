Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A435DD21
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Apr 2021 13:01:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E280100EB82B;
	Tue, 13 Apr 2021 04:01:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:190:11c2::b:1457; helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN> 
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B5E16100EF267
	for <linux-nvdimm@lists.01.org>; Tue, 13 Apr 2021 04:01:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b840069f7e8348dd41416.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8400:69f7:e834:8dd4:1416])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 054E31EC032C;
	Tue, 13 Apr 2021 13:01:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1618311700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=EapHv6oFwJH3m5E8yzDZ3r7waNuPmjlteZ0NxRRuJyI=;
	b=GrYWMUG/t9s1mlCo560HOgrajeQxxIgGSNEJch83ZwT3mM/8rK82Jtcer/mQlHTWjEm4GO
	3DT5AQecd1CmxvaulFNGQqJ/aK5u8v7UZzBI2x/FZXSzRWLAPMgWKJs//+jsrgutWVi3gE
	h3yW+K0CzdqH7wpcFoPzZtWhSaW8qwQ=
Date: Tue, 13 Apr 2021 13:01:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kemeng Shi <shikemeng@huawei.com>
Subject: Re: [PATCH] x86: Accelerate copy_page with non-temporal in X86
Message-ID: <20210413110137.GD16519@zn.tnic>
References: <3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com>
Message-ID-Hash: YVFBXXMDW7J4EQOVVDFMR24DZUY7TQXC
X-Message-ID-Hash: YVFBXXMDW7J4EQOVVDFMR24DZUY7TQXC
X-MailFrom: bp@alien8.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YVFBXXMDW7J4EQOVVDFMR24DZUY7TQXC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

+ linux-nvdimm

Original mail at https://lkml.kernel.org/r/3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com

On Tue, Apr 13, 2021 at 02:25:58PM +0800, Kemeng Shi wrote:
> I'm using AEP with dax_kmem drvier, and AEP is export as a NUMA node in

What is AEP?

> my system. I will move cold pages from DRAM node to AEP node with
> move_pages system call. With old "rep movsq', it costs 2030ms to move
> 1 GB pages. With "movnti", it only cost about 890ms to move 1GB pages.

So there's __copy_user_nocache() which does NT stores.

> -	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
> +	ALTERNATIVE_2 "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD, \
> +                      "jmp copy_page_nt", X86_FEATURE_XMM2

This makes every machine which has sse2 do NT stores now. Which means
*every* machine practically.

The folks on linux-nvdimm@ should be able to give you a better idea what
to do.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

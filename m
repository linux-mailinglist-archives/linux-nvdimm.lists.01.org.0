Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F627C257
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Sep 2020 12:25:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 53E5F153F4D2D;
	Tue, 29 Sep 2020 03:25:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:190:11c2::b:1457; helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN> 
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4348D140D8DBB
	for <linux-nvdimm@lists.01.org>; Tue, 29 Sep 2020 03:25:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ead0084926be0aaf8b723.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:8492:6be0:aaf8:b723])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 753C21EC034B;
	Tue, 29 Sep 2020 12:25:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1601375121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=vD3s6odY/cyE9Bx1q0oRZfhly7bcVfpKxNIBv+AD3wk=;
	b=ShLtAJ1+ONETkeLGQIFpUr5YpYO4Y8avI/Jwm/uh7pk67leh6pvbESMFqfa71vUJRYBzXL
	Utw8bgAfPDECvMhnh48UTxadK4tT9xzoHIe9xly+7QEHld/P6HTUArNTnmwb8000XJnLXZ
	noscDle3MKpVzFNcmkIiIUTBqk1oOjk=
Date: Tue, 29 Sep 2020 12:25:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 1/2] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
Message-ID: <20200929102512.GB21110@zn.tnic>
References: <160087928642.3520.17063139768910633998.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160087929294.3520.12013578778066801369.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <160087929294.3520.12013578778066801369.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID-Hash: 5ZMOR2LJDUCQOPJ3HORAZTEU7QY7QJDW
X-Message-ID-Hash: 5ZMOR2LJDUCQOPJ3HORAZTEU7QY7QJDW
X-MailFrom: bp@alien8.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: mingo@redhat.com, x86@kernel.org, stable@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Mikulas Patocka <mpatocka@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnaldo Carvalho de Melo <acme@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5ZMOR2LJDUCQOPJ3HORAZTEU7QY7QJDW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 23, 2020 at 09:41:33AM -0700, Dan Williams wrote:
> The rename replaces a single top-level memcpy_mcsafe() with either
> copy_mc_to_user(), or copy_mc_to_kernel().

What is "copy_mc" supposed to mean? Especially if it is called that on
two arches...

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7101ac64bb20..e876b3a087f9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -75,7 +75,7 @@ config X86
>  	select ARCH_HAS_PTE_DEVMAP		if X86_64
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
> -	select ARCH_HAS_UACCESS_MCSAFE		if X86_64 && X86_MCE
> +	select ARCH_HAS_COPY_MC			if X86_64

X86_MCE is dropped here. So if I have a build which has

# CONFIG_X86_MCE is not set

One of those quirks like:

        /*
         * CAPID0{7:6} indicate whether this is an advanced RAS SKU
         * CAPID5{8:5} indicate that various NVDIMM usage modes are
         * enabled, so memory machine check recovery is also enabled.
         */
        if ((capid0 & 0xc0) == 0xc0 || (capid5 & 0x1e0))
                enable_copy_mc_fragile();

will still call enable_copy_mc_fragile() and none of those platforms
need MCE functionality?

But there's a hunk in here which sets it in the MCE code:

        if (mca_cfg.recovery)
                enable_copy_mc_fragile();

So which is it? They need it or they don't?

The comment over copy_mc_to_kernel() says:

 * Call into the 'fragile' version on systems that have trouble
 * actually do machine check recovery

If CONFIG_X86_MCE is not set, I'll say. :)

> +++ b/arch/x86/lib/copy_mc.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2016-2020 Intel Corporation. All rights reserved. */
> +
> +#include <linux/jump_label.h>
> +#include <linux/uaccess.h>
> +#include <linux/export.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +static DEFINE_STATIC_KEY_FALSE(copy_mc_fragile_key);
> +
> +void enable_copy_mc_fragile(void)
> +{
> +	static_branch_inc(&copy_mc_fragile_key);
> +}
> +
> +/**
> + * copy_mc_to_kernel - memory copy that that handles source exceptions

One "that" is enough.

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

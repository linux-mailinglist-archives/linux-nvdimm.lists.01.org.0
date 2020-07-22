Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA5229D02
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jul 2020 18:22:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4889111AFADA0;
	Wed, 22 Jul 2020 09:22:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8853A11AFAD8B
	for <linux-nvdimm@lists.01.org>; Wed, 22 Jul 2020 09:21:57 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D232122C9C
	for <linux-nvdimm@lists.01.org>; Wed, 22 Jul 2020 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595434917;
	bh=NnybZoElq3+0KYwoEu4w7pBb4jnYvQOexyS5ysvraSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UcMcUqZGs3A/zHint+yQtia7Uf3Fb8yRh4OyYW73633eFDF8vcz9eD7uDnKQ/c0cu
	 yoA7jR0qN1gN5YgaAVpozWehWHO7y/XScv8pB/dupzQgn5vR4+tU+XPdcM9ijeUk8u
	 8oa5kAzlA1/+LXQc6uLgnZdv5H6c3AhKs2JE2T38=
Received: by mail-wr1-f51.google.com with SMTP id o11so2488606wrv.9
        for <linux-nvdimm@lists.01.org>; Wed, 22 Jul 2020 09:21:56 -0700 (PDT)
X-Gm-Message-State: AOAM531cYZAm2ziLlvbqnPlIGMGMyL4mvvIHRbSJg0VLjdhc6PREKDy8
	PcQGiND5X4iznOU0z01hoPaOB+yCJGtitonEvuKIwQ==
X-Google-Smtp-Source: ABdhPJyEetM5mfaR+krsbN1VbThAmtrGRoGcIADpoq0lN9rBpz6OtbXdH4MYYDkEz8tY7NVo/wEe+Jv+iOx79Efg25I=
X-Received: by 2002:adf:e482:: with SMTP id i2mr296828wrm.75.1595434915303;
 Wed, 22 Jul 2020 09:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com>
In-Reply-To: <20200717072056.73134-18-ira.weiny@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 22 Jul 2020 09:21:43 -0700
X-Gmail-Original-Message-ID: <CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com>
Message-ID: <CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
To: Weiny Ira <ira.weiny@intel.com>
Message-ID-Hash: 3K7IRFKKWAOBVFCZ6R2HX5OUUFNLGMOW
X-Message-ID-Hash: 3K7IRFKKWAOBVFCZ6R2HX5OUUFNLGMOW
X-MailFrom: luto@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3K7IRFKKWAOBVFCZ6R2HX5OUUFNLGMOW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 12:21 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> The PKRS MSR is not managed by XSAVE.  It is already preserved through a
> context switch but this support leaves exception handling code open to
> memory accesses which the interrupted process has allowed.
>
> Close this hole by preserve the current task's PKRS MSR, reset the PKRS
> MSR value on exception entry, and then restore the state on exception
> exit.

Should this live in pt_regs?

--Andy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

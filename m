Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D2029380B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Oct 2020 11:32:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6EFE015F569EA;
	Tue, 20 Oct 2020 02:32:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.9.137.197; helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN> 
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9175715F569E0
	for <linux-nvdimm@lists.01.org>; Tue, 20 Oct 2020 02:32:27 -0700 (PDT)
Received: from zn.tnic (p200300ec2f106600748f54fac26d0739.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:6600:748f:54fa:c26d:739])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D9461EC0258;
	Tue, 20 Oct 2020 11:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1603186344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=zQSMKQsleLY8ITX+I3NDELePsK4U9vilbjl6nMGkcG0=;
	b=Twmzew3gMfZQf974h+00fcxkBGK02qITCu1dbq4+6sIRwMxg+NG5g/b2+IjO+EKlJ24pEZ
	Blcv3j1fxc0ONI/gL0EyXliGFM3f39FXy1GhatGCc1KcHg+ySke+IPFkYEBg1+BhYvgdhS
	X2IRvVOu+e7lMTXNFdoYKiS/c0n2GwE=
Date: Tue, 20 Oct 2020 11:32:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] x86, libnvdimm/test: Remove COPY_MC_TEST
Message-ID: <20201020093214.GB11583@zn.tnic>
References: <160316688322.3374697.8648308115165836243.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <160316688322.3374697.8648308115165836243.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID-Hash: IL72RMD72TU7ZSOARGPOS2NGQIGEDBXL
X-Message-ID-Hash: IL72RMD72TU7ZSOARGPOS2NGQIGEDBXL
X-MailFrom: bp@alien8.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IL72RMD72TU7ZSOARGPOS2NGQIGEDBXL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 19, 2020 at 09:08:03PM -0700, Dan Williams wrote:
> The COPY_MC_TEST facility has served its purpose for validating the
> early termination conditions of the copy_mc_fragile() implementation.
> Remove it and the EXPORT_SYMBOL_GPL of copy_mc_fragile().
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/Kconfig.debug              |    3 -
>  arch/x86/include/asm/copy_mc_test.h |   75 -------------------------
>  arch/x86/lib/copy_mc.c              |    4 -
>  arch/x86/lib/copy_mc_64.S           |   10 ---
>  tools/testing/nvdimm/test/nfit.c    |  103 -----------------------------------
>  5 files changed, 195 deletions(-)
>  delete mode 100644 arch/x86/include/asm/copy_mc_test.h

I love patches removing code. ACK.

I'll take this through tip after -rc1.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

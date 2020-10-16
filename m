Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C1290397
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Oct 2020 12:58:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8EBD515C2C27F;
	Fri, 16 Oct 2020 03:58:03 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 62B0D15C2C27E
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 03:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vZekZ76KW1BiiwMFIl0NBOsPALzv6fOefXANoYwORjo=; b=s3sqnnAyqvzeCqqogltPaUvZEd
	hgR7KOV9Fp54001uE9QNgg1AMWqHaFF5JgVauukBLqaKmERhe7h6OZuPB8JURXapZrfZATGcuctAT
	2FHdhg5BHGWOxaGlMWilCHjdNkV1JkDDKEFiz9cDDj1n639XOPcv4wIOP4l6A/t1XTyTxIHPEzsW7
	Fef+mSxOUoXwOKB4I2tTW7KtkIGOa86LcD9Sf4h2XhNC3QBU9iWQKu2iTqZKYXqS0uZ9fZ1a+hiUH
	CA8hoABSndA1QINh/XC8/+hqZfNTqSO4Q80FrZoJwaVoy8PnFxFbI89lyknHaXGnX/yMRVUIBm0iW
	DSJ6YZ5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTNQf-00024m-1i; Fri, 16 Oct 2020 10:57:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 787DB3011E6;
	Fri, 16 Oct 2020 12:57:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 651BE203C7039; Fri, 16 Oct 2020 12:57:43 +0200 (CEST)
Date: Fri, 16 Oct 2020 12:57:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V3 2/9] x86/fpu: Refactor arch_set_user_pkey_access()
 for PKS support
Message-ID: <20201016105743.GK2611@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009194258.3207172-3-ira.weiny@intel.com>
Message-ID-Hash: VFJ7RB5DFIWMFTC536HTAVOILJ53Q6CN
X-Message-ID-Hash: VFJ7RB5DFIWMFTC536HTAVOILJ53Q6CN
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VFJ7RB5DFIWMFTC536HTAVOILJ53Q6CN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 09, 2020 at 12:42:51PM -0700, ira.weiny@intel.com wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Define a helper, update_pkey_val(), which will be used to support both
> Protection Key User (PKU) and the new Protection Key for Supervisor
> (PKS) in subsequent patches.
> 
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  arch/x86/include/asm/pkeys.h |  2 ++
>  arch/x86/kernel/fpu/xstate.c | 22 ++++------------------
>  arch/x86/mm/pkeys.c          | 21 +++++++++++++++++++++
>  3 files changed, 27 insertions(+), 18 deletions(-)

This is not from Fenghua.

  https://lkml.kernel.org/r/20200717085442.GX10769@hirez.programming.kicks-ass.net

This is your patch based on the code I wrote.

> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> index f5efb4007e74..3cf8f775f36d 100644
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -208,3 +208,24 @@ static __init int setup_init_pkru(char *opt)
>  	return 1;
>  }
>  __setup("init_pkru=", setup_init_pkru);
> +
> +/*
> + * Update the pk_reg value and return it.
> + *
> + * Kernel users use the same flags as user space:
> + *     PKEY_DISABLE_ACCESS
> + *     PKEY_DISABLE_WRITE
> + */
> +u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
> +{
> +	int pkey_shift = pkey * PKR_BITS_PER_PKEY;
> +
> +	pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);
> +
> +	if (flags & PKEY_DISABLE_ACCESS)
> +		pk_reg |= PKR_AD_BIT << pkey_shift;
> +	if (flags & PKEY_DISABLE_WRITE)
> +		pk_reg |= PKR_WD_BIT << pkey_shift;
> +
> +	return pk_reg;
> +}
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

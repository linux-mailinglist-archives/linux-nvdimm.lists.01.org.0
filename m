Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 370AA2903BE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Oct 2020 13:06:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45B9C15C010CA;
	Fri, 16 Oct 2020 04:06:51 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 804351577DEF2
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+HxT6lf8z2s6GX+yM9g2TG2m/mbY0AbXizuVmoeBCSI=; b=capeaNLUb3LFnGa/brHo4bIFTQ
	QJQCo9AMK4SnBeVk0sX4k2XI9kRKM66EHK7p878iLEgmTG9DTgeNRK9CW4C5ZvWitr99zV5WD+9Gw
	ytFSGteXDgy6qxNtniRa8OZBSn/DblzJ4SG5CS1qjKzxSzcBousHhBruuLTZZ5Z000k0dorzxRThr
	uq4wcigwlAEJEZT89cgqbp0Ro3TJz09ioe2044DK7ZMHEdOFsYAWkflsH0qX8g6kkCktfa88f/Ccn
	tq4jiLDAyn/dzjhhXdB4rtlSWS2yb5XJnLgGbujgvpvpfk0PA7w4f6G8Eqo5wABoMVBNPnvhIwiCO
	o26+0dyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTNZF-0002eY-9X; Fri, 16 Oct 2020 11:06:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76ACD30015A;
	Fri, 16 Oct 2020 13:06:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5CC0B203C7039; Fri, 16 Oct 2020 13:06:36 +0200 (CEST)
Date: Fri, 16 Oct 2020 13:06:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201016110636.GL2611@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009194258.3207172-5-ira.weiny@intel.com>
Message-ID-Hash: NZ7KQQ7W4UL74XEK5TZVPV3PMS45PKZL
X-Message-ID-Hash: NZ7KQQ7W4UL74XEK5TZVPV3PMS45PKZL
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NZ7KQQ7W4UL74XEK5TZVPV3PMS45PKZL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 09, 2020 at 12:42:53PM -0700, ira.weiny@intel.com wrote:

> @@ -644,6 +663,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  
>  	if ((tifp ^ tifn) & _TIF_SLD)
>  		switch_to_sld(tifn);
> +
> +	pks_sched_in();
>  }
>  

You seem to have lost the comment proposed here:

  https://lkml.kernel.org/r/20200717083140.GW10769@hirez.programming.kicks-ass.net

It is useful and important information that the wrmsr normally doesn't
happen.

> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> index 3cf8f775f36d..30f65dd3d0c5 100644
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -229,3 +229,31 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
>  
>  	return pk_reg;
>  }
> +
> +DEFINE_PER_CPU(u32, pkrs_cache);
> +
> +/**
> + * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
> + * serializing but still maintains ordering properties similar to WRPKRU.
> + * The current SDM section on PKRS needs updating but should be the same as
> + * that of WRPKRU.  So to quote from the WRPKRU text:
> + *
> + * 	WRPKRU will never execute transiently. Memory accesses
> + * 	affected by PKRU register will not execute (even transiently)
> + * 	until all prior executions of WRPKRU have completed execution
> + * 	and updated the PKRU register.

(whitespace damage; space followed by tabstop)

> + */
> +void write_pkrs(u32 new_pkrs)
> +{
> +	u32 *pkrs;
> +
> +	if (!static_cpu_has(X86_FEATURE_PKS))
> +		return;
> +
> +	pkrs = get_cpu_ptr(&pkrs_cache);
> +	if (*pkrs != new_pkrs) {
> +		*pkrs = new_pkrs;
> +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
> +	}
> +	put_cpu_ptr(pkrs);
> +}

looks familiar that... :-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A86E302839
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 Jan 2021 17:54:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 974BC100EBBA0;
	Mon, 25 Jan 2021 08:54:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA247100EF26A
	for <linux-nvdimm@lists.01.org>; Mon, 25 Jan 2021 08:54:54 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1611593693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUCMunEAlwcf5q7H1YeFZFYeq7DLFWJs3Mg8KMXP9Z0=;
	b=qPts7aTDPFTfj2b8NYdndbwpl6i5JliE2w0lBoVUP6U4zTo/URi/QcGr43vpN94WGA5dCH
	XnAz2JWBNo5ymP9pAlPpdWXCt4R7yejmS/ex2MOk+DV9LdD+lM2/Tj5CaXr9zzbw6bQq4U
	uLTmX7JwDHxFzCuXNYkpPrT28pphQ8o=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id DA924ACFB;
	Mon, 25 Jan 2021 16:54:52 +0000 (UTC)
Date: Mon, 25 Jan 2021 17:54:51 +0100
From: Michal Hocko <mhocko@suse.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
Message-ID: <20210125165451.GT827@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-9-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210121122723.3446-9-rppt@kernel.org>
Message-ID-Hash: 2H7YGC5GLDRMEO4CCODAKY2YWTWNTMGN
X-Message-ID-Hash: 2H7YGC5GLDRMEO4CCODAKY2YWTWNTMGN
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2H7YGC5GLDRMEO4CCODAKY2YWTWNTMGN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu 21-01-21 14:27:20, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Account memory consumed by secretmem to memcg. The accounting is updated
> when the memory is actually allocated and freed.

What does this mean? What are the lifetime rules?

[...]

> +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> +{
> +	int err;
> +
> +	err = memcg_kmem_charge_page(page, gfp, order);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * seceremem caches are unreclaimable kernel allocations, so treat
> +	 * them as unreclaimable slab memory for VM statistics purposes
> +	 */
> +	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> +			      PAGE_SIZE << order);

A lot of memcg accounted memory is not reclaimable. Why do you abuse
SLAB counter when this is not a slab owned memory? Why do you use the
kmem accounting API when __GFP_ACCOUNT should give you the same without
this details?
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7611223825
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 11:22:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B9C7311F7AAC9;
	Fri, 17 Jul 2020 02:22:00 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8CD2011F7AAC8
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TVkuCstWwGbU5lR9R8S3AI8DhZ88mUshSYAkBfz+5XE=; b=Z5Xnlmw2cCH5l1TalyDMrEJgWf
	WulSJp0j6pRZHL391RQPzEDB32ETPb124LofOLZsc+s0D6Mg20pQIlX2Kx9Jzyfb7Ej6o5tvuwoxC
	qItCuZPV4BNdciL2VYuOsi81AplfjiXWLOgJJznG0qW+EEIsp2xr4LSPuhWOAQ4z8FOm6OV5G5xyo
	vcTMrpiYIBlBOEqLCA9vhl4p77XSQFAlaGcGuDnjjf14l6MwdevORCZR/+FC+WZ5n7DFNyVDFgE6l
	phY6FcV5IZOeILg/4mOcFQG42H2iyjT2lwMRB0yBuh0Qz2sVkae9Mcm8X4Rk15UXY7KyCq7aXkDF6
	uiS6FqoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwMYm-0007PR-6T; Fri, 17 Jul 2020 09:21:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1ACE0304D58;
	Fri, 17 Jul 2020 11:21:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0BB8629CF6F4E; Fri, 17 Jul 2020 11:21:39 +0200 (CEST)
Date: Fri, 17 Jul 2020 11:21:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V2 13/17] kmap: Add stray write protection for device
 pages
Message-ID: <20200717092139.GC10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-14-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-14-ira.weiny@intel.com>
Message-ID-Hash: R4EEEJUP3PN3IIYHIEMFO3AEUMYD5VLS
X-Message-ID-Hash: R4EEEJUP3PN3IIYHIEMFO3AEUMYD5VLS
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R4EEEJUP3PN3IIYHIEMFO3AEUMYD5VLS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 12:20:52AM -0700, ira.weiny@intel.com wrote:
> @@ -31,6 +32,20 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
>  
>  #include <asm/kmap_types.h>
>  
> +static inline void enable_access(struct page *page)
> +{
> +	if (!page_is_access_protected(page))
> +		return;
> +	dev_access_enable();
> +}
> +
> +static inline void disable_access(struct page *page)
> +{
> +	if (!page_is_access_protected(page))
> +		return;
> +	dev_access_disable();
> +}

These are some very generic names, do we want them to be a little more
specific?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC2626C4C8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 18:00:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A6311454546F;
	Wed, 16 Sep 2020 08:59:59 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C7A514409C87
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=2L8WeVvRo1osqjjhclSBTpn136Oyr6chq2WMPl65EcM=; b=sha7upVR0ozVlTJFDWdFS4KUrg
	Dlh504xPkCjJ6bcnR0tgQmZYiIutQK/G0ONBD+iomCp+zVQ82oPYqYPfOa29q6UCwl36D+BB9FNFs
	pSeTBdPEiVQz6llxOwpNLZRraxMD45Yt9agHPf8ceWEhufE5EkURg5LtEm+1DjoRnfjJ/WOFs5+4j
	BadKgeBe/qwlbda6A6xYg/rSWFAOIGOJ/+qKGuMxZNBtCJ1ZUglDN7/DVuOWKZv/bNRIhqme65n0j
	CV7jlQDHwCcs1yfZz07j2hPdh6zbICLmsA3R4X5f+JNoZnWPrhrt60ytieQyxK1LeEjJ519udtgbv
	hAy+S0yQ==;
Received: from [2601:1c0:6280:3f0::19c2]
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIZqU-0000qm-87; Wed, 16 Sep 2020 15:59:46 +0000
Subject: Re: [PATCH v5 3/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20200916073539.3552-1-rppt@kernel.org>
 <20200916073539.3552-4-rppt@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6319035d-73db-4b4d-3fa7-aaa11d3843a0@infradead.org>
Date: Wed, 16 Sep 2020 08:59:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916073539.3552-4-rppt@kernel.org>
Content-Language: en-US
Message-ID-Hash: JUUVOZYDK3MSIUAQAFI62TNXOKX3H5FP
X-Message-ID-Hash: JUUVOZYDK3MSIUAQAFI62TNXOKX3H5FP
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, l
 inux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JUUVOZYDK3MSIUAQAFI62TNXOKX3H5FP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Mike,


On 9/16/20 12:35 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/Kconfig                   |   7 +
>  arch/x86/Kconfig               |   1 +
>  include/uapi/linux/magic.h     |   1 +
>  include/uapi/linux/secretmem.h |   8 +
>  kernel/sys_ni.c                |   2 +
>  mm/Kconfig                     |   4 +
>  mm/Makefile                    |   1 +
>  mm/secretmem.c                 | 264 +++++++++++++++++++++++++++++++++
>  8 files changed, 288 insertions(+)
>  create mode 100644 include/uapi/linux/secretmem.h
>  create mode 100644 mm/secretmem.c
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index af14a567b493..8d161bd4142d 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -975,6 +975,13 @@ config HAVE_SPARSE_SYSCALL_NR
>  config ARCH_HAS_VDSO_DATA
>  	bool
>  
> +config HAVE_SECRETMEM_UNCACHED
> +       bool
> +       help
> +          An architecture can select this if its semantics of non-cached
> +          mappings can be used to prevent speculative loads and it is
> +          useful for secret protection.

Please use tabs instead of spaces for indentation.

> +
>  source "kernel/gcov/Kconfig"
>  
>  source "scripts/gcc-plugins/Kconfig"

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 6c974888f86f..70cfc20d7caa 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -868,4 +868,8 @@ config ARCH_HAS_HUGEPD
>  config MAPPING_DIRTY_HELPERS
>          bool
>  
> +config SECRETMEM
> +        def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED

Use tab above for indentation.

> +	select GENERIC_ALLOCATOR
> +
>  endmenu


thanks.
-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

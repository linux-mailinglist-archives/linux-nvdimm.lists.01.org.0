Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE223CAD7
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Aug 2020 15:05:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0260A12B54564;
	Wed,  5 Aug 2020 06:05:43 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E2A512B54562
	for <linux-nvdimm@lists.01.org>; Wed,  5 Aug 2020 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=da1gRr0zZ2t7B4lRqNuRkoPDQjMi6ltCJuE8Al1tVCE=; b=HWXVkRHwN832dRG05UXHB0oBIw
	bVIHmST3idcP9ekdGW3zfjwF0Pw9NtKHZriMtDEWG2IfLDr6OCBzltDSMhOl6UaR4VB+MKj5TLP04
	D+y2OfSJNRXduO2wurxCTyIhNrEbjOfxiC3fQ9kowloxLDsXYz+qNZBWskWkV4r67YJb5rni6tnxu
	zEaPdgkZf+diFOhUAogaiUm5PlxPfMHj+JY1pUqMrnKYwv3swkoiKxzB+3OAJw82jZfkAD5C/RvSG
	ZSbD7oGskSaQ/+z+rKi6n9bG70XhVIbZNtZ+0+ODNHwM6cKpRLNKr0S7UXSrAbxLcx/udZsOs7w26
	cmMvbHww==;
Received: from [2601:1c0:6280:3f0::19c2]
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3J6n-0003pL-49; Wed, 05 Aug 2020 13:05:31 +0000
Subject: Re: [PATCH v3 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
References: <20200804095035.18778-1-rppt@kernel.org>
 <20200804095035.18778-4-rppt@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1f52d43e-29e4-b175-73d5-0aa3c3e79f23@infradead.org>
Date: Wed, 5 Aug 2020 06:05:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804095035.18778-4-rppt@kernel.org>
Content-Language: en-US
Message-ID-Hash: RJFFGBVTXV22UWILBTMUCX4LOPJKWTL2
X-Message-ID-Hash: RJFFGBVTXV22UWILBTMUCX4LOPJKWTL2
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.o
 rg, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RJFFGBVTXV22UWILBTMUCX4LOPJKWTL2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 8/4/20 2:50 AM, Mike Rapoport wrote:
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f2104cc0d35c..8378175e72a4 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -872,4 +872,8 @@ config ARCH_HAS_HUGEPD
>  config MAPPING_DIRTY_HELPERS
>          bool
>  
> +config SECRETMEM
> +        def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED

use tab above, not spaces.

> +	select GENERIC_ALLOCATOR
> +
>  endmenu


-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

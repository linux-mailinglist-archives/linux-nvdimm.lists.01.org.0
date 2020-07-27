Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F4622F63B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Jul 2020 19:11:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6C615123CCCC8;
	Mon, 27 Jul 2020 10:11:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE239123C2E0B
	for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 10:11:17 -0700 (PDT)
Received: from kernel.org (unknown [87.71.40.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 3AAEB206E7;
	Mon, 27 Jul 2020 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595869877;
	bh=XLRy4SH6xYtcSpdHOrlqOGtGsA5ScggILcg7hMblP4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGlKfXBUd26L5XDA1ssqNMsN524ad4SB5OWposrAfAR1GqXXVCoku8j2/PxKiDDlt
	 ZjgCXf8wWE4+IGmxJrktVr72zad9jL8jTfqjGu+VoAyYWbVCO1WDhniWv6reqEeMu8
	 mqapPlh3w6TjsmKchi6eYJoHQoysiCGjddWIxmbQ=
Date: Mon, 27 Jul 2020 20:11:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] mm: secretmem: add ability to reserve memory at
 boot
Message-ID: <20200727171102.GA3655207@kernel.org>
References: <20200727162935.31714-1-rppt@kernel.org>
 <20200727162935.31714-8-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200727162935.31714-8-rppt@kernel.org>
Message-ID-Hash: VQ7Y3ZLWEQCIQVKSE5LDYLOPNIOCQYS7
X-Message-ID-Hash: VQ7Y3ZLWEQCIQVKSE5LDYLOPNIOCQYS7
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, li
 nux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VQ7Y3ZLWEQCIQVKSE5LDYLOPNIOCQYS7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Oops, something went wrong with the rebase, this should have been
squashed into the previous patch...

On Mon, Jul 27, 2020 at 07:29:35PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Taking pages out from the direct map and bringing them back may create
> undesired fragmentation and usage of the smaller pages in the direct
> mapping of the physical memory.
> 
> This can be avoided if a significantly large area of the physical memory
> would be reserved for secretmem purposes at boot time.
> 
> Add ability to reserve physical memory for secretmem at boot time using
> "secretmem" kernel parameter and then use that reserved memory as a global
> pool for secret memory needs.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..6f3c2f28160f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4548,6 +4548,10 @@
>  			Format: integer between 0 and 10
>  			Default is 0.
>  
> +	secretmem=n[KMG]
> +			[KNL,BOOT] Reserve specified amount of memory to
> +			back mappings of secret memory.
> +
>  	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
>  			xtime_lock contention on larger systems, and/or RCU lock
>  			contention on all systems with CONFIG_MAXSMP set.
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 036BA152510
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 04:05:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A04741007B1F8;
	Tue,  4 Feb 2020 19:08:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7BFF11007B1F8
	for <linux-nvdimm@lists.01.org>; Tue,  4 Feb 2020 19:08:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 48C5yp0hsYz9sSR;
	Wed,  5 Feb 2020 14:05:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1580871907;
	bh=Dy2HNszoS5jMHuHyexeNZ1i6v2XpVUmuydKw/9Caj58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oLjjl/QmMaQUGkaI425lp8ZqbybG1H7xgmO+WmWq3t6CGe3Ydfi2omMvBob16Z5TS
	 LHkGOmvtvcpZoOVFbp1xrUN8gFyM+NV2mLZMiM0QNEI7mXLXmjvRfPJAaikuMqME9U
	 DdqyIDLQ8fMvvU9O3fXj+2ZNog4M9YaBI1kKj0vVSxuvesokyfqnXtxONTr0BTRBPw
	 GW6r4NuLz+BlK//+r3+ZzGcMec3ZhTxzZS+gLGPQpEtFPtWSi10F20kXho2mhO2xk1
	 C2dHxfOWKKQ1nfwjw5I8ncgxAzNir+zHOoAFGWZtbmPWBsUWAIawAKTavRpdoKHRah
	 /1o2zj3OuuW7Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 2/5] mm/memremap_pages: Introduce memremap_compat_align()
In-Reply-To: <158041476763.3889308.13149849631980018039.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com> <158041476763.3889308.13149849631980018039.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Wed, 05 Feb 2020 14:05:02 +1100
Message-ID: <875zgl3fa9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-ID-Hash: CFFLZ7267THKLJUTMCXSY4CMUCZV323S
X-Message-ID-Hash: CFFLZ7267THKLJUTMCXSY4CMUCZV323S
X-MailFrom: mpe@ellerman.id.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, hch@lst.de, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CFFLZ7267THKLJUTMCXSY4CMUCZV323S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:
> The "sub-section memory hotplug" facility allows memremap_pages() users
> like libnvdimm to compensate for hardware platforms like x86 that have a
> section size larger than their hardware memory mapping granularity.  The
> compensation that sub-section support affords is being tolerant of
> physical memory resources shifting by units smaller (64MiB on x86) than
> the memory-hotplug section size (128 MiB). Where the platform
> physical-memory mapping granularity is limited by the number and
> capability of address-decode-registers in the memory controller.
>
> While the sub-section support allows memremap_pages() to operate on
> sub-section (2MiB) granularity, the Power architecture may still
> require 16MiB alignment on "!radix_enabled()" platforms.
>
> In order for libnvdimm to be able to detect and manage this per-arch
> limitation, introduce memremap_compat_align() as a common minimum
> alignment across all driver-facing memory-mapping interfaces, and let
> Power override it to 16MiB in the "!radix_enabled()" case.
>
> The assumption / requirement for 16MiB to be a viable
> memremap_compat_align() value is that Power does not have platforms
> where its equivalent of address-decode-registers never hardware remaps a
> persistent memory resource on smaller than 16MiB boundaries.
>
> Based on an initial patch by Aneesh.
>
> Link: http://lore.kernel.org/r/CAPcyv4gBGNP95APYaBcsocEa50tQj9b5h__83vgngjq3ouGX_Q@mail.gmail.com
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/powerpc/include/asm/io.h |   10 ++++++++++
>  drivers/nvdimm/pfn_devs.c     |    2 +-
>  include/linux/io.h            |   23 +++++++++++++++++++++++
>  include/linux/mmzone.h        |    1 +
>  4 files changed, 35 insertions(+), 1 deletion(-)

The powerpc change here looks fine to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index a63ec938636d..0fa2dc483008 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -734,6 +734,16 @@ extern void __iomem * __ioremap_at(phys_addr_t pa, void *ea,
>  				   unsigned long size, pgprot_t prot);
>  extern void __iounmap_at(void *ea, unsigned long size);
>  
> +#ifdef CONFIG_SPARSEMEM
> +static inline unsigned long memremap_compat_align(void)
> +{
> +	if (radix_enabled())
> +		return SUBSECTION_SIZE;
> +	return (1UL << mmu_psize_defs[mmu_linear_psize].shift);
> +}
> +#define memremap_compat_align memremap_compat_align
> +#endif
> +
>  /*
>   * When CONFIG_PPC_INDIRECT_PIO is set, we use the generic iomap implementation
>   * which needs some additional definitions here. They basically allow PIO
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

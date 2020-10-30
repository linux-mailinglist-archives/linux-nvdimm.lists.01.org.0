Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C09A29FBFE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Oct 2020 04:05:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1F08616560DA8;
	Thu, 29 Oct 2020 20:05:56 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 326A916560DA2
	for <linux-nvdimm@lists.01.org>; Thu, 29 Oct 2020 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=IQCVq7lEFY4ZXTcSP8xyrm8MlU2EUcpLtjS377JVJrA=; b=TigpKhuNkaCHPAVrtzYG2pTwkr
	MQtdqJ44dF6DgW4X3L3QiOSF1U4bfsNpakAYDDhFQN1E+Nehxpe0iOBh4C1qrJqbsqceI9THYatBd
	y9OnxhinSIJFKAFVxq2/j/hhkOJUCjMbE4Ghqn0/8YM8rZ5L3zzA0dxwSM4VaiROF7SqT6MRhy1f/
	96/mT8gaIv/GULDNzkhb5aEB7mRQ/oBlgV+d+Pbrha9+f4kbyjkQApjbNQyehxAqFmnE5n8hGN+GP
	j03L20PMrzEWvMy5oafjodPnHOf1ErW0mkdBYhj3FNP0xBsdcRB561V/IVYGghh4H226+Ddy2+roQ
	/ryZNJiA==;
Received: from [2601:1c0:6280:3f0::371c]
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYKjb-0001Ap-DH; Fri, 30 Oct 2020 03:05:47 +0000
Subject: Re: [PATCH] x86/mm: Fix phys_to_target_node() export
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
References: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c3316d91-c238-402b-c981-0123fd663ec4@infradead.org>
Date: Thu, 29 Oct 2020 20:05:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Message-ID-Hash: 6DW2BAQPQ7FYDQPP7R6FKOX6U3N5LPQG
X-Message-ID-Hash: 6DW2BAQPQ7FYDQPP7R6FKOX6U3N5LPQG
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, x86@kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6DW2BAQPQ7FYDQPP7R6FKOX6U3N5LPQG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/29/20 7:29 PM, Dan Williams wrote:
> The core-mm has a default __weak implementation of phys_to_target_node()
> when the architecture does not override it. That symbol is exported
> for modules. However, while the export in mm/memory_hotplug.c exported
> the symbol in the configuration cases of:
> 
> 	CONFIG_NUMA_KEEP_MEMINFO=y
> 	CONFIG_MEMORY_HOTPLUG=y
> 
> ...and:
> 
> 	CONFIG_NUMA_KEEP_MEMINFO=n
> 	CONFIG_MEMORY_HOTPLUG=y
> 
> ...it failed to export the symbol in the case of:
> 
> 	CONFIG_NUMA_KEEP_MEMINFO=y
> 	CONFIG_MEMORY_HOTPLUG=n
> 
> Always export the symbol from the CONFIG_NUMA_KEEP_MEMINFO section of
> arch/x86/mm/numa.c, and teach mm/memory_hotplug.c to optionally export
> in case arch/x86/mm/numa.c has already performed the export.
> 
> The dependency on NUMA_KEEP_MEMINFO for DEV_DAX_HMEM_DEVICES is invalid
> now that the symbol is properly exported in all combinations of
> CONFIG_NUMA_KEEP_MEMINFO and CONFIG_MEMORY_HOTPLUG. Note that in the
> CONFIG_NUMA=n case no export is needed since their is a dummy static
> inline implementation of phys_to_target_node() in that case.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: a035b6bf863e ("mm/memory_hotplug: introduce default phys_to_target_node() implementation")
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


> ---
>  arch/x86/mm/numa.c  |    1 +
>  drivers/dax/Kconfig |    1 -
>  mm/memory_hotplug.c |    5 +++++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 44148691d78b..e025947f19e0 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -938,6 +938,7 @@ int phys_to_target_node(phys_addr_t start)
>  
>  	return meminfo_to_nid(&numa_reserved_meminfo, start);
>  }
> +EXPORT_SYMBOL_GPL(phys_to_target_node);
>  
>  int memory_add_physaddr_to_nid(u64 start)
>  {
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index 567428e10b7b..d2834c2cfa10 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -50,7 +50,6 @@ config DEV_DAX_HMEM
>  	  Say M if unsure.
>  
>  config DEV_DAX_HMEM_DEVICES
> -	depends on NUMA_KEEP_MEMINFO # for phys_to_target_node()
>  	depends on DEV_DAX_HMEM && DAX=y
>  	def_bool y
>  
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b44d4c7ba73b..ed326b489674 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -365,9 +365,14 @@ int __weak phys_to_target_node(u64 start)
>  			start);
>  	return 0;
>  }
> +
> +/* If the arch did not export a strong symbol, export the weak one. */
> +#ifndef CONFIG_NUMA_KEEP_MEMINFO
>  EXPORT_SYMBOL_GPL(phys_to_target_node);
>  #endif
>  
> +#endif
> +
>  /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
>  static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
>  				     unsigned long start_pfn,
> 
> 


-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

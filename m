Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 248272A0434
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Oct 2020 12:34:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 44764165780EE;
	Fri, 30 Oct 2020 04:34:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A68E216572509
	for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 04:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1604057676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZZiFHkCJ4oPedcp68fkUsKmumK9JIlBRCeMmx6sJP4=;
	b=FShVL5L/eHZ+4sPOJQ4TamBr0fKTfvzWgsBihTV8QFWaseeO9x1hWZ+TYpmXu+49U0AeHG
	ZUoP5Rv/qipwQhEaxMatgE938Fuqtgyo77bzeswwJPTbYgTqVqLxJaextxvQbdj3Zk/8Vg
	th3+m+pe4D10XlA1dwO/OpU2jeAFfZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-EEeP5EFhOW2VXK5Rky8MpA-1; Fri, 30 Oct 2020 07:34:32 -0400
X-MC-Unique: EEeP5EFhOW2VXK5Rky8MpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67EDD107B784;
	Fri, 30 Oct 2020 11:34:30 +0000 (UTC)
Received: from [10.36.112.97] (ovpn-112-97.ams2.redhat.com [10.36.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5420160F96;
	Fri, 30 Oct 2020 11:34:27 +0000 (UTC)
Subject: Re: [PATCH] x86/mm: Fix phys_to_target_node() export
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
References: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <708658b8-fc77-1503-5c98-c05b50c92b90@redhat.com>
Date: Fri, 30 Oct 2020 12:34:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: VRBS2OPXU4VG3IBXE2HSPHX7AWP2VUQR
X-Message-ID-Hash: VRBS2OPXU4VG3IBXE2HSPHX7AWP2VUQR
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, x86@kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VRBS2OPXU4VG3IBXE2HSPHX7AWP2VUQR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 30.10.20 03:29, Dan Williams wrote:
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
> ---
>   arch/x86/mm/numa.c  |    1 +
>   drivers/dax/Kconfig |    1 -
>   mm/memory_hotplug.c |    5 +++++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 44148691d78b..e025947f19e0 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -938,6 +938,7 @@ int phys_to_target_node(phys_addr_t start)
>   
>   	return meminfo_to_nid(&numa_reserved_meminfo, start);
>   }
> +EXPORT_SYMBOL_GPL(phys_to_target_node);
>   
>   int memory_add_physaddr_to_nid(u64 start)
>   {
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index 567428e10b7b..d2834c2cfa10 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -50,7 +50,6 @@ config DEV_DAX_HMEM
>   	  Say M if unsure.
>   
>   config DEV_DAX_HMEM_DEVICES
> -	depends on NUMA_KEEP_MEMINFO # for phys_to_target_node()
>   	depends on DEV_DAX_HMEM && DAX=y
>   	def_bool y
>   
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b44d4c7ba73b..ed326b489674 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -365,9 +365,14 @@ int __weak phys_to_target_node(u64 start)
>   			start);
>   	return 0;
>   }
> +
> +/* If the arch did not export a strong symbol, export the weak one. */
> +#ifndef CONFIG_NUMA_KEEP_MEMINFO
>   EXPORT_SYMBOL_GPL(phys_to_target_node);
>   #endif
>   
> +#endif
> +
>   /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
>   static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
>   				     unsigned long start_pfn,
> 
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

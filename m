Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED822F2B94
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 10:47:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38520100EB820;
	Tue, 12 Jan 2021 01:47:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7D07E100EBBB9
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 01:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1610444815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvyJnSq10lv34KzIUsMYXdt+Iwqvb+rfS/2QN/Oiz50=;
	b=Gwcf7vT9zsJD2Q5agrog1msmuVsMGAW/NXj89/JZgAl0b5loUE3eyehVq01Q33X6M1tUtc
	CjnHWhIiLKfFVK3/HaqXAXVnG3+edrX5uxI5MfTGGorTsi6aLQSBk1JWNXzlL57YEAF29A
	BoAqCna9Pg8YAcgny3pbE/ThR5ZtbRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-X3MvMTgaPCm-Vt0DpjGlVA-1; Tue, 12 Jan 2021 04:46:45 -0500
X-MC-Unique: X3MvMTgaPCm-Vt0DpjGlVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C362107ACF7;
	Tue, 12 Jan 2021 09:46:44 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DBD8960BE2;
	Tue, 12 Jan 2021 09:46:42 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] mm: Move pfn_to_online_page() out of line
To: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044408207.1482714.1125458890762969867.stgit@dwillia2-desk3.amr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a85a1fa0-4ad8-ee63-eab0-de73bc532431@redhat.com>
Date: Tue, 12 Jan 2021 10:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161044408207.1482714.1125458890762969867.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: WEVA75UGD4ZXXQQPMDUYQEK57JLUVI3W
X-Message-ID-Hash: WEVA75UGD4ZXXQQPMDUYQEK57JLUVI3W
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@kernel.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WEVA75UGD4ZXXQQPMDUYQEK57JLUVI3W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12.01.21 10:34, Dan Williams wrote:
> pfn_to_online_page() is already too large to be a macro or an inline
> function. In anticipation of further logic changes / growth, move it out
> of line.
> 
> No functional change, just code movement.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Reported-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/memory_hotplug.h |   17 +----------------
>  mm/memory_hotplug.c            |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 15acce5ab106..3d99de0db2dd 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -16,22 +16,7 @@ struct resource;
>  struct vmem_altmap;
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -/*
> - * Return page for the valid pfn only if the page is online. All pfn
> - * walkers which rely on the fully initialized page->flags and others
> - * should use this rather than pfn_valid && pfn_to_page
> - */
> -#define pfn_to_online_page(pfn)					   \
> -({								   \
> -	struct page *___page = NULL;				   \
> -	unsigned long ___pfn = pfn;				   \
> -	unsigned long ___nr = pfn_to_section_nr(___pfn);	   \
> -								   \
> -	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> -	    pfn_valid_within(___pfn))				   \
> -		___page = pfn_to_page(___pfn);			   \
> -	___page;						   \
> -})
> +struct page *pfn_to_online_page(unsigned long pfn);
>  
>  /*
>   * Types for free bootmem stored in page->lru.next. These have to be in
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f9d57b9be8c7..55a69d4396e7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -300,6 +300,22 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>  	return 0;
>  }
>  
> +/*
> + * Return page for the valid pfn only if the page is online. All pfn
> + * walkers which rely on the fully initialized page->flags and others
> + * should use this rather than pfn_valid && pfn_to_page
> + */
> +struct page *pfn_to_online_page(unsigned long pfn)
> +{
> +	unsigned long nr = pfn_to_section_nr(pfn);
> +
> +	if (nr < NR_MEM_SECTIONS && online_section_nr(nr) &&
> +	    pfn_valid_within(pfn))
> +		return pfn_to_page(pfn);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pfn_to_online_page);
> +
>  /*
>   * Reasonably generic function for adding memory.  It is
>   * expected that archs that support memory hotplug will
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

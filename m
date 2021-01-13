Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB82F4687
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 09:31:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 95C07100EB339;
	Wed, 13 Jan 2021 00:31:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E75D100EB338
	for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 00:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1610526667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLp4vxk+82Jz6Cr9tpUqUqEbN1T5xSL04lBhhKhpD84=;
	b=c6ziVMulQDuJE40pF/+G7oxsGZqwJ5VrTGE7CFhF//X1Bt4l3pFltZ2+goeyMojTLfYsou
	V+bi+yYJ50vf93B8RNKu4xpVhsNTwGTlrtvB17z/3Z15EZvrZQbTWeB1HW9NHuUxy5xc01
	7CBLXsbGX0AQ1m05qX7TgsH5q0dNAGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-Iphjah_0POy8mBshrFSi2g-1; Wed, 13 Jan 2021 03:31:05 -0500
X-MC-Unique: Iphjah_0POy8mBshrFSi2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D6238066E2;
	Wed, 13 Jan 2021 08:31:04 +0000 (UTC)
Received: from [10.36.114.135] (ovpn-114-135.ams2.redhat.com [10.36.114.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9DAA45D9DD;
	Wed, 13 Jan 2021 08:31:02 +0000 (UTC)
Subject: Re: [PATCH v3 5/6] mm: Fix memory_failure() handling of dax-namespace
 metadata
To: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161052334425.1805594.17861842381807251887.stgit@dwillia2-desk3.amr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4664e9f3-5c2d-4c51-2bcd-9d03ef9c4fed@redhat.com>
Date: Wed, 13 Jan 2021 09:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161052334425.1805594.17861842381807251887.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: GESCGQE3JM5LMMBKIH6D47VUKFPRKMPL
X-Message-ID-Hash: GESCGQE3JM5LMMBKIH6D47VUKFPRKMPL
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Naoya Horiguchi <naoya.horiguchi@nec.com>, Andrew Morton <akpm@linux-foundation.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GESCGQE3JM5LMMBKIH6D47VUKFPRKMPL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13.01.21 08:35, Dan Williams wrote:
> Given 'struct dev_pagemap' spans both data pages and metadata pages be
> careful to consult the altmap if present to delineate metadata. In fact
> the pfn_first() helper already identifies the first valid data pfn, so
> export that helper for other code paths via pgmap_pfn_valid().
> 
> Other usage of get_dev_pagemap() are not a concern because those are
> operating on known data pfns having been looking up by get_user_pages().
> I.e. metadata pfns are never user mapped.
> 
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/memremap.h |    6 ++++++
>  mm/memory-failure.c      |    6 ++++++
>  mm/memremap.c            |   15 +++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 79c49e7f5c30..f5b464daeeca 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -137,6 +137,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
>  void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
>  struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  		struct dev_pagemap *pgmap);
> +bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
>  
>  unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
>  void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
> @@ -165,6 +166,11 @@ static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  	return NULL;
>  }
>  
> +static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
> +{
> +	return false;
> +}
> +
>  static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
>  {
>  	return 0;
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 78b173c7190c..541569cb4a99 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1308,6 +1308,12 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  		 */
>  		put_page(page);
>  
> +	/* device metadata space is not recoverable */
> +	if (!pgmap_pfn_valid(pgmap, pfn)) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Prevent the inode from being freed while we are interrogating
>  	 * the address_space, typically this would be handled by
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 16b2fb482da1..2455bac89506 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -80,6 +80,21 @@ static unsigned long pfn_first(struct dev_pagemap *pgmap, int range_id)
>  	return pfn + vmem_altmap_offset(pgmap_altmap(pgmap));
>  }
>  
> +bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
> +{
> +	int i;
> +
> +	for (i = 0; i < pgmap->nr_range; i++) {
> +		struct range *range = &pgmap->ranges[i];
> +
> +		if (pfn >= PHYS_PFN(range->start) &&
> +		    pfn <= PHYS_PFN(range->end))
> +			return pfn >= pfn_first(pgmap, i);
> +	}
> +
> +	return false;
> +}
> +
>  static unsigned long pfn_end(struct dev_pagemap *pgmap, int range_id)
>  {
>  	const struct range *range = &pgmap->ranges[range_id];
> 

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

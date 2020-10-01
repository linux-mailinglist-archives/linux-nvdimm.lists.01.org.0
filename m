Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FEC27FBB9
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Oct 2020 10:41:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86F2E154F5C5B;
	Thu,  1 Oct 2020 01:41:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 22CC7154F5C59
	for <linux-nvdimm@lists.01.org>; Thu,  1 Oct 2020 01:41:25 -0700 (PDT)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1601541683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vv5CEkkTlSYputHEql/RgJBda51Hxz9ogvuSCFmZEdQ=;
	b=LN8neGWWP+gFf7TMHzZETXiZ7uuoKqLNAPU6sJRQk88F9UX0h/xLTg0dmgUu63bmcBU8o/
	FRnxjnUzWUqteT5WaNGoGjnpLYVTzlEgk3AtmGPsizlLmeKWc8n9yDLaM+AqRKGDHUWwV0
	F8yyoQ8QK08c5wtjolvoFUgbCqArJ0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-zIO-qmr0ONqlCgKZzLIScg-1; Thu, 01 Oct 2020 04:41:19 -0400
X-MC-Unique: zIO-qmr0ONqlCgKZzLIScg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CECF186840F;
	Thu,  1 Oct 2020 08:41:16 +0000 (UTC)
Received: from [10.36.114.102] (ovpn-114-102.ams2.redhat.com [10.36.114.102])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 26AF719931;
	Thu,  1 Oct 2020 08:41:11 +0000 (UTC)
Subject: Re: [PATCH v5 01/17] device-dax: make pgmap optional for instance
 creation
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160106110513.30709.4303239334850606031.stgit@dwillia2-desk3.amr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <e3b7c947-c221-8be7-41ae-aed2f481d640@redhat.com>
Date: Thu, 1 Oct 2020 10:41:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160106110513.30709.4303239334850606031.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: JUXMONL2TOSM3DKRDBAAVEVIKQIBIXJP
X-Message-ID-Hash: JUXMONL2TOSM3DKRDBAAVEVIKQIBIXJP
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Brice Goglin <Brice.Goglin@inria.fr>, Jia He <justin.he@arm.com>, Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JUXMONL2TOSM3DKRDBAAVEVIKQIBIXJP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25.09.20 21:11, Dan Williams wrote:
> The passed in dev_pagemap is only required in the pmem case as the
> libnvdimm core may have reserved a vmem_altmap for dev_memremap_pages() to
> place the memmap in pmem directly.  In the hmem case there is no agent
> reserving an altmap so it can all be handled by a core internal default.
> 
> Pass the resource range via a new @range property of 'struct
> dev_dax_data'.
> 
> Link: https://lkml.kernel.org/r/159643099958.4062302.10379230791041872886.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Brice Goglin <Brice.Goglin@inria.fr>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jia He <justin.he@arm.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/bus.c              |   29 +++++++++++++++--------------
>  drivers/dax/bus.h              |    2 ++
>  drivers/dax/dax-private.h      |    9 ++++++++-
>  drivers/dax/device.c           |   28 +++++++++++++++++++---------
>  drivers/dax/hmem/hmem.c        |    8 ++++----
>  drivers/dax/kmem.c             |   12 ++++++------
>  drivers/dax/pmem/core.c        |    4 ++++
>  tools/testing/nvdimm/dax-dev.c |    8 ++++----
>  8 files changed, 62 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index dffa4655e128..96bd64ba95a5 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -271,7 +271,7 @@ static ssize_t size_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
> -	unsigned long long size = resource_size(&dev_dax->region->res);
> +	unsigned long long size = range_len(&dev_dax->range);
>  
>  	return sprintf(buf, "%llu\n", size);
>  }
> @@ -293,19 +293,12 @@ static ssize_t target_node_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(target_node);
>  
> -static unsigned long long dev_dax_resource(struct dev_dax *dev_dax)
> -{
> -	struct dax_region *dax_region = dev_dax->region;
> -
> -	return dax_region->res.start;
> -}
> -
>  static ssize_t resource_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  
> -	return sprintf(buf, "%#llx\n", dev_dax_resource(dev_dax));
> +	return sprintf(buf, "%#llx\n", dev_dax->range.start);
>  }
>  static DEVICE_ATTR(resource, 0400, resource_show, NULL);
>  
> @@ -376,6 +369,7 @@ static void dev_dax_release(struct device *dev)
>  
>  	dax_region_put(dax_region);
>  	put_dax(dax_dev);
> +	kfree(dev_dax->pgmap);
>  	kfree(dev_dax);
>  }
>  
> @@ -412,7 +406,12 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>  	if (!dev_dax)
>  		return ERR_PTR(-ENOMEM);
>  
> -	memcpy(&dev_dax->pgmap, data->pgmap, sizeof(struct dev_pagemap));
> +	if (data->pgmap) {
> +		dev_dax->pgmap = kmemdup(data->pgmap,
> +				sizeof(struct dev_pagemap), GFP_KERNEL);
> +		if (!dev_dax->pgmap)
> +			goto err_pgmap;
> +	}
>  
>  	/*
>  	 * No 'host' or dax_operations since there is no access to this
> @@ -421,18 +420,19 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>  	dax_dev = alloc_dax(dev_dax, NULL, NULL, DAXDEV_F_SYNC);
>  	if (IS_ERR(dax_dev)) {
>  		rc = PTR_ERR(dax_dev);
> -		goto err;
> +		goto err_alloc_dax;
>  	}
>  
>  	/* a device_dax instance is dead while the driver is not attached */
>  	kill_dax(dax_dev);
>  
> -	/* from here on we're committed to teardown via dax_dev_release() */
> +	/* from here on we're committed to teardown via dev_dax_release() */
>  	dev = &dev_dax->dev;
>  	device_initialize(dev);
>  
>  	dev_dax->dax_dev = dax_dev;
>  	dev_dax->region = dax_region;
> +	dev_dax->range = data->range;
>  	dev_dax->target_node = dax_region->target_node;
>  	kref_get(&dax_region->kref);
>  
> @@ -458,8 +458,9 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>  		return ERR_PTR(rc);
>  
>  	return dev_dax;
> -
> - err:
> +err_alloc_dax:
> +	kfree(dev_dax->pgmap);
> +err_pgmap:
>  	kfree(dev_dax);
>  
>  	return ERR_PTR(rc);
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index 299c2e7fac09..4aeb36da83a4 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -3,6 +3,7 @@
>  #ifndef __DAX_BUS_H__
>  #define __DAX_BUS_H__
>  #include <linux/device.h>
> +#include <linux/range.h>
>  
>  struct dev_dax;
>  struct resource;
> @@ -21,6 +22,7 @@ struct dev_dax_data {
>  	struct dax_region *dax_region;
>  	struct dev_pagemap *pgmap;
>  	enum dev_dax_subsys subsys;
> +	struct range range;
>  	int id;
>  };
>  
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 8a4c40ccd2ef..6779f683671d 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -41,6 +41,7 @@ struct dax_region {
>   * @target_node: effective numa node if dev_dax memory range is onlined
>   * @dev - device core
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
> + * @range: resource range for the instance
>   * @dax_mem_res: physical address range of hotadded DAX memory
>   * @dax_mem_name: name for hotadded DAX memory via add_memory_driver_managed()
>   */
> @@ -49,10 +50,16 @@ struct dev_dax {
>  	struct dax_device *dax_dev;
>  	int target_node;
>  	struct device dev;
> -	struct dev_pagemap pgmap;
> +	struct dev_pagemap *pgmap;
> +	struct range range;
>  	struct resource *dax_kmem_res;
>  };
>  
> +static inline u64 range_len(struct range *range)
> +{
> +	return range->end - range->start + 1;
> +}

include/linux/range.h seems to have this function - why is this here needed?

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

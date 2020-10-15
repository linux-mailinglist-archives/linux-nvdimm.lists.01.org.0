Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4385E28EF61
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Oct 2020 11:29:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 55F38159A4819;
	Thu, 15 Oct 2020 02:29:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B6EC0159A4818
	for <linux-nvdimm@lists.01.org>; Thu, 15 Oct 2020 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1602754145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RM2QVF+V+hLr3+Hq7uLhLi1sgIiupbgiR8L9qI6w03U=;
	b=jFTaFJfQDEEBlHiKtSgJ20NeMkY6//Zm5Rsu83RjlPBl0KrxIAVn6/Y9BwF7dFb3J5XH6z
	WkRRTekJvwU+ol6C/AszmeLj6omGOp0OWFiOjdrioHqjqdEe9WFDJCNGLubN7zFUFF4d4g
	1xC34rYhWQfPbLbDsBDC5MBc/Vx7s+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-NvYuuqNdPMOJwj3qDf8LCA-1; Thu, 15 Oct 2020 05:29:03 -0400
X-MC-Unique: NvYuuqNdPMOJwj3qDf8LCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED2C1803629;
	Thu, 15 Oct 2020 09:29:00 +0000 (UTC)
Received: from [10.36.114.207] (ovpn-114-207.ams2.redhat.com [10.36.114.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C6C8610F3;
	Thu, 15 Oct 2020 09:28:55 +0000 (UTC)
Subject: Re: [PATCH 1/2] device-dax/kmem: Fix resource release
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
References: <160272252400.3136502.13635752844548960833.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160272252925.3136502.17220638073995895400.stgit@dwillia2-desk3.amr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <9b463afd-6e33-8afd-23ff-84d602029fc9@redhat.com>
Date: Thu, 15 Oct 2020 11:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160272252925.3136502.17220638073995895400.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: YYZYL4ZXUNNCRUXI2PCUFQZLUMPJDWXF
X-Message-ID-Hash: YYZYL4ZXUNNCRUXI2PCUFQZLUMPJDWXF
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Brice Goglin <Brice.Goglin@inria.fr>, Jia He <justin.he@arm.com>, Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, akpm@linux-foundation.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YYZYL4ZXUNNCRUXI2PCUFQZLUMPJDWXF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 15.10.20 02:42, Dan Williams wrote:
> The conversion to request_mem_region() is broken because it assumes that
> the range is marked busy prior to release. However, due to the way that
> the kmem driver manipulates the IORESOURCE_BUSY flag (clears it to
> let {add,remove}_memory() handle busy) it requires a manual
> release_resource() to perform cleanup.
> 
> Given that the actual 'struct resource *' needs to be recalled, not just
> the range, add that tracking to the kmem driver-data.
> 
> Reported-by: David Hildenbrand <david@redhat.com>
> Fixes: 0513bd5bb114 ("device-dax/kmem: replace release_resource() with release_mem_region()")
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Brice Goglin <Brice.Goglin@inria.fr>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jia He <justin.he@arm.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/kmem.c |   48 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 6c933f2b604e..af04b6d1d263 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -35,11 +35,17 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
>  	return 0;
>  }
>  
> +struct dax_kmem_data {
> +	const char *res_name;
> +	struct resource *res[];
> +};
> +
>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  {
>  	struct device *dev = &dev_dax->dev;
> +	struct dax_kmem_data *data;
> +	int rc = -ENOMEM;
>  	int i, mapped = 0;
> -	char *res_name;
>  	int numa_node;
>  
>  	/*
> @@ -55,14 +61,17 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		return -EINVAL;
>  	}
>  
> -	res_name = kstrdup(dev_name(dev), GFP_KERNEL);
> -	if (!res_name)
> +	data = kzalloc(sizeof(*data) + sizeof(struct resource *) * dev_dax->nr_range, GFP_KERNEL);
> +	if (!data)
>  		return -ENOMEM;
>  
> +	data->res_name = kstrdup(dev_name(dev), GFP_KERNEL);
> +	if (!data->res_name)
> +		goto err_res_name;
> +
>  	for (i = 0; i < dev_dax->nr_range; i++) {
>  		struct resource *res;
>  		struct range range;
> -		int rc;
>  
>  		rc = dax_kmem_range(dev_dax, i, &range);
>  		if (rc) {
> @@ -72,7 +81,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		}
>  
>  		/* Region is permanently reserved if hotremove fails. */
> -		res = request_mem_region(range.start, range_len(&range), res_name);
> +		res = request_mem_region(range.start, range_len(&range), data->res_name);
>  		if (!res) {
>  			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve region\n",
>  					i, range.start, range.end);
> @@ -82,9 +91,10 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  			 */
>  			if (mapped)
>  				continue;
> -			kfree(res_name);
> -			return -EBUSY;
> +			rc = -EBUSY;
> +			goto err_request_mem;
>  		}
> +		data->res[i] = res;
>  
>  		/*
>  		 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
> @@ -104,18 +114,25 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		if (rc) {
>  			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
>  					i, range.start, range.end);
> -			release_mem_region(range.start, range_len(&range));
> +			release_resource(res);
> +			kfree(res);
> +			data->res[i] = NULL;
>  			if (mapped)
>  				continue;
> -			kfree(res_name);
> -			return rc;
> +			goto err_request_mem;
>  		}
>  		mapped++;
>  	}
>  
> -	dev_set_drvdata(dev, res_name);
> +	dev_set_drvdata(dev, data);
>  
>  	return 0;
> +
> +err_request_mem:
> +	kfree(data->res_name);
> +err_res_name:
> +	kfree(data);
> +	return rc;
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> @@ -123,7 +140,7 @@ static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  {
>  	int i, success = 0;
>  	struct device *dev = &dev_dax->dev;
> -	const char *res_name = dev_get_drvdata(dev);
> +	struct dax_kmem_data *data = dev_get_drvdata(dev);
>  
>  	/*
>  	 * We have one shot for removing memory, if some memory blocks were not
> @@ -142,7 +159,9 @@ static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  		rc = remove_memory(dev_dax->target_node, range.start,
>  				range_len(&range));
>  		if (rc == 0) {
> -			release_mem_region(range.start, range_len(&range));
> +			release_resource(data->res[i]);
> +			kfree(data->res[i]);
> +			data->res[i] = NULL;
>  			success++;
>  			continue;
>  		}
> @@ -153,7 +172,8 @@ static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  	}
>  
>  	if (success >= dev_dax->nr_range) {
> -		kfree(res_name);
> +		kfree(data->res_name);
> +		kfree(data);
>  		dev_set_drvdata(dev, NULL);
>  	}
>  
> 

Looks sane to me

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

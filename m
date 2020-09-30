Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44627EEB0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 18:14:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3515154E1D2D;
	Wed, 30 Sep 2020 09:14:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 08CA0154E1D2C
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1601482468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1ZdFMTh+VxHRozNY6CY6rpIDlXCySIQIP+2aaYHRy+g=;
	b=eLbgCDPP+0zRMVe5mjHPoYQS9d7ofAppHezeXhppHa07vdZQodlwRs8Y3YFg7fPTMyeFXh
	iu1cqf1N5qCCE7ph1Oh4RaGN0BY4vQ07QsHBIexGAYti2SYekIYVj4nGevLjHEkvAyHRBu
	VamniNCUp470gdVyb2zfkWsQIim4av0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-gJyuNpaPPVCSn-B_4-INLg-1; Wed, 30 Sep 2020 12:14:24 -0400
X-MC-Unique: gJyuNpaPPVCSn-B_4-INLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B21010BBED0;
	Wed, 30 Sep 2020 16:14:20 +0000 (UTC)
Received: from [10.36.112.204] (ovpn-112-204.ams2.redhat.com [10.36.112.204])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 757CD5D9D3;
	Wed, 30 Sep 2020 16:14:16 +0000 (UTC)
Subject: Re: [PATCH v5 02/17] device-dax/kmem: introduce dax_kmem_range()
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160106111109.30709.3173462396758431559.stgit@dwillia2-desk3.amr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <2c2bc46e-573c-4e8c-db9b-605559144432@redhat.com>
Date: Wed, 30 Sep 2020 18:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160106111109.30709.3173462396758431559.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: TPKXGVT5YRUS2OGSPBAL5R2L7S4OCRNH
X-Message-ID-Hash: TPKXGVT5YRUS2OGSPBAL5R2L7S4OCRNH
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Brice Goglin <Brice.Goglin@inria.fr>, Jia He <justin.he@arm.com>, Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TPKXGVT5YRUS2OGSPBAL5R2L7S4OCRNH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25.09.20 21:11, Dan Williams wrote:
> Towards removing the mode specific @dax_kmem_res attribute from the
> generic 'struct dev_dax', and preparing for multi-range support, teach
> the driver to calculate the hotplug range from the device range. The
> hotplug range is the trivially calculated memory-block-size aligned
> version of the device range.
> 
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
>  drivers/dax/kmem.c |   40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 5bb133df147d..b0d6a99cf12d 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -19,13 +19,20 @@ static const char *kmem_name;
>  /* Set if any memory will remain added when the driver will be unloaded. */
>  static bool any_hotremove_failed;
>  
> +static struct range dax_kmem_range(struct dev_dax *dev_dax)
> +{
> +	struct range range;
> +
> +	/* memory-block align the hotplug range */
> +	range.start = ALIGN(dev_dax->range.start, memory_block_size_bytes());
> +	range.end = ALIGN_DOWN(dev_dax->range.end + 1, memory_block_size_bytes()) - 1;
> +	return range;
> +}
> +
>  int dev_dax_kmem_probe(struct device *dev)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
> -	struct range *range = &dev_dax->range;
> -	resource_size_t kmem_start;
> -	resource_size_t kmem_size;
> -	resource_size_t kmem_end;
> +	struct range range = dax_kmem_range(dev_dax);
>  	struct resource *new_res;
>  	const char *new_res_name;
>  	int numa_node;
> @@ -44,25 +51,14 @@ int dev_dax_kmem_probe(struct device *dev)
>  		return -EINVAL;
>  	}
>  
> -	/* Hotplug starting at the beginning of the next block: */
> -	kmem_start = ALIGN(range->start, memory_block_size_bytes());
> -
> -	kmem_size = range_len(range);
> -	/* Adjust the size down to compensate for moving up kmem_start: */
> -	kmem_size -= kmem_start - range->start;
> -	/* Align the size down to cover only complete blocks: */
> -	kmem_size &= ~(memory_block_size_bytes() - 1);
> -	kmem_end = kmem_start + kmem_size;
> -
>  	new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
>  	if (!new_res_name)
>  		return -ENOMEM;
>  
>  	/* Region is permanently reserved if hotremove fails. */
> -	new_res = request_mem_region(kmem_start, kmem_size, new_res_name);
> +	new_res = request_mem_region(range.start, range_len(&range), new_res_name);
>  	if (!new_res) {
> -		dev_warn(dev, "could not reserve region [%pa-%pa]\n",
> -			 &kmem_start, &kmem_end);
> +		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n", range.start, range.end);
>  		kfree(new_res_name);
>  		return -EBUSY;
>  	}
> @@ -96,9 +92,8 @@ int dev_dax_kmem_probe(struct device *dev)
>  static int dev_dax_kmem_remove(struct device *dev)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
> +	struct range range = dax_kmem_range(dev_dax);
>  	struct resource *res = dev_dax->dax_kmem_res;
> -	resource_size_t kmem_start = res->start;
> -	resource_size_t kmem_size = resource_size(res);
>  	const char *res_name = res->name;
>  	int rc;
>  
> @@ -108,12 +103,11 @@ static int dev_dax_kmem_remove(struct device *dev)
>  	 * there is no way to hotremove this memory until reboot because device
>  	 * unbind will succeed even if we return failure.
>  	 */
> -	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
> +	rc = remove_memory(dev_dax->target_node, range.start, range_len(&range));
>  	if (rc) {
>  		any_hotremove_failed = true;
> -		dev_err(dev,
> -			"DAX region %pR cannot be hotremoved until the next reboot\n",
> -			res);
> +		dev_err(dev, "%#llx-%#llx cannot be hotremoved until the next reboot\n",
> +				range.start, range.end);
>  		return rc;
>  	}
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

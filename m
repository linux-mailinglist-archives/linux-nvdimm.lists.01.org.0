Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD2616982B
	for <lists+linux-nvdimm@lfdr.de>; Sun, 23 Feb 2020 15:56:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62AE210FC338A;
	Sun, 23 Feb 2020 06:57:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 434051003E9AA
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 06:57:30 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 06:56:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400";
   d="scan'208";a="255331825"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2020 06:56:36 -0800
Date: Sun, 23 Feb 2020 06:56:36 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Alistair Delva <adelva@google.com>
Subject: Re: [PATCH 1/2] libnvdimm/of_pmem: handle memory-region in DT
Message-ID: <20200223145635.GB29607@iweiny-DESK2.sc.intel.com>
References: <20200222183010.197844-1-adelva@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200222183010.197844-1-adelva@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: YX4UI6UNN4BMUV665CQRWXRAXJNN527J
X-Message-ID-Hash: YX4UI6UNN4BMUV665CQRWXRAXJNN527J
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YX4UI6UNN4BMUV665CQRWXRAXJNN527J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Feb 22, 2020 at 10:30:09AM -0800, Alistair Delva wrote:
> From: Kenny Root <kroot@google.com>
> 
> Add support for parsing the 'memory-region' DT property in addition to
> the 'reg' DT property. This enables use cases where the pmem region is
> not in I/O address space or dedicated memory (e.g. a bootloader
> carveout).
> 
> Signed-off-by: Kenny Root <kroot@google.com>
> Signed-off-by: Alistair Delva <adelva@google.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> Cc: kernel-team@android.com
> ---
>  drivers/nvdimm/of_pmem.c | 75 ++++++++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 8224d1431ea9..a68e44fb0041 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -14,13 +14,47 @@ struct of_pmem_private {
>  	struct nvdimm_bus *bus;
>  };
>  
> +static void of_pmem_register_region(struct platform_device *pdev,
> +				    struct nvdimm_bus *bus,
> +				    struct device_node *np,
> +				    struct resource *res, bool is_volatile)

FWIW it would be easier to review if this was splut into a patch which created
the helper of_pmem_register_region() without the new logic.  Then added the new
logic here.

> +{
> +	struct nd_region_desc ndr_desc;
> +	struct nd_region *region;
> +
> +	/*
> +	 * NB: libnvdimm copies the data from ndr_desc into it's own
> +	 * structures so passing a stack pointer is fine.
> +	 */
> +	memset(&ndr_desc, 0, sizeof(ndr_desc));
> +	ndr_desc.numa_node = dev_to_node(&pdev->dev);
> +	ndr_desc.target_node = ndr_desc.numa_node;
> +	ndr_desc.res = res;
> +	ndr_desc.of_node = np;
> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> +
> +	if (is_volatile)
> +		region = nvdimm_volatile_region_create(bus, &ndr_desc);
> +	else
> +		region = nvdimm_pmem_region_create(bus, &ndr_desc);
> +
> +	if (!region)
> +		dev_warn(&pdev->dev,
> +			 "Unable to register region %pR from %pOF\n",
> +			 ndr_desc.res, np);
> +	else
> +		dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> +			ndr_desc.res, np);
> +}
> +
>  static int of_pmem_region_probe(struct platform_device *pdev)
>  {
>  	struct of_pmem_private *priv;
> -	struct device_node *np;
> +	struct device_node *mrp, *np;
>  	struct nvdimm_bus *bus;
> +	struct resource res;
>  	bool is_volatile;
> -	int i;
> +	int i, ret;
>  
>  	np = dev_of_node(&pdev->dev);
>  	if (!np)
> @@ -46,31 +80,22 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  			is_volatile ? "volatile" : "non-volatile",  np);
>  
>  	for (i = 0; i < pdev->num_resources; i++) {
> -		struct nd_region_desc ndr_desc;
> -		struct nd_region *region;
> -
> -		/*
> -		 * NB: libnvdimm copies the data from ndr_desc into it's own
> -		 * structures so passing a stack pointer is fine.
> -		 */
> -		memset(&ndr_desc, 0, sizeof(ndr_desc));
> -		ndr_desc.numa_node = dev_to_node(&pdev->dev);
> -		ndr_desc.target_node = ndr_desc.numa_node;
> -		ndr_desc.res = &pdev->resource[i];
> -		ndr_desc.of_node = np;
> -		set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> -
> -		if (is_volatile)
> -			region = nvdimm_volatile_region_create(bus, &ndr_desc);
> -		else
> -			region = nvdimm_pmem_region_create(bus, &ndr_desc);
> +		of_pmem_register_region(pdev, bus, np, &pdev->resource[i],
> +					is_volatile);
> +	}
>  
> -		if (!region)
> -			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
> -					ndr_desc.res, np);
> +	i = 0;
> +	while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {
> +		ret = of_address_to_resource(mr_np, 0, &res);
> +		if (ret)
> +			dev_warn(
> +				&pdev->dev,
> +				"Unable to acquire memory-region from %pOF: %d\n",
> +				mr_np, ret);
>  		else
> -			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> -					ndr_desc.res, np);
> +			of_pmem_register_region(pdev, bus, np, &res,
> +						is_volatile);
> +		of_node_put(mr_np);

Why of_node_put()?

Ira
>  	}
>  
>  	return 0;
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

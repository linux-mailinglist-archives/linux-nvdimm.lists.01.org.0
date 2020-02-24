Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E3B16B487
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 23:49:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5630610FC3599;
	Mon, 24 Feb 2020 14:50:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 89DD610FC33F8
	for <linux-nvdimm@lists.01.org>; Mon, 24 Feb 2020 14:50:13 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 14:49:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400";
   d="scan'208";a="231269244"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2020 14:49:20 -0800
Date: Mon, 24 Feb 2020 14:49:20 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Alistair Delva <adelva@google.com>
Subject: Re: [PATCH v2 1/3] libnvdimm/of_pmem: factor out region registration
Message-ID: <20200224224920.GA8867@iweiny-DESK2.sc.intel.com>
References: <20200224020815.139570-1-adelva@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224020815.139570-1-adelva@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 5LILEOG5Q7JDE6EYM2REYEJP34DBX5IE
X-Message-ID-Hash: 5LILEOG5Q7JDE6EYM2REYEJP34DBX5IE
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5LILEOG5Q7JDE6EYM2REYEJP34DBX5IE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Feb 23, 2020 at 06:08:13PM -0800, Alistair Delva wrote:
> From: Kenny Root <kroot@google.com>
> 
> From: Kenny Root <kroot@google.com>
> 
> Factor out region registration for 'reg' node. A follow-up change will
> use of_pmem_register_region() to handle memory-region nodes too.

Thanks!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Signed-off-by: Kenny Root <kroot@google.com>
> Signed-off-by: Alistair Delva <adelva@google.com>
> Reviewed-by: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> Cc: kernel-team@android.com
> ---
>  drivers/nvdimm/of_pmem.c | 60 +++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 8224d1431ea9..fdf54494e8c9 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -14,6 +14,39 @@ struct of_pmem_private {
>  	struct nvdimm_bus *bus;
>  };
>  
> +static void of_pmem_register_region(struct platform_device *pdev,
> +				    struct nvdimm_bus *bus,
> +				    struct device_node *np,
> +				    struct resource *res, bool is_volatile)
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
> @@ -46,31 +79,8 @@ static int of_pmem_region_probe(struct platform_device *pdev)
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
> -
> -		if (!region)
> -			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
> -					ndr_desc.res, np);
> -		else
> -			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> -					ndr_desc.res, np);
> +		of_pmem_register_region(pdev, bus, np, &pdev->resource[i],
> +					is_volatile);
>  	}
>  
>  	return 0;
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

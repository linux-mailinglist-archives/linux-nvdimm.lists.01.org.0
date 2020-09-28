Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699827B318
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 19:25:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 704C0151E296A;
	Mon, 28 Sep 2020 10:25:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8732E151D3481
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 10:25:05 -0700 (PDT)
IronPort-SDR: enxmyx0pqQCBo71JbphhWDL8BdvTCbBSjkS/E4gyojnwA1THVta0ASXyjE/ypuaoViuVN9uLq8
 TQM1YGLIKKWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="246773283"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400";
   d="scan'208";a="246773283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:25:02 -0700
IronPort-SDR: 4WIJbj5K0sIe+bmBUpyIDeZm5z/xcEN5g6l7fpRJYcuQZ78GihJee+w7OCJd4oDLuUv6jARImD
 ocGBp05s50bg==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400";
   d="scan'208";a="349916054"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:25:02 -0700
Date: Mon, 28 Sep 2020 10:25:02 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH] nvdimm: Use kobj_to_dev() API
Message-ID: <20200928172502.GC458519@iweiny-DESK2.sc.intel.com>
References: <1601103260-10249-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1601103260-10249-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: VNP35LNNIRMF2C52MFR3S6DTYOKAXHHN
X-Message-ID-Hash: VNP35LNNIRMF2C52MFR3S6DTYOKAXHHN
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VNP35LNNIRMF2C52MFR3S6DTYOKAXHHN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Sep 26, 2020 at 02:54:17PM +0800, Wang Qing wrote:
> Use kobj_to_dev() instead of container_of().
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/namespace_devs.c | 2 +-
>  drivers/nvdimm/region_devs.c    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index 6da67f4..1d11ca7
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1623,7 +1623,7 @@ static struct attribute *nd_namespace_attributes[] = {
>  static umode_t namespace_visible(struct kobject *kobj,
>  		struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  
>  	if (a == &dev_attr_resource.attr && is_namespace_blk(dev))
>  		return 0;
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ef23119..92adfaf
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -644,7 +644,7 @@ static struct attribute *nd_region_attributes[] = {
>  
>  static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, typeof(*dev), kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nd_region *nd_region = to_nd_region(dev);
>  	struct nd_interleave_set *nd_set = nd_region->nd_set;
>  	int type = nd_region_to_nstype(nd_region);
> @@ -759,7 +759,7 @@ REGION_MAPPING(31);
>  
>  static umode_t mapping_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nd_region *nd_region = to_nd_region(dev);
>  
>  	if (n < nd_region->ndr_mappings)
> -- 
> 2.7.4
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1957DBE4B4
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 20:36:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 100A4202F8BAF;
	Wed, 25 Sep 2019 11:38:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B959B202F73BC
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 11:38:50 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 11:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,549,1559545200"; d="scan'208";a="340492191"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga004.jf.intel.com with ESMTP; 25 Sep 2019 11:36:37 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Sep 2019 11:36:36 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.68]) by
 FMSMSX119.amr.corp.intel.com ([169.254.14.227]) with mapi id 14.03.0439.000;
 Wed, 25 Sep 2019 11:36:35 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Weiny, Ira"
 <ira.weiny@intel.com>
Subject: Re: [PATCH] bnvdimm/namsepace: Don't set claim_class on error
Thread-Topic: [PATCH] bnvdimm/namsepace: Don't set claim_class on error
Thread-Index: AQHVc8yfjpwRrvESakuTYdbqlYtrt6c9Lg8A
Date: Wed, 25 Sep 2019 18:36:35 +0000
Message-ID: <ff7ff4f5b4289d189a7c347591a5c35876ea804f.camel@intel.com>
References: <20190925181056.11097-1-ira.weiny@intel.com>
In-Reply-To: <20190925181056.11097-1-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <CD0C650088AFED4EBC5C98E45C47D4B3@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-09-25 at 11:10 -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Don't leave claim_class set to an invalid value if an error occurs in
> btt_claim_class().
> 
> While we are here change the return type of __holder_class_store() to be
> clear about the values it is returning.
> 
> This was found via code inspection.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/nvdimm/namespace_devs.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

One minor nit below, but otherwise it looks good to me:
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index 5b22cecefc99..a020c166e1e7 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1510,16 +1510,19 @@ static ssize_t holder_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(holder);
>  
> -static ssize_t __holder_class_store(struct device *dev, const char *buf)
> +static int __holder_class_store(struct device *dev, const char *buf)
>  {
>  	struct nd_namespace_common *ndns = to_ndns(dev);
>  
>  	if (dev->driver || ndns->claim)
>  		return -EBUSY;
>  
> -	if (sysfs_streq(buf, "btt"))
> -		ndns->claim_class = btt_claim_class(dev);
> -	else if (sysfs_streq(buf, "pfn"))
> +	if (sysfs_streq(buf, "btt")) {
> +		int rc = btt_claim_class(dev);

Need a blank line here separating variable declarations and code.

> +		if (rc < NVDIMM_CCLASS_NONE)
> +			return rc;
> +		ndns->claim_class = rc;
> +	} else if (sysfs_streq(buf, "pfn"))
>  		ndns->claim_class = NVDIMM_CCLASS_PFN;
>  	else if (sysfs_streq(buf, "dax"))
>  		ndns->claim_class = NVDIMM_CCLASS_DAX;
> @@ -1528,10 +1531,6 @@ static ssize_t __holder_class_store(struct device *dev, const char *buf)
>  	else
>  		return -EINVAL;
>  
> -	/* btt_claim_class() could've returned an error */
> -	if ((int)ndns->claim_class < 0)
> -		return ndns->claim_class;
> -
>  	return 0;
>  }
>  
> @@ -1539,7 +1538,7 @@ static ssize_t holder_class_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
>  {
>  	struct nd_region *nd_region = to_nd_region(dev->parent);
> -	ssize_t rc;
> +	int rc;
>  
>  	nd_device_lock(dev);
>  	nvdimm_bus_lock(dev);
> @@ -1547,7 +1546,7 @@ static ssize_t holder_class_store(struct device *dev,
>  	rc = __holder_class_store(dev, buf);
>  	if (rc >= 0)
>  		rc = nd_namespace_label_update(nd_region, dev);
> -	dev_dbg(dev, "%s(%zd)\n", rc < 0 ? "fail " : "", rc);
> +	dev_dbg(dev, "%s(%d)\n", rc < 0 ? "fail " : "", rc);
>  	nvdimm_bus_unlock(dev);
>  	nd_device_unlock(dev);
>  

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

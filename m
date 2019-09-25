Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F143BBE355
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 19:24:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C01DE202F8BA8;
	Wed, 25 Sep 2019 10:26:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4A453202E2917
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 10:26:24 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 10:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; d="scan'208";a="188838288"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga008.fm.intel.com with ESMTP; 25 Sep 2019 10:24:10 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.68]) by
 FMSMSX103.amr.corp.intel.com ([169.254.2.82]) with mapi id 14.03.0439.000;
 Wed, 25 Sep 2019 10:24:09 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "dan.carpenter@oracle.com"
 <dan.carpenter@oracle.com>
Subject: Re: [PATCH] libnvdimm/namespace: Fix a signedness bug in
 __holder_class_store()
Thread-Topic: [PATCH] libnvdimm/namespace: Fix a signedness bug in
 __holder_class_store()
Thread-Index: AQHVc5B5rM1ZYUSIHUSOStf/1XoAG6c9GkyA
Date: Wed, 25 Sep 2019 17:24:09 +0000
Message-ID: <71808ca30f4e367931bf58fa3e1798371c2a5044.camel@intel.com>
References: <20190925110008.GK3264@mwanda>
In-Reply-To: <20190925110008.GK3264@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <CCF587D42594D44D9B798B21BC52A6BD@intel.com>
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

On Wed, 2019-09-25 at 14:00 +0300, Dan Carpenter wrote:
> The "ndns->claim_class" variable is an enum but in this case GCC will
> treat it as an unsigned int so the error handling is never triggered.
> 
> Fixes: 14e494542636 ("libnvdimm, btt: BTT updates for UEFI 2.7 format")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/nvdimm/namespace_devs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index cca0a3ba1d2c..669985527716 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1529,7 +1529,7 @@ static ssize_t __holder_class_store(struct device *dev, const char *buf)
>  		return -EINVAL;
>  
>  	/* btt_claim_class() could've returned an error */
> -	if (ndns->claim_class < 0)
> +	if ((int)ndns->claim_class < 0)
>  		return ndns->claim_class;
>  
>  	return 0;

Looks straightforward, and a good catch.
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

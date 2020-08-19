Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF6724A5B3
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 20:14:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 44667134575E4;
	Wed, 19 Aug 2020 11:14:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 79307134575E3
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 11:13:59 -0700 (PDT)
IronPort-SDR: xygtFzJY6Y8EiIBDpx2+s3RhlTWQurGnel1iGLI7aKetlPj0UAc031aXTEmibPpZGTLu0u9L9u
 CpgK2m6zfMNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="135243693"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600";
   d="scan'208";a="135243693"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 11:13:58 -0700
IronPort-SDR: 3gzx1NcgRAUmsITkgLSlB1EGdnhF2dF2pEqyEcubPNvfoAjbD9EkYecFv0r6uHP5PuwAhjRKjT
 E8Ov1bSULQiA==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600";
   d="scan'208";a="497330358"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 11:13:58 -0700
Date: Wed, 19 Aug 2020 11:13:58 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH] drivers/dax: Use kobj_to_dev() instead
Message-ID: <20200819181357.GE3142014@iweiny-DESK2.sc.intel.com>
References: <1597289224-19897-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1597289224-19897-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: XA6M3ANKLFECHMKKUM3ZW6SBKQ7W4KET
X-Message-ID-Hash: XA6M3ANKLFECHMKKUM3ZW6SBKQ7W4KET
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XA6M3ANKLFECHMKKUM3ZW6SBKQ7W4KET/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 13, 2020 at 11:27:02AM +0800, Wang Qing wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

LTGM

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/dax/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index df238c8..24625d2
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -331,7 +331,7 @@ static DEVICE_ATTR_RO(numa_node);
>  
>  static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  
>  	if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)
> -- 
> 2.7.4
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB81E9D65
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jun 2020 07:45:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 335ED100DEFF8;
	Sun, 31 May 2020 22:40:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5A7FA100E2AF2
	for <linux-nvdimm@lists.01.org>; Sun, 31 May 2020 22:40:34 -0700 (PDT)
IronPort-SDR: LbHapPVxESJFc9ANJTcMWjPYwfTm3xdZmWmfMMIuWi/dFHXhaNkUQqkCQt3ZKzaY2qnHZK3/S7
 GsLWsY89SbIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:45:16 -0700
IronPort-SDR: JxZ75MqOuUf8l5cClPSYYtbPsPm4Ulj/NgfMiJbogtdgBvy1GiF1e89Udz1NeecgJz8tvnjWVy
 T/wcQzU3zerg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400";
   d="scan'208";a="268206982"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 31 May 2020 22:45:15 -0700
Date: Sun, 31 May 2020 22:45:15 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Shuai He <hexiaoshuaishuai@gmail.com>
Subject: Re: [PATCH] drivers/dax/bus: Use kobj_to_dev() API
Message-ID: <20200601054515.GB1505637@iweiny-DESK2.sc.intel.com>
References: <1590723777-8718-1-git-send-email-hexiaoshuaishuai@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1590723777-8718-1-git-send-email-hexiaoshuaishuai@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: EGLK2IXNALDKV4LVASNDUBTSVI6Y5D4O
X-Message-ID-Hash: EGLK2IXNALDKV4LVASNDUBTSVI6Y5D4O
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EGLK2IXNALDKV4LVASNDUBTSVI6Y5D4O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 29, 2020 at 11:42:57AM +0800, Shuai He wrote:
> Use kobj_to_dev() API instead of container_of().
> 
> Signed-off-by: Shuai He <hexiaoshuaishuai@gmail.com>

Seems reasonable:
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/dax/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index df238c8..24625d2 100644
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

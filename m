Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F13647D4
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 18:04:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6601E100EC1DA;
	Mon, 19 Apr 2021 09:04:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE197100ED4BB
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 09:04:14 -0700 (PDT)
IronPort-SDR: gnaSSqGzpXUx+Y/Okouhj+uos023Mk3Vde92SKBSFejmYw8ADzG3Ia37VYnU9kzDB1CRhNL8Yd
 ZsMVEfUdrpsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="195382104"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400";
   d="scan'208";a="195382104"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 09:04:12 -0700
IronPort-SDR: t5DAkXmlvwniORyDpzVffceigCGlOZ133P9EB9TGAXhCmbq9kozvQc4vsSZzXrCgvH9xXACkPm
 WTj4fin83e9Q==
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400";
   d="scan'208";a="420062661"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 09:04:11 -0700
Date: Mon, 19 Apr 2021 09:04:11 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Wan Jiabing <wanjiabing@vivo.com>
Subject: Re: [PATCH] libnvdimm.h: Remove duplicate struct declaration
Message-ID: <20210419160411.GG1904484@iweiny-DESK2.sc.intel.com>
References: <20210419112725.42145-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210419112725.42145-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: TS4V6MYOUUYY5U32RE5AFNGP5HEJGTHY
X-Message-ID-Hash: TS4V6MYOUUYY5U32RE5AFNGP5HEJGTHY
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, kael_w@yeah.net
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TS4V6MYOUUYY5U32RE5AFNGP5HEJGTHY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 19, 2021 at 07:27:25PM +0800, Wan Jiabing wrote:
> struct device is declared at 133rd line.
> The declaration here is unnecessary. Remove it.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/linux/libnvdimm.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 01f251b6e36c..89b69e645ac7 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -141,7 +141,6 @@ static inline void __iomem *devm_nvdimm_ioremap(struct device *dev,
>  
>  struct nvdimm_bus;
>  struct module;
> -struct device;
>  struct nd_blk_region;

What is the coding style preference for pre-declarations like this?  Should
they be placed at the top of the file?

The patch is reasonable but if the intent is to declare right before use for
clarity, both devm_nvdimm_memremap() and nd_blk_region_desc() use struct
device.  So perhaps this duplicate is on purpose?

Ira

>  struct nd_blk_region_desc {
>  	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
> -- 
> 2.25.1
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

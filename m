Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9E201D33
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Jun 2020 23:36:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A684E10FC729F;
	Fri, 19 Jun 2020 14:36:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1353210FC6C8A
	for <linux-nvdimm@lists.01.org>; Fri, 19 Jun 2020 14:36:25 -0700 (PDT)
IronPort-SDR: QVOL/ocaOqybrI6Nd0TKqBzWURcXzgeoPGnoYzkoqqmYjnQ4jw/2OrqP82LG7qlQ1XD7XeSbfG
 lKHLbDXX/zZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="204580382"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800";
   d="scan'208";a="204580382"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 14:36:25 -0700
IronPort-SDR: 4K/HxW4uIuQ0D6dlKG6XYG191cP3Z0mCRfpBOrnwzL11vK8zKp2IHOZo9/kIQcRPP7PbfzSJej
 U0vAS1rcNaNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800";
   d="scan'208";a="477774556"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jun 2020 14:36:24 -0700
Date: Fri, 19 Jun 2020 14:36:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH][next] nvdimm/region: Use struct_size() in kzalloc()
Message-ID: <20200619213624.GA3910394@iweiny-DESK2.sc.intel.com>
References: <20200619172112.GA31702@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619172112.GA31702@embeddedor>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: DWL6FQMGBDHV7FO4CORTT3V5CMKJYS6X
X-Message-ID-Hash: DWL6FQMGBDHV7FO4CORTT3V5CMKJYS6X
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DWL6FQMGBDHV7FO4CORTT3V5CMKJYS6X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 19, 2020 at 12:21:12PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/region_devs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 4502f9c4708d..8365fb1a9114 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1063,8 +1063,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
>  		struct nd_blk_region *ndbr;
>  
>  		ndbr_desc = to_blk_region_desc(ndr_desc);
> -		ndbr = kzalloc(sizeof(*ndbr) + sizeof(struct nd_mapping)
> -				* ndr_desc->num_mappings,
> +		ndbr = kzalloc(struct_size(ndbr, nd_region.mapping, ndr_desc->num_mappings),
>  				GFP_KERNEL);
>  		if (ndbr) {
>  			nd_region = &ndbr->nd_region;
> -- 
> 2.27.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

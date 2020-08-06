Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 811C423E21D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 21:26:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9AC881293B91B;
	Thu,  6 Aug 2020 12:26:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C12CD1293B8E4
	for <linux-nvdimm@lists.01.org>; Thu,  6 Aug 2020 12:25:58 -0700 (PDT)
IronPort-SDR: j5SNC9nAb1XrVKQjlaJBNK1C5Jnuz28oy8QBZsSrNBp2kO3KzOqj/3P4ftdqra3f36Y3vXuJa+
 DW2K+RgZMSNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="217247932"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800";
   d="scan'208";a="217247932"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:25:58 -0700
IronPort-SDR: 1J++mHly7JMLbXnbQvdotUfwoonPHaDEiQz1Yj+f2h4WOUcVed8vm6wQm75BDPH8yXRlM/ioHZ
 8xLrTr1odK2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800";
   d="scan'208";a="397360030"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2020 12:25:58 -0700
Date: Thu, 6 Aug 2020 12:25:58 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v2 1/3] libnvdimm/security: fix a typo
Message-ID: <20200806192557.GK1573827@iweiny-DESK2.sc.intel.com>
References: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: WF3O7UDNOSGT4ZS7DTBIZXAKZNRRCZB6
X-Message-ID-Hash: WF3O7UDNOSGT4ZS7DTBIZXAKZNRRCZB6
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WF3O7UDNOSGT4ZS7DTBIZXAKZNRRCZB6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 03, 2020 at 04:41:37PM -0600, Jane Chu wrote:
> commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
> introduced a typo, causing a 'nvdimm->sec.flags' update being overwritten
> by the subsequent update meant for 'nvdimm->sec.ext_flags'.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 4cef69b..8f3971c 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -457,7 +457,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>  	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
>  	put_device(&nvdimm->dev);
>  	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
> -	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
> +	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
>  }
>  
>  void nvdimm_security_overwrite_query(struct work_struct *work)
> -- 
> 1.8.3.1
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

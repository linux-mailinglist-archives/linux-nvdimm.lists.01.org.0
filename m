Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAEA1A3756
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Apr 2020 17:41:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83D1210113FD9;
	Thu,  9 Apr 2020 08:42:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F339110113FD8
	for <linux-nvdimm@lists.01.org>; Thu,  9 Apr 2020 08:42:14 -0700 (PDT)
IronPort-SDR: T4bxnRuvgpQQO/n3t2f4oodJFH7mnEqAkWGSwVP3TGJpPdB1VD4KVt+ItTtjfVaFM14iRWG+fg
 h9qWu1izoLjQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 08:41:25 -0700
IronPort-SDR: iNogsqV2AsJTGmDcYQ45c5IPeWZjcrV8PHKh6czAO77rTbQoPqKf85OQh7HVcrM8XWz5p4jEZf
 BlaQiOkWGc3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200";
   d="scan'208";a="257831521"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga008.jf.intel.com with ESMTP; 09 Apr 2020 08:41:25 -0700
Date: Thu, 9 Apr 2020 08:41:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH] libnvdimm/security: make
 __nvdimm_security_overwrite_query() static
Message-ID: <20200409154124.GA801897@iweiny-DESK2.sc.intel.com>
References: <20200409084857.44169-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200409084857.44169-1-yanaijie@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: MG5UM7JNGFVMJOXZNSIXMBGN6VMGS44M
X-Message-ID-Hash: MG5UM7JNGFVMJOXZNSIXMBGN6VMGS44M
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MG5UM7JNGFVMJOXZNSIXMBGN6VMGS44M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 09, 2020 at 04:48:57PM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> drivers/nvdimm/security.c:416:6: warning: symbol
> '__nvdimm_security_overwrite_query' was not declared. Should it be
> static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 89b85970912d..11fb5ada70ad 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -413,7 +413,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
>  	return rc;
>  }
>  
> -void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
> +static void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>  {
>  	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(&nvdimm->dev);
>  	int rc;
> -- 
> 2.17.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

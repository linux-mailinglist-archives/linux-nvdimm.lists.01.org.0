Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E1823E223
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 21:26:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 12BAA12BB676F;
	Thu,  6 Aug 2020 12:26:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BDAF41293B91B
	for <linux-nvdimm@lists.01.org>; Thu,  6 Aug 2020 12:26:38 -0700 (PDT)
IronPort-SDR: qygweJjSKrx9gk14oBe/EhKBqnNguHcVdfbxPwJCVOYIKU1ysHcdBx4fFfPlzD6U24+6+z0wZM
 MLH+yUn1562g==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="132990436"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800";
   d="scan'208";a="132990436"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:26:38 -0700
IronPort-SDR: dBZabNtMYg4WmnmsghcQq2ljNwJqcGP6+gd4BZC1t7IEktnfXuBISk9F9V3Q8B9djC+MIDE0UN
 7J9b8wRmI2aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800";
   d="scan'208";a="289379037"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2020 12:26:37 -0700
Date: Thu, 6 Aug 2020 12:26:37 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v2 3/3] libnvdimm/security: ensure sysfs poll thread woke
 up and fetch updated attr
Message-ID: <20200806192637.GM1573827@iweiny-DESK2.sc.intel.com>
References: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
 <1596494499-9852-3-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1596494499-9852-3-git-send-email-jane.chu@oracle.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: AHRKGREQ3BRG26TIQ6FXXZHQ2QO3V3X7
X-Message-ID-Hash: AHRKGREQ3BRG26TIQ6FXXZHQ2QO3V3X7
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AHRKGREQ3BRG26TIQ6FXXZHQ2QO3V3X7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 03, 2020 at 04:41:39PM -0600, Jane Chu wrote:
> commit 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
> adds a sysfs_notify_dirent() to wake up userspace poll thread when the "overwrite"
> operation has completed. But the notification is issued before the internal
> dimm security state and flags have been updated, so the userspace poll thread
> wakes up and fetches the not-yet-updated attr and falls back to sleep, forever.
> But if user from another terminal issue "ndctl wait-overwrite nmemX" again,
> the command returns instantly.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/security.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 8f3971c..4b80150 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -450,14 +450,19 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>  	else
>  		dev_dbg(&nvdimm->dev, "overwrite completed\n");
>  
> -	if (nvdimm->sec.overwrite_state)
> -		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
> +	/*
> +	 * Mark the overwrite work done and update dimm security flags,
> +	 * then send a sysfs event notification to wake up userspace
> +	 * poll threads to picked up the changed state.
> +	 */
>  	nvdimm->sec.overwrite_tmo = 0;
>  	clear_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags);
>  	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
> -	put_device(&nvdimm->dev);
>  	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>  	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
> +	if (nvdimm->sec.overwrite_state)
> +		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
> +	put_device(&nvdimm->dev);
>  }
>  
>  void nvdimm_security_overwrite_query(struct work_struct *work)
> -- 
> 1.8.3.1
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

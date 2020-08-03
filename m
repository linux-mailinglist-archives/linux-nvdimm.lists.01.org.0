Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3DF23AE53
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 22:42:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 329C9129C0252;
	Mon,  3 Aug 2020 13:42:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dave.jiang@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8407C129C0247
	for <linux-nvdimm@lists.01.org>; Mon,  3 Aug 2020 13:42:09 -0700 (PDT)
IronPort-SDR: NMMAk+w3GmuAExHyl9D/4WawezBvznRIs6ymZ0ifO4DdsDsfi4n+Uhipx4217O5vuv/MATvSZ5
 11yUJYB6UmTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="213739782"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800";
   d="scan'208";a="213739782"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 13:42:09 -0700
IronPort-SDR: G8qehCHuJl7G+oYeLcNmtNncs+SV1quOrUt0k6EZCvNZVKFommktmxwqbgieIgWw+BfsL8TLcb
 7N/nz6Urovhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800";
   d="scan'208";a="314944197"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.255.79.119]) ([10.255.79.119])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2020 13:42:08 -0700
Subject: Re: [PATCH 2/2] libnvdimm/security: ensure sysfs poll thread woke up
 and fetch updated attr
To: Jane Chu <jane.chu@oracle.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
 <1595606959-8516-2-git-send-email-jane.chu@oracle.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <b9957db2-c130-f2ae-14a1-e711a98c7c69@intel.com>
Date: Mon, 3 Aug 2020 13:42:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595606959-8516-2-git-send-email-jane.chu@oracle.com>
Content-Language: en-US
Message-ID-Hash: GEGEBUHQMSBOYDR7DJHOMLCX3OEWXZDT
X-Message-ID-Hash: GEGEBUHQMSBOYDR7DJHOMLCX3OEWXZDT
X-MailFrom: dave.jiang@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GEGEBUHQMSBOYDR7DJHOMLCX3OEWXZDT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On 7/24/2020 9:09 AM, Jane Chu wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/nvdimm/security.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 8f3971c..4b80150 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -450,14 +450,19 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>   	else
>   		dev_dbg(&nvdimm->dev, "overwrite completed\n");
>   
> -	if (nvdimm->sec.overwrite_state)
> -		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
> +	/*
> +	 * Mark the overwrite work done and update dimm security flags,
> +	 * then send a sysfs event notification to wake up userspace
> +	 * poll threads to picked up the changed state.
> +	 */
>   	nvdimm->sec.overwrite_tmo = 0;
>   	clear_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags);
>   	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
> -	put_device(&nvdimm->dev);
>   	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>   	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
> +	if (nvdimm->sec.overwrite_state)
> +		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
> +	put_device(&nvdimm->dev);
>   }
>   
>   void nvdimm_security_overwrite_query(struct work_struct *work)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

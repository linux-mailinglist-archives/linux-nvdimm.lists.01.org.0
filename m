Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E2E23AE50
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 22:41:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0DBDE129C0252;
	Mon,  3 Aug 2020 13:41:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dave.jiang@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 82D6B129C0247
	for <linux-nvdimm@lists.01.org>; Mon,  3 Aug 2020 13:41:23 -0700 (PDT)
IronPort-SDR: MN77SykGkmH1zdUuE2DxUA3fACEjPSYYq+jd9jcDYdpz3pRrSbwyGMVvgB9EU7QtvCguFbGuLX
 plzqVLgDevVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="170292622"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800";
   d="scan'208";a="170292622"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 13:41:22 -0700
IronPort-SDR: iFi7RNfxqEjT9sKJPJCjrNKn/WYf8bCytJNouHIrjN7xU8DcScew7N9F1vbxd4EHxa6/UHGOid
 ptI+di/H7GBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800";
   d="scan'208";a="314943442"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.255.79.119]) ([10.255.79.119])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2020 13:41:22 -0700
Subject: Re: [PATCH 1/2] libnvdimm/security: 'security' attr never show
 'overwrite' state
To: Jane Chu <jane.chu@oracle.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <cb8c1944-f72c-ecfa-bd3d-276f504542e1@intel.com>
Date: Mon, 3 Aug 2020 13:41:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
Content-Language: en-US
Message-ID-Hash: O37MTSFQG6D3EA66IBVSPQ24EPEIHRZI
X-Message-ID-Hash: O37MTSFQG6D3EA66IBVSPQ24EPEIHRZI
X-MailFrom: dave.jiang@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O37MTSFQG6D3EA66IBVSPQ24EPEIHRZI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On 7/24/2020 9:09 AM, Jane Chu wrote:
> Since
> commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute"),
> when issue
>   # ndctl sanitize-dimm nmem0 --overwrite
> then immediately check the 'security' attribute,
>   # cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/nmem0/security
>   unlocked
> Actually the attribute stays 'unlocked' through out the entire overwrite
> operation, never changed.  That's because 'nvdimm->sec.flags' is a bitmap
> that has both bits set indicating 'overwrite' and 'unlocked'.
> But security_show() checks the mutually exclusive bits before it checks
> the 'overwrite' bit at last. The order should be reversed.
> 
> The commit also has a typo: in one occasion, 'nvdimm->sec.ext_state'
> assignment is replaced with 'nvdimm->sec.flags' assignment for
> the NVDIMM_MASTER type.

May be best to split this fix to a different patch? Just thinking git bisect 
later on to track issues. Otherwise Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>   drivers/nvdimm/dimm_devs.c | 4 ++--
>   drivers/nvdimm/security.c  | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index b7b77e8..5d72026 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -363,14 +363,14 @@ __weak ssize_t security_show(struct device *dev,
>   {
>   	struct nvdimm *nvdimm = to_nvdimm(dev);
>   
> +	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
> +		return sprintf(buf, "overwrite\n");
>   	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
>   		return sprintf(buf, "disabled\n");
>   	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
>   		return sprintf(buf, "unlocked\n");
>   	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
>   		return sprintf(buf, "locked\n");
> -	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
> -		return sprintf(buf, "overwrite\n");
>   	return -ENOTTY;
>   }
>   
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 4cef69b..8f3971c 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -457,7 +457,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>   	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
>   	put_device(&nvdimm->dev);
>   	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
> -	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
> +	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
>   }
>   
>   void nvdimm_security_overwrite_query(struct work_struct *work)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

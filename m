Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5423E220
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 21:26:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD30112BB6772;
	Thu,  6 Aug 2020 12:26:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE5B51293B91B
	for <linux-nvdimm@lists.01.org>; Thu,  6 Aug 2020 12:26:26 -0700 (PDT)
IronPort-SDR: 9vNaBPBzoQr2q71ZOB80CcUK4YgbCOKmxO4lhOoKWWVSV1tQ3cxJ+6Dxw7vEB5jKh6TNsJV9iD
 75nZXhp1mi4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="214429164"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800";
   d="scan'208";a="214429164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:26:26 -0700
IronPort-SDR: 5O34ZelIxamjXUnl1FzmYNKNvTuh08rRshm/yKzkLDz7jljjSA2lVh3biO5Xi8SYHvqVFUhTFa
 lyNB9SEAJL/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800";
   d="scan'208";a="293409554"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2020 12:26:26 -0700
Date: Thu, 6 Aug 2020 12:26:26 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v2 2/3] libnvdimm/security: the 'security' attr never
 show 'overwrite' state
Message-ID: <20200806192625.GL1573827@iweiny-DESK2.sc.intel.com>
References: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
 <1596494499-9852-2-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1596494499-9852-2-git-send-email-jane.chu@oracle.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 6COB7B33KFJCYEGURISRJRKWOKDPYBTI
X-Message-ID-Hash: 6COB7B33KFJCYEGURISRJRKWOKDPYBTI
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6COB7B33KFJCYEGURISRJRKWOKDPYBTI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 03, 2020 at 04:41:38PM -0600, Jane Chu wrote:
> 'security' attribute displays the security state of an nvdimm.
> During normal operation, the nvdimm state maybe one of 'disabled',
> 'unlocked' or 'locked'.  When an admin issues
>   # ndctl sanitize-dimm nmem0 --overwrite
> the attribute is expected to change to 'overwrite' until the overwrite
> operation completes.
> 
> But tests on our systems show that 'overwrite' is never shown during
> the overwrite operation. i.e.
>   # cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/nmem0/security
>   unlocked
> the attribute remain 'unlocked' through out the operation, consequently
> "ndctl wait-overwrite nmem0" command doesn't wait at all.
> 
> The driver tracks the state in 'nvdimm->sec.flags': when the operation
> starts, it adds an overwrite bit to the flags; and when the operation
> completes, it removes the bit. Hence security_show() should check the
> 'overwrite' bit first, in order to indicate the actual state when multiple
> bits are set in the flags.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/dimm_devs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index b7b77e8..5d72026 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -363,14 +363,14 @@ __weak ssize_t security_show(struct device *dev,
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  
> +	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
> +		return sprintf(buf, "overwrite\n");
>  	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
>  		return sprintf(buf, "disabled\n");
>  	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
>  		return sprintf(buf, "unlocked\n");
>  	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
>  		return sprintf(buf, "locked\n");
> -	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
> -		return sprintf(buf, "overwrite\n");
>  	return -ENOTTY;
>  }
>  
> -- 
> 1.8.3.1
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

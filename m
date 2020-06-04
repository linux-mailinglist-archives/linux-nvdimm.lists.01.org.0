Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450041EDA6E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jun 2020 03:28:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6C8C9100A4621;
	Wed,  3 Jun 2020 18:23:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 13235100A4620
	for <linux-nvdimm@lists.01.org>; Wed,  3 Jun 2020 18:23:28 -0700 (PDT)
IronPort-SDR: BxCvHJyN4hma3SmvOlryT9Tp14Ow5SCEwUbQTFBfuN5UoH+8jqtzhhUCX9h+36NnI3bDa98R37
 3flUPRXVSjIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 18:28:28 -0700
IronPort-SDR: vddF3rw+QtTpID4ZNtCecRtaVrIBLa8W+2DncsYpcfviZrmPSbPrOVg8ZBxqWne2HQfHASmh/7
 uF4g2IOFmpsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400";
   d="scan'208";a="312760847"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jun 2020 18:28:27 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jun 2020 18:28:27 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.222]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.123]) with mapi id 14.03.0439.000;
 Wed, 3 Jun 2020 18:28:27 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH v5 3/6] libndctl: Introduce new dimm-ops
 dimm_init() & dimm_uninit()
Thread-Topic: [ndctl PATCH v5 3/6] libndctl: Introduce new dimm-ops
 dimm_init() & dimm_uninit()
Thread-Index: AQHWNgVrAh/euwUHHU645pXJeZnSgajIKDCA
Date: Thu, 4 Jun 2020 01:28:27 +0000
Message-ID: <c11365008f888c081778906eb14f62b7fdc02868.camel@intel.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com>
	 <20200529220600.225320-4-vaibhav@linux.ibm.com>
In-Reply-To: <20200529220600.225320-4-vaibhav@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <B61796323F99B64283EBAE057E1B0EBB@intel.com>
MIME-Version: 1.0
Message-ID-Hash: UAESPF27RROZZMDSEQPPTPTCP43TMP47
X-Message-ID-Hash: UAESPF27RROZZMDSEQPPTPTCP43TMP47
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UAESPF27RROZZMDSEQPPTPTCP43TMP47/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2020-05-30 at 03:35 +0530, Vaibhav Jain wrote:
> There are scenarios when a dimm-provider need to allocate some
> per-dimm data that can be quickly retrieved. This data can be used to
> cache data that spans multiple 'struct ndctl_cmd' submissions.
> 
> Unfortunately currently in libnvdimm there is no easy way to implement
> this. Even if this data is some how stored in some field of 'struct
> ndctl_dimm', managing its lifetime is a challenge.
> 
> To solve this problem, the patch proposes a new member 'struct
> ndctl_dimm.dimm_user_data' to store per-dimm data interpretation of
> which is specific to a dimm-provider. Also two new dimm-ops namely
> dimm_init() & dimm_uninit() are introduced that can be used to manage
> the lifetime of this per-dimm data.
> 
> Semantics
> =========
> int (*dimm_init)(struct ndctl_dimm *):
> 
> This callback will be called just after dimm-probe inside add_dimm()
> is completed. Dimm-providers should use this callback to allocate
> per-dimm data and assign it to 'struct ndctl_dimm.dimm_user_data'
> member. In case this function returns an error, dimm initialization is
> halted and errors out.
> 
> void (*dimm_uninit)(struct ndctl_dimm *):
> 
> This callback will be called during free_dimm() and is only called if
> previous call to 'dimm_ops->dimm_init()' had reported no
> error. Dimm-providers should use this callback to unallocate and
> cleanup 'dimm_user_data'.

I'm not sure I fully understand the need for this whole paradigm - of
creating a private caching area in ndctl_dimm, and having these
init/uninit functions to set it up.

Looking ahead at subsequent patches, the data you're stashing there is
already cached in the kernel or the command payloads. It seems the
caching is maybe just avoiding some ioctl round trips - is that correct?

If so , why not just make all the data retrieval synchronous to the
operation that's requesting it? Health retrieval is generally not a fast
path of any sort, and doing everything synchronously seems much simpler,
and is also what existing nvdimm families do.

> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v4..v5:
> * None
> 
> v3..v4:
> * None
> 
> v2..v3:
> * None
> 
> v1..v2:
> * Changed the patch order
> ---
>  ndctl/lib/libndctl.c | 11 +++++++++++
>  ndctl/lib/private.h  |  5 +++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index a52c2e208fbe..8d226abf7495 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -598,6 +598,11 @@ static void free_dimm(struct ndctl_dimm *dimm)
>  {
>  	if (!dimm)
>  		return;
> +
> +	/* If needed call the dimm uninitialization function */
> +	if (dimm->ops && dimm->ops->dimm_uninit)
> +		dimm->ops->dimm_uninit(dimm);
> +
>  	free(dimm->unique_id);
>  	free(dimm->dimm_buf);
>  	free(dimm->dimm_path);
> @@ -1714,8 +1719,14 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
>  	if (dimm->cmd_family == NVDIMM_FAMILY_PAPR)
>  		dimm->ops = papr_dimm_ops;
>  
> +	/* Call the dimm initialization function if needed */
> +	if (!rc && dimm->ops && dimm->ops->dimm_init)
> +		rc = dimm->ops->dimm_init(dimm);
> +
>   out:
>  	if (rc) {
> +		/* Ensure dimm_uninit() is not called during free_dimm() */
> +		dimm->ops = NULL;
>  		err(ctx, "Unable to probe dimm:%d. Err:%d\n", id, rc);
>  		goto err_read;
>  	}
> diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
> index d90236b1f98b..d0188a97d673 100644
> --- a/ndctl/lib/private.h
> +++ b/ndctl/lib/private.h
> @@ -99,6 +99,7 @@ struct ndctl_dimm {
>  	} flags;
>  	int locked;
>  	int aliased;
> +	void *dimm_user_data;
>  	struct list_node list;
>  	int formats;
>  	int format[0];
> @@ -347,6 +348,10 @@ struct ndctl_dimm_ops {
>  	int (*fw_update_supported)(struct ndctl_dimm *);
>  	int (*xlat_firmware_status)(struct ndctl_cmd *);
>  	u32 (*get_firmware_status)(struct ndctl_cmd *);
> +	/* Called just after dimm is initialized and probed */
> +	int (*dimm_init)(struct ndctl_dimm *);
> +	/* Called just before struct ndctl_dimm is de-allocated */
> +	void (*dimm_uninit)(struct ndctl_dimm *);
>  };
>  
>  extern struct ndctl_dimm_ops * const intel_dimm_ops;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

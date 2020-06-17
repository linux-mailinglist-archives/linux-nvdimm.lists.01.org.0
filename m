Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A47181FC2CC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Jun 2020 02:36:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C89610FC3712;
	Tue, 16 Jun 2020 17:36:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5037910096677
	for <linux-nvdimm@lists.01.org>; Tue, 16 Jun 2020 17:36:10 -0700 (PDT)
IronPort-SDR: UUN9aiePFfqWG9fOh2ZZ9IwCgmleFuFBcKPH3xwGACxIG5nz92UvGIepI4vlZheGRWE7qMdJcm
 2ZyRjaPXIITA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 17:36:09 -0700
IronPort-SDR: m4KfFMHS1iK+Luljrkh2WLgdWtrIxBP/I2T5pp9DZf3AIWdl4WZnjFt6QIuvi8GENZ+WcNYcvK
 5cUmrZ1BqSUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400";
   d="scan'208";a="420959144"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga004.jf.intel.com with ESMTP; 16 Jun 2020 17:36:08 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 17:36:08 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.71]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.235]) with mapi id 14.03.0439.000;
 Tue, 16 Jun 2020 17:35:17 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH v6 1/5] libndctl: Refactor out add_dimm() to
 handle NFIT specific init
Thread-Topic: [ndctl PATCH v6 1/5] libndctl: Refactor out add_dimm() to
 handle NFIT specific init
Thread-Index: AQHWQ59NGxSN72xXBkmmiUb7Wfy9tKjcbHCA
Date: Wed, 17 Jun 2020 00:35:17 +0000
Message-ID: <77ef7c2fcbb084d7261e9e2595c57a03bc234ef7.camel@intel.com>
References: <20200616053029.84731-1-vaibhav@linux.ibm.com>
	 <20200616053029.84731-2-vaibhav@linux.ibm.com>
In-Reply-To: <20200616053029.84731-2-vaibhav@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <AFE38E97B5547A4695CA0A9D32B7A20C@intel.com>
MIME-Version: 1.0
Message-ID-Hash: TPR6ALYFBKHVKVHNUOAHBM5W32HJHEQU
X-Message-ID-Hash: TPR6ALYFBKHVKVHNUOAHBM5W32HJHEQU
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TPR6ALYFBKHVKVHNUOAHBM5W32HJHEQU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-06-16 at 11:00 +0530, Vaibhav Jain wrote:
> Presently add_dimm() only probes dimms that support NFIT/ACPI. Hence

"...probes NVDIMMs for platforms that support the ACPI NFIT"

The NFIT is a platform firmware thing, not directly related to the DIMMs
themselves.

> this patch refactors this functionality into two functions namely

s/Hence this patch refactors/Refactor/

> add_dimm() and add_nfit_dimm(). Function add_dimm() performs
> allocation and common 'struct ndctl_dimm' initialization and depending
> on whether the dimm-bus supports NIFT, calls add_nfit_dimm(). Once
> the probe is completed based on the value of 'ndctl_dimm.cmd_family'
> appropriate dimm-ops are assigned to the dimm.
> 
> In case dimm-bus is of unknown type or doesn't support NFIT the
> initialization still continues, with no dimm-ops assigned to the
> 'struct ndctl_dimm' there-by limiting the functionality available.

No need to hyphenate 'thereby'

> 
> This patch shouldn't introduce any behavioral change.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v5..v6:
> * Changed a return code for add_nfit_dimm() in case a allocation
>   failed. [ Vishal ]
> * Updated an error message in error path of add_dimm() [ Vishal ]
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
> * None
> ---
>  ndctl/lib/libndctl.c | 196 +++++++++++++++++++++++++------------------
>  1 file changed, 115 insertions(+), 81 deletions(-)
> 
[..]

> +
> +	/* Assign dimm-ops based on command family */
> +	if (dimm->cmd_family == NVDIMM_FAMILY_INTEL)
> +		dimm->ops = intel_dimm_ops;
> +	if (dimm->cmd_family == NVDIMM_FAMILY_HPE1)
> +		dimm->ops = hpe1_dimm_ops;
> +	if (dimm->cmd_family == NVDIMM_FAMILY_MSFT)
> +		dimm->ops = msft_dimm_ops;
> +	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
> +		dimm->ops = hyperv_dimm_ops;
>   out:
> +	if (rc) {
> +		/* Ensure dimm_uninit() is not called during free_dimm() */
> +		dimm->ops = NULL;

I think the above assignment and comment are now stale..

> +		err(ctx, "%s: probe failed: %s\n", ndctl_dimm_get_devname(dimm),
> +		    strerror(-rc));
> +		goto err_read;
> +	}
> +
>  	list_add(&bus->dimms, &dimm->list);
>  	free(path);
>  
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

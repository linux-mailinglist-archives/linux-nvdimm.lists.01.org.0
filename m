Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF78377284
	for <lists+linux-nvdimm@lfdr.de>; Sat,  8 May 2021 17:11:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A5F4C100EBB97;
	Sat,  8 May 2021 08:11:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5C7D3100EC1EB
	for <linux-nvdimm@lists.01.org>; Sat,  8 May 2021 08:11:34 -0700 (PDT)
IronPort-SDR: 7cB2LHZ+0zyGjP9uWn6RyHqQGAbHBT0jcKAZdF7Qu8e6fuC0LHeKHjvFk5sHMO9CfdChYvqHhL
 hKTbBQq+7vgg==
X-IronPort-AV: E=McAfee;i="6200,9189,9978"; a="284389964"
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400";
   d="scan'208";a="284389964"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 08:11:33 -0700
IronPort-SDR: v0IxB0OVabyrdXvmG070D8sDxtMPisZuxqlscS2UBywrGOWr5pmkX4wOPWThazHWlep5JWFlLW
 ne1wEoftkyhw==
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400";
   d="scan'208";a="435407452"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 08:11:32 -0700
Date: Sat, 8 May 2021 08:11:30 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/papr_scm: Reduce error severity if nvdimm
 stats inaccessible
Message-ID: <20210508151130.GK1904484@iweiny-DESK2.sc.intel.com>
References: <20210508043642.114076-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210508043642.114076-1-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: JTFYT6FSQTQSYALFJF65E26L3WLWIGPS
X-Message-ID-Hash: JTFYT6FSQTQSYALFJF65E26L3WLWIGPS
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JTFYT6FSQTQSYALFJF65E26L3WLWIGPS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, May 08, 2021 at 10:06:42AM +0530, Vaibhav Jain wrote:
> Currently drc_pmem_qeury_stats() generates a dev_err in case
> "Enable Performance Information Collection" feature is disabled from
> HMC or performance stats are not available for an nvdimm. The error is
> of the form below:
> 
> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
> 	 performance stats, Err:-10
> 
> This error message confuses users as it implies a possible problem
> with the nvdimm even though its due to a disabled/unavailable
> feature. We fix this by explicitly handling the H_AUTHORITY and
> H_UNSUPPORTED errors from the H_SCM_PERFORMANCE_STATS hcall.
> 
> In case of H_AUTHORITY error an info message is logged instead of an
> error, saying that "Permission denied while accessing performance
> stats" and an EPERM error is returned back.
> 
> In case of H_UNSUPPORTED error we return a EOPNOTSUPP error back from
> drc_pmem_query_stats() indicating that performance stats-query
> operation is not supported on this nvdimm.
> 
> Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> Changelog
> 
> v3:
> * Return EOPNOTSUPP error in case of H_UNSUPPORTED [ Ira ]
> * Return EPERM in case of H_AUTHORITY [ Ira ]
> * Updated patch description
> 
> v2:
> * Updated the message logged in case of H_AUTHORITY error [ Ira ]
> * Switched from dev_warn to dev_info in case of H_AUTHORITY error.
> * Instead of -EPERM return -EACCESS for H_AUTHORITY error.
> * Added explicit handling of H_UNSUPPORTED error.
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index ef26fe40efb0..e2b69cc3beaf 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -310,6 +310,13 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
>  		dev_err(&p->pdev->dev,
>  			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
>  		return -ENOENT;
> +	} else if (rc == H_AUTHORITY) {
> +		dev_info(&p->pdev->dev,
> +			 "Permission denied while accessing performance stats");
> +		return -EPERM;
> +	} else if (rc == H_UNSUPPORTED) {
> +		dev_dbg(&p->pdev->dev, "Performance stats unsupported\n");
> +		return -EOPNOTSUPP;
>  	} else if (rc != H_SUCCESS) {
>  		dev_err(&p->pdev->dev,
>  			"Failed to query performance stats, Err:%lld\n", rc);
> -- 
> 2.31.1
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

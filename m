Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0574A217A09
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 23:13:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 44CDF1108DEA6;
	Tue,  7 Jul 2020 14:13:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7EE8E11075BCA
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 14:12:59 -0700 (PDT)
IronPort-SDR: 75OuZK25BP7Arb/+6T1/E/x+ZMCBGDy20UVyBXbqlcHPGeenGWEEuWUSUjc1FBhcAyjEy8+95B
 ztLyhULgL1PA==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="232559731"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800";
   d="scan'208";a="232559731"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 14:12:58 -0700
IronPort-SDR: dGFkiFu3bz5RdeUX9uRN6oACF9yLWJo56Th+mNAjx0Hr6/t9RA4J1TPGdf64vCLZc3I9kQ8EQt
 +XmmuTsCjzGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800";
   d="scan'208";a="483200543"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2020 14:12:58 -0700
Date: Tue, 7 Jul 2020 14:12:58 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [PATCH ndctl] infoblock: Set the default alignment to the
 platform alignment
Message-ID: <20200707211258.GD961523@iweiny-DESK2.sc.intel.com>
References: <20200707005641.3936295-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200707005641.3936295-1-santosh@fossix.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: BSJPNKOMB6ZYOL74XTIAEUBNRHKSMGUW
X-Message-ID-Hash: BSJPNKOMB6ZYOL74XTIAEUBNRHKSMGUW
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BSJPNKOMB6ZYOL74XTIAEUBNRHKSMGUW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 07, 2020 at 06:26:41AM +0530, Santosh Sivaraj wrote:
> The default alignment for write-infoblock command is set to 2M. Change
> that to use the platform's supported alignment or PAGE_SIZE. The first
> supported alignment is taken as the default.
> 
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---

[snip]

> @@ -1992,12 +2001,36 @@ static int namespace_rw_infoblock(struct ndctl_namespace *ndns,
>  	const char *save;
>  	const char *cmd = write ? "write-infoblock" : "read-infoblock";
>  	const char *devname = ndctl_namespace_get_devname(ndns);
> +	unsigned long long align;
>  
>  	if (ndctl_namespace_is_active(ndns)) {
>  		pr_verbose("%s: %s enabled, must be disabled\n", cmd, devname);
>  		return -EBUSY;
>  	}
>  
> +	if (write) {
> +		if (!param.align) {
> +			align = ndctl_get_default_alignment(ndns);
> +
> +			if (asprintf((char **)&param.align, "%llu", align) < 0) {

If we are looping through namespaces doesn't param.align need to be localized
to this function as well?

Ira

> +				rc = -EINVAL;
> +				goto out;
> +			}
> +		}
> +
> +		if (param.size) {
> +			unsigned long long size = parse_size64(param.size);
> +			align = parse_size64(param.align);
> +
> +			if (align < ULLONG_MAX && !IS_ALIGNED(size, align)) {
> +				error("--size=%s not aligned to %s\n", param.size,
> +				      param.align);
> +				rc = -EINVAL;
> +				goto out;
> +			}
> +		}
> +	}
> +
>  	ndctl_namespace_set_raw_mode(ndns, 1);
>  	rc = ndctl_namespace_enable(ndns);
>  	if (rc < 0) {
> @@ -2060,6 +2093,9 @@ static int do_xaction_namespace(const char *namespace,
>  	}
>  
>  	if (action == ACTION_WRITE_INFOBLOCK && !namespace) {
> +		if (!param.align)
> +			param.align = "2M";
> +
>  		rc = file_write_infoblock(param.outfile);
>  		if (rc >= 0)
>  			(*processed)++;
> -- 
> 2.26.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

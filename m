Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 581612621ED
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Sep 2020 23:28:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 390B913C614A5;
	Tue,  8 Sep 2020 14:27:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C35713C046E7
	for <linux-nvdimm@lists.01.org>; Tue,  8 Sep 2020 14:27:54 -0700 (PDT)
IronPort-SDR: fK5EvxZIaHZqORFq/+OGf2sMNBIHc2CQHLfAuSK+Gu12crzPXs5IIrhamoblU2hxxvMALOqLO9
 Yoyyv4K8hvYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155628050"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600";
   d="scan'208";a="155628050"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 14:27:53 -0700
IronPort-SDR: hwcjq7Pqa0jT08ahd3lviO5aItJ8tdYYEohvQkRbr5SMQYLLE0tI/WJR/vWuSO8HZXglMKmkMe
 GDGZw9vyLKtw==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600";
   d="scan'208";a="299929072"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 14:27:52 -0700
Date: Tue, 8 Sep 2020 14:27:52 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/papr_scm: Limit the readability of
 'perf_stats' sysfs attribute
Message-ID: <20200908212752.GD1930795@iweiny-DESK2.sc.intel.com>
References: <20200907110540.21349-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200907110540.21349-1-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: PMRIT4K7VCFVYE3UCRPMO4R6FIW4UPFO
X-Message-ID-Hash: PMRIT4K7VCFVYE3UCRPMO4R6FIW4UPFO
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PMRIT4K7VCFVYE3UCRPMO4R6FIW4UPFO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 07, 2020 at 04:35:40PM +0530, Vaibhav Jain wrote:
> The newly introduced 'perf_stats' attribute uses the default access
> mode of 0444 letting non-root users access performance stats of an
> nvdimm and potentially force the kernel into issuing large number of
> expensive HCALLs. Since the information exposed by this attribute
> cannot be cached hence its better to ward of access to this attribute
	                                   ^^^
                                           off?

> from users who don't need to access these performance statistics.
> 
> Hence this patch updates access mode of 'perf_stats' attribute to
> be only readable by root users.

Generally it is bad form to say "this patch".  See 4c here:

	-- https://www.ozlabs.org/~akpm/stuff/tpp.txt

But I'm not picky...  :-D

With the s/of/off/ change:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Change-log:
> 
> v2:
> * Instead of checking for perfmon_capable() inside show_perf_stats()
>   set the attribute as DEVICE_ATTR_ADMIN_RO [ Aneesh ]
> * Update patch description
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index f439f0dfea7d1..a88a707a608aa 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -822,7 +822,7 @@ static ssize_t perf_stats_show(struct device *dev,
>  	kfree(stats);
>  	return rc ? rc : seq_buf_used(&s);
>  }
> -DEVICE_ATTR_RO(perf_stats);
> +DEVICE_ATTR_ADMIN_RO(perf_stats);
>  
>  static ssize_t flags_show(struct device *dev,
>  			  struct device_attribute *attr, char *buf)
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

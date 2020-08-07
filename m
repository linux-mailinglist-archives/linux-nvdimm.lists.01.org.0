Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B123F2CB
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Aug 2020 20:33:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4170412B8B9ED;
	Fri,  7 Aug 2020 11:33:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 154A4119A18DC
	for <linux-nvdimm@lists.01.org>; Fri,  7 Aug 2020 11:33:30 -0700 (PDT)
IronPort-SDR: XrrVtd2yo4TmASqZ29YHZCl+5BTX8W+cw9mjj9A1wufrXA771ZMwqSefskXwo6pF/8zrJOVck7
 cf6n4JsaD74Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="150878524"
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800";
   d="scan'208";a="150878524"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 11:33:30 -0700
IronPort-SDR: pkIsI4Zv9vbuywWRtP2kf1b48AP7lVZrxMdJbV1zsOl0Rmkxhz0SFMCvgwRj9SM0hxfbVAZBKR
 9MQ3pqnUfZGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800";
   d="scan'208";a="397667364"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2020 11:33:30 -0700
Date: Fri, 7 Aug 2020 11:33:30 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [ndctl PATCH trivial] test: Remove a redundant
 ndctl_namespace_foreach
Message-ID: <20200807183329.GC2467625@iweiny-DESK2.sc.intel.com>
References: <20200806124702.305084-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806124702.305084-1-santosh@fossix.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: C3SLZ363DGO2ROWXQTNXOPXM3YHQ7EOK
X-Message-ID-Hash: C3SLZ363DGO2ROWXQTNXOPXM3YHQ7EOK
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C3SLZ363DGO2ROWXQTNXOPXM3YHQ7EOK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 06, 2020 at 06:17:02PM +0530, Santosh Sivaraj wrote:
> I don't think this was intended to be in the code.
> 
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  test/multi-pmem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/test/multi-pmem.c b/test/multi-pmem.c
> index 668662c..cb7cd40 100644
> --- a/test/multi-pmem.c
> +++ b/test/multi-pmem.c
> @@ -162,7 +162,6 @@ static int do_multi_pmem(struct ndctl_ctx *ctx, struct ndctl_test *test)
>  		char uuid_str1[40], uuid_str2[40];
>  		uuid_t uuid_check;
>  
> -		ndctl_namespace_foreach(region, ndns)
>  		sprintf(devname, "namespace%d.%d",
>  				ndctl_region_get_id(region), i);
>  		ndctl_namespace_foreach(region, ndns)
> -- 
> 2.26.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

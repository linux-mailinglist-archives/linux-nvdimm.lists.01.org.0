Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8395D96F8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Oct 2019 18:20:18 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D1E3110FCB77F;
	Wed, 16 Oct 2019 09:23:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2774910FCB759
	for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 09:23:13 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 09:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200";
   d="scan'208";a="225842278"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 16 Oct 2019 09:20:14 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 16 Oct 2019 09:20:13 -0700
Received: from crsmsx101.amr.corp.intel.com (172.18.63.136) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 16 Oct 2019 09:20:13 -0700
Received: from crsmsx102.amr.corp.intel.com ([169.254.2.18]) by
 CRSMSX101.amr.corp.intel.com ([169.254.1.128]) with mapi id 14.03.0439.000;
 Wed, 16 Oct 2019 10:20:11 -0600
From: "Weiny, Ira" <ira.weiny@intel.com>
To: luanshi <zhangliguang@linux.alibaba.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>, "Busch, Keith" <keith.busch@intel.com>
Subject: RE: [PATCH] libnvdimm: fix kernel-doc notation
Thread-Topic: [PATCH] libnvdimm: fix kernel-doc notation
Thread-Index: AQHVg8e3BIMAxZDB6Uiw4K6Fu0994qddc1Xg
Date: Wed, 16 Oct 2019 16:20:09 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E92B4C086@CRSMSX102.amr.corp.intel.com>
References: <1571192160-54202-1-git-send-email-zhangliguang@linux.alibaba.com>
In-Reply-To: <1571192160-54202-1-git-send-email-zhangliguang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzVmMGUwY2MtOTI2Zi00ZDk4LWI1N2UtNzhjZGVkOTZkNDM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMXZoWTVoV2pMU09rbU94aHB6SUVVbVlPQVorcnJcL2lSRVo5VzU3dWtiVkxiRmpxU0M1aW9Jak96a2FPRkdsU0UifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Message-ID-Hash: F5DQTYIB4M4LYNGZ5PG2N2KEAK6E3X3U
X-Message-ID-Hash: F5DQTYIB4M4LYNGZ5PG2N2KEAK6E3X3U
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F5DQTYIB4M4LYNGZ5PG2N2KEAK6E3X3U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

> Fix kernel-doc notation in drivers/nvdimm/namespace_devs.c.
> 
> Fixes: bf9bccc14c05 ("libnvdimm: pmem label sets and namespace
> instantiation.")
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>  drivers/nvdimm/namespace_devs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/namespace_devs.c
> b/drivers/nvdimm/namespace_devs.c index cca0a3b..5cfb1e9 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1900,7 +1900,7 @@ static int select_pmem_id(struct nd_region
> *nd_region, u8 *pmem_id)
>  /**
>   * create_namespace_pmem - validate interleave set labelling, retrieve
> label0
>   * @nd_region: region with mappings to validate
> - * @nspm: target namespace to create
> + * @ndindex: target namespace index to create

nsindex?  's'?

Ira

>   * @nd_label: target pmem namespace label to evaluate
>   */
>  static struct device *create_namespace_pmem(struct nd_region
> *nd_region,
> --
> 1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

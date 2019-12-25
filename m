Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0B212A75F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Dec 2019 11:33:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D88BE10097F01;
	Wed, 25 Dec 2019 02:37:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C6C551011369E
	for <linux-nvdimm@lists.01.org>; Wed, 25 Dec 2019 02:37:13 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 02:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,354,1571727600";
   d="scan'208";a="392095025"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga005.jf.intel.com with ESMTP; 25 Dec 2019 02:33:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Dec 2019 02:33:52 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Dec 2019 02:33:51 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 25 Dec 2019 02:33:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 25 Dec 2019 02:33:51 -0800
Received: from SN6PR11MB3264.namprd11.prod.outlook.com (52.135.111.80) by
 SN6PR11MB3293.namprd11.prod.outlook.com (52.135.111.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 25 Dec 2019 10:33:49 +0000
Received: from SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c]) by SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c%7]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 10:33:49 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Topic: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Index: AdWqSy7tSheIw9IbRFeymChi7Sx2XP//fIUA/99j/4A=
Date: Wed, 25 Dec 2019 10:33:49 +0000
Message-ID: <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
In-Reply-To: <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTAxODhlZWItOTA4Yy00MzAxLWIyNmUtOWQwNTE2OTIyY2U2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiclwveEpEZnZRZEozWlVEREpyalZTWlFKbCtQd29tYTZYdzVCU29FYXR4S0dRbXFLc3gzV0pHY1BVNG5ybWJTWjAifQ==
x-ctpclassification: CTP_NT
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=redhairer.li@intel.com;
x-originating-ip: [192.55.52.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cba7988-a01a-4580-d70d-08d78925ee1a
x-ms-traffictypediagnostic: SN6PR11MB3293:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB329361CBC6E874DDB1C77DB892280@SN6PR11MB3293.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(13464003)(76116006)(71200400001)(478600001)(966005)(55016002)(66946007)(66446008)(7696005)(64756008)(66556008)(9686003)(66476007)(5660300002)(6506007)(53546011)(52536014)(81166006)(4326008)(86362001)(81156014)(8676002)(186003)(26005)(8936002)(2906002)(33656002)(316002)(6862004)(6636002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3293;H:SN6PR11MB3264.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zo490C08L/QrdAV8nMOTt92JxL6kieqTYFO3ypjNBMacJJ+flFcxm7+IOmRUsz33+uXa7C8IFvWEwqdW/l/alJd6gUq+Vf0ruu3utDHz19O2Z1OtVdPBfuhDNy6S3o4Gd8N3y/hioojqcEcCekxwutNXLAyLeGNLxEKKMl8apNbG4ihFBiDPAYAAoE4VjAB9P35Eo7c9f39m76xW17lLBT5fyHl8Kl4ULOMWGZqnRgAp4/979px4BalqvbfNnjH3eajiPVW/1AaoV4PPzwLMxoYEOmNLJAZp5d+IFy7t4pE14J39DGN/jQ+2JbxjJxnme8uo+oryQsDi2MEEl60vnn9Np/1jUtDvJVJDua0Di6fDG37NbS8M3toN/+XXphnv4lc/ieiPk72leWRvpq98uuw5ZPr8V5yFk8GRpYmpGf+J+dNYAD9PxTNgdDPFAj8NydqfyDOxchco08vnqtxGXcRjugt6YvKefUrlTzOwib9GggnKBSxwAhbOteXGnMvFlahPUcEcWlJzzX4jeD0dDuu6mwX4vJI4UmPCB5fdF24=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLKsHM8I78L4wjgDeLHft/cFpJ03E4Ym5tmUVk8Enc88r6/Mamng01bwd6xyqgkgFrGWV/KthqqKjyOcV1lQRDxC4eiOpcg6E/a2pDVHgUI9Tt53FFGDgP6rWKTpcK9lR724fcrPaGx6cXevEILKzieC/TnAliRPCiTrMo59ZVrRFzM7bKKcrgxUrytkn8L6E528XUZLNnn/2z4rBgqLpllOrd4nswf4aRXERM2zQUT1EYZn2+IZ5/IcIGW4WxBKEF2cud0KMOAvyhqLrXUUeHTqCs25Qof+X5EkwziZr2QDW8fYuGJAiJTiRYcK2USf6KVg1UUi5GM4RO+DRK/JpA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EB0YBNbvqMlLB3YbFk8YCvEiOZ3wfcueESi7RYIbOk=;
 b=cyiUXMrrSD8CA6uKFXzLkDD2yTsXZGAm115iDHDOeAlO8MsJ1a5N0vkgEWJEe5X29D5EBrgFC2XZlDz7oG1SZPLFwFxhPwZKzS923oCDlA7W0X/WUyOBLV/j0no6oPrrNjGwMI0BDiB39/Mt0n3NutgMutWChEKO2ZudpNmR28ebZZLnhYI6DX7XkX/6Ak/IFi0s7lSshGdzzN4p7GyCJmvCu/Y5N7hXMBfalgg+ntLSMmItvx6esbZ7Bb70rWEa9eSUIc/TPZj8/YkJNscmd1/C0P0CKPWXotaR6R145WejyPB4aB58vnxABdxjwxBrbZprC9p6mjTAJ2BwluQ+iQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EB0YBNbvqMlLB3YbFk8YCvEiOZ3wfcueESi7RYIbOk=;
 b=sv5yT4YCIU8zxIdkqlC/XMlnxpehn2iWXvd1TgS1Nq2SsNjpSs87MWRD9K6rRkc9k4FxYZce04SI9oPrBNMQgE/3O1X8IkC16+s+Zmpf8jZJpzt+wLQI81N69tMilRoEvbkKZP22VqVLiUwNUmwqJEjfC7Er6Z3qznNstGY+bJI=
x-ms-exchange-crosstenant-network-message-id: 5cba7988-a01a-4580-d70d-08d78925ee1a
x-ms-exchange-crosstenant-originalarrivaltime: 25 Dec 2019 10:33:49.6177 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: VAgP8yoEYOzPCWU7cSgrF5HkjGea6Ja9Oq0G2PbghP6tz4/IjzoXal4tPcFTcKaBcgVHKB7VlIq2RiKDn8Ajkw==
x-ms-exchange-transport-crosstenantheadersstamped: SN6PR11MB3293
MIME-Version: 1.0
X-OriginatorOrg: intel.com
Message-ID-Hash: YV5B4GJWVNNTGSQOIT64VAQRGLCLBGEQ
X-Message-ID-Hash: YV5B4GJWVNNTGSQOIT64VAQRGLCLBGEQ
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YV5B4GJWVNNTGSQOIT64VAQRGLCLBGEQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

I don't see any failure even apply my patch.
What failure do you observe?

make --no-print-directory check-TESTS
PASS: libndctl
PASS: dsm-fail
PASS: dpa-alloc
PASS: parent-uuid
PASS: multi-pmem
PASS: create.sh
PASS: clear.sh
PASS: pmem-errors.sh
PASS: daxdev-errors.sh
PASS: multi-dax.sh
PASS: btt-check.sh
PASS: label-compat.sh
PASS: blk-exhaust.sh
PASS: sector-mode.sh
PASS: inject-error.sh
PASS: btt-errors.sh
PASS: hugetlb
PASS: btt-pad-compat.sh
PASS: firmware-update.sh
PASS: ack-shutdown-count-set
PASS: rescan-partitions.sh
PASS: inject-smart.sh
PASS: monitor.sh
PASS: max_available_extent_ns.sh
PASS: pfn-meta-errors.sh
============================================================================
Testsuite summary for ndctl 67.dirty
============================================================================
# TOTAL: 25
# PASS:  25
# SKIP:  0
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
============================================================================

Thanks,

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com>
Sent: Wednesday, December 4, 2019 10:43 AM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm@lists.01.org
Subject: Re: [PATCH] daxctl: Change region input type from INTEGER to STRING.

Nice! You got mail working!

On Tue, Dec 3, 2019 at 6:33 PM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> Allow daxctl to accept both <region-id>, and region name as region parameter.
> For example:
>
>     daxctl list -r region5
>     daxctl list -r 5
>
> Link: https://github.com/pmem/ndctl/issues/109
> Signed-off-by: Redhairer Li <redhairer.li@intel.com>
> ---
>  daxctl/device.c | 11 ++++-------
>  daxctl/list.c   | 14 ++++++--------
>  util/filter.c   | 16 ++++++++++++++++
>  util/filter.h   |  2 ++
>  4 files changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/daxctl/device.c b/daxctl/device.c index 72e506e..d9db2f9
> 100644
> --- a/daxctl/device.c
> +++ b/daxctl/device.c
> @@ -19,15 +19,13 @@
>  static struct {
>         const char *dev;
>         const char *mode;
> -       int region_id;
> +       const char *region;
>         bool no_online;
>         bool no_movable;
>         bool force;
>         bool human;
>         bool verbose;
> -} param = {
> -       .region_id = -1,
> -};
> +} param;
>
>  enum dev_mode {
>         DAXCTL_DEV_MODE_UNKNOWN,
> @@ -51,7 +49,7 @@ enum device_action {  };
>
>  #define BASE_OPTIONS() \
> -OPT_INTEGER('r', "region", &param.region_id, "restrict to the given
> region"), \
> +OPT_STRING('r', "region", &param.region, "region-id", "filter by
> +region"), \
>  OPT_BOOLEAN('u', "human", &param.human, "use human friendly number
> formats"), \  OPT_BOOLEAN('v', "verbose", &param.verbose, "emit more
> debug messages")
>
> @@ -484,8 +482,7 @@ static int do_xaction_device(const char *device, enum device_action action,
>         *processed = 0;
>
>         daxctl_region_foreach(ctx, region) {
> -               if (param.region_id >= 0 && param.region_id
> -                               != daxctl_region_get_id(region))
> +               if (!util_daxctl_region_filter(region, device))
>                         continue;

There's a bug here, can you spot it?

This causes:

     make TESTS=daxctl-devices.sh check

...to fail.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

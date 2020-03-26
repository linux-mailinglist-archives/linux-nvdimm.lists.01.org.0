Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B12193BC3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Mar 2020 10:25:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E703D10FC3BA3;
	Thu, 26 Mar 2020 02:26:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lukasz.dorau@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6A71010FC3763
	for <linux-nvdimm@lists.01.org>; Thu, 26 Mar 2020 02:26:24 -0700 (PDT)
IronPort-SDR: F77+GO4bo+YmLJbT1/6fbCWWgYyEgXNF1JRMa+WrhmvEiSxEA5qo2yivNIpojuTosDbatqjAhe
 awykmxWuJwrw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 02:25:34 -0700
IronPort-SDR: tKdDhFS1+T/lvStGJYuInkieywWc4MsQ2vPtJCBjIZHEOfFpE7m/Z/Hp3NV4OHGPzWzI6XWFM8
 YTrZroWqqj1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,307,1580803200";
   d="scan'208";a="293584627"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Mar 2020 02:25:34 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 02:25:34 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 02:25:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.58) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 26 Mar 2020 02:25:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEbRWSymjixxqOF+rFzoRK5HzM/pozEXyLSrSQEJj9hridZBBgRslb3fBLiEPILfvJCiqMJuRMP8RdTMfNy07dVbdJUf+4zmGns96QVHEobbk3SNZZS3jlaNNiMuI6LvgNIr/XjjpNRdsZWCya2z8S7yDjE+kW0TAqEAhIDT4ZgBJKcRKKpodQHl72dtTsJorTfDAQxqjjeXVrxL1eunlnD9WakngGcvousYZxy34w3CW4nyAPLz1Eq6oK8weiVp0sE0fUg6Szb+O8UxscUXzDX/yvxBshTXDAbSeDpZTB/r2IorClWjG71RUz3KRiM8HNtt3YipgHqHPoElOkKh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Y2nVKHIdbn+XHmd5co8fp6xX+0gS9E0JamoY9GUlc=;
 b=jSUqN4kTrt8TtFWG/tnp+DP6ZoxsuGM2QugwAOzgJ9lSNic0rnE/shJC+Vo1OUoP/YxF6eoBRqK4gHvI/N8xRupj5uHABSMftiIjVecXGBQDK+3IKMpyLLqm7pBd+qjd5UaTHIHByQA6L3lRCKBuSzOXs4hmcNqMGOxA12XvhykUrGiKilMGhSRSvOsHqPdx/EJKYdMcMwLLwq6POQLStgJM2nnUJkPJ+uL0ypSWUXK00x2Hk2YxCwry9avkHyehR7NSIbu8AYnjnoUEyTgLcpWHLmlmSytVvaCtCuKfTxIV+QaQ6mzq9Upsg/+WXsKrD2OkaCCLoNue82tb/F5foQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Y2nVKHIdbn+XHmd5co8fp6xX+0gS9E0JamoY9GUlc=;
 b=NsBl1MBwLDj0fCNJtMKd8LbmAry7bRF2goxpDy7TS3FPQVaVl+hKl65wkEEhuFRvC0L+aGuMI4zoLOoxZWFghUaKpJHsw2uR3LdFZ3+40WgOY04Ql1/4oO/3SEMQ1FipLa79a6LhK5Dxuhw/fGE4ey9Ir93gjsy13m92SiP1W1o=
Received: from BN7PR11MB2849.namprd11.prod.outlook.com (2603:10b6:406:b5::24)
 by BN7PR11MB2801.namprd11.prod.outlook.com (2603:10b6:406:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 09:25:30 +0000
Received: from BN7PR11MB2849.namprd11.prod.outlook.com
 ([fe80::55e7:da52:9a70:4b33]) by BN7PR11MB2849.namprd11.prod.outlook.com
 ([fe80::55e7:da52:9a70:4b33%7]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 09:25:30 +0000
From: "Dorau, Lukasz" <lukasz.dorau@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>
Subject: [ndctl PATCH] ndctl/README: Add a missing config setting
Thread-Topic: [ndctl PATCH] ndctl/README: Add a missing config setting
Thread-Index: AdYDUHwforQEEX8ZSJ6r2fig7Jv/xQ==
Date: Thu, 26 Mar 2020 09:25:29 +0000
Message-ID: <BN7PR11MB28495CCA929E46ADEB9B6B9296CF0@BN7PR11MB2849.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lukasz.dorau@intel.com;
x-originating-ip: [194.49.105.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09474363-4c5d-4dc4-235a-08d7d167a084
x-ms-traffictypediagnostic: BN7PR11MB2801:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2801250A547D2EA547BE02C796CF0@BN7PR11MB2801.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(498600001)(107886003)(9686003)(6916009)(66556008)(66946007)(66476007)(66446008)(76116006)(8676002)(186003)(81166006)(81156014)(55016002)(64756008)(7696005)(8936002)(4744005)(4326008)(26005)(5660300002)(86362001)(33656002)(54906003)(6506007)(52536014)(71200400001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2801;H:BN7PR11MB2849.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ql259p5tJdSCrG2seWl1l05rIRiOyjiqcVS58btgrlk2qDA3t8VRcGpWEankK0IxGu3vLc7pop9pqs2RU1sFkhrgDKp33C0jHUuWVUKZle9o/X0oR+9x8mKiUmHnB0o5WSIVwxCzx27SFaeYs7WNoOAHf1ZWIKHKqTGIJlDyoLNrc/bUlngscn9ZYdd/eH8NojUeeP6I85poA383HkX3gvsdw4d/dnG5t6nnn2nC+rXh4c4NqAFbKzIfxM8p7VGp0fCs19d7e0HrhjQIoDt2vu2tXKdUN7jMHfTvy5Ucojt6Of4F54/TcgK60hxRfp1vZD+N6IVCmSa5iIZ7ZHApAV0oFZnHdeivupr9JPryK7rRjbcUUuBoctF3TX4U8CJ8MKzidMiAkpPCZ14/Ly1J8Dwp3Zgg92VQFOsTV9rlnEpZzxSV8Bvp9f5d4UWNihb
x-ms-exchange-antispam-messagedata: tBdhl++L/NPwuPc5jWD9cvZFNTdYhbZ+X/IJZKe79HLg09/bBZTin6jD1PC8HjuVfYQaKCWEyYx7ivIXIFlThuh/O6lt6GX+KtC+b+s983OHwv9JgLORBH4TqpZgTq51cFgYDQPQ1z546/HDmq+2eQ==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09474363-4c5d-4dc4-235a-08d7d167a084
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 09:25:29.8786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NGqJ2RnDF4wrrp55R3ZPW8mVbIvi4IJEe4ypjcN9Q76K5j6tSJGVpBLRIBC1WwQeCQsnRVxs6d7OSDS7piDWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2801
X-OriginatorOrg: intel.com
Message-ID-Hash: EROY2MVSU7HYJFTOGWNIVRW4L3NQQDIM
X-Message-ID-Hash: EROY2MVSU7HYJFTOGWNIVRW4L3NQQDIM
X-MailFrom: lukasz.dorau@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EROY2MVSU7HYJFTOGWNIVRW4L3NQQDIM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Add a missing config setting to README.md:
CONFIG_DEV_DAX_PMEM_COMPAT=m

Cc: Williams, Dan J <dan.j.williams@intel.com>
Cc: Verma, Vishal L <vishal.l.verma@intel.com>
Signed-off-by: Lukasz Dorau <lukasz.dorau@intel.com>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.md b/README.md
index d296c6b..436ada3 100644
--- a/README.md
+++ b/README.md
@@ -65,6 +65,7 @@ loaded.  To build and install nfit_test.ko:
    CONFIG_NVDIMM_PFN=y
    CONFIG_NVDIMM_DAX=y
    CONFIG_DEV_DAX_PMEM=m
+   CONFIG_DEV_DAX_PMEM_COMPAT=m
    ```
 
 1. Build and install the unit test enabled libnvdimm modules in the
-- 
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

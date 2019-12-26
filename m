Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE912A98C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Dec 2019 02:48:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B9A1A10097F27;
	Wed, 25 Dec 2019 17:51:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3FAEE10097F24
	for <linux-nvdimm@lists.01.org>; Wed, 25 Dec 2019 17:51:51 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 17:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,357,1571727600";
   d="scan'208";a="214469074"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga007.fm.intel.com with ESMTP; 25 Dec 2019 17:48:30 -0800
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Dec 2019 17:48:30 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Dec 2019 17:48:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 25 Dec 2019 17:48:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr4HXX5JXOlenSSxRC1zTkKLVD1tgbhOjZIz+pSND1s6PW5e7p1B3S7XFXXHyOezcR2cIVqnqTUAz4VFKD2uvSkZFxCij4YbTAFGv9dMOZhRowUFT/fPrJlPm8N84O1QutKVZfBwEdmHIaIqPE4G9Z4bJSsggBuYvae9rEKUpsALlLK5k8M0uIkyOuboRM5KwIEUZZqFiF5VG6EtTQunsAn0FO+lVkxMsoCH97KkcfdKdGc5lCtCdupApgR3klr7/y8xC//WzsPa59Fsf+Zuc4jUd2+6z07anxjyd1Fq6BkzSX6etkOShh7er6GQGAjjYTL3rgrynFs2P/9pKdR10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OUi69DvBwWSBjOxA0cTFx6kJOfaKfENkj+frXbk0+Y=;
 b=kUprMpGmO5ivSBAJ6ATj6MMDP+0DrvxwE5gJ0rzVqI0wcezz+qt9VzyXEjke2/Mb0z23rIx3tkqWGgwxydipmtABLdt6Kjh+AstNTPew7PWhCDk+7u5itjQmzxrEzlMVIkQl5Jd1PsJlxvfT+DqvtvolRHJsDSA6lmOirt3KEOpSD3qWiT5s/vcNEWxnghwXLq8hrdmZ7u2znJlJ4Rs4zIVTXezCD+v85P5zqIW2zA6DfqtTugLSzA/N08VInDUpKHapbAhZCpZZ2hECW3HusT83Jh5nsfe9PTImFmAOR7mo2qdhbrU5Xh1gmKH8vR2l7XrtkKEle5z73B+Bvy5bOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OUi69DvBwWSBjOxA0cTFx6kJOfaKfENkj+frXbk0+Y=;
 b=ti7z5sOT3otPTvxLWqhJbZ8/jDbw5D1Xx3e1Ugoj6LH6csMb1sWC/xihoqqkpFPQEHEHikUxCiMq8vshEcD2Nw/ybowkhUii6IdB2FR07bWUX+JIWkFAnZUFTLzXAPxkcdCfBSAqrR0cXPnIaJT7vfeLi5QZYAK79cutSUtnaXI=
Received: from SN6PR11MB3264.namprd11.prod.outlook.com (52.135.111.80) by
 SN6PR11MB3168.namprd11.prod.outlook.com (52.135.109.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 01:48:13 +0000
Received: from SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c]) by SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c%7]) with mapi id 15.20.2559.017; Thu, 26 Dec 2019
 01:48:13 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Topic: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Index: AdWqSy7tSheIw9IbRFeymChi7Sx2XP//fIUA/99j/4CAQ1rRAP//ul5A
Date: Thu, 26 Dec 2019 01:48:13 +0000
Message-ID: <SN6PR11MB3264C140FEB5C66679095AFF922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
 <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iP1NK=2funtr6yp9VhedntKvzkvBsXDkLLXt6FBZYO=A@mail.gmail.com>
In-Reply-To: <CAPcyv4iP1NK=2funtr6yp9VhedntKvzkvBsXDkLLXt6FBZYO=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTRmYWVmYjktNGZhMC00MWExLWJhZGEtNjU3NWYzMzg0YTMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ1NaN29FMXd0bFp0U0d2S1NmbURlaURua1wvUXQ0dkRcL2JvXC9TOGRJUVwveGxSY3BRXC9vem5TYXRZQUMwY1VFaTB3In0=
x-ctpclassification: CTP_NT
dlp-reaction: request-justification,no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=redhairer.li@intel.com;
x-originating-ip: [192.55.52.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6e0793e-f1c6-4763-3e35-08d789a5ab89
x-ms-traffictypediagnostic: SN6PR11MB3168:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB31683AE1644CC416F5692C3F922B0@SN6PR11MB3168.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39860400002)(13464003)(189003)(199004)(76116006)(55016002)(6862004)(9686003)(7696005)(186003)(8676002)(478600001)(86362001)(81156014)(316002)(81166006)(66476007)(6636002)(66446008)(66556008)(64756008)(66946007)(4326008)(5660300002)(26005)(71200400001)(53546011)(6506007)(33656002)(52536014)(8936002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3168;H:SN6PR11MB3264.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXHjbHu8N3vy5FziIcBywNkgkOoDIvH2LIStmjMUTe08Ey1J61nhGQukopeMAxRAJzwJVTOJCPfbN9+BqXkONRP4k09RGhQrFa+jOxO0q25qr4c9nh44UTWIqQI3MEMGztQRGuhNJhzjnxqwJw95CGq6krCo1DhJc7j0MhvlGDFkBG50TjaVIETL+bOVs2SjHhqO3ICfmD15yiRJd53zoFkQLOTueNmN0+nOFHrL9QYWC2/TfigIZKObw8Yx16PsyRzMI9iRjDJ6NNsc/yYBu29Y0290sl3q2Rc1WeoBaiU2+yT9/QpfrBfkXNIbUAMTElezjggIeetEjdZmAatcqjvfXZXtHPCj1QdzuFs012cuP47FZ7vUJ9q9T5KOGcm4pxeVpA/q4GYHtUWIuhfUI6Fkymd2ffzJ0+1nSj7AEcsjKe50rw1bVE2j23PxE9zNCkiCrGIZcrhegb0bXxA+ovL/HZsVglIceGmj0jKXOLkpJ3qGOFFsqVdpL6Vd6tuR
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e0793e-f1c6-4763-3e35-08d789a5ab89
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 01:48:13.4323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/8biybHDVgVq19il1kHDP+de8elbbmzrWkxvkg5xALEAWHIw0d59M1D/3eaK5UJnq4vAfR/vHK9BXQLaCX+Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3168
X-OriginatorOrg: intel.com
Message-ID-Hash: GENELXRFI5FM5SYPUPDVW4UBJDYOACJO
X-Message-ID-Hash: GENELXRFI5FM5SYPUPDVW4UBJDYOACJO
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GENELXRFI5FM5SYPUPDVW4UBJDYOACJO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I try "--enable-destructive".
But I always see the following msg when I run "make check" and "make TESTS=daxctl-devices.sh check".
Do I miss anything here?


/usr/bin/ld: blk_namespaces.o: undefined reference to symbol 'uuid_generate@@UUID_1.0'
//lib/x86_64-linux-gnu/libuuid.so.1: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
Makefile:850: recipe for target 'blk-ns' failed
make[3]: *** [blk-ns] Error 1
Makefile:1477: recipe for target 'check-am' failed
make[2]: *** [check-am] Error 2
Makefile:785: recipe for target 'check-recursive' failed
make[1]: *** [check-recursive] Error 1
Makefile:1079: recipe for target 'check' failed
make: *** [check] Error 2

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 
Sent: Thursday, December 26, 2019 5:18 AM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm@lists.01.org
Subject: Re: [PATCH] daxctl: Change region input type from INTEGER to STRING.

On Wed, Dec 25, 2019 at 2:33 AM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> Hi Dan,
>
> I don't see any failure even apply my patch.
> What failure do you observe?

I see the failure in the daxctl-devices.sh unit test. That test and others are included in the "destructive" set of unit tests. They are classified "destructive" because they write to platform persistent memory resources instead of the emulated nfit_test resources. You need to pass "--enable-destructive" to the configure script at build time to enable the destructive tests.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

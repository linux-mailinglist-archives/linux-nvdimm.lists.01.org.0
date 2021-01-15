Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9BD2F8216
	for <lists+linux-nvdimm@lfdr.de>; Fri, 15 Jan 2021 18:22:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 029A2100F2245;
	Fri, 15 Jan 2021 09:22:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7457D100ED4A7
	for <linux-nvdimm@lists.01.org>; Fri, 15 Jan 2021 09:22:25 -0800 (PST)
IronPort-SDR: MKxVxxol1dIwDhEFYlDhWa1IDQplLUUXEIOGOX3EktMz3D/Y/6aiZyheWXsaagaTxLpPoBLiSl
 WGg7NW15kOGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="166248486"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400";
   d="scan'208";a="166248486"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 09:22:24 -0800
IronPort-SDR: +V8vaHiS333gelLLyDQrhQTRMnIlpXAKfVp9ttVEdpfe6jxIjRMA5Or+pn9rQJaEJnLcGWgoJ7
 EjqNjv4m0dtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400";
   d="scan'208";a="465648778"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2021 09:22:23 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 Jan 2021 09:22:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 15 Jan 2021 09:22:23 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 15 Jan 2021 09:22:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Btuab3aiYEmwchaf+hyLEjk2KAg7Xq2s9Q74x9knXLDiTHLMs0LotFk1LZcE+sS+RO0zaUMMIZTsPdWSDom0yGWwL2/UAsEpzeTW2TQx83Ljqp6msyauStM71T2nweTcEvPBMfInbF7ZhL9Br+keK0ccCnomMcXLLsfsPZKRQ/iDf8n9PQQAsfUnUyXPO/FDeV7+PwNXoMZXY7UMlsRmL900XZsoGHFuCQHKswHhL9+OkfMLnPQmi+Gg9B/0E3S4O4sbnsU13Mg+qe+THe2v/pLze9HMEhGtkhMKBqeBKWUc37PBEiabg83VgCYpuGGTWh9CpxVnFYB+bwrOjcoPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf9aA6voIPulK5vWCLTu9sLsjeUjGhXLAuxeWhal7I8=;
 b=Rra5yGQHBtARjuC4FOlMsQar2oj+o+viPXNEhQXewiqBozYz24SdNA2c4IMGZyvEotLzLSZtZtRImnF0ie5VRktqG/wEMzmOFAbGgO8N8Rc3/C1hFyumgRSlKBUwlv+KqS+9syRsYpiZ3W9jetDOcjIYWL875ptZDTjfML5GyDG34utpsS4NmGeJ2i50QKVqFlBmNYf+LCFgvrpRhZ5S9hfgjuZLX3IBktA/6JaHyPJ1shKiyQBVxEskYqkw8uIaTz6AFL41Oh55ULzTD9p82oNwGead6dinN+S39JMpmV4DRADZrpPyjIk5jgKSxEjIAvaAGaYH/akv1rF5Ts0NIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf9aA6voIPulK5vWCLTu9sLsjeUjGhXLAuxeWhal7I8=;
 b=ioG+oNL5u5BxEPZKef8V+bL68JxyC23UqB9LtPYcEJhlMbUEYXb3ZWJmK8UoPbdEjjKi27gKqVuYCpDx3W0js2AzizMyaJxhAbHfLR1bLmGDaZ4YktpI+Yb5owRGuBGMvsGKl2kqbyB34GT0VVVFxtfT4RUKQgv6j7ZZUu2z5Vc=
Received: from MWHPR11MB1375.namprd11.prod.outlook.com (2603:10b6:300:23::11)
 by CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 17:22:22 +0000
Received: from MWHPR11MB1375.namprd11.prod.outlook.com
 ([fe80::75b7:96f5:3a1d:3b98]) by MWHPR11MB1375.namprd11.prod.outlook.com
 ([fe80::75b7:96f5:3a1d:3b98%9]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 17:22:22 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
Thread-Topic: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
Thread-Index: AQHW6XrcV5Ed68tNgkCZDi+pg3otQqoo62Hg
Date: Fri, 15 Jan 2021 17:22:21 +0000
Message-ID: <MWHPR11MB13753C37B1394CFFE124A30892A70@MWHPR11MB1375.namprd11.prod.outlook.com>
References: <20200426095232.27524-1-redhairer.li@intel.com>
 <CAPcyv4gLKSMa4bN446MnRtjdfGaM-Hjy+dcYm316=4EP43G1wg@mail.gmail.com>
 <BL0PR11MB3281CBD1CC9B64389731ECE492AC0@BL0PR11MB3281.namprd11.prod.outlook.com>
 <CAPcyv4gupvktDG2PdCL6SyO4gwC1WoP8PKmPv1gP6pp8i10esQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gupvktDG2PdCL6SyO4gwC1WoP8PKmPv1gP6pp8i10esQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: request-justification,no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [1.160.100.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b4bf4ee-e504-4b65-6010-08d8b97a1e72
x-ms-traffictypediagnostic: CO1PR11MB5009:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB50096293C2C8B0886379BCCA92A70@CO1PR11MB5009.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZfeD7o72fPv2NLIXQ96Tfb22WhPJsDxzXjRBgvBySnEuAoO7z4t5pkyG0i1v+Lf9s2O+nI+2+6HTU79Lz4IOfX2YigPqBDiBU/wb22jHc0jSiAd2FFGsqwJ6Kp3x8XANeLCpeTflb2rL47fwwMPxrnAVUKHhSOPpG96toyEkmV+u8Nl+wmymSHNjsNSLvwpqx++/uxCFMx28iT47po1HyKsRWAN1LuzBBkbPgi9/UfIY7XD+Ylvxi13lc5lL5dHUTBrMw2vUPZctHwCuPw9yvn5/HqWK67jRErukvoVKWwpdsTktZOjAC1MAuuJ80du50ToXTjmA8r5tGA8VmcXvnJYSlWQjqMOj/RepIPP1evx5rZTKspEuoP2g5wjLrNFRv+wgzIwaMzswQwQofDH5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(26005)(83380400001)(55016002)(33656002)(9686003)(66446008)(6862004)(66556008)(66946007)(15650500001)(8676002)(6636002)(2906002)(76116006)(478600001)(52536014)(86362001)(5660300002)(64756008)(8936002)(66476007)(53546011)(71200400001)(6506007)(4326008)(7696005)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NDRwZmdXWXZnamc2YVBJS0plaU9rc0RMT1paM1NWNW5qaHVaRGpKbW5jL2pS?=
 =?utf-8?B?Qlh2SWZEbXFRUkpsNndyTW5XT0t3YXVKVjFPUXVyRnlqdVdtdHNuMWNWSTBp?=
 =?utf-8?B?Z1ZNRnZFa1JrVHJaUWNXMzZ5WEFLWmRzdnFsM1NzUU5xRFRMd1podWdoRTh0?=
 =?utf-8?B?QkRERXBkY3B6SlprNGlEYWlLblhVVnVjSklyR0lVZGFCSEIraEZvdkNZeUEx?=
 =?utf-8?B?UGRkM3ZNcmkzUWs1SXM5eEUwU2pPNFhaTDJieUs1alNiL1VnSU9GOXJZeEZJ?=
 =?utf-8?B?NzRsbzVYODhFOStMM2hDdG52cTNoY045RGJJR0F4L3VSUk01aDdkQ3FiMlZy?=
 =?utf-8?B?YjZoVFd0QVdCK0pzaXRoQU44KzUxQVhGcXA4b1JlZE1sSzZOZEY4K2Y4NkdL?=
 =?utf-8?B?N2U0SHBBL3QxeTZPeU5zM3dxK2VKaWtBQnFIWEF3dklsTWVnMFVqbkQwNTJN?=
 =?utf-8?B?bkNLZlBWVFF1SUFNc2pRRGp4U2EzVytZUjIzQzdVeXpna3Q0cmkyOHZXdGdh?=
 =?utf-8?B?c1lYQTRTRzhyYjJISlVqcXk3UVY1OU9sRzAzTE1hZDlQbklpTVVRZXJrcWgy?=
 =?utf-8?B?ZElaU1hjT3ovNVd5aE83Y3IxMUxIUjZwcWFZR3pyNndIRGxPOUVIWWp5dnhR?=
 =?utf-8?B?ZTZZZUNkWHFWRUIxcDJyQWQ4OHlzTE8rajI4ODlLRWNkN2JwbGwvU0Y3ZXRU?=
 =?utf-8?B?SFdxTjNxQ1Rib2Q0T1ZmcjhiUUJuREk0ZGp2dnhWalpDWFFlY2FQbHVZOUFX?=
 =?utf-8?B?WEJzSmtKa25aT2l3MTVRdlBMcno4VS9SenB1WHFoVlNsNEd4NnpLYTFaME9P?=
 =?utf-8?B?ZmN5Um5xU0lUbG1uQzNpbHFRbjc2U0kvZysxY09PVzhPak1aaGJoTmZmWGov?=
 =?utf-8?B?aTE3RGpCN1AzQm9KSFB0OFh5K0g2YU5vNDhMS2x1SkthM3ArWjAwem93b29U?=
 =?utf-8?B?OXp0Mjc5K1ZNTVcrcEIrK0RIU1Y2Y3J0ckhtUXA5b1BoeHNaMHpXdVFPcXdt?=
 =?utf-8?B?Qmp3T05NR3BqTnY1U0VVSE03V0pTd3Y1emhYU2I1OXB3dmxIYWFRVnBJWDc5?=
 =?utf-8?B?aHAxQmlia1kvb0dXVzY5SUdLdWpLN1ZTVGMzYkYzT2R6em1SNEx6SFM1Sm9J?=
 =?utf-8?B?ZEU2QmREVGtOd0dCb0kzY0Q1OFh5MXFaS1dxVGdEYmZlV3cwRTJmWC9VajFj?=
 =?utf-8?B?a2hTdXJQRnR1YzBSbTBEWEpqZmpqaElSKzBwWG1nbTlYZ1FtQTdNSTkxSGFH?=
 =?utf-8?B?RXRSRXRIRG9INGhLdFFFcnpNdUNWOVVjT0hPU0sxWHpkNWE0YjFPRzNYUm9i?=
 =?utf-8?Q?vdmLa4GxH4qzk=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4bf4ee-e504-4b65-6010-08d8b97a1e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 17:22:21.9306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TgPOznuFTfW2yUzBLWx2671Cup7H1pi6wLSTaQxgZ1usmqHcpLoPOCqIoiH7AFwGvlSCY5VSqm6gyDmJG70tWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5009
X-OriginatorOrg: intel.com
Message-ID-Hash: NEIXANMX43Z6XOIEXNRNILUYVMIH2NXA
X-Message-ID-Hash: NEIXANMX43Z6XOIEXNRNILUYVMIH2NXA
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NEIXANMX43Z6XOIEXNRNILUYVMIH2NXA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

Your comment is make sense.
ndctl_namespace_disable_safe will return 1 if namespace size is 0.
I send a new patch out for review.

But I am not sure what do you mean for 2nd patch.
In cmd_disable_namespace, it already print error if rc<0.
	rc = do_xaction_namespace(namespace, ACTION_DISABLE, ctx, &disabled);
	if (rc < 0 && !err_count)
		fprintf(stderr, "error disabling namespaces: %s\n",
				strerror(-rc));

my patch is based on v70 due to latest one will see "FAIL: create.sh" when make check even not include my change.

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 
Sent: Wednesday, January 13, 2021 3:08 PM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting relative to seed devices

Hi Redhairer, sorry for the long delay circling back to this...

On Mon, Apr 27, 2020 at 6:10 PM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> If make this return 0 in the case when size is zero, then seed device 
> will be counted in due to case ACTION_DISABLE:
> rc = ndctl_namespace_disable_safe(ndns);
> if (rc == 0)
> (*processed)++;
> break;
> I ever think make it return 1.

I think returning 1 is the right answer, because this isn't a failure and there are several other places that call
ndctl_namespace_disable_safe() that need to be updated to treat rc < 0 as failure and rc >= 0 as success / no disable necessary.

ndctl/namespace.c:1127: rc = ndctl_namespace_disable_safe(ndns);
ndctl/namespace.c-1128- if (rc)
--
ndctl/namespace.c:1433: rc = ndctl_namespace_disable_safe(ndns);
ndctl/namespace.c-1434- if (rc) {
--
ndctl/namespace.c:1457: rc = ndctl_namespace_disable_safe(ndns);
ndctl/namespace.c-1458- if (rc) {
--
ndctl/namespace.c:1480: rc = ndctl_namespace_disable_safe(ndns);
ndctl/namespace.c-1481- if (rc) {
--
ndctl/namespace.c:2215:                                 rc =
ndctl_namespace_disable_safe(ndns);
ndctl/namespace.c-2216-                                 if (rc == 0)
--
ndctl/region.c:72:                      rc = ndctl_namespace_disable_safe(ndns);
ndctl/region.c-73-                      if (rc)


> It also can return correct number which not count in seed device.
> But there will be no error msg when I disable seed device.
> It will make user confuse.
> Eg.
> root@ubuntu-red:~/git/ndctl# ndctl/ndctl disable-namespace namespce0.0 
> disabled 0 namespace

Why is that confusing isn't the namespace already disabled?

>
> So I follow enable-namespace to return -ENXIO and it will look like 
> root@ubuntu-red:~/git/ndctl# ndctl/ndctl disable-namespace namespce0.0 
> error disabling namespaces: No such device or address disabled 0 
> namespaces
>
> But no matter return -ENXIO or 1, it will make test/create.sh fail. 
> This is why I modify region.c

region.c and several other places need to be updated. I would split this into 2 patches.

The first patch updates all callers of ndctl_disable_namespace_safe() to treat rc > 0 as success.

Then the second patch can treat cmd_disable_namespace() to not count rc > 0 as error, but also don't count it as disabled.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5666F2DBE96
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 11:25:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10076100EC1E7;
	Wed, 16 Dec 2020 02:25:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 190CB100EC1E3
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 02:25:52 -0800 (PST)
IronPort-SDR: fVOGbTIwxC+60cN/poDA8lfdQhm6rLQDONpr3ehMayCdmz7lCr0XF2zc26+H0QGiqY5IiRpZLD
 tPgSJ5Xa0BiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="239136704"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400";
   d="scan'208";a="239136704"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 02:25:52 -0800
IronPort-SDR: gEgTlGRPJMxIYxy1e15VatTADcnXUgSGd4hSDcCjIIuVfAExoM/YFKkZ5kKv7wC5G7XwuHuBxk
 yyd0ze1Kzzrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400";
   d="scan'208";a="557302485"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2020 02:25:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Dec 2020 02:25:52 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Dec 2020 02:25:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Dec 2020 02:25:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 16 Dec 2020 02:25:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxONTSU9upY2T1jSoFizwlU6W2w2UqkAG31noU7ca7La+/KIslIMYhCnr7ESHva1YJfRaxpdNoLp0/Gl/5gV4XWh0Vb5fBY4TfFZlJt1wgtnV6rHf1spxUb3CJeDfA2fmDwunVL1kCgjn+A38KRg+pzfc7QArobYNVVgahNFVXJHwAxfdwfq8fmGgvOuqmBrfLNjo/Sya8sK2QNbYJbfZcoUQZGCpIyEOZlCE4+GZiZm+uoEOXR5fRQUctJD2DAgDbIB4yuop4eXZEnck1YdqBDGH+lJOFRGiI84OPJ5vLWNgjycvADclD3kPDZelZMkW0FTgimsgxc3lEc27MD8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ukw5URrevdzvcQJkliH8Urv50re1nA/GdIN2PFrp6k=;
 b=F07lx/o4yfWq4QviL5keCPaQI2Y0aEZ5RIhbtyk8ZkHemEfx7R9//TYQlWJZ5+odx4FHjlrL8moUGRybo8TIMFa7s90/s9uGajEEsXgV+uGKKo+k3zsdxBELXSd3C7a1qfMU/1MLTvfJFoEwC5KL9KkyaHGGSrX+kvklhVRlB8UKZ/57o8XaHgHOB9O4DlSlw3KACzFxs+OsmYPlDtaCiI0s5yXLVmfWbZAdl7wbN4DxUri5OUyBCMNg1VVvOBJxGCFAvHmhVOWZEHmlxGX6yWXH5y2XEQxRKyCkf1ZcPgCZygQaGDqXS62zdTmezE8gcTmTEfZEMDNkw/42ULvwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ukw5URrevdzvcQJkliH8Urv50re1nA/GdIN2PFrp6k=;
 b=y4ih7M4J2wSJpHeTneqLDBhRKgjqebEAzeXJR5pN5IKbcbEbSf5HQG5lSFd6dFU7gn0Rfiig289oTS0xAqI1AlYGvjlemBOvRq3jVu9SKBMVmtoHgAyu1PCP1TaFWU+zq4Ahd6eqF0wKoqPG3lMJTw2aUORIJc5eCUkZXCbuy/M=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3350.namprd11.prod.outlook.com (2603:10b6:a03:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Wed, 16 Dec
 2020 10:25:49 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 10:25:49 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>
Subject: Re: [PATCH ndctl v2 10/10] daxctl/test: Add tests for dynamic dax
 regions
Thread-Topic: [PATCH ndctl v2 10/10] daxctl/test: Add tests for dynamic dax
 regions
Thread-Index: AQHWWS/+CocEkUdsuUO3WJ5KKdcmHKkSwLoAgN6XlACACSD1AA==
Date: Wed, 16 Dec 2020 10:25:49 +0000
Message-ID: <da472bf3dd4a8d05cce635146f7a89f95112666b.camel@intel.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
	 <20200713160837.13774-11-joao.m.martins@oracle.com>
	 <5cf76b3d-21db-daf9-dc1d-d38714a9a7c2@oracle.com>
	 <42e0711f-b26b-65af-4f12-efb28b07a096@oracle.com>
In-Reply-To: <42e0711f-b26b-65af-4f12-efb28b07a096@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ca9ffc3-e942-433c-ad94-08d8a1acf56b
x-ms-traffictypediagnostic: BYAPR11MB3350:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB335012E8E75B41C695AE79C8C7C50@BYAPR11MB3350.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c5uNsetcmqux8/2SKRk3ePZ9AKb1aEz3gh63l37M9x1JNEPrvZ8yY3lQIuw8trWBo9DQWLVQNYO6lRdlD+JdPcWGVtGx3a/Oq8jJjEuKT7DFChDg5AzR/xXXgmsr6iAT5Wi/2jei7F0FkFgZkNzPAY8uQ/7NUtP6oKF2aFdVDTTlD+jWk6/6v5NAhjJES628UOPNJPndCuY3zKWMqwEvFbvHKCv/uybJWEx7JHkrLuo0NGqZ201oYuopqGZ8Y9SC//M01GXpH/2WX88x7WErPeHJF0tf5rAA0w7crc1uSQ2JmiNIVGd4x5GqUT98XJXfLmsy8PVrWZjQ0Ph/OKqhrRX+Y9Xmrg4w8GzIInkpgcVGG0/HxwvmqBFtooKHODXrbGuPQjHKkMrxiBQAQIe4+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(53546011)(6506007)(86362001)(6486002)(8676002)(66946007)(8936002)(316002)(66476007)(36756003)(2906002)(4001150100001)(30864003)(66556008)(64756008)(91956017)(76116006)(110136005)(6512007)(186003)(83380400001)(5660300002)(478600001)(71200400001)(26005)(4326008)(66446008)(966005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bHBZNlk2ZjhzRlpSSngwTm9Ma3c3N2lGM3V5dXNoUlMzM1pLY3JNek5Oa3p5?=
 =?utf-8?B?Sm5jVUsxNGhmRkNxZ21qYjNQSWhkOWs3dUwybGhkTDJoV05SeUV5SFEvMEdZ?=
 =?utf-8?B?RVdQMDhtenl5TVNtMmF3S0FFbG9UNENzZGFRNWEvRWR5YnduU2I0VTdRS0FU?=
 =?utf-8?B?RFJuQVZyR2lrTGxiWU5DS1hTYklhUGRNUk5XOTIxeWFJRmorcGw2NkJBVkJk?=
 =?utf-8?B?dmhGZGFzVEZWSDV6MW9UM3oybE9mM0Q3eUF6T3BEY1hza0x4d01nTkRaa2VG?=
 =?utf-8?B?dHA0ZlhCc2FDcTMyaDlwTVQrK3hqbmVuQ3FSVHg0U2h2akpjTFF1dmpLUjF2?=
 =?utf-8?B?U3hQUEI5RWRManlFOExIOUVSMGdSQ1Q5RGtKMDVlMXhXZ3RxbVc3L1g4MXRM?=
 =?utf-8?B?cVJEUlZWdG8vaDJlTSt1TnRGemdyTEhrY0xzbktWaVI2blNZM1drZ1pNanBX?=
 =?utf-8?B?c2JGMTVJNllaK0J4WkNSUjFxQjU1WEhqa20zSS9vZ0tISG1IYnNxU1ptclVy?=
 =?utf-8?B?SEtuRzVQZE5SbThaNVVoanQzcjdnNldFR2pIV0k4SkpvVUs5WG1MMVBMMkc1?=
 =?utf-8?B?RU9RMDZONG5QT1ExcFVMNjh0WGpxMG1pZFZYUitwNVNWRXMwSFJHbWNPUHh4?=
 =?utf-8?B?ZnUyYnZzUVpEN3Z0NWMxQk9jd3NsRFk1MWQrNStkcTVwUmwvMytLcndCUk03?=
 =?utf-8?B?cXZCdkdjdVVOZHh1OUtzYm8rUHJJRGsrb1d2NHdLQXFMT3NsR2Rqb2R3VUc3?=
 =?utf-8?B?emluNXdlVGlNR053YlBKbFdFazdvWVdqL0x2Vkt0Nkl1anp6ZkZVTHprZitW?=
 =?utf-8?B?T1hlUHdjUjNZZ0xsYzFKSG5EMFdaeFlDc2xGa0VqbDdmTnExeU5hLzlxQ1Va?=
 =?utf-8?B?WWpZckd4TFpqMHAvaEFGWHdSWThOcWJXVkdwcEJKVTltbkZNbm9wZk9TN1Ey?=
 =?utf-8?B?blFVcmRhUXZLa0tvdXBKYUZxM3RnNWJ2UzdEWHpQU0dlbzc2S2N5TVlHK01n?=
 =?utf-8?B?cThPU3BVZVdpS1p4eXBXd0hsNDZQNFVGZ1RYMFpZdzhORWJEdHNjSHZlVVdr?=
 =?utf-8?B?TDZGempkelFyUWZqRnRySCtTckVlQ09Xd0ZDL3g2YXBQQ09yWTlYZndjS0JN?=
 =?utf-8?B?a1JZdEZQdDVyUitYYlI5U2VlcnVPZDNGM3NDQzhmRzdpS3VHWGpYN1k1U2ls?=
 =?utf-8?B?RXJFN2R5NjZKWUFrRmN4WnRXb2t1U0RFLzJRMTRHdzJwQ3JWNVJISHArTWxk?=
 =?utf-8?B?eVNqSlNna1B5Skl1djBET1MweE9jQS9RWFZzdC9qQUlUd0Z6a0dKM2tYS0Vm?=
 =?utf-8?Q?ff5nSUCUvoDoOGgERB5hE/aaWTrZt2c+Kr?=
Content-ID: <E714291A4F9FAF43B7BA4E1A47E383B1@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca9ffc3-e942-433c-ad94-08d8a1acf56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 10:25:49.5377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsVrvy7qdgDOTfS0iZk4xxU/3Gxr9JpQIuHKXpOl8ncbMp1/N4VTHX0LAon2VgjMFZZ8/6Cs/gfIpYaBuKh/5P7JtgOdbc64ZE7AKKNTgyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3350
X-OriginatorOrg: intel.com
Message-ID-Hash: URDBBK7M32LTHVQDCCPBCTWZUIMKYE7K
X-Message-ID-Hash: URDBBK7M32LTHVQDCCPBCTWZUIMKYE7K
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/URDBBK7M32LTHVQDCCPBCTWZUIMKYE7K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-12-10 at 15:01 +0000, Joao Martins wrote:
> On 7/21/20 5:49 PM, Joao Martins wrote:
> > On 7/13/20 5:08 PM, Joao Martins wrote:
> > > Add a couple tests which exercise the new sysfs based
> > > interface for Soft-Reserved regions (by EFI/HMAT, or
> > > efi_fake_mem).
> > > 
> > > The tests exercise the daxctl orchestration surrounding
> > > for creating/disabling/destroying/reconfiguring devices.
> > > Furthermore it exercises dax region space allocation
> > > code paths particularly:
> > > 
> > >  1) zeroing out and reconfiguring a dax device from
> > >  its current size to be max available and back to initial
> > >  size
> > > 
> > >  2) creates devices from holes in the beginning,
> > >  middle of the region.
> > > 
> > >  3) reconfigures devices in a interleaving fashion
> > > 
> > >  4) test adjust of the region towards beginning and end
> > > 
> > > The tests assume you pass a valid efi_fake_mem parameter
> > > marked as EFI_MEMORY_SP e.g.
> > > 
> > > 	efi_fake_mem=112G@16G:0x40000
> > > 
> > > Naturally it bails out from the test if hmem device driver
> > > isn't loaded or builtin. If hmem regions are found, only
> > > region 0 is used, and the others remain untouched.
> > > 
> > > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > 
> > Following your suggestion[0], I added a couple more validations
> > to this test suite, covering the mappings. So on top of this patch
> > I added the following snip below the scissors mark. Mainly, I check
> > that the size calculated by mappingNNNN is the same as advertised by
> > the sysfs size attribute, thus looping through all the mappings.
> > 
> > Perhaps it would be enough to have just such validation in setup_dev()
> > to catch the bug in [0]. But I went ahead and also validated the test
> > cases where a certain amount of mappings are meant to be created.
> > 
> > My only worry is the last piece in daxctl_test_adjust() where we might
> > be tying too much on how a kernel version picks space from the region;
> > should this logic change in an unforeseeable future (e.g. allowing space
> > at the beginning to be adjusted). Otherwise, if this no concern, let me
> > know and I can resend a v3 with the adjustment below.
> > 
> 
> Ping?

Hi Joao,

Thanks for the patience on these, I've gone through the patches in
preparation for the next release, and they all look mostly fine. I had a
few minor fixups - to the documentation and the test (fixup module name,
and shellcheck complaints). I've appended a diff below of all the fixups
I added.

I've also included the patch below for the mapping size validation. I
think the concern for future kernel layout changes is valid, but if/when
that happens, we can always come back and relax or adjust the test as
needed. So for now, I think having a pickier test should be better than
not having one.

> 
> > ----->8------
> > Subject: Validate @size versus mappingX sizes
> > 
> > [0]
> > https://lore.kernel.org/linux-nvdimm/CAPcyv4hFS7JS9s7cUY=2Ru2kUTRsesxwX1PGnnc_tudJjoDUGw@mail.gmail.com/
> > 
> > ---
> > 
> >  test/daxctl-create.sh | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 63 insertions(+), 1 deletion(-)
> > 

My fixups:

---

Documentation/daxctl/daxctl-create-device.txt      | 18 +++-----------
 Documentation/daxctl/daxctl-destroy-device.txt     | 22 ++++--------------
 Documentation/daxctl/daxctl-disable-device.txt     | 22 ++++--------------
 Documentation/daxctl/daxctl-enable-device.txt      | 22 ++++--------------
 Documentation/daxctl/daxctl-reconfigure-device.txt | 19 ++++-----------
 Documentation/daxctl/human-option.txt              |  8 +++++++
 Documentation/daxctl/region-option.txt             |  8 +++++++
 Documentation/daxctl/verbose-option.txt            |  5 ++++
 util/filter.c                                      |  2 +-
 test/daxctl-create.sh                              | 76 ++++++++++++++++++++++++++++++------------------------------
 10 files changed, 82 insertions(+), 120 deletions(-)

---

diff --git a/Documentation/daxctl/daxctl-create-device.txt b/Documentation/daxctl/daxctl-create-device.txt
index 648d254..70029ab 100644
--- a/Documentation/daxctl/daxctl-create-device.txt
+++ b/Documentation/daxctl/daxctl-create-device.txt
@@ -71,12 +71,7 @@ EFI memory map with EFI_MEMORY_SP. The resultant ranges mean that it's
 
 OPTIONS
 -------
--r::
---region=::
-	Restrict the operation to devices belonging to the specified region(s).
-	A device-dax region is a contiguous range of memory that hosts one or
-	more /dev/daxX.Y devices, where X is the region id and Y is the device
-	instance id.
+include::region-option.txt[]
 
 -s::
 --size=::
@@ -87,16 +82,9 @@ OPTIONS
 
 	The size must be a multiple of the region alignment.
 
--u::
---human::
-	By default the command will output machine-friendly raw-integer
-	data. Instead, with this flag, numbers representing storage size
-	will be formatted as human readable strings with units, other
-	fields are converted to hexadecimal strings.
+include::human-option.txt[]
 
--v::
---verbose::
-	Emit more debug messages
+include::verbose-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/daxctl/daxctl-destroy-device.txt b/Documentation/daxctl/daxctl-destroy-device.txt
index 1c91cb2..a63ab0c 100644
--- a/Documentation/daxctl/daxctl-destroy-device.txt
+++ b/Documentation/daxctl/daxctl-destroy-device.txt
@@ -38,23 +38,11 @@ Destroys a dax device in 'devdax' mode.
 
 OPTIONS
 -------
--r::
---region=::
-	Restrict the operation to devices belonging to the specified region(s).
-	A device-dax region is a contiguous range of memory that hosts one or
-	more /dev/daxX.Y devices, where X is the region id and Y is the device
-	instance id.
-
--u::
---human::
-	By default the command will output machine-friendly raw-integer
-	data. Instead, with this flag, numbers representing storage size
-	will be formatted as human readable strings with units, other
-	fields are converted to hexadecimal strings.
-
--v::
---verbose::
-	Emit more debug messages
+include::region-option.txt[]
+
+include::human-option.txt[]
+
+include::verbose-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/daxctl/daxctl-disable-device.txt b/Documentation/daxctl/daxctl-disable-device.txt
index 383aeeb..ee9f6e8 100644
--- a/Documentation/daxctl/daxctl-disable-device.txt
+++ b/Documentation/daxctl/daxctl-disable-device.txt
@@ -33,23 +33,11 @@ Disables a dax device in 'devdax' mode.
 
 OPTIONS
 -------
--r::
---region=::
-	Restrict the operation to devices belonging to the specified region(s).
-	A device-dax region is a contiguous range of memory that hosts one or
-	more /dev/daxX.Y devices, where X is the region id and Y is the device
-	instance id.
-
--u::
---human::
-	By default the command will output machine-friendly raw-integer
-	data. Instead, with this flag, numbers representing storage size
-	will be formatted as human readable strings with units, other
-	fields are converted to hexadecimal strings.
-
--v::
---verbose::
-	Emit more debug messages
+include::region-option.txt[]
+
+include::human-option.txt[]
+
+include::verbose-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/daxctl/daxctl-enable-device.txt b/Documentation/daxctl/daxctl-enable-device.txt
index 6410d92..24cdcf3 100644
--- a/Documentation/daxctl/daxctl-enable-device.txt
+++ b/Documentation/daxctl/daxctl-enable-device.txt
@@ -34,23 +34,11 @@ Enables a dax device in 'devdax' mode.
 
 OPTIONS
 -------
--r::
---region=::
-	Restrict the operation to devices belonging to the specified region(s).
-	A device-dax region is a contiguous range of memory that hosts one or
-	more /dev/daxX.Y devices, where X is the region id and Y is the device
-	instance id.
-
--u::
---human::
-	By default the command will output machine-friendly raw-integer
-	data. Instead, with this flag, numbers representing storage size
-	will be formatted as human readable strings with units, other
-	fields are converted to hexadecimal strings.
-
--v::
---verbose::
-	Emit more debug messages
+include::region-option.txt[]
+
+include::human-option.txt[]
+
+include::verbose-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
index 8caae43..9a11ff5 100644
--- a/Documentation/daxctl/daxctl-reconfigure-device.txt
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -121,12 +121,7 @@ refrain from then onlining it.
 
 OPTIONS
 -------
--r::
---region=::
-	Restrict the operation to devices belonging to the specified region(s).
-	A device-dax region is a contiguous range of memory that hosts one or
-	more /dev/daxX.Y devices, where X is the region id and Y is the device
-	instance id.
+include::region-option.txt[]
 
 -s::
 --size=::
@@ -161,16 +156,10 @@ include::movable-options.txt[]
 	to offline the memory on the NUMA node associated with the dax device
 	before converting it back to "devdax" mode.
 
--u::
---human::
-	By default the command will output machine-friendly raw-integer
-	data. Instead, with this flag, numbers representing storage size
-	will be formatted as human readable strings with units, other
-	fields are converted to hexadecimal strings.
 
--v::
---verbose::
-	Emit more debug messages
+include::human-option.txt[]
+
+include::verbose-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/daxctl/human-option.txt b/Documentation/daxctl/human-option.txt
new file mode 100644
index 0000000..2f4de7a
--- /dev/null
+++ b/Documentation/daxctl/human-option.txt
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+-u::
+--human::
+	By default the command will output machine-friendly raw-integer
+	data. Instead, with this flag, numbers representing storage size
+	will be formatted as human readable strings with units, other
+	fields are converted to hexadecimal strings.
diff --git a/Documentation/daxctl/region-option.txt b/Documentation/daxctl/region-option.txt
new file mode 100644
index 0000000..a824e22
--- /dev/null
+++ b/Documentation/daxctl/region-option.txt
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+-r::
+--region=::
+	Restrict the operation to devices belonging to the specified region(s).
+	A device-dax region is a contiguous range of memory that hosts one or
+	more /dev/daxX.Y devices, where X is the region id and Y is the device
+	instance id.
diff --git a/Documentation/daxctl/verbose-option.txt b/Documentation/daxctl/verbose-option.txt
new file mode 100644
index 0000000..cb62c8e
--- /dev/null
+++ b/Documentation/daxctl/verbose-option.txt
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+-v::
+--verbose::
+	Emit more debug messages
diff --git a/util/filter.c b/util/filter.c
index 7c8debb..8c78f32 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -342,7 +342,7 @@ struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
 		return region;
 
 	if ((sscanf(ident, "%d", &region_id) == 1
-				|| sscanf(ident, "region%d", &region_id) == 1)
+			|| sscanf(ident, "region%d", &region_id) == 1)
 			&& daxctl_region_get_id(region) == region_id)
 		return region;
 
diff --git a/test/daxctl-create.sh b/test/daxctl-create.sh
index 8dbc00f..a4fbe06 100755
--- a/test/daxctl-create.sh
+++ b/test/daxctl-create.sh
@@ -20,8 +20,8 @@ find_testdev()
 
 	# The hmem driver is needed to change the device mode, only
 	# kernels >= v5.6 might have it available. Skip if not.
-	if ! modinfo hmem; then
-		# check if hmem is builtin
+	if ! modinfo dax_hmem; then
+		# check if dax_hmem is builtin
 		if [ ! -d "/sys/module/device_hmem" ]; then
 			printf "Unable to find hmem module\n"
 			exit $rc
@@ -66,7 +66,7 @@ reset_dev()
 	test -n "$testdev"
 
 	"$DAXCTL" disable-device "$testdev"
-	"$DAXCTL" reconfigure-device -s $available "$testdev"
+	"$DAXCTL" reconfigure-device -s "$available" "$testdev"
 	"$DAXCTL" enable-device "$testdev"
 }
 
@@ -76,7 +76,7 @@ reset()
 
 	"$DAXCTL" disable-device -r 0 all
 	"$DAXCTL" destroy-device -r 0 all
-	"$DAXCTL" reconfigure-device -s $available "$testdev"
+	"$DAXCTL" reconfigure-device -s "$available" "$testdev"
 }
 
 clear_dev()
@@ -91,8 +91,8 @@ test_pass()
 
 	# Available size
 	_available_size=$("$DAXCTL" list -r 0 | jq -er '.[0].available_size | .//""')
-	if [[ ! $_available_size == $available ]]; then
-		printf "Unexpected available size $_available_size != $available\n"
+	if [[ ! $_available_size == "$available" ]]; then
+		echo "Unexpected available size $_available_size != $available"
 		exit "$rc"
 	fi
 }
@@ -103,7 +103,7 @@ fail_if_available()
 
 	_size=$("$DAXCTL" list -r 0 | jq -er '.[0].available_size | .//""')
 	if [[ $_size ]]; then
-		printf "Unexpected available size $_size\n"
+		echo "Unexpected available size $_size"
 		exit "$rc"
 	fi
 }
@@ -124,8 +124,8 @@ daxctl_get_size_by_mapping()
 	local _start=0
 	local _end=0
 
-	_start=$(cat $1/start)
-	_end=$(cat $1/end)
+	_start=$(cat "$1"/start)
+	_end=$(cat "$1"/end)
 	((size=size + _end - _start + 1))
 	echo $size
 }
@@ -138,10 +138,10 @@ daxctl_get_nr_mappings()
 	local path=""
 
 	path=$(readlink -f /sys/bus/dax/devices/"$1"/)
-	until ! [ -d $path/mapping$i ]
+	until ! [ -d "$path/mapping$i" ]
 	do
 		_size=$(daxctl_get_size_by_mapping "$path/mapping$i")
-		if [[ $msize == 0 ]]; then
+		if [[ $_size == 0 ]]; then
 			i=0
 			break
 		fi
@@ -151,8 +151,8 @@ daxctl_get_nr_mappings()
 
 	# Return number of mappings if the sizes between size field
 	# and the one computed by mappingNNN are the same
-	_size=$("$DAXCTL" list -d $1 | jq -er '.[0].size | .//""')
-	if [[ ! $_size == $devsize ]]; then
+	_size=$("$DAXCTL" list -d "$1" | jq -er '.[0].size | .//""')
+	if [[ ! $_size == "$devsize" ]]; then
 		echo 0
 	else
 		echo $i
@@ -163,7 +163,7 @@ daxctl_test_multi()
 {
 	local daxdev
 
-	size=$(expr $available / 4)
+	size=$((available / 4))
 
 	if [[ $2 ]]; then
 		"$DAXCTL" disable-device "$testdev"
@@ -171,24 +171,24 @@ daxctl_test_multi()
 	fi
 
 	daxdev_1=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
-	test -n $daxdev_1
+	test -n "$daxdev_1"
 
 	daxdev_2=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
-	test -n $daxdev_2
+	test -n "$daxdev_2"
 
 	if [[ ! $2 ]]; then
 		daxdev_3=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
-		test -n $daxdev_3
+		test -n "$daxdev_3"
 	fi
 
 	# Hole
-	"$DAXCTL" disable-device  $1 &&	"$DAXCTL" destroy-device  $1
+	"$DAXCTL" disable-device  "$1" && "$DAXCTL" destroy-device "$1"
 
 	# Pick space in the created hole and at the end
-	new_size=$(expr $size \* 2)
-	daxdev_4=$("$DAXCTL" create-device -r 0 -s $new_size | jq -er '.[].chardev')
-	test -n $daxdev_4
-	test $(daxctl_get_nr_mappings $daxdev_4) -eq 2
+	new_size=$((size * 2))
+	daxdev_4=$("$DAXCTL" create-device -r 0 -s "$new_size" | jq -er '.[].chardev')
+	test -n "$daxdev_4"
+	test "$(daxctl_get_nr_mappings "$daxdev_4")" -eq 2
 
 	fail_if_available
 
@@ -201,7 +201,7 @@ daxctl_test_multi_reconfig()
 	local ncfgs=$1
 	local daxdev
 
-	size=$(expr $available / $ncfgs)
+	size=$((available / ncfgs))
 
 	test -n "$testdev"
 
@@ -212,19 +212,19 @@ daxctl_test_multi_reconfig()
 	daxdev_1=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
 	"$DAXCTL" disable-device "$daxdev_1"
 
-	start=$(expr $size + $size)
-	max=$(expr $ncfgs / 2 \* $size)
+	start=$((size + size))
+	max=$((size * ncfgs / 2))
 	for i in $(seq $start $size $max)
 	do
 		"$DAXCTL" disable-device "$testdev"
-		"$DAXCTL" reconfigure-device -s $i "$testdev"
+		"$DAXCTL" reconfigure-device -s "$i" "$testdev"
 
 		"$DAXCTL" disable-device "$daxdev_1"
-		"$DAXCTL" reconfigure-device -s $i "$daxdev_1"
+		"$DAXCTL" reconfigure-device -s "$i" "$daxdev_1"
 	done
 
-	test $(daxctl_get_nr_mappings $testdev) -eq $((ncfgs / 2))
-	test $(daxctl_get_nr_mappings $daxdev_1) -eq $((ncfgs / 2))
+	test "$(daxctl_get_nr_mappings "$testdev")" -eq $((ncfgs / 2))
+	test "$(daxctl_get_nr_mappings "$daxdev_1")" -eq $((ncfgs / 2))
 
 	fail_if_available
 
@@ -237,15 +237,15 @@ daxctl_test_adjust()
 	local ncfgs=4
 	local daxdev
 
-	size=$(expr $available / $ncfgs)
+	size=$((available / ncfgs))
 
 	test -n "$testdev"
 
-	start=$(expr $size + $size)
+	start=$((size + size))
 	for i in $(seq 1 1 $ncfgs)
 	do
-		daxdev=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
-		test $(daxctl_get_nr_mappings $daxdev) -eq 1
+		daxdev=$("$DAXCTL" create-device -r 0 -s "$size" | jq -er '.[].chardev')
+		test "$(daxctl_get_nr_mappings "$daxdev")" -eq 1
 	done
 
 	daxdev=$(daxctl_get_dev "dax0.1")
@@ -255,18 +255,18 @@ daxctl_test_adjust()
 
 	daxdev=$(daxctl_get_dev "dax0.2")
 	"$DAXCTL" disable-device "$daxdev"
-	"$DAXCTL" reconfigure-device -s $(expr $size \* 2) "$daxdev"
+	"$DAXCTL" reconfigure-device -s $((size * 2)) "$daxdev"
 	# Allocates space at the beginning: expect two mappings as
 	# as don't adjust the mappingX region. This is because we
 	# preserve the relative page_offset of existing allocations
-	test $(daxctl_get_nr_mappings $daxdev) -eq 2
+	test "$(daxctl_get_nr_mappings "$daxdev")" -eq 2
 
 	daxdev=$(daxctl_get_dev "dax0.3")
 	"$DAXCTL" disable-device "$daxdev"
-	"$DAXCTL" reconfigure-device -s $(expr $size \* 2) "$daxdev"
+	"$DAXCTL" reconfigure-device -s $((size * 2)) "$daxdev"
 	# Adjusts space at the end, expect one mapping because we are
 	# able to extend existing region range.
-	test $(daxctl_get_nr_mappings $daxdev) -eq 1
+	test "$(daxctl_get_nr_mappings "$daxdev")" -eq 1
 
 	fail_if_available
 
@@ -293,7 +293,7 @@ daxctl_test1()
 	daxdev=$("$DAXCTL" create-device -r 0 | jq -er '.[].chardev')
 
 	test -n "$daxdev"
-	test $(daxctl_get_nr_mappings $daxdev) -eq 1
+	test "$(daxctl_get_nr_mappings "$daxdev")" -eq 1
 	fail_if_available
 
 	"$DAXCTL" disable-device "$daxdev" && "$DAXCTL" destroy-device "$daxdev"

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F9365CB2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 17:55:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFE06100F2275;
	Tue, 20 Apr 2021 08:55:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=robert.moore@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D85C6100F2270
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 08:54:57 -0700 (PDT)
IronPort-SDR: vO9ArK8NO7b2hmeq7fy7SpWLfqlC5uE74x2fGrMHaXKSxMeibU/6zlxt6Gm4Pwizc5mKVgujwZ
 o8MoqJVlkM+w==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195646090"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400";
   d="scan'208";a="195646090"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:54:55 -0700
IronPort-SDR: LTF9RTsSTymexx0QocH/3bZ8vcj1Enz+3XFHTy/TydgcQ0X0C8zvJkUQxckA+8iyKo8eQk9Ukf
 J6exfGVq3Dvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400";
   d="scan'208";a="385376903"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 20 Apr 2021 08:54:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 08:54:55 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 08:54:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 20 Apr 2021 08:54:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 20 Apr 2021 08:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/bGrNuDfJrohDdp8m5JWl0hZyFEgQMRIRlw8h4RifNFtNu+rrevwNPOX8jzk9qwQ3X5yZefj1o4dSPZbxQW/GO2ZoDAGApywmCIPpmxvn1g3447f2MgUDsujx6ci72AYJQ4iiXNc3YDSvGT9OZC1DlPqGVK5XB2ERwDxUSbm7c2zbkY7IIuaufbq3GO0G3XO/bVhywKEnri1tkarUYJYDyh4f9JAEc4pEYn6/ChEY17HZmZqh6oGXVZ9J1wrtA1cHzhWqwHwEQr3XslT3Ek4UH0QnFJXFY5iqt5e3S99EYBVc1xqTlD6/lJUWGowCoGmezEtYAIpRWO+HRHjcClTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe4cCrenEFYIzfeo/GKbHy2z3Ao8hM/3y+LqpO6P5j0=;
 b=IF5D6EOEiVjTrYHQzsaE/q2Wz8SnhxYDW5/6KekKXmmSF4oexSBJObiKAbGUSI9w/GN+WjnXN0qkUX6ZdO9E0TZJh7R36kUTB9gB1wv1JD+2e2V78+X7gc/22ylcLZRYuP1dd54si+tw7QeXFqQa/Ye2/j/Lc4a6KkOFV0f+jv13dlVbE+AA+ju+QVTKA5zgp6ofPFcOAg4bTe+NiOQp8knX7NveVaDncjuMPMQ5FQ5AXMs6k6DOYZziSmmP0Fe5ky8OZQxqJoE5yFKJxpxWVAhYW4ctpX1zeL98dK068+NBT2203jncJuZNpxRTniIuEUojrLSnMBFm/c5nZR9iKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe4cCrenEFYIzfeo/GKbHy2z3Ao8hM/3y+LqpO6P5j0=;
 b=bB6mzj3iN5sZihCseTZ5fKDPubIbwwUS/fCO8Fbk/G8sn5AOGqfbN6eDpoTkXmnTG5TOh1hq+Q5KKkrw1+sG1LbU/oOPYXT+AzjW5i33jVETtkHTKgxPewRJYrvJrnT2jg4rV4a+K6jagXnVYwwOk0TN6FkVg5A7+ml8gNxbO3o=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5134.namprd11.prod.outlook.com (2603:10b6:a03:2de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Tue, 20 Apr
 2021 15:54:49 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::41e6:b61:67ef:2712]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::41e6:b61:67ef:2712%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 15:54:49 +0000
From: "Moore, Robert" <robert.moore@intel.com>
To: "Kaneda, Erik" <erik.kaneda@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>
Subject: RE: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Thread-Topic: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Thread-Index: AQHXMvxos6/G1E0Lb0im/q88amHNoKq3m/kAgAAYKgCABMAQMIABIANw
Date: Tue, 20 Apr 2021 15:54:48 +0000
Message-ID: <BYAPR11MB3256014ACBE12F02D6738F0287489@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
 <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
 <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
 <YHn2oiP+2YpkFGXQ@smile.fi.intel.com>
 <CAPcyv4g=XyFfDZYL-brAO7LTVEc90=x7aQWar_WZtfnPx09UVQ@mail.gmail.com>
 <CY4PR11MB1590FE3E5B4AC80972BD253AF0499@CY4PR11MB1590.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB1590FE3E5B4AC80972BD253AF0499@CY4PR11MB1590.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b2d3087-b362-429c-6230-08d90414a0b0
x-ms-traffictypediagnostic: SJ0PR11MB5134:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB51349478840064430DE7C8BF87489@SJ0PR11MB5134.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zYp4LMQ6jtqqSP0FNNuV57m4zUAZOienxn4e5m+CntO/z9mE60ijbyNwVrgS9lC8gsxwWRWgRNeYIC2RCUJSFS+IgK/csMbIEiIff61Ypb3lH+ok4afLI9x/bY1jQOIurqmyuSRzHM722z9/m7vz1Y75bjb+UJdxlKg78bfIe22bWhnitwmwXXNDlxwzUx6/zHRM3uFydwgsVNFCca3UYQ4rET3guOBEJ0r8Xh9tzJJHLDCpSpiThw30TBLqWEx8MXzwLoZf4/nNnTwcfi7OafxU5gVFUCuFvHlC+yV54gXK095Wss21kc4Mj47grwxheYqPV2uF7VebJRN5KDPHnkR+R+zQlwUKL+6uL3goHi+ghGmzU1os/GyCCcHP14pQzenpVgM82vSfatJ1zf8t2dwihTSyoVl7HGgqHxeBeonN084S3W6NLxb1uHfLi8Ejn4arYx36GLH6rYbZ4DQZ3zy2qqrMK3DcFTfSD2SqlygCGHOS2ZALC2/bFqBNsuMLF/rrAu71bJxYTTtCSpel1wSoTuWl/vKUr/nhkl1WcgJz+psNV1gEd5yKkS7aCR/Du6yhWnTXEZR6RxgpX7jzqHzPWFuy7aS/CxwXjiSit70=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(8936002)(478600001)(53546011)(8676002)(76116006)(38100700002)(7696005)(5660300002)(66476007)(66946007)(6636002)(6506007)(110136005)(54906003)(71200400001)(186003)(122000001)(316002)(26005)(2906002)(86362001)(55016002)(66446008)(83380400001)(66556008)(33656002)(64756008)(4326008)(9686003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N0hFeVMydDBmV0MwVTcwU0tvazQwT0FYcDVOOStxbnpNQ1ZIZWRqYjRNb1J1?=
 =?utf-8?B?bHp6dEJhbWlBREJjUW5tUnRJcEtReVlBNlVJcXhKb2Urd2x6LzhlMWI2K1Bk?=
 =?utf-8?B?ZS9KL2QyTWVYUG82aHlDUXZjSkdSSU1Rd1F0MWVVWlVLT2d0TWNBMHh0N1hB?=
 =?utf-8?B?Z21ZN2V3eDNSNkR5Q1d0M3kwL1RPaWJsVElEcmVlMFJ1RVhQWkh3MTF2WmZn?=
 =?utf-8?B?a09xT0M1ZERWeVoxbWw1b0NhSkR1MGV2ejhyOGczaktlcmtUUGRIYkpJMXZh?=
 =?utf-8?B?d2FQUExUSDROaGQ2WGxjSkl6TVJFUjhFSkpNNG5IdXZ5b1p6RjU1eGlUK0Y2?=
 =?utf-8?B?YkkwcG1qNUFiWDFZbDV2eHo4SGVRRENmd01ja29iTmtRdjlOeEZzSDA4ODE2?=
 =?utf-8?B?TFR4aE12dTNBeUxOSC96YlIvSnA3U3kxM29ySzhiS2hSMy9oZEwwcW14NGlV?=
 =?utf-8?B?NS9tdloxT29uQW1XajRxdVpHRmxNMUsvWGpNT2Y4TGFsdmozQXg1SW12Wndm?=
 =?utf-8?B?QnZlNDJTWXBEUXVSVXVrbElOWnZQTmRJOTU3dWVIb2Jldm8waGowbkcvSlNK?=
 =?utf-8?B?ZlQ1ckRDSUhnNFNSazh4UVQ2RktTanZCRmh0dHhhd2RVcHo1c3FReGkvM1d1?=
 =?utf-8?B?OUdpUlV3SHRvTnQ3dXRZZTRndnorMmp2U1RxMXA0dGhhQWR3cVZoZ1RBd2hY?=
 =?utf-8?B?UGp5YWt6dTA5R2w0Lzl4bXZ2UlhLem5uVGFCMHFsSTFCQ1dlSWo1K2dxR0pw?=
 =?utf-8?B?ZzNoOFRsYU5HMVFEeGZJRnN4N3UxbjdQUzArZncwNGxYa0p2MDhBRm55Uzlp?=
 =?utf-8?B?MTlMN1FBMWpISHhxclNyb2xrcUxPRzJyT2syVWlPSVRzdkpaVGEyM0JzcFdZ?=
 =?utf-8?B?Z25sSXlTNlIwNHhXU1U1NUpMYXRoenZnRXFPQStHcWQ3dDI4WmFQT2RsNGxU?=
 =?utf-8?B?ZXlERmZJaXFYUDZjSTFhTTdHeFlOWGdadnlCZUhDcG9zTXFRR2FLd1pPQjZx?=
 =?utf-8?B?NkpFQ29oS2wzL3FZREwrZWxrNTB0dm1tVHp1cWR3ZXN5bnc1QWdzM3F5ME4x?=
 =?utf-8?B?b1lFY2RWcHJOWUhLKzlQVzAxSmd3bk1BZWF2L2lWcEptcXVQQitiOWZ0Rk4w?=
 =?utf-8?B?Q1g2cDJtUmFmZngzd29wdWxESnYrRVdPeDlBbmFpTTRHbDB2aHdTRExrUzF1?=
 =?utf-8?B?RnhaUUxEcnQrYU5YakF4SUxqVDVXTUJKampXeUJBOWd6ZE90RVpFSytVT3Yr?=
 =?utf-8?B?b3FCRDl3TUIzVzBuWjVrRmx4RWlhaWh2dEpSU2k4VDZ5UHE2N0pKaHZJNXZW?=
 =?utf-8?B?UnNLUVJoQWxtUTZzcU01VGM3c09TMlVxVHdKSlY3MDM3WWMyUzRIZ3lISysw?=
 =?utf-8?B?VlgwVHFwYktZY3FOcWtvbEowMnlmVVEwRGM1NDV1YVJDQzlWODM3YXhoRjRh?=
 =?utf-8?B?cTc2a2pxem5SWFg4U0duV2lXdXlFaUJUSVlYU1FIUGluVVpkWENaZkxoSXVW?=
 =?utf-8?B?ZjhTU2hSOHQwSnhWWGpHcnA2U3hYcUN0MzNMU2dGeERUM0VmR3R0SVE2cDRi?=
 =?utf-8?B?dEZzRXdZQW1ZaVRHQVkrRFhIRUpZZVNma3Q3OHRGdGhuWFM4VENmTEkxQUwr?=
 =?utf-8?B?Z2hsSUl4cW5MdDEveUJoQ0I1RHZzdTVCN3VJVVJLaDFhVEFlMGp6Rm1UNHhE?=
 =?utf-8?B?WUpYd0xPdlZxUk05QitXbGJ2NXhVU2J1UjJ0aWdWWGlDSmtJcml2THZ4bzBt?=
 =?utf-8?Q?V79J0QWutBWhPqRqKOC+MnXyCtn2rZCmihpqORf?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2d3087-b362-429c-6230-08d90414a0b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 15:54:48.9448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lk6pY+PhTfHAc1VcbtbA8yWNKH2od5Ec/LhLqHZB9XtEgO2WFYOXuI6GbeTlKlFG0vrD5SjxhmpJVo8fVGauBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5134
X-OriginatorOrg: intel.com
Message-ID-Hash: I4X2RTPYFASUTCH4OJANYQVWCUZBM6KW
X-Message-ID-Hash: I4X2RTPYFASUTCH4OJANYQVWCUZBM6KW
X-MailFrom: robert.moore@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I4X2RTPYFASUTCH4OJANYQVWCUZBM6KW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



-----Original Message-----
From: Kaneda, Erik <erik.kaneda@intel.com> 
Sent: Monday, April 19, 2021 3:56 PM
To: Williams, Dan J <dan.j.williams@intel.com>; Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Moore, Robert <robert.moore@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Verma, Vishal L <vishal.l.verma@intel.com>; Jiang, Dave <dave.jiang@intel.com>; Weiny, Ira <ira.weiny@intel.com>
Subject: RE: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer

+Bob and Rafael

> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Friday, April 16, 2021 3:09 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-nvdimm <linux-nvdimm@lists.01.org>; Linux Kernel Mailing 
> List <linux-kernel@vger.kernel.org>; Verma, Vishal L 
> <vishal.l.verma@intel.com>; Jiang, Dave <dave.jiang@intel.com>; Weiny, 
> Ira <ira.weiny@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>
> Subject: Re: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw 
> buffer
> 
> On Fri, Apr 16, 2021 at 1:42 PM Andy Shevchenko 
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Apr 16, 2021 at 01:08:06PM -0700, Dan Williams wrote:
> > > [ add Erik ]
> > >
> > > On Fri, Apr 16, 2021 at 10:36 AM Andy Shevchenko 
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Thu, Apr 15, 2021 at 05:37:54PM +0300, Andy Shevchenko wrote:
> > > > > Strictly speaking the comparison between guid_t and raw buffer 
> > > > > is not correct. Return to plain memcmp() since the data 
> > > > > structures haven't changed to use uuid_t / guid_t the current 
> > > > > state of affairs is inconsistent. Either it should be changed 
> > > > > altogether or left as is.
> > > >
> > > > Dan, please review this one as well. I think here you may agree with me.
> > >
> > > You know, this is all a problem because ACPICA is using a raw buffer.
> >
> > And this is fine. It might be any other representation as well.
> >
> > > Erik, would it be possible to use the guid_t type in ACPICA? That 
> > > would allow NFIT to drop some ugly casts.
> >
> > guid_t is internal kernel type. If we ever decide to deviate from 
> > the current representation it wouldn't be possible in case a 3rd 
> > party is using it 1:1 (via typedef or so).
> 
Hi Dan,

> I'm thinking something like ACPICA defining that space as a union with 
> the correct typing just for Linux.

I'm assuming that you mean using something like guid_t type for ACPI data table fields like NFIT rather than objects returned by ACPI namespace object such as _DSD.

For ACPI data tables, we could to use macros so that different operating systems can provide their own definitions for a guid. For ACPICA, it will expands to a 16-byte array. Linux can have it's own definition that contains a union or their own guid type (guid_t). As long as the OS-supplied definition is 16bytes, I don't think there would be an issue.

Erik,
I don't like to add these kinds of macros, since it is simply another item that needs to be added to port ACPICA to different hosts. (And must be known by the porter.)

Other than that, I suppose we can add such a macro.

Bob, do you have any thoughts on this?
Erik
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

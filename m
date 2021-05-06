Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C8F375946
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 19:27:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 266C2100EAB54;
	Thu,  6 May 2021 10:27:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=erik.kaneda@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 96092100EAB4C
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 10:27:54 -0700 (PDT)
IronPort-SDR: Vrsla8YkbSaj+Sm+tCwT6B6jeezRr0TqHIqOgJYkB8zlvk2JXmGD2LqG7CD3cESZFH1GFF97ei
 7X99eB0wN+aw==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="198617779"
X-IronPort-AV: E=Sophos;i="5.82,278,1613462400";
   d="scan'208";a="198617779"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 10:27:53 -0700
IronPort-SDR: ziKftrJCrTQSLIgL04v+jEiOaM2DprtYUkv2oyP9mrmHrneB1HVaz6fkvRromfn2mmoRjYgnff
 vVNZxc95Sg4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,278,1613462400";
   d="scan'208";a="407095608"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2021 10:27:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 6 May 2021 10:27:52 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 6 May 2021 10:27:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 6 May 2021 10:27:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 6 May 2021 10:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT2sYEA1E29QDhG/VowEQb5/EE6b4CHsNBqISnxE+h8RqI3OTSkwpsYLsOKU/BQf51B0OULdennq+pZmn9yn8j2KFZaVEbfaBTV0S40iOb7j4y5Qk1f3u4AsIySzVeefBwcRVZOxURBFq+OeGTBWDVOjboOSnuOznzFdiRep/aO4eEvaUGP1pirjEPOP7nz5b3cTToipzLsBMIpKX6ZOgs/wqZ60ohw6ljekdAlcOwothbiyhyHj2yMbZuxIAF2D1KluBv8hO/sl3Hb+2rXXC274q3Ho7VbJq6gRq65OkruVvbqZWu9PoYaRq7TSevIj2lfChv4VwoJcBwCGjGAV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFcdS3KF5t3Z12xtXeWaJHA5j+kFxocVfDU2pfUpqY8=;
 b=EvsW01gp/QZbYJzImRo6KZMB3MPfg1huQQjDSNKz/eOHG0TusHnJ6yL5i9pVfszRSd2Zt5TZ5cHtXMdFPvd/ZEXsoyiqIOguSldAxmeuLkQ/jVG83oBiFjMz1Rps9uNBgs/PI4TwmpBYrvuWVVMcK6JJHAmJ3cLABlqXYRLTLRraHT2ISssC+li3Gv0ecjsjOHHjulHSFm5oquxeKbHE9f83jJzz3+4lHuxHY4AMZ+MTIV9lr8twP90YWR2/+NIh2PUUG9nAO++cTX3jf7dg0DK1jrd64wxdKvhlHU8qrfmszFsscHIjGy1mD1eNA1FAaZgXfgNMvJNd053GmbIyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFcdS3KF5t3Z12xtXeWaJHA5j+kFxocVfDU2pfUpqY8=;
 b=tER5Sm9OlHhGzoaNS3TwiHta+lYwGIUICyRFDvW6cMukngNBrybiF6RPVsFAcLCtaQsZnPr6bqq3s3klFqwM94B0QRH/xVz9VCXzZcX8c2nfdAFhohSoWQS+Ydi2Lm9LOcAYyAkDZQo2k1jHevrckJ59AdBm9P/RwAXW2VRKbX4=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR1101MB2286.namprd11.prod.outlook.com (2603:10b6:301:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Thu, 6 May
 2021 17:27:50 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 17:27:50 +0000
From: "Kaneda, Erik" <erik.kaneda@intel.com>
To: Yi Zhang <yi.zhang@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [bug report] system panic at nfit_get_smbios_id+0x6e/0xf0 [nfit]
 during boot
Thread-Topic: [bug report] system panic at nfit_get_smbios_id+0x6e/0xf0 [nfit]
 during boot
Thread-Index: AQHXQiSsHElpbDh99UKeH3Y66fM1HarWtIJw
Date: Thu, 6 May 2021 17:27:49 +0000
Message-ID: <MWHPR11MB1599C0D93E6535796F3E0F21F0589@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <CAHj4cs9s25EqRhL6_D5Rg_7j14N5UVODJ0ps4=4n7sZ6zE5U3w@mail.gmail.com>
 <CAPcyv4iuA=+aUOgHvYXtg8D_1RSxjrZC4cG2GXVhEZVeQCD5rA@mail.gmail.com>
 <CAHj4cs_Zp85ePses2CxuNyoh5FAObWxOuWGAmmOeZ1KOTQ6msQ@mail.gmail.com>
In-Reply-To: <CAHj4cs_Zp85ePses2CxuNyoh5FAObWxOuWGAmmOeZ1KOTQ6msQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2600:6c55:4c7f:e63f:306c:de08:5ab3:a78d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a82693d-f803-4bc4-6e23-08d910b445e6
x-ms-traffictypediagnostic: MWHPR1101MB2286:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2286B3D42A598B3291CA5554F0589@MWHPR1101MB2286.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yEabCpPnlzaTHFH7lRWxukQgiNAV2rDxpMd4jG/mK8rIDqESeplIUM1z3HC6IVE5B33MaF/uWxjRZ68Ggpaw4WwarauCuYllq215GkT9Ixkrlmwhks0IWudYrN/WTvmjfvgbAmlFWgugl6okL2NNdVv6buV6hPz+KGMHZt/33t4OBmy1Qj2cXDsRdP6YD/c8kyRQtzz5XnZ2nKFCqqDTL+ilZHaQ9JyvuxdvABUmsqAuiZe7XfJkl4WQTvzLXHRKK+VohOC13+ojEAjrSIm+M2bFk7rpzsCINIKl3T62TSYatyJDPQpJaWCGcdDW3kT6ePp3CpCuJnO/R9Xoac2CxREmXEsoj2xU5UqBf+t2FFTOdm21faH8iSRhdFx9UgBDkrMp5AIjjnCApqs8DdjkN9cQPN2SdPnyLkMLZtb4A74fR6kyiEjKUrFeDxJVqhb2e178lzGLUg+wzXbCRNFxpDohPJ4xgaXrbkdvQjkPIa85ZvHLZRq2XyVIQW+3r7zJpS3BYjsL0gon7aN6Ng81+FbgfkUvBt0EczVO/ZpqBLadg1hDkFSq+Mmvp6wPeXeO0+CcqAtoQCxBm4JrAA2qZweRvf+IqWx5UfcELvJdkNO9Fp2P3nltU/KYPEBFcPnuBoQAGtPxopA++laRl8XZZ+RMpudAjArZsRdsxfYVv8iUXu0J3ktGakCo5Y4UnHww
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39860400002)(83380400001)(8676002)(966005)(86362001)(9686003)(55016002)(2906002)(122000001)(186003)(38100700002)(53546011)(110136005)(5660300002)(316002)(33656002)(478600001)(4326008)(66946007)(52536014)(6506007)(8936002)(76116006)(54906003)(66476007)(6636002)(7696005)(64756008)(66556008)(66446008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NUdoOVgvYTB2OUowczlVajFjaUNlNU9SZDhMaWwvb0N6ZGR4NkdESHFoV3BX?=
 =?utf-8?B?T1dEK1FVWVBielQ0aFA5anNwM3p5YW1DS3VCb0FVMmVRcWU1MnVFekFOWXdL?=
 =?utf-8?B?OGVzNVI5a0xnZWpaLzV1ZlI1YTR1SzFmVVoyMHBEc0NlYlBHd3JwNFhtcVZw?=
 =?utf-8?B?WWo1cXFqNEIyalhUY0psL25tS3JYU0hYaG1CSkEzOC9QTlpzZ01PTWlERWxV?=
 =?utf-8?B?Mmxmb1VGVERYaWNidkx6ZklJaENMUE0yb1hnMG5hc3Y1T3VNM1FscHBmYWlU?=
 =?utf-8?B?ZUFjWFplR25SNFd5T3hqWFpIRG1sN3V0R2Nxa1Z6Y3BuclhyK1FMYlN3cThl?=
 =?utf-8?B?R0tySUVSRks4Ky84dU5RRitrSDkyUTF2Zm12bjZ6bXcwcUpHL1VxK2xKRlZl?=
 =?utf-8?B?TDMrMFIwcitjS1hNeHR5RnMwemdNa1NDYjhsdFJpRzFOaXhNckVkYmZYWkNB?=
 =?utf-8?B?Snk3UmszZEtQN2x4d1VoZXBZcDI4Q0tLaHRpZmRpcWl0bnJ0MEduSXkzUGo0?=
 =?utf-8?B?QVpsNXZSOEVYOWpJT3RNaVVYL25LL1M2Z0xINFVVNUcwdy9VV2NLNjJhRmNL?=
 =?utf-8?B?Tk4wTTY3NDlIMCtnalZQbHBqNmlvV3lHTWhieldUQkQ1VDlWUmdySTNHaVk1?=
 =?utf-8?B?VkhJd1UzQmswT3FDdm1RTXNOVCswK3k2M0dRbDE1QXBBVFhJaTBFM1Nqejh2?=
 =?utf-8?B?NFJrakNTQXpnR2FrUkVFUFhxVEowSTVDNktHdlBoNG81V3hMYmxrZFJnWHNU?=
 =?utf-8?B?dTk2ZUxxcDQ0WVE4Y3NiS0JXTk1jbnU1YVdOcXR1ZTlXZGIwWjlBYWIyNTdj?=
 =?utf-8?B?enc3NWFUbXJSRjdwbXFyZXpwdGVPOFhzZ3NOeFoySlpuSGdLSm9Bc2loajZO?=
 =?utf-8?B?VDRDZmM1bkJKa1FodWNwMzJSVWNoaHM2N2tVY0RGK29VQjQ2SGpJbVV5L3Ns?=
 =?utf-8?B?MnVFZ3hyWEtpTTlpcVJOTVBJSkxvQit6SUI5WVhlblIwbkNucC9BaFBTdFFp?=
 =?utf-8?B?MVY3aEY3dUEzaDZaZ0E1RlhvMURYSEZuaUpuemErOFlwTjVjSFJrSldlUnR5?=
 =?utf-8?B?dlNZcXZtUEZ3aElwZHcwbjhySWhQZEF2aDJqYzNVckxhbUZUaDMyQmp6Z3hS?=
 =?utf-8?B?Y2k4L2xJbTVibk5sZGdmaTJST25hSDhlbmZ0elBBMExrWFhrMVpSNlVCR0Z3?=
 =?utf-8?B?YUlWc0tOQ3B4aU5iV3dISFc0WlRZZ3RkWUl6VS80TWplVmFpRHFLRkZLRHBj?=
 =?utf-8?B?ZGlBNnYxbDZNdk9GUE9kVXdFZmdVZVRBcXhxVVMvcDdnbVEwc3d4U3ViYXhx?=
 =?utf-8?B?WnIwRlIvSGw0UEJ2ZVM2amp5RTY1WWo1NVhTUHVIcnpkdE1XOFJPODBYTmZp?=
 =?utf-8?B?ODR5SW9ubDFNamJTZkM3R1lPV1JWOVlVSmY5UDk4YzhrdzFKYnhkY21TVy8w?=
 =?utf-8?B?U0RMaGFNM0xHVy95QldJeksxTldxeHZRWFByQXE2VG43M1VvZzJtaXg2Wnk5?=
 =?utf-8?B?VGRkQ1ZwTXRyc1BPVktqdHY4czI2bWxIOWpNUXhzMEZYWUZia2d1QU5RRmVa?=
 =?utf-8?B?QWdhMEh1QUZxK3E3SHJ6SVYzTkNidDEvRFRweDJXUnFBVDlMSUdKS2ZkYnlv?=
 =?utf-8?B?Z2NVYjhVY2hISFp4M0FzLzVBcUlBZ0NXYVFtcVJHd0pEWjJwUU1tRHl0WVBR?=
 =?utf-8?B?b051aUhkRE1lbllRN09SeHJLU0hwek1ncEIzNlRTZk9tcHIvUXZWU3BFa0ww?=
 =?utf-8?B?MlhpbXEzb3hNSkpaSzNWTUYvbHFVYTFPUHc1WXVtV3FkOXF3WnNiam1XTEI4?=
 =?utf-8?B?MTlFZFoyREtERXhmM0p5K0RudlJBWUpzVm0zVjBQQ2J0U09ib2hwdnVLOUN1?=
 =?utf-8?Q?myRIMs9eOqi0q?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a82693d-f803-4bc4-6e23-08d910b445e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 17:27:50.0533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ge25l42vH+dlK1tP0zm3zytQSzFB4MnpcfFxKuBIx+UNpD45/rXkPv7r4t1a+6vLa6CjLi2k5EcMyLv/xhNfIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2286
X-OriginatorOrg: intel.com
Message-ID-Hash: NNOVIB2VYXZYLLKSGY5K5KTQQLPH33PU
X-Message-ID-Hash: NNOVIB2VYXZYLLKSGY5K5KTQQLPH33PU
X-MailFrom: erik.kaneda@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NNOVIB2VYXZYLLKSGY5K5KTQQLPH33PU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Yi Zhang <yi.zhang@redhat.com>
> Sent: Wednesday, May 5, 2021 8:05 PM
> To: Williams, Dan J <dan.j.williams@intel.com>; Moore, Robert
> <robert.moore@intel.com>
> Cc: linux-nvdimm <linux-nvdimm@lists.01.org>; Kaneda, Erik
> <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> Subject: Re: [bug report] system panic at nfit_get_smbios_id+0x6e/0xf0
> [nfit] during boot
> 
> On Sat, May 1, 2021 at 2:05 PM Dan Williams <dan.j.williams@intel.com>
> wrote:
> >
> > On Fri, Apr 30, 2021 at 7:28 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> > >
> > > Hi
> > >
> > > With the latest Linux tree, my DCPMM server boot failed with the
> > > bellow panic log, pls help check it, let me know if you need any test
> > > for it.
> >
> > So v5.12 is ok but v5.12+ is not?
> >
> > Might you be able to bisect?
> 
> Hi Dan
> This issue was introduced with this patch, let me know if you need more info.
> 
> commit cf16b05c607bd716a0a5726dc8d577a89fdc1777
> Author: Bob Moore <robert.moore@intel.com>
> Date:   Tue Apr 6 14:30:15 2021 -0700
> 
>     ACPICA: ACPI 6.4: NFIT: add Location Cookie field
> 
>     Also, update struct size to reflect these changes in nfit core driver.
> 
>     ACPICA commit af60199a9a1de9e6844929fd4cc22334522ed195
> 
>     Link: https://github.com/acpica/acpica/commit/af60199a
>     Cc: Dan Williams <dan.j.williams@intel.com>
>     Signed-off-by: Bob Moore <robert.moore@intel.com>
>     Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

It's likely that this change forced the nfit driver's code to parse the ACPI table so that it assumes that the location cookie field is always enabled and the NFIT was parsed incorrectly. Does the NFIT table on this platform contain a valid cookie field?

> >
> > If not can you send the nfit.gz from this command:
> >
> > acpidump -n NFIT | gzip -c > nfit.gz
> >
> > Also can you send the full dmesg? I don't suppose you see a message of
> > this format before this failure:
> >
> >                         dev_err(acpi_desc->dev, "SPA %d missing DCR %d\n",
> >                                         spa->range_index, dcr);
> >

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

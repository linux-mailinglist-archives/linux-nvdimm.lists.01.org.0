Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480A0316F09
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 19:46:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 954D4100EBBB3;
	Wed, 10 Feb 2021 10:46:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123; helo=esa.microchip.iphmx.com; envelope-from=ariel.sibley@microchip.com; receiver=<UNKNOWN> 
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4144F100ED487
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 10:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612982768; x=1644518768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=agSHP5eqmrGYAyrVlJBqoo/gs+tN+2FmOmsyUO38Fd0=;
  b=oS20SqMBJcKAxZaMwLTYyCaKJQ2jjZ+Ig4Z3FkGsX3DKHvPbaeHG9MYV
   wPPtC7F73RlQtSqYZpH6i+NVQF/TX/nfYhj13Q1uIWcSSrTPy1wuITD97
   KhJj1Ilf3vsYthBlOF+N/Ho4xrpwvJPVgWx5i7c6bc5XBD5++eSFvvZA+
   djiiik8HlBrWTGGi0LZzksb1ao0PN/mCM97p/nis6/N3ARqiYFR/mtTMt
   T6vRbAWICaRz/ANDon8RJRCY7c/3Fth5MqBHvYRB3ZmtgjDkACbdhxWNH
   DAjQjsanxGRkom5stciLJ95k7ByxjizWYPUeTgAOr2rJEKaMkDu382rE+
   w==;
IronPort-SDR: VTy0UQK9ytXF+eiYwo02MZBFynCiYU0HtguTzQDW3EMC1nRkSSfitQfBcihpsy5Lc2h8msIAmT
 GZxeGqWzmHG5v9j4XlrJ8utrjMhQwqB2urtZ1uaNEiw7TN22L8CoFbJxPWbxsQqBsS19yTffVX
 WMQfqhf1Ub/ThjI2R/HG0MoAZn2TyC8JJ2bNM3GPoOco9dS71v0uIVf+ut51l5NAEB50jgz66I
 Ycj6mGcYOU0h34aGhk0EIPmyp3Uhbi9UURi4QcW6jEjaVituZUe7ix24xez+gsdz7CWSGlLPu7
 lnw=
X-IronPort-AV: E=Sophos;i="5.81,169,1610434800";
   d="scan'208";a="43670818"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 11:46:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 11:46:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 10 Feb 2021 11:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cONziAq+VUv1n8zljF0VAkX3jt2R/GczrSd10h+EafoGsgl3h37JPEBjS1y7sKPOD4rxL+JhXN6TYwx5Qj4E08sUPMsb1rXQFcMqohUtPnATLoLuo2Ro2lxI4yVxA9Yvsw+48XGenZ6lXs1IccpP5EvDpv6I1DVoBA5xy1rbCQB1+DfxBaB3k7qkcV5pCrWVYv9z16kF/LoJ7/1CydM4l8h5bOHn1WsAy3wLYjNOj5Y5HszKoKCuZbVjHM/QzExXDZBl4aG2ONaOR5vrgGH100IRSmlRBIhFyKvSSVGQcod8of8mo/IWXyR0hOQTlOB0Ux2HWG6389JYO/Lw376XQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agSHP5eqmrGYAyrVlJBqoo/gs+tN+2FmOmsyUO38Fd0=;
 b=KY6vwSCF2kpdxeMpVpGoKqac0VO//g3u/2cSveCLDu4wcAPC83Bob2G0bdvY0Gr4JA+UW9dKcIJ4cp6hMVcuR/Tk5e28GlHJZLPKJ9Yeq3kd0AZPVWZ0yweyng3y/CY/bGtqfU22UZf338JFemsCbcwafSWo1JQSeDfeDI0IxbwwsOFUr0K/e2y3+aF4UEfO9kfPz3/imeJeXn70MXa2/WqfM4IRDSbT+tDPsK5oMzKFawKTcAW+iwB9hVuWuHaaGxi/m/qmGF5dYvHaB0MzLdyxnSM++N6qKJ5JKzR08MxVdq2TE6Q5mUri6ZUK+3YvkmzMHpo8bmXu5R9poM7SIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agSHP5eqmrGYAyrVlJBqoo/gs+tN+2FmOmsyUO38Fd0=;
 b=ugtD4DMnqJcP7QqU4HmtPrpw4jjeqqJRaHStYd+opN1SHOdCCXQOfMQkuRMjPMsiJmNcYsvNDaeoNU7ligO8ZYclaI0YVgKHVZkuOZBeLyGlG9IoRctdLoXillpPpeAF/2DD0V0Bf9nvFnt+xS69dl+cJoHcy8Hbsm4Ljoh4BME=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by MN2PR11MB3968.namprd11.prod.outlook.com (2603:10b6:208:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 18:46:04 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::51c7:31cf:308f:4c30]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::51c7:31cf:308f:4c30%5]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 18:46:04 +0000
From: <Ariel.Sibley@microchip.com>
To: <ben.widawsky@intel.com>
Subject: RE: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Thread-Topic: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Thread-Index: AQHW/0AqZCOVul459UanKz+acVTCvapRfUwQgAAdewCAAAx2IIAACrSAgAAD9bA=
Date: Wed, 10 Feb 2021 18:46:04 +0000
Message-ID: <MN2PR11MB364513777E713224B3BB7D74888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-6-ben.widawsky@intel.com>
 <MN2PR11MB36455574E25237635D3F9CC0888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <20210210164904.lfhtfvlyeypfpjhe@intel.com>
 <MN2PR11MB36450EFC1729D9A4CDB2FB27888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <20210210181159.opwjsjovzsom7rky@intel.com>
In-Reply-To: <20210210181159.opwjsjovzsom7rky@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [142.134.145.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efcc3bec-aa47-4507-6402-08d8cdf41ec2
x-ms-traffictypediagnostic: MN2PR11MB3968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB396835F90A48449061CBD858888D9@MN2PR11MB3968.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBlewjiUkBa9A2GES5n59KAEsrUyGYx7WdL49WReJyHNqqWT2Gb2H1hFA5KFtOKeL3hzCUmy+34lbcSkEIFGDmnTBzKnwDkHVlfe0/PsFzHuPyryz6NBCvLePuoZ3BtEEiY2Yv3805g66MZM6wd31iroDBE++IBHTiRf3w/Unbx7nYSBbuZbT/CpwYSGzMK2dUSb4CV5vGJZuY0VWpdoj2RM2YXisfCM18vVTbZZiilGg7nScdGqZJKojxHsH0hDRUxJZK8xaPfsR7a11SBHb8D2uz0osVzQErqWCJ/lT03rRcsVFsosAPRNHdMrAaI9rXn3xmZqV9odCowlS3y72NINOFheEOt39DaAwwZxMEdToruu8gq91JSTIhlwrk6wzydUp/KyY/1Gv2LQMUuA2R7Fecr5Zu8H5EyxZQLBO+dIAEhgDgmpHgUmA7CGUriTkr+eCP1Dypb7f2juLQ1m+vs0lsQEqHfKR6KWA2hZpV4O6B9En4ulTOMof/jDOy8hZY0tmlfCET2Z7McymudpIBMrvXBgM44IhRtmk6Y4bLWw+vup41sZq5ierWWKsXfC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(136003)(396003)(8936002)(6506007)(7696005)(478600001)(54906003)(6916009)(186003)(26005)(4326008)(316002)(71200400001)(8676002)(107886003)(5660300002)(9686003)(7416002)(64756008)(66476007)(66556008)(66446008)(55016002)(52536014)(76116006)(66946007)(2906002)(86362001)(83380400001)(33656002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N0plc1lMY3BpcW9SRFgxU3VVS0ZXZmNWd2hDMmd3NlNMb1hOK0V5aVUxNHpj?=
 =?utf-8?B?aDdxcTZibExnTTlDVklpY0JFZ0J5enVZYjR4d25VeDZsbjZNd1JlUjRaRE02?=
 =?utf-8?B?WnBqNVlIQ2c3L0pEQnllRWhjcU43YkRESTZMdW5DQnZ6TGhwTFE0VjhxSVhT?=
 =?utf-8?B?dk1ONUtsRVZmZkNIM0JFODlCTjZjVmJzbW5YeXNJL0ZqZi9KWkdjejUzbGdS?=
 =?utf-8?B?b0Zvdk9LUWowRDB6Z1JaeVR2Z3M3S0EzVkd4cjBaRGY5VDQ0T20zSUpFcDV4?=
 =?utf-8?B?SGFmaG9DLzNLNGJlQ29YSHVjbkduT3BTL21Gc3JlYjBTbWxoZDJlamdtNTln?=
 =?utf-8?B?MUJEd1AvdEhDY0Z5VUx6UGlPTjEzQXdlaFdYNEdmQjdIQ2Q5RmR0eEdTN3E0?=
 =?utf-8?B?SHEvV0lTTU9UMDRHNDlwWmdkVkEwV3VMMVg2QU5ud3NpNmJWN3JZWDFSeHpk?=
 =?utf-8?B?Q1RPWTc3cG0vRE5iLytMdUxjWGJ1Z0RNaWVFb3JlRG5sWkJhdWRQMUpmdTVR?=
 =?utf-8?B?NWdJTHRhTGQ4dmhBMUtCTjJRT09tVFpoaUNqNGVUc01XeUY2MGVRTlRyMGZK?=
 =?utf-8?B?eW5IdWVFR2FlY0ZJTkU5UHorbzl1dmQvMjI0SlIrKzFXYm1tR0FUK21CRkpl?=
 =?utf-8?B?N0FiVlAyTHpKZTI0d3QwcVZCN1h0eXhienl1blhUb2VWdDFaeEsrNndBUVoz?=
 =?utf-8?B?Y0FXd29rZE80VFo0aGRRNWlqd2IzZFIwRTREeCtHMkdWWmtWR3JtbzUvdWl4?=
 =?utf-8?B?Qk00bENIeWJYSXN6VXRWOEZ0NTRMWXJpQ0loYjhtZkZ6ek1FY0hvanBoaXl3?=
 =?utf-8?B?dW8wZSt4Y2g1YzFHUEVtRFprZVZpS1czRHNIeWIzM0ZCWFhDUWZ4TDhUQzl2?=
 =?utf-8?B?cWwzSUhNN3V5OFp0Y1g3WmRUVTlrVUdSSHlUN2hTME5lUDdZMnpVRW4zVFJN?=
 =?utf-8?B?VnFJSS93OENFK044T3hlZXJJYVE4U2wydEFoUWczTXZndGwxWm9Sd1lNd0ZZ?=
 =?utf-8?B?ODlyMDY3aXRvYkVhTHVsUGtrUXJiOW54a1hmRXordXBCQUQ1Y1EzUUYveUpL?=
 =?utf-8?B?OGpSa0ttbHJWYWRDTEUxOVFpZEkxS0N0c1BwM1RrZzM0cVFkYnVZMHQ2ZXor?=
 =?utf-8?B?d3hKRkV4WGpKYkg4Z0ZRS1E0T2dMQm5Ga3gzV2UrNUpMY0Q4enU3cE5WVWdN?=
 =?utf-8?B?VTZWdUdaMTh5V0VOekxtMkI5UWZ2NlRQR1dEMlpmUUhrUm50UTAyaG5vZ0tM?=
 =?utf-8?B?SmNoM2VneXUyR0pXWnEzTzg3cjl0d3YrNm11OE14Q0xVVXA5ZjVDTUxrZzdQ?=
 =?utf-8?B?T2g4Ky9NRXphczVKNnNpejVoUWNNQXF0NjJyM3A1WE9FdlhBUGc2NmdVWDEv?=
 =?utf-8?B?aUdRTVJTOWZHM2VrU0ZUR2JGb3NadXBvcVlVQlR4S3cwdDdBQU5YcmdCc3pD?=
 =?utf-8?B?LzBFYTdUMmxZVUVJaitVTmlTb1lnWlFTYytOSEJaajRMUGhUdFZnQWVvRzJs?=
 =?utf-8?B?VitZWEF6NVAvSHVpeldWLzBtVm0vZnNCTENtRGxzVmx5NGhjRVBCR0cwWFdU?=
 =?utf-8?B?UnhiaGxsUVZtSDJDUjNKUjkvRU1GUFRhSGRuRm0zUWU0Q2Q4TDZkZFg0WnRk?=
 =?utf-8?B?Y3g2ZVV2UFJtRTVHNE5kRFVUUzV6S09mV1diOEUzOGU1VkdSclNtNFkrMTl6?=
 =?utf-8?B?WEhhUVRuYjRYRHBVczRmUFlpU0xxUEpyR3RiNlRYVEpaM2Y0V3VwOGhESXQr?=
 =?utf-8?Q?RVII1Oty9MYgU+LmvrrdxrEmb4YH2Xy71JEBEBO?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcc3bec-aa47-4507-6402-08d8cdf41ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 18:46:04.3106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HuY4O9nYodlhY2jIco6YQd1srUxmMkZXvz11zb7LG+0wbTX7aRRHZVA1Nov+GJur2g5+FddpHPWne67/0+7UzeHQnncGXyHUeDg6x/aKi6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3968
Message-ID-Hash: E7D5RF6OHVRELVZPZ3ODGPBGTDPVI4JU
X-Message-ID-Hash: E7D5RF6OHVRELVZPZ3ODGPBGTDPVI4JU
X-MailFrom: Ariel.Sibley@microchip.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, helgaas@kernel.org, cbrowy@avery-design.com, hch@infradead.org, david@redhat.com, rientjes@google.com, jcm@jonmasters.org, Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com, rdunlap@infradead.org, jgroves@micron.com, sean.v.kelley@intel.com, Ahmad.Danesh@microchip.com, Varada.Dighe@microchip.com, Kirthi.Shenoy@microchip.com, Sanjay.Goyal@microchip.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E7D5RF6OHVRELVZPZ3ODGPBGTDPVI4JU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > > > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > > > index c4ba3aa0a05d..08eaa8e52083 100644
> > > > > --- a/drivers/cxl/Kconfig
> > > > > +++ b/drivers/cxl/Kconfig
> > > > > @@ -33,6 +33,24 @@ config CXL_MEM
> > > > >
> > > > >           If unsure say 'm'.
> > > > >
> > > > > +config CXL_MEM_RAW_COMMANDS
> > > > > +       bool "RAW Command Interface for Memory Devices"
> > > > > +       depends on CXL_MEM
> > > > > +       help
> > > > > +         Enable CXL RAW command interface.
> > > > > +
> > > > > +         The CXL driver ioctl interface may assign a kernel ioctl command
> > > > > +         number for each specification defined opcode. At any given point in
> > > > > +         time the number of opcodes that the specification defines and a device
> > > > > +         may implement may exceed the kernel's set of associated ioctl function
> > > > > +         numbers. The mismatch is either by omission, specification is too new,
> > > > > +         or by design. When prototyping new hardware, or developing /
> > > > > debugging
> > > > > +         the driver it is useful to be able to submit any possible command to
> > > > > +         the hardware, even commands that may crash the kernel due to their
> > > > > +         potential impact to memory currently in use by the kernel.
> > > > > +
> > > > > +         If developing CXL hardware or the driver say Y, otherwise say N.
> > > >
> > > > Blocking RAW commands by default will prevent vendors from developing user
> > > > space tools that utilize vendor specific commands. Vendors of CXL.mem devices
> > > > should take ownership of ensuring any vendor defined commands that could cause
> > > > user data to be exposed or corrupted are disabled at the device level for
> > > > shipping configurations.
> > >
> > > Thanks for brining this up Ariel. If there is a recommendation on how to codify
> > > this, I would certainly like to know because the explanation will be long.
> > >
> > > ---
> > >
> > > The background:
> > >
> > > The enabling/disabling of the Kconfig option is driven by the distribution
> > > and/or system integrator. Even if we made the default 'y', nothing stops them
> > > from changing that. if you are using this driver in production and insist on
> > > using RAW commands, you are free to carry around a small patch to get rid of the
> > > WARN (it is a one-liner).
> > >
> > > To recap why this is in place - the driver owns the sanctity of the device and
> > > therefore a [large] part of the whole system. What we can do as driver writers
> > > is figure out the set of commands that are "safe" and allow those. Aside from
> > > being able to validate them, we're able to mediate them with other parallel
> > > operations that might conflict. We gain the ability to squint extra hard at bug
> > > reports. We provide a reason to try to use a well defined part of the spec.
> > > Realizing that only allowing that small set of commands in a rapidly growing
> > > ecosystem is not a welcoming API; we decided on RAW.
> > >
> > > Vendor commands can be one of two types:
> > > 1. Some functionality probably most vendors want.
> > > 2. Functionality that is really single vendor specific.
> > >
> > > Hopefully we can agree that the path for case #1 is to work with the consortium
> > > to standardize a command that does what is needed and that can eventually become
> > > part of UAPI. The situation is unfortunate, but temporary. If you won't be able
> > > to upgrade your kernel, patch out the WARN as above.
> > >
> > > The second situation is interesting and does need some more thought and
> > > discussion.
> > >
> > > ---
> > >
> > > I see 3 realistic options for truly vendor specific commands.
> > > 1. Tough noogies. Vendors aren't special and they shouldn't do that.
> > > 2. modparam to disable the WARN for specific devices (let the sysadmin decide)
> > > 3. Try to make them part of UAPI.
> > >
> > > The right answer to me is #1, but I also realize I live in the real world.
> > >
> > > #2 provides too much flexibility. Vendors will just do what they please and
> > > distros and/or integrators will be seen as hostile if they don't accommodate.
> > >
> > > I like #3, but I have a feeling not everyone will agree. My proposal for vendor
> > > specific commands is, if it's clear it's truly a unique command, allow adding it
> > > as part of UAPI (moving it out of RAW). I expect like 5 of these, ever. If we
> > > start getting multiple per vendor, we've failed. The infrastructure is already
> > > in place to allow doing this pretty easily. I think we'd have to draw up some
> > > guidelines (like adding test cases for the command) to allow these to come in.
> > > Anything with command effects is going to need extra scrutiny.
> >
> > This would necessitate adding specific opcode values in the range C000h-FFFFh
> > to UAPI, and those would then be allowed for all CXL.mem devices, correct?  If
> > so, I do not think this is the right approach, as opcodes in this range are by
> > definition vendor defined.  A given opcode value will have totally different
> > effects depending on the vendor.
> 
> Perhaps I didn't explain well enough. The UAPI would define the command ID to
> opcode mapping, for example 0xC000. There would be a validation step in the
> driver where it determines if it's actually the correct hardware to execute on.
> So it would be entirely possible to have multiple vendor commands with the same
> opcode.
> 
> So UAPI might be this:
>         ___C(GET_HEALTH_INFO, "Get Health Info"),                         \
>         ___C(GET_LOG, "Get Log"),                                         \
>         ___C(VENDOR_FOO_XXX, "FOO"),                                      \
>         ___C(VENDOR_BAR_XXX, "BAR"),                                      \
> 
> User space just picks the command they want, FOO/BAR. If they use VENDOR_BAR_XXX
> on VENDOR_FOO's hardware, they will get an error return value.

Would the driver be doing this enforcement of vendor ID / opcode compatibility, or would the error return value mentioned here be from the device?  My concern is where the same opcode has two meanings for different vendors.  For example, for Vendor A opcode 0xC000 might report some form of status information, but for Vendor B it might have data side effects.  There may not have been any UAPI intention to expose 0xC000 for Vendor B devices, but the existence of 0xC000 in UAPI for Vendor A results in the data corrupting version of 0xC000 for Vendor B being allowed.  It would seem to me that even if the commands are in UAPI, the driver would still need to rely on the contents of the CEL to determine if the command should be allowed.
 
> > I think you may be on to something with the command effects.  But rather than
> > "extra scrutiny" for opcodes that have command effects, would it make sense to
> > allow vendor defined opcodes that have Bit[5:0] in the Command Effect field of
> > the CEL Entry Structure (Table 173) set to 0?  In conjunction, those bits
> > represent any change to the configuration or data within the device.  For
> > commands that have no such effects, is there harm to allowing them?  Of
> > course, this approach relies on the vendor to not misrepresent the command
> > effects.
> >
> 
> That last sentence is what worries me :-)

One must also rely on the vendor to not simply corrupt data at random. :) IMO the contents of the CEL should be believed by the driver, rather than the driver treating the device as a hostile actor.

> 
> 
> > >
> > > In my opinion, as maintainers of the driver, we do owe the community an answer
> > > as to our direction for this. Dan, what is your thought?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

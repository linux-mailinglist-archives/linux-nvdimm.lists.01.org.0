Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C1B316DB6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 19:03:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3EFBA100EA911;
	Wed, 10 Feb 2021 10:03:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123; helo=esa.microchip.iphmx.com; envelope-from=ariel.sibley@microchip.com; receiver=<UNKNOWN> 
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 44F27100EA910
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 10:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612980224; x=1644516224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DJ+9Kkc1J5DopGIRKe4YqGARUu/skXfsV21LdBZrulw=;
  b=z32c0KbzAuH33fHY5m2iulwc5tDu9mnjTAMYn2WqnxaLpVqqJk7kFGhJ
   RDMRm/zLgAqPI/wjbvEgYyJcuzPXpDr8aSdDSoYnRLJ8o25SKBk4DUiOW
   7C6TWYYNuuRgDt5C2Rbni5l3N2kVV8Xo5zzQrv82FchYeX90UEaNJNa0/
   KQqkT+Kl6WMXnUACbhzCrQVA0PzUQm29BU7RZNOxPWnrmUF4eDoXOTuGu
   Lsb4yE8jLXaAq+EqIe7kKHBBOgUwLWae9PdkRXWoECuoAjw274Z1f8/83
   UKcZHNEB0D8QklILt2HUqH/lniENwzU+VtqKj9rV19wNfkZsfv+OUG0Hw
   g==;
IronPort-SDR: LlMoBaDMnFdhuozyciwETT3M9F4J+vgS5Dc+7A9WSBoBsrIW+WTX8nTQ4UWKKb0eazVgOMfiA3
 lcARfWZayqoRqiAAB/i7lq0ONRh9ftxb8C3T/HQIrIWFsGXyeqIpZ6XULrulf805S+G/cnOI6+
 DqoCnKyzlQdPaOsvvBfo2V9da0kZhUR/hEoPVVCkjsIkjXasXmVzuzN1CQbdGUqVzPVyKL+V/9
 pcnOahgrC37EjpKvX9/hmCeBsxV25+3SnuPRDL/jxFbdfhg8LaRK9bRhgmU+VOYsnuC1GcoiyJ
 VV4=
X-IronPort-AV: E=Sophos;i="5.81,168,1610434800";
   d="scan'208";a="106153187"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 11:03:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 11:03:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 10 Feb 2021 11:03:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeCiLASgnJanIyDlABuFRmZr5MkSCPFShf0dZrY+JStXUcZXvZQVkTR2Qwxt82cM4lfqh06JHhksguWF67aMYVsU+O3x/eMBGk856mmWwHuIqhCmeHr0PZtNFtV3vu79BpZVb7q1CER9bB/YUBpZr9i77Bm+6bz/4/Tu/s9qVxd+ugZ8MZnRzznWR8oaXvjnQAXxIZ0UcnDq9BV+PmwQ46Lxtk4/cPdNxrzyk/c8W7TrbjVkBwvlJDOr286JljqagMCyP+grbJc7BJnGLoFbHer1vWCVWN8zHl3nhqwhYUZusD67qXa2n7bH2pzu01i+CfavLaZxJ74h4zzQxNVcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ+9Kkc1J5DopGIRKe4YqGARUu/skXfsV21LdBZrulw=;
 b=SPO8TT8IX3mVK7fx4c8NblZrthNsuGWCoIgtrSTei3VXYyVoFkHGJv0WsdbXgXeBhne0/2YYUfbnhx+R8HG6deDAamsg+fdE4WE2ZcSp1WKwc3aWkf8BYUYSJm1AzqAV6EkPwSG116NdV4NI4s6NTYPvBi6zVUHpU57QEt6CfiF8PUGlNi125CsaIeDaMKTnLzu29Qb+mzhQAj71cZWs8fgsG4Abiv5rf91r4bWC0alBspyAF88daknkIXJIW8q09V3M8YtA8+WOLpJrWxb98/0n/jY9DoUZY+AKuVOkbRTHvSsU2u1R6iwPWvq19S5FhKu0AebkWWpVjXH8S5ED9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ+9Kkc1J5DopGIRKe4YqGARUu/skXfsV21LdBZrulw=;
 b=DbcWfPYEjgcCjBFDe7oi26ugKtvCCI7MUEqCUZI8TIKVyIuNgzRrSpDmi7lxRAttl6wtRNvTI+1TaXkqqx2dUfiBn4Yf8aSbv5T7INGUvBgEYLW8Ni18N6vWsRwCGf41GLFUqndA0anaxe2BNKpyW5OSfs0SOheS/T8pNjk0fP8=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by MN2PR11MB3856.namprd11.prod.outlook.com (2603:10b6:208:ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Wed, 10 Feb
 2021 18:03:36 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::51c7:31cf:308f:4c30]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::51c7:31cf:308f:4c30%5]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 18:03:36 +0000
From: <Ariel.Sibley@microchip.com>
To: <ben.widawsky@intel.com>
Subject: RE: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Thread-Topic: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Thread-Index: AQHW/0AqZCOVul459UanKz+acVTCvapRfUwQgAAdewCAAAx2IA==
Date: Wed, 10 Feb 2021 18:03:35 +0000
Message-ID: <MN2PR11MB36450EFC1729D9A4CDB2FB27888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-6-ben.widawsky@intel.com>
 <MN2PR11MB36455574E25237635D3F9CC0888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <20210210164904.lfhtfvlyeypfpjhe@intel.com>
In-Reply-To: <20210210164904.lfhtfvlyeypfpjhe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [142.134.145.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1be68f97-d6dd-421d-dcb6-08d8cdee2fe3
x-ms-traffictypediagnostic: MN2PR11MB3856:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB385637DA454C5F0B17DD800E888D9@MN2PR11MB3856.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VGw5lSVDsEA26xJgkcrh4HeKvKdBjMhFt+K32htYVJVHtlzN1FBdgpmVMku8D12eRlm1hqT1m3Kp8WcmF7hx5kMtjIbVHaUWCgaOu4KIrzqZpUtu+AxdMm5T1G0FtM4Ni/1t6uh4Otud9iwMSVHebC2ox1QWUyKmw6Vf7oY8gliNdCcqFiq2mxaxZDWtVdMtoLPsBb4OskQTPLwL3fkN32C9cECVPB1BdAuRRH1giWYVIK28Ip/hPzCzllN1HIdoeWNARVSTFTpRy/IIBvJTSQcnhYx/7AvWrQtaZjARn5bIvHDrLgG8JE/MIm0riRtkR7X1Qgr3YfQu6RYCpnIqsC1ZFBMFb0+vmqF47BHYvBlfMk/UjE0Svv/1qYel5AKPYhXy5wvMXlug5xcf/PgX9+i57Uq1dDW5veSYRbnSiIFzPuRXuTawtXMu+1cpMbPqTYUq1j9TIfS21mu1RFrQjYQPXccDlubH258EN7SuhMo2bVY+s5pHu112D4pTvGZCJ4FR4UQ8kmQb9oDpWRSqbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(346002)(39860400002)(33656002)(9686003)(6506007)(478600001)(8936002)(55016002)(54906003)(7416002)(316002)(8676002)(71200400001)(66446008)(66556008)(66476007)(66946007)(76116006)(64756008)(86362001)(26005)(2906002)(7696005)(186003)(4326008)(83380400001)(6916009)(52536014)(5660300002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d25HNHhUbkxmWUN4STR6d0NTVHhlTnVqNWtRb3JhOEdDWms3TG5sWWNCd0hI?=
 =?utf-8?B?c1JOdDJGcVdsa1dxMS8wS3JWU3U5c0YyS2dlWk5DbGM0d2Vzd1RXTEVRQ045?=
 =?utf-8?B?NDhrYUIxbWovWGtxY0M1cGpOR2dlZ1JFcjFYcU5YYStIajhmU3hxNUNDbUR6?=
 =?utf-8?B?cjZ0SGNmOW52ZThSVmRlYXRZQzRaRmYwckZPQ0UzSStLVWQxN2J3clBNelM1?=
 =?utf-8?B?VThzbFd2V1BFNDRETEp6L0U2aHg4ZUR0c05Lbm1xeGRoYmIzTEVKVTVlTGlm?=
 =?utf-8?B?Qmw5cGh3b3NtKzJxQjNXZXZ6Sy9EZHF3NWEwVmlOTUU4anRzUm12djVPeWY1?=
 =?utf-8?B?aXQyZTdwVzJEWG4zZThZelp2M1F4Y0xPdUc4Mk90Si9RWnBQL2NJVVJ1N0RP?=
 =?utf-8?B?czVQTmsvakpQQk9wODJFcUZlUGhtZE9CSFJ4UC9hVTRhUGpGaU9mS2VUblFn?=
 =?utf-8?B?OEtUQmdWT213WGFFQUpiRlNRQ0VjaFQ3Zm1ENlMxVGptdWVqUlBRTzk5eUhw?=
 =?utf-8?B?d0FnV3RCMEEvNXlxdE1TNnVuZnlkSGxvZklQeE5NRExaYW1PRVFlUkhGa0FZ?=
 =?utf-8?B?dkhVZThPV2N5VmljQ0c5d2ZWTkxoengrWFpaZlJqa3lqQytkZ0J4VWFqTUVI?=
 =?utf-8?B?bnhsQkd0aUlQdU03cFVrUDJtbEV4TG50dHFOR0FaZWRBKzkxTmczcEFFZ3I3?=
 =?utf-8?B?MC9vYXRtUzNMbXIvMytCdnMxZnJ0NUVDbFJHWFJRczlORGpoRVVmbWIxYWxl?=
 =?utf-8?B?QkVVQVcvVmxaRi8vVGdldFlLakhrRSsxcDBYY0NVQndtSk1jQW50a1RJYTBJ?=
 =?utf-8?B?Q3hGdW9oZERsdXV1d0wwd000ZXd0NHN6T1NHaGVpUUxtMjdvei9HSEdqVmxI?=
 =?utf-8?B?MWlsbUFBeGNPejY5emhKRjlod016dzVTVmhvUWZvYjlQNXZyT1hFZ1RINkRM?=
 =?utf-8?B?ZDZpU3FvMzFXWkxxcXJQN3BOOGdzLzF3S3lFaDJoK096RjN0am5MZGhpWjJU?=
 =?utf-8?B?eHlxYTVDZEE1NzlPZzN0Sk1zUXhYSmNRRmVzeWFldFBGbDFWaU90cm43bVd2?=
 =?utf-8?B?M3B0TENQUmRHbzFVSW92OWUzRlRKRG1DNlpjK2pwaWNZV3YxcTdPM1hUSVVC?=
 =?utf-8?B?d1ZWQWh3d1RVVVVtb0I3SEV5VnljQUdhdXZlWkovN25RSzN3LytXYVNIRnVY?=
 =?utf-8?B?UDVsb1lIWFhDblFPMTRBeUNyOTVhMmp5Zi81RVJVVjk4S2RSa1NBRXJWTFJx?=
 =?utf-8?B?RTFsWEt4b0s5cThRaCtJYXB5dmVFK0hqR3o1V3Q3czZhYzJJT3VRSjh4ZE5C?=
 =?utf-8?B?WFI4enFIdkdlMTBpZkMxSWNYcXZjL2orOXJaTDg3anFXV3NncHdaUDVqSTZI?=
 =?utf-8?B?NnBMUmdMN3gwSjA0S3QweTFadHZYSXJSQzNDVWlXTVNzSW43cC9ITjRkdUt4?=
 =?utf-8?B?dU5tNXkyWDRsOGdGT1ROWGMraytLMVk4WlFVb1hJMmQ5UTBJaGhJcmZJbm9M?=
 =?utf-8?B?M0VWM3EzNjl4KzdrdUtOUEhHbDNoL3NGR0dZWTNxcEZzbFZ3ckZYRDVPeFJ0?=
 =?utf-8?B?QldQcEtXREdIcG8rSGhWY2tkUG5tblQ3eXZHaUd2eDlCcUZJN2UrbzErelFP?=
 =?utf-8?B?OTkyZmNPZFJnQWdvYzBsSnlkN0N1eDl0TjAxd1lLUFpJK2d6OGJsUzN0eWs0?=
 =?utf-8?B?Umx1dEhCT3RTNExmeFpSczBTdGJhVWo0a2dubXhaUXRYVkJvd3JlY2hwWjBZ?=
 =?utf-8?Q?06A+2RcRBfZxGBYVjJE4xf45yBph+wqvmaM7ga9?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be68f97-d6dd-421d-dcb6-08d8cdee2fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 18:03:35.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zu1rEbW7cHnnKLjEh6ri4r0xUbti1DgOO+SIyiDf2gBThJLk7DcIF8A8claAAIPeivUE8DStZX1m4ipS7ibzZ4nFkuOboeB89tfd6hfZ+Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3856
Message-ID-Hash: FXMG5M4XPA7FH2AOAH5DMHNI6A7JGWOZ
X-Message-ID-Hash: FXMG5M4XPA7FH2AOAH5DMHNI6A7JGWOZ
X-MailFrom: Ariel.Sibley@microchip.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, helgaas@kernel.org, cbrowy@avery-design.com, hch@infradead.org, david@redhat.com, rientjes@google.com, jcm@jonmasters.org, Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com, rdunlap@infradead.org, jgroves@micron.com, sean.v.kelley@intel.com, Ahmad.Danesh@microchip.com, Varada.Dighe@microchip.com, Kirthi.Shenoy@microchip.com, Sanjay.Goyal@microchip.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FXMG5M4XPA7FH2AOAH5DMHNI6A7JGWOZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > index c4ba3aa0a05d..08eaa8e52083 100644
> > > --- a/drivers/cxl/Kconfig
> > > +++ b/drivers/cxl/Kconfig
> > > @@ -33,6 +33,24 @@ config CXL_MEM
> > >
> > >           If unsure say 'm'.
> > >
> > > +config CXL_MEM_RAW_COMMANDS
> > > +       bool "RAW Command Interface for Memory Devices"
> > > +       depends on CXL_MEM
> > > +       help
> > > +         Enable CXL RAW command interface.
> > > +
> > > +         The CXL driver ioctl interface may assign a kernel ioctl command
> > > +         number for each specification defined opcode. At any given point in
> > > +         time the number of opcodes that the specification defines and a device
> > > +         may implement may exceed the kernel's set of associated ioctl function
> > > +         numbers. The mismatch is either by omission, specification is too new,
> > > +         or by design. When prototyping new hardware, or developing /
> > > debugging
> > > +         the driver it is useful to be able to submit any possible command to
> > > +         the hardware, even commands that may crash the kernel due to their
> > > +         potential impact to memory currently in use by the kernel.
> > > +
> > > +         If developing CXL hardware or the driver say Y, otherwise say N.
> >
> > Blocking RAW commands by default will prevent vendors from developing user
> > space tools that utilize vendor specific commands. Vendors of CXL.mem devices
> > should take ownership of ensuring any vendor defined commands that could cause
> > user data to be exposed or corrupted are disabled at the device level for
> > shipping configurations.
> 
> Thanks for brining this up Ariel. If there is a recommendation on how to codify
> this, I would certainly like to know because the explanation will be long.
> 
> ---
> 
> The background:
> 
> The enabling/disabling of the Kconfig option is driven by the distribution
> and/or system integrator. Even if we made the default 'y', nothing stops them
> from changing that. if you are using this driver in production and insist on
> using RAW commands, you are free to carry around a small patch to get rid of the
> WARN (it is a one-liner).
> 
> To recap why this is in place - the driver owns the sanctity of the device and
> therefore a [large] part of the whole system. What we can do as driver writers
> is figure out the set of commands that are "safe" and allow those. Aside from
> being able to validate them, we're able to mediate them with other parallel
> operations that might conflict. We gain the ability to squint extra hard at bug
> reports. We provide a reason to try to use a well defined part of the spec.
> Realizing that only allowing that small set of commands in a rapidly growing
> ecosystem is not a welcoming API; we decided on RAW.
> 
> Vendor commands can be one of two types:
> 1. Some functionality probably most vendors want.
> 2. Functionality that is really single vendor specific.
> 
> Hopefully we can agree that the path for case #1 is to work with the consortium
> to standardize a command that does what is needed and that can eventually become
> part of UAPI. The situation is unfortunate, but temporary. If you won't be able
> to upgrade your kernel, patch out the WARN as above.
> 
> The second situation is interesting and does need some more thought and
> discussion.
> 
> ---
> 
> I see 3 realistic options for truly vendor specific commands.
> 1. Tough noogies. Vendors aren't special and they shouldn't do that.
> 2. modparam to disable the WARN for specific devices (let the sysadmin decide)
> 3. Try to make them part of UAPI.
> 
> The right answer to me is #1, but I also realize I live in the real world.
> 
> #2 provides too much flexibility. Vendors will just do what they please and
> distros and/or integrators will be seen as hostile if they don't accommodate.
> 
> I like #3, but I have a feeling not everyone will agree. My proposal for vendor
> specific commands is, if it's clear it's truly a unique command, allow adding it
> as part of UAPI (moving it out of RAW). I expect like 5 of these, ever. If we
> start getting multiple per vendor, we've failed. The infrastructure is already
> in place to allow doing this pretty easily. I think we'd have to draw up some
> guidelines (like adding test cases for the command) to allow these to come in.
> Anything with command effects is going to need extra scrutiny.

This would necessitate adding specific opcode values in the range C000h-FFFFh to UAPI, and those would then be allowed for all CXL.mem devices, correct?  If so, I do not think this is the right approach, as opcodes in this range are by definition vendor defined.  A given opcode value will have totally different effects depending on the vendor.

I think you may be on to something with the command effects.  But rather than "extra scrutiny" for opcodes that have command effects, would it make sense to allow vendor defined opcodes that have Bit[5:0] in the Command Effect field of the CEL Entry Structure (Table 173) set to 0?  In conjunction, those bits represent any change to the configuration or data within the device.  For commands that have no such effects, is there harm to allowing them?  Of course, this approach relies on the vendor to not misrepresent the command effects.

> 
> In my opinion, as maintainers of the driver, we do owe the community an answer
> as to our direction for this. Dan, what is your thought?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

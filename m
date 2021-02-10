Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289A316A1C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 16:26:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A58F0100EAB11;
	Wed, 10 Feb 2021 07:26:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233; helo=esa.microchip.iphmx.com; envelope-from=ariel.sibley@microchip.com; receiver=<UNKNOWN> 
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED1F0100EBB7B
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 07:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612970805; x=1644506805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xGVzJquCzyjQYa4LIIypMWK2VAvY2VtOhqrB42TBKao=;
  b=pjnAx7y9xNTbdIg9o4VksZDx2zbZBzn1jCNHHRLZEYLSvHNCmxVEqfqp
   3teuK4z7hbXGI+vxvgomeGYCZ9LqWJgt7No3LxtDDzaWz9qHbXYysZzI/
   ixV79skS8gaTdXFadEhx05X6ByRiFMJZ/YM3JoIEbQUZnQyuULXgBPjFz
   e+/olr6RMXsObKkVf9VCFjj3be5cxiDGy9sgUIe+TjUya8w8KuzHej96n
   68l/X9NAp6bEi/wNVZD9BtRmqYNKOCjP1qvi6kMothsAD+8IKo6NHbL6f
   qc2eWUsB8TILKnWhrGaEYUN/q2p6kMN1LHZFbIDCfRo0hgFHFxdc+Smlg
   g==;
IronPort-SDR: vwCVGxVJThETRAbcUmdJWtiNNgPYabBmPfEgW9aa8If73sgNVKvG/URQc3sb1vupu/7Pe/hrXM
 GD9jEyAaxiuf+V7Dy9no3LfsuE/VVEoWKYIINn5dvCkENuDx9aYEZwzjUoqwy2lSHajOPZOlPR
 P/5zIDsU6Lhf5BIlRaE7TmR42ycm+ZVbWWnxeQ9G6NxEZAUL1k14+WFaHKT18wKswEay+V3RW+
 w2F1SpBRTeLYhxw4EhuO+shNDxRqrE060NUUwfLLpwZ6alVyLDiUTSklrYHAe7Q8QnEO3vqmzR
 +aU=
X-IronPort-AV: E=Sophos;i="5.81,168,1610434800";
   d="scan'208";a="108719237"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 08:26:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 08:26:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 10 Feb 2021 08:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaxLrcc88/V8g86xpqjGEaOcDuWGtpUbUObx3IYsbPoBxodHcgnQstwZJPsyPt3xcA15BZ1GRtS6sHcOEBLNuAtLVywcFCzcihSZdQRD9EAD2JtjAeTvyEC/xCjz5vRyl1GWr5HaKcVqKROlXt7NenAxLBaEVxqzjr5TNbRULhOtIrJjpfl/ptwHFiJhMtPJsQgbYf8U3oc1Bt/0d+hXSVBEZ38WcPEpFu+8pBArbwXU0aGfFtC+UR/XcJAUBjP93Pu0n8ujkah3V4bqJIxNePxj7Z7yfOmWt367y8CGqmGiw4QnwOSbzEjCi1L4r7xIBh8JmbhbL93IFUsXiCsiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rteu7Jctq28lgwb8XznjyCN7S2VISSfAMObiYy0AGfI=;
 b=NfGFRWDYBLjZ8tIow3nc2j64MCkywN1qjQroetzCDE5gxVgL0bUF7G25v4AsZnnoW8Zq5N8qHBV+IQ9dibK+yUFShKHIktDS7HTNf5RiOsfY/IEo9OKzOFN4DPFW1MNDIijxuDc7dltLK7ZRxgHA6CyVjzPR7pgWQd5AQ59QGAiN6l1JTJ84/P6HNU7/KsNTeo+oKYdGBAhSmakoZdgwMD2Pxcp3hd9cxuxWQm3SZZZbTRAMR7PEdtc/da1RpoDkCNwlTauqUr442IXvxT0tP8GhmOFKRBb9/rOM0MZRQcChIu5KOGpbH7Wh1uo7BwpbKS3jfcq6eZo3va63T/x6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rteu7Jctq28lgwb8XznjyCN7S2VISSfAMObiYy0AGfI=;
 b=jmUrznCyUi1nmjgcD9fNilkjubIGHD0rCUTYqqC1Nrx1tcrDwlQeLTZJ1//dhyMdIX22JHrGbPaeStRw+neqt/4EpBIHMgsDZrT24HZBU8XDFlEm7Mdf10/6rx9I6mrtQdodxMQYKS8v93xzE8eqyqPl3+KzlrmPQUQf6J7drKI=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by MN2PR11MB3648.namprd11.prod.outlook.com (2603:10b6:208:f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 10 Feb
 2021 15:26:27 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::51c7:31cf:308f:4c30]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::51c7:31cf:308f:4c30%5]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 15:26:27 +0000
From: <Ariel.Sibley@microchip.com>
To: <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Thread-Topic: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Thread-Index: AQHW/0AqZCOVul459UanKz+acVTCvapRfUwQ
Date: Wed, 10 Feb 2021 15:26:27 +0000
Message-ID: <MN2PR11MB36455574E25237635D3F9CC0888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-6-ben.widawsky@intel.com>
In-Reply-To: <20210210000259.635748-6-ben.widawsky@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [142.134.145.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d30efc6-6810-469d-115c-08d8cdd83bc3
x-ms-traffictypediagnostic: MN2PR11MB3648:
x-microsoft-antispam-prvs: <MN2PR11MB3648B7F3EF4F10333189B652888D9@MN2PR11MB3648.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4OBqMZ8ipHipRogcYq7jSyeW+7sOEgcxf7S3rKauMKT3/u3a0/VpQ1EraPbYOfV0Q9KZKUYjCdwh21kfmALpTSbA4cpF6Oqg5Jb6ey1kSQqk6lWIPGhkecy19snxPTDJL3Arravrl7/MBnl+BL8sx+xlE4fqr/E7KfDhbGFhZ/KVGgr8WHPtr5l/nsw0gSxCgNPnmMLewqZXxzbiBCK+TVfbRw1d566lMUs5VTb79XrrPi/JW5X5yEamxWJQLa54IFPdqPmaIe6TvT9AM1L1aKt5qyOXIa0WIPkhBgMylNvbq7u3Tg4hnJEnRuY2yi9LxWMAt/8UVD/SsoZIdMeyUsYyFVL0XUtqHQdRyIJGq/WgogJ3SZjHhiFYHJ1NJsUUBeDhistFmVSzhlR/OCO/tUUc7CPDO6L4IRrWtGoZzSmikReRJylbGbbOsPW55IbJJu95SASqNkUrrVEHQjmcsOY6ZaxoGxHkbozNGsY3BnIaui3gmgflil2UG5hk9zh4mXfH22WlQgr2FEFJyekMfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(136003)(396003)(71200400001)(4326008)(8676002)(2906002)(66446008)(64756008)(66556008)(54906003)(66476007)(52536014)(6506007)(110136005)(33656002)(83380400001)(76116006)(478600001)(7696005)(5660300002)(26005)(86362001)(8936002)(9686003)(66946007)(316002)(55016002)(186003)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gOymMf+WEY4yG+Xfrdz5PI1KH7Mqb6Ki7EQTiXcThj+wrXrftv/WW3mgb9j0?=
 =?us-ascii?Q?CDer+rAjFY//ITpZJXxFK2Q79snOpvQmIzPTfuLmtTzVsX40kMqk5lv2O5Dd?=
 =?us-ascii?Q?+OBb/j+MCt94bOmpCWxv2iqUbcM/xMnmeGuyKNQCzuWYJZAIAT8xg9Ia60A+?=
 =?us-ascii?Q?n/oGPlqxG2JZ3l7sCPLdqORw30ksRGpxe6og+/olIEmds4GUJdNpo3sKthq2?=
 =?us-ascii?Q?68C9XNPWIpp+Db9u6XWlZUaEbC908+knBdwORLxdZt45GlaE6Bx2AHnQgkVz?=
 =?us-ascii?Q?GfPdiA4pSUvPwo0zjZoBs1vaDU1ej3qFCrKJu2XD9scBA8rk/3w5nGZhpUQh?=
 =?us-ascii?Q?ecIubz/6nbkq7BimTdOX5A91+9QYwZ+2aGEIHZSdrbmGLKRmsp4OS8CrQuBs?=
 =?us-ascii?Q?tAmT/OxpmXXaC/yQoPukqGmG3aAeDmFh00g/CNO5HtUJNGhqv5UHrUgR6h61?=
 =?us-ascii?Q?PfzUWU6rN+w6GXcsAPh6cWb7ZNKvQv+FOTvGts1vumrYyfu1vv11KQsWrmxo?=
 =?us-ascii?Q?neFAicn2aZFU+YmpU9YU+GKMytPpmKKhGEQSkXMYazag+ZX0tYGjstEaYxfs?=
 =?us-ascii?Q?7LPj06Eh1rQooo6rSOYe9UM7MlNI2jofQGROoZBisqXWxRfSNIwrkpb8/uE5?=
 =?us-ascii?Q?kaldtbbwr2M8MAgNcWZih+4OaNSgIPZhrhp23N5pIFaS30wRpulBpTqF8Hfw?=
 =?us-ascii?Q?632fRhP+DtIf4fdkwRHerZ5VWyD7XpNey8Hgv2ephI5mu1LNIV+1FlyK/zTQ?=
 =?us-ascii?Q?0DugoaWgRRN5p83bf1gJMB03mXJ+zuDLKA2TY3XusogoeFhz+2B8WmxWUI7h?=
 =?us-ascii?Q?T7m6RqvWPAryKBK5qgFWm2qgynBNa5zdThzdltih8SUK5Be+QtgX47OGUkBy?=
 =?us-ascii?Q?Zhlh9sGTIVAdT4CEMG4LSZBsm2xBF70qjw/ilFKZ/C59jowXqUbhqASpGrK1?=
 =?us-ascii?Q?cXGAGC043YlAoYgLBLsjBnW/IJszg6WEGAZer7FQU6Mi8QHRq3hopDS6OOUo?=
 =?us-ascii?Q?NwHih2pzFtdYDoCpfhMXAtEasqUhmGjfjq66T6iADbjAz4bh97oSlveN7xN2?=
 =?us-ascii?Q?yxvw2vPGyCpvp3eODy1fFOmkRYmxJzhoFNzbzl+GC1IgaNjYBWU1MCqulyk+?=
 =?us-ascii?Q?4rSWLFu8lZyzZgQSATjs8q1NhM8FzFBRhFYvo3/Bllh4pNJrEsDSoICjm2l1?=
 =?us-ascii?Q?9PTn2UVFkMTLadWCWw8/3v7T8DxqKvEc0Syeef55Y8gW4f63u18y0egMBrRz?=
 =?us-ascii?Q?pQ4e2/hkK0fBw4rkdB9E1ujx+labqs6KCNfh/3PGvauESMZfBwA1CknEoVpX?=
 =?us-ascii?Q?W7mCacEqvCHLxIzK4dmhIjiq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d30efc6-6810-469d-115c-08d8cdd83bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 15:26:27.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRpiWRDXuRW2qDUVWJkzMWVf937tDgKisduj8eD6xY4BRGymyE/2M9xAbB/hg8jviBbKraw4k4g4EqrU3vkjGL+ZiRad9xjZWQAuiIE81Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3648
Message-ID-Hash: GLKK5BQLSSJMHG4XC5Y5W7M267HJMRE5
X-Message-ID-Hash: GLKK5BQLSSJMHG4XC5Y5W7M267HJMRE5
X-MailFrom: Ariel.Sibley@microchip.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, helgaas@kernel.org, cbrowy@avery-design.com, hch@infradead.org, david@redhat.com, rientjes@google.com, jcm@jonmasters.org, Jonathan.Cameron@Huawei.com, rafael.j.wysocki@intel.com, rdunlap@infradead.org, jgroves@micron.com, sean.v.kelley@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GLKK5BQLSSJMHG4XC5Y5W7M267HJMRE5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index c4ba3aa0a05d..08eaa8e52083 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -33,6 +33,24 @@ config CXL_MEM
> 
>           If unsure say 'm'.
> 
> +config CXL_MEM_RAW_COMMANDS
> +       bool "RAW Command Interface for Memory Devices"
> +       depends on CXL_MEM
> +       help
> +         Enable CXL RAW command interface.
> +
> +         The CXL driver ioctl interface may assign a kernel ioctl command
> +         number for each specification defined opcode. At any given point in
> +         time the number of opcodes that the specification defines and a device
> +         may implement may exceed the kernel's set of associated ioctl function
> +         numbers. The mismatch is either by omission, specification is too new,
> +         or by design. When prototyping new hardware, or developing /
> debugging
> +         the driver it is useful to be able to submit any possible command to
> +         the hardware, even commands that may crash the kernel due to their
> +         potential impact to memory currently in use by the kernel.
> +
> +         If developing CXL hardware or the driver say Y, otherwise say N.

Blocking RAW commands by default will prevent vendors from developing user space tools that utilize vendor specific commands. Vendors of CXL.mem devices should take ownership of ensuring any vendor defined commands that could cause user data to be exposed or corrupted are disabled at the device level for shipping configurations.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

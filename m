Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE69130FFB8
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Feb 2021 22:53:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08E70100EAB05;
	Thu,  4 Feb 2021 13:53:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.244.68; helo=nam12-mw2-obe.outbound.protection.outlook.com; envelope-from=jgroves@micron.com; receiver=<UNKNOWN> 
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 49BE5100EB32C
	for <linux-nvdimm@lists.01.org>; Thu,  4 Feb 2021 13:53:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2ZamvWORdKU60GQ02qJbA94Oa8qB3ESKTi+pihSm84y+EXLl+hocNKYT8gnE7s4waVoz3kfpMksUWqeArZQLTaw3fmdg5HNPJQd6+0RaKo0yP6m+SOcoT7sfZ2YqRNTtjyCfIve3R2t5tAYSTjw8TsmfngzfYjD8LPilU0j5DKn3Ilecy4C6dTwTCosntMNJW6+Q3NQcQ1vfPo5iMxiLgRrxR8hp4TTx2JHEjHz2HHBLjJzV0qEkaRnSy/gThawgPghyJyCdJ15FoyK7zJlxjdi21YsN0Tj5/0cZ8MsRH65VJJ3u5ZWoT0pGFRf2d611OGlDe73UDnTLVWqkWSDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHhWxFwvL5seV8qORlPcPZuWMOQNwjQiQXHWGYQCGXg=;
 b=EIfo0Inue923qQpNukQjs0aw1U8W28cOYRYvAS8bcGCov9VFaL92hK8w6BWIj8DVUdISIh83w/ZHbIxjb5IoUMD6w5mf2yifjArbtWBYW56WD/glwuInCReug7PMjCuiw2lHpx+ZDxaYZzkfWnDx1R2sUO4hQRtFdn2sRiMK1b8anUR8txmFkAES56jjri2SJo+hVUtT/LBJAd84hn7y2Sddd6kS74m3L3dHDxwXoZnqVxHF9P2kIa9asdalZ1R7oQt0fp365kBfqINfwazq8UOiJmSTobAhA2HPnbaBDDDu8/Yltm/X45z9kvB0LPjwJXa6zY/FsCHh6R53tFd+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHhWxFwvL5seV8qORlPcPZuWMOQNwjQiQXHWGYQCGXg=;
 b=mjM6CasHadriePpWmbEqwgAtJVsxmo66baySS6iXpseLUUBtxh5U/rC8vCw27vyaxhc4ty3jdqsryKV4tYAXi2X1pSPgNfBn33LnqUfGWeCdDEqtmaxE3D3As0XQF7btsXsGYPS4Q7UyJRwnYXUaqJYhjFxzK1d9tJ9r4EiUM28=
Received: from SN6PR08MB4605.namprd08.prod.outlook.com (2603:10b6:805:99::20)
 by SN6PR08MB4126.namprd08.prod.outlook.com (2603:10b6:805:1f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 21:53:30 +0000
Received: from SN6PR08MB4605.namprd08.prod.outlook.com
 ([fe80::fc97:e08f:1368:895]) by SN6PR08MB4605.namprd08.prod.outlook.com
 ([fe80::fc97:e08f:1368:895%6]) with mapi id 15.20.3825.020; Thu, 4 Feb 2021
 21:53:29 +0000
From: "John Groves (jgroves)" <jgroves@micron.com>
To: Dan Williams <dan.j.williams@intel.com>, Ben Widawsky
	<ben.widawsky@intel.com>
Subject: Re: [EXT] Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
Thread-Topic: [EXT] Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
Thread-Index: AQHW+MNm8l1QrW4wOEO7HhtD47UIUapDqw8AgAAEH4CABN6WMQ==
Date: Thu, 4 Feb 2021 21:53:29 +0000
Message-ID: 
 <SN6PR08MB46052FE9BC20A747CACD8F50D1B39@SN6PR08MB4605.namprd08.prod.outlook.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-5-ben.widawsky@intel.com>
 <20210201175400.GG197521@fedora>
 <20210201191316.e3kkkwqbx5fujp6y@intel.com>,<CAPcyv4hP6AOV1OQKbohCqczM1RUPQHQ07+7MuNJ1_p6+opLSQQ@mail.gmail.com>
In-Reply-To: 
 <CAPcyv4hP6AOV1OQKbohCqczM1RUPQHQ07+7MuNJ1_p6+opLSQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=True;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2021-02-04T21:49:42.4444100Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Privileged
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=micron.com;
x-originating-ip: [70.114.197.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3835b78-5f5a-45fc-69ef-08d8c9574f17
x-ms-traffictypediagnostic: SN6PR08MB4126:
x-microsoft-antispam-prvs: 
 <SN6PR08MB41261398AF0E20674B1C97ECD1B39@SN6PR08MB4126.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZDQFKMphTqIlLN9NbGZC052f3FIfz6po/+hOD7a62Uwg9KLUmoxUGj1VV6C0LdAAB72X92OM6S48o6Ed0Qvv1sj8bk4UUdDwpMtC9nn9OxcnjU2VA1K8Qcv5XNd2LHFd6FMwJ+rfp77s0+ouCGJVCgn8pukCdPWSzlwiZ92N3gxaud0PBjxs+VCLbZ/ozqBg+kV9fjcs3JJGgZmKF3XMX05Bt7tznj1SJUEV09utiytsBA0Gc7dRrCLpcPQqC74tlxf6rJiaPv+cChmbFnCMjGsALzQyOspZD+p/bC6FvHKw+lRpVaNMGPacAUG+dRGSB7RDaxEE1NHKAkituhUk/cngd+iRPaZVxlf7oJelJIvepeAATZBeJF9mC8qS93BO8LEPB/g6hWRS1Xf0Aub4i2iRD7aHgJLbrLY/jzMb5TFlmTaOl0p9Xbf90EhUSfJ/RsWa89xCbcqA1TQLdQc29AHEImYcBzKOw3y4OKaiiGB3pSdsnvZ12owBhBMAdjbenaMpMlxNJ09pKAg+RQkIfw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB4605.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(110136005)(55016002)(316002)(66556008)(9686003)(33656002)(478600001)(8676002)(54906003)(7416002)(52536014)(5660300002)(8936002)(64756008)(71200400001)(66446008)(7696005)(66946007)(76116006)(4326008)(66476007)(86362001)(186003)(26005)(83380400001)(2906002)(53546011)(6506007)(15650500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?//mg770urFHKX3IOwwOALQQD+Xn0Tg7I6n5R/GwJ0ViyWQGIXlHYmae6?=
 =?Windows-1252?Q?r90D5bfLd3438qgtSATBs0oRv4RuOXU44mbgqgcoRcR/+Exroq5yZDIf?=
 =?Windows-1252?Q?8JNQ1/HcxT35iC2ROPprhd5j8RN6JZ8f9gsieFqYCblSMb6YiHQ02Ev0?=
 =?Windows-1252?Q?ZHeLvxCZMhg/nMrFwFpsXfycvvL/RTmhiMQ19jb0mS77YamfH5tWth0V?=
 =?Windows-1252?Q?eeVKdxYSglzUa/pTiu4JIvrUPCnM8CXqoUvz3s2jSQkzeVziU0yr50Y0?=
 =?Windows-1252?Q?UYAiIynMvNKHU3Mowp5QkNRqDqq2vK+cv25qFUgeHYi1+rPBlqWzX/qV?=
 =?Windows-1252?Q?+4psM6vxox17oqXT9faEFAWNRIJT5KPnQcDMopVqIospfRP+emNUKlxK?=
 =?Windows-1252?Q?1hairbMBHrpiuZtAQB3w3qP66ab6vsU0QBzaGrMjJ5hpfQpdBcf5lk0i?=
 =?Windows-1252?Q?/TI9JbLhgH4pTvNhfTJHug+8g+R8BLUpMQpt8F6/+jn8+bKnXMiyy+YW?=
 =?Windows-1252?Q?zeGlPJ9MSeX6iu9Y+ZEJCRLvSs64G+KpGgoRDqYqxxQ+y816RPLWJu5I?=
 =?Windows-1252?Q?dOzhpkfj4s2ZMbpnmZ/uPdrVntrS45zFzcpmDQOj1w57G/rbsYxuoEoc?=
 =?Windows-1252?Q?QVP3ztn3dBuh0JyldT7eIahHkVeya3H6+UNZawnb+qFrOisQoGI0dAc+?=
 =?Windows-1252?Q?NX/HPXAffkkSPX/CJ9JsKtYOTO1XVRSSvzSZPc91IPdfTsTvATUa0VKy?=
 =?Windows-1252?Q?ZPBpWtnogSGBaZCpZmvFsfEY0hyo20tvg+lIOGQZPa1tNXj2/TqyL23J?=
 =?Windows-1252?Q?wdes/Y3kOWNNF0axaVJ6u4mLRl6YlrddHrSzEUy4VqKjbhvtc5S25zOl?=
 =?Windows-1252?Q?lAHOuB/VvPaWIQES1zjtHWmoAWMNGSpN/7lGm8gGq1dGLBm6NDeo3Vu1?=
 =?Windows-1252?Q?Zri4Vq9/Bj+Jo9Ej6z7J8uMlKCA5cYmjJoxrneuvwnzCC9XNjUx3ShEp?=
 =?Windows-1252?Q?jRsB4K4rEGhC9md4AgvRmSq2KWgyc4RWhbmg7jst7k5hRd7HQap7gVwH?=
 =?Windows-1252?Q?VIIdmaU4Q0IWo2lC6qJi0KaUduQX3VVaBzwDGLNwSySp0fSHlGBFuUNW?=
 =?Windows-1252?Q?aRM2p69ZH1wSZYC8KmBT7/BAmfhdikoZnT5ysWEFqwKjnVhn87qBIkrs?=
 =?Windows-1252?Q?f75iy2m2gk170+ZTpUaGKjXUx6t0YKGWnvKagumj+ABlcJE7cx/w4gpD?=
 =?Windows-1252?Q?OhYXOHU9OKUVkPTNxqiF1B/2ZFFV4ZruGfmVxZT/mpxG35QPCDCKbh4e?=
 =?Windows-1252?Q?+j0/N5UL0t0oevpIlinVAFd9Um7yTQQNzQk3Dj8601XBu9j7k7IumVKD?=
 =?Windows-1252?Q?n2DflGihl2TRNvq51Oihp2rqj4j14WxeVXRXauXbAcfRgHtthv3s71SE?=
 =?Windows-1252?Q?apddSudf0HOhi4I9wZBhiA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB4605.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3835b78-5f5a-45fc-69ef-08d8c9574f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 21:53:29.8507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egPIBbVe9vRc6gfDiI93977WzYQE2awQt79ViK6W0z6u8ed1JOjv4SGAIgUgQOdNi0hyUabGjUfv5hKstGndGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4126
Message-ID-Hash: ZGDZCWEADU3J27VGWBCWADEDHZM6DV5Q
X-Message-ID-Hash: ZGDZCWEADU3J27VGWBCWADEDHZM6DV5Q
X-MailFrom: jgroves@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "daniel.lll@alibaba-inc.com" <daniel.lll@alibaba-inc.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q6KM7ZVMJ4S4WMTKJZ4XSS3D6PNT3ZIK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Micron Confidential



From: Dan Williams <dan.j.williams@intel.com>
Date: Monday, February 1, 2021 at 1:28 PM
To: Ben Widawsky <ben.widawsky@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-cxl@vger.kernel.o=
rg <linux-cxl@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Li=
nux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux=
-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas=
 <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hel=
lwig <hch@infradead.org>, Ira Weiny <ira.weiny@intel.com>, Jon Masters <jcm=
@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wy=
socki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, V=
ishal Verma <vishal.l.verma@intel.com>, daniel.lll@alibaba-inc.com <daniel.=
lll@alibaba-inc.com>, John Groves (jgroves) <jgroves@micron.com>, Kelley, S=
ean V <sean.v.kelley@intel.com>
Subject: [EXT] Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you =
recognize the sender and were expecting this message.


On Mon, Feb 1, 2021 at 11:13 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-01 12:54:00, Konrad Rzeszutek Wilk wrote:
> > > +#define cxl_doorbell_busy(cxlm)                                     =
           \
> > > +   (cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET) &              =
      \
> > > +    CXLDEV_MB_CTRL_DOORBELL)
> > > +
> > > +#define CXL_MAILBOX_TIMEOUT_US 2000
> >
> > You been using the spec for the values. Is that number also from it ?
> >
>
> Yes it is. I'll add a comment with the spec reference.


From section 8.2.8.4 in the CXL 2.0 spec: =93The mailbox command timeout is=
 2 seconds.=94  So this should be:

#define CXL_MAILBOX_TIMEOUT_US 2000000

=85right? 2000us is 2ms=85

[snip]


Micron Confidential
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

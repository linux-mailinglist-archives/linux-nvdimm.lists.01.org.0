Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDEB217DF0
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 06:08:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A5CCB110BA96B;
	Tue,  7 Jul 2020 21:08:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.7.41; helo=eur04-he1-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F418B110B96A5
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 21:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKL+uC5bE4dFsU5eDWFNN9hq2e7PDF0lqPrghHSrnSg=;
 b=kCQK2OnbUTAEw8fTS6CRfloY6muMDn7kWpIfcCN8aty3TDroBB2NYAiY8LcyPtDl/fFqaKuzPcMjj0r0XmLapJ96zsOOhABqrbB553DjBQ1u53xdM0ZF1dZhJhc+zvAzEKupkirO9pJ8QWoSoXHI3mYZN89Mvz5MaIvcN8PbKuY=
Received: from AM6P194CA0006.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::19)
 by DB7PR08MB3017.eurprd08.prod.outlook.com (2603:10a6:5:1f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Wed, 8 Jul
 2020 04:08:30 +0000
Received: from VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::de) by AM6P194CA0006.outlook.office365.com
 (2603:10a6:209:90::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Wed, 8 Jul 2020 04:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT011.mail.protection.outlook.com (10.152.18.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 04:08:29 +0000
Received: ("Tessian outbound 114f46c34313:v62"); Wed, 08 Jul 2020 04:08:29 +0000
X-CR-MTA-TID: 64aa7808
Received: from 9ba354f06351.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 426D5FFC-BCA5-4C63-8ED0-11BEC10B32EB.1;
	Wed, 08 Jul 2020 04:08:24 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9ba354f06351.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Jul 2020 04:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0QCQnNp0tn76sSK3hKl7fXcy2xHlCQYDQcz9Ve69wSwc3/DL0rdPbli2nzEuLeCWBjUdEwoIhPkhdx2YM9UjfYw4gR79Cy+5SMzSF2HcPliItLc+1DuhMk6xzg5ZC/cpxRIiY0N/0dZx7ruoclUNZj/1RNiq3Pe85HISNZ7ZeOpWA0FDRXMFrDfNWNCcsqvCrCwU5lZcoiGsV3sIDOFKZtWEoViOHg9Mc/QJPZdqOQWesiO1TAJXrBpKuSdXUNVuZFTY77CN9iqw4+YsTNwrxzpZ4n3wgoG7gVhq6TXQ/SjfL5zfVZlm/Wmj2NK0ExHX5sIK9FvqgnZ+BePz5fvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKL+uC5bE4dFsU5eDWFNN9hq2e7PDF0lqPrghHSrnSg=;
 b=LtJtwpl33vBLm+azO8XwJEQ/gjqa24jqYFMYnjgsBFsYX0/Zhl2iRgpMIoq8UBANribz6DjUbRAmFwJjM3Y72UNAzvPoSfugC42KS6h8ScNctvtdTW7WIpF9ae2IpIC2Ejsrds79AOndYupEfdY1YMpJeA2SFeN68D+ooklGY+SEecW5MD44rqxjM64IKfJyZwBYFuGqV98P/ZSSe2e0LFn+nV1C6s7J1vASPNb2v4f8RItC/vyHRpbrZ+25DrIXKSjA5QzKvHzwNIGiArChfI7vaxw+dG56RUKgI1jFpMLlWfTnIL9nBk/3RCXLX+zHaKbXm2iMhShvopsV+zACtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKL+uC5bE4dFsU5eDWFNN9hq2e7PDF0lqPrghHSrnSg=;
 b=kCQK2OnbUTAEw8fTS6CRfloY6muMDn7kWpIfcCN8aty3TDroBB2NYAiY8LcyPtDl/fFqaKuzPcMjj0r0XmLapJ96zsOOhABqrbB553DjBQ1u53xdM0ZF1dZhJhc+zvAzEKupkirO9pJ8QWoSoXHI3mYZN89Mvz5MaIvcN8PbKuY=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB4536.eurprd08.prod.outlook.com (2603:10a6:20b:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 04:08:22 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 04:08:22 +0000
From: Justin He <Justin.He@arm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Thread-Topic: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Thread-Index: AQHWVCPSGGxRNvjq20KjOcC2mjPWIqj8ApMAgADwVZCAABxdAIAAAVUw
Date: Wed, 8 Jul 2020 04:08:22 +0000
Message-ID: 
 <AM6PR08MB4069D0D1FD8FB31B6A56DDB5F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
In-Reply-To: 
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 53974128-d14d-4a70-85c9-8bb860a20d6b.1
x-checkrecipientchecked: true
Authentication-Results-Original: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd2545a3-ed55-4940-b49d-08d822f49279
x-ms-traffictypediagnostic: AM6PR08MB4536:|DB7PR08MB3017:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: 
	<DB7PR08MB3017A5C831A8730FF3ADF058F7670@DB7PR08MB3017.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 94B9ujPrF2FPr7Z3xjZUdzaxqz8sZ74G2A9P6iocoYTUDnNoex1dSQOCSB+yErccE/sKv7XYJAfnktU94trd7+zNuOe2MN4cFvzZmn7GPUaWO21hhydIgFAe8n1XaQBO767250/9FtRAaQgRJBg+5baMq+V5NvDB3z5kxuHiS3LFuop5GROpg4MWLtb5x7cvxVrgZquNp4iTTg2YK+wjSXvCJkxF5R0ra7u4xubo5SBCxK1YKIz8peuzPLYRo5ahmhuqTpDblAy2w6veHKDrDhJcWRhtjwVXOM/p4irUDM4SOMJxup2veKnHhOze2aL0Z5mkqrHKpv3OvAemUVNRFg==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(366004)(136003)(346002)(376002)(55016002)(8936002)(7416002)(478600001)(9686003)(316002)(86362001)(33656002)(8676002)(53546011)(186003)(6506007)(26005)(5660300002)(7696005)(52536014)(71200400001)(54906003)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(2906002)(4326008)(83380400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 yw9lJE8pLGxjwMQln8AO8921NYl/dd66f8k0jfPknRfdT7UqdwEIsihiLSEmPaRwOTh7pvkuyubblwy1+j5o6PyIocnapLmJ2jIhsZMqFGGQpSRefJolNvJuy3M91/muqKyKRTwkAss7C3cgKttBtIAPyDcLABrMhfQ1NwlirL6lgm4TSi9JQLk1idSlvtJV9p+c8BChpmEqD8aJbjN5uFB5bP7D8u8gnVhPWGMxgYnUoWZKt6mut2L1g1hNHD2v64rfWYQAj2rMxk93H2v49WgQRVNQ/bvsoH3NqvcUlDoAsZSPQhwcSnRudBmGqLdpAOYKCD+i9yUhbXcW1YnBBFBjxnCQ4hgQ3Go3GzQquLbVIAaIMbOaXmYKhDf41gG9FGRS7OqgzqybAwNmKl3vkKZ8jNdXmyV4CuqzoJrzyK0jpVI2ej3DsXWI4TShbTVphdpi3bwqf9wyJ7hsn0Ys3OKE2OKI8/yGNdp8gYUgKtA=
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4536
Original-Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(346002)(396003)(376002)(136003)(46966005)(83380400001)(26005)(8676002)(33656002)(53546011)(70206006)(82310400002)(70586007)(36906005)(4326008)(8936002)(6862004)(356005)(478600001)(6506007)(81166007)(7696005)(82740400003)(316002)(86362001)(5660300002)(186003)(2906002)(55016002)(54906003)(9686003)(336012)(52536014)(47076004);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	4162fb3f-ccf9-43e9-dfe3-08d822f48e68
X-Forefront-PRVS: 04583CED1A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H6t559vlvnSs0wGsilA5rbhI27YjQ4autbyOBApMMmZe+YK58YqbU84/TPi3RuMNJGJSQ95Spco6gvSwedGF2AkQ8TYycIGemB7gEukuR8Rj7AWa+296OZ6Zu6CqssX0UXmClnCgCJKYH3SKW6H6wEn5jQqINc7+3eX1XOJv8KTAxx6ZzQn8iSoDolVki8S03valJl9zSmIR9VSgk6Tt8ccYBY9SdAdSWuJCkD1KYj14hcd2IRk//Z6Ogo+T8IiUiY36K+eM+cjw9dS5UYY9w1Ukr7aBlZEX+RURThnIpDYHvBokMTBRE5ce4jZmixotKGcknSYi/aYqhkWLWpcwEJcygDGY/vnADZZabdMeBXqWPGTpwPKrG5xJPLTaW0svmqGIkK2Jhbj73H+Fp2TIpw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 04:08:29.6549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2545a3-ed55-4940-b49d-08d822f49279
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3017
Message-ID-Hash: 6RKTANAXR4FVDRR7BK6PACFDOGFPDIZJ
X-Message-ID-Hash: 6RKTANAXR4FVDRR7BK6PACFDOGFPDIZJ
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5XUBKJYBBTYHJOS2KO3UX4LE3TCPU7TK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan

> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Wednesday, July 8, 2020 11:57 AM
> To: Justin He <Justin.He@arm.com>
> Cc: Michal Hocko <mhocko@kernel.org>; David Hildenbrand <david@redhat.com>;
> Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon <will@kernel.org>;
> Vishal Verma <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>;
> Andrew Morton <akpm@linux-foundation.org>; Mike Rapoport
> <rppt@linux.ibm.com>; Baoquan He <bhe@redhat.com>; Chuhong Yuan
> <hslester96@gmail.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-mm@kvack.org; linux-nvdimm@lists.01.org;
> Kaly Xin <Kaly.Xin@arm.com>
> Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid
> as EXPORT_SYMBOL_GPL
> 
> On Tue, Jul 7, 2020 at 7:20 PM Justin He <Justin.He@arm.com> wrote:
> >
> > Hi Michal and David
> >
> > > -----Original Message-----
> > > From: Michal Hocko <mhocko@kernel.org>
> > > Sent: Tuesday, July 7, 2020 7:55 PM
> > > To: Justin He <Justin.He@arm.com>
> > > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> > > <will@kernel.org>; Dan Williams <dan.j.williams@intel.com>; Vishal
> Verma
> > > <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Andrew
> > > Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>;
> > > Baoquan He <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>;
> linux-
> > > arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > > mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin <Kaly.Xin@arm.com>
> > > Subject: Re: [PATCH v2 1/3] arm64/numa: export
> memory_add_physaddr_to_nid
> > > as EXPORT_SYMBOL_GPL
> > >
> > > On Tue 07-07-20 13:59:15, Jia He wrote:
> > > > This exports memory_add_physaddr_to_nid() for module driver to use.
> > > >
> > > > memory_add_physaddr_to_nid() is a fallback option to get the nid in
> case
> > > > NUMA_NO_NID is detected.
> > > >
> > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > Signed-off-by: Jia He <justin.he@arm.com>
> > > > ---
> > > >  arch/arm64/mm/numa.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > > > index aafcee3e3f7e..7eeb31740248 100644
> > > > --- a/arch/arm64/mm/numa.c
> > > > +++ b/arch/arm64/mm/numa.c
> > > > @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> > > >
> > > >  /*
> > > >   * We hope that we will be hotplugging memory on nodes we already
> know
> > > about,
> > > > - * such that acpi_get_node() succeeds and we never fall back to
> this...
> > > > + * such that acpi_get_node() succeeds. But when SRAT is not present,
> > > the node
> > > > + * id may be probed as NUMA_NO_NODE by acpi, Here provide a
> fallback
> > > option.
> > > >   */
> > > >  int memory_add_physaddr_to_nid(u64 addr)
> > > >  {
> > > > -   pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n",
> > > addr);
> > > >     return 0;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > >
> > > Does it make sense to export a noop function? Wouldn't make more sense
> > > to simply make it static inline somewhere in a header? I haven't
> checked
> > > whether there is an easy way to do that sanely bu this just hit my
> eyes.
> >
> > Okay, I can make a change in memory_hotplug.h, sth like:
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -149,13 +149,13 @@ int add_pages(int nid, unsigned long start_pfn,
> unsigned long nr_pages,
> >               struct mhp_params *params);
> >  #endif /* ARCH_HAS_ADD_PAGES */
> >
> > -#ifdef CONFIG_NUMA
> > -extern int memory_add_physaddr_to_nid(u64 start);
> > -#else
> > +#if !defined(CONFIG_NUMA) || !defined(memory_add_physaddr_to_nid)
> >  static inline int memory_add_physaddr_to_nid(u64 start)
> >  {
> >         return 0;
> >  }
> > +#else
> > +extern int memory_add_physaddr_to_nid(u64 start);
> >  #endif
> >
> > And then check the memory_add_physaddr_to_nid() helper on all arches,
> > if it is noop(return 0), I can simply remove it.
> > if it is not noop, after the helper,
> > #define memory_add_physaddr_to_nid
> >
> > What do you think of this proposal?
> 
> Especially for architectures that use memblock info for numa info
> (which seems to be everyone except x86) why not implement a generic
> memory_add_physaddr_to_nid() that does:
> 
> int memory_add_physaddr_to_nid(u64 addr)
> {
>         unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
>         int nid;
> 
>         for_each_online_node(nid) {
>                 get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
>                 if (pfn >= start_pfn && pfn <= end_pfn)
>                         return nid;
>         }
>         return NUMA_NO_NODE;
> }

Thanks for your suggestion,
Could I wrap the codes and let memory_add_physaddr_to_nid simply invoke
phys_to_target_node()? 


--
Cheers,
Justin (Jia He)


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

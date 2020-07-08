Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3EA218008
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 08:56:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8331E110BDB30;
	Tue,  7 Jul 2020 23:56:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.3.76; helo=eur03-am5-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30076.outbound.protection.outlook.com [40.107.3.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C581E110BC288
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 23:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9KjTfjizXxP12ARgMEOLY8C/RR4KIvup9neUM1k+CI=;
 b=erN3b8Bvy8cR8hK/mbpieykrvfUSCyz3ztbtX5k6cQXXr/iZ5ywlr2RgHklwtcsyHXWI5BxU4m994yPNjgb2PGrfjwSRO69SVOmS8aSxNsqoe+aMOcEuzNwO1dhBik/xyuvZnVe92V5gYh6i0rvPotFdewKzTqMfIDINSuUu2as=
Received: from AM6PR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::18) by AM7PR08MB5430.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Wed, 8 Jul
 2020 06:56:45 +0000
Received: from AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::a) by AM6PR01CA0041.outlook.office365.com
 (2603:10a6:20b:e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Wed, 8 Jul 2020 06:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT061.mail.protection.outlook.com (10.152.16.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 06:56:45 +0000
Received: ("Tessian outbound 2dd9eeca983c:v62"); Wed, 08 Jul 2020 06:56:44 +0000
X-CR-MTA-TID: 64aa7808
Received: from fbe4b376364c.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2B1B6EC7-E5AB-451C-99A5-5A00DDD691A8.1;
	Wed, 08 Jul 2020 06:56:39 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fbe4b376364c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Jul 2020 06:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5+l5NxJoH0uaQT7lWJoqPic94y+y8fZFv3d44185dyHZ2O3e8t94eesgxUAp2wOx2p/m+iyVPa2l7mQyY7DdRMODyFAec04TaJx+BxHbyNj1vFWdc436yJ9WcqNobOYTkgjEqbMx5+0IkEXRekJXBFnbjzznGpqHMOgIgq4DBeD4WPvEiFcluQZK/bCEd6eU9tzHUOTZRLMzv1F/H4BUmHVEicAljrw/pob4q3oh8h7pd/mCNCYqli8UoH7uNteo3bP6e9fgXqVZAMgVxV4LqUI6pN+V7ss0ft3Qxuocu277gqMbJDPPMqutrF+FPNvue0S4RG2G1XnKhMhhUSWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9KjTfjizXxP12ARgMEOLY8C/RR4KIvup9neUM1k+CI=;
 b=a9T/pJIbog/HwLFJbITrl3IjYPjhY4wBLdstpGaqaLwgIbZdCMuKKsvbkPjTdgAYrzoyJonb3qj53ylwGBANDnS2V8xhhn2R6KElhIbnOMTODg9bWRmdRw93A9o8fFbbXfv0RXdj7SvHcovCnx5GHbk0yM8GbigGeqcttzv8MhcnIFArZqUnlEWTwkJaI0ntkhndeyy4KyZVOe3QiUF3tiH6/vDU7bYNeKvUz9af7Y9RHBqxPtHTXH5bgvdG0Ot8Duz4w2JBhSrqp4sAtVxUQ/JngjY8qf7aMzk8JjUiSyKQCqiluxW6G1wcX6eT7TeXqdpjeQN38+EabAveQBDtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9KjTfjizXxP12ARgMEOLY8C/RR4KIvup9neUM1k+CI=;
 b=erN3b8Bvy8cR8hK/mbpieykrvfUSCyz3ztbtX5k6cQXXr/iZ5ywlr2RgHklwtcsyHXWI5BxU4m994yPNjgb2PGrfjwSRO69SVOmS8aSxNsqoe+aMOcEuzNwO1dhBik/xyuvZnVe92V5gYh6i0rvPotFdewKzTqMfIDINSuUu2as=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB5207.eurprd08.prod.outlook.com (2603:10a6:20b:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 06:56:38 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 06:56:38 +0000
From: Justin He <Justin.He@arm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Thread-Topic: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Thread-Index: 
 AQHWVCPSGGxRNvjq20KjOcC2mjPWIqj8ApMAgADwVZCAABxdAIAAGtaAgAAEYYCAAAZuAA==
Date: Wed, 8 Jul 2020 06:56:38 +0000
Message-ID: 
 <AM6PR08MB4069AC46B435AB32BE9E2834F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
 <20200708053239.GC386073@linux.ibm.com>
 <CAPcyv4i2gnrugO5n715WsDoj+gxV9Mjt-49zNnv+ROMLYy79LQ@mail.gmail.com>
In-Reply-To: 
 <CAPcyv4i2gnrugO5n715WsDoj+gxV9Mjt-49zNnv+ROMLYy79LQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 3c8e218e-6f3c-4a46-9bef-c6f091b1f269.1
x-checkrecipientchecked: true
x-ts-email-id: e84b7eec-f554-4438-b455-78fea75428a0
Authentication-Results-Original: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02fab350-c89e-4909-e553-08d8230c13d7
x-ms-traffictypediagnostic: AM6PR08MB5207:|AM7PR08MB5430:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: 
	<AM7PR08MB543091FEBD84AAD9AC206E0CF7670@AM7PR08MB5430.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 CszeoZH6fTvkeGvibgxoPRlL0u+f+yH40fgMmgnXdybxhz9RSDBJeY54VmNCiK18HgzhAnjpUIVMKakpmIRHwunpDJzWDL3HT2tpRsXPOxMUH5xLB2xPjpv508EwN4MZ/bVC0rd/hJzLsPC3a+QvzUifNR6GnSJFAln5JmtLfflD/YxDtn0aAv+A3X+mdVe86jFC6Rt63gU+UNkJ1opoEcJwbWsm9iYboJLcCu1bRL6cgJFPS8jcfb1zrv8rjFDoiLdQXrfWCAKrjoqw9EnWpwhfMvFE1xMc10MjBTfjPOOycc3xZRUPUVhTBO3XxgIv6S9uKGcKySaNjgZWnc6Dnw==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(6506007)(54906003)(316002)(76116006)(5660300002)(66946007)(71200400001)(33656002)(66476007)(64756008)(66446008)(7696005)(66556008)(9686003)(52536014)(86362001)(55016002)(53546011)(4326008)(26005)(186003)(83380400001)(6916009)(2906002)(478600001)(7416002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 HTUGYcHGLQKTjaXgYz0Q2ELj4Lq5828sWd1gJJCufB3LYS4BUjcygeLjxa9c7vzFVPvc2+KiEry6sKPWruXGq2L5jdMy58bPDBGsXnKkYNxSAjjEKbpQnJVK1aBtaQnHbOLvEppKqnH+vBY0BmR8K8gCaRi83kIv+bcu9k13KZzvZME/FRyWhMeu1l8rRr6YxvurzLet0wNutFMk7/sXf1PATXn5G5mtAeMYMs5yBF6EawiknLzRXE8uz3UXzT39DYLKmKw6eIruq3j9wSM4PBOWOtT7D6TohN+aVebjQSyC7K2R3E36hT728IwS7HgU+WU0G0BwbOuobZfOUpKW9cxPyAEa2z2w2GX+FhhHzK0KcIC3R3YnNZva3BM1VX8qReEiSNp0U5kfIjvYEN3ORog40Re2fdiCREmGFyNv7+ERcqNMb8BPht9qO5XjnrPPRZxQJJbs+B7db0gyL5p0XviB+pGWpYx6/Bo6VYzmVII=
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5207
Original-Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966005)(8936002)(26005)(36906005)(6506007)(53546011)(9686003)(186003)(47076004)(70586007)(70206006)(33656002)(83380400001)(316002)(4326008)(8676002)(6862004)(478600001)(336012)(356005)(2906002)(82310400002)(55016002)(86362001)(82740400003)(5660300002)(7696005)(81166007)(52536014)(54906003);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	dec253fb-8144-45a6-381c-08d8230c1004
X-Forefront-PRVS: 04583CED1A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XHUFOXnANEaJ748gUhFN+7LIgOEfp1/F05rX7uaZVLeBolHOzT1hRkbQiEJ69uhP8SHggapPjQRKu6jM7ySXLODERgJBmfWuMNQZtXESZ6BryNoiDv+pE1qpo1knBL7rucj8K+NsAb11m3+9umikzKKiikJcD0VxOamdxSpibW0v0qmcBaVOVI5z5bR+7qZ3bOWRlKMsRkCHFiw5laDFyDtKNO2uWma8MRitsmFrpSENiNzxCeBpA2OQgPB+TuX+yv2oJav9QCBNwxM+5aFwkCNyZW5Ht5ccldhaqCygY+85e5N90QDEOwAt7rKUhktG4+P5gzl2pExXKprKmV7JAY8ilglNCpUs/y8AEFfZkyjc3dKnjZau++7W+NJXAxqeApB7G7KW3DLp9DkDo/RXLw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 06:56:45.1611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fab350-c89e-4909-e553-08d8230c13d7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Message-ID-Hash: DGTG7CGZGYAW5CCZ3C4QSP6OCTHUI3E3
X-Message-ID-Hash: DGTG7CGZGYAW5CCZ3C4QSP6OCTHUI3E3
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>, Mike Rapoport <rppt@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D2C2J2XQ4BM5OHGPJL3GFQO2GLGKUKK3/>
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
> Sent: Wednesday, July 8, 2020 1:48 PM
> To: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Justin He <Justin.He@arm.com>; Michal Hocko <mhocko@kernel.org>; David
> Hildenbrand <david@redhat.com>; Catalin Marinas <Catalin.Marinas@arm.com>;
> Will Deacon <will@kernel.org>; Vishal Verma <vishal.l.verma@intel.com>;
> Dave Jiang <dave.jiang@intel.com>; Andrew Morton <akpm@linux-
> foundation.org>; Baoquan He <bhe@redhat.com>; Chuhong Yuan
> <hslester96@gmail.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-mm@kvack.org; linux-nvdimm@lists.01.org;
> Kaly Xin <Kaly.Xin@arm.com>
> Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid
> as EXPORT_SYMBOL_GPL
> 
> On Tue, Jul 7, 2020 at 10:33 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Tue, Jul 07, 2020 at 08:56:36PM -0700, Dan Williams wrote:
> > > On Tue, Jul 7, 2020 at 7:20 PM Justin He <Justin.He@arm.com> wrote:
> > > >
> > > > Hi Michal and David
> > > >
> > > > > -----Original Message-----
> > > > > From: Michal Hocko <mhocko@kernel.org>
> > > > > Sent: Tuesday, July 7, 2020 7:55 PM
> > > > > To: Justin He <Justin.He@arm.com>
> > > > > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> > > > > <will@kernel.org>; Dan Williams <dan.j.williams@intel.com>; Vishal
> Verma
> > > > > <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>;
> Andrew
> > > > > Morton <akpm@linux-foundation.org>; Mike Rapoport
> <rppt@linux.ibm.com>;
> > > > > Baoquan He <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>;
> linux-
> > > > > arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-
> > > > > mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin
> <Kaly.Xin@arm.com>
> > > > > Subject: Re: [PATCH v2 1/3] arm64/numa: export
> memory_add_physaddr_to_nid
> > > > > as EXPORT_SYMBOL_GPL
> > > > >
> > > > > On Tue 07-07-20 13:59:15, Jia He wrote:
> > > > > > This exports memory_add_physaddr_to_nid() for module driver to
> use.
> > > > > >
> > > > > > memory_add_physaddr_to_nid() is a fallback option to get the nid
> in case
> > > > > > NUMA_NO_NID is detected.
> > > > > >
> > > > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > > > Signed-off-by: Jia He <justin.he@arm.com>
> > > > > > ---
> > > > > >  arch/arm64/mm/numa.c | 5 +++--
> > > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > > > > > index aafcee3e3f7e..7eeb31740248 100644
> > > > > > --- a/arch/arm64/mm/numa.c
> > > > > > +++ b/arch/arm64/mm/numa.c
> > > > > > @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> > > > > >
> > > > > >  /*
> > > > > >   * We hope that we will be hotplugging memory on nodes we
> already know
> > > > > about,
> > > > > > - * such that acpi_get_node() succeeds and we never fall back to
> this...
> > > > > > + * such that acpi_get_node() succeeds. But when SRAT is not
> present,
> > > > > the node
> > > > > > + * id may be probed as NUMA_NO_NODE by acpi, Here provide a
> fallback
> > > > > option.
> > > > > >   */
> > > > > >  int memory_add_physaddr_to_nid(u64 addr)
> > > > > >  {
> > > > > > -   pr_warn("Unknown node for memory at 0x%llx, assuming node
> 0\n",
> > > > > addr);
> > > > > >     return 0;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > > > >
> > > > > Does it make sense to export a noop function? Wouldn't make more
> sense
> > > > > to simply make it static inline somewhere in a header? I haven't
> checked
> > > > > whether there is an easy way to do that sanely bu this just hit my
> eyes.
> > > >
> > > > Okay, I can make a change in memory_hotplug.h, sth like:
> > > > --- a/include/linux/memory_hotplug.h
> > > > +++ b/include/linux/memory_hotplug.h
> > > > @@ -149,13 +149,13 @@ int add_pages(int nid, unsigned long start_pfn,
> unsigned long nr_pages,
> > > >               struct mhp_params *params);
> > > >  #endif /* ARCH_HAS_ADD_PAGES */
> > > >
> > > > -#ifdef CONFIG_NUMA
> > > > -extern int memory_add_physaddr_to_nid(u64 start);
> > > > -#else
> > > > +#if !defined(CONFIG_NUMA) || !defined(memory_add_physaddr_to_nid)
> > > >  static inline int memory_add_physaddr_to_nid(u64 start)
> > > >  {
> > > >         return 0;
> > > >  }
> > > > +#else
> > > > +extern int memory_add_physaddr_to_nid(u64 start);
> > > >  #endif
> > > >
> > > > And then check the memory_add_physaddr_to_nid() helper on all arches,
> > > > if it is noop(return 0), I can simply remove it.
> > > > if it is not noop, after the helper,
> > > > #define memory_add_physaddr_to_nid
> > > >
> > > > What do you think of this proposal?
> > >
> > > Especially for architectures that use memblock info for numa info
> > > (which seems to be everyone except x86) why not implement a generic
> > > memory_add_physaddr_to_nid() that does:
> >
> > That would be only arm64.
> >
> 
> Darn, I saw ARCH_KEEP_MEMBLOCK and had delusions of grandeur that it
> could solve my numa api woes. At least for x86 the problem is already
> solved with reserved numa_meminfo, but now I'm trying to write generic
> drivers that use those apis and finding these gaps on other archs.

Even on arm64, there is a dependency issue in dax_pmem kmem case.
If dax pmem uses memory_add_physaddr_to_nid() to decide which node that
memblock should add into, get_pfn_range_for_nid() might not have
the correct memblock info at that time. That is, get_pfn_range_for_nid()
can't get the correct memblock info before add_memory()

So IMO, memory_add_physaddr_to_nid() still have to implement as noop on
arm64 (return 0) together with sh,s390x? Powerpc, x86,ia64 can use their
own implementation. And phys_to_target_node() can use your suggested(
for_each_online_node() ...)

What do you think of it? Thanks

--
Cheers,
Justin (Jia He)


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

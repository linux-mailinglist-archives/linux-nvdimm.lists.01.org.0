Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4E219C67
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 11:37:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 834CB1141F7AB;
	Thu,  9 Jul 2020 02:37:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.6.79; helo=eur04-db3-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0AE531141F7A8
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jul 2020 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNkJ1GT23bvVx7BKqyG/rMU6wJA3ldpjaggg8j/RWz4=;
 b=xQRmKImmnytsy8+mYv45XybSb71RGGbGRoDBT+mv6eeyfvUEKVaKSnZdr7SM5GSDdQffCbZB7YtTONS2sDpc6hVbcv1XqoXx8Fck4qs5/FIAAB4GOrYorFSrtdvxqiSc/IacUxm4qJ0S6K7xqMEifEAQOWQWLps35n95aliox2o=
Received: from AM5P194CA0012.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::22)
 by HE1PR08MB2777.eurprd08.prod.outlook.com (2603:10a6:7:2e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 9 Jul
 2020 09:36:53 +0000
Received: from VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:8f:cafe::83) by AM5P194CA0012.outlook.office365.com
 (2603:10a6:203:8f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Thu, 9 Jul 2020 09:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT010.mail.protection.outlook.com (10.152.18.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 09:36:53 +0000
Received: ("Tessian outbound 73b502bf693a:v62"); Thu, 09 Jul 2020 09:36:51 +0000
X-CR-MTA-TID: 64aa7808
Received: from e4cf6cc6711d.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8C2728F8-1433-4020-A5A6-DB44C55AFBD7.1;
	Thu, 09 Jul 2020 09:36:46 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e4cf6cc6711d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 09 Jul 2020 09:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJLfq9G1JAhsSfpJYU8hZVWH2i6OpreXtBVmZSh9ht9Gvpeic7CDSKSOO/5UpKsGGdYHn9W7tKfbnPP5rdYKsBBRUqh6ERaZxNKDpxyLnAU/6HjFemjbr+I7XJC2cA9YDx8gLUAVI+nN0uautfgJtdmseJvHTvOqiMW0WRezeJibtSsqL527VdfVyo+Q6PuKGyBsy4jmLPv51xS0Eu2Yz/g2BK37RQfzkMOJ3m8+3pYyr0z0NwYGGhaIXdLdqsdN+hLUt1bvFf4yot7/T3ezqEpuzcuQ9cILvizDzxUrwyT/MwULJdZ/ya6M/IJLtaYXLwCW9fNW7JIeiKI7b2EumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNkJ1GT23bvVx7BKqyG/rMU6wJA3ldpjaggg8j/RWz4=;
 b=SGuJPa/tEUGBQQv2sbwMUSyTnadicyNAR/QYtdK3p/WFV3aErkn+ep/VUaRpJvt0PMQAXslImDmK8Yfn0yaIczqXVB7L7QtYpipUGI/0mBlhzk4lqD9Qvaah5AyXuT7w7he6xFWDLRKjhq8gXVBVZvqoqTNYYOy5wlskJpKBOyP9XYtqZ8oswiV4iuOeV5YIHwasCni/3fPuXKpeO25erjR6TXWzs/AGC4OjktDa/xEuBMdOsuGhx8YZTrrdDHujgMqBJJ5hpMolqFrQrbILOr3Bz5cLv4Zu+/RQmqrmPfXRppZayyD42gF++Vf85Z5mNCq5BarhBvpXqIVQJSHaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNkJ1GT23bvVx7BKqyG/rMU6wJA3ldpjaggg8j/RWz4=;
 b=xQRmKImmnytsy8+mYv45XybSb71RGGbGRoDBT+mv6eeyfvUEKVaKSnZdr7SM5GSDdQffCbZB7YtTONS2sDpc6hVbcv1XqoXx8Fck4qs5/FIAAB4GOrYorFSrtdvxqiSc/IacUxm4qJ0S6K7xqMEifEAQOWQWLps35n95aliox2o=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB4408.eurprd08.prod.outlook.com (2603:10a6:20b:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Thu, 9 Jul
 2020 09:36:43 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 09:36:43 +0000
From: Justin He <Justin.He@arm.com>
To: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: RE: [PATCH v3 4/6] mm: don't export memory_add_physaddr_to_nid in
 arch specific directory
Thread-Topic: [PATCH v3 4/6] mm: don't export memory_add_physaddr_to_nid in
 arch specific directory
Thread-Index: AQHWVZW4cB9QLv1x3USSUrS3ZjVOOaj+gToAgAB3WoCAAAAygIAABM2g
Date: Thu, 9 Jul 2020 09:36:42 +0000
Message-ID: 
 <AM6PR08MB406932241B7FB3753B77B113F7640@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200709020629.91671-1-justin.he@arm.com>
 <20200709020629.91671-5-justin.he@arm.com>
 <20200709021104.GZ25523@casper.infradead.org>
 <20200709091815.GF781326@linux.ibm.com>
 <49a53674-f246-fdd6-009b-447a88cdb68e@redhat.com>
In-Reply-To: <49a53674-f246-fdd6-009b-447a88cdb68e@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 2231c3a8-8a59-4901-a186-35c2b1673aa8.0
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 409e15e8-1ebb-4b3e-3751-08d823eb9d05
x-ms-traffictypediagnostic: AM6PR08MB4408:|HE1PR08MB2777:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: 
	<HE1PR08MB27770F5129C8F5841693C0BBF7640@HE1PR08MB2777.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:220;OLM:220;
x-forefront-prvs: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 6hx1R9TLODq9DK6z3C4G5SvHatMqwOS7s7RM7Bg4GVdNU0SR+QOZ9Kr/It7d4u5QqBH1TqSHEYVM0ksIZgMarnSbxjbUwDcvHksO/3QjshScfcp5iWbc0UhMm1T0i9I2U+VNTMEwkYEw3fUQwu1ocVZ8rpB1Y9U7DHqjJdsLdRqerz7H0O92AcTU9sdgJbbCZdeYjCGZ392Uzk3xNa0m8PkBSGEljnHx0OCV/9fBb7kbWSJn4h4H7Wgnj2P7vdU2CYGq66T/AJsDz5O1g94PpP/0q4zBwOCsbQAUBGEPxAfImF49xzpADLDsf6UCDEFfagygCCaUcwiNVbNyrWeW5g==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(316002)(6506007)(54906003)(110136005)(9686003)(86362001)(8676002)(52536014)(83380400001)(53546011)(5660300002)(26005)(33656002)(2906002)(66446008)(66476007)(64756008)(66556008)(66946007)(478600001)(55016002)(4326008)(71200400001)(7696005)(7416002)(186003)(8936002)(76116006)(7406005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 LdVu64nkDjfdyPLZTLUM6C2bEskHMWCv56YV+OF7Of9zHgd9RyMCezG6mJvzV4a8PqKOR1Ld0aTUnl5d6DIk+TsjPOge5TTRWrLYC8ym1A6tYDorTXTw9o8RiPaDu2KH6uYxl4cIVtiGRAmeadOm9hPt0dy/kcUF8xZq/J6B74yHNUShv/RgWOp9yh0YiitOyG55cDurlzRxz+o3iGAiUGZlCNeyNF96vc3ZWvZiZWzO3cxIzMOJdim+caMvbSDE3hH7LGonLnZtdvSdMiI7YT/5K0Y0JKJIFDEulvXwSq0NrgIQdl8VG/QqoR9fK3aO0HKHn8/XTfEYcQIbZ+TqtyQNyZYO8Bqe61PsrC1g/vWwfdPSi8w+MbkkPOQw8aUAHPulP/TJYQIavdkXo7H+EZKVx2NfK3e16L3rKt36v6KOxa6Z+V8K2jxEqIle+uVDAH7aGPJWzKe/QQyWXdlCjgqgCxkSqwzYyQsaI2Jk8WA=
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4408
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966005)(2906002)(4326008)(83380400001)(7696005)(186003)(81166007)(8936002)(82310400002)(336012)(356005)(8676002)(70206006)(70586007)(9686003)(86362001)(52536014)(316002)(478600001)(55016002)(26005)(54906003)(82740400003)(5660300002)(110136005)(47076004)(6506007)(53546011)(33656002)(36906005);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	169e7c69-2863-4e2c-df06-08d823eb971e
X-Forefront-PRVS: 04599F3534
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ANnK2qA3OIaNuLYa+eTUY4BJRYkeZEhAwFlH97SmQIcYZGUO8F4RXlLk/+TbZRZF8Oz8a6lQxdfEewtLV6mcmlmPG+FLzeQ9GweLfSdIScsF336XXaduRnzs0drAwBIzM48c/BdtG4c/rKMAJzZ/MLdAKG4d81Mrsqht7bnQOagb8L8JQ9Amv8Fuhpr6BdiMzxTXFi98O9Vr2BOGea2K/0L34mDpdV/6NTkRnwZ/74qXyqdd+Iv8cldxarMeglc/hdckDXu89B0XBjWg1aiNmVL/g7I2CGcFhkH078/AL3sAbzOiZPvbZpjVl2kFPKPYARRnyWysST6AknQWGFfY6yRPRf1l7phWLHb4+EbHxy6wHaYOGJ1Ch0dKzizcME15Afs/qokwqFbpXdZEX7b8pg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 09:36:53.0427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409e15e8-1ebb-4b3e-3751-08d823eb9d05
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2777
Message-ID-Hash: CTSGDIZRR6YVU647ZTCXSJLI3GWEZSCL
X-Message-ID-Hash: CTSGDIZRR6YVU647ZTCXSJLI3GWEZSCL
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Hocko <mhocko@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.
 org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MZ23GVDKIFHM3G3K7PKDY37RO7DFS4SP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David

> -----Original Message-----
> From: David Hildenbrand <david@redhat.com>
> Sent: Thursday, July 9, 2020 5:19 PM
> To: Mike Rapoport <rppt@linux.ibm.com>; Matthew Wilcox
> <willy@infradead.org>
> Cc: Justin He <Justin.He@arm.com>; Catalin Marinas
> <Catalin.Marinas@arm.com>; Will Deacon <will@kernel.org>; Tony Luck
> <tony.luck@intel.com>; Fenghua Yu <fenghua.yu@intel.com>; Yoshinori Sato
> <ysato@users.sourceforge.jp>; Rich Felker <dalias@libc.org>; Dave Hansen
> <dave.hansen@linux.intel.com>; Andy Lutomirski <luto@kernel.org>; Peter
> Zijlstra <peterz@infradead.org>; Thomas Gleixner <tglx@linutronix.de>;
> Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>;
> x86@kernel.org; H. Peter Anvin <hpa@zytor.com>; Dan Williams
> <dan.j.williams@intel.com>; Vishal Verma <vishal.l.verma@intel.com>; Dave
> Jiang <dave.jiang@intel.com>; Andrew Morton <akpm@linux-foundation.org>;
> Baoquan He <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>; Logan
> Gunthorpe <logang@deltatee.com>; Masahiro Yamada <masahiroy@kernel.org>;
> Michal Hocko <mhocko@suse.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linux-ia64@vger.kernel.org; linux-
> sh@vger.kernel.org; linux-nvdimm@lists.01.org; linux-mm@kvack.org;
> Jonathan Cameron <Jonathan.Cameron@huawei.com>; Kaly Xin <Kaly.Xin@arm.com>
> Subject: Re: [PATCH v3 4/6] mm: don't export memory_add_physaddr_to_nid in
> arch specific directory
> 
> On 09.07.20 11:18, Mike Rapoport wrote:
> > On Thu, Jul 09, 2020 at 03:11:04AM +0100, Matthew Wilcox wrote:
> >> On Thu, Jul 09, 2020 at 10:06:27AM +0800, Jia He wrote:
> >>> After a general version of __weak memory_add_physaddr_to_nid
> implemented
> >>> and exported , it is no use exporting twice in arch directory even if
> >>> e,g, ia64/x86 have their specific version.
> >>>
> >>> This is to suppress the modpost warning:
> >>> WARNING: modpost: vmlinux: 'memory_add_physaddr_to_nid' exported twice.
> >>> Previous export was in vmlinux
> >>
> >> It's bad form to introduce a warning and then send a follow-up patch to
> >> fix the warning.  Just fold this patch into patch 1/6.
> >
> > Moreover, I think that patches 1-4 can be merged into one.
> >
> 
> +1

Okay, will update, thanks

--
Cheers,
Justin (Jia He)


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6911B21B610
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jul 2020 15:14:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BEF3410FDD195;
	Fri, 10 Jul 2020 06:14:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.2.78; helo=eur02-ve1-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20078.outbound.protection.outlook.com [40.107.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0A49E10FDD194
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++q/zPJYxPwlKDTq3CZb6axDsxRAI2fjYY01w3bJfpc=;
 b=1JdroQWPUBSh36J8tXBxTGrX/5iyLQyGVk66xICO/SZ0DX/BRzv5CIU41hRPXiLhMRZ/71tpQFES24SxKtlqQz7Bs/qeI+9LX7vX2ctlBlSDO/lX6kDqcOMTcfnAlj6lYQ916pM07ticd1NBnQQqSDfYfDJqKF06r0h+KbSY45g=
Received: from DB6PR0301CA0049.eurprd03.prod.outlook.com (2603:10a6:4:54::17)
 by DB7PR08MB3305.eurprd08.prod.outlook.com (2603:10a6:5:1c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 10 Jul
 2020 13:14:03 +0000
Received: from DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:54:cafe::f6) by DB6PR0301CA0049.outlook.office365.com
 (2603:10a6:4:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Fri, 10 Jul 2020 13:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT020.mail.protection.outlook.com (10.152.20.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 13:14:03 +0000
Received: ("Tessian outbound c4059ed8d7bf:v62"); Fri, 10 Jul 2020 13:14:02 +0000
X-CR-MTA-TID: 64aa7808
Received: from 71f697084cb6.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6673BB7F-54DC-4740-B6FF-F3378343169B.1;
	Fri, 10 Jul 2020 13:13:57 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 71f697084cb6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 10 Jul 2020 13:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1yIhj908v7xLWWY1y/XRg275pat24thKKxsw2eBD5cjZm4Gb/vMmtQMivzN9InBuccQBefePT4fazE+46jvT9l906O3J3a7M0RM7jOTrpsblhxyWMo3LB5OsvwJYr5Op2ZgqF5QHC6ZzMeqtKgD/FJvsoYrIHcMvt0IhFu2JL+9S9grWtIV+hC/n7/ZCHyMwFzQKDH3DwUQHJZ7fsVb1QlxjPOkxkuqUSZDgRF28520vLhuPTkBQ7/aJLrA6/3FKyAbCXGI7BZNVbCaLn2nCyrNeBbmZTDP5jblsYS2La8omEJVIuuEGgXad3MTUYlkeX4pZ20MoQLn4xroEOvYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++q/zPJYxPwlKDTq3CZb6axDsxRAI2fjYY01w3bJfpc=;
 b=FSgL4GFhKS791WSFc7uPH3VxbQl1iEAABQXRUrVcMGdwZagJwUoBzSyZygpdugqMwfgT6RU6bPHkk1iKwrfLTrVKFVOG14wRAi5D5YwsGxxzv1UB3XEe7GeJUQj9sXGaeTNXrzpkFC2iS8hWASYTIHwGQy/BHi3mbMZ96ttVYP7y2A85u0zbTc2DVImR3KuD87GI3tr4f6SmXWtcbJfrplg2yRdj6PSS8HwVJa7ljyy15vCcA0Uu62fu9O9uhGj00iwZwzt6Wbo9RgHNwwPqoV22CSIvC9BPDrDMO8Cgp7DT+x4vLWvUI/uRFnTZT6xTWrQUMNdO81WzMy56Yl0ORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++q/zPJYxPwlKDTq3CZb6axDsxRAI2fjYY01w3bJfpc=;
 b=1JdroQWPUBSh36J8tXBxTGrX/5iyLQyGVk66xICO/SZ0DX/BRzv5CIU41hRPXiLhMRZ/71tpQFES24SxKtlqQz7Bs/qeI+9LX7vX2ctlBlSDO/lX6kDqcOMTcfnAlj6lYQ916pM07ticd1NBnQQqSDfYfDJqKF06r0h+KbSY45g=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB4723.eurprd08.prod.outlook.com (2603:10a6:20b:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 13:13:52 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 13:13:51 +0000
From: Justin He <Justin.He@arm.com>
To: David Hildenbrand <david@redhat.com>, Catalin Marinas
	<Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato
	<ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH v4 0/2] Fix and enable pmem as RAM device on arm64
Thread-Topic: [PATCH v4 0/2] Fix and enable pmem as RAM device on arm64
Thread-Index: AQHWVmiq+FAjJUzClE67BDeP0d/JJ6kAe80AgABODeA=
Date: Fri, 10 Jul 2020 13:13:51 +0000
Message-ID: 
 <AM6PR08MB40698B1225FE05220D1A1F9FF7650@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200710031619.18762-1-justin.he@arm.com>
 <23e79097-6517-a301-b0da-4d5505de3d3f@redhat.com>
In-Reply-To: <23e79097-6517-a301-b0da-4d5505de3d3f@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: b0781ec9-66de-46d5-8cf6-0de601389276.0
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [223.166.32.234]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3321f01e-13fe-4efb-d9e5-08d824d31e04
x-ms-traffictypediagnostic: AM6PR08MB4723:|DB7PR08MB3305:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: 
	<DB7PR08MB33055ADDF27767C56E0167F0F7650@DB7PR08MB3305.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 Qut2CD3tGUNyTIInvH3SE9cNCbXBuM2S4YDXLdDzCjAeqONKmrEY5ljM+pYXmwD901nWwDaAQ/yyMfN48B9feqZHUXtCP3ZVa+ynqC3WAt6895DkT2rgxwDRXF6BLrgW6yacXB4qh6lxM/KYSgtLNPFLWegBYgAntbxGRoueALrdSwDsX+rtowjt7rg/OzqLvey0qvZB5rtz9kSwHWAZHRmpG54LED/4apdiw5Kpv+vzvZI3zFSpf+0UGsLI9MCULoNjLbDzvN2iETXhypzwq8I2MpirboTqfTmtRM4Hr4L952foS7BHC7lzX7rgRkjjrO/B3LnRFkPvP9rtZP135wVf5k6x9f+oKjDqWateE3G6aXZCeJzgd1ggpsA+vNGS
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(26005)(8676002)(4326008)(8936002)(2906002)(86362001)(66446008)(64756008)(52536014)(66556008)(71200400001)(55016002)(33656002)(478600001)(9686003)(66946007)(186003)(66476007)(76116006)(110136005)(5660300002)(7696005)(54906003)(316002)(83380400001)(7406005)(53546011)(6506007)(7416002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 Cno/Q1UNNWZudQquilMMYQ0QQfUx5wExU6FNyn/4xK61EYCeHC8EXE4xVzxx+EyUx52u+sEb1wLm826UpvbZ6LiDcXqptUdEgxgTG8zjPH0WCPeSxs6qnRUMNZiLKa9EEVUFwdR1QHtUilkrFP1/eT6OqyTfv7diP6mfDDorg6XLZRN8n+ydaNYqcpfaeCX7+mQ/wKfiTPGZaYHtjDNaZ5horGGAgL2p6pP0tj72vXsKPIXaLTRhzKYy1PHWm/Y96ks6UpeCzONAok9uVUaYOYHQXOCAt16AChb3SS6l79ZCbMx5bmc68fXCOGzzWxRl0Cq+NDEEsV6rXyFoUJ2tYeckO7ewRECXRv1BZ3pvkfuFE6kU+Ju5XsQT5JvKCdqpiiPq0CDLVl4d07nOsV1MfXavAmXFm1IlQ8wwbeVBJz/SGNF7Rum7RSQ2vlQBDGmUOoHDr6xOcpm2eiH8xvsjtrPd8QvJlM8G7tVZxL8s34S95VIJQhpDcrYyK9XHxF+g
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4723
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966005)(110136005)(356005)(2906002)(186003)(83380400001)(82310400002)(4326008)(316002)(8936002)(33656002)(5660300002)(8676002)(9686003)(70206006)(70586007)(336012)(47076004)(81166007)(82740400003)(55016002)(26005)(52536014)(7696005)(478600001)(54906003)(86362001)(6506007)(53546011)(921003);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	78635c42-3f5c-4a0a-227e-08d824d3173c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RyX/0lVjYqIYjceS2126uL+j9D7DbtwOZsx+Ges+QQm0YJFKN/RRz4JbtjR+uamwmO7EHcKxVEyOBPYlsyIeHqX98r/wsS2l+J+UzG/nw1Hs7dYa+foD5bmB+nJxVfaBiRDrkCbA2oS5d16izctS1j9yzHZgMPL2QzcrbJdjWAOpN2gUkOxRfUqAG2dQF3m4DruxISHG3MLnFD45ajacptbT51BD/tUYKImTbZ8O266BRVOlBG74s5lK9bZmbKxEDjPnPfo1v2/QGJ6RYJtaIZRFoI4pol6ICzA+Myz8Z23nPmStYWLPcfe9hLM4RH/cVLZSwNm92icqFih1lLrQQf04WfaHnwKhQH7mmtb1kK9hvEsWe05p1YlNqxfPDP0Sdvwx0o81JPaehmfQCRWFhSl0mEq4nVal2Ks8Kq5yeQg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:14:03.3199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3321f01e-13fe-4efb-d9e5-08d824d31e04
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3305
Message-ID-Hash: Q2ZVSWYKDIBQYO5GUWEKLPMINW6FGJD3
X-Message-ID-Hash: Q2ZVSWYKDIBQYO5GUWEKLPMINW6FGJD3
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Hocko <mhocko@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JA3W2GLR77Q763BPO5Z4L7B76GOUZKZ4/>
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
> Sent: Friday, July 10, 2020 4:30 PM
> To: Justin He <Justin.He@arm.com>; Catalin Marinas
> <Catalin.Marinas@arm.com>; Will Deacon <will@kernel.org>; Tony Luck
> <tony.luck@intel.com>; Fenghua Yu <fenghua.yu@intel.com>; Yoshinori Sato
> <ysato@users.sourceforge.jp>; Rich Felker <dalias@libc.org>; Dave Hansen
> <dave.hansen@linux.intel.com>; Andy Lutomirski <luto@kernel.org>; Peter
> Zijlstra <peterz@infradead.org>; Thomas Gleixner <tglx@linutronix.de>;
> Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org; H. Peter Anvin <hpa@zytor.com>; Dan Williams
> <dan.j.williams@intel.com>; Vishal Verma <vishal.l.verma@intel.com>; Dave
> Jiang <dave.jiang@intel.com>; Andrew Morton <akpm@linux-foundation.org>;
> Baoquan He <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>; Mike
> Rapoport <rppt@linux.ibm.com>; Logan Gunthorpe <logang@deltatee.com>;
> Masahiro Yamada <masahiroy@kernel.org>; Michal Hocko <mhocko@suse.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> ia64@vger.kernel.org; linux-sh@vger.kernel.org; linux-nvdimm@lists.01.org;
> linux-mm@kvack.org; Jonathan Cameron <Jonathan.Cameron@Huawei.com>; Kaly
> Xin <Kaly.Xin@arm.com>
> Subject: Re: [PATCH v4 0/2] Fix and enable pmem as RAM device on arm64
> 
> On 10.07.20 05:16, Jia He wrote:
> > This fixies a few issues when I tried to enable pmem as RAM device on
> arm64.
> >
> > To use memory_add_physaddr_to_nid as a fallback nid, it would be better
> > implement a general version (__weak) in mm/memory_hotplug. After that,
> arm64/
> > sh/s390 can simply use the general version, and PowerPC/ia64/x86 will
> use
> > arch specific version.
> >
> > Tested on ThunderX2 host/qemu "-M virt" guest with a nvdimm device. The
> > memblocks from the dax pmem device can be either hot-added or hot-
> removed
> > on arm64 guest. Also passed the compilation test on x86.
> >
> > Changes:
> > v4: - remove "device-dax: use fallback nid when numa_node is invalid",
> wait
> >       for Dan Williams' phys_addr_to_target_node() patch
> 
> So, this series no longer does what it promises? "Fix and enable pmem as
> RAM device on arm64"
> 
Hmm, a little bit awkward but seems no long what it promises. How about
sending patch1 patch2 individually without this cover-letter?

--
Cheers,
Justin (Jia He)


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

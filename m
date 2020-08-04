Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1F23BE78
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Aug 2020 19:03:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86DAE12A686E6;
	Tue,  4 Aug 2020 10:03:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.7.74; helo=eur04-he1-obe.outbound.protection.outlook.com; envelope-from=jgg@mellanox.com; receiver=<UNKNOWN> 
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 175EE12A17B00
	for <linux-nvdimm@lists.01.org>; Tue,  4 Aug 2020 10:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbmOvc1yqLDC0CEmZ+SJ0+bxokjsuPSWaksneOHlX9MvfZ+tHQT//RfE7VkTTsudo5Xo3if9RD8JO6/xbVt3PcOYROkL+iBvuuCyd3bOzfOh2wqEbHyK90TJukvdfhHDGGOFVO/w8NmdmyCeA45/8MbeXiZ2G/DZtmN5cHK5/r1lbFJaWY7BKkraCak2ughQiIQ9q+bwlOPgHp+h8bTNlixNtQsSly2lOiMHARvyu6iSJQ8GfC9tPGth6INQ56/JG0x0kUk7rVSrbwaxKBJRn1S3s+wTvjo5y1LXuRUDAmkQvQqbrTZdboJPq/XmJyrqOhFSmLu2p8TE0vBS6TcTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wLHGsl2C6BI5j1457dAed07dHoa/4CliwDGpeWowms=;
 b=EihtR8bw1bvL1BFx20M+abDXu/yIggTyWRTokAumOcge+DMlMN/VbDQEcL5dJSlBtGVzXE63eqcFWVSAlqGHFdam5D0LIeULt3TRCxCs3AcSHtaHDqxWZ/VPbiIJUW3pOWnYpaV7fBVGHoR3wL6dyOjDLXzZn0HGR8MtMZx7pmvQx4AP7Zjcw22UGkHya9fBX2S5krHuixegVoHXvkHz3eAenTcjpFl3+dUKHF7r5Hr1ge2xucRZCCtaBjm/j4YBBBXjOvwkkyqgCX2YkKv9GkBADqtCsrE7rvDbiulzQqtwuXPyQVxSbHkFZmaaLSy2fG5gF4q0XgpzEOKOcXgX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wLHGsl2C6BI5j1457dAed07dHoa/4CliwDGpeWowms=;
 b=CiW6z32ZyxRj7D3q9bT8Iuoev15rOBsjdgw96aRA7g53EYm03m8CrI31YTQCdPWQMtCMJXpoq4VI5R1O3/dnKbDAsA27t1cJwbMwMLcTaOKIZZUBihtMqJWH9mfl9eNAzGE9M7eS/H9xIkKpBbte+cIHGKZjoPHXrAxFVKwWkJ4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mellanox.com;
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (2603:10a6:5:23::16) by
 DB8PR05MB6698.eurprd05.prod.outlook.com (2603:10a6:10:132::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Tue, 4 Aug 2020 17:03:02 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::4025:1579:1d10:fd4d]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::4025:1579:1d10:fd4d%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 17:03:02 +0000
Date: Tue, 4 Aug 2020 14:02:58 -0300
From: Jason Gunthorpe <jgg@mellanox.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 00/23] device-dax: Support sub-dividing soft-reserved
 ranges
Message-ID: <20200804170258.GV19097@mellanox.com>
References: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Disposition: inline
In-Reply-To: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
X-ClientProxiedBy: BL0PR0102CA0061.prod.exchangelabs.com
 (2603:10b6:208:25::38) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0061.prod.exchangelabs.com (2603:10b6:208:25::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 17:03:02 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from <jgg@mellanox.com>)	id 1k30L5-003QOA-0S; Tue, 04 Aug 2020 14:02:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c561fd81-bafb-45b2-6a16-08d838983f6d
X-MS-TrafficTypeDiagnostic: DB8PR05MB6698:
X-Microsoft-Antispam-PRVS: 
	<DB8PR05MB6698AF9564BCD10DFACEFDA7CF4A0@DB8PR05MB6698.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H3oLK4DQy34IthsePWj+m2eUxKMWw32fALHR08cTHhfC1YCjn6Sbke6O516IPeZqLXEyscPRgrEen+KMQcwOw4Y5xgJKYfWIZDyV+YAlYCMfYxwtgq5x6Ykx9AN7xSn8fT+iyV/GLKCK7BvizYrwIP/dmFazcxTkjjrOeuIKT5YHGhOEbaV0gVzEXegvxcH1GX3OyCBHZCEJCJBps+DPwUGVTNzB9DlcLt1GjRHqsMF8aPEdtm395gy5DGNQBIbMtVkPkqqKIa8A5KNVdYyvrLbCr8PujbWJfrdbH3E71DYtsloEUahjdAnJK5hrOovT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB4138.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(2616005)(4326008)(9746002)(9786002)(558084003)(5660300002)(36756003)(7406005)(7416002)(426003)(26005)(186003)(66556008)(66946007)(66476007)(316002)(54906003)(1076003)(2906002)(478600001)(33656002)(8676002)(8936002)(86362001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	ooX1gXy+Unzj5ZgWTuhCl4+QjUgNuUDYr9BP99YBYYIwDbW0L34SzMiYI6uEiXDQilu2h4J5VoM3a6Y0TlcU5sJ8jbajC8YH/uyPiabwBEfCcx2Wya1ZBZA1YacFGJ9fx6NXtWNaPJYzj5uWKuk5uOd2zMaN/1M11nUFFOZ7l0YqL68evnuiixtmiUqb9Z8kkBW7zFeB/3XmlDMlcDN3nsSYlCzwbwfKZONOVw6HcX5qRWZ1aq4440wXsnP7utp6cv4kgrtioNapuEyvYk0NSnqd50UMDZaYre9ulBqUJVF+wnpIdUyIz/dakZ03r8EDtQWwRtC8dnWWdYAJqCM63W1jleZab2sauVr0t6kA4xeIbUCn6H4ePLQlbA9Ba8ztvlgm4EZD4gfe2+tpuT/oGvsKcIl+Kz/5FdxF/1Cr2hX6nw2C4I55PeId69/PU6lwXihyorHTG1YhlckZMrkKZUJn586A9uVutI8WCSVL11h/yh3XJaFLpXDLc73b67ilGGCEZrdkatkv6lNHjwn1o6ew6kAz9JRQsemGeI9GEmn6keBEXQx5c8d0f1GJNvbREqWLFasT12ssbx8sM5hc11xS5UVkl/BWCDePa4c5TPVQW4DHdEFI7X+1pWStkOMX+fd+Bt3cfD8ohqDJzkun5g==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c561fd81-bafb-45b2-6a16-08d838983f6d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR05MB4138.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 17:03:02.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzQLuCw32OZmSzSwbCewJA0UXR68m5N9rn3ogeA9QLUAW5V9CZrohYyFDBqtZ6XcFe+t/qXXq1QexO7CjF4HdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6698
Message-ID-Hash: ZXMZAWMZWXOJ67JI4FDILLJGTGJMTW3R
X-Message-ID-Hash: ZXMZAWMZWXOJ67JI4FDILLJGTGJMTW3R
X-MailFrom: jgg@mellanox.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, David Hildenbrand <david@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Joao Martins <joao.m.martins@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jia He <justin.he@arm.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>, Brice Goglin <Brice.Goglin@inria.fr>, Michael Ellerma
 n <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Vetter <daniel@ffwll.ch>, Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZXMZAWMZWXOJ67JI4FDILLJGTGJMTW3R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 31, 2020 at 08:24:58PM -0700, Dan Williams wrote:

> - Fix test_hmm and other compilation fixups (Ralph)

The hmm parts look OK

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

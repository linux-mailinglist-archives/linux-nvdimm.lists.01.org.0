Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80332197B7
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 07:13:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 347931007A824;
	Wed,  8 Jul 2020 22:13:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.15.47; helo=eur01-db5-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150047.outbound.protection.outlook.com [40.107.15.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F74B110CC32D
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 22:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sN+udc5fe7rcS4kOYX0bFZpVWtQBB+c87d5Xdiyt0Q=;
 b=78LAvTS6+lh3bxCxaSawrml6yAPVzm1T90ysCP68srNIeY5iPiE3WZZZRhsuzaI2jkcSqm+cbhIskFWcoNr87Flx4s/+GFArODNWtkcxiAQil/ewz6OaxQRNzhItXyCMxqTCbQ/PQjUk3dosH5HON4LFZHjnQIUtWLsYd+NLcR4=
Received: from AM6P194CA0002.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::15)
 by AM6PR08MB5029.eurprd08.prod.outlook.com (2603:10a6:20b:e7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 05:13:28 +0000
Received: from AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::4f) by AM6P194CA0002.outlook.office365.com
 (2603:10a6:209:90::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Thu, 9 Jul 2020 05:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT033.mail.protection.outlook.com (10.152.16.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 05:13:28 +0000
Received: ("Tessian outbound 1c27ecaec3d6:v62"); Thu, 09 Jul 2020 05:13:27 +0000
X-CR-MTA-TID: 64aa7808
Received: from f52441a98fb4.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4007E773-5DA6-4C6A-B5A2-3FB6CEF10A18.1;
	Thu, 09 Jul 2020 05:13:21 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f52441a98fb4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 09 Jul 2020 05:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFh2x/GAO2XMmi/DRIOrhF1wfVKb7ahSpKYTu1ffQnZfgtgtFRUwkcsRY2OE7xCVR9ffFreL6iSYUA/PL2Bo4S9+Rn8WP7j4Adh7R2aDglDqkDh6qqN5hoZjEjBhfh4G9DarF0B/v3636m+JSiuoLdae3a8+s7TQdOGiNBKqdGos6+rcIRrfgbQ0Zh+ecem+DyWrKQspgvzUNebkvo68OzKNPs4978tLZz5/p/7203vU1qFmHKcr9ctt+YKnyDdNyU/QZzGhQKDxa6fj8HW2AvC50wFcCPNaYc5chRP2f+OnSX6CUfP0QxsLt3maQtrA5+1QdcG8LkrQzUdXkLTW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sN+udc5fe7rcS4kOYX0bFZpVWtQBB+c87d5Xdiyt0Q=;
 b=VWi12XQ2NnMohOZ6J+zYEOhkiggspcxRMaTo6r+oPiEFVbNiowHfuE2obFPkroLUgCGUEhbLzRIdsFrtXJK4C9r/CRV4rj4Hd5isKWtQ08uKZWn/p/f3acdtGKIElvyksgne09MmL4qOJ6O2Kwq9GZDQuLpuvZS9+kOXIDPsBwnyHV7PYI/txulMeD+5cLv96g40j50LBn1+w7e1jKA6vT5v7c8oDV5mcbZyFg1sE3jp4Ch1yRzBraMrfwVuXl1gMaYJ5TyJ1Jjm+nDYjQVlXuLc4avKV8O/IX+ft+yW0xBzdcSwrfturWIFl94Nc/WLHO6kUSqi62hPe1cJ9TFWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sN+udc5fe7rcS4kOYX0bFZpVWtQBB+c87d5Xdiyt0Q=;
 b=78LAvTS6+lh3bxCxaSawrml6yAPVzm1T90ysCP68srNIeY5iPiE3WZZZRhsuzaI2jkcSqm+cbhIskFWcoNr87Flx4s/+GFArODNWtkcxiAQil/ewz6OaxQRNzhItXyCMxqTCbQ/PQjUk3dosH5HON4LFZHjnQIUtWLsYd+NLcR4=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM7PR08MB5335.eurprd08.prod.outlook.com (2603:10a6:20b:101::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Thu, 9 Jul
 2020 05:13:20 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 05:13:20 +0000
From: Justin He <Justin.He@arm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH v3 5/6] device-dax: use fallback nid when numa_node is
 invalid
Thread-Topic: [PATCH v3 5/6] device-dax: use fallback nid when numa_node is
 invalid
Thread-Index: AQHWVZW+nx78d4gAuUOw9EWfEfkjTKj+macAgAAZ3LA=
Date: Thu, 9 Jul 2020 05:13:19 +0000
Message-ID: 
 <AM6PR08MB4069D206048464CFCBBFDC9EF7640@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200709020629.91671-1-justin.he@arm.com>
 <20200709020629.91671-6-justin.he@arm.com>
 <CAPcyv4gfVhHyo-c=9bXd=z3=9Xqy7ato30D8p2aNsKBUONosug@mail.gmail.com>
In-Reply-To: 
 <CAPcyv4gfVhHyo-c=9bXd=z3=9Xqy7ato30D8p2aNsKBUONosug@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 569fc01c-900f-4ac6-9a2e-06ed3fe017b2.1
x-checkrecipientchecked: true
Authentication-Results-Original: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 521337bb-6dcf-472a-5e1c-08d823c6d081
x-ms-traffictypediagnostic: AM7PR08MB5335:|AM6PR08MB5029:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: 
	<AM6PR08MB5029669A6F8FC061452F0144F7640@AM6PR08MB5029.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:3968;OLM:3968;
x-forefront-prvs: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 8Xbtp0259dtbnwCyTYPbOIVhEFoz+RPJOv7cNTnlI3Ff6NCyJBeGnEQj9r8qJEIuGZRM8BljAbbZkv9gvhNAjvCES85YbpE7ezGy/U82BfQm2vYB1MdovrMiugzggiztqeuNBO5ycNKAFOKloPWexdp3NLoZuCdTZ/Z8V7dbTF8xpwBDxwR2vsptRn+H/59sT+CjdW3yxD+BQ3SeNpizverlZ1Uyh6VvYonkgisZfW+ffcDBzdNtlmxUWOpy0W6kHhag9mm4t9NzJ6s/ZfgUcZHcjkUg4KmUhFHqd+z3PU5dsG1lKeWJwIZTQMIZaPHJOElcJ6bFc7Qi0HbysnkOQQ==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(54906003)(6506007)(26005)(8676002)(83380400001)(6916009)(76116006)(7406005)(7416002)(4326008)(8936002)(66446008)(7696005)(71200400001)(53546011)(478600001)(66946007)(66556008)(66476007)(316002)(64756008)(2906002)(5660300002)(9686003)(33656002)(86362001)(186003)(55016002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 fkW/kph5UtYTIUPfsMjWGqBZaEYj9emNUlh9LjN0Tgpq3mTQxjGDzJC6w2tjJZP+faSBLrzfpLJCc52N27Njd7rFX/lLFmSUgVInJv+TL3AX2ZuJlEF7Ur9k5uTW89OSfnj6g3+z707uztDSUiGA6JJ7Lkpn0782fA6iZtK3LbGVBgATToe7bKhw2/FUjRoqtjihdK1sAIbM//koG1NF517P+FDLdta8ENbUPzOD49wcB5WNad8kUT/LWPIN4gy8rUj3Aoxal8fis1c7wtY3yiuQqj9FJehKA6HZA5VdOnDQYy+t/FzRz7/ELT96urZ2HlyZ/lXmGq0n5/M5NEcvrKNcoMTA7coOzGg/bwV3BAMQxZcDOkMG1Wr9TrniwVRG6h5rK/wK7YLVJEQg1Zq8EoHX5JmhxHORBkTlEc6ueKjJhM0a5fjSY7GhN2i2diWQ4HnkMoHC7gWS0meFtKTN17ccNOP2fqTidWXGfju3Tlg=
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5335
Original-Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966005)(53546011)(478600001)(82310400002)(356005)(54906003)(6506007)(81166007)(2906002)(36906005)(47076004)(7696005)(86362001)(82740400003)(316002)(52536014)(83380400001)(26005)(5660300002)(4326008)(6862004)(9686003)(336012)(33656002)(55016002)(70586007)(70206006)(186003)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	c56af25b-e866-4f30-64fa-08d823c6cbdc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yWs/Ku1rNF/wn8kaszjOmQO05VXUsUACKjBhUO89VM4EueZ8cw/FXE9XcQzT3EqMFRFIdki8YlR4UJlhCBA3yqXw31b9yJuyy7Sa+PfPwy647oy7tQ+x/igDuGAaLgmWi9ENlzh3ks6fAv3LQLZULGMsNgaHuQ1vwOSRbS8RTILjuJU+5UCiyzcsim/XezVw2VRx6KDy6GnKjLi7lRdEz1rBukfyS3dIdAoVXkBo9QzzRZ+UnDSYubjV2vDavo7CTT+whu6b6xuW5iilrPZ8KPpA4lF1Ne4M7WGMOmtTq6+ag2swzOU60CyXZWK9Xc2F6pXqpMlvKpgNRMxGvS0LilOkl5QVNXfQvicbmRjjWVRc/jTF49GiKYt5LC/KrRwGNUnzu4xOZy9OQu5xPqF+DQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 05:13:28.0961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 521337bb-6dcf-472a-5e1c-08d823c6d081
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5029
Message-ID-Hash: IJ7IV2BUT52QPRS5LKTUPFSL2VXWDRP6
X-Message-ID-Hash: IJ7IV2BUT52QPRS5LKTUPFSL2VXWDRP6
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Hocko <mhocko@suse.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org
 >, Linux MM <linux-mm@kvack.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7LUSEYGQNAOV2SVUYB7Y7R6KE6UV4WB5/>
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
> Sent: Thursday, July 9, 2020 11:39 AM
> To: Justin He <Justin.He@arm.com>
> Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> <will@kernel.org>; Tony Luck <tony.luck@intel.com>; Fenghua Yu
> <fenghua.yu@intel.com>; Yoshinori Sato <ysato@users.sourceforge.jp>; Rich
> Felker <dalias@libc.org>; Dave Hansen <dave.hansen@linux.intel.com>; Andy
> Lutomirski <luto@kernel.org>; Peter Zijlstra <peterz@infradead.org>;
> Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> Borislav Petkov <bp@alien8.de>; David Hildenbrand <david@redhat.com>; X86
> ML <x86@kernel.org>; H. Peter Anvin <hpa@zytor.com>; Vishal Verma
> <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Andrew
> Morton <akpm@linux-foundation.org>; Baoquan He <bhe@redhat.com>; Chuhong
> Yuan <hslester96@gmail.com>; Mike Rapoport <rppt@linux.ibm.com>; Logan
> Gunthorpe <logang@deltatee.com>; Masahiro Yamada <masahiroy@kernel.org>;
> Michal Hocko <mhocko@suse.com>; Linux ARM <linux-arm-
> kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; linux-ia64@vger.kernel.org; Linux-sh <linux-
> sh@vger.kernel.org>; linux-nvdimm <linux-nvdimm@lists.01.org>; Linux MM
> <linux-mm@kvack.org>; Jonathan Cameron <Jonathan.Cameron@huawei.com>; Kaly
> Xin <Kaly.Xin@arm.com>
> Subject: Re: [PATCH v3 5/6] device-dax: use fallback nid when numa_node is
> invalid
> 
> On Wed, Jul 8, 2020 at 7:07 PM Jia He <justin.he@arm.com> wrote:
> >
> > numa_off is set unconditionally at the end of dummy_numa_init(),
> > even with a fake numa node. ACPI detects node id as NUMA_NO_NODE(-1) in
> > acpi_map_pxm_to_node() because it regards numa_off as turning off the
> numa
> > node. Hence dev_dax->target_node is NUMA_NO_NODE on arm64 with fake numa.
> >
> > Without this patch, pmem can't be probed as a RAM device on arm64 if
> SRAT table
> > isn't present:
> > $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -
> a 64K
> > kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with
> invalid node: -1
> > kmem: probe of dax0.0 failed with error -22
> >
> > This fixes it by using fallback memory_add_physaddr_to_nid() as nid.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  drivers/dax/kmem.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> > index 275aa5f87399..218f66057994 100644
> > --- a/drivers/dax/kmem.c
> > +++ b/drivers/dax/kmem.c
> > @@ -31,22 +31,23 @@ int dev_dax_kmem_probe(struct device *dev)
> >         int numa_node;
> >         int rc;
> >
> > +       /* Hotplug starting at the beginning of the next block: */
> > +       kmem_start = ALIGN(res->start, memory_block_size_bytes());
> > +
> >         /*
> >          * Ensure good NUMA information for the persistent memory.
> >          * Without this check, there is a risk that slow memory
> >          * could be mixed in a node with faster memory, causing
> > -        * unavoidable performance issues.
> > +        * unavoidable performance issues. Furthermore, fallback node
> > +        * id can be used when numa_node is invalid.
> >          */
> >         numa_node = dev_dax->target_node;
> >         if (numa_node < 0) {
> > -               dev_warn(dev, "rejecting DAX region %pR with invalid
> node: %d\n",
> > -                        res, numa_node);
> > -               return -EINVAL;
> > +               numa_node = memory_add_physaddr_to_nid(kmem_start);
> 
> I think this fixup belongs to the core to set a fallback value for
> dev_dax->target_node.
> 
> I'm close to having patches to provide a functional
> phys_addr_to_target_node() for arm64.

Should My this patch(5/6) wait on your new phys_addr_to_target_node() patch?
Thanks for the clarification.

--
Cheers,
Justin (Jia He)


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78961349CAF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C7DA100F227D;
	Thu, 25 Mar 2021 16:10:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1CDAC100EC1C8
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:33 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNA6mU136792;
	Thu, 25 Mar 2021 23:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=xOXVthTr7705vX0AU8WhlfFywO1Y1olXp2ZtgXcnpBg=;
 b=E7c4n5Leb5hqlKIJ1HK7YsB9O7XHIolA3uyevFjzAp6OwlYZH7LhqakyUk46YaUW0mnb
 oqUlapOD8x0g/3GUUWza3O7Aa9UqNdAalmVEmlZ4Hof8x5ri4olmWdZ1m79YlhGnqlgV
 jnwZfRpArYuPoc9M0VBwqIYdvpOil19LYKdXnYDnrDjQKaZ/etTNW2BNXD3Retcp2TmT
 6whq4cpJhZRiJL6P1mpmLw0DeCDcKVxWuOxF237p5mYvn6gbN94/+DFQv8cHkIB03XPw
 PVG9Kzzgt5r1WKwwu+XkC97nOdH+jO9cHohaDv/nWmrvFQQC5htZ/sfhJ1fFLsZt5vFE Xg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 37h13e8dxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNAItK009261;
	Thu, 25 Mar 2021 23:10:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
	by userp3020.oracle.com with ESMTP id 37h14gdpy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpKh7gUp3BMMYir80Gyb5Gm0367eooxbCKPtY4MO5nwu5uBrHy1RWF0LSdLF9tIXZyqEXcoXBcHQILaZPKL3yW51+jZJGOYGdWwJQ5kuGEywXxk8drJTgBbh5xbqKg7ssNYPRdRvvzvHFgaXG/4NHpN08sHKc3+VUoNYSw/6HRR+/HqWB+VXqk/1pMz1rRhFxQ/uI4hthhUOEzlWZhDcyrFXSP6p19x52dCkMcpDIrnum3I6CeAAIlOw026kQM0pIhoH42gaLMPvEiECE1gsSsRCH8ew0BsXU1G0loKs6WnPl2zmzUTZq+f04c3C3GEE/+YwQdBpLZVX0u/j2sfs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOXVthTr7705vX0AU8WhlfFywO1Y1olXp2ZtgXcnpBg=;
 b=JSEk8tH+wKfgTC39QQhfSPWgnjR2xBkCgFAtBJYT3h9PtZy6Q4VSL8eWBM9mcxGmDdQt5XcJWLuIGTqYX9VKlvHhdSIorrewXWFByggcx/2oX8yeB2wNlQNL6fz+oz4V4FPN5hkWtWlCej0bH+UUiQjfMXj/DZy1YpiJetDHq/TWgP6cMAbECfIZuO/QTUgabPc90tr+RurQtKdZUb2rmXHtbzkyNHordKM02G6vhKzXH1uVR5DHf574SganiKC85BYKlg2jtyntg+MYht+6BlgZFCND6zcIBX1IwWNR3HL78vcsTJJD7GeeKeOczXOan2EjpKyE+jHHWiSeIwuZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOXVthTr7705vX0AU8WhlfFywO1Y1olXp2ZtgXcnpBg=;
 b=uQ+gKmoxUzsxZrHp7vVS/8pI9JRIOVuEZLnVwr0V+Lrt1Pr9y/1clL0PqU+i/bveKZ251390YK1bWvopmGXPj9jDMtgZ9tM5PsV77JO4V3SgPlTIsDsnn1pGvCDsiFS8Kjh576xtx1DV6qsxWmKD+cHVkPeqOgHMDQB3FBw3vbQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3987.namprd10.prod.outlook.com (2603:10b6:a03:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 23:10:04 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:10:04 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for compound pages
Date: Thu, 25 Mar 2021 23:09:31 +0000
Message-Id: <20210325230938.30752-5-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:10:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deec0e5f-cb80-4adf-d95c-08d8efe31f5e
X-MS-TrafficTypeDiagnostic: BY5PR10MB3987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB3987B1BBB1F2C968DADD0627BB629@BY5PR10MB3987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V6fCSVfMT295TCceSsmgtBhTldM2B+q6VwiJOCCg7Y76kqsprnqdNiY8Jq4YHXQO7Xf54oFg1aJH4QsBPzfZx8FpZS8UQ7T8PAp+NFI+J6yn/nz8E0X7Z3/RlzpENXifDOxmSJQTdBmOusT3IML45eFj+X2RcHh8eBYG8hmjXd6w33YrsPUyQpUhQHDhmNiTARWfI5c71Go7o7sgd28QGlII+nNgAUs96fDgh3E/MsMv9YbKKVbL37AA3N8am8zr5o2MJGPHOtWdA9RhSuYG/OX9jzQzkiBHJD7G42UsEt3b2DesDsqfL3U9aPTeMQRxsMVhOR+rf9Qm8bB6z9+xBd1hhKB6HOB8e9LZ+PomPtRti5jo1ZI6yu+BwNLEpErqPcm2cotr7aHVQROX5BhZ/DogAgorjyiuYWa07IiDbo7Th0ldPEypagwF+4FRSlBLmKpIIAcI05hrpZFOpIRzIpAqGDUx4I8SyEAzyOdnxI7fgdlnaYjI4rRIZmqmO606hWvRqe0vpYzHo6JhsaTvqMk7CFenwpRhEFYoPbv/Lhw4M3RLN3tImJ+0t1y2i62pzHEHwwCclVD3wVauDeadHvMfrT1QJN8gQChG7rd1bCLHNwN5TLXZi29QseOXZS+S6PoajcscFkrf11QQvZ4cradZhguFvFzRM5u2sK6FgfI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(83380400001)(4326008)(26005)(107886003)(6916009)(36756003)(7696005)(52116002)(66476007)(66556008)(478600001)(66946007)(186003)(316002)(2906002)(8936002)(54906003)(2616005)(86362001)(8676002)(956004)(5660300002)(103116003)(1076003)(6666004)(38100700001)(16526019)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?1/fYXn+WUCcc63mIq/y8BhlT51f3ilIj7lqiYZt71H3jSYjCpp3rgwX3iHep?=
 =?us-ascii?Q?WPuJxlx8MeP8AEgpaNLbslS/mDaUDPspzz7VqOSOx1zIAhgmgyYu/ULaYB6k?=
 =?us-ascii?Q?YfwOpjXrhRzrzMehagivSTaaAzX6OLx6OldJqZQXyQguy1MfmRrCu6BHlu8O?=
 =?us-ascii?Q?7AwAzkxlAOkAcDAe9Sl1iOydy5ZD384rhbkMOtjCOR36uHBd1zZDgjo2gHJv?=
 =?us-ascii?Q?a2x5hPp3f6Y/b13O12R2fwgCqnC28WRyh46IER8FMgTMk97U1vQyRkHDWlTd?=
 =?us-ascii?Q?8v1saAkDHTzF5tT2fdSghSU5TOPe4qW9UtGG4k8HWm573IHnS6nKtv4D5bcw?=
 =?us-ascii?Q?zK7veFz8Ic+/VJPwp5FN0Nxhs9nXGIl2z5DHNohq2WqNrw6v5fpaRRQ/v8IK?=
 =?us-ascii?Q?YvCrQ8hJh3m1dLo8MDJhmA4Xql+ow5kLtOnDWmZNCKtRQ5+TmOe7u9O4X9b5?=
 =?us-ascii?Q?L9gsVe1X5ZJwv6oMS7C2n4MDLgiDFqYcfYopjYsV8PgFg5iBFhgX3PbdPFYB?=
 =?us-ascii?Q?wZuop1LkkktY5o0LhH0e+Koi3Irgx++cz56mvLlvtWcAtErwenDKIBcwnVKi?=
 =?us-ascii?Q?KUe70lezD5sO0xPFRAvwSJbSzD263CtpWOamDXd9MxTBIUGzjILdkynXb/pM?=
 =?us-ascii?Q?GJKK40Rj2SyE+i0Ye1K+7zy9Low/RnOyAIeI1tEygiZeuP+iRVO5xLKzM4vJ?=
 =?us-ascii?Q?V2/Ta2ZvGBMTTZj4da16l75NJSqJr4GH1e3Nxd84ZhIelqbUTIjDdMViLkAX?=
 =?us-ascii?Q?jn/8BEqG0D4QFxj6ssPp84DobBf/aC00fyiZqvNt2kDAdOWuxXfXCVpbZ5mC?=
 =?us-ascii?Q?M+xCt72UvRbLHiBdr0ZvjmckJTfqaOEG88eVLr2FlilvZtyR7+LvL6pMkTp5?=
 =?us-ascii?Q?GkFqcoTLMTdEBiIcJ5l02ft924TcKxck/i5zlaK5ARiql2Th+26+LhieyrvE?=
 =?us-ascii?Q?tVCrxXCceNLkkkzl7WW9Qnkq0tUf4CrAoBY28vH1eG9Zl+79ebE3OTHV9m5H?=
 =?us-ascii?Q?KVVpcdqGSM9TgCsCG1gPLFbIO9t8ZD+SdaK06QbnD/2VJr00UQixr+8C61eK?=
 =?us-ascii?Q?NS38NmHTTr3jQUWj2ShMzc2JDwk2+YnsL/WMe6XyxdC3mT5alN7hBuPDCWVG?=
 =?us-ascii?Q?vw25WT5xUZ8ZEaME/Puo0TW1G1uVnjVXkcE4tjtJIL91Jwyl3UfvcKVqaTdl?=
 =?us-ascii?Q?NQFfeS/W6hOpSvIP5w97xP1YSxiB39t+3uZzn7AfqtdJdmc6yNzJ09JdPLp/?=
 =?us-ascii?Q?XdOIS+FI252ftjDhPtKjbFZymblRVAK0ALUgQnOM37C2oLLDNM0pQG17+4XE?=
 =?us-ascii?Q?cHB4c3ju7zmikkBLuYM8gljH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deec0e5f-cb80-4adf-d95c-08d8efe31f5e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:10:03.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGXIFUbY6FDUF/VvGJf3gybLLljfYqiwMIwE9AHnDd7fgOTXC6p3LO73N8ORLvB3O3DuUXL2n3N5/UJGC1dDA8HinQwRZZsm5VVYsudm9bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3987
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250171
X-Proofpoint-ORIG-GUID: GwK2E3ba2ZIN6067bHoAo3MUd9yUe7MR
X-Proofpoint-GUID: GwK2E3ba2ZIN6067bHoAo3MUd9yUe7MR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
Message-ID-Hash: QMGFVF6GSI6P3N6D4QSCRTU2MTWG6VRJ
X-Message-ID-Hash: QMGFVF6GSI6P3N6D4QSCRTU2MTWG6VRJ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QMGFVF6GSI6P3N6D4QSCRTU2MTWG6VRJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a new align property for struct dev_pagemap which specifies that a
pagemap is composed of a set of compound pages of size @align, instead
of base pages. When these pages are initialised, most are initialised as
tail pages instead of order-0 pages.

For certain ZONE_DEVICE users like device-dax which have a fixed page
size, this creates an opportunity to optimize GUP and GUP-fast walkers,
treating it the same way as THP or hugetlb pages.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/memremap.h | 13 +++++++++++++
 mm/memremap.c            |  8 ++++++--
 mm/page_alloc.c          | 24 +++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index b46f63dcaed3..bb28d82dda5e 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -114,6 +114,7 @@ struct dev_pagemap {
 	struct completion done;
 	enum memory_type type;
 	unsigned int flags;
+	unsigned long align;
 	const struct dev_pagemap_ops *ops;
 	void *owner;
 	int nr_range;
@@ -130,6 +131,18 @@ static inline struct vmem_altmap *pgmap_altmap(struct dev_pagemap *pgmap)
 	return NULL;
 }
 
+static inline unsigned long pgmap_align(struct dev_pagemap *pgmap)
+{
+	if (!pgmap || !pgmap->align)
+		return PAGE_SIZE;
+	return pgmap->align;
+}
+
+static inline unsigned long pgmap_pfn_align(struct dev_pagemap *pgmap)
+{
+	return PHYS_PFN(pgmap_align(pgmap));
+}
+
 #ifdef CONFIG_ZONE_DEVICE
 bool pfn_zone_device_reserved(unsigned long pfn);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
diff --git a/mm/memremap.c b/mm/memremap.c
index 805d761740c4..d160853670c4 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -318,8 +318,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
 				PHYS_PFN(range->start),
 				PHYS_PFN(range_len(range)), pgmap);
-	percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
-			- pfn_first(pgmap, range_id));
+	if (pgmap_align(pgmap) > PAGE_SIZE)
+		percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
+			- pfn_first(pgmap, range_id)) / pgmap_pfn_align(pgmap));
+	else
+		percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
+				- pfn_first(pgmap, range_id));
 	return 0;
 
 err_add_memory:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 58974067bbd4..3a77f9e43f3a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6285,6 +6285,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
+	unsigned int pfn_align = pgmap_pfn_align(pgmap);
+	unsigned int order_align = order_base_2(pfn_align);
 	unsigned long zone_idx = zone_idx(zone);
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
@@ -6302,10 +6304,30 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		nr_pages = end_pfn - start_pfn;
 	}
 
-	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+	for (pfn = start_pfn; pfn < end_pfn; pfn += pfn_align) {
 		struct page *page = pfn_to_page(pfn);
+		unsigned long i;
 
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+
+		if (pfn_align == 1)
+			continue;
+
+		__SetPageHead(page);
+
+		for (i = 1; i < pfn_align; i++) {
+			__init_zone_device_page(page + i, pfn + i, zone_idx,
+						nid, pgmap);
+			prep_compound_tail(page, i);
+
+			/*
+			 * The first and second tail pages need to
+			 * initialized first, hence the head page is
+			 * prepared last.
+			 */
+			if (i == 2)
+				prep_compound_head(page, order_align);
+		}
 	}
 
 	pr_info("%s initialised %lu pages in %ums\n", __func__,
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

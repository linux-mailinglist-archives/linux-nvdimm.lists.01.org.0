Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE73349CB2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A7A6F100EAB47;
	Thu, 25 Mar 2021 16:10:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 78496100EB353
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:33 -0700 (PDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PN0mYG136557;
	Thu, 25 Mar 2021 23:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=to3HhWm59rBOu+npVpIlkd97Z9Q5FNJcCaQyMIuXZ5Q=;
 b=U8iRpeiy+9SEUNI4bmy2WptwrbxEBiCkSapxnMNF3xpuNpKET4WGphkUtUl9GNQqpLdD
 NGuMlCs1NPZUQm+kdPaeHsQHD9Ra2pEHbgQ+dpnq4ep2JoI+s+e5NU2uXfIVFcU4aElL
 uruu5i94gDNeNYFPjJHDoonn3jVIU0FZ1XYMRS6Jzc/G186KyzizlAyqtWlaQtW9iFxN
 Nab+SPgJABk/6YmO3xvgcilfirES6YbJ0m566hnZa9wMhiCk89yMPUqDehEnEo8i+UnJ
 ATuDGYEK50mjwmWTFSjXwiAhSkarkZf1dPtMEtxAJTiLUlgsx/a+wMu+ifdVP01CNL/M Tw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 37h13hrdwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PN0XgM105859;
	Thu, 25 Mar 2021 23:10:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by aserp3020.oracle.com with ESMTP id 37h14mdk2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW/Z/YZuMX9A2OO0pUNe23Hp3LSkdKRzKrIUWPNJ5vmrVG+HwDal3o6GUfQyLncBZ4yZvO1F/OBaH3vO94APhDgZ+u81ZUdOxJYKvOR5WnMKpozDNBTWSM/ehN6BbJ6g2oHNE56mYFzaueVjn8CvtLBPYElA5nXvO7LljEwELiYMjVzVV783Jd1dICpSmKH1cJ9WtQvvybSk8OP4eRxkWIoXh/PKojvazI6UeBrpA/K+K8D1EddfbpmQggPHDgKqD99Fi0HJccirjNxHNoMwWfxMkUj9/Rkl5gPtJwJ1kaVDx2e8iQ38JTm+wr+9YmVQpfVVtViHCc1AUnZRoKyoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to3HhWm59rBOu+npVpIlkd97Z9Q5FNJcCaQyMIuXZ5Q=;
 b=X80Bi1Tnbya7ek4BqsSXRc7WNugqy5Z1KuPvxNlFCc06d5cizaW0e4a2uP9tvOaWTW09K9nwnpix+uiQfggNbltprsMx3W6G3dvZ6I1u/xGsGLe0CkaK1T8su2jq6lobEJyN8b+jl628GfxgRcVy74Lh47FJKyrgYPEnHIEmTeTZZ7nM3IqGWkpsoe/BWfmHB1PC1bBYM+uQlxWVLSv+eJixSzbIqRpGrXnTspEAEWraLrdCkmUlJL/5zpAYq1oFRcbfCoEdtXuFuB67jiCj/Fw37vbUuaPGXEzz46orTzzzoygcLvAbqwaDYmAEGMykaFl+Juu+bFbIxCIqOLxBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to3HhWm59rBOu+npVpIlkd97Z9Q5FNJcCaQyMIuXZ5Q=;
 b=r6zYCMAx9oD7elxSWAbNLwS0KkceKcUza+o3ZUodM7+FOMJTG8sWde4M/7RtEsNDMlusqy7Cd+jq4TXNNktbMR9mqlvLDaJ8ExwyUlOi8P5bNG17Lqah41V+IrScbmnlq8QHd29NObJd/RlEEXLgpULEsOhl5Uzi3R4lsk2ZIzk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 23:10:00 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:10:00 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 03/11] mm/page_alloc: refactor memmap_init_zone_device() page init
Date: Thu, 25 Mar 2021 23:09:30 +0000
Message-Id: <20210325230938.30752-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:09:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: add72cc5-7647-4b2f-328c-08d8efe31d95
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB4371B58541AC01310024D272BB629@BY5PR10MB4371.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BOc5ifyNBQvtpWSyXJHDiW/GLgNkg7Rg5Zu01k4GviSglZzkCuCJvmVIUCj4evKlELcIG82qvQuvd49kJ0psIESuOcqrYAocajvS1dI6gstGxDorsT+G+12eL+8K8Wo668pNVjS6t7wlEiCqoG0/GI75hGWJ2rpvH5JEvqAWYD1dKGgwuUbiljuGEQh8AzkWF1jxUgbAbGZSPm44ZAT/BJJmFxIU+WFJNtla6eBzv0TlNXVQpLBLnCSiIpgKlf3pavDKsIRhQxfrhsjxSmYRKTsITClhbpR0dFTftsKW4kuhYvreJFRCf0G9M4i7z1IlqOs7rL+w6EKTCI9DEXXF+FXxKY38hYjx3+yqiP9P9onmGrtP9Ne3Opton20Q1WPqEzx0/iCi+jGiqLj0/2S/SMHCAJcReWfcAwK9blO5UP+cmSBN8NMtVlGhmVxXTlxxVU+vFceCBYMzHwHTsiXHNZWH3P8Q3Z1BaZe2ridTrYR6NvDz9jQZdAtCvUW2fTGudxku+K7VyBJCjLgvvRbo46Z7GYkAz3wTgqmqBaCdBp+nbMRlj063GLK3u/s2yqVJIS3vcInOR8tMTFGJiD04gDxo6ZjaIrEuxFDLNHsA/Py0Z7y/BEuJH63A3OTgTvL1T8/VHs3iTUuoL722nWfzCBwgDZn0HodYC82lOqgCrFo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(186003)(26005)(16526019)(7696005)(316002)(38100700001)(54906003)(103116003)(478600001)(6486002)(2906002)(52116002)(83380400001)(6916009)(66946007)(86362001)(66556008)(8936002)(4326008)(6666004)(5660300002)(36756003)(2616005)(1076003)(956004)(66476007)(107886003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?i/s/CB0brVl5EsQlLF8CkRjco5aE29pEelCClRUum+4Eh920Gom3moj3W83g?=
 =?us-ascii?Q?NBXgoUscx9R5u5tTMhZgMe0ZtPM5WterBhCnzuyoPAEBKgvAP1m9/8RYXEIl?=
 =?us-ascii?Q?oxFEVlrHsyD46uLd9PK1NiwXXjna/Nw75Kq660pRnGqoPOOvkdbjkYGbTl6n?=
 =?us-ascii?Q?TR5qxvtyeJvb6affjqny2WCOr0B/I4Cx3Z+v8+sr+G6JX2Sn0ajX0AwABXQG?=
 =?us-ascii?Q?Rf9vQIGoTPfwGWxXaQrJEFoXdtuTweDSoXica+CLoOcvvkoOTeVyPlr3CPMG?=
 =?us-ascii?Q?4d8VlohBwmi8yA8bj+UijBodfosBuqyhQBTpQIhc4F8Z+8sxeI2GTf5zaO67?=
 =?us-ascii?Q?gcUVbeWxNx625SuyEsd/SFGZV3zYu1tjYFstiMW06FEZZeblIQxnM3qIGju6?=
 =?us-ascii?Q?pV4SDlDy7WtFpeuc3kCMkpkbIa7UBxgJw3XCYegiiMM1M+HHGQ6l2MsRNaY5?=
 =?us-ascii?Q?Sr0sJDulDjJ7XW8u8f0sOcXARql7yngkhRQSCirdy2BNL6gbQN3Y54xIh9mP?=
 =?us-ascii?Q?HLraNINcEBxk42SQ2SMH0wwvUNvsdeTYR94UKX1Mm96ib230CtVnuuenyqdQ?=
 =?us-ascii?Q?kgIuQj7BoJLdJ/0cWuQoaY3uW3cQECXMKTkKyR6outCPI9YC1Mu49dL4dRB0?=
 =?us-ascii?Q?VNwBqEu9XRkcSYjY780H4GAOy0laYp99DDh+wsopWwdKieEzeCZCEbmrGRds?=
 =?us-ascii?Q?byL5AmONjDmCMkAYpD1ogpNhfBrPxCrVytJlAoZYUL1VeqPmuDqbAEuKPAts?=
 =?us-ascii?Q?HxBpM1shPn81HeX0fLTcF4x0FCW4bZxLZ5Un3L0+WyUQ19M//xDBCx/Xuyvk?=
 =?us-ascii?Q?3QqchXVzy7WsNPmS9Kl8CWMKIWz1RtHva/qMmtjZTDG9ED9gY7VcRiatblAa?=
 =?us-ascii?Q?PfK49H+c/uEMcBE1FCiRNS6cKMTHczhEKh+2PZdhW5ksOJvaYuFtaa5PNFae?=
 =?us-ascii?Q?3/HDh+lUwI9YaTSKaoQNUYqFRCYRSt7T1IPQ8CJvQbTDvdq1doii+BihrNKR?=
 =?us-ascii?Q?YgwhQGdxEGOaEDJiiNO/wcaFv693Rw5GwiyMU49ZwjIiKJwsjT0h50dwcK7Q?=
 =?us-ascii?Q?3EhbRou2pdA1XuRlzWAjt6BQbUpPXKXLYiM6a6XH+anOmdU2WRB5RP7qryz7?=
 =?us-ascii?Q?7A5rTdKQAI/c+8tkKrQeJ7aHKW5JUpUFOYApCwxpcW0J05j89WsrxAVUntX7?=
 =?us-ascii?Q?Iyq0gE8kYlxKEHJEACU59+gO0D4v09VMJbe1ildfp7ixiLAmXG7BPW2FSaSn?=
 =?us-ascii?Q?M2vbXmCE7vV1AJsKQ/eG/DVcdnOykCo8qsv/KGLFanvubvxFZ+msCyWy1xoi?=
 =?us-ascii?Q?wd4Er0IXRh16KmSP/IZ+4MUb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add72cc5-7647-4b2f-328c-08d8efe31d95
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:10:00.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpSb3OWgtI1XC71zeohWPPQIWNvoRX1+SOSQCvAvOMvrdGU7jyq5wlleQvW8+VZ/ia5A0M2OdcZ7XicYl6uMslH/fKdATh85VPnH4kbLWS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250170
X-Proofpoint-GUID: b4DDCjW_qozs93J64QvGDVlWQcAYzpnF
X-Proofpoint-ORIG-GUID: b4DDCjW_qozs93J64QvGDVlWQcAYzpnF
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250170
Message-ID-Hash: RHKF65BDT3ONZ2XL3V735AOQ7DCZCWCA
X-Message-ID-Hash: RHKF65BDT3ONZ2XL3V735AOQ7DCZCWCA
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RHKF65BDT3ONZ2XL3V735AOQ7DCZCWCA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Move struct page init to an helper function __init_zone_device_page().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/page_alloc.c | 74 +++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 43dd98446b0b..58974067bbd4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6237,6 +6237,46 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 }
 
 #ifdef CONFIG_ZONE_DEVICE
+static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
+					  unsigned long zone_idx, int nid,
+					  struct dev_pagemap *pgmap)
+{
+
+	__init_single_page(page, pfn, zone_idx, nid);
+
+	/*
+	 * Mark page reserved as it will need to wait for onlining
+	 * phase for it to be fully associated with a zone.
+	 *
+	 * We can use the non-atomic __set_bit operation for setting
+	 * the flag as we are still initializing the pages.
+	 */
+	__SetPageReserved(page);
+
+	/*
+	 * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
+	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
+	 * ever freed or placed on a driver-private list.
+	 */
+	page->pgmap = pgmap;
+	page->zone_device_data = NULL;
+
+	/*
+	 * Mark the block movable so that blocks are reserved for
+	 * movable at startup. This will force kernel allocations
+	 * to reserve their blocks rather than leaking throughout
+	 * the address space during boot when many long-lived
+	 * kernel allocations are made.
+	 *
+	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
+	 * because this is done early in section_activate()
+	 */
+	if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
+		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+		cond_resched();
+	}
+}
+
 void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long start_pfn,
 				   unsigned long nr_pages,
@@ -6265,39 +6305,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_single_page(page, pfn, zone_idx, nid);
-
-		/*
-		 * Mark page reserved as it will need to wait for onlining
-		 * phase for it to be fully associated with a zone.
-		 *
-		 * We can use the non-atomic __set_bit operation for setting
-		 * the flag as we are still initializing the pages.
-		 */
-		__SetPageReserved(page);
-
-		/*
-		 * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
-		 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
-		 * ever freed or placed on a driver-private list.
-		 */
-		page->pgmap = pgmap;
-		page->zone_device_data = NULL;
-
-		/*
-		 * Mark the block movable so that blocks are reserved for
-		 * movable at startup. This will force kernel allocations
-		 * to reserve their blocks rather than leaking throughout
-		 * the address space during boot when many long-lived
-		 * kernel allocations are made.
-		 *
-		 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
-		 * because this is done early in section_activate()
-		 */
-		if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
-			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-			cond_resched();
-		}
+		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 	}
 
 	pr_info("%s initialised %lu pages in %ums\n", __func__,
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

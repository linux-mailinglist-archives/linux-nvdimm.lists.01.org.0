Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B12B349CB4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 28667100EAB55;
	Thu, 25 Mar 2021 16:10:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8E933100F225C
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:33 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNAHj5136830;
	Thu, 25 Mar 2021 23:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=IYSeFT3PKOSLK03Sr/oxNuTZOq3HJR8yrGxzOY6hTwI=;
 b=GEN96YFXtN/4IlQoktWOMyZoFCCRu1E2UVbMfcajqTgoDDKKTfPFo9nEpb/qMUDaXyrI
 4F+USNKKaLsRESYdOyl8zFAFNKIwl7e7zyzTW/rK07kjiCsUqbgWXW/jvNbLnK50N18O
 EIccLjRRwHdF3h7PyNSvru7zcQpxNxmEWr8IRq9/eVtbzbgJCG+vmKdJ8NhO3NmEPMle
 Lt0ZH8VgOsj609pHjOF5C0+vz4w1UIN1TjGxvyiYSLkBIZRRf6l1WFzoNhr7HykbFFVD
 FsffFDBjvxVBxbOjxEIhE+3En88bxWJHh2qr27akljYcyIUkxkI2KlPCzR4KcrBxkxiA wg==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 37h13e8dxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PN1Ko7002948;
	Thu, 25 Mar 2021 23:10:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by aserp3030.oracle.com with ESMTP id 37h140nhh8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etm+xDll18SMSsVBEfeinS5EOTQ50wTmCvmaxnIe2sVKUHgGjP6NhioZYetCnq0TTUbkRyxSRRMOo3MeLwnHcObKwkpZW7hH5EVgPgJ9Ubiqgfq6MGRkQD/TVO+Nfb/4HYAu7dGxRTdfJ8UIb1uEiOYYi0+J0xMjr2haUe3RXKPYNUeROfLbWdIOuSUvw06A6GFL5JYPK1pbblD1elhZZjp4bkB/fr3rr7rQxeJ2JU7Adis/cDmiltDhraweziZ2ayH5+XlfMOJ2r/iYo8SuTKOQDovfVmsL4mMuWuTVHrjNfFh1Hi0o9MGbhEE8J9Bh+u2pR1ukRrypCSlVHG055Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYSeFT3PKOSLK03Sr/oxNuTZOq3HJR8yrGxzOY6hTwI=;
 b=T85ZBa0Gz3qbf752pOT4FOu0vCkMUOvtqe/EcKYfCuj96JceLxvAhDcg+wUAeTZoTqI0AYe3GrUrT0FNvDxjD0y69bzHtC2IO+2QAsIozfOWaV75ZnRZKR2N6/trdGgSzp6fsANFx3c/ynwWwfNKgTX2AEedcxR6O5eJ1hHkfsfeZds0qm/QFcSVly9CJtTXbGQm4K/lchkd6dJ2DjocVbSUpHwZWWA+lwsVuEWnPmJj8vAcNvwMoTF0yL4vkVqP3nRBF3p/0oLC6AkrZNh6423HtHkSKaB8BGrLFMuA8Rg7sKB9JYIi0bxaSuWuSmYe9DCqvZ0zBHekOxWnfEuv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYSeFT3PKOSLK03Sr/oxNuTZOq3HJR8yrGxzOY6hTwI=;
 b=YcwpZyuV2XyzZD+zkOO0EkfWtcSfTodB6hlDcCWRfAykzGswLlWpBLByihKP+nIqk6Iae2eufYjmdgBbGifqJjL2rIBI958XsWo35iWorU49D1KUXShkSCT6Yj271pyGvT6nLsym9E8owW2pwsmToLhOI2G7N7mFJakYQ0xHIxc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2853.namprd10.prod.outlook.com (2603:10b6:a03:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 23:10:23 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:10:23 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 10/11] device-dax: compound pagemap support
Date: Thu, 25 Mar 2021 23:09:37 +0000
Message-Id: <20210325230938.30752-11-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:10:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b525738f-d968-4734-015d-08d8efe32b25
X-MS-TrafficTypeDiagnostic: BYAPR10MB2853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB28530476AE76C01C34F40B2CBB629@BYAPR10MB2853.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ybcPQ6fIy+mt9RcJtx0XBBAcpAvkrl4AbMoC/yLkVIKUg7+E4bMlBmf/Yc3+aKTgvMPYEuS9xtZnlY8OIiwmXY1EJtLuiAi2Kr3ld/Qq8R2K0gwPfYVz5Rjj1lphB5uqmTowrqFNrikzqiQLdh+e3N4vBaWSldy7SSQ3skdv4xK5NFMvXQBCdkvFWWqx3Tg62E7sipbErbsY+a/pu9U44BvGufQdEW/DjN5U9VcZYPAZY9BFD3Xqo7sTYskBN+MISzozLl42C8titX2I9FGvkJbgX/t6kMoYf+oPjPH38qBkMWnbhOb0eFutkFzcUwMmLUhSdjffU14zAKpsmwogbjxXdYBKu7d8RFfRHEI9CD31uytD8I/+2sRXbnnjNjRQusGIj7egWxv3scIKcWVK3GnZLioXMjhskTvAA4OPaGg/NPNATzWffnqQdQsfdfGNOEoF/A4V9wcawijRJP5OlJNRbUfANk+5M/FWU6C3AS3u72SkjQ7TYi1zHE9vVXOXx67ALHYts/PkT1b5DbEUepVKpm5LgRMuaOHowhDilcA84jv18YPXoIY7X/idVdtL6nFsQTUKAs0jUvgFHNgxHrExq9V+0F98dCl71BSctn4JNTLfuma0w+QgEOKzwbvPDWk99ssSYexkzTb8JbWX4Pv5DvxGeu8X2daIhm7A15w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(396003)(366004)(136003)(38100700001)(4326008)(8676002)(1076003)(2616005)(8936002)(956004)(6666004)(6916009)(107886003)(66476007)(478600001)(103116003)(86362001)(186003)(83380400001)(7696005)(5660300002)(52116002)(316002)(66556008)(6486002)(36756003)(16526019)(2906002)(26005)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?OtgS/otz953nXBf8nYoWlr2cJWomyvpNjI2tsPyduyDTawTaducu1Yar0d1R?=
 =?us-ascii?Q?OLCSJUC0SRkymJY6KHcZ2KvIbQVSebAB6TzcSdAqEwvliz0PIU/Cdm6m7dT8?=
 =?us-ascii?Q?nnnms2GE5lEHn5OpaTCclx7e8kMnkrcM6kNcPMjdnyTee96WBQ6zreMIzo5W?=
 =?us-ascii?Q?WPpPn+tSuoC9yx7TB1Utu+7iGfMfvmrifHbCVOcPcMEP3EGCLpA/el3JRlNX?=
 =?us-ascii?Q?gJfdmQxjGX3Xm39KrXW2t/NBMcs9adCLMESDhuSFKz1NgPz01nMJF8GWI00L?=
 =?us-ascii?Q?4PExa2jPVJ0/De8sGdQ2Kc6MtvtZz8cYeE4LNO+DCHXXvN6M837pAWrn5pfu?=
 =?us-ascii?Q?6C52yL0WvBqArzBypCmwt3Ba1pXJaqznLA8C4Fbc6sTkoTsqYZi+kIRqoHtC?=
 =?us-ascii?Q?qAfNzKyd+BZiFTFwRsGJhaayM4Gy3FPJfK1FLFM/aNppgf1YS6yH/YO/LvBf?=
 =?us-ascii?Q?nfQfgLr38M6tFAB/3pwkTvEk2ks9MkceXh0S8AQCVj/wBDbn0Z6quAMUPq24?=
 =?us-ascii?Q?tzI6PpLWIb/fZ9a3XMPttEO39LFsvIc6xH1HWBHar/p65wKmOeHtexnXprkh?=
 =?us-ascii?Q?1GI/A/bhfbOQoEYkUaAsqzUX5uBR5kIVW2BToJJFNzyxghHm8u+vfEa4E5hc?=
 =?us-ascii?Q?9EckMlSTzW+ogMstfb6x2Dc+OCI4bqgSdQz8u/FehkN5Iqy/2FC1p55WFEFk?=
 =?us-ascii?Q?y9i6qqSYJuDhm+JYH/QocvFzkNpLJvoXq6kOozSS1a7+cxle192ET3xRh5dl?=
 =?us-ascii?Q?yWReTmXA/O90gN5jG6fJ2clYfxRlDIVPdghwXd8nOdgSL7Ql3moKdLJ/J7GP?=
 =?us-ascii?Q?qizcbasxAIFwWJd5DLUd6TgPhMhDYVU1tr7G1X/Lh8ex37wmU/v1Yf+MIyWa?=
 =?us-ascii?Q?kMsDaefQ3Qq4+IG0nei+AE6pmSxlBODtgLZyJllCS327Cef6jYsoniPWVyyO?=
 =?us-ascii?Q?3GbuAFjifaLbjk6cnVcvfEAR4Tv0Xj+R72Dlf6MhodzdgC5zy636e2aoP3B2?=
 =?us-ascii?Q?Cmss+68R/CH7QLmFfwsJQXbzHmPv5VAqMMD5n3bK0L9vZ0XkA2PGaDFODXjJ?=
 =?us-ascii?Q?HHqhq+F0EniI1lkLarW+sneeUy6Qo74V1rNi5SDPlC/7TnkpRY4FCELOwfKi?=
 =?us-ascii?Q?bXMvgpVUfJk7fnOIopdXZ+wKudOBTgsU5EUtp6EJDrJe5UcOotIn1aUII5lk?=
 =?us-ascii?Q?1nnyxxhB5HLikjFhI5kPO5YMrIUInexatpNbsGqHypQuQP2PxvnLlckflGn9?=
 =?us-ascii?Q?gdD0A8SgCvrllbe36HTiVLpfJ8CrwZhRRl9pHdWpBZvYHBKpKa8roHxfjEqg?=
 =?us-ascii?Q?ZPsc7M34eUmNmPNrNlNCyogM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b525738f-d968-4734-015d-08d8efe32b25
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:10:23.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /t2V/bTRWG92xMai7Tdg4ewVrfHPUrAL9vBp2nLXV6BWP9YiruPBxPuWfQLdCcSYXpLPHWqIzrnQhTcKX1NpJjHNowQSuPq52QrNEh873ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2853
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250170
X-Proofpoint-ORIG-GUID: tuYdsBbc0DzjLg-8akuONTWhRb81AwUa
X-Proofpoint-GUID: tuYdsBbc0DzjLg-8akuONTWhRb81AwUa
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
Message-ID-Hash: KOTCI2GR4TKMEMUR32ZA4MCAIQW272TA
X-Message-ID-Hash: KOTCI2GR4TKMEMUR32ZA4MCAIQW272TA
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KOTCI2GR4TKMEMUR32ZA4MCAIQW272TA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

dax devices are created with a fixed @align (huge page size) which
is enforced through as well at mmap() of the device. Faults,
consequently happen too at the specified @align specified at the
creation, and those don't change through out dax device lifetime.
MCEs poisons a whole dax huge page, as well as splits occurring at
at the configured page size.

Use the newly added compound pagemap facility which maps the
assigned dax ranges as compound pages at a page size of @align.
Currently, this means, that region/namespace bootstrap would take
considerably less, given that you would initialize considerably less
pages.

On setups with 128G NVDIMMs the initialization with DRAM stored struct pages
improves from ~268-358 ms to ~78-100 ms with 2M pages, and to less than
a 1msec with 1G pages.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/dax/device.c | 58 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index db92573c94e8..e3dcc4ad1727 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -192,6 +192,43 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 }
 #endif /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
+static void set_page_mapping(struct vm_fault *vmf, pfn_t pfn,
+			     unsigned long fault_size,
+			     struct address_space *f_mapping)
+{
+	unsigned long i;
+	pgoff_t pgoff;
+
+	pgoff = linear_page_index(vmf->vma, vmf->address
+			& ~(fault_size - 1));
+
+	for (i = 0; i < fault_size / PAGE_SIZE; i++) {
+		struct page *page;
+
+		page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
+		if (page->mapping)
+			continue;
+		page->mapping = f_mapping;
+		page->index = pgoff + i;
+	}
+}
+
+static void set_compound_mapping(struct vm_fault *vmf, pfn_t pfn,
+				 unsigned long fault_size,
+				 struct address_space *f_mapping)
+{
+	struct page *head;
+
+	head = pfn_to_page(pfn_t_to_pfn(pfn));
+	head = compound_head(head);
+	if (head->mapping)
+		return;
+
+	head->mapping = f_mapping;
+	head->index = linear_page_index(vmf->vma, vmf->address
+			& ~(fault_size - 1));
+}
+
 static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 		enum page_entry_size pe_size)
 {
@@ -225,8 +262,7 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 	}
 
 	if (rc == VM_FAULT_NOPAGE) {
-		unsigned long i;
-		pgoff_t pgoff;
+		struct dev_pagemap *pgmap = pfn_t_to_page(pfn)->pgmap;
 
 		/*
 		 * In the device-dax case the only possibility for a
@@ -234,17 +270,10 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 		 * mapped. No need to consider the zero page, or racing
 		 * conflicting mappings.
 		 */
-		pgoff = linear_page_index(vmf->vma, vmf->address
-				& ~(fault_size - 1));
-		for (i = 0; i < fault_size / PAGE_SIZE; i++) {
-			struct page *page;
-
-			page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
-			if (page->mapping)
-				continue;
-			page->mapping = filp->f_mapping;
-			page->index = pgoff + i;
-		}
+		if (pgmap->align > PAGE_SIZE)
+			set_compound_mapping(vmf, pfn, fault_size, filp->f_mapping);
+		else
+			set_page_mapping(vmf, pfn, fault_size, filp->f_mapping);
 	}
 	dax_read_unlock(id);
 
@@ -426,6 +455,9 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 	}
 
 	pgmap->type = MEMORY_DEVICE_GENERIC;
+	if (dev_dax->align > PAGE_SIZE)
+		pgmap->align = dev_dax->align;
+
 	addr = devm_memremap_pages(dev, pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

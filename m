Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65741349CB1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC6CC100EAB45;
	Thu, 25 Mar 2021 16:10:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 771E4100EC1C8
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:33 -0700 (PDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNAM4Q143171;
	Thu, 25 Mar 2021 23:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=amhTLQinMuwxgNnk2V0csPPUmxneFDqpFfpg5NELNYY=;
 b=XHE/u8kPXaUtlKJIeiY6xqDQOl87/RjNTfIsH39EYjYSv8/NJapuWV28rsdt8zDvUkgf
 cbLUu5XLlYAwGR7lIOLpMowAAsv3oeJ4HVSNeUcNxdyvEexhNLs+mYBZxXWbywFUlQh4
 WHA1BkOtMfdo4kHgTEYghPml0BLSytX6XJ4kj6FJyaoC5uJ/OvituJnZ1EZQg5IrgZX3
 6JXm0RkhbwbfL2NQs7Axt6Xj0fmNf4En9uZ/3/2y18mQWxt/yuSstEHwFHFOc4ZHkmaz
 fxWk5ywULOWSc/niKfYYT1gmOjBuV8y/YBUIxRPMXanLPCpssg4kwu/oLipFQwGdVL7S Fg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 37h13hrdwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNAItS009261;
	Thu, 25 Mar 2021 23:10:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
	by userp3020.oracle.com with ESMTP id 37h14gdpy3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIjTzhbG2mNSUKdy87GzjqFpakuC+K0QSAhoc2Qluz0r/nNUXahFGfv6MX436mY4LuhPtWKvMwDlsij2Ur8oqvEnPJ9RcOrAV8g8dFon7788xxCNZE+jCo2cuh+sSCuZLM47phiy0EJ6/EdYTGHoqdiqTguBA0EOywS7rkDmfGnhlmytO3qKMV2HaQpVo+AS5q5bBy3HN7p1k4tMhgedI6+rYFgAE7STCPSgdeTGX/RdJdP5rGQN9vhPutVqXSn6V6MnSYgUXAe2yDkUIntj2UgOAKx238xwjUZlXENgDGOE5y2SbLlqe8zI9ukUBGv0TTKpB/sfjMxAopm6QBKI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amhTLQinMuwxgNnk2V0csPPUmxneFDqpFfpg5NELNYY=;
 b=EQ+cIFwfzxf8A6t7ZR5U8FfeKmDsYRAPi9jsJVegCrV1ETjgNrdtaql58/ysRGcrQx2hcQAD5Q0NqUQ8ONHZ3tSUy0PqQEmAE6aAp4jcz1bgRtJBWJ+B8QqnyR3ofPpQtxWS1j8L/JaFD03A+OTotYEJUKCUBOkijU4sAknvikwNzR3f1udriT/IO/kbUUFcyviHHtIO2VGyVxdyB2N+LQOEvdH3/EhTSTDV9QrGF7j7MpHomU/wC83h8JINz1UPneAJQnP3LvWCKVq+lN17qsJuIgOYB28iqo+0yZrE+9iNP7LRrygMgy90vp8OKELpxoNX0JJLt0ETtnExR43nQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amhTLQinMuwxgNnk2V0csPPUmxneFDqpFfpg5NELNYY=;
 b=WTkG5W4tQbcbFthoXvdvw17d3KbFx5wfXg6dFw8bIdFwPKIR0Zoc0WWNuKvnPsFQYT6jGcejsDVQtWbtrr+nmnJkWCop6xJdWAI0Rg+eoqu2fS8Qwu6Gy51r0jPQCRppYUz+0MDCnGKUeLEhW/CuBrxupMYNAClNc/vKtjqQsKc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3987.namprd10.prod.outlook.com (2603:10b6:a03:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 23:10:07 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:10:07 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 05/11] mm/sparse-vmemmap: add a pgmap argument to section activation
Date: Thu, 25 Mar 2021 23:09:32 +0000
Message-Id: <20210325230938.30752-6-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:10:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a8e4e9-e069-4ef6-9023-08d8efe3213b
X-MS-TrafficTypeDiagnostic: BY5PR10MB3987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB398759E87A972BBE8CDAFD32BB629@BY5PR10MB3987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	naDulOLEQrr+hw7j4TmtAr4HcgV6yV2QlFAuVRpXJz4+GAmNAzNRntGPgSpLOVXOmB8MS+2ZiQfDTDR0smw747t2BqRhsKBl1P9905+dbpy9ur3BFaWvfAUg1qXKhU60VjlPoankuGncEtDM81bdhuRidnt3p00Mc950WfSSKkUolKOCUb5SU+aRGdc/DnTWjCtqH3+DFFt+xKKTOXOeFkzoJHOeGM6lOUGCsFdvUgJc7+sBqPqaB8c4Hli2kPn9uBQw6tEiLjxLMDKDZzuOdCZmH9YSFZHTjjSfPC3nHd2zVeRbpzU7jLZgW79KLe0++eStgwJdMyFkKsns7PrnC8nTS5C2S8r81G2NFa6poLNVk6SWRZBC4DsyTUSzXqm1EC7o4rZEqrvDfLPxR9vSEPVReP/itTDgFeS0rm1MLqbRmFIec128vNlyYipYJWPFdmTvwkH17edCVmxtEjgaAkI5pS2Wrx4LHLWPC9gIooaNgrSjAiz7SdaTqsC2v/Dn0dkpA4vcBuhpbNbU0basFcNNYEAXOM5dGhFUIUYLhLKvxFwN8o0ob95MKrxMDaRr+SGC2xtQkiF31BrfbmGHk8Syi0AplBcLHHywS2mOdc8V7AxDHp9faLnNPDhgt+thh4c+AbUIPdMRqnq7cKGpY76g11YNurSy36vqA+ScDHfCUYF0Pgv5mIUtlX0+CqCxPe9nStw8ciXSVtuB/GBB7D6yLYuoFljAq/dQkS8D3g2pr/m/W9A/K94UH/wM1lUs
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(83380400001)(4326008)(26005)(107886003)(6916009)(36756003)(7696005)(52116002)(66476007)(966005)(66556008)(478600001)(66946007)(186003)(316002)(2906002)(8936002)(54906003)(2616005)(86362001)(8676002)(956004)(5660300002)(103116003)(1076003)(6666004)(38100700001)(16526019)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?0thRjAN6hn5++DyXyOnfKcuYN/wcB7JaENCXa2AapuHvO+XYKrlmhfMMTmbH?=
 =?us-ascii?Q?2zq/4N3/p0H/74RJ8TiRxAFRbmE3lSepLxqs5H0asu/ziZ4eH2xGywylfbNG?=
 =?us-ascii?Q?n6XGzEsH+VtXwgdrH6fiSXHDWFgVUfEoOcPLKnByCYbaNuJaquW7iTAV3sYO?=
 =?us-ascii?Q?qM77FcH5ozZLUdf8CRSffPcdAovFD0Io3WkN/LnXBDrBGqhfKXcORWRcPbC8?=
 =?us-ascii?Q?AUd4TYmT6F2TxRqJAGBFe/1yVaCs55qvPF2LXS+0f44PbnbtH7Qr1A4DFSF4?=
 =?us-ascii?Q?pQMRcq/NzYUhpDDJXL70jkzHVcj30cr2Vrh+f4821sDh3JB9HJG4sKKp88Fq?=
 =?us-ascii?Q?5WrY6e4TbzHd0r3YRnrfCftEx4IVj9MYMJ021N250NXmR/aS29pHDb09OXeq?=
 =?us-ascii?Q?G2uhVH01SO1eckxL0ojS/jtr3FvsrVlN4ydfH26gJpdbUuyxJZki7FllBFsY?=
 =?us-ascii?Q?62gfe9ohOuuiArdhUDOSQHq1X7LSbN8KASCDts5BWHbtJMYBfYiMbyxv5qa6?=
 =?us-ascii?Q?WtQXK2QbjDrwfiW72tE5S8gSsLy6QTpAdNOxgwt09S3pQ5X2zA3bpjLyiLxs?=
 =?us-ascii?Q?DMJygpaNZlBLBKeHccLAHU2mRLFnFJ5gkpAr177syZWbkpWVnqP+IKxJdGpi?=
 =?us-ascii?Q?vHe26cud/MMHO4oFPkUcuhSrtkMbbWpbss0Rv2u6ehfoTIxbU6/kNWFKKnpd?=
 =?us-ascii?Q?q/BykphkvSVZCfqivw0msH0/GALOPl6E676uc2DoOhO2FbdFwx7Ve2WjJCrm?=
 =?us-ascii?Q?CNnXHktE1QkLiHQUBpYJixGxRxHY73QYue5OS64cCGc6yx2JX8C5XSSoGxQk?=
 =?us-ascii?Q?Sc1J1leoRR1sClJ9h7qC1oQbqtarR9AqB9kF1HCLAHnWDI9dEg0CHZK3AKXq?=
 =?us-ascii?Q?Zn17pMBNSiFLP90Vg9rynUPn0V+x+HKy+H7+CqnHFmQCRWQ7/0vevYmyE+cc?=
 =?us-ascii?Q?T308XLLwA1tEm73tlCzZrs5XX6gwdlLp3t7jOU90YDLYlZJequuf8I4BYO2X?=
 =?us-ascii?Q?WIZ2/qr7nUxmsn9U01AmKuk2ScmRqnopsVzHt06qxNJFMBCLLGUReHTScHdK?=
 =?us-ascii?Q?mGqJ0adYkmgK7Qi7637E/CI4iuSdjR0yhUMZXT+M8M7IIx0R9Cf+6XC7E4OO?=
 =?us-ascii?Q?TXxfXtevQqwYr8q2Bk4jnL+ER3PlfkMNauxpmdyJjrICXms6o0t+8zbbkOZv?=
 =?us-ascii?Q?Bmzic3ZFLS+pZUDZxwCDV1UlUSqEAw6cLiywS59JxVvhmdmhv+4WwyqPUc1/?=
 =?us-ascii?Q?o/v/0gBj9O1iYbl8/PL8Svj4YET2OrU3gXpOIH/3pQQrqlGpvY16TOwRebqL?=
 =?us-ascii?Q?Y+nKAQz0VzdtGIrUgY0v0wj1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a8e4e9-e069-4ef6-9023-08d8efe3213b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:10:07.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fJMTTlVRwxfl220ajjYW/tYRIcLuLbPKXAxf0TLvoDazoeV0VteTwrcgul2mZ6Q5Va3rPZAoMD7h7a8zFXKa9p0+ni/VkQ3YBU2uanY3iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3987
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250171
X-Proofpoint-GUID: ga212bBJh-fMU4fJ1xD5Peg49mTBQJp8
X-Proofpoint-ORIG-GUID: ga212bBJh-fMU4fJ1xD5Peg49mTBQJp8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
Message-ID-Hash: WA5F7R2XAOMXJ7RB6ODTSXVRO2LSN5GU
X-Message-ID-Hash: WA5F7R2XAOMXJ7RB6ODTSXVRO2LSN5GU
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WA5F7R2XAOMXJ7RB6ODTSXVRO2LSN5GU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

@altmap is stored in a dev_pagemap, but it will be repurposed for
hotplug memory for storing the memmap in the hotplugged memory[*] and
reusing the altmap infrastructure to that end. This is to say that
altmap can't be replaced with a @pgmap as it is going to cover more than
dev_pagemap backend altmaps.

So in addition to @altmap, pass @pgmap to sparse section populate
functions namely:

	sparse_add_section
	  section_activate
	    populate_section_memmap
   	      __populate_section_memmap

Passing @pgmap allows __populate_section_memmap() to both fetch the align
in which memmap metadata is created for and also to let sparse-vmemmap
fetch pgmap ranges to co-relate to a given section and pick whether to just
reuse tail pages from past onlined sections.

[*] https://lore.kernel.org/linux-mm/20210319092635.6214-1-osalvador@suse.de/

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/memory_hotplug.h |  5 ++++-
 include/linux/mm.h             |  3 ++-
 mm/memory_hotplug.c            |  3 ++-
 mm/sparse-vmemmap.c            |  3 ++-
 mm/sparse.c                    | 24 +++++++++++++++---------
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index a85d4b7d15c2..45532192934c 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -14,6 +14,7 @@ struct mem_section;
 struct memory_block;
 struct resource;
 struct vmem_altmap;
+struct dev_pagemap;
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 struct page *pfn_to_online_page(unsigned long pfn);
@@ -72,6 +73,7 @@ typedef int __bitwise mhp_t;
 struct mhp_params {
 	struct vmem_altmap *altmap;
 	pgprot_t pgprot;
+	struct dev_pagemap *pgmap;
 };
 
 bool mhp_range_allowed(u64 start, u64 size, bool need_mapping);
@@ -360,7 +362,8 @@ extern void remove_pfn_range_from_zone(struct zone *zone,
 				       unsigned long nr_pages);
 extern bool is_memblock_offlined(struct memory_block *mem);
 extern int sparse_add_section(int nid, unsigned long pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap);
+		unsigned long nr_pages, struct vmem_altmap *altmap,
+		struct dev_pagemap *pgmap);
 extern void sparse_remove_section(struct mem_section *ms,
 		unsigned long pfn, unsigned long nr_pages,
 		unsigned long map_offset, struct vmem_altmap *altmap);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cb1e191da319..61474602c2b1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3033,7 +3033,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
+		struct dev_pagemap *pgmap);
 pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
 p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
 pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e0b499a1fee4..2df3b2a7b4b5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -384,7 +384,8 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages = min(end_pfn - pfn,
 				   SECTION_ALIGN_UP(pfn + 1) - pfn);
-		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap);
+		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap,
+					 params->pgmap);
 		if (err)
 			break;
 		cond_resched();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 16183d85a7d5..370728c206ee 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -249,7 +249,8 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 }
 
 struct page * __meminit __populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
+		struct dev_pagemap *pgmap)
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
diff --git a/mm/sparse.c b/mm/sparse.c
index be66a62e22c3..c2abf1281a89 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -443,7 +443,8 @@ static unsigned long __init section_map_size(void)
 }
 
 struct page __init *__populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
+		struct dev_pagemap *pgmap)
 {
 	unsigned long size = section_map_size();
 	struct page *map = sparse_buffer_alloc(size);
@@ -542,7 +543,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 			break;
 
 		map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
-				nid, NULL);
+				nid, NULL, NULL);
 		if (!map) {
 			pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
 			       __func__, nid);
@@ -648,9 +649,10 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
+		struct dev_pagemap *pgmap)
 {
-	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
+	return __populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
@@ -719,7 +721,8 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 }
 #else
 struct page * __meminit populate_section_memmap(unsigned long pfn,
-		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
+		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
+		struct dev_pagemap *pgmap)
 {
 	return kvmalloc_node(array_size(sizeof(struct page),
 					PAGES_PER_SECTION), GFP_KERNEL, nid);
@@ -842,7 +845,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 }
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap)
+		unsigned long nr_pages, struct vmem_altmap *altmap,
+		struct dev_pagemap *pgmap)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
 	struct mem_section_usage *usage = NULL;
@@ -874,7 +878,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
 		return pfn_to_page(pfn);
 
-	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap);
+	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
@@ -889,6 +893,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  * @start_pfn: start pfn of the memory range
  * @nr_pages: number of pfns to add in the section
  * @altmap: device page map
+ * @pgmap: device page map object that owns the section
  *
  * This is only intended for hotplug.
  *
@@ -902,7 +907,8 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  * * -ENOMEM	- Out of memory.
  */
 int __meminit sparse_add_section(int nid, unsigned long start_pfn,
-		unsigned long nr_pages, struct vmem_altmap *altmap)
+		unsigned long nr_pages, struct vmem_altmap *altmap,
+		struct dev_pagemap *pgmap)
 {
 	unsigned long section_nr = pfn_to_section_nr(start_pfn);
 	struct mem_section *ms;
@@ -913,7 +919,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	if (ret < 0)
 		return ret;
 
-	memmap = section_activate(nid, start_pfn, nr_pages, altmap);
+	memmap = section_activate(nid, start_pfn, nr_pages, altmap, pgmap);
 	if (IS_ERR(memmap))
 		return PTR_ERR(memmap);
 
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

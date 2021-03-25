Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE03349CB7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BD4B5100EAB4C;
	Thu, 25 Mar 2021 16:10:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 44EEE100EAB4C
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:43 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNAaFO136887;
	Thu, 25 Mar 2021 23:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=qk7F7RrEv2ndA9z1VMQVsJEgAKfhVBs0GSQxMoEVwTQ=;
 b=fgWr2A6mEqCMD0HxhwGorbc3riuHs+oShrccwGj1BM43iDqiWW2W91zG/8NeVTiCckN7
 GEvWV5M900qtip6FRVwPOoa46H6kdr9IvhfF8GDp93jtP9DUIGfMQouo2kDL8lWKhipH
 FtJkfG8whAPVyxKpCr3WxRdYyX/jKb1ihnKy1dTiD5fv17uR37HT7dybDeyYIyfxG+/Q
 2ruOxw2T7UFB7GxlB4s8n5x0lAE8+rFuDXHzCqT4akOSM6QoJlTB6zO2cdhEspK6mBf2
 I4ngGDWHiLG0IYikz8aq1KLS8BDU0eJ/jPFGif3SyeKhya/jjW/UdoaeEblW9WhxpByq TQ==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 37h13e8dxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNAWNB148442;
	Thu, 25 Mar 2021 23:10:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by aserp3020.oracle.com with ESMTP id 37h14mdknt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmlTxv3jZzPh+QJugh9/tekA9DHu3m6c8VwenJRUfBnrpPMp3E+cA0frSEBkWLNTVg94qyXs7YKWPtb7i3Bb5VWAS0+pZj7++FyQXsaB3M10rm3CEzwxx+YM7xBrN49MpeUvnzHwV/o7+dqgkXTNH2ZGBWfeqoB2H3m+oJjTp/ba2tRG3IbarivxRyMZDA2FQjbIXMtdu84YlcVY3g6p3U8v80ULV4v5Ovy3LCSiAvw4zljkGy1nuh9fLijVH6W/BEDNej+Z+P+DxrVZFJYPSeTwjSOLpNxzL99c9Q17iF7v77Yf1++wxjIKPhKIJXdB6ombq876pFT2ndYSmlPdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk7F7RrEv2ndA9z1VMQVsJEgAKfhVBs0GSQxMoEVwTQ=;
 b=bnEj++WX93Q5A17vyNlqkOBhtoGiPlwd//3r6J7CjFbRXMf2uaLtjRFwYL6wxLarjo7gSyQMXKpK2+dCGM43C+hb4+YEtk1+ZlRefoLp3s+7WlmxvIHeh0XMia8cKworwcQEsmTJQiMZMPyQ9O98VpZEVyboujNgA54ruLSeGU9otckVTMuW1YRgB6fRpVCWUlPWL8TjwSnXlTg1wTKmikqOir4aBTmpNLv03hFLRqlcBZthlNgxcTpCiFzSSogyZxXrb+AGdmCHnRbpgc0MQi6I0ihijTQMNTtBuICySdZJWXb1/mGT+4E3aPsaHebBb+TvRSV3u3BgTbrSFjMk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk7F7RrEv2ndA9z1VMQVsJEgAKfhVBs0GSQxMoEVwTQ=;
 b=fBzX7mbksXE+EHZWYy8ASp0plUSey9LMhBrtoXuzIYdnCoVCnhX/cCwG+NzhozAZEME4T2SwEe0QaYJgqgA+g+TnyZmPAlp6RqUwTAP+dVVQod7wkhSYNcl7J172DMsdH0DrV5cTX5w311OibD4Szo8be3+1voLYFxHvahiTFr8=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2853.namprd10.prod.outlook.com (2603:10b6:a03:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 23:10:26 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:10:26 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 11/11] mm/gup: grab head page refcount once for group of subpages
Date: Thu, 25 Mar 2021 23:09:38 +0000
Message-Id: <20210325230938.30752-12-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:10:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 221a6aea-71cf-4e5f-91c1-08d8efe32cf8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB285380D61B8E4114369D5675BB629@BYAPR10MB2853.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EYuU23tNWZ80qzM2+DfwO42DD4Yhj9miD655jmaIj0jpCcOl9CQLom98xWiqIuje6CaYj8LvRwBbw/C1YguvrLCV48p7QvcXjaQYKEPHZAk/jtEIYu1HZqH3Hp1/0eTZJME2VHyfaJzrjT6w1hWcNUCjNb8SKCnOirSreOjuKuG7hY0Ip1gfUHwMJD60ldMeZAKtBjFgq0tkpBWBU/CGhxLkyG4+mWz0LmcIUwAi5i0vypXH1zDf+ZdWOpYHxYq+MMFD5SzXKg0PtIlLQOJU35fO2zUXvpgOj9043X+mhzeEOVOj9vFJCHf+prg5awawKCItvTxjiSiwP/2roy308ao3+XTj2KttntfTGRkipmRR2i4ba0eoXd0qX5hRqxtJ8tO2cZu0xFlX+ezGA5vps3ePWvg1L2lVTNSMPvcfCfL3tNVlzb9AI6LViJBYcYUnhBOi0OSNpy4SZniCABFd5tquR1xYDJ/mttXIkNOOqYwOVo5GoWSDaiVrCYdtl8jnAtmht3AlVQLp6ckbPdBybf9DQYTYCIHjLJBEhgQGurxl97Qe4NPXX1HS2lYQnLqfCszJvUe+4MOgp28n5ZMGAKhVfwjsX6pVBgWtXjotgpQG++7snJgKndGaYCtHRzZeZYJ+/arj0j+ta3h12BhhlL4307HLGEv8Kf33aKz5ybY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(396003)(366004)(136003)(38100700001)(4326008)(8676002)(1076003)(2616005)(8936002)(956004)(6666004)(6916009)(107886003)(66476007)(478600001)(103116003)(86362001)(186003)(83380400001)(7696005)(5660300002)(52116002)(316002)(66556008)(6486002)(36756003)(16526019)(2906002)(26005)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?2isDJkI4qsg/jnyQOjoGN9esyXmkSUQD29d9JfKiv4zkl6y1Ng/8OQ+bU2Lc?=
 =?us-ascii?Q?qf9hw9HXXHxXgO2s7gbwwLvK0aKuZtRMkbMCLncStoWZynApwTBKhYW1z6nR?=
 =?us-ascii?Q?FUQQjg99j0m2IJtH7DhX+uUYSbjckvubRH63n7Zcy56yKe4ccAsqI/c2d2vR?=
 =?us-ascii?Q?nTJf8Xx/0VsNhajZ4UTRdyLw3qH49nYLG5YSharN5ytdetfruWO6qiCyQyYk?=
 =?us-ascii?Q?+Ou+CLxtChdv9UpkBdlzeMfD5vJpyZjpBHy9TEzyWr3wooyIeEYF0GyMcuBy?=
 =?us-ascii?Q?z84/q6YuTox8ISNVLkobH+xBb19x0BYFTCkYq+120Nq//iphHlV1oGIzC5wT?=
 =?us-ascii?Q?Xi61Q38WqiQfDSFuOq4UUJX/AtsMtcQXa30a3/OzFdtAd+jWP7TCaCMF+8gu?=
 =?us-ascii?Q?7jsM4cGKNJFc1sezVd4xsuBJFGOAd0UtypOkQRFF6+/RGWYRLIBSEVtYXYAh?=
 =?us-ascii?Q?rdm1YuF8DDoiF2c1Y2LXsMGwsNtYlnQG+CeTvPwdY3HOjbcYuJBNyqX5Y/e7?=
 =?us-ascii?Q?BARtJA1UJ9I9ByVq/3yp3pFj4h5oFrKY+UAadvP2W4rwA3MwKpMs2tM7QZWQ?=
 =?us-ascii?Q?mRjYckBuW0XiLiN/jL+9C/o2nHsl+1PxsRjBO4qrshdiTjfn9E3KT2VinGXE?=
 =?us-ascii?Q?S9Q/yjxLf7HF/0pnrYe3zWoQPr8U1Tgu84W3pD7UMBBJBoRdVu9o+LSCm00c?=
 =?us-ascii?Q?4XAqC3ZpDNiXbJnaVDUY/CEf885ItdEwly2yyFWPeg60RfZqhiP58ny8Y0nA?=
 =?us-ascii?Q?sHyS6xsYfwV1ZZI2QfMaS/jbmMuE9RcEFn7JvkS8AhJ40En0fYD02E29bOar?=
 =?us-ascii?Q?qZVD4fIW43AC2UI2e8n9MTlvLKYN2oN5yyjFTiA/6dSDScsOh8Qub64TF5db?=
 =?us-ascii?Q?UsGM5WTHArZopeyQtiUtvQMRs6SxvmvQnO8PitupJys0PUQRlkgkl3UPDuby?=
 =?us-ascii?Q?dUVF4ClS3B68gJVTj1N3Nh/73FxoxfPQT5eUKB6eitOO1sMP5ivMEype6D6O?=
 =?us-ascii?Q?SsnZixtU+xRUcahrAr/g1EjwJr6ADcjAz4CIvrGWXmjpgPDbB3ggeI5LBkOJ?=
 =?us-ascii?Q?jQH88uRdCKB1b7j5d1pd0JcFvqdDC6GLFJRKxZSdh1iEDtCntwOn3xgAPzqh?=
 =?us-ascii?Q?EF0Z7YQ2PsEQK60hO88j1+iCg3oF+3PHIvMVA0lehHM3QcP6zuxeAmYl0Bdm?=
 =?us-ascii?Q?97XodV6spwG6VM9SwjFjXmLxNHbKq0mak1uspO7SZS1BCSMMatSRk4AcQH0N?=
 =?us-ascii?Q?36pu4Qs3YhZnM4uIJxvQwhQ0fVOq+oSogdOCyU7paNh1jNJdZC9tDJki65fC?=
 =?us-ascii?Q?O5iEVsyMOBQi4qdKGyDD0GrA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221a6aea-71cf-4e5f-91c1-08d8efe32cf8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:10:26.6436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi6J4BBKjiKl8UzwyISKg8gZk+MUJhdniLCTo/IRxtvXcP6McP6s5tqQOa21ZuJiNqgFdJcycWlv10ii4ejH9I4g3t+ykZSWbXEpxEhLJdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2853
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
X-Proofpoint-ORIG-GUID: dnxdYPMyScT_rAeFICldTrJex07kmz5i
X-Proofpoint-GUID: dnxdYPMyScT_rAeFICldTrJex07kmz5i
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
Message-ID-Hash: RLYMEZISISZKZ7MVYOFIK7XROX4KRAE7
X-Message-ID-Hash: RLYMEZISISZKZ7MVYOFIK7XROX4KRAE7
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RLYMEZISISZKZ7MVYOFIK7XROX4KRAE7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Much like hugetlbfs or THPs, treat device pagemaps with
compound pages like the rest of GUP handling of compound pages.

Rather than incrementing the refcount every 4K, we record
all sub pages and increment by @refs amount *once*.

Performance measured by gup_benchmark improves considerably
get_user_pages_fast() and pin_user_pages_fast() with NVDIMMs:

 $ gup_test -f /dev/dax1.0 -m 16384 -r 10 -S [-u,-a] -n 512 -w
(get_user_pages_fast 2M pages) ~59 ms -> ~6.1 ms
(pin_user_pages_fast 2M pages) ~87 ms -> ~6.2 ms
[altmap]
(get_user_pages_fast 2M pages) ~494 ms -> ~9 ms
(pin_user_pages_fast 2M pages) ~494 ms -> ~10 ms

 $ gup_test -f /dev/dax1.0 -m 129022 -r 10 -S [-u,-a] -n 512 -w
(get_user_pages_fast 2M pages) ~492 ms -> ~49 ms
(pin_user_pages_fast 2M pages) ~493 ms -> ~50 ms
[altmap with -m 127004]
(get_user_pages_fast 2M pages) ~3.91 sec -> ~70 ms
(pin_user_pages_fast 2M pages) ~3.97 sec -> ~74 ms

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/gup.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b3e647c8b7ee..514f12157a0f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2159,31 +2159,54 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
+
+static int record_subpages(struct page *page, unsigned long addr,
+			   unsigned long end, struct page **pages)
+{
+	int nr;
+
+	for (nr = 0; addr != end; addr += PAGE_SIZE)
+		pages[nr++] = page++;
+
+	return nr;
+}
+
 #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
 static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 			     unsigned long end, unsigned int flags,
 			     struct page **pages, int *nr)
 {
-	int nr_start = *nr;
+	int refs, nr_start = *nr;
 	struct dev_pagemap *pgmap = NULL;
 
 	do {
-		struct page *page = pfn_to_page(pfn);
+		struct page *head, *page = pfn_to_page(pfn);
+		unsigned long next;
 
 		pgmap = get_dev_pagemap(pfn, pgmap);
 		if (unlikely(!pgmap)) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
 			return 0;
 		}
-		SetPageReferenced(page);
-		pages[*nr] = page;
-		if (unlikely(!try_grab_page(page, flags))) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
+
+		head = compound_head(page);
+		next = PageCompound(head) ? end : addr + PAGE_SIZE;
+		refs = record_subpages(page, addr, next, pages + *nr);
+
+		SetPageReferenced(head);
+		head = try_grab_compound_head(head, refs, flags);
+		if (!head) {
+			if (PageCompound(head)) {
+				ClearPageReferenced(head);
+				put_dev_pagemap(pgmap);
+			} else {
+				undo_dev_pagemap(nr, nr_start, flags, pages);
+			}
 			return 0;
 		}
-		(*nr)++;
-		pfn++;
-	} while (addr += PAGE_SIZE, addr != end);
+		*nr += refs;
+		pfn += refs;
+	} while (addr += (refs << PAGE_SHIFT), addr != end);
 
 	if (pgmap)
 		put_dev_pagemap(pgmap);
@@ -2243,17 +2266,6 @@ static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
 }
 #endif
 
-static int record_subpages(struct page *page, unsigned long addr,
-			   unsigned long end, struct page **pages)
-{
-	int nr;
-
-	for (nr = 0; addr != end; addr += PAGE_SIZE)
-		pages[nr++] = page++;
-
-	return nr;
-}
-
 #ifdef CONFIG_ARCH_HAS_HUGEPD
 static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 				      unsigned long sz)
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

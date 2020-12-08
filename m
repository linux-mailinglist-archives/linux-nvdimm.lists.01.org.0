Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE312D311F
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:32:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE5F2100EB838;
	Tue,  8 Dec 2020 09:32:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 92FD2100EB827
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:32:31 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HNtm1191619;
	Tue, 8 Dec 2020 17:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=D5qZqJl9pDTnQTyU+Z93dVba8Vn316JE/ksYxTiz9X0=;
 b=V1mXdGn4LGY79Syj73VzU+i1xF9fxXfqx6KCgHAvig/smz+i02wt5Eg0JRZzs5c8ma0A
 Gc3YKnF+4ktQwnI8vQJG0J6lx1JMykq9Aesw5dfr6d+cwSqfuSVvrAfza/O21rRdtIMr
 7odsDTXl80xC6500/95/h0DkmmPkZlP7OJSalJPWz/quEolmpA8JAaMsxBREX6Jhvzss
 sxOWqiKskjfEoPpbM3pDa7FiNktGr/pR+4tmPEr9/F0B0XtRUIGji1w4T1Lbxh+Bqw9I
 j+OoYO4FSlRmpfXVqdm1M/PHCW889TXllixIs3SI3MGvGtxte5S6CZ8v1IQ2IS6+eRHb SA==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 3581mqv09r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:32:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HOVrt195377;
	Tue, 8 Dec 2020 17:30:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 358m3y2f35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:30:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8HUJNO031431;
	Tue, 8 Dec 2020 17:30:19 GMT
Received: from paddy.uk.oracle.com (/10.175.194.215)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:30:19 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound pages
Date: Tue,  8 Dec 2020 17:28:52 +0000
Message-Id: <20201208172901.17384-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080107
Message-ID-Hash: SZ6LSQZHTONZLGV64R6IU4JSUQ7UJDZ2
X-Message-ID-Hash: SZ6LSQZHTONZLGV64R6IU4JSUQ7UJDZ2
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SZ6LSQZHTONZLGV64R6IU4JSUQ7UJDZ2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a new flag for struct dev_pagemap which designates that a a pagemap
is described as a set of compound pages or in other words, that how
pages are grouped together in the page tables are reflected in how we
describe struct pages. This means that rather than initializing
individual struct pages, we also initialize these struct pages, as
compound pages (on x86: 2M or 1G compound pages)

For certain ZONE_DEVICE users, like device-dax, which have a fixed page
size, this creates an opportunity to optimize GUP and GUP-fast walkers,
thus playing the same tricks as hugetlb pages.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/memremap.h | 2 ++
 mm/memremap.c            | 8 ++++++--
 mm/page_alloc.c          | 7 +++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 79c49e7f5c30..f8f26b2cc3da 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -90,6 +90,7 @@ struct dev_pagemap_ops {
 };
 
 #define PGMAP_ALTMAP_VALID	(1 << 0)
+#define PGMAP_COMPOUND		(1 << 1)
 
 /**
  * struct dev_pagemap - metadata for ZONE_DEVICE mappings
@@ -114,6 +115,7 @@ struct dev_pagemap {
 	struct completion done;
 	enum memory_type type;
 	unsigned int flags;
+	unsigned int align;
 	const struct dev_pagemap_ops *ops;
 	void *owner;
 	int nr_range;
diff --git a/mm/memremap.c b/mm/memremap.c
index 16b2fb482da1..287a24b7a65a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -277,8 +277,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
 				PHYS_PFN(range->start),
 				PHYS_PFN(range_len(range)), pgmap);
-	percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
-			- pfn_first(pgmap, range_id));
+	if (pgmap->flags & PGMAP_COMPOUND)
+		percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
+			- pfn_first(pgmap, range_id)) / PHYS_PFN(pgmap->align));
+	else
+		percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
+				- pfn_first(pgmap, range_id));
 	return 0;
 
 err_add_memory:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eaa227a479e4..9716ecd58e29 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6116,6 +6116,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
+	bool compound = pgmap->flags & PGMAP_COMPOUND;
+	unsigned int align = PHYS_PFN(pgmap->align);
 	unsigned long zone_idx = zone_idx(zone);
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
@@ -6171,6 +6173,11 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		}
 	}
 
+	if (compound) {
+		for (pfn = start_pfn; pfn < end_pfn; pfn += align)
+			prep_compound_page(pfn_to_page(pfn), order_base_2(align));
+	}
+
 	pr_info("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
 }
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

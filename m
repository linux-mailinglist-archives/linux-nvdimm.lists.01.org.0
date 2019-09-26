Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E0BF2E5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Sep 2019 14:26:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83AD921967BC5;
	Thu, 26 Sep 2019 05:28:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 094382010BCA0
 for <linux-nvdimm@lists.01.org>; Thu, 26 Sep 2019 05:28:23 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8QCN70R044775; Thu, 26 Sep 2019 08:26:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v8w54rnjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 08:26:03 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8QCOgDd051112;
 Thu, 26 Sep 2019 08:26:03 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v8w54rnjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 08:26:03 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8QCQ0k6003088;
 Thu, 26 Sep 2019 12:26:02 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02wdc.us.ibm.com with ESMTP id 2v5bg7exj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 12:26:02 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8QCQ1pe56754614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2019 12:26:01 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C2BF6E052;
 Thu, 26 Sep 2019 12:26:01 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 436FE6E04C;
 Thu, 26 Sep 2019 12:25:59 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.34.158])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 26 Sep 2019 12:25:58 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, akpm@linux-foundation.org,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 1/2] mm/memunmap: Use the correct start and end pfn when
 removing pages from zone
Date: Thu, 26 Sep 2019 17:55:51 +0530
Message-Id: <20190926122552.17905-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830091428.18399-1-david@redhat.com>
References: <20190830091428.18399-1-david@redhat.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-26_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260118
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-mm@kvack.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

With altmap, all the resource pfns are not initialized. While initializing
pfn, altmap reserve space is skipped. Hence when removing pfn from zone skip
pfns that were never initialized.

Update memunmap_pages to calculate start and end pfn based on altmap
values. This fixes a kernel crash that is observed when destroying namespace.

[   74.745056] BUG: Unable to handle kernel data access at 0xc00c000001400000
[   74.745256] Faulting instruction address: 0xc0000000000b58b0
cpu 0x2: Vector: 300 (Data Access) at [c00000026ea93580]
    pc: c0000000000b58b0: memset+0x68/0x104
    lr: c0000000003eb008: page_init_poison+0x38/0x50
    ...
  current = 0xc000000271c67d80
  paca    = 0xc00000003fffd680   irqmask: 0x03   irq_happened: 0x01
    pid   = 3665, comm = ndctl
[link register   ] c0000000003eb008 page_init_poison+0x38/0x50
[c00000026ea93830] c0000000004754d4 remove_pfn_range_from_zone+0x64/0x3e0
[c00000026ea938a0] c0000000004b8a60 memunmap_pages+0x300/0x400
[c00000026ea93930] c0000000009e32a0 devm_action_release+0x30/0x50
...

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memremap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 390bb3544589..76b98110031e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -113,7 +113,8 @@ static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
 void memunmap_pages(struct dev_pagemap *pgmap)
 {
 	struct resource *res = &pgmap->res;
-	unsigned long pfn = PHYS_PFN(res->start);
+	unsigned long start_pfn, end_pfn;
+	unsigned long pfn, nr_pages;
 	int nid;
 
 	dev_pagemap_kill(pgmap);
@@ -121,14 +122,18 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 		put_page(pfn_to_page(pfn));
 	dev_pagemap_cleanup(pgmap);
 
+	start_pfn = pfn_first(pgmap);
+	end_pfn = pfn_end(pgmap);
+	nr_pages = end_pfn - start_pfn;
+
 	/* pages are dead and unused, undo the arch mapping */
-	nid = page_to_nid(pfn_to_page(pfn));
+	nid = page_to_nid(pfn_to_page(start_pfn));
 
 	mem_hotplug_begin();
-	remove_pfn_range_from_zone(page_zone(pfn_to_page(pfn)), pfn,
-				   PHYS_PFN(resource_size(res)));
+	remove_pfn_range_from_zone(page_zone(pfn_to_page(start_pfn)),
+				   start_pfn, nr_pages);
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
-		__remove_pages(pfn, PHYS_PFN(resource_size(res)), NULL);
+		__remove_pages(start_pfn, nr_pages, NULL);
 	} else {
 		arch_remove_memory(nid, res->start, resource_size(res),
 				pgmap_altmap(pgmap));
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

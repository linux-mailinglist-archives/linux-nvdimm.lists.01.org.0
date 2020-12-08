Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8119A2D3116
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:30:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4FA34100EB82F;
	Tue,  8 Dec 2020 09:30:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E34E100EB825
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:30:52 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HNtFI191647;
	Tue, 8 Dec 2020 17:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=iIdjfPyCeZVdLs1aRy3eOjZbWDQIpPbiALVmzGStE1w=;
 b=whnak4zF2li/G2++F2OrxCP5NIZhbsOfoby48WhoGOPxpU0sRuKrFGp/3PkWC3SK2UHX
 3GgsDeeBvfz7dqU8N7gA3c9KIaN3yiulzt9UIdRndVOU9xKbCPG1Mb0fSIUrRgFe2Lz9
 /VX07NgbhaRuz+OWuofDHwb6FWqSFQcNgiG9tuuSR0I2JJrj2kGIEC+UebFjSa8+LHH5
 XLi7mdHNA4VZbFcX7x2ffC9t+okWRwRwoPsx54m8Wo7XwmfIWid8MF7uIyu5/7xyy6uG
 4lNgJoXbcl8aL65Ldgl8BlWOLqNxmVTLqqvfyv8NqhXhhBOlUYKfXIxL0GzWpD0SVrTo fw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 3581mqv012-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:30:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HOVUo195414;
	Tue, 8 Dec 2020 17:30:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 358m3y2fk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:30:44 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8HUiLM012477;
	Tue, 8 Dec 2020 17:30:44 GMT
Received: from paddy.uk.oracle.com (/10.175.194.215)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:30:43 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 8/9] RDMA/umem: batch page unpin in __ib_mem_release()
Date: Tue,  8 Dec 2020 17:29:00 +0000
Message-Id: <20201208172901.17384-10-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=3 mlxscore=0 mlxlogscore=829
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxlogscore=842
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080107
Message-ID-Hash: 4XXVKAUWKNV3FSKSCFRQOESWS4RA2J3R
X-Message-ID-Hash: 4XXVKAUWKNV3FSKSCFRQOESWS4RA2J3R
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4XXVKAUWKNV3FSKSCFRQOESWS4RA2J3R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Take advantage of the newly added unpin_user_pages() batched
refcount update, by calculating a page array from an SGL
(same size as the one used in ib_mem_get()) and call
unpin_user_pages() with that.

unpin_user_pages() will check on consecutive pages that belong
to the same compound page set and batch the refcount update in
a single write.

Running a test program which calls mr reg/unreg on a 1G in size
and measures cost of both operations together (in a guest using rxe)
with device-dax and hugetlbfs:

Before:
159 rounds in 5.027 sec: 31617.923 usec / round (device-dax)
466 rounds in 5.009 sec: 10748.456 usec / round (hugetlbfs)

After:
 305 rounds in 5.010 sec: 16426.047 usec / round (device-dax)
1073 rounds in 5.004 sec: 4663.622 usec / round (hugetlbfs)

We also see similar improvements on a setup with pmem and RDMA hardware.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/infiniband/core/umem.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index e9fecbdf391b..493cfdcf7381 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -44,20 +44,40 @@
 
 #include "uverbs.h"
 
+#define PAGES_PER_LIST (PAGE_SIZE / sizeof(struct page *))
+
 static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
 {
+	bool make_dirty = umem->writable && dirty;
+	struct page **page_list = NULL;
 	struct sg_page_iter sg_iter;
+	unsigned long nr = 0;
 	struct page *page;
 
+	page_list = (struct page **) __get_free_page(GFP_KERNEL);
+
 	if (umem->nmap > 0)
 		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
 				DMA_BIDIRECTIONAL);
 
 	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
 		page = sg_page_iter_page(&sg_iter);
-		unpin_user_pages_dirty_lock(&page, 1, umem->writable && dirty);
+		if (page_list)
+			page_list[nr++] = page;
+
+		if (!page_list) {
+			unpin_user_pages_dirty_lock(&page, 1, make_dirty);
+		} else if (nr == PAGES_PER_LIST) {
+			unpin_user_pages_dirty_lock(page_list, nr, make_dirty);
+			nr = 0;
+		}
 	}
 
+	if (nr)
+		unpin_user_pages_dirty_lock(page_list, nr, make_dirty);
+
+	if (page_list)
+		free_page((unsigned long) page_list);
 	sg_free_table(&umem->sg_head);
 }
 
@@ -212,8 +232,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 		cond_resched();
 		ret = pin_user_pages_fast(cur_base,
 					  min_t(unsigned long, npages,
-						PAGE_SIZE /
-						sizeof(struct page *)),
+						PAGES_PER_LIST),
 					  gup_flags | FOLL_LONGTERM, page_list);
 		if (ret < 0)
 			goto umem_release;
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0630A2D3113
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:30:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB828100EB82F;
	Tue,  8 Dec 2020 09:30:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EF093100EB82B
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:30:46 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HNtKb191639;
	Tue, 8 Dec 2020 17:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=g6swsjDZvzJC7QAazYa+f++QasgrbynEkAanWwTCzP4=;
 b=G8frdM5XIvg9XNJYzwKy9DT8AVDtQLnRWPKHtTS1ysuB8J6wjUoZ48J6Ah6k2K08fCYN
 gayysIbwvSAGqQ+2rsmuUyvbcfD65SUtXoOveitYVRNSHxkzsQi2Kido21OcUpobyErC
 BkFrxaUds/KwXQUfH435n3AxCugDcn6NAO7bAynllz+8CIDrY8zg5rYN/cfhCw5paFhV
 Yh5LCbrwqB+9kZBZ/XqsDmLdl/qaWuXjzfKRqxZeeLh5xIRyJicrZAEdK/9bv4vgo4LB
 924C1ySZJbXDduABBaU9lMizWtDsya5BR6n44HWzrkGn7x9N8vfgGDuPJZlkmGUTVzI1 0Q==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 3581mqv00b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:30:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HPjfh032498;
	Tue, 8 Dec 2020 17:30:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 358m4y6ssv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:30:36 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B8HUZH2004555;
	Tue, 8 Dec 2020 17:30:35 GMT
Received: from paddy.uk.oracle.com (/10.175.194.215)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:30:34 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 5/9] device-dax: Compound pagemap support
Date: Tue,  8 Dec 2020 17:28:57 +0000
Message-Id: <20201208172901.17384-7-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080107
Message-ID-Hash: J5X5FCSJUULVGUS2IO3QDPNP6HYA7CG3
X-Message-ID-Hash: J5X5FCSJUULVGUS2IO3QDPNP6HYA7CG3
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J5X5FCSJUULVGUS2IO3QDPNP6HYA7CG3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

dax devices are created with a fixed @align (huge page size) which
is enforced through as well at mmap() of the device. Faults,
consequently happen too at the specified @align specified at the
creation, and those don't change through out dax device lifetime.
MCEs poisons a whole dax huge page, as well as splits occurring at
at the configured page size.

As such, use the newly added compound pagemap facility which onlines
the assigned dax ranges as compound pages. Currently, this means,
that region/namespace bootstrap would take considerably less, given
that you would initialize considerably less pages.

On emulated NVDIMM guests this can be easily seen, e.g. on a setup
with an emulated NVDIMM with 128G in size seeing improvements from ~750ms
to ~190ms with 2M pages, and to less than a 1msec with 1G pages.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
Probably deserves its own sysfs attribute for enabling PGMAP_COMPOUND?
---
 drivers/dax/device.c | 54 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 25e0b84a4296..9daec6e08efe 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -192,6 +192,39 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 }
 #endif /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
+static void set_page_mapping(struct vm_fault *vmf, pfn_t pfn,
+			     unsigned int fault_size,
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
+				 unsigned int fault_size,
+				 struct address_space *f_mapping)
+{
+	struct page *head;
+
+	head = pfn_to_page(pfn_t_to_pfn(pfn));
+	head->mapping = f_mapping;
+	head->index = linear_page_index(vmf->vma, vmf->address
+			& ~(fault_size - 1));
+}
+
 static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 		enum page_entry_size pe_size)
 {
@@ -225,8 +258,7 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 	}
 
 	if (rc == VM_FAULT_NOPAGE) {
-		unsigned long i;
-		pgoff_t pgoff;
+		struct dev_pagemap *pgmap = pfn_t_to_page(pfn)->pgmap;
 
 		/*
 		 * In the device-dax case the only possibility for a
@@ -234,17 +266,10 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
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
+		if (pgmap->flags & PGMAP_COMPOUND)
+			set_compound_mapping(vmf, pfn, fault_size, filp->f_mapping);
+		else
+			set_page_mapping(vmf, pfn, fault_size, filp->f_mapping);
 	}
 	dax_read_unlock(id);
 
@@ -426,6 +451,9 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 	}
 
 	pgmap->type = MEMORY_DEVICE_GENERIC;
+	pgmap->flags = PGMAP_COMPOUND;
+	pgmap->align = dev_dax->align;
+
 	addr = devm_memremap_pages(dev, pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

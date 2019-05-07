Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE09416E05
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 02:10:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F24F212449EE;
	Tue,  7 May 2019 17:09:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E976A211F9D7B
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 17:09:57 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 May 2019 17:09:57 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga002.jf.intel.com with ESMTP; 07 May 2019 17:09:57 -0700
Subject: [PATCH v2 2/6] mm/devm_memremap_pages: Introduce devm_memunmap_pages
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Tue, 07 May 2019 16:56:10 -0700
Message-ID: <155727337088.292046.5774214552136776763.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Use the new devm_relase_action() facility to allow
devm_memremap_pages_release() to be manually triggered.

Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memremap.h |    6 ++++++
 kernel/memremap.c        |    6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f0628660d541..7601ee314c4a 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -100,6 +100,7 @@ struct dev_pagemap {
 
 #ifdef CONFIG_ZONE_DEVICE
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
+void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		struct dev_pagemap *pgmap);
 
@@ -118,6 +119,11 @@ static inline void *devm_memremap_pages(struct device *dev,
 	return ERR_PTR(-ENXIO);
 }
 
+static inline void devm_memunmap_pages(struct device *dev,
+		struct dev_pagemap *pgmap)
+{
+}
+
 static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		struct dev_pagemap *pgmap)
 {
diff --git a/kernel/memremap.c b/kernel/memremap.c
index a856cb5ff192..65afbacab44e 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -266,6 +266,12 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 }
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
 
+void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap)
+{
+	devm_release_action(dev, devm_memremap_pages_release, pgmap);
+}
+EXPORT_SYMBOL_GPL(devm_memunmap_pages);
+
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
 {
 	/* number of pfns from base where pfn_to_page() is valid */

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

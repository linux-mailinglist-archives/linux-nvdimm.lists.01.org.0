Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E28915D1
	for <lists+linux-nvdimm@lfdr.de>; Sun, 18 Aug 2019 11:12:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4072620260CEF;
	Sun, 18 Aug 2019 02:14:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+0e271e77d026f8461fef+5838+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2C4CF2021D300
 for <linux-nvdimm@lists.01.org>; Sun, 18 Aug 2019 02:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XHUyB9CWr0UZbWKK6wZpfXFP3u0SKSAB4X0VpzLA/8I=; b=BNpweUzHFydimszWGKSQwsbUDL
 oVWgIkoTWERwtt2ERYmPL6f9bxxBQbkjmVVG6NLRdRnOp7Qus74ojQgbESKr15Seu8JmfkxYuAy24
 RUAC45FOvJK0427ygD1DrBnWk0/XxQj87cjOc/JFggtIlBwrdUQ6rFA+gieqQUeo/WtMIk64Kl6Zz
 GObVorRR+fb4/L2C2+3vImX2eN7ER6xQwtf6pfm5ppeQiiJU2CU4HniN/xfpcm964ksdwskQb/G+Y
 juUbIxEuMge7qw6GCxKGdjhqGJMuzxJcC12Y4/+fTjLdPvnrn9PbEAuh7jn5UBhXcNs2AK+h8ZzMl
 XC11bHeQ==;
Received: from [2001:4bb8:188:24ee:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hzHEu-0001Ew-Vw; Sun, 18 Aug 2019 09:12:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4/4] memremap: provide a not device managed memremap_pages
Date: Sun, 18 Aug 2019 11:05:57 +0200
Message-Id: <20190818090557.17853-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190818090557.17853-1-hch@lst.de>
References: <20190818090557.17853-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The kvmppc ultravisor code wants a device private memory pool that is
system wide and not attached to a device.  Instead of faking up one
provide a low-level memremap_pages for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/memremap.h |  2 +
 kernel/memremap.c        | 84 +++++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 8f0013e18e14..fb2a0bd826b9 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -123,6 +123,8 @@ static inline struct vmem_altmap *pgmap_altmap(struct dev_pagemap *pgmap)
 }
 
 #ifdef CONFIG_ZONE_DEVICE
+void *memremap_pages(struct dev_pagemap *pgmap, int nid);
+void memunmap_pages(struct dev_pagemap *pgmap);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 09a087ca30ff..77a77704eb28 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -96,9 +96,8 @@ static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
 	}
 }
 
-static void devm_memremap_pages_release(void *data)
+void memunmap_pages(struct dev_pagemap *pgmap)
 {
-	struct dev_pagemap *pgmap = data;
 	struct resource *res = &pgmap->res;
 	unsigned long pfn;
 	int nid;
@@ -128,6 +127,12 @@ static void devm_memremap_pages_release(void *data)
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
 	devmap_managed_enable_put();
 }
+EXPORT_SYMBOL_GPL(memunmap_pages);
+
+static void devm_memremap_pages_release(void *data)
+{
+	memunmap_pages(data);
+}
 
 static void dev_pagemap_percpu_release(struct percpu_ref *ref)
 {
@@ -137,27 +142,12 @@ static void dev_pagemap_percpu_release(struct percpu_ref *ref)
 	complete(&pgmap->done);
 }
 
-/**
- * devm_memremap_pages - remap and provide memmap backing for the given resource
- * @dev: hosting device for @res
- * @pgmap: pointer to a struct dev_pagemap
- *
- * Notes:
- * 1/ At a minimum the res and type members of @pgmap must be initialized
- *    by the caller before passing it to this function
- *
- * 2/ The altmap field may optionally be initialized, in which case
- *    PGMAP_ALTMAP_VALID must be set in pgmap->flags.
- *
- * 3/ The ref field may optionally be provided, in which pgmap->ref must be
- *    'live' on entry and will be killed and reaped at
- *    devm_memremap_pages_release() time, or if this routine fails.
- *
- * 4/ res is expected to be a host memory range that could feasibly be
- *    treated as a "System RAM" range, i.e. not a device mmio range, but
- *    this is not enforced.
+/*
+ * Not device managed version of dev_memremap_pages, undone by
+ * memunmap_pages().  Please use dev_memremap_pages if you have a struct
+ * device available.
  */
-void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
+void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 {
 	struct resource *res = &pgmap->res;
 	struct dev_pagemap *conflict_pgmap;
@@ -168,7 +158,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		.altmap = pgmap_altmap(pgmap),
 	};
 	pgprot_t pgprot = PAGE_KERNEL;
-	int error, nid, is_ram;
+	int error, is_ram;
 	bool need_devmap_managed = true;
 
 	switch (pgmap->type) {
@@ -223,7 +213,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 
 	conflict_pgmap = get_dev_pagemap(PHYS_PFN(res->start), NULL);
 	if (conflict_pgmap) {
-		dev_WARN(dev, "Conflicting mapping in same section\n");
+		WARN(1, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
 		error = -ENOMEM;
 		goto err_array;
@@ -231,7 +221,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 
 	conflict_pgmap = get_dev_pagemap(PHYS_PFN(res->end), NULL);
 	if (conflict_pgmap) {
-		dev_WARN(dev, "Conflicting mapping in same section\n");
+		WARN(1, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
 		error = -ENOMEM;
 		goto err_array;
@@ -252,7 +242,6 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	if (error)
 		goto err_array;
 
-	nid = dev_to_node(dev);
 	if (nid < 0)
 		nid = numa_mem_id();
 
@@ -308,12 +297,6 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 				PHYS_PFN(res->start),
 				PHYS_PFN(resource_size(res)), pgmap);
 	percpu_ref_get_many(pgmap->ref, pfn_end(pgmap) - pfn_first(pgmap));
-
-	error = devm_add_action_or_reset(dev, devm_memremap_pages_release,
-			pgmap);
-	if (error)
-		return ERR_PTR(error);
-
 	return __va(res->start);
 
  err_add_memory:
@@ -328,6 +311,43 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	devmap_managed_enable_put();
 	return ERR_PTR(error);
 }
+EXPORT_SYMBOL_GPL(memremap_pages);
+
+/**
+ * devm_memremap_pages - remap and provide memmap backing for the given resource
+ * @dev: hosting device for @res
+ * @pgmap: pointer to a struct dev_pagemap
+ *
+ * Notes:
+ * 1/ At a minimum the res and type members of @pgmap must be initialized
+ *    by the caller before passing it to this function
+ *
+ * 2/ The altmap field may optionally be initialized, in which case
+ *    PGMAP_ALTMAP_VALID must be set in pgmap->flags.
+ *
+ * 3/ The ref field may optionally be provided, in which pgmap->ref must be
+ *    'live' on entry and will be killed and reaped at
+ *    devm_memremap_pages_release() time, or if this routine fails.
+ *
+ * 4/ res is expected to be a host memory range that could feasibly be
+ *    treated as a "System RAM" range, i.e. not a device mmio range, but
+ *    this is not enforced.
+ */
+void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
+{
+	int error;
+	void *ret;
+
+	ret = memremap_pages(pgmap, dev_to_node(dev));
+	if (IS_ERR(ret))
+		return ret;
+
+	error = devm_add_action_or_reset(dev, devm_memremap_pages_release,
+			pgmap);
+	if (error)
+		return ERR_PTR(error);
+	return ret;
+}
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
 
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap)
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

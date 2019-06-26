Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7732568E6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 14:28:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D312212AAB93;
	Wed, 26 Jun 2019 05:28:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+ab1f803c58217d155be4+5785+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8C228212AAB70
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9nJ/dQhFjQO4BwxUpP2mzPbE9YtD10wJjf4r3VQFN1A=; b=nXboAeYlCcF/zPpOPlIZvUmrzJ
 BTlirQHtzX2iEb6BKwv8oq08WeXcTesdjieof8gl0uUgUWf5wEdBkuVebpF9RqaOiPevnhYkIEcS/
 pjaCaLjEHzt59FXX1qkUyQpExIuKbtyBv5IFulvM7w8K8rC84x4zezBXBYaW46dojoBmGnMVwjqUm
 nF8nfnPRrptXmw0i78mJw+0WcV0vVd9wCisBHxjXgkqM0ANgfmKVYJu2eVwWDcB7vrAgI1scU5arC
 9u78bHoi+wBhSxalLJDEDSdhTQj5G8zS5OswD85z75fNDbwF+X49HHWs6BF57YsOZsFjyLfoem3ay
 xQHtzn2Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hg71o-0001RJ-D7; Wed, 26 Jun 2019 12:27:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 11/25] memremap: lift the devmap_enable manipulation into
 devm_memremap_pages
Date: Wed, 26 Jun 2019 14:27:10 +0200
Message-Id: <20190626122724.13313-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626122724.13313-1-hch@lst.de>
References: <20190626122724.13313-1-hch@lst.de>
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
Cc: linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Just check if there is a ->page_free operation set and take care of the
static key enable, as well as the put using device managed resources.
Also check that a ->page_free is provided for the pgmaps types that
require it, and check for a valid type as well while we are at it.

Note that this also fixes the fact that hmm never called
dev_pagemap_put_ops and thus would leave the slow path enabled forever,
even after a device driver unload or disable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/pmem.c | 23 +++--------------
 include/linux/mm.h    | 10 --------
 kernel/memremap.c     | 59 +++++++++++++++++++++++++++----------------
 mm/hmm.c              |  2 --
 4 files changed, 41 insertions(+), 53 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 9dac48359353..48767171a4df 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -334,11 +334,6 @@ static void pmem_release_disk(void *__pmem)
 	put_disk(pmem->disk);
 }
 
-static void pmem_release_pgmap_ops(void *__pgmap)
-{
-	dev_pagemap_put_ops();
-}
-
 static void pmem_pagemap_page_free(struct page *page, void *data)
 {
 	wake_up_var(&page->_refcount);
@@ -350,16 +345,6 @@ static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 	.cleanup		= pmem_pagemap_cleanup,
 };
 
-static int setup_pagemap_fsdax(struct device *dev, struct dev_pagemap *pgmap)
-{
-	dev_pagemap_get_ops();
-	if (devm_add_action_or_reset(dev, pmem_release_pgmap_ops, pgmap))
-		return -ENOMEM;
-	pgmap->type = MEMORY_DEVICE_FS_DAX;
-	pgmap->ops = &fsdax_pagemap_ops;
-	return 0;
-}
-
 static int pmem_attach_disk(struct device *dev,
 		struct nd_namespace_common *ndns)
 {
@@ -415,8 +400,8 @@ static int pmem_attach_disk(struct device *dev,
 	pmem->pfn_flags = PFN_DEV;
 	pmem->pgmap.ref = &q->q_usage_counter;
 	if (is_nd_pfn(dev)) {
-		if (setup_pagemap_fsdax(dev, &pmem->pgmap))
-			return -ENOMEM;
+		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pfn_sb = nd_pfn->pfn_sb;
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
@@ -428,8 +413,8 @@ static int pmem_attach_disk(struct device *dev,
 	} else if (pmem_should_map_pages(dev)) {
 		memcpy(&pmem->pgmap.res, &nsio->res, sizeof(pmem->pgmap.res));
 		pmem->pgmap.altmap_valid = false;
-		if (setup_pagemap_fsdax(dev, &pmem->pgmap))
-			return -ENOMEM;
+		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
 		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6e4b9be08b13..aa3970291cdf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -932,8 +932,6 @@ static inline bool is_zone_device_page(const struct page *page)
 #endif
 
 #ifdef CONFIG_DEV_PAGEMAP_OPS
-void dev_pagemap_get_ops(void);
-void dev_pagemap_put_ops(void);
 void __put_devmap_managed_page(struct page *page);
 DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
 static inline bool put_devmap_managed_page(struct page *page)
@@ -973,14 +971,6 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 #endif /* CONFIG_PCI_P2PDMA */
 
 #else /* CONFIG_DEV_PAGEMAP_OPS */
-static inline void dev_pagemap_get_ops(void)
-{
-}
-
-static inline void dev_pagemap_put_ops(void)
-{
-}
-
 static inline bool put_devmap_managed_page(struct page *page)
 {
 	return false;
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 00c1ceb60c19..3219a4c91d07 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -17,6 +17,35 @@ static DEFINE_XARRAY(pgmap_array);
 #define SECTION_MASK ~((1UL << PA_SECTION_SHIFT) - 1)
 #define SECTION_SIZE (1UL << PA_SECTION_SHIFT)
 
+#ifdef CONFIG_DEV_PAGEMAP_OPS
+DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
+EXPORT_SYMBOL(devmap_managed_key);
+static atomic_t devmap_managed_enable;
+
+static void devmap_managed_enable_put(void *data)
+{
+	if (atomic_dec_and_test(&devmap_managed_enable))
+		static_branch_disable(&devmap_managed_key);
+}
+
+static int devmap_managed_enable_get(struct device *dev, struct dev_pagemap *pgmap)
+{
+	if (!pgmap->ops->page_free) {
+		WARN(1, "Missing page_free method\n");
+		return -EINVAL;
+	}
+
+	if (atomic_inc_return(&devmap_managed_enable) == 1)
+		static_branch_enable(&devmap_managed_key);
+	return devm_add_action_or_reset(dev, devmap_managed_enable_put, NULL);
+}
+#else
+static int devmap_managed_enable_get(struct device *dev, struct dev_pagemap *pgmap)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_DEV_PAGEMAP_OPS */
+
 #if IS_ENABLED(CONFIG_DEVICE_PRIVATE)
 vm_fault_t device_private_entry_fault(struct vm_area_struct *vma,
 		       unsigned long addr,
@@ -156,6 +185,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	};
 	pgprot_t pgprot = PAGE_KERNEL;
 	int error, nid, is_ram;
+	bool need_devmap_managed = true;
 
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
@@ -173,6 +203,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		break;
 	case MEMORY_DEVICE_DEVDAX:
 	case MEMORY_DEVICE_PCI_P2PDMA:
+		need_devmap_managed = false;
 		break;
 	default:
 		WARN(1, "Invalid pgmap type %d\n", pgmap->type);
@@ -185,6 +216,12 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (need_devmap_managed) {
+		error = devmap_managed_enable_get(dev, pgmap);
+		if (error)
+			return ERR_PTR(error);
+	}
+
 	align_start = res->start & ~(SECTION_SIZE - 1);
 	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
 		- align_start;
@@ -351,28 +388,6 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 #ifdef CONFIG_DEV_PAGEMAP_OPS
-DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
-EXPORT_SYMBOL(devmap_managed_key);
-static atomic_t devmap_enable;
-
-/*
- * Toggle the static key for ->page_free() callbacks when dev_pagemap
- * pages go idle.
- */
-void dev_pagemap_get_ops(void)
-{
-	if (atomic_inc_return(&devmap_enable) == 1)
-		static_branch_enable(&devmap_managed_key);
-}
-EXPORT_SYMBOL_GPL(dev_pagemap_get_ops);
-
-void dev_pagemap_put_ops(void)
-{
-	if (atomic_dec_and_test(&devmap_enable))
-		static_branch_disable(&devmap_managed_key);
-}
-EXPORT_SYMBOL_GPL(dev_pagemap_put_ops);
-
 void __put_devmap_managed_page(struct page *page)
 {
 	int count = page_ref_dec_return(page);
diff --git a/mm/hmm.c b/mm/hmm.c
index 987793fba923..5b0bd5f6a74f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1415,8 +1415,6 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 	void *result;
 	int ret;
 
-	dev_pagemap_get_ops();
-
 	devmem = devm_kzalloc(device, sizeof(*devmem), GFP_KERNEL);
 	if (!devmem)
 		return ERR_PTR(-ENOMEM);
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

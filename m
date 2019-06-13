Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB6B434CE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 11:43:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2FFE4212963FD;
	Thu, 13 Jun 2019 02:43:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+aff2f865c54b6c032bcd+5772+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8D297212963ED
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TQXVBWfIqlzVbrygyo5vum+QYxG/VVv5jsBwO0qkppA=; b=UBMIjgc7UKwEGwdFQidbjqSnOO
 sl8tOdzK6YyD4G5gAX8Y9qW4ErlA2S5LnOv3V/cTwqC0ciDilPjy3GsKV03Ip5H8W0p60mg72Z76S
 BNG3rAkhsaOlVzZ0hl2D58ioxhQrK8e80vptGoxDjtbWc/kWObXljn2ZjiT5hDjKdJfBMLE0lS/kA
 GH4f//eF48WF9CLrrT6JCnPc7VdA0/lhANIMBoByo6LQ7zb7MVhXGcCBzCdrS1y1uEPmP4WCHNK2O
 K0g5+PIeHM2mBfTXBdNpnyokz5WzgqLPxYhtUm2Fhu7m57o8aArvGzHFb8zBFrfbuTbjsasXLEHwK
 rr6EJXyw==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hbMGr-0001mf-4O; Thu, 13 Jun 2019 09:43:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 07/22] memremap: move dev_pagemap callbacks into a separate
 structure
Date: Thu, 13 Jun 2019 11:43:10 +0200
Message-Id: <20190613094326.24093-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
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

The dev_pagemap is a growing too many callbacks.  Move them into a
separate ops structure so that they are not duplicated for multiple
instances, and an attacker can't easily overwrite them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/device.c              |  6 +++++-
 drivers/nvdimm/pmem.c             | 18 +++++++++++++-----
 drivers/pci/p2pdma.c              |  5 ++++-
 include/linux/memremap.h          | 29 +++++++++++++++--------------
 kernel/memremap.c                 | 12 ++++++------
 mm/hmm.c                          |  8 ++++++--
 tools/testing/nvdimm/test/iomap.c |  2 +-
 7 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 996d68ff992a..4adab774dade 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -443,6 +443,10 @@ static void dev_dax_kill(void *dev_dax)
 	kill_dev_dax(dev_dax);
 }
 
+static const struct dev_pagemap_ops dev_dax_pagemap_ops = {
+	.kill		= dev_dax_percpu_kill,
+};
+
 int dev_dax_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
@@ -471,7 +475,7 @@ int dev_dax_probe(struct device *dev)
 		return rc;
 
 	dev_dax->pgmap.ref = &dev_dax->ref;
-	dev_dax->pgmap.kill = dev_dax_percpu_kill;
+	dev_dax->pgmap.ops = &dev_dax_pagemap_ops;
 	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
 	if (IS_ERR(addr)) {
 		devm_remove_action(dev, dev_dax_percpu_exit, &dev_dax->ref);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index d9d845077b8b..4efbf184ea68 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -316,7 +316,7 @@ static void pmem_release_queue(void *q)
 	blk_cleanup_queue(q);
 }
 
-static void pmem_freeze_queue(struct percpu_ref *ref)
+static void pmem_kill(struct percpu_ref *ref)
 {
 	struct request_queue *q;
 
@@ -339,19 +339,27 @@ static void pmem_release_pgmap_ops(void *__pgmap)
 	dev_pagemap_put_ops();
 }
 
-static void fsdax_pagefree(struct page *page, void *data)
+static void pmem_fsdax_page_free(struct page *page, void *data)
 {
 	wake_up_var(&page->_refcount);
 }
 
+static const struct dev_pagemap_ops fsdax_pagemap_ops = {
+	.page_free		= pmem_fsdax_page_free,
+	.kill			= pmem_kill,
+};
+
+static const struct dev_pagemap_ops pmem_legacy_pagemap_ops = {
+	.kill			= pmem_kill,
+};
+
 static int setup_pagemap_fsdax(struct device *dev, struct dev_pagemap *pgmap)
 {
 	dev_pagemap_get_ops();
 	if (devm_add_action_or_reset(dev, pmem_release_pgmap_ops, pgmap))
 		return -ENOMEM;
 	pgmap->type = MEMORY_DEVICE_FS_DAX;
-	pgmap->page_free = fsdax_pagefree;
-
+	pgmap->ops = &fsdax_pagemap_ops;
 	return 0;
 }
 
@@ -412,7 +420,6 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->pfn_flags = PFN_DEV;
 	pmem->pgmap.ref = &q->q_usage_counter;
-	pmem->pgmap.kill = pmem_freeze_queue;
 	if (is_nd_pfn(dev)) {
 		if (setup_pagemap_fsdax(dev, &pmem->pgmap))
 			return -ENOMEM;
@@ -433,6 +440,7 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pfn_flags |= PFN_MAP;
 		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
 	} else {
+		pmem->pgmap.ops = &pmem_legacy_pagemap_ops;
 		addr = devm_memremap(dev, pmem->phys_addr,
 				pmem->size, ARCH_MEMREMAP_PMEM);
 		memcpy(&bb_res, &nsio->res, sizeof(bb_res));
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 742928d0053e..6e76380f5b97 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -150,6 +150,10 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	return error;
 }
 
+static const struct dev_pagemap_ops pci_p2pdma_pagemap_ops = {
+	.kill		= pci_p2pdma_percpu_kill,
+};
+
 /**
  * pci_p2pdma_add_resource - add memory for use as p2p memory
  * @pdev: the device to add the memory to
@@ -196,7 +200,6 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
 	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
 		pci_resource_start(pdev, bar);
-	pgmap->kill = pci_p2pdma_percpu_kill;
 
 	addr = devm_memremap_pages(&pdev->dev, pgmap);
 	if (IS_ERR(addr)) {
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f0628660d541..5f7f40875b35 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -63,39 +63,40 @@ enum memory_type {
 	MEMORY_DEVICE_PCI_P2PDMA,
 };
 
-/*
- * Additional notes about MEMORY_DEVICE_PRIVATE may be found in
- * include/linux/hmm.h and Documentation/vm/hmm.rst. There is also a brief
- * explanation in include/linux/memory_hotplug.h.
- *
- * The page_free() callback is called once the page refcount reaches 1
- * (ZONE_DEVICE pages never reach 0 refcount unless there is a refcount bug.
- * This allows the device driver to implement its own memory management.)
- */
-typedef void (*dev_page_free_t)(struct page *page, void *data);
+struct dev_pagemap_ops {
+	/*
+	 * Called once the page refcount reaches 1.  (ZONE_DEVICE pages never
+	 * reach 0 refcount unless there is a refcount bug. This allows the
+	 * device driver to implement its own memory management.)
+	 */
+	void (*page_free)(struct page *page, void *data);
+
+	/*
+	 * Transition the percpu_ref in struct dev_pagemap to the dead state.
+	 */
+	void (*kill)(struct percpu_ref *ref);
+};
 
 /**
  * struct dev_pagemap - metadata for ZONE_DEVICE mappings
- * @page_free: free page callback when page refcount reaches 1
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
  * @res: physical address range covered by @ref
  * @ref: reference count that pins the devm_memremap_pages() mapping
- * @kill: callback to transition @ref to the dead state
  * @dev: host device of the mapping for debug
  * @data: private data pointer for page_free()
  * @type: memory type: see MEMORY_* in memory_hotplug.h
+ * @ops: method table
  */
 struct dev_pagemap {
-	dev_page_free_t page_free;
 	struct vmem_altmap altmap;
 	bool altmap_valid;
 	struct resource res;
 	struct percpu_ref *ref;
-	void (*kill)(struct percpu_ref *ref);
 	struct device *dev;
 	void *data;
 	enum memory_type type;
 	u64 pci_p2pdma_bus_offset;
+	const struct dev_pagemap_ops *ops;
 };
 
 #ifdef CONFIG_ZONE_DEVICE
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 1490e63f69a9..e23286ce0ec4 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -92,7 +92,7 @@ static void devm_memremap_pages_release(void *data)
 	unsigned long pfn;
 	int nid;
 
-	pgmap->kill(pgmap->ref);
+	pgmap->ops->kill(pgmap->ref);
 	for_each_device_pfn(pfn, pgmap)
 		put_page(pfn_to_page(pfn));
 
@@ -127,8 +127,8 @@ static void devm_memremap_pages_release(void *data)
  * @pgmap: pointer to a struct dev_pagemap
  *
  * Notes:
- * 1/ At a minimum the res, ref and type members of @pgmap must be initialized
- *    by the caller before passing it to this function
+ * 1/ At a minimum the res, ref and type and ops members of @pgmap must be
+ *    initialized by the caller before passing it to this function
  *
  * 2/ The altmap field may optionally be initialized, in which case altmap_valid
  *    must be set to true
@@ -156,7 +156,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	pgprot_t pgprot = PAGE_KERNEL;
 	int error, nid, is_ram;
 
-	if (!pgmap->ref || !pgmap->kill)
+	if (!pgmap->ref || !pgmap->ops || !pgmap->ops->kill)
 		return ERR_PTR(-EINVAL);
 
 	align_start = res->start & ~(SECTION_SIZE - 1);
@@ -266,7 +266,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
  err_pfn_remap:
 	pgmap_array_delete(res);
  err_array:
-	pgmap->kill(pgmap->ref);
+	pgmap->ops->kill(pgmap->ref);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
@@ -353,7 +353,7 @@ void __put_devmap_managed_page(struct page *page)
 
 		mem_cgroup_uncharge(page);
 
-		page->pgmap->page_free(page, page->pgmap->data);
+		page->pgmap->ops->page_free(page, page->pgmap->data);
 	} else if (!count)
 		__put_page(page);
 }
diff --git a/mm/hmm.c b/mm/hmm.c
index 13a16faf0a77..2501ac6045d0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1348,6 +1348,11 @@ static void hmm_devmem_free(struct page *page, void *data)
 	devmem->ops->free(devmem, page);
 }
 
+static const struct dev_pagemap_ops hmm_pagemap_ops = {
+	.page_free		= hmm_devmem_free,
+	.kill			= hmm_devmem_ref_kill,
+};
+
 /*
  * hmm_devmem_add() - hotplug ZONE_DEVICE memory for device memory
  *
@@ -1406,11 +1411,10 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 
 	devmem->pagemap.type = MEMORY_DEVICE_PRIVATE;
 	devmem->pagemap.res = *devmem->resource;
-	devmem->pagemap.page_free = hmm_devmem_free;
+	devmem->pagemap.ops = &hmm_pagemap_ops;
 	devmem->pagemap.altmap_valid = false;
 	devmem->pagemap.ref = &devmem->ref;
 	devmem->pagemap.data = devmem;
-	devmem->pagemap.kill = hmm_devmem_ref_kill;
 
 	result = devm_memremap_pages(devmem->device, &devmem->pagemap);
 	if (IS_ERR(result))
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index c6635fee27d8..7f5ece9b5011 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -108,7 +108,7 @@ static void nfit_test_kill(void *_pgmap)
 {
 	struct dev_pagemap *pgmap = _pgmap;
 
-	pgmap->kill(pgmap->ref);
+	pgmap->ops->kill(pgmap->ref);
 }
 
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

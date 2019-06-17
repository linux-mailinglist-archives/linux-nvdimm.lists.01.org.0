Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E2F48216
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 14:28:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC60C2129DB99;
	Mon, 17 Jun 2019 05:28:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+a9ecd0bfb5b639be820a+5776+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 58F8921296B30
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7YtpHKyCpwh/jBnBJmxc0lcdvCMmZyq3FZMS/N8Gm6s=; b=WTYjqtZWDVPa1JoJT2LZGI83TG
 IRs4+NaNIEmp7EYCJWepGEdIrGAK30Qa0W3+f+sw2sPqTZuYZ+UM7HBbzX8/W1pQbd4yzdhwjyuQW
 uXvhM+BpRm7F1z1ytvBtf45PvnCfavUVPW4oIpHw3nzlf7jWvPgOxJIx1fLD03x0B5dBuBjtKLazj
 iJV8qt6qHJNno7vhSqOLtNiL9zFMGnXSsdrQ/xmJr7LtKYk1d2aLhR5JvzFWfzTV9h8Qvuu7KiKd3
 3kb1DFVgXK3pdpIQVOgLxC7/An2SE4CCqT/20AAFOO/q4YjuwTv/Gs6O/ZvCSOJy1uLwmFsRbNh2e
 PzK0M9+Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hcqjr-00007j-7B; Mon, 17 Jun 2019 12:27:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 08/25] memremap: move dev_pagemap callbacks into a separate
 structure
Date: Mon, 17 Jun 2019 14:27:16 +0200
Message-Id: <20190617122733.22432-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617122733.22432-1-hch@lst.de>
References: <20190617122733.22432-1-hch@lst.de>
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/dax/device.c              | 11 ++++++----
 drivers/dax/pmem/core.c           |  2 +-
 drivers/nvdimm/pmem.c             | 19 +++++++++-------
 drivers/pci/p2pdma.c              |  9 +++++---
 include/linux/memremap.h          | 36 +++++++++++++++++--------------
 kernel/memremap.c                 | 18 ++++++++--------
 mm/hmm.c                          | 10 ++++++---
 tools/testing/nvdimm/test/iomap.c |  9 ++++----
 8 files changed, 65 insertions(+), 49 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 8465d12fecba..cd483050a775 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -36,9 +36,8 @@ static void dev_dax_percpu_exit(struct percpu_ref *ref)
 	percpu_ref_exit(ref);
 }
 
-static void dev_dax_percpu_kill(struct percpu_ref *data)
+static void dev_dax_percpu_kill(struct percpu_ref *ref)
 {
-	struct percpu_ref *ref = data;
 	struct dev_dax *dev_dax = ref_to_dev_dax(ref);
 
 	dev_dbg(&dev_dax->dev, "%s\n", __func__);
@@ -442,6 +441,11 @@ static void dev_dax_kill(void *dev_dax)
 	kill_dev_dax(dev_dax);
 }
 
+static const struct dev_pagemap_ops dev_dax_pagemap_ops = {
+	.kill		= dev_dax_percpu_kill,
+	.cleanup	= dev_dax_percpu_exit,
+};
+
 int dev_dax_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
@@ -466,8 +470,7 @@ int dev_dax_probe(struct device *dev)
 		return rc;
 
 	dev_dax->pgmap.ref = &dev_dax->ref;
-	dev_dax->pgmap.kill = dev_dax_percpu_kill;
-	dev_dax->pgmap.cleanup = dev_dax_percpu_exit;
+	dev_dax->pgmap.ops = &dev_dax_pagemap_ops;
 	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index f9f51786d556..6eb6dfdf19bf 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -16,7 +16,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	struct dev_dax *dev_dax;
 	struct nd_namespace_io *nsio;
 	struct dax_region *dax_region;
-	struct dev_pagemap pgmap = { 0 };
+	struct dev_pagemap pgmap = { };
 	struct nd_namespace_common *ndns;
 	struct nd_dax *nd_dax = to_nd_dax(dev);
 	struct nd_pfn *nd_pfn = &nd_dax->nd_pfn;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index c4f5a808b9da..1a9986dc4dc6 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -311,7 +311,7 @@ static const struct attribute_group *pmem_attribute_groups[] = {
 	NULL,
 };
 
-static void __pmem_release_queue(struct percpu_ref *ref)
+static void pmem_pagemap_cleanup(struct percpu_ref *ref)
 {
 	struct request_queue *q;
 
@@ -321,10 +321,10 @@ static void __pmem_release_queue(struct percpu_ref *ref)
 
 static void pmem_release_queue(void *ref)
 {
-	__pmem_release_queue(ref);
+	pmem_pagemap_cleanup(ref);
 }
 
-static void pmem_freeze_queue(struct percpu_ref *ref)
+static void pmem_pagemap_kill(struct percpu_ref *ref)
 {
 	struct request_queue *q;
 
@@ -347,19 +347,24 @@ static void pmem_release_pgmap_ops(void *__pgmap)
 	dev_pagemap_put_ops();
 }
 
-static void fsdax_pagefree(struct page *page, void *data)
+static void pmem_pagemap_page_free(struct page *page, void *data)
 {
 	wake_up_var(&page->_refcount);
 }
 
+static const struct dev_pagemap_ops fsdax_pagemap_ops = {
+	.page_free		= pmem_pagemap_page_free,
+	.kill			= pmem_pagemap_kill,
+	.cleanup		= pmem_pagemap_cleanup,
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
 
@@ -417,8 +422,6 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->pfn_flags = PFN_DEV;
 	pmem->pgmap.ref = &q->q_usage_counter;
-	pmem->pgmap.kill = pmem_freeze_queue;
-	pmem->pgmap.cleanup = __pmem_release_queue;
 	if (is_nd_pfn(dev)) {
 		if (setup_pagemap_fsdax(dev, &pmem->pgmap))
 			return -ENOMEM;
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index a98126ad9c3a..e083567d26ef 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -100,7 +100,7 @@ static void pci_p2pdma_percpu_cleanup(struct percpu_ref *ref)
 	struct p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(ref);
 
 	wait_for_completion(&p2p_pgmap->ref_done);
-	percpu_ref_exit(&p2p_pgmap->ref);
+	percpu_ref_exit(ref);
 }
 
 static void pci_p2pdma_release(void *data)
@@ -152,6 +152,11 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	return error;
 }
 
+static const struct dev_pagemap_ops pci_p2pdma_pagemap_ops = {
+	.kill		= pci_p2pdma_percpu_kill,
+	.cleanup	= pci_p2pdma_percpu_cleanup,
+};
+
 /**
  * pci_p2pdma_add_resource - add memory for use as p2p memory
  * @pdev: the device to add the memory to
@@ -207,8 +212,6 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
 	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
 		pci_resource_start(pdev, bar);
-	pgmap->kill = pci_p2pdma_percpu_kill;
-	pgmap->cleanup = pci_p2pdma_percpu_cleanup;
 
 	addr = devm_memremap_pages(&pdev->dev, pgmap);
 	if (IS_ERR(addr)) {
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 1732dea030b2..1cdcfd595770 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -63,41 +63,45 @@ enum memory_type {
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
+	 * Transition the refcount in struct dev_pagemap to the dead state.
+	 */
+	void (*kill)(struct percpu_ref *ref);
+
+	/*
+	 * Wait for refcount in struct dev_pagemap to be idle and reap it.
+	 */
+	void (*cleanup)(struct percpu_ref *ref);
+};
 
 /**
  * struct dev_pagemap - metadata for ZONE_DEVICE mappings
- * @page_free: free page callback when page refcount reaches 1
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
  * @res: physical address range covered by @ref
  * @ref: reference count that pins the devm_memremap_pages() mapping
- * @kill: callback to transition @ref to the dead state
- * @cleanup: callback to wait for @ref to be idle and reap it
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
-	void (*cleanup)(struct percpu_ref *ref);
 	struct device *dev;
 	void *data;
 	enum memory_type type;
 	u64 pci_p2pdma_bus_offset;
+	const struct dev_pagemap_ops *ops;
 };
 
 #ifdef CONFIG_ZONE_DEVICE
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 6a2dd31a6250..85635ff57e04 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -92,10 +92,10 @@ static void devm_memremap_pages_release(void *data)
 	unsigned long pfn;
 	int nid;
 
-	pgmap->kill(pgmap->ref);
+	pgmap->ops->kill(pgmap->ref);
 	for_each_device_pfn(pfn, pgmap)
 		put_page(pfn_to_page(pfn));
-	pgmap->cleanup(pgmap->ref);
+	pgmap->ops->cleanup(pgmap->ref);
 
 	/* pages are dead and unused, undo the arch mapping */
 	align_start = res->start & ~(SECTION_SIZE - 1);
@@ -128,8 +128,8 @@ static void devm_memremap_pages_release(void *data)
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
@@ -184,7 +184,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		break;
 	}
 
-	if (!pgmap->ref || !pgmap->kill || !pgmap->cleanup) {
+	if (!pgmap->ref || !pgmap->ops || !pgmap->ops->kill ||
+	    !pgmap->ops->cleanup) {
 		WARN(1, "Missing reference count teardown definition\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -298,9 +299,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
  err_pfn_remap:
 	pgmap_array_delete(res);
  err_array:
-	pgmap->kill(pgmap->ref);
-	pgmap->cleanup(pgmap->ref);
-
+	pgmap->ops->kill(pgmap->ref);
+	pgmap->ops->cleanup(pgmap->ref);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
@@ -393,7 +393,7 @@ void __put_devmap_managed_page(struct page *page)
 
 		mem_cgroup_uncharge(page);
 
-		page->pgmap->page_free(page, page->pgmap->data);
+		page->pgmap->ops->page_free(page, page->pgmap->data);
 	} else if (!count)
 		__put_page(page);
 }
diff --git a/mm/hmm.c b/mm/hmm.c
index 172d695dcb8b..694e53bc55f4 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1381,6 +1381,12 @@ static void hmm_devmem_free(struct page *page, void *data)
 	devmem->ops->free(devmem, page);
 }
 
+static const struct dev_pagemap_ops hmm_pagemap_ops = {
+	.page_free		= hmm_devmem_free,
+	.kill			= hmm_devmem_ref_kill,
+	.cleanup		= hmm_devmem_ref_exit,
+};
+
 /*
  * hmm_devmem_add() - hotplug ZONE_DEVICE memory for device memory
  *
@@ -1435,12 +1441,10 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 
 	devmem->pagemap.type = MEMORY_DEVICE_PRIVATE;
 	devmem->pagemap.res = *devmem->resource;
-	devmem->pagemap.page_free = hmm_devmem_free;
+	devmem->pagemap.ops = &hmm_pagemap_ops;
 	devmem->pagemap.altmap_valid = false;
 	devmem->pagemap.ref = &devmem->ref;
 	devmem->pagemap.data = devmem;
-	devmem->pagemap.kill = hmm_devmem_ref_kill;
-	devmem->pagemap.cleanup = hmm_devmem_ref_exit;
 
 	result = devm_memremap_pages(devmem->device, &devmem->pagemap);
 	if (IS_ERR(result))
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index 219dd0a1cb08..a667d974155e 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -106,11 +106,10 @@ EXPORT_SYMBOL(__wrap_devm_memremap);
 
 static void nfit_test_kill(void *_pgmap)
 {
-	struct dev_pagemap *pgmap = _pgmap;
-
-	WARN_ON(!pgmap || !pgmap->ref || !pgmap->kill || !pgmap->cleanup);
-	pgmap->kill(pgmap->ref);
-	pgmap->cleanup(pgmap->ref);
+	WARN_ON(!pgmap || !pgmap->ref || !pgmap->ops->kill ||
+		!pgmap->ops->cleanup);
+	pgmap->ops->kill(pgmap->ref);
+	pgmap->ops->cleanup(pgmap->ref);
 }
 
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

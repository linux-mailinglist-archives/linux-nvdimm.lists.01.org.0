Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 566484821F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 14:28:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 395AD2129DBAA;
	Mon, 17 Jun 2019 05:28:10 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id DD3702129DBA5
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 05:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CCDpYq0cfPU5A/VTH+xsLw5c5i/G2uDb/EZi5JVjZA8=; b=UAicujz/YVlKK+WKFtiONSPd4O
 BJKs+xmHpssspGq3McquTV8vbga/nq3/q1eYBDV/EH8jgE9LbrEuhITcWWrtX4KP6gedHj21lXM7L
 fzIbsm/SnlwB5scY8jKHVKMRjExJvc6f+ggr7aJhlVwN6hXtbnw63NYAfc9m0pXlk8SqqOqvuwn91
 oYdNf/bAVgS250D/KEXwGQLD+OIK8ngJNhKbAwHIwdznpPM3aCF9/hjhYag8FTwDYhgM5z8nMN0Hi
 BlsdruuEUAfUs3Ea4mKWmZ+OnZ3IAaE4JeL3zAlMq/tZkvynJuq+HxmOnhFK3av+Yv/7+kxYzEjYc
 bP3Y7R/w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hcqjz-0000Cf-UU; Mon, 17 Jun 2019 12:28:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 12/25] memremap: remove the data field in struct dev_pagemap
Date: Mon, 17 Jun 2019 14:27:20 +0200
Message-Id: <20190617122733.22432-13-hch@lst.de>
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

struct dev_pagemap is always embedded into a containing structure, so
there is no need to an additional private data field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/nvdimm/pmem.c    | 2 +-
 include/linux/memremap.h | 3 +--
 kernel/memremap.c        | 2 +-
 mm/hmm.c                 | 9 +++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 85364c59c607..1ff4b1c4c7c3 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -342,7 +342,7 @@ static void pmem_release_disk(void *__pmem)
 	put_disk(pmem->disk);
 }
 
-static void pmem_pagemap_page_free(struct page *page, void *data)
+static void pmem_pagemap_page_free(struct page *page)
 {
 	wake_up_var(&page->_refcount);
 }
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 72a8a1a9303b..036c637f0150 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -69,7 +69,7 @@ struct dev_pagemap_ops {
 	 * reach 0 refcount unless there is a refcount bug. This allows the
 	 * device driver to implement its own memory management.)
 	 */
-	void (*page_free)(struct page *page, void *data);
+	void (*page_free)(struct page *page);
 
 	/*
 	 * Transition the refcount in struct dev_pagemap to the dead state.
@@ -104,7 +104,6 @@ struct dev_pagemap {
 	struct resource res;
 	struct percpu_ref *ref;
 	struct device *dev;
-	void *data;
 	enum memory_type type;
 	u64 pci_p2pdma_bus_offset;
 	const struct dev_pagemap_ops *ops;
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 5245c25b10e3..9dd5ccdb1adb 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -379,7 +379,7 @@ void __put_devmap_managed_page(struct page *page)
 
 		mem_cgroup_uncharge(page);
 
-		page->pgmap->ops->page_free(page, page->pgmap->data);
+		page->pgmap->ops->page_free(page);
 	} else if (!count)
 		__put_page(page);
 }
diff --git a/mm/hmm.c b/mm/hmm.c
index 2e5642dc6b04..8a0e04bbeee6 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1365,15 +1365,17 @@ static void hmm_devmem_ref_kill(struct dev_pagemap *pgmap)
 
 static vm_fault_t hmm_devmem_migrate_to_ram(struct vm_fault *vmf)
 {
-	struct hmm_devmem *devmem = vmf->page->pgmap->data;
+	struct hmm_devmem *devmem =
+		container_of(vmf->page->pgmap, struct hmm_devmem, pagemap);
 
 	return devmem->ops->fault(devmem, vmf->vma, vmf->address, vmf->page,
 			vmf->flags, vmf->pmd);
 }
 
-static void hmm_devmem_free(struct page *page, void *data)
+static void hmm_devmem_free(struct page *page)
 {
-	struct hmm_devmem *devmem = data;
+	struct hmm_devmem *devmem =
+		container_of(page->pgmap, struct hmm_devmem, pagemap);
 
 	devmem->ops->free(devmem, page);
 }
@@ -1439,7 +1441,6 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 	devmem->pagemap.ops = &hmm_pagemap_ops;
 	devmem->pagemap.altmap_valid = false;
 	devmem->pagemap.ref = &devmem->ref;
-	devmem->pagemap.data = devmem;
 
 	result = devm_memremap_pages(devmem->device, &devmem->pagemap);
 	if (IS_ERR(result))
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

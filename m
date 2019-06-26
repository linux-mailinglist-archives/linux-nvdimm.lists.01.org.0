Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D3568E9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 14:28:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EB703212AAB9A;
	Wed, 26 Jun 2019 05:28:07 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 5862D212AAB9F
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u3zsuvlhpuVlW2irmLMymipD93NE9PuZGgr9ihGk+cw=; b=d5qB8osfJqMohKxbGTFQMSvZ2L
 1KQRqOrBzZgw95hqR7pC5Tucj3aBgj0VNA4cifFq8mAtLKD0y1772q8m2Z/ML4g9MnP7VyGZXROYQ
 CGsjiwCerbX6BpeiN/MViA/hM/oV9hr2xUNh/hyDYSytiOYO4VuD3HQ99ONPGzpXSDohyUZvaf5+5
 tEP6Go2MhIcoBaHR6YQM6iXPbXRjeKNPZuAc5iukG7vmbCG+osMb+7klCclgJbFAUga+T2bDeuUhW
 MOLIB+v5w+TI2bA58t30lzk9E06TgqWSiqBPClXaFtnn8gsbsrA6lO0aCw7Xfkzg6beeIa6ehrRFz
 vyIO8/mQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hg71t-0001U5-Fd; Wed, 26 Jun 2019 12:28:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 13/25] memremap: remove the data field in struct dev_pagemap
Date: Wed, 26 Jun 2019 14:27:12 +0200
Message-Id: <20190626122724.13313-14-hch@lst.de>
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
index 48767171a4df..093408ce40ad 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -334,7 +334,7 @@ static void pmem_release_disk(void *__pmem)
 	put_disk(pmem->disk);
 }
 
-static void pmem_pagemap_page_free(struct page *page, void *data)
+static void pmem_pagemap_page_free(struct page *page)
 {
 	wake_up_var(&page->_refcount);
 }
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index ac985bd03a7f..336eca601dad 100644
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
index c06a5487dda7..6c3dbb692037 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -376,7 +376,7 @@ void __put_devmap_managed_page(struct page *page)
 
 		mem_cgroup_uncharge(page);
 
-		page->pgmap->ops->page_free(page, page->pgmap->data);
+		page->pgmap->ops->page_free(page);
 	} else if (!count)
 		__put_page(page);
 }
diff --git a/mm/hmm.c b/mm/hmm.c
index 96633ee066d8..36e25cdbdac1 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1368,15 +1368,17 @@ static void hmm_devmem_ref_kill(struct dev_pagemap *pgmap)
 
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
@@ -1442,7 +1444,6 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
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

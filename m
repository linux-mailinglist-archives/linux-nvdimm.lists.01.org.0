Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F423B48227
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 14:28:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AF7782129EB8E;
	Mon, 17 Jun 2019 05:28:18 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 2A2852129EB8C
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bqNW86dzEIGFtFX91S0QfixvDgbjQWnIT6qUU0eVEH4=; b=WuL0DYWbzTX1df3odeTY431W11
 U+IcQwoSHpIn1fMOzejiKLQ4T8swbios1PHMUkKcA2qDdFfDiObZfLsILw7OcEJxSkmTjZINPR6Ex
 JU5UL9obm/Ujq0gzLG5GLwV6DXCHwO9XcVhmV5JdSTTENkyBGpYwzs9vK4bZgbYpWH0X2uxeezDtb
 zTKdJMavLuTl530T4mh89YjZh7oD2lAFwjczLk5AV3FaKTfWD1grijdKZyC4ZIwEVCxgVy3oz5n7T
 RBeVOLMjWP1rN6VKNGoDkd/NFq1PppJFQffAUKysbEbgpOzqWo2a2uIJuDwVJADkhF56XaEwfYDf2
 sPXWKLLg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hcqk8-0000Gn-Ll; Mon, 17 Jun 2019 12:28:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 16/25] PCI/P2PDMA: use the dev_pagemap internal refcount
Date: Mon, 17 Jun 2019 14:27:24 +0200
Message-Id: <20190617122733.22432-17-hch@lst.de>
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

The functionality is identical to the one currently open coded in
p2pdma.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/p2pdma.c | 56 ++++----------------------------------------
 1 file changed, 4 insertions(+), 52 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 48a88158e46a..608f84df604a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -24,12 +24,6 @@ struct pci_p2pdma {
 	bool p2pmem_published;
 };
 
-struct p2pdma_pagemap {
-	struct dev_pagemap pgmap;
-	struct percpu_ref ref;
-	struct completion ref_done;
-};
-
 static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -78,32 +72,6 @@ static const struct attribute_group p2pmem_group = {
 	.name = "p2pmem",
 };
 
-static struct p2pdma_pagemap *to_p2p_pgmap(struct percpu_ref *ref)
-{
-	return container_of(ref, struct p2pdma_pagemap, ref);
-}
-
-static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
-{
-	struct p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(ref);
-
-	complete(&p2p_pgmap->ref_done);
-}
-
-static void pci_p2pdma_percpu_kill(struct dev_pagemap *pgmap)
-{
-	percpu_ref_kill(pgmap->ref);
-}
-
-static void pci_p2pdma_percpu_cleanup(struct dev_pagemap *pgmap)
-{
-	struct p2pdma_pagemap *p2p_pgmap =
-		container_of(pgmap, struct p2pdma_pagemap, pgmap);
-
-	wait_for_completion(&p2p_pgmap->ref_done);
-	percpu_ref_exit(&p2p_pgmap->ref);
-}
-
 static void pci_p2pdma_release(void *data)
 {
 	struct pci_dev *pdev = data;
@@ -153,11 +121,6 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	return error;
 }
 
-static const struct dev_pagemap_ops pci_p2pdma_pagemap_ops = {
-	.kill		= pci_p2pdma_percpu_kill,
-	.cleanup	= pci_p2pdma_percpu_cleanup,
-};
-
 /**
  * pci_p2pdma_add_resource - add memory for use as p2p memory
  * @pdev: the device to add the memory to
@@ -171,7 +134,6 @@ static const struct dev_pagemap_ops pci_p2pdma_pagemap_ops = {
 int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			    u64 offset)
 {
-	struct p2pdma_pagemap *p2p_pgmap;
 	struct dev_pagemap *pgmap;
 	void *addr;
 	int error;
@@ -194,22 +156,12 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			return error;
 	}
 
-	p2p_pgmap = devm_kzalloc(&pdev->dev, sizeof(*p2p_pgmap), GFP_KERNEL);
-	if (!p2p_pgmap)
+	pgmap = devm_kzalloc(&pdev->dev, sizeof(*pgmap), GFP_KERNEL);
+	if (!pgmap)
 		return -ENOMEM;
-
-	init_completion(&p2p_pgmap->ref_done);
-	error = percpu_ref_init(&p2p_pgmap->ref,
-			pci_p2pdma_percpu_release, 0, GFP_KERNEL);
-	if (error)
-		goto pgmap_free;
-
-	pgmap = &p2p_pgmap->pgmap;
-
 	pgmap->res.start = pci_resource_start(pdev, bar) + offset;
 	pgmap->res.end = pgmap->res.start + size - 1;
 	pgmap->res.flags = pci_resource_flags(pdev, bar);
-	pgmap->ref = &p2p_pgmap->ref;
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
 	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
 		pci_resource_start(pdev, bar);
@@ -223,7 +175,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	error = gen_pool_add_owner(pdev->p2pdma->pool, (unsigned long)addr,
 			pci_bus_address(pdev, bar) + offset,
 			resource_size(&pgmap->res), dev_to_node(&pdev->dev),
-			&p2p_pgmap->ref);
+			pgmap->ref);
 	if (error)
 		goto pages_free;
 
@@ -235,7 +187,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 pages_free:
 	devm_memunmap_pages(&pdev->dev, pgmap);
 pgmap_free:
-	devm_kfree(&pdev->dev, p2p_pgmap);
+	devm_kfree(&pdev->dev, pgmap);
 	return error;
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

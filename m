Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84EA48223
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 14:28:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E56E2129DB9A;
	Mon, 17 Jun 2019 05:28:13 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 27CF621296B01
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GlNxVMm8W4O5v065JMNFU6bkRl3AbEbXSnrBr8peAhc=; b=hceq9aC6tJ73idi0gys5khCNkb
 4oa/Hc09tP2sutmhvsQMCCgbZeQ65RgYiliHtKl5ES7k4PIx5QoJOmP158XuVwgiaDMwakShQWbmE
 2BQA9YBQorrWSgUr5kX4t9vAcPMRIvxeaD7vV44sRG6NUoWodLAfV48Htg6MQ2WO2MAtKlChRMtf5
 wCam1QxlrgXhMZA6F9p2gc2Ek7aGGPTwazLl9Df998k9Zp7cthixwUdhiZdLy/lL4lTfdFLHfTxA4
 MgbRgO934AqctA5SWdhgmmfrTW0+igprb3FsAQeA/tukrmljjK2fU4vyzRWkn67p8G3T2FPFSv6xF
 0pBQDtSw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hcqk4-0000Ep-9f; Mon, 17 Jun 2019 12:28:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 14/25] memremap: provide an optional internal refcount in
 struct dev_pagemap
Date: Mon, 17 Jun 2019 14:27:22 +0200
Message-Id: <20190617122733.22432-15-hch@lst.de>
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

Provide an internal refcounting logic if no ->ref field is provided
in the pagemap passed into devm_memremap_pages so that callers don't
have to reinvent it poorly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memremap.h          |  4 ++
 kernel/memremap.c                 | 64 ++++++++++++++++++++++++-------
 tools/testing/nvdimm/test/iomap.c | 17 ++++++--
 3 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 7289eb091b04..7e0f072ddce7 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -95,6 +95,8 @@ struct dev_pagemap_ops {
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
  * @res: physical address range covered by @ref
  * @ref: reference count that pins the devm_memremap_pages() mapping
+ * @internal_ref: internal reference if @ref is not provided by the caller
+ * @done: completion for @internal_ref
  * @dev: host device of the mapping for debug
  * @data: private data pointer for page_free()
  * @type: memory type: see MEMORY_* in memory_hotplug.h
@@ -105,6 +107,8 @@ struct dev_pagemap {
 	struct vmem_altmap altmap;
 	struct resource res;
 	struct percpu_ref *ref;
+	struct percpu_ref internal_ref;
+	struct completion done;
 	struct device *dev;
 	enum memory_type type;
 	unsigned int flags;
diff --git a/kernel/memremap.c b/kernel/memremap.c
index b41d98a64ebf..60693a1e8e92 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -29,7 +29,7 @@ static void dev_pagemap_put_ops(void *data)
 
 static int dev_pagemap_get_ops(struct device *dev, struct dev_pagemap *pgmap)
 {
-	if (!pgmap->ops->page_free) {
+	if (!pgmap->ops || !pgmap->ops->page_free) {
 		WARN(1, "Missing page_free method\n");
 		return -EINVAL;
 	}
@@ -75,6 +75,24 @@ static unsigned long pfn_next(unsigned long pfn)
 #define for_each_device_pfn(pfn, map) \
 	for (pfn = pfn_first(map); pfn < pfn_end(map); pfn = pfn_next(pfn))
 
+static void dev_pagemap_kill(struct dev_pagemap *pgmap)
+{
+	if (pgmap->ops && pgmap->ops->kill)
+		pgmap->ops->kill(pgmap);
+	else
+		percpu_ref_kill(pgmap->ref);
+}
+
+static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
+{
+	if (pgmap->ops && pgmap->ops->cleanup) {
+		pgmap->ops->cleanup(pgmap);
+	} else {
+		wait_for_completion(&pgmap->done);
+		percpu_ref_exit(pgmap->ref);
+	}
+}
+
 static void devm_memremap_pages_release(void *data)
 {
 	struct dev_pagemap *pgmap = data;
@@ -84,10 +102,10 @@ static void devm_memremap_pages_release(void *data)
 	unsigned long pfn;
 	int nid;
 
-	pgmap->ops->kill(pgmap);
+	dev_pagemap_kill(pgmap);
 	for_each_device_pfn(pfn, pgmap)
 		put_page(pfn_to_page(pfn));
-	pgmap->ops->cleanup(pgmap);
+	dev_pagemap_cleanup(pgmap);
 
 	/* pages are dead and unused, undo the arch mapping */
 	align_start = res->start & ~(SECTION_SIZE - 1);
@@ -114,20 +132,29 @@ static void devm_memremap_pages_release(void *data)
 		      "%s: failed to free all reserved pages\n", __func__);
 }
 
+static void dev_pagemap_percpu_release(struct percpu_ref *ref)
+{
+	struct dev_pagemap *pgmap =
+		container_of(ref, struct dev_pagemap, internal_ref);
+
+	complete(&pgmap->done);
+}
+
 /**
  * devm_memremap_pages - remap and provide memmap backing for the given resource
  * @dev: hosting device for @res
  * @pgmap: pointer to a struct dev_pagemap
  *
  * Notes:
- * 1/ At a minimum the res, ref and type and ops members of @pgmap must be
- *    initialized by the caller before passing it to this function
+ * 1/ At a minimum the res and type members of @pgmap must be initialized
+ *    by the caller before passing it to this function
  *
  * 2/ The altmap field may optionally be initialized, in which case
  *    PGMAP_ALTMAP_VALID must be set in pgmap->flags.
  *
- * 3/ pgmap->ref must be 'live' on entry and will be killed and reaped
- *    at devm_memremap_pages_release() time, or if this routine fails.
+ * 3/ The ref field may optionally be provided, in which pgmap->ref must be
+ *    'live' on entry and will be killed and reaped at
+ *    devm_memremap_pages_release() time, or if this routine fails.
  *
  * 4/ res is expected to be a host memory range that could feasibly be
  *    treated as a "System RAM" range, i.e. not a device mmio range, but
@@ -178,10 +205,21 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		break;
 	}
 
-	if (!pgmap->ref || !pgmap->ops || !pgmap->ops->kill ||
-	    !pgmap->ops->cleanup) {
-		WARN(1, "Missing reference count teardown definition\n");
-		return ERR_PTR(-EINVAL);
+	if (!pgmap->ref) {
+		if (pgmap->ops && (pgmap->ops->kill || pgmap->ops->cleanup))
+			return ERR_PTR(-EINVAL);
+
+		init_completion(&pgmap->done);
+		error = percpu_ref_init(&pgmap->internal_ref,
+				dev_pagemap_percpu_release, 0, GFP_KERNEL);
+		if (error)
+			return ERR_PTR(error);
+		pgmap->ref = &pgmap->internal_ref;
+	} else {
+		if (!pgmap->ops || !pgmap->ops->kill || !pgmap->ops->cleanup) {
+			WARN(1, "Missing reference count teardown definition\n");
+			return ERR_PTR(-EINVAL);
+		}
 	}
 
 	if (pgmap->type != MEMORY_DEVICE_PCI_P2PDMA) {
@@ -299,8 +337,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
  err_pfn_remap:
 	pgmap_array_delete(res);
  err_array:
-	pgmap->ops->kill(pgmap);
-	pgmap->ops->cleanup(pgmap);
+	dev_pagemap_kill(pgmap);
+	dev_pagemap_cleanup(pgmap);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index 3a1fa7735f47..8cd9b9873a7f 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -106,10 +106,19 @@ EXPORT_SYMBOL(__wrap_devm_memremap);
 
 static void nfit_test_kill(void *_pgmap)
 {
-	WARN_ON(!pgmap || !pgmap->ref || !pgmap->ops->kill ||
-		!pgmap->ops->cleanup);
-	pgmap->ops->kill(pgmap);
-	pgmap->ops->cleanup(pgmap);
+	WARN_ON(!pgmap || !pgmap->ref)
+
+	if (pgmap->ops && pgmap->ops->kill)
+		pgmap->ops->kill(pgmap);
+	else
+		percpu_ref_kill(pgmap->ref);
+
+	if (pgmap->ops && pgmap->ops->cleanup) {
+		pgmap->ops->cleanup(pgmap);
+	} else {
+		wait_for_completion(&pgmap->done);
+		percpu_ref_exit(pgmap->ref);
+	}
 }
 
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

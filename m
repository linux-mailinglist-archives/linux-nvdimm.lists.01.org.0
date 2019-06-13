Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 174FB434D8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 11:44:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3A71212963FB;
	Thu, 13 Jun 2019 02:44:08 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 821A021296070
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+F36Qtp9KNZlJRbFfbQN1eq8EHq+227/7sfzGGclHLw=; b=VblDbKsZb0RRpnPdAvevOdbtuG
 06yzYUmtWkiIPsoP1nmvo3AnrsDTuJovv6fNdum1MQwQKL25pb99SXJvc4gW0o62hlT7lLlTc/WjS
 K8qZKqiBN5WxofN6jGW7fAo3QUQf+dfuCfyvrfo4N272eB6mZoLfEfgv+BoGYRDNyl7Vb5xEuzWlM
 N6FMty3/n4xFBrIv2BT8kRH14dLL54XD4q2x0fsA6G1rQEvtBsX62S7CCnV4Mt/JdWcLV2XjWf64q
 xbmSBMtbYVIv7Cq/AJJH58RKU1ONXDRSyMYUcP30T1sQI1wMywIlngAo880SbnoVdXJORn4vkMSFl
 G7SCcZbA==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hbMH5-0001qr-IT; Thu, 13 Jun 2019 09:44:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 12/22] memremap: provide an optional internal refcount in
 struct dev_pagemap
Date: Thu, 13 Jun 2019 11:43:15 +0200
Message-Id: <20190613094326.24093-13-hch@lst.de>
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

Provide an internal refcounting logic if no ->ref field is provided
in the pagemap passed into devm_memremap_pages so that callers don't
have to reinvent it poorly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memremap.h          |  4 +++
 kernel/memremap.c                 | 60 ++++++++++++++++++++++++++-----
 tools/testing/nvdimm/test/iomap.c |  9 +++--
 3 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 75b80de6394a..b77ed00851ce 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -88,6 +88,8 @@ struct dev_pagemap_ops {
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
  * @res: physical address range covered by @ref
  * @ref: reference count that pins the devm_memremap_pages() mapping
+ * @internal_ref: internal reference if @ref is not provided by the caller
+ * @done: completion for @internal_ref
  * @dev: host device of the mapping for debug
  * @data: private data pointer for page_free()
  * @type: memory type: see MEMORY_* in memory_hotplug.h
@@ -98,6 +100,8 @@ struct dev_pagemap {
 	bool altmap_valid;
 	struct resource res;
 	struct percpu_ref *ref;
+	struct percpu_ref internal_ref;
+	struct completion done;
 	struct device *dev;
 	enum memory_type type;
 	u64 pci_p2pdma_bus_offset;
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 5c94ad4f5783..edca4389da68 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -83,6 +83,14 @@ static unsigned long pfn_next(unsigned long pfn)
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
 static void devm_memremap_pages_release(void *data)
 {
 	struct dev_pagemap *pgmap = data;
@@ -92,7 +100,8 @@ static void devm_memremap_pages_release(void *data)
 	unsigned long pfn;
 	int nid;
 
-	pgmap->ops->kill(pgmap);
+	dev_pagemap_kill(pgmap);
+
 	for_each_device_pfn(pfn, pgmap)
 		put_page(pfn_to_page(pfn));
 
@@ -121,20 +130,37 @@ static void devm_memremap_pages_release(void *data)
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
+static void dev_pagemap_percpu_exit(void *data)
+{
+	struct dev_pagemap *pgmap = data;
+
+	wait_for_completion(&pgmap->done);
+	percpu_ref_exit(pgmap->ref);
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
  * 2/ The altmap field may optionally be initialized, in which case altmap_valid
  *    must be set to true
  *
- * 3/ pgmap->ref must be 'live' on entry and will be killed at
- *    devm_memremap_pages_release() time, or if this routine fails.
+ * 3/ The ref field may optionally be provided, in which pgmap->ref must be
+ *    'live' on entry and will be killed at devm_memremap_pages_release() time,
+ *    or if this routine fails.
  *
  * 4/ res is expected to be a host memory range that could feasibly be
  *    treated as a "System RAM" range, i.e. not a device mmio range, but
@@ -156,10 +182,26 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	pgprot_t pgprot = PAGE_KERNEL;
 	int error, nid, is_ram;
 
-	if (!pgmap->ref || !pgmap->ops || !pgmap->ops->kill)
-		return ERR_PTR(-EINVAL);
+	if (!pgmap->ref) {
+		if (pgmap->ops && pgmap->ops->kill)
+			return ERR_PTR(-EINVAL);
+
+		init_completion(&pgmap->done);
+		error = percpu_ref_init(&pgmap->internal_ref,
+				dev_pagemap_percpu_release, 0, GFP_KERNEL);
+		if (error)
+			return ERR_PTR(error);
+		pgmap->ref = &pgmap->internal_ref;
+		error = devm_add_action_or_reset(dev, dev_pagemap_percpu_exit,
+				pgmap);
+		if (error)
+			return ERR_PTR(error);
+	} else {
+		if (!pgmap->ops || !pgmap->ops->kill)
+			return ERR_PTR(-EINVAL);
+	}
 
-	if (pgmap->ops->page_free) {
+	if (pgmap->ops && pgmap->ops->page_free) {
 		error = dev_pagemap_enable(dev);
 		if (error)
 			return ERR_PTR(error);
@@ -272,7 +314,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
  err_pfn_remap:
 	pgmap_array_delete(res);
  err_array:
-	pgmap->ops->kill(pgmap);
+	dev_pagemap_kill(pgmap);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index ee07c4de2b35..3d0e916f9fff 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -104,9 +104,14 @@ void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
 }
 EXPORT_SYMBOL(__wrap_devm_memremap);
 
-static void nfit_test_kill(void *pgmap)
+static void nfit_test_kill(void *data)
 {
-	pgmap->ops->kill(pgmap);
+	struct dev_pagemap *pgmap = data;
+
+	if (pgmap->ops && pgmap->ops->kill)
+		pgmap->ops->kill(pgmap);
+	else
+		percpu_ref_kill(pgmap->ref);
 }
 
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

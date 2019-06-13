Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E366D434E6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 11:44:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A6D3B21296070;
	Thu, 13 Jun 2019 02:44:28 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id C3098212963E0
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 02:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ST5vXDP0wxZAFs+13zRZ2VJKiKZc1CoEKVcbqRs6asg=; b=o60fvrdjva6GPXOY7bWBawc6ta
 0VTdlbWHmmpNA05wC2tx9zYyp5vxCSFXni3mwAYEo/JBfwXp+ip6D7QSxCyt6RsLm6bkCBG4evj7W
 uLJKEpwWIrv5wjFFQ+/vT588yk1NuNPnmFI/ifWHUX2+fx93ET4T0o8OjB+Ag5kwwEpG4PAAQ4evQ
 5Qmy0oIpRMwn7fkxXQK5/g1paPzm38DzgVl72fd1ZqQ/K8gUf1mi0G9Qv1PWHT0qLuF6X42bqPSGX
 It5fsP86hUBvvu/gab1CK5Bz5//1Jz5zbVZXS9iFZbny1chkNTg7sqFV9amTjjSAiH8zqxZoqFe7y
 bMa6st9A==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hbMHP-0001w6-RZ; Thu, 13 Jun 2019 09:44:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 19/22] mm: simplify ZONE_DEVICE page private data
Date: Thu, 13 Jun 2019 11:43:22 +0200
Message-Id: <20190613094326.24093-20-hch@lst.de>
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

Remove the clumsy hmm_devmem_page_{get,set}_drvdata helpers, and
instead just access the page directly.  Also make the page data
a void pointer, and thus much easier to use.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 18 +++++++----------
 include/linux/hmm.h                    | 27 --------------------------
 include/linux/mm_types.h               |  2 +-
 mm/page_alloc.c                        |  8 ++++----
 4 files changed, 12 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 9e32bc8ecbc7..27aa4e72abe9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -104,11 +104,8 @@ struct nouveau_migrate {
 
 static void nouveau_dmem_page_free(struct page *page)
 {
-	struct nouveau_dmem_chunk *chunk;
-	unsigned long idx;
-
-	chunk = (void *)hmm_devmem_page_get_drvdata(page);
-	idx = page_to_pfn(page) - chunk->pfn_first;
+	struct nouveau_dmem_chunk *chunk = page->zone_device_data;
+	unsigned long idx = page_to_pfn(page) - chunk->pfn_first;
 
 	/*
 	 * FIXME:
@@ -200,7 +197,7 @@ nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
 
 		dst_addr = fault->dma[fault->npages++];
 
-		chunk = (void *)hmm_devmem_page_get_drvdata(spage);
+		chunk = spage->zone_device_data;
 		src_addr = page_to_pfn(spage) - chunk->pfn_first;
 		src_addr = (src_addr << PAGE_SHIFT) + chunk->bo->bo.offset;
 
@@ -633,9 +630,8 @@ nouveau_dmem_init(struct nouveau_drm *drm)
 		list_add_tail(&chunk->list, &drm->dmem->chunk_empty);
 
 		page = pfn_to_page(chunk->pfn_first);
-		for (j = 0; j < DMEM_CHUNK_NPAGES; ++j, ++page) {
-			hmm_devmem_page_set_drvdata(page, (long)chunk);
-		}
+		for (j = 0; j < DMEM_CHUNK_NPAGES; ++j, ++page)
+			page->zone_device_data = chunk;
 	}
 
 	NV_INFO(drm, "DMEM: registered %ldMB of device memory\n", size >> 20);
@@ -698,7 +694,7 @@ nouveau_dmem_migrate_alloc_and_copy(struct vm_area_struct *vma,
 		if (!dpage || dst_pfns[i] == MIGRATE_PFN_ERROR)
 			continue;
 
-		chunk = (void *)hmm_devmem_page_get_drvdata(dpage);
+		chunk = dpage->zone_device_data;
 		dst_addr = page_to_pfn(dpage) - chunk->pfn_first;
 		dst_addr = (dst_addr << PAGE_SHIFT) + chunk->bo->bo.offset;
 
@@ -864,7 +860,7 @@ nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
 			continue;
 		}
 
-		chunk = (void *)hmm_devmem_page_get_drvdata(page);
+		chunk = page->zone_device_data;
 		addr = page_to_pfn(page) - chunk->pfn_first;
 		addr = (addr + chunk->bo->bo.mem.start) << PAGE_SHIFT;
 
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 13152ab504ec..e095a8b55dfa 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -550,33 +550,6 @@ static inline void hmm_mm_init(struct mm_struct *mm)
 static inline void hmm_mm_init(struct mm_struct *mm) {}
 #endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
 
-#if IS_ENABLED(CONFIG_DEVICE_PRIVATE) ||  IS_ENABLED(CONFIG_DEVICE_PUBLIC)
-/*
- * hmm_devmem_page_set_drvdata - set per-page driver data field
- *
- * @page: pointer to struct page
- * @data: driver data value to set
- *
- * Because page can not be on lru we have an unsigned long that driver can use
- * to store a per page field. This just a simple helper to do that.
- */
-static inline void hmm_devmem_page_set_drvdata(struct page *page,
-					       unsigned long data)
-{
-	page->hmm_data = data;
-}
-
-/*
- * hmm_devmem_page_get_drvdata - get per page driver data field
- *
- * @page: pointer to struct page
- * Return: driver data value
- */
-static inline unsigned long hmm_devmem_page_get_drvdata(const struct page *page)
-{
-	return page->hmm_data;
-}
-#endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
 #else /* IS_ENABLED(CONFIG_HMM) */
 static inline void hmm_mm_destroy(struct mm_struct *mm) {}
 static inline void hmm_mm_init(struct mm_struct *mm) {}
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8ec38b11b361..f33a1289c101 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -158,7 +158,7 @@ struct page {
 		struct {	/* ZONE_DEVICE pages */
 			/** @pgmap: Points to the hosting device page map. */
 			struct dev_pagemap *pgmap;
-			unsigned long hmm_data;
+			void *zone_device_data;
 			unsigned long _zd_pad_1;	/* uses mapping */
 		};
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8abe0af..d069ee1f4c2e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5887,12 +5887,12 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		__SetPageReserved(page);
 
 		/*
-		 * ZONE_DEVICE pages union ->lru with a ->pgmap back
-		 * pointer and hmm_data.  It is a bug if a ZONE_DEVICE
-		 * page is ever freed or placed on a driver-private list.
+		 * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
+		 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
+		 * ever freed or placed on a driver-private list.
 		 */
 		page->pgmap = pgmap;
-		page->hmm_data = 0;
+		page->zone_device_data = 0;
 
 		/*
 		 * Mark the block movable so that blocks are reserved for
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0496D434EA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 11:44:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC40121296415;
	Thu, 13 Jun 2019 02:44:34 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 037A721296413
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kZ4qxfaugsPBAzNnf2F5+YBv7IsxX/EWqM6pYodKjkw=; b=k97Dd7pLGeOpmCNCf65fhjYJNc
 ImDu+Xfy6FCJV49fGpZqtY6ITY20Ga5rfbF1ZP8/+kIAUOmCJaXe/qfHjuLsqZDKoqXq4TdEj5Vp0
 jtQNy4yxzFvw8d8X2ge3Dw8edBPvJTaL6od2e2JrfH7Xxbknm4G8HBU9oSnr3E1JnwunI7X3nvPkT
 gG7E9aumHhR8ixTiSTA9r3AzufEbuqKR9dAa8/cqyW4WBVN++uRv1Vx9WTUDrrW59jnByDhykg/ZP
 Vn1lViZhnwx6LLeJpNkx+m+iBmbD0cfZ+ta1tZifhaEB9tvPlXBZQ5SA/zqi/MaVwZjAenHCd3+pW
 jVf38HmA==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hbMHW-0001xS-3I; Thu, 13 Jun 2019 09:44:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 21/22] mm: remove the HMM config option
Date: Thu, 13 Jun 2019 11:43:24 +0200
Message-Id: <20190613094326.24093-22-hch@lst.de>
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

All the mm/hmm.c code is better keyed off HMM_MIRROR.  Also let nouveau
depend on it instead of the mix of a dummy dependency symbol plus the
actually selected one.  Drop various odd dependencies, as the code is
pretty portable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/Kconfig |  3 +--
 include/linux/hmm.h             | 14 +++-----------
 include/linux/mm_types.h        |  2 +-
 mm/Kconfig                      | 27 +++------------------------
 mm/Makefile                     |  2 +-
 mm/hmm.c                        |  2 --
 6 files changed, 9 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 6303d203ab1d..66c839d8e9d1 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -84,11 +84,10 @@ config DRM_NOUVEAU_BACKLIGHT
 
 config DRM_NOUVEAU_SVM
 	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
-	depends on ARCH_HAS_HMM
 	depends on DEVICE_PRIVATE
 	depends on DRM_NOUVEAU
+	depends on HMM_MIRROR
 	depends on STAGING
-	select HMM_MIRROR
 	default n
 	help
 	  Say Y here if you want to enable experimental support for
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index e095a8b55dfa..64ea2fa00872 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -62,7 +62,7 @@
 #include <linux/kconfig.h>
 #include <asm/pgtable.h>
 
-#if IS_ENABLED(CONFIG_HMM)
+#ifdef CONFIG_HMM_MIRROR
 
 #include <linux/device.h>
 #include <linux/migrate.h>
@@ -324,9 +324,6 @@ static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
 	return hmm_device_entry_from_pfn(range, pfn);
 }
 
-
-
-#if IS_ENABLED(CONFIG_HMM_MIRROR)
 /*
  * Mirroring: how to synchronize device page table with CPU page table.
  *
@@ -546,13 +543,8 @@ static inline void hmm_mm_init(struct mm_struct *mm)
 {
 	mm->hmm = NULL;
 }
-#else /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-static inline void hmm_mm_init(struct mm_struct *mm) {}
-#endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-
-#else /* IS_ENABLED(CONFIG_HMM) */
-static inline void hmm_mm_destroy(struct mm_struct *mm) {}
+#else /* CONFIG_HMM_MIRROR */
 static inline void hmm_mm_init(struct mm_struct *mm) {}
-#endif /* IS_ENABLED(CONFIG_HMM) */
+#endif /* CONFIG_HMM_MIRROR */
 
 #endif /* LINUX_HMM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index f33a1289c101..8d37182f8dbe 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -501,7 +501,7 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
 
-#if IS_ENABLED(CONFIG_HMM)
+#ifdef CONFIG_HMM_MIRROR
 		/* HMM needs to track a few things per mm */
 		struct hmm *hmm;
 #endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 4dbd718c8cf4..73676cb4693f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -669,37 +669,17 @@ config ZONE_DEVICE
 
 	  If FS_DAX is enabled, then say Y.
 
-config ARCH_HAS_HMM_MIRROR
-	bool
-	default y
-	depends on (X86_64 || PPC64)
-	depends on MMU && 64BIT
-
-config ARCH_HAS_HMM
-	bool
-	depends on (X86_64 || PPC64)
-	depends on ZONE_DEVICE
-	depends on MMU && 64BIT
-	depends on MEMORY_HOTPLUG
-	depends on MEMORY_HOTREMOVE
-	depends on SPARSEMEM_VMEMMAP
-	default y
-
 config MIGRATE_VMA_HELPER
 	bool
 
 config DEV_PAGEMAP_OPS
 	bool
 
-config HMM
-	bool
-	select MMU_NOTIFIER
-	select MIGRATE_VMA_HELPER
-
 config HMM_MIRROR
 	bool "HMM mirror CPU page table into a device page table"
-	depends on ARCH_HAS_HMM
-	select HMM
+	depends on MMU
+	select MMU_NOTIFIER
+	select MIGRATE_VMA_HELPER
 	help
 	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
 	  process into a device page table. Here, mirror means "keep synchronized".
@@ -721,7 +701,6 @@ config DEVICE_PUBLIC
 	bool "Addressable device memory (like GPU memory)"
 	depends on ARCH_HAS_HMM
 	depends on BROKEN
-	select HMM
 	select DEV_PAGEMAP_OPS
 
 	help
diff --git a/mm/Makefile b/mm/Makefile
index ac5e5ba78874..91c99040065c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -102,5 +102,5 @@ obj-$(CONFIG_FRAME_VECTOR) += frame_vector.o
 obj-$(CONFIG_DEBUG_PAGE_REF) += debug_page_ref.o
 obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
 obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
-obj-$(CONFIG_HMM) += hmm.o
+obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
diff --git a/mm/hmm.c b/mm/hmm.c
index 5b2e9bb6063a..8d50c482469c 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -26,7 +26,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/memory_hotplug.h>
 
-#if IS_ENABLED(CONFIG_HMM_MIRROR)
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
 
 /**
@@ -1289,4 +1288,3 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 	return cpages;
 }
 EXPORT_SYMBOL(hmm_range_dma_unmap);
-#endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C2D56913
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 14:28:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5FC1212AAB8C;
	Wed, 26 Jun 2019 05:28:40 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 2AE56212AAB8A
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8c7Qw79j4iTVfYu8BDZ4XSZccS1fj4ydMQxMOZ0rYRM=; b=qeW+utdJvjdhQsheXW/BJJc+6E
 Je3Qw7KX8yqGRD61b+aMkwDnKhRl79dbPTB2oSJS9EJkkp6B04gH0AKwiMVXmZSWXedEVwmeZuHtd
 rxfolj9Lb0kntloPPle3ysnemn+eVNPk1PVLI65krTeg8f8ixCclNzvQ1VMgjJNdcaSfpbGEE5JqZ
 LdQuIQpaH4WpWeh96t9pFdDMHn8Nlh1iBjfjdCn7Tu5xaSa1u8SC412S343cnc/TFWSgHhCX2D4kz
 T8P1Ggyzn7yKEs00DA9YZRe2O9RSSxL1RnyDktKkewIGQSovonLhKuAUk0FzNPPqOPnS9qC33UPWA
 glFwMabA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hg72M-0001fg-QA; Wed, 26 Jun 2019 12:28:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 24/25] mm: remove the HMM config option
Date: Wed, 26 Jun 2019 14:27:23 +0200
Message-Id: <20190626122724.13313-25-hch@lst.de>
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

All the mm/hmm.c code is better keyed off HMM_MIRROR.  Also let nouveau
depend on it instead of the mix of a dummy dependency symbol plus the
actually selected one.  Drop various odd dependencies, as the code is
pretty portable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/Kconfig |  3 +--
 include/linux/hmm.h             |  5 +----
 include/linux/mm_types.h        |  2 +-
 mm/Kconfig                      | 27 ++++-----------------------
 mm/Makefile                     |  2 +-
 mm/hmm.c                        |  2 --
 6 files changed, 8 insertions(+), 33 deletions(-)

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
index 3d00e9550e77..b697496e85ba 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -62,7 +62,7 @@
 #include <linux/kconfig.h>
 #include <asm/pgtable.h>
 
-#if IS_ENABLED(CONFIG_HMM)
+#ifdef CONFIG_HMM_MIRROR
 
 #include <linux/device.h>
 #include <linux/migrate.h>
@@ -332,9 +332,6 @@ static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
 	return hmm_device_entry_from_pfn(range, pfn);
 }
 
-
-
-#if IS_ENABLED(CONFIG_HMM_MIRROR)
 /*
  * Mirroring: how to synchronize device page table with CPU page table.
  *
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
index eecf037a54b3..1e426c26b1d6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -669,37 +669,18 @@ config ZONE_DEVICE
 
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
+	depends on (X86_64 || PPC64)
+	depends on MMU && 64BIT
+	select MMU_NOTIFIER
+	select MIGRATE_VMA_HELPER
 	help
 	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
 	  process into a device page table. Here, mirror means "keep synchronized".
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
index 90ca0cdab9db..d62ce64d6bca 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -25,7 +25,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/memory_hotplug.h>
 
-#if IS_ENABLED(CONFIG_HMM_MIRROR)
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
 
 static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
@@ -1326,4 +1325,3 @@ long hmm_range_dma_unmap(struct hmm_range *range,
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

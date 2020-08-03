Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0812239EC6
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 07:19:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6FF9A12A6D4C5;
	Sun,  2 Aug 2020 22:19:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9FCA12A6D4C3
	for <linux-nvdimm@lists.01.org>; Sun,  2 Aug 2020 22:19:27 -0700 (PDT)
IronPort-SDR: 4iAlEX70YzHzNWyatocmFmjkkwz3Jh5Hm0DbidRdXLN+q6RMEMdkawdb2K4gbYD2+LnX35jU0g
 nRx5OOudy/jA==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="132105574"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="132105574"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:19:27 -0700
IronPort-SDR: wN3Cp2fspHKF+0Pq0t3ameslhgzNv8IcPCRiWKS24QCzNJqdB6Q3J0N/UQpdN35JPBDD1GvDvw
 Xx8L9ksVx6ZQ==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="491698058"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:19:26 -0700
Subject: [PATCH v4 08/23] device-dax: Drop the dax_region.pfn_flags attribute
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Sun, 02 Aug 2020 22:03:08 -0700
Message-ID: <159643098829.4062302.13611520567669439046.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 4UK3BCPT5Q3KHQX2KHO6Q3GTDUFKGWOM
X-Message-ID-Hash: 4UK3BCPT5Q3KHQX2KHO6Q3GTDUFKGWOM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, joao.m.martins@oracle.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4UK3BCPT5Q3KHQX2KHO6Q3GTDUFKGWOM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

All callers specify the same flags to alloc_dax_region(), so there is no
need to allow for anything other than PFN_DEV|PFN_MAP, or carry a
->pfn_flags around on the region. Device-dax instances are always page
backed.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |    4 +---
 drivers/dax/bus.h         |    3 +--
 drivers/dax/dax-private.h |    2 --
 drivers/dax/device.c      |   26 +++-----------------------
 drivers/dax/hmem/hmem.c   |    2 +-
 drivers/dax/pmem/core.c   |    3 +--
 6 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index df238c8b6ef2..f06ffa66cd78 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -226,8 +226,7 @@ static void dax_region_unregister(void *region)
 }
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, int target_node, unsigned int align,
-		unsigned long long pfn_flags)
+		struct resource *res, int target_node, unsigned int align)
 {
 	struct dax_region *dax_region;
 
@@ -251,7 +250,6 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 
 	dev_set_drvdata(parent, dax_region);
 	memcpy(&dax_region->res, res, sizeof(*res));
-	dax_region->pfn_flags = pfn_flags;
 	kref_init(&dax_region->kref);
 	dax_region->id = region_id;
 	dax_region->align = align;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 9e4eba67e8b9..55577e9791da 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -10,8 +10,7 @@ struct dax_device;
 struct dax_region;
 void dax_region_put(struct dax_region *dax_region);
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, int target_node, unsigned int align,
-		unsigned long long flags);
+		struct resource *res, int target_node, unsigned int align);
 
 enum dev_dax_subsys {
 	DEV_DAX_BUS,
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 16850d5388ab..8a4c40ccd2ef 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -23,7 +23,6 @@ void dax_bus_exit(void);
  * @dev: parent device backing this region
  * @align: allocation and mapping alignment for child dax devices
  * @res: physical address range of the region
- * @pfn_flags: identify whether the pfns are paged back or not
  */
 struct dax_region {
 	int id;
@@ -32,7 +31,6 @@ struct dax_region {
 	struct device *dev;
 	unsigned int align;
 	struct resource res;
-	unsigned long long pfn_flags;
 };
 
 /**
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 4c0af2eb7e19..bffef1b21144 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -41,14 +41,6 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		return -EINVAL;
 	}
 
-	if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) == PFN_DEV
-			&& (vma->vm_flags & VM_DONTCOPY) == 0) {
-		dev_info_ratelimited(dev,
-				"%s: %s: fail, dax range requires MADV_DONTFORK\n",
-				current->comm, func);
-		return -EINVAL;
-	}
-
 	if (!vma_is_dax(vma)) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, vma is not DAX capable\n",
@@ -102,7 +94,7 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	*pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
+	*pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
 
 	return vmf_insert_mixed(vmf->vma, vmf->address, *pfn);
 }
@@ -127,12 +119,6 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	/* dax pmd mappings require pfn_t_devmap() */
-	if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) != (PFN_DEV|PFN_MAP)) {
-		dev_dbg(dev, "region lacks devmap flags\n");
-		return VM_FAULT_SIGBUS;
-	}
-
 	if (fault_size < dax_region->align)
 		return VM_FAULT_SIGBUS;
 	else if (fault_size > dax_region->align)
@@ -150,7 +136,7 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	*pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
+	*pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
 
 	return vmf_insert_pfn_pmd(vmf, *pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
@@ -177,12 +163,6 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	/* dax pud mappings require pfn_t_devmap() */
-	if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) != (PFN_DEV|PFN_MAP)) {
-		dev_dbg(dev, "region lacks devmap flags\n");
-		return VM_FAULT_SIGBUS;
-	}
-
 	if (fault_size < dax_region->align)
 		return VM_FAULT_SIGBUS;
 	else if (fault_size > dax_region->align)
@@ -200,7 +180,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	*pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
+	*pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
 
 	return vmf_insert_pfn_pud(vmf, *pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 29ceb5795297..506893861253 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -22,7 +22,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	memcpy(&pgmap.res, res, sizeof(*res));
 
 	dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
-			PMD_SIZE, PFN_DEV|PFN_MAP);
+			PMD_SIZE);
 	if (!dax_region)
 		return -ENOMEM;
 
diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 2bedf8414fff..ea52bb77a294 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -53,8 +53,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	memcpy(&res, &pgmap.res, sizeof(res));
 	res.start += offset;
 	dax_region = alloc_dax_region(dev, region_id, &res,
-			nd_region->target_node, le32_to_cpu(pfn_sb->align),
-			PFN_DEV|PFN_MAP);
+			nd_region->target_node, le32_to_cpu(pfn_sb->align));
 	if (!dax_region)
 		return ERR_PTR(-ENOMEM);
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

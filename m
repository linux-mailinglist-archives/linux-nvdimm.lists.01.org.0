Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B59239EDD
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 07:20:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 03D4C12A6D4D0;
	Sun,  2 Aug 2020 22:20:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 18EF512A6D4C7
	for <linux-nvdimm@lists.01.org>; Sun,  2 Aug 2020 22:20:33 -0700 (PDT)
IronPort-SDR: dYGhhyNmDuRliIy8tWQ80fVAyzPcwW4iVcRLcp1FY0ZxxKHsups57jIcqfTNZMRj2F6weT1aK9
 AJ4wcdBt3B2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="151252266"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="151252266"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:20:32 -0700
IronPort-SDR: Q4wqFp6NHlXuXQJz/1u4ACuBKdO7iqNqFIYE446SgNcM7iR/d/jzaKrY5zPk3IbBbdo7/GpsCn
 qDO+PvICOLHg==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="329890662"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:20:32 -0700
Subject: [PATCH v4 20/23] device-dax: Make align a per-device property
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Sun, 02 Aug 2020 22:04:13 -0700
Message-ID: <159643105377.4062302.4159447829955683131.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: O4COHXDIUM2WYJ6OETU4Z5XC7UM6RRFL
X-Message-ID-Hash: O4COHXDIUM2WYJ6OETU4Z5XC7UM6RRFL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: joao.m.martins@oracle.com, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O4COHXDIUM2WYJ6OETU4Z5XC7UM6RRFL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Joao Martins <joao.m.martins@oracle.com>

Introduce @align to struct dev_dax.

When creating a new device, we still initialize to the default
dax_region @align. Child devices belonging to a region may wish
to keep a different alignment property instead of a global
region-defined one.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20200716172913.19658-2-joao.m.martins@oracle.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |    1 +
 drivers/dax/dax-private.h |    3 +++
 drivers/dax/device.c      |   37 +++++++++++++++----------------------
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 2779c65dc7c0..9edfdf83408e 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1215,6 +1215,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->target_node = dax_region->target_node;
+	dev_dax->align = dax_region->align;
 	ida_init(&dev_dax->ida);
 	kref_get(&dax_region->kref);
 
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 13780f62b95e..5fd3a26cfcea 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -62,6 +62,7 @@ struct dax_mapping {
 struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
+	unsigned int align;
 	int target_node;
 	int id;
 	struct ida ida;
@@ -84,4 +85,6 @@ static inline struct dax_mapping *to_dax_mapping(struct device *dev)
 {
 	return container_of(dev, struct dax_mapping, dev);
 }
+
+phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff, unsigned long size);
 #endif
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2bfc5c83e3b0..d2b1892cb1b2 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -17,7 +17,6 @@
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		const char *func)
 {
-	struct dax_region *dax_region = dev_dax->region;
 	struct device *dev = &dev_dax->dev;
 	unsigned long mask;
 
@@ -32,7 +31,7 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		return -EINVAL;
 	}
 
-	mask = dax_region->align - 1;
+	mask = dev_dax->align - 1;
 	if (vma->vm_start & mask || vma->vm_end & mask) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
@@ -78,21 +77,19 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 				struct vm_fault *vmf, pfn_t *pfn)
 {
 	struct device *dev = &dev_dax->dev;
-	struct dax_region *dax_region;
 	phys_addr_t phys;
 	unsigned int fault_size = PAGE_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
 		return VM_FAULT_SIGBUS;
 
-	dax_region = dev_dax->region;
-	if (dax_region->align > PAGE_SIZE) {
+	if (dev_dax->align > PAGE_SIZE) {
 		dev_dbg(dev, "alignment (%#x) > fault size (%#x)\n",
-			dax_region->align, fault_size);
+			dev_dax->align, fault_size);
 		return VM_FAULT_SIGBUS;
 	}
 
-	if (fault_size != dax_region->align)
+	if (fault_size != dev_dax->align)
 		return VM_FAULT_SIGBUS;
 
 	phys = dax_pgoff_to_phys(dev_dax, vmf->pgoff, PAGE_SIZE);
@@ -120,15 +117,15 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 
 	dax_region = dev_dax->region;
-	if (dax_region->align > PMD_SIZE) {
+	if (dev_dax->align > PMD_SIZE) {
 		dev_dbg(dev, "alignment (%#x) > fault size (%#x)\n",
-			dax_region->align, fault_size);
+			dev_dax->align, fault_size);
 		return VM_FAULT_SIGBUS;
 	}
 
-	if (fault_size < dax_region->align)
+	if (fault_size < dev_dax->align)
 		return VM_FAULT_SIGBUS;
-	else if (fault_size > dax_region->align)
+	else if (fault_size > dev_dax->align)
 		return VM_FAULT_FALLBACK;
 
 	/* if we are outside of the VMA */
@@ -164,15 +161,15 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 
 	dax_region = dev_dax->region;
-	if (dax_region->align > PUD_SIZE) {
+	if (dev_dax->align > PUD_SIZE) {
 		dev_dbg(dev, "alignment (%#x) > fault size (%#x)\n",
-			dax_region->align, fault_size);
+			dev_dax->align, fault_size);
 		return VM_FAULT_SIGBUS;
 	}
 
-	if (fault_size < dax_region->align)
+	if (fault_size < dev_dax->align)
 		return VM_FAULT_SIGBUS;
-	else if (fault_size > dax_region->align)
+	else if (fault_size > dev_dax->align)
 		return VM_FAULT_FALLBACK;
 
 	/* if we are outside of the VMA */
@@ -267,9 +264,8 @@ static int dev_dax_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct file *filp = vma->vm_file;
 	struct dev_dax *dev_dax = filp->private_data;
-	struct dax_region *dax_region = dev_dax->region;
 
-	if (!IS_ALIGNED(addr, dax_region->align))
+	if (!IS_ALIGNED(addr, dev_dax->align))
 		return -EINVAL;
 	return 0;
 }
@@ -278,9 +274,8 @@ static unsigned long dev_dax_pagesize(struct vm_area_struct *vma)
 {
 	struct file *filp = vma->vm_file;
 	struct dev_dax *dev_dax = filp->private_data;
-	struct dax_region *dax_region = dev_dax->region;
 
-	return dax_region->align;
+	return dev_dax->align;
 }
 
 static const struct vm_operations_struct dax_vm_ops = {
@@ -319,13 +314,11 @@ static unsigned long dax_get_unmapped_area(struct file *filp,
 {
 	unsigned long off, off_end, off_align, len_align, addr_align, align;
 	struct dev_dax *dev_dax = filp ? filp->private_data : NULL;
-	struct dax_region *dax_region;
 
 	if (!dev_dax || addr)
 		goto out;
 
-	dax_region = dev_dax->region;
-	align = dax_region->align;
+	align = dev_dax->align;
 	off = pgoff << PAGE_SHIFT;
 	off_end = off + len;
 	off_align = round_up(off, align);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

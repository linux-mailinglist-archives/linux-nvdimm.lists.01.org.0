Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EDC14E3E2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jan 2020 21:22:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B6627100780A5;
	Thu, 30 Jan 2020 12:25:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 26924100780A5
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 12:25:43 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 12:22:11 -0800
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400";
   d="scan'208";a="320000739"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 12:22:11 -0800
Subject: [PATCH 2/5] mm/memremap_pages: Introduce memremap_compat_align()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 30 Jan 2020 12:06:07 -0800
Message-ID: <158041476763.3889308.13149849631980018039.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: ULPPKFQWZBK5K7XQ3FFQRIS4P6SH2DCB
X-Message-ID-Hash: ULPPKFQWZBK5K7XQ3FFQRIS4P6SH2DCB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, hch@lst.de, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ULPPKFQWZBK5K7XQ3FFQRIS4P6SH2DCB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The "sub-section memory hotplug" facility allows memremap_pages() users
like libnvdimm to compensate for hardware platforms like x86 that have a
section size larger than their hardware memory mapping granularity.  The
compensation that sub-section support affords is being tolerant of
physical memory resources shifting by units smaller (64MiB on x86) than
the memory-hotplug section size (128 MiB). Where the platform
physical-memory mapping granularity is limited by the number and
capability of address-decode-registers in the memory controller.

While the sub-section support allows memremap_pages() to operate on
sub-section (2MiB) granularity, the Power architecture may still
require 16MiB alignment on "!radix_enabled()" platforms.

In order for libnvdimm to be able to detect and manage this per-arch
limitation, introduce memremap_compat_align() as a common minimum
alignment across all driver-facing memory-mapping interfaces, and let
Power override it to 16MiB in the "!radix_enabled()" case.

The assumption / requirement for 16MiB to be a viable
memremap_compat_align() value is that Power does not have platforms
where its equivalent of address-decode-registers never hardware remaps a
persistent memory resource on smaller than 16MiB boundaries.

Based on an initial patch by Aneesh.

Link: http://lore.kernel.org/r/CAPcyv4gBGNP95APYaBcsocEa50tQj9b5h__83vgngjq3ouGX_Q@mail.gmail.com
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reported-by: Jeff Moyer <jmoyer@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/powerpc/include/asm/io.h |   10 ++++++++++
 drivers/nvdimm/pfn_devs.c     |    2 +-
 include/linux/io.h            |   23 +++++++++++++++++++++++
 include/linux/mmzone.h        |    1 +
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index a63ec938636d..0fa2dc483008 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -734,6 +734,16 @@ extern void __iomem * __ioremap_at(phys_addr_t pa, void *ea,
 				   unsigned long size, pgprot_t prot);
 extern void __iounmap_at(void *ea, unsigned long size);
 
+#ifdef CONFIG_SPARSEMEM
+static inline unsigned long memremap_compat_align(void)
+{
+	if (radix_enabled())
+		return SUBSECTION_SIZE;
+	return (1UL << mmu_psize_defs[mmu_linear_psize].shift);
+}
+#define memremap_compat_align memremap_compat_align
+#endif
+
 /*
  * When CONFIG_PPC_INDIRECT_PIO is set, we use the generic iomap implementation
  * which needs some additional definitions here. They basically allow PIO
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index b94f7a7e94b8..a5c25cb87116 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -750,7 +750,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	start = nsio->res.start;
 	size = resource_size(&nsio->res);
 	npfns = PHYS_PFN(size - SZ_8K);
-	align = max(nd_pfn->align, (1UL << SUBSECTION_SHIFT));
+	align = max(nd_pfn->align, SUBSECTION_SIZE);
 	end_trunc = start + size - ALIGN_DOWN(start + size, align);
 	if (nd_pfn->mode == PFN_MODE_PMEM) {
 		/*
diff --git a/include/linux/io.h b/include/linux/io.h
index 35e8d84935e0..ccd34519fad3 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -6,6 +6,7 @@
 #ifndef _LINUX_IO_H
 #define _LINUX_IO_H
 
+#include <linux/mmzone.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/bug.h>
@@ -79,6 +80,28 @@ void *devm_memremap(struct device *dev, resource_size_t offset,
 		size_t size, unsigned long flags);
 void devm_memunmap(struct device *dev, void *addr);
 
+#ifndef memremap_compat_align
+#ifdef CONFIG_SPARSEMEM
+/*
+ * Minimum compatible alignment of the resource (start, end) across
+ * memremap interfaces (i.e. memremap + memremap_pages)
+ */
+static inline unsigned long memremap_compat_align(void)
+{
+	return SUBSECTION_SIZE;
+}
+#else /* CONFIG_SPARSEMEM */
+/*
+ * No ZONE_DEVICE / memremap_pages() support so the minimum mapping
+ * granularity is a single page.
+ */
+static inline unsigned long memremap_compat_align(void)
+{
+	return PAGE_SIZE;
+}
+#endif /* CONFIG_SPARSEMEM */
+#endif /* memremap_compat_align */
+
 #ifdef CONFIG_PCI
 /*
  * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 89d8ff06c9ce..b0de83620cd7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1171,6 +1171,7 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
 #define SECTION_ALIGN_DOWN(pfn)	((pfn) & PAGE_SECTION_MASK)
 
 #define SUBSECTION_SHIFT 21
+#define SUBSECTION_SIZE (1UL << SUBSECTION_SHIFT)
 
 #define PFN_SUBSECTION_SHIFT (SUBSECTION_SHIFT - PAGE_SHIFT)
 #define PAGES_PER_SUBSECTION (1UL << PFN_SUBSECTION_SHIFT)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

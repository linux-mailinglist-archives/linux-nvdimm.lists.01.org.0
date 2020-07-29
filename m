Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC623182E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 05:35:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DAEC11460B21;
	Tue, 28 Jul 2020 20:35:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by ml01.01.org (Postfix) with ESMTP id 7B59B12664311
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 20:35:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CA4631B;
	Tue, 28 Jul 2020 20:35:36 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A161E3F66E;
	Tue, 28 Jul 2020 20:35:28 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH 3/6] mm/memory_hotplug: allow pmem kmem not to align with memory_block_size
Date: Wed, 29 Jul 2020 11:34:21 +0800
Message-Id: <20200729033424.2629-4-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Message-ID-Hash: A226WWADFYG5MWIPXQML4YTBEJ6ZTBZV
X-Message-ID-Hash: A226WWADFYG5MWIPXQML4YTBEJ6ZTBZV
X-MailFrom: justin.he@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <steve.capper@arm.com>, Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A226WWADFYG5MWIPXQML4YTBEJ6ZTBZV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When dax pmem is probed as RAM device on arm64, previously, kmem_start in
dev_dax_kmem_probe() should be aligned with 1G memblock size on arm64 due
to SECTION_SIZE_BITS(30).

There will be some meta data at the beginning/end of the iomem space, e.g.
namespace info and nvdimm label:
240000000-33fdfffff : Persistent Memory
  240000000-2403fffff : namespace0.0
  280000000-2bfffffff : dax0.0
    280000000-2bfffffff : System RAM

Hence it makes the whole kmem space not aligned with memory_block_size for
both start addr and end addr. Hence there is a big gap when kmem is added
into memory block which causes big memory space wasting.

This changes it by relaxing the alignment check for dax pmem kmem in the
path of online/offline memory blocks.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/base/memory.c | 16 ++++++++++++++++
 mm/memory_hotplug.c   | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 4a1691664c6c..3d2a94f3b1d9 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -334,6 +334,22 @@ static ssize_t valid_zones_show(struct device *dev,
 	 * online nodes otherwise the page_zone is not reliable
 	 */
 	if (mem->state == MEM_ONLINE) {
+#ifdef CONFIG_ZONE_DEVICE
+		struct resource res;
+		int ret;
+
+		/* adjust start_pfn for dax pmem kmem */
+		ret = find_next_iomem_res(start_pfn << PAGE_SHIFT,
+					((start_pfn + nr_pages) << PAGE_SHIFT) - 1,
+					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					IORES_DESC_PERSISTENT_MEMORY,
+					false, &res);
+		if (!ret && PFN_UP(res.start) > start_pfn) {
+			nr_pages -= PFN_UP(res.start) - start_pfn;
+			start_pfn = PFN_UP(res.start);
+		}
+#endif
+
 		/*
 		 * The block contains more than one zone can not be offlined.
 		 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a53103dc292b..25745f67b680 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -999,6 +999,20 @@ int try_online_node(int nid)
 
 static int check_hotplug_memory_range(u64 start, u64 size)
 {
+#ifdef CONFIG_ZONE_DEVICE
+	struct resource res;
+	int ret;
+
+	/* Allow pmem kmem not to align with block size */
+	ret = find_next_iomem_res(start, start + size - 1,
+				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+				IORES_DESC_PERSISTENT_MEMORY,
+				false, &res);
+	if (!ret) {
+		return 0;
+	}
+#endif
+
 	/* memory range must be block size aligned */
 	if (!size || !IS_ALIGNED(start, memory_block_size_bytes()) ||
 	    !IS_ALIGNED(size, memory_block_size_bytes())) {
@@ -1481,19 +1495,42 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	mem_hotplug_begin();
 
 	/*
-	 * Don't allow to offline memory blocks that contain holes.
+	 * Don't allow to offline memory blocks that contain holes except
+	 * for pmem.
 	 * Consequently, memory blocks with holes can never get onlined
 	 * via the hotplug path - online_pages() - as hotplugged memory has
 	 * no holes. This way, we e.g., don't have to worry about marking
 	 * memory holes PG_reserved, don't need pfn_valid() checks, and can
 	 * avoid using walk_system_ram_range() later.
+	 * When dax pmem is used as RAM (kmem), holes at the beginning is
+	 * allowed.
 	 */
 	walk_system_ram_range(start_pfn, end_pfn - start_pfn, &nr_pages,
 			      count_system_ram_pages_cb);
 	if (nr_pages != end_pfn - start_pfn) {
+#ifdef CONFIG_ZONE_DEVICE
+		struct resource res;
+
+		/* Allow pmem kmem not to align with block size */
+		ret = find_next_iomem_res(start_pfn << PAGE_SHIFT,
+					(end_pfn << PAGE_SHIFT) - 1,
+					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					IORES_DESC_PERSISTENT_MEMORY,
+					false, &res);
+		if (ret) {
+			ret = -EINVAL;
+			reason = "memory holes";
+			goto failed_removal;
+		}
+
+		/* adjust start_pfn for dax pmem kmem */
+		start_pfn = PFN_UP(res.start);
+		end_pfn = PFN_DOWN(res.end + 1);
+#else
 		ret = -EINVAL;
 		reason = "memory holes";
 		goto failed_removal;
+#endif
 	}
 
 	/* This makes hotplug much easier...and readable.
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

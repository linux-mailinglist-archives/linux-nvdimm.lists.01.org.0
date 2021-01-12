Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F6B2F2B59
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 10:34:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EA53E100EBB76;
	Tue, 12 Jan 2021 01:34:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A03C1100EBB76
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 01:34:53 -0800 (PST)
IronPort-SDR: n6JQaT31sV9J2p9oubigpRneFHg3yJHsXGo9WNfsydacsUWgf2HDy7aDuMQ8X6C6N7tuURjAcw
 KiKAcYoohmLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="174503047"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400";
   d="scan'208";a="174503047"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:53 -0800
IronPort-SDR: 1cA306Ajw9GGMohxh+f8sCPVIs3psRWeoxX8r1HL+gk2oYg/Ku/eSHOxxOg1KkRTysnrnre2Xb
 Gn3ktYY8KV4g==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400";
   d="scan'208";a="348400264"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:53 -0800
Subject: [PATCH v2 3/5] mm: Teach pfn_to_online_page() about ZONE_DEVICE
 section collisions
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Tue, 12 Jan 2021 01:34:53 -0800
Message-ID: <161044409294.1482714.434561066315039753.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 3PVGHIKARYQDMMYUBMU23J7PQNE6LD3Z
X-Message-ID-Hash: 3PVGHIKARYQDMMYUBMU23J7PQNE6LD3Z
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3PVGHIKARYQDMMYUBMU23J7PQNE6LD3Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

While pfn_to_online_page() is able to determine pfn_valid() at
subsection granularity it is not able to reliably determine if a given
pfn is also online if the section is mixes ZONE_{NORMAL,MOVABLE} with
ZONE_DEVICE. This means that pfn_to_online_page() may return invalid
@page objects. For example with a memory map like:

100000000-1fbffffff : System RAM
  142000000-143002e16 : Kernel code
  143200000-143713fff : Kernel rodata
  143800000-143b15b7f : Kernel data
  144227000-144ffffff : Kernel bss
1fc000000-2fbffffff : Persistent Memory (legacy)
  1fc000000-2fbffffff : namespace0.0

This command:

echo 0x1fc000000 > /sys/devices/system/memory/soft_offline_page

...succeeds when it should fail. When it succeeds it touches
an uninitialized page and may crash or cause other damage (see
dissolve_free_huge_page()).

While the memory map above is contrived via the memmap=ss!nn kernel
command line option, the collision happens in practice on shipping
platforms. The memory controller resources that decode spans of
physical address space are a limited resource. One technique
platform-firmware uses to conserve those resources is to share a decoder
across 2 devices to keep the address range contiguous. Unfortunately the
unit of operation of a decoder is 64MiB while the Linux section size is
128MiB. This results in situations where, without subsection hotplug
memory mappings with different lifetimes collide into one object that
can only express one lifetime.

Update move_pfn_range_to_zone() to flag (SECTION_TAINT_ZONE_DEVICE) a
section that mixes ZONE_DEVICE pfns with other online pfns. With
SECTION_TAINT_ZONE_DEVICE to delineate, pfn_to_online_page() can fall
back to a slow-path check for ZONE_DEVICE pfns in an online section. In
the fast path online_section() for a full ZONE_DEVICE section returns
false.

Because the collision case is rare, and for simplicity, the
SECTION_TAINT_ZONE_DEVICE flag is never cleared once set.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Michal Hocko <mhocko@suse.com>
Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mmzone.h |   22 +++++++++++++++-------
 mm/memory_hotplug.c    |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316bff3d..0b5c44f730b4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1273,13 +1273,14 @@ extern size_t mem_section_usage_size(void);
  *      which results in PFN_SECTION_SHIFT equal 6.
  * To sum it up, at least 6 bits are available.
  */
-#define	SECTION_MARKED_PRESENT	(1UL<<0)
-#define SECTION_HAS_MEM_MAP	(1UL<<1)
-#define SECTION_IS_ONLINE	(1UL<<2)
-#define SECTION_IS_EARLY	(1UL<<3)
-#define SECTION_MAP_LAST_BIT	(1UL<<4)
-#define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
-#define SECTION_NID_SHIFT	3
+#define SECTION_MARKED_PRESENT		(1UL<<0)
+#define SECTION_HAS_MEM_MAP		(1UL<<1)
+#define SECTION_IS_ONLINE		(1UL<<2)
+#define SECTION_IS_EARLY		(1UL<<3)
+#define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
+#define SECTION_MAP_LAST_BIT		(1UL<<5)
+#define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
+#define SECTION_NID_SHIFT		3
 
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
@@ -1318,6 +1319,13 @@ static inline int online_section(struct mem_section *section)
 	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
 }
 
+static inline int online_device_section(struct mem_section *section)
+{
+	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
+
+	return section && ((section->section_mem_map & flags) == flags);
+}
+
 static inline int online_section_nr(unsigned long nr)
 {
 	return online_section(__nr_to_section(nr));
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a845b3979bc0..b2ccb84c3082 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -308,6 +308,7 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
 struct page *pfn_to_online_page(unsigned long pfn)
 {
 	unsigned long nr = pfn_to_section_nr(pfn);
+	struct dev_pagemap *pgmap;
 	struct mem_section *ms;
 
 	if (nr >= NR_MEM_SECTIONS)
@@ -320,6 +321,22 @@ struct page *pfn_to_online_page(unsigned long pfn)
 	if (!pfn_section_valid(ms, pfn))
 		return NULL;
 
+	if (!online_device_section(ms))
+		return pfn_to_page(pfn);
+
+	/*
+	 * Slowpath: when ZONE_DEVICE collides with
+	 * ZONE_{NORMAL,MOVABLE} within the same section some pfns in
+	 * the section may be 'offline' but 'valid'. Only
+	 * get_dev_pagemap() can determine sub-section online status.
+	 */
+	pgmap = get_dev_pagemap(pfn, NULL);
+	put_dev_pagemap(pgmap);
+
+	/* The presence of a pgmap indicates ZONE_DEVICE offline pfn */
+	if (pgmap)
+		return NULL;
+
 	return pfn_to_page(pfn);
 }
 EXPORT_SYMBOL_GPL(pfn_to_online_page);
@@ -702,6 +719,14 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
 	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
 
 }
+
+static void section_taint_zone_device(unsigned long pfn)
+{
+	struct mem_section *ms = __pfn_to_section(pfn);
+
+	ms->section_mem_map |= SECTION_TAINT_ZONE_DEVICE;
+}
+
 /*
  * Associate the pfn range with the given zone, initializing the memmaps
  * and resizing the pgdat/zone data to span the added pages. After this
@@ -731,6 +756,19 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	resize_pgdat_range(pgdat, start_pfn, nr_pages);
 	pgdat_resize_unlock(pgdat, &flags);
 
+	/*
+	 * Subsection population requires care in pfn_to_online_page().
+	 * Set the taint to enable the slow path detection of
+	 * ZONE_DEVICE pages in an otherwise  ZONE_{NORMAL,MOVABLE}
+	 * section.
+	 */
+	if (zone_idx(zone) == ZONE_DEVICE) {
+		if (!IS_ALIGNED(start_pfn, PAGES_PER_SECTION))
+			section_taint_zone_device(start_pfn);
+		if (!IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION))
+			section_taint_zone_device(start_pfn + nr_pages);
+	}
+
 	/*
 	 * TODO now we have a visible range of pages which are not associated
 	 * with their zone properly. Not nice but set_pfnblock_flags_mask
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F117404F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 20:34:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7EE9F10FC36F9;
	Fri, 28 Feb 2020 11:35:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A2FC310FC36F7
	for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 11:35:11 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 11:34:19 -0800
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400";
   d="scan'208";a="261962847"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 11:34:19 -0800
Subject: [PATCH v3 5/5] libnvdimm/region: Introduce an 'align' attribute
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Fri, 28 Feb 2020 11:18:14 -0800
Message-ID: <158291749396.1609624.15961227027632462090.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: DLALBZAQGNGULQ5B4U6VEPKCONHXXUL7
X-Message-ID-Hash: DLALBZAQGNGULQ5B4U6VEPKCONHXXUL7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DLALBZAQGNGULQ5B4U6VEPKCONHXXUL7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The align attribute applies an alignment constraint for namespace
creation in a region. Whereas the 'align' attribute of a namespace
applied alignment padding via an info block, the 'align' attribute
applies alignment constraints to the free space allocation.

The default for 'align' is the maximum known memremap_compat_align()
across all archs (16MiB from PowerPC at time of writing) multiplied by
the number of interleave ways if there is blk-aliasing. The minimum is
PAGE_SIZE and allows for the creation of cross-arch incompatible
namespaces, just as previous kernels allowed, but the expectation is
cross-arch and mode-independent compatibility by default.

The regression risk with this change is limited to cases that were
dependent on the ability to create unaligned namespaces, *and* for some
reason are unable to opt-out of aligned namespaces by writing to
'regionX/align'. If such a scenario arises the default can be flipped
from opt-out to opt-in of compat-aligned namespace creation, but that is
a last resort. The kernel will otherwise continue to support existing
defined misaligned namespaces.

Unfortunately this change needs to touch several parts of the
implementation at once:

- region/available_size: expand busy extents to current align
- region/max_available_extent: expand busy extents to current align
- namespace/size: trim free space to current align

...to keep the free space accounting conforming to the dynamic align
setting.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reported-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Link: https://lore.kernel.org/r/158041478371.3889308.14542630147672668068.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/dimm_devs.c      |   86 +++++++++++++++++++++++----
 drivers/nvdimm/namespace_devs.c |    9 ++-
 drivers/nvdimm/nd.h             |    1 
 drivers/nvdimm/region_devs.c    |  122 ++++++++++++++++++++++++++++++++++++---
 4 files changed, 192 insertions(+), 26 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 39a61a514746..b7b77e8d9027 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -563,6 +563,21 @@ int nvdimm_security_freeze(struct nvdimm *nvdimm)
 	return rc;
 }
 
+static unsigned long dpa_align(struct nd_region *nd_region)
+{
+	struct device *dev = &nd_region->dev;
+
+	if (dev_WARN_ONCE(dev, !is_nvdimm_bus_locked(dev),
+				"bus lock required for capacity provision\n"))
+		return 0;
+	if (dev_WARN_ONCE(dev, !nd_region->ndr_mappings || nd_region->align
+				% nd_region->ndr_mappings,
+				"invalid region align %#lx mappings: %d\n",
+				nd_region->align, nd_region->ndr_mappings))
+		return 0;
+	return nd_region->align / nd_region->ndr_mappings;
+}
+
 int alias_dpa_busy(struct device *dev, void *data)
 {
 	resource_size_t map_end, blk_start, new;
@@ -571,6 +586,7 @@ int alias_dpa_busy(struct device *dev, void *data)
 	struct nd_region *nd_region;
 	struct nvdimm_drvdata *ndd;
 	struct resource *res;
+	unsigned long align;
 	int i;
 
 	if (!is_memory(dev))
@@ -608,13 +624,21 @@ int alias_dpa_busy(struct device *dev, void *data)
 	 * Find the free dpa from the end of the last pmem allocation to
 	 * the end of the interleave-set mapping.
 	 */
+	align = dpa_align(nd_region);
+	if (!align)
+		return 0;
+
 	for_each_dpa_resource(ndd, res) {
+		resource_size_t start, end;
+
 		if (strncmp(res->name, "pmem", 4) != 0)
 			continue;
-		if ((res->start >= blk_start && res->start < map_end)
-				|| (res->end >= blk_start
-					&& res->end <= map_end)) {
-			new = max(blk_start, min(map_end + 1, res->end + 1));
+
+		start = ALIGN_DOWN(res->start, align);
+		end = ALIGN(res->end + 1, align) - 1;
+		if ((start >= blk_start && start < map_end)
+				|| (end >= blk_start && end <= map_end)) {
+			new = max(blk_start, min(map_end, end) + 1);
 			if (new != blk_start) {
 				blk_start = new;
 				goto retry;
@@ -654,6 +678,7 @@ resource_size_t nd_blk_available_dpa(struct nd_region *nd_region)
 		.res = NULL,
 	};
 	struct resource *res;
+	unsigned long align;
 
 	if (!ndd)
 		return 0;
@@ -661,10 +686,20 @@ resource_size_t nd_blk_available_dpa(struct nd_region *nd_region)
 	device_for_each_child(&nvdimm_bus->dev, &info, alias_dpa_busy);
 
 	/* now account for busy blk allocations in unaliased dpa */
+	align = dpa_align(nd_region);
+	if (!align)
+		return 0;
 	for_each_dpa_resource(ndd, res) {
+		resource_size_t start, end, size;
+
 		if (strncmp(res->name, "blk", 3) != 0)
 			continue;
-		info.available -= resource_size(res);
+		start = ALIGN_DOWN(res->start, align);
+		end = ALIGN(res->end + 1, align) - 1;
+		size = end - start + 1;
+		if (size >= info.available)
+			return 0;
+		info.available -= size;
 	}
 
 	return info.available;
@@ -683,19 +718,31 @@ resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
 	struct nvdimm_bus *nvdimm_bus;
 	resource_size_t max = 0;
 	struct resource *res;
+	unsigned long align;
 
 	/* if a dimm is disabled the available capacity is zero */
 	if (!ndd)
 		return 0;
 
+	align = dpa_align(nd_region);
+	if (!align)
+		return 0;
+
 	nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
 	if (__reserve_free_pmem(&nd_region->dev, nd_mapping->nvdimm))
 		return 0;
 	for_each_dpa_resource(ndd, res) {
+		resource_size_t start, end;
+
 		if (strcmp(res->name, "pmem-reserve") != 0)
 			continue;
-		if (resource_size(res) > max)
-			max = resource_size(res);
+		/* trim free space relative to current alignment setting */
+		start = ALIGN(res->start, align);
+		end = ALIGN_DOWN(res->end + 1, align) - 1;
+		if (end < start)
+			continue;
+		if (end - start + 1 > max)
+			max = end - start + 1;
 	}
 	release_free_pmem(nvdimm_bus, nd_mapping);
 	return max;
@@ -723,24 +770,33 @@ resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 	struct resource *res;
 	const char *reason;
+	unsigned long align;
 
 	if (!ndd)
 		return 0;
 
+	align = dpa_align(nd_region);
+	if (!align)
+		return 0;
+
 	map_start = nd_mapping->start;
 	map_end = map_start + nd_mapping->size - 1;
 	blk_start = max(map_start, map_end + 1 - *overlap);
 	for_each_dpa_resource(ndd, res) {
-		if (res->start >= map_start && res->start < map_end) {
+		resource_size_t start, end;
+
+		start = ALIGN_DOWN(res->start, align);
+		end = ALIGN(res->end + 1, align) - 1;
+		if (start >= map_start && start < map_end) {
 			if (strncmp(res->name, "blk", 3) == 0)
 				blk_start = min(blk_start,
-						max(map_start, res->start));
-			else if (res->end > map_end) {
+						max(map_start, start));
+			else if (end > map_end) {
 				reason = "misaligned to iset";
 				goto err;
 			} else
-				busy += resource_size(res);
-		} else if (res->end >= map_start && res->end <= map_end) {
+				busy += end - start + 1;
+		} else if (end >= map_start && end <= map_end) {
 			if (strncmp(res->name, "blk", 3) == 0) {
 				/*
 				 * If a BLK allocation overlaps the start of
@@ -749,8 +805,8 @@ resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 				 */
 				blk_start = map_start;
 			} else
-				busy += resource_size(res);
-		} else if (map_start > res->start && map_start < res->end) {
+				busy += end - start + 1;
+		} else if (map_start > start && map_start < end) {
 			/* total eclipse of the mapping */
 			busy += nd_mapping->size;
 			blk_start = map_start;
@@ -760,7 +816,7 @@ resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 	*overlap = map_end + 1 - blk_start;
 	available = blk_start - map_start;
 	if (busy < available)
-		return available - busy;
+		return ALIGN_DOWN(available - busy, align);
 	return 0;
 
  err:
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 2388598ce1a2..23b373bb31b3 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -542,6 +542,11 @@ static void space_valid(struct nd_region *nd_region, struct nvdimm_drvdata *ndd,
 {
 	bool is_reserve = strcmp(label_id->id, "pmem-reserve") == 0;
 	bool is_pmem = strncmp(label_id->id, "pmem", 4) == 0;
+	unsigned long align;
+
+	align = nd_region->align / nd_region->ndr_mappings;
+	valid->start = ALIGN(valid->start, align);
+	valid->end = ALIGN_DOWN(valid->end + 1, align) - 1;
 
 	if (valid->start >= valid->end)
 		goto invalid;
@@ -981,10 +986,10 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 		return -ENXIO;
 	}
 
-	div_u64_rem(val, PAGE_SIZE * nd_region->ndr_mappings, &remainder);
+	div_u64_rem(val, nd_region->align, &remainder);
 	if (remainder) {
 		dev_dbg(dev, "%llu is not %ldK aligned\n", val,
-				(PAGE_SIZE * nd_region->ndr_mappings) / SZ_1K);
+				nd_region->align / SZ_1K);
 		return -EINVAL;
 	}
 
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ca39abe29c7c..c4d69c1cce55 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -146,6 +146,7 @@ struct nd_region {
 	struct device *btt_seed;
 	struct device *pfn_seed;
 	struct device *dax_seed;
+	unsigned long align;
 	u16 ndr_mappings;
 	u64 ndr_size;
 	u64 ndr_start;
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index a5fc6e4c56ff..bf239e783940 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -216,21 +216,25 @@ int nd_region_to_nstype(struct nd_region *nd_region)
 }
 EXPORT_SYMBOL(nd_region_to_nstype);
 
-static ssize_t size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static unsigned long long region_size(struct nd_region *nd_region)
 {
-	struct nd_region *nd_region = to_nd_region(dev);
-	unsigned long long size = 0;
-
-	if (is_memory(dev)) {
-		size = nd_region->ndr_size;
+	if (is_memory(&nd_region->dev)) {
+		return nd_region->ndr_size;
 	} else if (nd_region->ndr_mappings == 1) {
 		struct nd_mapping *nd_mapping = &nd_region->mapping[0];
 
-		size = nd_mapping->size;
+		return nd_mapping->size;
 	}
 
-	return sprintf(buf, "%llu\n", size);
+	return 0;
+}
+
+static ssize_t size_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nd_region *nd_region = to_nd_region(dev);
+
+	return sprintf(buf, "%llu\n", region_size(nd_region));
 }
 static DEVICE_ATTR_RO(size);
 
@@ -529,6 +533,55 @@ static ssize_t read_only_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(read_only);
 
+static ssize_t align_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nd_region *nd_region = to_nd_region(dev);
+
+	return sprintf(buf, "%#lx\n", nd_region->align);
+}
+
+static ssize_t align_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct nd_region *nd_region = to_nd_region(dev);
+	unsigned long val, dpa;
+	u32 remainder;
+	int rc;
+
+	rc = kstrtoul(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	if (!nd_region->ndr_mappings)
+		return -ENXIO;
+
+	/*
+	 * Ensure space-align is evenly divisible by the region
+	 * interleave-width because the kernel typically has no facility
+	 * to determine which DIMM(s), dimm-physical-addresses, would
+	 * contribute to the tail capacity in system-physical-address
+	 * space for the namespace.
+	 */
+	dpa = val;
+	remainder = do_div(dpa, nd_region->ndr_mappings);
+	if (!is_power_of_2(dpa) || dpa < PAGE_SIZE
+			|| val > region_size(nd_region) || remainder)
+		return -EINVAL;
+
+	/*
+	 * Given that space allocation consults this value multiple
+	 * times ensure it does not change for the duration of the
+	 * allocation.
+	 */
+	nvdimm_bus_lock(dev);
+	nd_region->align = val;
+	nvdimm_bus_unlock(dev);
+
+	return len;
+}
+static DEVICE_ATTR_RW(align);
+
 static ssize_t region_badblocks_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -571,6 +624,7 @@ static DEVICE_ATTR_RO(persistence_domain);
 
 static struct attribute *nd_region_attributes[] = {
 	&dev_attr_size.attr,
+	&dev_attr_align.attr,
 	&dev_attr_nstype.attr,
 	&dev_attr_mappings.attr,
 	&dev_attr_btt_seed.attr,
@@ -626,6 +680,19 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 		return a->mode;
 	}
 
+	if (a == &dev_attr_align.attr) {
+		int i;
+
+		for (i = 0; i < nd_region->ndr_mappings; i++) {
+			struct nd_mapping *nd_mapping = &nd_region->mapping[i];
+			struct nvdimm *nvdimm = nd_mapping->nvdimm;
+
+			if (test_bit(NDD_LABELING, &nvdimm->flags))
+				return a->mode;
+		}
+		return 0;
+	}
+
 	if (a != &dev_attr_set_cookie.attr
 			&& a != &dev_attr_available_size.attr)
 		return a->mode;
@@ -935,6 +1002,42 @@ void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 }
 EXPORT_SYMBOL(nd_region_release_lane);
 
+/*
+ * PowerPC requires this alignment for memremap_pages(). All other archs
+ * should be ok with SUBSECTION_SIZE (see memremap_compat_align()).
+ */
+#define MEMREMAP_COMPAT_ALIGN_MAX SZ_16M
+
+static unsigned long default_align(struct nd_region *nd_region)
+{
+	unsigned long align, per_mapping;
+	int i, mappings;
+	u32 remainder;
+
+	if (is_nd_blk(&nd_region->dev))
+		align = PAGE_SIZE;
+	else
+		align = MEMREMAP_COMPAT_ALIGN_MAX;
+
+	for (i = 0; i < nd_region->ndr_mappings; i++) {
+		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
+		struct nvdimm *nvdimm = nd_mapping->nvdimm;
+
+		if (test_bit(NDD_ALIASING, &nvdimm->flags)) {
+			align = MEMREMAP_COMPAT_ALIGN_MAX;
+			break;
+		}
+	}
+
+	mappings = max_t(u16, 1, nd_region->ndr_mappings);
+	per_mapping = align;
+	remainder = do_div(per_mapping, mappings);
+	if (remainder)
+		align *= mappings;
+
+	return align;
+}
+
 static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 		struct nd_region_desc *ndr_desc,
 		const struct device_type *dev_type, const char *caller)
@@ -1039,6 +1142,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	dev->of_node = ndr_desc->of_node;
 	nd_region->ndr_size = resource_size(ndr_desc->res);
 	nd_region->ndr_start = ndr_desc->res->start;
+	nd_region->align = default_align(nd_region);
 	if (ndr_desc->flush)
 		nd_region->flush = ndr_desc->flush;
 	else
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

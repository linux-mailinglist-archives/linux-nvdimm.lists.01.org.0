Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5156117493C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:36:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8F1D10FC340E;
	Sat, 29 Feb 2020 12:37:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B3C5710FC340D
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:37:37 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:45 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="318461574"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:45 -0800
Subject: [ndctl PATCH 07/36] ndctl/region: Support ndctl_region_{get,
 set}_align()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 29 Feb 2020 12:20:40 -0800
Message-ID: <158300764065.2141307.13099616257595468995.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: FI2PKSE46DPXG4UX7FPNO7J4Q2JLY5GN
X-Message-ID-Hash: FI2PKSE46DPXG4UX7FPNO7J4Q2JLY5GN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FI2PKSE46DPXG4UX7FPNO7J4Q2JLY5GN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for the new kernel facility to set space alignment
constraints at the region level. Update the unit tests to bypass the
default 16MiB alignment constraint. Add the new parameter to the default
region listing given how central it is to understanding the valid values
for "create-namespace --size=...".

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/lib/libndctl.c   |   45 +++++++++++++++++++++++++++++++++++++++++++++
 ndctl/lib/libndctl.sym |    2 ++
 ndctl/libndctl.h       |    2 ++
 ndctl/list.c           |   10 +++++++++-
 test/blk_namespaces.c  |    1 +
 test/dpa-alloc.c       |   10 ++++++++--
 test/dsm-fail.c        |    5 ++++-
 test/libndctl.c        |   10 ++++++++--
 test/parent-uuid.c     |    1 +
 9 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 889a83720c0d..d0c1236f0698 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -150,6 +150,7 @@ struct ndctl_region {
 	struct kmod_module *module;
 	struct ndctl_bus *bus;
 	int id, num_mappings, nstype, range_index, ro;
+	unsigned long align;
 	int mappings_init;
 	int namespaces_init;
 	int btts_init;
@@ -1109,6 +1110,44 @@ NDCTL_EXPORT int ndctl_region_set_ro(struct ndctl_region *region, int ro)
 	return ro;
 }
 
+NDCTL_EXPORT unsigned long ndctl_region_get_align(struct ndctl_region *region)
+{
+	return region->align;
+}
+
+/**
+ * ndctl_region_set_align() - Align namespace dpa allocations to @align
+ * @region: region to modify
+ * @align: alignment that must be a power-of-2 and >= the platform minimum
+ *
+ * WARNING: setting the region align value to anything less than the
+ * kernel default (16M) may result in namespaces that are not cross-arch
+ * (PowerPC) compatible. The minimum alignment for raw mode namespaces
+ * is PAGE_SIZE.
+ */
+NDCTL_EXPORT int ndctl_region_set_align(struct ndctl_region *region,
+		unsigned long align)
+{
+	struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
+	char *path = region->region_buf;
+	int len = region->buf_len, rc;
+	char buf[SYSFS_ATTR_SIZE];
+
+	if (snprintf(path, len, "%s/align", region->region_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				ndctl_region_get_devname(region));
+		return -ENXIO;
+	}
+
+	sprintf(buf, "%#lx\n", align);
+	rc = sysfs_write_attr(ctx, path, buf);
+	if (rc < 0)
+		return rc;
+
+	region->align = align;
+	return 0;
+}
+
 NDCTL_EXPORT unsigned long long ndctl_region_get_resource(struct ndctl_region *region)
 {
 	struct ndctl_ctx *ctx = ndctl_region_get_ctx(region);
@@ -2158,6 +2197,12 @@ static void *add_region(void *parent, int id, const char *region_base)
 	else
 		region->target_node = -1;
 
+	sprintf(path, "%s/align", region_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		region->align = strtoul(buf, NULL, 0);
+	else
+		region->align = ULONG_MAX;
+
 	if (region_set_type(region, path) < 0)
 		goto err_read;
 
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index bf049af1393a..ac575a23d035 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -428,4 +428,6 @@ LIBNDCTL_23 {
 	ndctl_namespace_is_configuration_idle;
 	ndctl_namespace_get_target_node;
 	ndctl_region_get_target_node;
+	ndctl_region_get_align;
+	ndctl_region_set_align;
 } LIBNDCTL_22;
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 208240b20aee..076c34583b7d 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -372,6 +372,8 @@ struct ndctl_namespace *ndctl_region_get_namespace_seed(
 		struct ndctl_region *region);
 int ndctl_region_get_ro(struct ndctl_region *region);
 int ndctl_region_set_ro(struct ndctl_region *region, int ro);
+unsigned long ndctl_region_get_align(struct ndctl_region *region);
+int ndctl_region_set_align(struct ndctl_region *region, unsigned long align);
 unsigned long long ndctl_region_get_resource(struct ndctl_region *region);
 struct ndctl_btt *ndctl_region_get_btt_seed(struct ndctl_region *region);
 struct ndctl_pfn *ndctl_region_get_pfn_seed(struct ndctl_region *region);
diff --git a/ndctl/list.c b/ndctl/list.c
index 7d7835247005..aedccfe8fe75 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -78,7 +78,7 @@ static struct json_object *region_to_json(struct ndctl_region *region,
 	struct ndctl_interleave_set *iset;
 	struct ndctl_mapping *mapping;
 	unsigned int bb_count = 0;
-	unsigned long long extent;
+	unsigned long long extent, align;
 	enum ndctl_persistence_domain pd;
 	int numa, target;
 
@@ -95,6 +95,14 @@ static struct json_object *region_to_json(struct ndctl_region *region,
 		goto err;
 	json_object_object_add(jregion, "size", jobj);
 
+	align = ndctl_region_get_align(region);
+	if (align < ULLONG_MAX) {
+		jobj = util_json_object_size(align, flags);
+		if (!jobj)
+			goto err;
+		json_object_object_add(jregion, "align", jobj);
+	}
+
 	jobj = util_json_object_size(ndctl_region_get_available_size(region),
 			flags);
 	if (!jobj)
diff --git a/test/blk_namespaces.c b/test/blk_namespaces.c
index b587ab93fbb8..437fcad0a8f5 100644
--- a/test/blk_namespaces.c
+++ b/test/blk_namespaces.c
@@ -54,6 +54,7 @@ static struct ndctl_namespace *create_blk_namespace(int region_fraction,
 	unsigned long long size;
 	uuid_t uuid;
 
+	ndctl_region_set_align(region, sysconf(_SC_PAGESIZE));
 	ndctl_namespace_foreach(region, ndns)
 		if (ndctl_namespace_get_size(ndns) == 0) {
 			seed_ns = ndns;
diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index 9a9c6b64c504..b757b9ad9c2c 100644
--- a/test/dpa-alloc.c
+++ b/test/dpa-alloc.c
@@ -58,15 +58,21 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER1);
 	if (!bus)
 		return -ENXIO;
-	ndctl_region_foreach(bus, region)
+	ndctl_region_foreach(bus, region) {
 		ndctl_region_disable_invalidate(region);
+		ndctl_region_set_align(region, sysconf(_SC_PAGESIZE)
+				* ndctl_region_get_interleave_ways(region));
+	}
 
 	/* init nfit_test.0 */
 	bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER0);
 	if (!bus)
 		return -ENXIO;
-	ndctl_region_foreach(bus, region)
+	ndctl_region_foreach(bus, region) {
 		ndctl_region_disable_invalidate(region);
+		ndctl_region_set_align(region, sysconf(_SC_PAGESIZE)
+				* ndctl_region_get_interleave_ways(region));
+	}
 
 	ndctl_dimm_foreach(bus, dimm) {
 		rc = ndctl_dimm_zero_labels(dimm);
diff --git a/test/dsm-fail.c b/test/dsm-fail.c
index 6e812aec008f..b2c51db4aa3a 100644
--- a/test/dsm-fail.c
+++ b/test/dsm-fail.c
@@ -48,8 +48,11 @@ static int reset_bus(struct ndctl_bus *bus)
 	}
 
 	/* set regions back to their default state */
-	ndctl_region_foreach(bus, region)
+	ndctl_region_foreach(bus, region) {
 		ndctl_region_enable(region);
+		ndctl_region_set_align(region, sysconf(_SC_PAGESIZE)
+				* ndctl_region_get_interleave_ways(region));
+	}
 	return 0;
 }
 
diff --git a/test/libndctl.c b/test/libndctl.c
index 02bb9ccaa465..9ad8f87b92dc 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -2622,9 +2622,15 @@ static int do_test0(struct ndctl_ctx *ctx, struct ndctl_test *test)
 		}
 	}
 
-	/* set regions back to their default state */
-	ndctl_region_foreach(bus, region)
+	/*
+	 * Enable regions and adjust the space-align to drop the default
+	 * alignment constraints
+	 */
+	ndctl_region_foreach(bus, region) {
 		ndctl_region_enable(region);
+		ndctl_region_set_align(region, sysconf(_SC_PAGESIZE)
+				* ndctl_region_get_interleave_ways(region));
+	}
 
 	/* pfn and dax tests require vmalloc-enabled nfit_test */
 	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 8, 0))) {
diff --git a/test/parent-uuid.c b/test/parent-uuid.c
index 3a63f7244e21..f41ca2c7bd75 100644
--- a/test/parent-uuid.c
+++ b/test/parent-uuid.c
@@ -61,6 +61,7 @@ static struct ndctl_namespace *create_blk_namespace(int region_fraction,
 	struct ndctl_namespace *ndns, *seed_ns = NULL;
 	unsigned long long size;
 
+	ndctl_region_set_align(region, sysconf(_SC_PAGESIZE));
 	ndctl_namespace_foreach(region, ndns)
 		if (ndctl_namespace_get_size(ndns) == 0) {
 			seed_ns = ndns;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

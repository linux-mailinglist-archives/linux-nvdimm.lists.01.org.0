Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86EA174936
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:36:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1BD5B10FC33F3;
	Sat, 29 Feb 2020 12:37:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0887D10FC33EF
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:37:06 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:14 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="227910358"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:14 -0800
Subject: [ndctl PATCH 01/36] ndctl/list: Add 'target_node' to region and
 namespace verbose listings
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 29 Feb 2020 12:20:09 -0800
Message-ID: <158300760991.2141307.10325510336768323052.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: G4YXMIF5BNHQ5LKQGLVGVZACH5C4ZOG3
X-Message-ID-Hash: G4YXMIF5BNHQ5LKQGLVGVZACH5C4ZOG3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G4YXMIF5BNHQ5LKQGLVGVZACH5C4ZOG3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Historically the 'numa_node' attribute of a device has been the local,
or closest cpu numa node that can access the device. With the ACPI HMAT
and other platform descriptions of performance differentiated memory,
memory device targets may have their own numa identifier. The
target_node property indicates that target information and the effective
online numa node the memory range would receive if it were onlined.

While this property has been available to device-dax instances since
kernel commit 21c75763a3ae "device-dax: Add a 'target_node' attribute",
recent kernels have also started exporting for regions and namespaces.
Add it to the verbose listing.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/lib/libndctl.c   |   25 ++++++++++++++++++++++++-
 ndctl/lib/libndctl.sym |    2 ++
 ndctl/lib/private.h    |    3 ++-
 ndctl/libndctl.h       |    2 ++
 ndctl/list.c           |    9 ++++++++-
 util/json.c            |    9 ++++++++-
 6 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 2d23dbb3caf7..889a83720c0d 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -135,6 +135,7 @@ struct ndctl_mapping {
  * @generation: incremented everytime the region is disabled
  * @nstype: the resulting type of namespace this region produces
  * @numa_node: numa node attribute
+ * @target_node: target node were this region to be onlined
  *
  * A region may alias between pmem and block-window access methods.  The
  * region driver is tasked with parsing the label (if their is one) and
@@ -160,7 +161,7 @@ struct ndctl_region {
 	char *region_buf;
 	int buf_len;
 	int generation;
-	int numa_node;
+	int numa_node, target_node;
 	struct list_head btts;
 	struct list_head pfns;
 	struct list_head daxs;
@@ -2151,6 +2152,12 @@ static void *add_region(void *parent, int id, const char *region_base)
 	else
 		region->numa_node = -1;
 
+	sprintf(path, "%s/target_node", region_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		region->target_node = strtol(buf, NULL, 0);
+	else
+		region->target_node = -1;
+
 	if (region_set_type(region, path) < 0)
 		goto err_read;
 
@@ -2424,6 +2431,11 @@ NDCTL_EXPORT int ndctl_region_get_numa_node(struct ndctl_region *region)
 	return region->numa_node;
 }
 
+NDCTL_EXPORT int ndctl_region_get_target_node(struct ndctl_region *region)
+{
+	return region->target_node;
+}
+
 NDCTL_EXPORT struct badblock *ndctl_region_get_next_badblock(struct ndctl_region *region)
 {
 	return badblocks_iter_next(&region->bb_iter);
@@ -3477,6 +3489,12 @@ static void *add_namespace(void *parent, int id, const char *ndns_base)
 	else
 		ndns->numa_node = -1;
 
+	sprintf(path, "%s/target_node", ndns_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		ndns->target_node = strtol(buf, NULL, 0);
+	else
+		ndns->target_node = -1;
+
 	sprintf(path, "%s/holder_class", ndns_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		ndns->enforce_mode = enforce_name_to_id(buf);
@@ -4398,6 +4416,11 @@ NDCTL_EXPORT int ndctl_namespace_get_numa_node(struct ndctl_namespace *ndns)
     return ndns->numa_node;
 }
 
+NDCTL_EXPORT int ndctl_namespace_get_target_node(struct ndctl_namespace *ndns)
+{
+	return ndns->target_node;
+}
+
 static int __ndctl_namespace_set_write_cache(struct ndctl_namespace *ndns,
 		int state)
 {
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index 4e767789dfe1..bf049af1393a 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -426,4 +426,6 @@ LIBNDCTL_22 {
 
 LIBNDCTL_23 {
 	ndctl_namespace_is_configuration_idle;
+	ndctl_namespace_get_target_node;
+	ndctl_region_get_target_node;
 } LIBNDCTL_22;
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 2b8fee2d9e5a..16bf8f953828 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -201,6 +201,7 @@ struct badblocks_iter {
  * @bdev: associated block_device of a namespace
  * @size: unsigned
  * @numa_node: numa node attribute
+ * @target_node: target node were this region to be onlined
  *
  * A 'namespace' is the resulting device after region-aliasing and
  * label-parsing is resolved.
@@ -220,7 +221,7 @@ struct ndctl_namespace {
 	char *alt_name;
 	uuid_t uuid;
 	struct ndctl_lbasize lbasize;
-	int numa_node;
+	int numa_node, target_node;
 	struct list_head injected_bb;
 };
 
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 9a53049e7f61..208240b20aee 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -383,6 +383,7 @@ struct ndctl_dimm *ndctl_region_get_first_dimm(struct ndctl_region *region);
 struct ndctl_dimm *ndctl_region_get_next_dimm(struct ndctl_region *region,
 		struct ndctl_dimm *dimm);
 int ndctl_region_get_numa_node(struct ndctl_region *region);
+int ndctl_region_get_target_node(struct ndctl_region *region);
 struct ndctl_region *ndctl_bus_get_region_by_physical_address(struct ndctl_bus *bus,
 		unsigned long long address);
 #define ndctl_dimm_foreach_in_region(region, dimm) \
@@ -511,6 +512,7 @@ int ndctl_namespace_set_sector_size(struct ndctl_namespace *ndns,
 int ndctl_namespace_get_raw_mode(struct ndctl_namespace *ndns);
 int ndctl_namespace_set_raw_mode(struct ndctl_namespace *ndns, int raw_mode);
 int ndctl_namespace_get_numa_node(struct ndctl_namespace *ndns);
+int ndctl_namespace_get_target_node(struct ndctl_namespace *ndns);
 int ndctl_namespace_inject_error(struct ndctl_namespace *ndns,
 		unsigned long long block, unsigned long long count,
 		bool notify);
diff --git a/ndctl/list.c b/ndctl/list.c
index 8f3e9ad4efd6..86ffbcfe8560 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -80,7 +80,7 @@ static struct json_object *region_to_json(struct ndctl_region *region,
 	unsigned int bb_count = 0;
 	unsigned long long extent;
 	enum ndctl_persistence_domain pd;
-	int numa;
+	int numa, target;
 
 	if (!jregion)
 		return NULL;
@@ -130,6 +130,13 @@ static struct json_object *region_to_json(struct ndctl_region *region,
 			json_object_object_add(jregion, "numa_node", jobj);
 	}
 
+	target = ndctl_region_get_target_node(region);
+	if (target >= 0 && flags & UTIL_JSON_VERBOSE) {
+		jobj = json_object_new_int(target);
+		if (jobj)
+			json_object_object_add(jregion, "target_node", jobj);
+	}
+
 	iset = ndctl_region_get_interleave_set(region);
 	if (iset) {
 		jobj = util_json_object_hex(
diff --git a/util/json.c b/util/json.c
index 497c52ba1a00..0abaf3a5b9c2 100644
--- a/util/json.c
+++ b/util/json.c
@@ -912,7 +912,7 @@ struct json_object *util_namespace_to_json(struct ndctl_namespace *ndns,
 	unsigned long align = 0;
 	char buf[40];
 	uuid_t uuid;
-	int numa;
+	int numa, target;
 
 	if (!jndns)
 		return NULL;
@@ -1092,6 +1092,13 @@ struct json_object *util_namespace_to_json(struct ndctl_namespace *ndns,
 			json_object_object_add(jndns, "numa_node", jobj);
 	}
 
+	target = ndctl_namespace_get_target_node(ndns);
+	if (target >= 0 && flags & UTIL_JSON_VERBOSE) {
+		jobj = json_object_new_int(target);
+		if (jobj)
+			json_object_object_add(jndns, "target_node", jobj);
+	}
+
 	if (pfn)
 		jbbs = util_pfn_badblocks_to_json(pfn, &bb_count, flags);
 	else if (dax)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

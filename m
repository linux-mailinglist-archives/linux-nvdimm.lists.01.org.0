Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A316777C32
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:55:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F1A80212E46F0;
	Sat, 27 Jul 2019 14:57:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 85C9F212E25B5
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:57:47 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:20 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="346216792"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:20 -0700
Subject: [ndctl PATCH v2 19/26] ndctl/namespace: Kill off the legacy mode names
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:41:03 -0700
Message-ID: <156426366309.531577.11554918086632763562.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The command line interface switched to "fsdax", "devdax", and "sector"
for the mode names. Kill off the remaining instances of "memory", "dax",
and "safe".

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/lib/libndctl.c |    4 ++-
 ndctl/libndctl.h     |    1 +
 ndctl/namespace.c    |   66 +++++++++++++++++++++++++-------------------------
 test/libndctl.c      |    6 ++---
 util/filter.c        |    4 ++-
 util/json.c          |    4 ++-
 6 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index c1ecdd8c9c61..e81d64dc8aa8 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -3405,7 +3405,7 @@ static const char *enforce_id_to_name(enum ndctl_namespace_mode mode)
 {
 	static const char *id_to_name[] = {
 		[NDCTL_NS_MODE_MEMORY] = "pfn",
-		[NDCTL_NS_MODE_SAFE] = "btt", /* TODO: convert to btt2 */
+		[NDCTL_NS_MODE_SECTOR] = "btt", /* TODO: convert to btt2 */
 		[NDCTL_NS_MODE_RAW] = "",
 		[NDCTL_NS_MODE_DAX] = "dax",
 		[NDCTL_NS_MODE_UNKNOWN] = "<unknown>",
@@ -3728,7 +3728,7 @@ NDCTL_EXPORT enum ndctl_namespace_mode ndctl_namespace_get_mode(
 	if (strcmp("raw", buf) == 0)
 		return NDCTL_NS_MODE_RAW;
 	if (strcmp("safe", buf) == 0)
-		return NDCTL_NS_MODE_SAFE;
+		return NDCTL_NS_MODE_SECTOR;
 	return -ENXIO;
 }
 
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index c9d0dc120d3b..f3f2ef66c5a8 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -472,6 +472,7 @@ enum ndctl_namespace_mode {
 	NDCTL_NS_MODE_MEMORY,
 	NDCTL_NS_MODE_FSDAX = NDCTL_NS_MODE_MEMORY,
 	NDCTL_NS_MODE_SAFE,
+	NDCTL_NS_MODE_SECTOR = NDCTL_NS_MODE_SAFE,
 	NDCTL_NS_MODE_RAW,
 	NDCTL_NS_MODE_DAX,
 	NDCTL_NS_MODE_DEVDAX = NDCTL_NS_MODE_DAX,
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index e5a2b1341cdb..f958726a994d 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -225,9 +225,9 @@ static int set_defaults(enum device_action mode)
 		}
 	} else if (!param.reconfig && param.type) {
 		if (strcmp(param.type, "pmem") == 0)
-			param.mode = "memory";
+			param.mode = "fsdax";
 		else
-			param.mode = "safe";
+			param.mode = "sector";
 		param.mode_default = true;
 	}
 
@@ -242,9 +242,9 @@ static int set_defaults(enum device_action mode)
 		}
 
 		if (!param.reconfig && param.mode
-				&& strcmp(param.mode, "memory") != 0
-				&& strcmp(param.mode, "dax") != 0) {
-			error("--map only valid for an dax mode pmem namespace\n");
+				&& strcmp(param.mode, "fsdax") != 0
+				&& strcmp(param.mode, "devdax") != 0) {
+			error("--map only valid for an devdax mode pmem namespace\n");
 			rc = -EINVAL;
 		}
 	} else if (!param.reconfig)
@@ -252,8 +252,8 @@ static int set_defaults(enum device_action mode)
 
 	/* check for incompatible mode and type combinations */
 	if (param.type && param.mode && strcmp(param.type, "blk") == 0
-			&& (strcmp(param.mode, "memory") == 0
-				|| strcmp(param.mode, "dax") == 0)) {
+			&& (strcmp(param.mode, "fsdax") == 0
+				|| strcmp(param.mode, "devdax") == 0)) {
 		error("only 'pmem' namespaces support dax operation\n");
 		rc = -ENXIO;
 	}
@@ -377,7 +377,7 @@ do { \
 static bool do_setup_pfn(struct ndctl_namespace *ndns,
 		struct parsed_parameters *p)
 {
-	if (p->mode != NDCTL_NS_MODE_MEMORY)
+	if (p->mode != NDCTL_NS_MODE_FSDAX)
 		return false;
 
 	/*
@@ -385,7 +385,7 @@ static bool do_setup_pfn(struct ndctl_namespace *ndns,
 	 * instance, and a pfn device is required to place the memmap
 	 * array in device memory.
 	 */
-	if (!ndns || ndctl_namespace_get_mode(ndns) != NDCTL_NS_MODE_MEMORY
+	if (!ndns || ndctl_namespace_get_mode(ndns) != NDCTL_NS_MODE_FSDAX
 			|| p->loc == NDCTL_PFN_LOC_PMEM)
 		return true;
 
@@ -419,7 +419,7 @@ static int setup_namespace(struct ndctl_region *region,
 		if (i < num)
 			try(ndctl_namespace, set_sector_size, ndns,
 					p->sector_size);
-		else if (p->mode == NDCTL_NS_MODE_SAFE)
+		else if (p->mode == NDCTL_NS_MODE_SECTOR)
 			/* pass, the btt sector_size will override */;
 		else if (p->sector_size != 512) {
 			error("%s: sector_size: %ld not supported\n",
@@ -450,7 +450,7 @@ static int setup_namespace(struct ndctl_region *region,
 		rc = ndctl_pfn_enable(pfn);
 		if (rc && p->autorecover)
 			ndctl_pfn_set_namespace(pfn, NULL);
-	} else if (p->mode == NDCTL_NS_MODE_DAX) {
+	} else if (p->mode == NDCTL_NS_MODE_DEVDAX) {
 		struct ndctl_dax *dax = ndctl_region_get_dax_seed(region);
 
 		try(ndctl_dax, set_uuid, dax, uuid);
@@ -461,7 +461,7 @@ static int setup_namespace(struct ndctl_region *region,
 		rc = ndctl_dax_enable(dax);
 		if (rc && p->autorecover)
 			ndctl_dax_set_namespace(dax, NULL);
-	} else if (p->mode == NDCTL_NS_MODE_SAFE) {
+	} else if (p->mode == NDCTL_NS_MODE_SECTOR) {
 		struct ndctl_btt *btt = ndctl_region_get_btt_seed(region);
 
 		/*
@@ -560,28 +560,28 @@ static int validate_namespace_options(struct ndctl_region *region,
 
 	if (param.mode) {
 		if (strcmp(param.mode, "memory") == 0)
-			p->mode = NDCTL_NS_MODE_MEMORY;
+			p->mode = NDCTL_NS_MODE_FSDAX;
 		else if (strcmp(param.mode, "sector") == 0)
-			p->mode = NDCTL_NS_MODE_SAFE;
+			p->mode = NDCTL_NS_MODE_SECTOR;
 		else if (strcmp(param.mode, "safe") == 0)
-			p->mode = NDCTL_NS_MODE_SAFE;
+			p->mode = NDCTL_NS_MODE_SECTOR;
 		else if (strcmp(param.mode, "dax") == 0)
-			p->mode = NDCTL_NS_MODE_DAX;
+			p->mode = NDCTL_NS_MODE_DEVDAX;
 		else
 			p->mode = NDCTL_NS_MODE_RAW;
 
 		if (ndctl_region_get_type(region) != ND_DEVICE_REGION_PMEM
-				&& (p->mode == NDCTL_NS_MODE_MEMORY
-					|| p->mode == NDCTL_NS_MODE_DAX)) {
+				&& (p->mode == NDCTL_NS_MODE_FSDAX
+					|| p->mode == NDCTL_NS_MODE_DEVDAX)) {
 			debug("blk %s does not support %s mode\n", region_name,
-					p->mode == NDCTL_NS_MODE_MEMORY
+					p->mode == NDCTL_NS_MODE_FSDAX
 					? "fsdax" : "devdax");
 			return -EAGAIN;
 		}
 	} else if (ndns)
 		p->mode = ndctl_namespace_get_mode(ndns);
 
-	if (p->mode == NDCTL_NS_MODE_MEMORY) {
+	if (p->mode == NDCTL_NS_MODE_FSDAX) {
 		pfn = ndctl_region_get_pfn_seed(region);
 		if (!pfn && param.mode_default) {
 			debug("%s fsdax mode not available\n", region_name);
@@ -590,7 +590,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		/*
 		 * NB: We only fail validation if a pfn-specific option is used
 		 */
-	} else if (p->mode == NDCTL_NS_MODE_DAX) {
+	} else if (p->mode == NDCTL_NS_MODE_DEVDAX) {
 		dax = ndctl_region_get_dax_seed(region);
 		if (!dax) {
 			error("Kernel does not support devdax mode\n");
@@ -602,7 +602,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		int i, alignments;
 
 		switch (p->mode) {
-		case NDCTL_NS_MODE_MEMORY:
+		case NDCTL_NS_MODE_FSDAX:
 			if (!pfn) {
 				error("Kernel does not support setting an alignment in fsdax mode\n");
 				return -EINVAL;
@@ -611,13 +611,13 @@ static int validate_namespace_options(struct ndctl_region *region,
 			alignments = ndctl_pfn_get_num_alignments(pfn);
 			break;
 
-		case NDCTL_NS_MODE_DAX:
+		case NDCTL_NS_MODE_DEVDAX:
 			alignments = ndctl_dax_get_num_alignments(dax);
 			break;
 
 		default:
 			error("%s mode does not support setting an alignment\n",
-					p->mode == NDCTL_NS_MODE_SAFE
+					p->mode == NDCTL_NS_MODE_SECTOR
 					? "sector" : "raw");
 			return -ENXIO;
 		}
@@ -626,7 +626,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		for (i = 0; i < alignments; i++) {
 			uint64_t a;
 
-			if (p->mode == NDCTL_NS_MODE_MEMORY)
+			if (p->mode == NDCTL_NS_MODE_FSDAX)
 				a = ndctl_pfn_get_supported_alignment(pfn, i);
 			else
 				a = ndctl_dax_get_supported_alignment(dax, i);
@@ -645,7 +645,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		 * one. If we don't then use PAGE_SIZE so the size_align
 		 * checking works.
 		 */
-		if (p->mode == NDCTL_NS_MODE_MEMORY) {
+		if (p->mode == NDCTL_NS_MODE_FSDAX) {
 			/*
 			 * The initial pfn device support in the kernel didn't
 			 * have the 'align' sysfs attribute and assumed a 2MB
@@ -656,7 +656,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 				p->align = ndctl_pfn_get_align(pfn);
 			else
 				p->align = SZ_2M;
-		} else if (p->mode == NDCTL_NS_MODE_DAX) {
+		} else if (p->mode == NDCTL_NS_MODE_DEVDAX) {
 			/*
 			 * device dax mode was added after the align attribute
 			 * so checking for it is unnecessary.
@@ -717,7 +717,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 
 		p->sector_size = parse_size64(param.sector_size);
 		btt = ndctl_region_get_btt_seed(region);
-		if (p->mode == NDCTL_NS_MODE_SAFE) {
+		if (p->mode == NDCTL_NS_MODE_SECTOR) {
 			if (!btt) {
 				debug("%s: does not support 'sector' mode\n",
 						region_name);
@@ -757,7 +757,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		 * sector size, otherwise fall back to what the
 		 * namespace supports.
 		 */
-		if (btt && p->mode == NDCTL_NS_MODE_SAFE)
+		if (btt && p->mode == NDCTL_NS_MODE_SECTOR)
 			p->sector_size = ndctl_btt_get_sector_size(btt);
 		else
 			p->sector_size = ndctl_namespace_get_sector_size(ndns);
@@ -784,14 +784,14 @@ static int validate_namespace_options(struct ndctl_region *region,
 		else
 			p->loc = NDCTL_PFN_LOC_PMEM;
 
-		if (ndns && p->mode != NDCTL_NS_MODE_MEMORY
-			&& p->mode != NDCTL_NS_MODE_DAX) {
+		if (ndns && p->mode != NDCTL_NS_MODE_FSDAX
+			&& p->mode != NDCTL_NS_MODE_DEVDAX) {
 			debug("%s: --map= only valid for fsdax mode namespace\n",
 				ndctl_namespace_get_devname(ndns));
 			return -EINVAL;
 		}
-	} else if (p->mode == NDCTL_NS_MODE_MEMORY
-			|| p->mode == NDCTL_NS_MODE_DAX)
+	} else if (p->mode == NDCTL_NS_MODE_FSDAX
+			|| p->mode == NDCTL_NS_MODE_DEVDAX)
 		p->loc = NDCTL_PFN_LOC_PMEM;
 
 	if (!pfn && do_setup_pfn(ndns, p)) {
diff --git a/test/libndctl.c b/test/libndctl.c
index 02bb9ccaa465..daddbf919b79 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -1080,7 +1080,7 @@ static int check_btt_create(struct ndctl_region *region, struct ndctl_namespace
 		devname = ndctl_btt_get_devname(btt);
 		ndctl_btt_set_uuid(btt, btt_s->uuid);
 		ndctl_btt_set_sector_size(btt, btt_s->sector_sizes[i]);
-		rc = ndctl_namespace_set_enforce_mode(ndns, NDCTL_NS_MODE_SAFE);
+		rc = ndctl_namespace_set_enforce_mode(ndns, NDCTL_NS_MODE_SECTOR);
 		if (ndctl_test_attempt(test, KERNEL_VERSION(4, 13, 0)) && rc < 0) {
 			fprintf(stderr, "%s: failed to enforce btt mode\n", devname);
 			goto err;
@@ -1100,7 +1100,7 @@ static int check_btt_create(struct ndctl_region *region, struct ndctl_namespace
 		/* prior to v4.5 the mode attribute did not exist */
 		if (ndctl_test_attempt(test, KERNEL_VERSION(4, 5, 0))) {
 			mode = ndctl_namespace_get_mode(ndns);
-			if (mode >= 0 && mode != NDCTL_NS_MODE_SAFE)
+			if (mode >= 0 && mode != NDCTL_NS_MODE_SECTOR)
 				fprintf(stderr, "%s: expected safe mode got: %d\n",
 						devname, mode);
 		}
@@ -1474,7 +1474,7 @@ static int check_btt_autodetect(struct ndctl_bus *bus,
 
 	mode = ndctl_namespace_get_enforce_mode(ndns);
 	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 13, 0))
-			&& mode != NDCTL_NS_MODE_SAFE) {
+			&& mode != NDCTL_NS_MODE_SECTOR) {
 		fprintf(stderr, "%s expected enforce_mode btt\n", devname);
 		return -ENXIO;
 	}
diff --git a/util/filter.c b/util/filter.c
index 1734bce537f1..ce6239fbac3b 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -345,9 +345,9 @@ static enum ndctl_namespace_mode mode_to_type(const char *mode)
 	else if (strcasecmp(mode, "fsdax") == 0)
 		return NDCTL_NS_MODE_MEMORY;
 	else if (strcasecmp(mode, "sector") == 0)
-		return NDCTL_NS_MODE_SAFE;
+		return NDCTL_NS_MODE_SECTOR;
 	else if (strcasecmp(mode, "safe") == 0)
-		return NDCTL_NS_MODE_SAFE;
+		return NDCTL_NS_MODE_SECTOR;
 	else if (strcasecmp(mode, "dax") == 0)
 		return NDCTL_NS_MODE_DAX;
 	else if (strcasecmp(mode, "devdax") == 0)
diff --git a/util/json.c b/util/json.c
index babdc8c47565..3e171e7672ae 100644
--- a/util/json.c
+++ b/util/json.c
@@ -904,7 +904,7 @@ struct json_object *util_namespace_to_json(struct ndctl_namespace *ndns,
 		jobj = json_object_new_string("devdax");
 		loc = ndctl_dax_get_location(dax);
 		break;
-	case NDCTL_NS_MODE_SAFE:
+	case NDCTL_NS_MODE_SECTOR:
 		if (!btt)
 			goto err;
 		jobj = json_object_new_string("sector");
@@ -920,7 +920,7 @@ struct json_object *util_namespace_to_json(struct ndctl_namespace *ndns,
 	if (jobj)
 		json_object_object_add(jndns, "mode", jobj);
 
-	if ((mode != NDCTL_NS_MODE_SAFE) && (mode != NDCTL_NS_MODE_RAW)) {
+	if ((mode != NDCTL_NS_MODE_SECTOR) && (mode != NDCTL_NS_MODE_RAW)) {
 		jobj = json_object_new_string(locations[loc]);
 		if (jobj)
 			json_object_object_add(jndns, "map", jobj);

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

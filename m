Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 943D917494D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:37:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E95BE10FC341A;
	Sat, 29 Feb 2020 12:38:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2809510FC341A
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:38:42 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:49 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="385829617"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:50 -0800
Subject: [ndctl PATCH 19/36] ndctl/namespace: Kill off the legacy mode names
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:21:45 -0800
Message-ID: <158300770529.2141307.5753780055294698645.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 7VCG72MZ3I2PB4UWLHJZCT72IZG7GVML
X-Message-ID-Hash: 7VCG72MZ3I2PB4UWLHJZCT72IZG7GVML
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7VCG72MZ3I2PB4UWLHJZCT72IZG7GVML/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
index d0c1236f0698..9ad1b7091dc0 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -3465,7 +3465,7 @@ static const char *enforce_id_to_name(enum ndctl_namespace_mode mode)
 {
 	static const char *id_to_name[] = {
 		[NDCTL_NS_MODE_MEMORY] = "pfn",
-		[NDCTL_NS_MODE_SAFE] = "btt", /* TODO: convert to btt2 */
+		[NDCTL_NS_MODE_SECTOR] = "btt", /* TODO: convert to btt2 */
 		[NDCTL_NS_MODE_RAW] = "",
 		[NDCTL_NS_MODE_DAX] = "dax",
 		[NDCTL_NS_MODE_UNKNOWN] = "<unknown>",
@@ -3794,7 +3794,7 @@ NDCTL_EXPORT enum ndctl_namespace_mode ndctl_namespace_get_mode(
 	if (strcmp("raw", buf) == 0)
 		return NDCTL_NS_MODE_RAW;
 	if (strcmp("safe", buf) == 0)
-		return NDCTL_NS_MODE_SAFE;
+		return NDCTL_NS_MODE_SECTOR;
 	return -ENXIO;
 }
 
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 076c34583b7d..2580f433ade8 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -475,6 +475,7 @@ enum ndctl_namespace_mode {
 	NDCTL_NS_MODE_MEMORY,
 	NDCTL_NS_MODE_FSDAX = NDCTL_NS_MODE_MEMORY,
 	NDCTL_NS_MODE_SAFE,
+	NDCTL_NS_MODE_SECTOR = NDCTL_NS_MODE_SAFE,
 	NDCTL_NS_MODE_RAW,
 	NDCTL_NS_MODE_DAX,
 	NDCTL_NS_MODE_DEVDAX = NDCTL_NS_MODE_DAX,
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index cd75038f5ae3..770caa5ebab0 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -234,9 +234,9 @@ static int set_defaults(enum device_action mode)
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
 
@@ -251,9 +251,9 @@ static int set_defaults(enum device_action mode)
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
@@ -261,8 +261,8 @@ static int set_defaults(enum device_action mode)
 
 	/* check for incompatible mode and type combinations */
 	if (param.type && param.mode && strcmp(param.type, "blk") == 0
-			&& (strcmp(param.mode, "memory") == 0
-				|| strcmp(param.mode, "dax") == 0)) {
+			&& (strcmp(param.mode, "fsdax") == 0
+				|| strcmp(param.mode, "devdax") == 0)) {
 		error("only 'pmem' namespaces support dax operation\n");
 		rc = -ENXIO;
 	}
@@ -386,7 +386,7 @@ do { \
 static bool do_setup_pfn(struct ndctl_namespace *ndns,
 		struct parsed_parameters *p)
 {
-	if (p->mode != NDCTL_NS_MODE_MEMORY)
+	if (p->mode != NDCTL_NS_MODE_FSDAX)
 		return false;
 
 	/*
@@ -394,7 +394,7 @@ static bool do_setup_pfn(struct ndctl_namespace *ndns,
 	 * instance, and a pfn device is required to place the memmap
 	 * array in device memory.
 	 */
-	if (!ndns || ndctl_namespace_get_mode(ndns) != NDCTL_NS_MODE_MEMORY
+	if (!ndns || ndctl_namespace_get_mode(ndns) != NDCTL_NS_MODE_FSDAX
 			|| p->loc == NDCTL_PFN_LOC_PMEM)
 		return true;
 
@@ -446,7 +446,7 @@ static int setup_namespace(struct ndctl_region *region,
 		if (i < num)
 			try(ndctl_namespace, set_sector_size, ndns,
 					p->sector_size);
-		else if (p->mode == NDCTL_NS_MODE_SAFE)
+		else if (p->mode == NDCTL_NS_MODE_SECTOR)
 			/* pass, the btt sector_size will override */;
 		else if (p->sector_size != 512) {
 			error("%s: sector_size: %ld not supported\n",
@@ -480,7 +480,7 @@ static int setup_namespace(struct ndctl_region *region,
 		rc = ndctl_pfn_enable(pfn);
 		if (rc && p->autorecover)
 			ndctl_pfn_set_namespace(pfn, NULL);
-	} else if (p->mode == NDCTL_NS_MODE_DAX) {
+	} else if (p->mode == NDCTL_NS_MODE_DEVDAX) {
 		struct ndctl_dax *dax = ndctl_region_get_dax_seed(region);
 
 		rc = check_dax_align(ndns);
@@ -494,7 +494,7 @@ static int setup_namespace(struct ndctl_region *region,
 		rc = ndctl_dax_enable(dax);
 		if (rc && p->autorecover)
 			ndctl_dax_set_namespace(dax, NULL);
-	} else if (p->mode == NDCTL_NS_MODE_SAFE) {
+	} else if (p->mode == NDCTL_NS_MODE_SECTOR) {
 		struct ndctl_btt *btt = ndctl_region_get_btt_seed(region);
 
 		/*
@@ -586,28 +586,28 @@ static int validate_namespace_options(struct ndctl_region *region,
 
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
 			err("blk %s does not support %s mode\n", region_name,
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
 			err("%s fsdax mode not available\n", region_name);
@@ -616,7 +616,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		/*
 		 * NB: We only fail validation if a pfn-specific option is used
 		 */
-	} else if (p->mode == NDCTL_NS_MODE_DAX) {
+	} else if (p->mode == NDCTL_NS_MODE_DEVDAX) {
 		dax = ndctl_region_get_dax_seed(region);
 		if (!dax) {
 			error("Kernel does not support devdax mode\n");
@@ -628,7 +628,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		int i, alignments;
 
 		switch (p->mode) {
-		case NDCTL_NS_MODE_MEMORY:
+		case NDCTL_NS_MODE_FSDAX:
 			if (!pfn) {
 				error("Kernel does not support setting an alignment in fsdax mode\n");
 				return -EINVAL;
@@ -637,13 +637,13 @@ static int validate_namespace_options(struct ndctl_region *region,
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
@@ -652,7 +652,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		for (i = 0; i < alignments; i++) {
 			uint64_t a;
 
-			if (p->mode == NDCTL_NS_MODE_MEMORY)
+			if (p->mode == NDCTL_NS_MODE_FSDAX)
 				a = ndctl_pfn_get_supported_alignment(pfn, i);
 			else
 				a = ndctl_dax_get_supported_alignment(dax, i);
@@ -687,7 +687,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		 * one. If we don't then use PAGE_SIZE so the size_align
 		 * checking works.
 		 */
-		if (p->mode == NDCTL_NS_MODE_MEMORY) {
+		if (p->mode == NDCTL_NS_MODE_FSDAX) {
 			/*
 			 * The initial pfn device support in the kernel didn't
 			 * have the 'align' sysfs attribute and assumed a 2MB
@@ -698,7 +698,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 				p->align = ndctl_pfn_get_align(pfn);
 			else
 				p->align = SZ_2M;
-		} else if (p->mode == NDCTL_NS_MODE_DAX) {
+		} else if (p->mode == NDCTL_NS_MODE_DEVDAX) {
 			/*
 			 * device dax mode was added after the align attribute
 			 * so checking for it is unnecessary.
@@ -767,7 +767,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 
 		p->sector_size = parse_size64(param.sector_size);
 		btt = ndctl_region_get_btt_seed(region);
-		if (p->mode == NDCTL_NS_MODE_SAFE) {
+		if (p->mode == NDCTL_NS_MODE_SECTOR) {
 			if (!btt) {
 				err("%s: does not support 'sector' mode\n",
 						region_name);
@@ -807,7 +807,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 		 * sector size, otherwise fall back to what the
 		 * namespace supports.
 		 */
-		if (btt && p->mode == NDCTL_NS_MODE_SAFE)
+		if (btt && p->mode == NDCTL_NS_MODE_SECTOR)
 			p->sector_size = ndctl_btt_get_sector_size(btt);
 		else
 			p->sector_size = ndctl_namespace_get_sector_size(ndns);
@@ -834,14 +834,14 @@ static int validate_namespace_options(struct ndctl_region *region,
 		else
 			p->loc = NDCTL_PFN_LOC_PMEM;
 
-		if (ndns && p->mode != NDCTL_NS_MODE_MEMORY
-			&& p->mode != NDCTL_NS_MODE_DAX) {
+		if (ndns && p->mode != NDCTL_NS_MODE_FSDAX
+			&& p->mode != NDCTL_NS_MODE_DEVDAX) {
 			err("%s: --map= only valid for fsdax mode namespace\n",
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
index 9ad8f87b92dc..994e0fadf4f7 100644
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
index 877d6c74ff18..9f6b65a70117 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -361,9 +361,9 @@ static enum ndctl_namespace_mode mode_to_type(const char *mode)
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
index 6745bcc19058..50346c5bcbab 100644
--- a/util/json.c
+++ b/util/json.c
@@ -944,7 +944,7 @@ struct json_object *util_namespace_to_json(struct ndctl_namespace *ndns,
 		jobj = json_object_new_string("devdax");
 		loc = ndctl_dax_get_location(dax);
 		break;
-	case NDCTL_NS_MODE_SAFE:
+	case NDCTL_NS_MODE_SECTOR:
 		if (!btt)
 			goto err;
 		jobj = json_object_new_string("sector");
@@ -960,7 +960,7 @@ struct json_object *util_namespace_to_json(struct ndctl_namespace *ndns,
 	if (jobj)
 		json_object_object_add(jndns, "mode", jobj);
 
-	if ((mode != NDCTL_NS_MODE_SAFE) && (mode != NDCTL_NS_MODE_RAW)) {
+	if ((mode != NDCTL_NS_MODE_SECTOR) && (mode != NDCTL_NS_MODE_RAW)) {
 		jobj = json_object_new_string(locations[loc]);
 		if (jobj)
 			json_object_object_add(jndns, "map", jobj);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

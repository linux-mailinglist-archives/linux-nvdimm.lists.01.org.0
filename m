Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B5D77C33
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:55:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 463AD212E25B5;
	Sat, 27 Jul 2019 14:57:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4E39D212E259E
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:57:52 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:25 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="322416440"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:25 -0700
Subject: [ndctl PATCH v2 20/26] ndctl/namespace: Introduce mode-to-name and
 name-to-mode helpers
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:41:08 -0700
Message-ID: <156426366820.531577.12558755097769166345.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Before open coding yet another translation between modes and their text
name, introduce a util_nsmode() and util_nsmode_name() helpers.

Consolidate the existing mode_to_type() helper into the new common /
public util.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   39 +++++++--------------------------------
 util/filter.c     |   42 +++++++++++++++++++++++++++---------------
 util/filter.h     |    3 +++
 3 files changed, 37 insertions(+), 47 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index f958726a994d..43a5fccac491 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -205,21 +205,7 @@ static int set_defaults(enum device_action mode)
 		param.type = "pmem";
 
 	if (param.mode) {
-		if (strcmp(param.mode, "safe") == 0)
-			/* pass */;
-		else if (strcmp(param.mode, "sector") == 0)
-		      param.mode = "safe"; /* pass */
-		else if (strcmp(param.mode, "memory") == 0)
-		      /* pass */;
-		else if (strcmp(param.mode, "fsdax") == 0)
-			param.mode = "memory"; /* pass */
-		else if (strcmp(param.mode, "raw") == 0)
-		      /* pass */;
-		else if (strcmp(param.mode, "dax") == 0)
-		      /* pass */;
-		else if (strcmp(param.mode, "devdax") == 0)
-			param.mode = "dax"; /* pass */
-		else {
+		if (util_nsmode(param.mode) == NDCTL_NS_MODE_UNKNOWN) {
 			error("invalid mode '%s'\n", param.mode);
 			rc = -EINVAL;
 		}
@@ -285,7 +271,7 @@ static int set_defaults(enum device_action mode)
 			rc = -EINVAL;
 		}
 	} else if (((param.type && strcmp(param.type, "blk") == 0)
-			|| (param.mode && strcmp(param.mode, "safe") == 0))) {
+			|| util_nsmode(param.mode) == NDCTL_NS_MODE_SECTOR)) {
 		/* default sector size for blk-type or safe-mode */
 		param.sector_size = "4096";
 	}
@@ -559,23 +545,12 @@ static int validate_namespace_options(struct ndctl_region *region,
 	}
 
 	if (param.mode) {
-		if (strcmp(param.mode, "memory") == 0)
-			p->mode = NDCTL_NS_MODE_FSDAX;
-		else if (strcmp(param.mode, "sector") == 0)
-			p->mode = NDCTL_NS_MODE_SECTOR;
-		else if (strcmp(param.mode, "safe") == 0)
-			p->mode = NDCTL_NS_MODE_SECTOR;
-		else if (strcmp(param.mode, "dax") == 0)
-			p->mode = NDCTL_NS_MODE_DEVDAX;
-		else
-			p->mode = NDCTL_NS_MODE_RAW;
-
+		p->mode = util_nsmode(param.mode);
 		if (ndctl_region_get_type(region) != ND_DEVICE_REGION_PMEM
 				&& (p->mode == NDCTL_NS_MODE_FSDAX
 					|| p->mode == NDCTL_NS_MODE_DEVDAX)) {
 			debug("blk %s does not support %s mode\n", region_name,
-					p->mode == NDCTL_NS_MODE_FSDAX
-					? "fsdax" : "devdax");
+					util_nsmode_name(p->mode));
 			return -EAGAIN;
 		}
 	} else if (ndns)
@@ -593,7 +568,8 @@ static int validate_namespace_options(struct ndctl_region *region,
 	} else if (p->mode == NDCTL_NS_MODE_DEVDAX) {
 		dax = ndctl_region_get_dax_seed(region);
 		if (!dax) {
-			error("Kernel does not support devdax mode\n");
+			error("Kernel does not support %s mode\n",
+					util_nsmode_name(p->mode));
 			return -ENODEV;
 		}
 	}
@@ -617,8 +593,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 
 		default:
 			error("%s mode does not support setting an alignment\n",
-					p->mode == NDCTL_NS_MODE_SECTOR
-					? "sector" : "raw");
+					util_nsmode_name(p->mode));
 			return -ENXIO;
 		}
 
diff --git a/util/filter.c b/util/filter.c
index ce6239fbac3b..e4b1885b26f8 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -335,29 +335,41 @@ struct daxctl_dev *util_daxctl_dev_filter(struct daxctl_dev *dev,
 	return NULL;
 }
 
-static enum ndctl_namespace_mode mode_to_type(const char *mode)
+enum ndctl_namespace_mode util_nsmode(const char *mode)
 {
 	if (!mode)
-		return -ENXIO;
-
+		return NDCTL_NS_MODE_UNKNOWN;
 	if (strcasecmp(mode, "memory") == 0)
-		return NDCTL_NS_MODE_MEMORY;
-	else if (strcasecmp(mode, "fsdax") == 0)
-		return NDCTL_NS_MODE_MEMORY;
-	else if (strcasecmp(mode, "sector") == 0)
+		return NDCTL_NS_MODE_FSDAX;
+	if (strcasecmp(mode, "fsdax") == 0)
+		return NDCTL_NS_MODE_FSDAX;
+	if (strcasecmp(mode, "sector") == 0)
 		return NDCTL_NS_MODE_SECTOR;
-	else if (strcasecmp(mode, "safe") == 0)
+	if (strcasecmp(mode, "safe") == 0)
 		return NDCTL_NS_MODE_SECTOR;
-	else if (strcasecmp(mode, "dax") == 0)
-		return NDCTL_NS_MODE_DAX;
-	else if (strcasecmp(mode, "devdax") == 0)
-		return NDCTL_NS_MODE_DAX;
-	else if (strcasecmp(mode, "raw") == 0)
+	if (strcasecmp(mode, "dax") == 0)
+		return NDCTL_NS_MODE_DEVDAX;
+	if (strcasecmp(mode, "devdax") == 0)
+		return NDCTL_NS_MODE_DEVDAX;
+	if (strcasecmp(mode, "raw") == 0)
 		return NDCTL_NS_MODE_RAW;
 
 	return NDCTL_NS_MODE_UNKNOWN;
 }
 
+const char *util_nsmode_name(enum ndctl_namespace_mode mode)
+{
+	static const char *modes[] = {
+		[NDCTL_NS_MODE_FSDAX] = "fsdax",
+		[NDCTL_NS_MODE_DEVDAX] = "devdax",
+		[NDCTL_NS_MODE_RAW] = "raw",
+		[NDCTL_NS_MODE_SECTOR] = "sector",
+		[NDCTL_NS_MODE_UNKNOWN] = "unknown",
+	};
+
+	return modes[mode];
+}
+
 int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
 		struct util_filter_params *param)
 {
@@ -380,7 +392,7 @@ int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
 			type = ND_DEVICE_REGION_BLK;
 	}
 
-	if (mode_to_type(param->mode) == NDCTL_NS_MODE_UNKNOWN) {
+	if (param->mode && util_nsmode(param->mode) == NDCTL_NS_MODE_UNKNOWN) {
 		error("invalid mode: '%s'\n", param->mode);
 		return -EINVAL;
 	}
@@ -458,7 +470,7 @@ int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
 					continue;
 
 				mode = ndctl_namespace_get_mode(ndns);
-				if (param->mode && mode_to_type(param->mode) != mode)
+				if (param->mode && util_nsmode(param->mode) != mode)
 					continue;
 
 				fctx->filter_namespace(ndns, fctx);
diff --git a/util/filter.h b/util/filter.h
index c2cdddf5be54..55f78f2a4cf7 100644
--- a/util/filter.h
+++ b/util/filter.h
@@ -38,6 +38,9 @@ struct ndctl_region *util_region_filter_by_namespace(struct ndctl_region *region
 struct daxctl_dev *util_daxctl_dev_filter(struct daxctl_dev *dev,
 		const char *ident);
 
+enum ndctl_namespace_mode util_nsmode(const char *mode);
+const char *util_nsmode_name(enum ndctl_namespace_mode mode);
+
 struct json_object;
 
 /* json object hierarchy for the util_filter_walk() performed by cmd_list() */

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDA817494E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:37:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 199B910FC3581;
	Sat, 29 Feb 2020 12:38:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8E3CB10FC3581
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:38:47 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:55 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="257481360"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:55 -0800
Subject: [ndctl PATCH 20/36] ndctl/namespace: Introduce mode-to-name and
 name-to-mode helpers
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:21:50 -0800
Message-ID: <158300771041.2141307.11811224712955268465.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: U5SKYWMMR4D7NHG2GAFFPBVCJV76MLBV
X-Message-ID-Hash: U5SKYWMMR4D7NHG2GAFFPBVCJV76MLBV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U5SKYWMMR4D7NHG2GAFFPBVCJV76MLBV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
index 770caa5ebab0..1747a061d5b7 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -214,21 +214,7 @@ static int set_defaults(enum device_action mode)
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
@@ -294,7 +280,7 @@ static int set_defaults(enum device_action mode)
 			rc = -EINVAL;
 		}
 	} else if (((param.type && strcmp(param.type, "blk") == 0)
-			|| (param.mode && strcmp(param.mode, "safe") == 0))) {
+			|| util_nsmode(param.mode) == NDCTL_NS_MODE_SECTOR)) {
 		/* default sector size for blk-type or safe-mode */
 		param.sector_size = "4096";
 	}
@@ -585,23 +571,12 @@ static int validate_namespace_options(struct ndctl_region *region,
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
 			err("blk %s does not support %s mode\n", region_name,
-					p->mode == NDCTL_NS_MODE_FSDAX
-					? "fsdax" : "devdax");
+					util_nsmode_name(p->mode));
 			return -EAGAIN;
 		}
 	} else if (ndns)
@@ -619,7 +594,8 @@ static int validate_namespace_options(struct ndctl_region *region,
 	} else if (p->mode == NDCTL_NS_MODE_DEVDAX) {
 		dax = ndctl_region_get_dax_seed(region);
 		if (!dax) {
-			error("Kernel does not support devdax mode\n");
+			error("Kernel does not support %s mode\n",
+					util_nsmode_name(p->mode));
 			return -ENODEV;
 		}
 	}
@@ -643,8 +619,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 
 		default:
 			error("%s mode does not support setting an alignment\n",
-					p->mode == NDCTL_NS_MODE_SECTOR
-					? "sector" : "raw");
+					util_nsmode_name(p->mode));
 			return -ENXIO;
 		}
 
diff --git a/util/filter.c b/util/filter.c
index 9f6b65a70117..af72793929e2 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -351,29 +351,41 @@ struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
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
+	static const char * const modes[] = {
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
@@ -396,7 +408,7 @@ int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
 			type = ND_DEVICE_REGION_BLK;
 	}
 
-	if (mode_to_type(param->mode) == NDCTL_NS_MODE_UNKNOWN) {
+	if (param->mode && util_nsmode(param->mode) == NDCTL_NS_MODE_UNKNOWN) {
 		error("invalid mode: '%s'\n", param->mode);
 		return -EINVAL;
 	}
@@ -474,7 +486,7 @@ int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
 					continue;
 
 				mode = ndctl_namespace_get_mode(ndns);
-				if (param->mode && mode_to_type(param->mode) != mode)
+				if (param->mode && util_nsmode(param->mode) != mode)
 					continue;
 
 				fctx->filter_namespace(ndns, fctx);
diff --git a/util/filter.h b/util/filter.h
index 0c12b94218d6..ad3441cc3a16 100644
--- a/util/filter.h
+++ b/util/filter.h
@@ -40,6 +40,9 @@ struct daxctl_dev *util_daxctl_dev_filter(struct daxctl_dev *dev,
 struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
 		const char *ident);
 
+enum ndctl_namespace_mode util_nsmode(const char *mode);
+const char *util_nsmode_name(enum ndctl_namespace_mode mode);
+
 struct json_object;
 
 /* json object hierarchy for the util_filter_walk() performed by cmd_list() */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

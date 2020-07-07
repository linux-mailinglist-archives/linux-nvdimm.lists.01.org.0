Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2FC216436
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:57:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 11D551108DEB2;
	Mon,  6 Jul 2020 19:57:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 526101108DEB2
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:57:06 -0700 (PDT)
IronPort-SDR: JFYQtqMwTp22kpItk46d5YxqgCnJNGF1WcPqejZa7Vcr6P0YPpeC6n+tR+NsdkmXo9QpgLiL4M
 3VQBDIGyjbnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="127124230"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="127124230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:06 -0700
IronPort-SDR: Sh2tWv9AE5czw4uBKsB19ZQheCB4FrD4JpXqXXZHc4InLoPZJcE1fXdwMTTDP6mrNJaqPbSdmU
 qz3jgX84vz0Q==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="315371667"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:05 -0700
Subject: [ndctl PATCH 06/16] ndctl/dimm: Prepare to emit dimm json object
 after firmware update
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:40:50 -0700
Message-ID: <159408965016.2386154.1586833845040694311.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: NHCZYZVW5TYNO5VY2SVWYT2CMY2XPJMI
X-Message-ID-Hash: NHCZYZVW5TYNO5VY2SVWYT2CMY2XPJMI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NHCZYZVW5TYNO5VY2SVWYT2CMY2XPJMI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Move util_dimm_firmware_to_json() internal to util_dimm_to_json().
Introduce a new UTIL_JSON_FIRMWARE flag to optionally dump firmware info
when listing the dimm from either 'ndctl list', or after 'ndctl
update-firmware'.

Move util_dimm_firmware_to_json() out of ndctl/util/json-firmware.c into
the core util/json.c.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/Makefile.am          |    1 -
 ndctl/list.c               |   10 +----
 ndctl/util/json-firmware.c |   85 --------------------------------------------
 util/json.c                |   84 +++++++++++++++++++++++++++++++++++++++++++
 util/json.h                |   17 +++++----
 5 files changed, 95 insertions(+), 102 deletions(-)
 delete mode 100644 ndctl/util/json-firmware.c

diff --git a/ndctl/Makefile.am b/ndctl/Makefile.am
index 49c6c4ab4498..a63b1e0b8a01 100644
--- a/ndctl/Makefile.am
+++ b/ndctl/Makefile.am
@@ -25,7 +25,6 @@ ndctl_SOURCES = ndctl.c \
 		../util/json.c \
 		../util/json.h \
 		util/json-smart.c \
-		util/json-firmware.c \
 		util/keys.h \
 		inject-error.c \
 		inject-smart.c \
diff --git a/ndctl/list.c b/ndctl/list.c
index 31fb1b9593a2..1f7cc8ee1deb 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -59,6 +59,8 @@ static unsigned long listopts_to_flags(void)
 		flags |= UTIL_JSON_VERBOSE;
 	if (list.capabilities)
 		flags |= UTIL_JSON_CAPABILITIES;
+	if (list.firmware)
+		flags |= UTIL_JSON_FIRMWARE;
 	return flags;
 }
 
@@ -367,14 +369,6 @@ static void filter_dimm(struct ndctl_dimm *dimm, struct util_filter_ctx *ctx)
 		}
 	}
 
-	if (list.firmware) {
-		struct json_object *jfirmware;
-
-		jfirmware = util_dimm_firmware_to_json(dimm, lfa->flags);
-		if (jfirmware)
-			json_object_object_add(jdimm, "firmware", jfirmware);
-	}
-
 	/*
 	 * Without a bus we are collecting dimms anonymously across the
 	 * platform.
diff --git a/ndctl/util/json-firmware.c b/ndctl/util/json-firmware.c
deleted file mode 100644
index 9a9db064d851..000000000000
--- a/ndctl/util/json-firmware.c
+++ /dev/null
@@ -1,85 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2018 Intel Corporation. All rights reserved. */
-#include <limits.h>
-#include <util/json.h>
-#include <uuid/uuid.h>
-#include <json-c/json.h>
-#include <ndctl/libndctl.h>
-#include <ccan/array_size/array_size.h>
-#include <ndctl.h>
-
-struct json_object *util_dimm_firmware_to_json(struct ndctl_dimm *dimm,
-		unsigned long flags)
-{
-	struct json_object *jfirmware = json_object_new_object();
-	struct json_object *jobj;
-	struct ndctl_cmd *cmd;
-	int rc;
-	uint64_t run, next;
-
-	if (!jfirmware)
-		return NULL;
-
-	cmd = ndctl_dimm_cmd_new_fw_get_info(dimm);
-	if (!cmd)
-		goto err;
-
-	rc = ndctl_cmd_submit(cmd);
-	if ((rc < 0) || ndctl_cmd_fw_xlat_firmware_status(cmd) != FW_SUCCESS) {
-		jobj = util_json_object_hex(-1, flags);
-		if (jobj)
-			json_object_object_add(jfirmware, "current_version",
-					jobj);
-		goto out;
-	}
-
-	run = ndctl_cmd_fw_info_get_run_version(cmd);
-	if (run == ULLONG_MAX) {
-		jobj = util_json_object_hex(-1, flags);
-		if (jobj)
-			json_object_object_add(jfirmware, "current_version",
-					jobj);
-		goto out;
-	}
-
-	jobj = util_json_object_hex(run, flags);
-	if (jobj)
-		json_object_object_add(jfirmware, "current_version", jobj);
-
-	rc = ndctl_dimm_fw_update_supported(dimm);
-	jobj = json_object_new_boolean(rc == 0);
-	if (jobj)
-		json_object_object_add(jfirmware, "can_update", jobj);
-
-	next = ndctl_cmd_fw_info_get_updated_version(cmd);
-	if (next == ULLONG_MAX) {
-		jobj = util_json_object_hex(-1, flags);
-		if (jobj)
-			json_object_object_add(jfirmware, "next_version",
-					jobj);
-		goto out;
-	}
-
-	if (next != 0) {
-		jobj = util_json_object_hex(next, flags);
-		if (jobj)
-			json_object_object_add(jfirmware,
-					"next_version", jobj);
-
-		jobj = json_object_new_boolean(true);
-		if (jobj)
-			json_object_object_add(jfirmware,
-					"need_powercycle", jobj);
-	}
-
-	ndctl_cmd_unref(cmd);
-	return jfirmware;
-
-err:
-	json_object_put(jfirmware);
-	jfirmware = NULL;
-out:
-	if (cmd)
-		ndctl_cmd_unref(cmd);
-	return jfirmware;
-}
diff --git a/util/json.c b/util/json.c
index 21ab25674624..59a3d07cc4a6 100644
--- a/util/json.c
+++ b/util/json.c
@@ -156,6 +156,82 @@ struct json_object *util_bus_to_json(struct ndctl_bus *bus)
 	return NULL;
 }
 
+struct json_object *util_dimm_firmware_to_json(struct ndctl_dimm *dimm,
+		unsigned long flags)
+{
+	struct json_object *jfirmware = json_object_new_object();
+	struct json_object *jobj;
+	struct ndctl_cmd *cmd;
+	int rc;
+	uint64_t run, next;
+
+	if (!jfirmware)
+		return NULL;
+
+	cmd = ndctl_dimm_cmd_new_fw_get_info(dimm);
+	if (!cmd)
+		goto err;
+
+	rc = ndctl_cmd_submit(cmd);
+	if ((rc < 0) || ndctl_cmd_fw_xlat_firmware_status(cmd) != FW_SUCCESS) {
+		jobj = util_json_object_hex(-1, flags);
+		if (jobj)
+			json_object_object_add(jfirmware, "current_version",
+					jobj);
+		goto out;
+	}
+
+	run = ndctl_cmd_fw_info_get_run_version(cmd);
+	if (run == ULLONG_MAX) {
+		jobj = util_json_object_hex(-1, flags);
+		if (jobj)
+			json_object_object_add(jfirmware, "current_version",
+					jobj);
+		goto out;
+	}
+
+	jobj = util_json_object_hex(run, flags);
+	if (jobj)
+		json_object_object_add(jfirmware, "current_version", jobj);
+
+	rc = ndctl_dimm_fw_update_supported(dimm);
+	jobj = json_object_new_boolean(rc == 0);
+	if (jobj)
+		json_object_object_add(jfirmware, "can_update", jobj);
+
+	next = ndctl_cmd_fw_info_get_updated_version(cmd);
+	if (next == ULLONG_MAX) {
+		jobj = util_json_object_hex(-1, flags);
+		if (jobj)
+			json_object_object_add(jfirmware, "next_version",
+					jobj);
+		goto out;
+	}
+
+	if (next != 0) {
+		jobj = util_json_object_hex(next, flags);
+		if (jobj)
+			json_object_object_add(jfirmware,
+					"next_version", jobj);
+
+		jobj = json_object_new_boolean(true);
+		if (jobj)
+			json_object_object_add(jfirmware,
+					"need_powercycle", jobj);
+	}
+
+	ndctl_cmd_unref(cmd);
+	return jfirmware;
+
+err:
+	json_object_put(jfirmware);
+	jfirmware = NULL;
+out:
+	if (cmd)
+		ndctl_cmd_unref(cmd);
+	return jfirmware;
+}
+
 struct json_object *util_dimm_to_json(struct ndctl_dimm *dimm,
 		unsigned long flags)
 {
@@ -266,6 +342,14 @@ struct json_object *util_dimm_to_json(struct ndctl_dimm *dimm,
 			json_object_object_add(jdimm, "security_frozen", jobj);
 	}
 
+	if (flags & UTIL_JSON_FIRMWARE) {
+		struct json_object *jfirmware;
+
+		jfirmware = util_dimm_firmware_to_json(dimm, flags);
+		if (jfirmware)
+			json_object_object_add(jdimm, "firmware", jfirmware);
+	}
+
 	return jdimm;
  err:
 	json_object_put(jdimm);
diff --git a/util/json.h b/util/json.h
index 6d39d3aa4693..fc91a8db034f 100644
--- a/util/json.h
+++ b/util/json.h
@@ -18,14 +18,15 @@
 #include <ccan/short_types/short_types.h>
 
 enum util_json_flags {
-	UTIL_JSON_IDLE = (1 << 0),
-	UTIL_JSON_MEDIA_ERRORS = (1 << 1),
-	UTIL_JSON_DAX = (1 << 2),
-	UTIL_JSON_DAX_DEVS = (1 << 3),
-	UTIL_JSON_HUMAN = (1 << 4),
-	UTIL_JSON_VERBOSE = (1 << 5),
-	UTIL_JSON_CAPABILITIES = (1 << 6),
-	UTIL_JSON_CONFIGURED = (1 << 7),
+	UTIL_JSON_IDLE		= (1 << 0),
+	UTIL_JSON_MEDIA_ERRORS	= (1 << 1),
+	UTIL_JSON_DAX		= (1 << 2),
+	UTIL_JSON_DAX_DEVS	= (1 << 3),
+	UTIL_JSON_HUMAN		= (1 << 4),
+	UTIL_JSON_VERBOSE	= (1 << 5),
+	UTIL_JSON_CAPABILITIES	= (1 << 6),
+	UTIL_JSON_CONFIGURED	= (1 << 7),
+	UTIL_JSON_FIRMWARE	= (1 << 8),
 };
 
 struct json_object;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

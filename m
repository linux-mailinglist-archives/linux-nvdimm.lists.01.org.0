Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA65227352
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 01:54:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 717821242E171;
	Mon, 20 Jul 2020 16:54:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E39461243792E
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 16:54:14 -0700 (PDT)
IronPort-SDR: q3oG4UNlsOvVAwJqHLgP3g1GXIenLt85Yujui5USYf6I/uoAxgPVXlAR3dH1m0nCYtIMtcujFw
 HrV6V4aDImXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="138128832"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="138128832"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 16:54:14 -0700
IronPort-SDR: wYmfxpaDmFF1tJoDODdf9v5Ed9P5NUSYQLCrnDiubPT/Hp4QwG4iiJmEM2mhY25ClRRR33qa8G
 ZlH6G/GHUHkw==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="310029255"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 16:54:13 -0700
Subject: [ndctl PATCH v2 1/4] ndctl/list: Add firmware activation enumeration
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 20 Jul 2020 16:37:56 -0700
Message-ID: <159528827659.994840.8440621449915325381.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159528827109.994840.13180558014653471832.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159528827109.994840.13180558014653471832.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 64BQZDQ2IAEAJCHFIJCLMZAKUTRPOY3X
X-Message-ID-Hash: 64BQZDQ2IAEAJCHFIJCLMZAKUTRPOY3X
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/64BQZDQ2IAEAJCHFIJCLMZAKUTRPOY3X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When firmware is staged check if the platform / kernel also supports live
firmware activation and include that state at both the dimm and bus level.
The "last activate result" is included only as a hint to whether a
powercycle is required to activate the current image. If firmware
activation fails the "need_powercycle" flag will appear, if firmware
activation is successful then the "current_version" field will be
up-to-date.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-list.txt |   39 +++++++---
 ndctl/bus.c                        |    2 -
 ndctl/lib/libndctl.c               |  140 ++++++++++++++++++++++++++++++++++++
 ndctl/lib/libndctl.sym             |    7 ++
 ndctl/lib/private.h                |    4 +
 ndctl/libndctl.h                   |   28 +++++++
 ndctl/list.c                       |    3 +
 util/json.c                        |  117 +++++++++++++++++++++++++++---
 util/json.h                        |    3 +
 9 files changed, 318 insertions(+), 25 deletions(-)

diff --git a/Documentation/ndctl/ndctl-list.txt b/Documentation/ndctl/ndctl-list.txt
index 7c7e3ac9d05c..b8d517d784b4 100644
--- a/Documentation/ndctl/ndctl-list.txt
+++ b/Documentation/ndctl/ndctl-list.txt
@@ -132,16 +132,35 @@ include::xable-bus-options.txt[]
 
 -F::
 --firmware::
-	Include dimm firmware info in the listing. For example:
-[verse]
-{
-  "dev":"nmem0",
-  "firmware":{
-      "current_version":0,
-      "next_version":1,
-      "need_powercycle":true
-  }
-}
+	Include firmware info in the listing, including the state and
+	capability of runtime firmware activation:
+
+----
+# ndctl list -BDF
+[
+  {
+    "provider":"nfit_test.0",
+    "dev":"ndbus2",
+    "scrub_state":"idle",
+    "firmware":{
+      "activate_method":"suspend",
+      "activate_state":"idle"
+    },
+    "dimms":[
+      {
+        "dev":"nmem1",
+        "id":"cdab-0a-07e0-ffffffff",
+        "handle":0,
+        "phys_id":0,
+        "security":"disabled",
+        "firmware":{
+          "current_version":0,
+          "can_update":true
+        }
+      },
+...
+]
+----
 
 -X::
 --device-dax::
diff --git a/ndctl/bus.c b/ndctl/bus.c
index 86bbd5178df9..6d5bafb86fe4 100644
--- a/ndctl/bus.c
+++ b/ndctl/bus.c
@@ -92,7 +92,7 @@ static int bus_action(int argc, const char **argv, const char *usage,
 			rc = scrub_action(bus, action);
 			if (rc == 0) {
 				success++;
-				jbus = util_bus_to_json(bus);
+				jbus = util_bus_to_json(bus, 0);
 				if (jbus)
 					json_object_array_add(jbuses, jbus);
 			} else if (!fail)
diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index ee737cbbfe3e..628bb9c0cffa 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -819,6 +819,31 @@ static void parse_dimm_flags(struct ndctl_dimm *dimm, char *flags)
 				ndctl_dimm_get_devname(dimm), flags);
 }
 
+static enum ndctl_fwa_state fwa_to_state(const char *fwa)
+{
+	if (strcmp(fwa, "idle") == 0)
+		return NDCTL_FWA_IDLE;
+	if (strcmp(fwa, "busy") == 0)
+		return NDCTL_FWA_BUSY;
+	if (strcmp(fwa, "armed") == 0)
+		return NDCTL_FWA_ARMED;
+	if (strcmp(fwa, "overflow") == 0)
+		return NDCTL_FWA_ARM_OVERFLOW;
+	return NDCTL_FWA_INVALID;
+}
+
+static enum ndctl_fwa_method fwa_method_to_method(const char *fwa_method)
+{
+	if (!fwa_method)
+		return NDCTL_FWA_METHOD_RESET;
+
+	if (strcmp(fwa_method, "quiesce") == 0)
+		return NDCTL_FWA_METHOD_SUSPEND;
+	if (strcmp(fwa_method, "live") == 0)
+		return NDCTL_FWA_METHOD_LIVE;
+	return NDCTL_FWA_METHOD_RESET;
+}
+
 static void *add_bus(void *parent, int id, const char *ctl_base)
 {
 	char buf[SYSFS_ATTR_SIZE];
@@ -880,6 +905,19 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 	if (!bus->scrub_path)
 		goto err_read;
 
+	sprintf(path, "%s/device/firmware/activate", ctl_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		bus->fwa_state = NDCTL_FWA_INVALID;
+	else
+		bus->fwa_state = fwa_to_state(buf);
+
+	sprintf(path, "%s/device/firmware/capability", ctl_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		bus->fwa_method = fwa_method_to_method(NULL);
+	else
+		bus->fwa_method = fwa_method_to_method(buf);
+
+
 	bus->bus_path = parent_dev_path("char", bus->major, bus->minor);
 	if (!bus->bus_path)
 		goto err_dev_path;
@@ -1436,6 +1474,51 @@ NDCTL_EXPORT int ndctl_bus_wait_for_scrub_completion(struct ndctl_bus *bus)
 	return ndctl_bus_poll_scrub_completion(bus, 0, 0);
 }
 
+NDCTL_EXPORT enum ndctl_fwa_state ndctl_bus_get_fw_activate_state(
+		struct ndctl_bus *bus)
+{
+	struct ndctl_ctx *ctx = ndctl_bus_get_ctx(bus);
+	char *path = bus->bus_buf;
+	char buf[SYSFS_ATTR_SIZE];
+	int len = bus->buf_len;
+
+	if (bus->fwa_state == NDCTL_FWA_INVALID)
+		return NDCTL_FWA_INVALID;
+
+	if (snprintf(path, len, "%s/firmware/activate", bus->bus_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				ndctl_bus_get_devname(bus));
+		return NDCTL_FWA_INVALID;
+	}
+
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		return NDCTL_FWA_INVALID;
+
+	bus->fwa_state = fwa_to_state(buf);
+
+	return bus->fwa_state;
+}
+
+NDCTL_EXPORT enum ndctl_fwa_method ndctl_bus_get_fw_activate_method(struct ndctl_bus *bus)
+{
+	return bus->fwa_method;
+}
+
+static enum ndctl_fwa_result fwa_result_to_result(const char *result)
+{
+	if (strcmp(result, "none") == 0)
+		return NDCTL_FWA_RESULT_NONE;
+	if (strcmp(result, "success") == 0)
+		return NDCTL_FWA_RESULT_SUCCESS;
+	if (strcmp(result, "fail") == 0)
+		return NDCTL_FWA_RESULT_FAIL;
+	if (strcmp(result, "not_staged") == 0)
+		return NDCTL_FWA_RESULT_NOTSTAGED;
+	if (strcmp(result, "need_reset") == 0)
+		return NDCTL_FWA_RESULT_NEEDRESET;
+	return NDCTL_FWA_RESULT_INVALID;
+}
+
 static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
 		const char *devname);
 static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
@@ -1515,6 +1598,18 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	} else
 		parse_dimm_flags(dimm, buf);
 
+	sprintf(path, "%s/firmware/activate", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		dimm->fwa_state = NDCTL_FWA_INVALID;
+	else
+		dimm->fwa_state = fwa_to_state(buf);
+
+	sprintf(path, "%s/firmware/result", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		dimm->fwa_result = NDCTL_FWA_RESULT_INVALID;
+	else
+		dimm->fwa_result = fwa_result_to_result(buf);
+
 	if (!ndctl_bus_has_nfit(bus))
 		goto out;
 
@@ -1998,6 +2093,51 @@ NDCTL_EXPORT int ndctl_dimm_enable(struct ndctl_dimm *dimm)
 	return 0;
 }
 
+NDCTL_EXPORT enum ndctl_fwa_state ndctl_dimm_get_fw_activate_state(
+		struct ndctl_dimm *dimm)
+{
+	struct ndctl_ctx *ctx = ndctl_dimm_get_ctx(dimm);
+	char *path = dimm->dimm_buf;
+	char buf[SYSFS_ATTR_SIZE];
+	int len = dimm->buf_len;
+
+	if (dimm->fwa_state == NDCTL_FWA_INVALID)
+		return NDCTL_FWA_INVALID;
+
+	if (snprintf(path, len, "%s/firmware/activate", dimm->dimm_path) >= len) {
+		err(ctx, "%s: buffer too small!\n", ndctl_dimm_get_devname(dimm));
+		return NDCTL_FWA_INVALID;
+	}
+
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		return NDCTL_FWA_INVALID;
+
+	dimm->fwa_state = fwa_to_state(buf);
+	return dimm->fwa_state;
+}
+
+NDCTL_EXPORT enum ndctl_fwa_result ndctl_dimm_get_fw_activate_result(
+		struct ndctl_dimm *dimm)
+{
+	struct ndctl_ctx *ctx = ndctl_dimm_get_ctx(dimm);
+	char *path = dimm->dimm_buf;
+	char buf[SYSFS_ATTR_SIZE];
+	int len = dimm->buf_len;
+
+	if (dimm->fwa_result == NDCTL_FWA_RESULT_INVALID)
+		return NDCTL_FWA_RESULT_INVALID;
+
+	if (snprintf(path, len, "%s/firmware/result", dimm->dimm_path) >= len) {
+		err(ctx, "%s: buffer too small!\n", ndctl_dimm_get_devname(dimm));
+		return NDCTL_FWA_RESULT_INVALID;
+	}
+
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		return NDCTL_FWA_RESULT_INVALID;
+
+	return fwa_result_to_result(buf);
+}
+
 NDCTL_EXPORT struct ndctl_dimm *ndctl_dimm_get_by_handle(struct ndctl_bus *bus,
 		unsigned int handle)
 {
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index ac575a23d035..37217036b0d8 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -431,3 +431,10 @@ LIBNDCTL_23 {
 	ndctl_region_get_align;
 	ndctl_region_set_align;
 } LIBNDCTL_22;
+
+LIBNDCTL_24 {
+	ndctl_dimm_get_fw_activate_state;
+	ndctl_dimm_get_fw_activate_result;
+	ndctl_bus_get_fw_activate_state;
+	ndctl_bus_get_fw_activate_method;
+} LIBNDCTL_23;
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 2e537f0a8649..02391631d85e 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -79,6 +79,8 @@ struct ndctl_dimm {
 	unsigned long cmd_mask;
 	unsigned long nfit_dsm_mask;
 	long long dirty_shutdown;
+	enum ndctl_fwa_state fwa_state;
+	enum ndctl_fwa_result fwa_result;
 	char *unique_id;
 	char *dimm_path;
 	char *dimm_buf;
@@ -174,6 +176,8 @@ struct ndctl_bus {
 	char *scrub_path;
 	unsigned long cmd_mask;
 	unsigned long nfit_dsm_mask;
+	enum ndctl_fwa_state fwa_state;
+	enum ndctl_fwa_method fwa_method;
 };
 
 /**
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 2580f433ade8..e66a52029481 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -110,6 +110,20 @@ enum ndctl_persistence_domain {
 	PERSISTENCE_UNKNOWN = INT_MAX,
 };
 
+enum ndctl_fwa_state {
+	NDCTL_FWA_INVALID,
+	NDCTL_FWA_IDLE,
+	NDCTL_FWA_ARMED,
+	NDCTL_FWA_BUSY,
+	NDCTL_FWA_ARM_OVERFLOW,
+};
+
+enum ndctl_fwa_method {
+	NDCTL_FWA_METHOD_RESET,
+	NDCTL_FWA_METHOD_SUSPEND,
+	NDCTL_FWA_METHOD_LIVE,
+};
+
 struct ndctl_bus;
 struct ndctl_bus *ndctl_bus_get_first(struct ndctl_ctx *ctx);
 struct ndctl_bus *ndctl_bus_get_next(struct ndctl_bus *bus);
@@ -139,6 +153,8 @@ unsigned int ndctl_bus_get_scrub_count(struct ndctl_bus *bus);
 int ndctl_bus_get_scrub_state(struct ndctl_bus *bus);
 int ndctl_bus_start_scrub(struct ndctl_bus *bus);
 int ndctl_bus_has_error_injection(struct ndctl_bus *bus);
+enum ndctl_fwa_state ndctl_bus_get_fw_activate_state(struct ndctl_bus *bus);
+enum ndctl_fwa_method ndctl_bus_get_fw_activate_method(struct ndctl_bus *bus);
 
 struct ndctl_dimm;
 struct ndctl_dimm *ndctl_dimm_get_first(struct ndctl_bus *bus);
@@ -702,6 +718,18 @@ enum ND_FW_STATUS ndctl_cmd_fw_xlat_firmware_status(struct ndctl_cmd *cmd);
 struct ndctl_cmd *ndctl_dimm_cmd_new_ack_shutdown_count(struct ndctl_dimm *dimm);
 int ndctl_dimm_fw_update_supported(struct ndctl_dimm *dimm);
 
+enum ndctl_fwa_result {
+        NDCTL_FWA_RESULT_INVALID,
+        NDCTL_FWA_RESULT_NONE,
+        NDCTL_FWA_RESULT_SUCCESS,
+        NDCTL_FWA_RESULT_NOTSTAGED,
+        NDCTL_FWA_RESULT_NEEDRESET,
+        NDCTL_FWA_RESULT_FAIL,
+};
+
+enum ndctl_fwa_state ndctl_dimm_get_fw_activate_state(struct ndctl_dimm *dimm);
+enum ndctl_fwa_result ndctl_dimm_get_fw_activate_result(struct ndctl_dimm *dimm);
+
 int ndctl_cmd_xlat_firmware_status(struct ndctl_cmd *cmd);
 int ndctl_cmd_submit_xlat(struct ndctl_cmd *cmd);
 
diff --git a/ndctl/list.c b/ndctl/list.c
index 1f7cc8ee1deb..f98148aea479 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -403,11 +403,12 @@ static bool filter_bus(struct ndctl_bus *bus, struct util_filter_ctx *ctx)
 		}
 	}
 
-	lfa->jbus = util_bus_to_json(bus);
+	lfa->jbus = util_bus_to_json(bus, lfa->flags);
 	if (!lfa->jbus) {
 		fail("\n");
 		return false;
 	}
+
 	json_object_array_add(lfa->jbuses, lfa->jbus);
 	return true;
 }
diff --git a/util/json.c b/util/json.c
index 59a3d07cc4a6..77bd4781551d 100644
--- a/util/json.c
+++ b/util/json.c
@@ -122,10 +122,10 @@ void util_display_json_array(FILE *f_out, struct json_object *jarray,
 	json_object_put(jarray);
 }
 
-struct json_object *util_bus_to_json(struct ndctl_bus *bus)
+struct json_object *util_bus_to_json(struct ndctl_bus *bus, unsigned long flags)
 {
 	struct json_object *jbus = json_object_new_object();
-	struct json_object *jobj;
+	struct json_object *jobj, *fw_obj = NULL;
 	int scrub;
 
 	if (!jbus)
@@ -150,6 +150,49 @@ struct json_object *util_bus_to_json(struct ndctl_bus *bus)
 		goto err;
 	json_object_object_add(jbus, "scrub_state", jobj);
 
+	if (flags & UTIL_JSON_FIRMWARE) {
+		struct ndctl_dimm *dimm;
+
+		/*
+		 * Skip displaying firmware activation capability if no
+		 * DIMMs support firmware update.
+		 */
+		ndctl_dimm_foreach(bus, dimm)
+			if (ndctl_dimm_fw_update_supported(dimm) == 0) {
+				fw_obj = json_object_new_object();
+				break;
+			}
+	}
+
+	if (fw_obj) {
+		enum ndctl_fwa_state state;
+		enum ndctl_fwa_method method;
+
+		jobj = NULL;
+		method = ndctl_bus_get_fw_activate_method(bus);
+		if (method == NDCTL_FWA_METHOD_RESET)
+			jobj = json_object_new_string("reset");
+		if (method == NDCTL_FWA_METHOD_SUSPEND)
+			jobj = json_object_new_string("suspend");
+		if (method == NDCTL_FWA_METHOD_LIVE)
+			jobj = json_object_new_string("live");
+		if (jobj)
+			json_object_object_add(fw_obj, "activate_method", jobj);
+
+		jobj = NULL;
+		state = ndctl_bus_get_fw_activate_state(bus);
+		if (state == NDCTL_FWA_ARMED)
+			jobj = json_object_new_string("armed");
+		if (state == NDCTL_FWA_IDLE)
+			jobj = json_object_new_string("idle");
+		if (state == NDCTL_FWA_ARM_OVERFLOW)
+			jobj = json_object_new_string("overflow");
+		if (jobj)
+			json_object_object_add(fw_obj, "activate_state", jobj);
+
+		json_object_object_add(jbus, "firmware", fw_obj);
+	}
+
 	return jbus;
  err:
 	json_object_put(jbus);
@@ -160,10 +203,13 @@ struct json_object *util_dimm_firmware_to_json(struct ndctl_dimm *dimm,
 		unsigned long flags)
 {
 	struct json_object *jfirmware = json_object_new_object();
+	bool can_update, need_powercycle;
+	enum ndctl_fwa_result result;
+	enum ndctl_fwa_state state;
 	struct json_object *jobj;
 	struct ndctl_cmd *cmd;
-	int rc;
 	uint64_t run, next;
+	int rc;
 
 	if (!jfirmware)
 		return NULL;
@@ -195,10 +241,12 @@ struct json_object *util_dimm_firmware_to_json(struct ndctl_dimm *dimm,
 		json_object_object_add(jfirmware, "current_version", jobj);
 
 	rc = ndctl_dimm_fw_update_supported(dimm);
-	jobj = json_object_new_boolean(rc == 0);
+	can_update = rc == 0;
+	jobj = json_object_new_boolean(can_update);
 	if (jobj)
 		json_object_object_add(jfirmware, "can_update", jobj);
 
+
 	next = ndctl_cmd_fw_info_get_updated_version(cmd);
 	if (next == ULLONG_MAX) {
 		jobj = util_json_object_hex(-1, flags);
@@ -208,16 +256,61 @@ struct json_object *util_dimm_firmware_to_json(struct ndctl_dimm *dimm,
 		goto out;
 	}
 
-	if (next != 0) {
-		jobj = util_json_object_hex(next, flags);
-		if (jobj)
-			json_object_object_add(jfirmware,
-					"next_version", jobj);
+	if (!next)
+		goto out;
+
+	jobj = util_json_object_hex(next, flags);
+	if (jobj)
+		json_object_object_add(jfirmware,
+				"next_version", jobj);
+
+	state = ndctl_dimm_get_fw_activate_state(dimm);
+	switch (state) {
+	case NDCTL_FWA_IDLE:
+		jobj = json_object_new_string("idle");
+		break;
+	case NDCTL_FWA_ARMED:
+		jobj = json_object_new_string("armed");
+		break;
+	case NDCTL_FWA_BUSY:
+		jobj = json_object_new_string("busy");
+		break;
+	default:
+		jobj = NULL;
+		break;
+	}
+	if (jobj)
+		json_object_object_add(jfirmware, "activate_state", jobj);
+
+	result = ndctl_dimm_get_fw_activate_result(dimm);
+	switch (result) {
+	case NDCTL_FWA_RESULT_NONE:
+	case NDCTL_FWA_RESULT_SUCCESS:
+	case NDCTL_FWA_RESULT_NOTSTAGED:
+		/*
+		 * If a 'next' firmware version is staged then this
+		 * result is stale, if the activation succeeds that is
+		 * indicated by not finding a 'next' entry.
+		 */
+		need_powercycle = false;
+		break;
+	case NDCTL_FWA_RESULT_NEEDRESET:
+	case NDCTL_FWA_RESULT_FAIL:
+	default:
+		/*
+		 * If the last activation failed, or if the activation
+		 * result is unavailable it is always the case that the
+		 * only remediation is powercycle.
+		 */
+		need_powercycle = true;
+		break;
+	}
 
+	if (need_powercycle) {
 		jobj = json_object_new_boolean(true);
-		if (jobj)
-			json_object_object_add(jfirmware,
-					"need_powercycle", jobj);
+		if (!jobj)
+			goto out;
+		json_object_object_add(jfirmware, "need_powercycle", jobj);
 	}
 
 	ndctl_cmd_unref(cmd);
diff --git a/util/json.h b/util/json.h
index fc91a8db034f..39a33789bac9 100644
--- a/util/json.h
+++ b/util/json.h
@@ -32,7 +32,8 @@ enum util_json_flags {
 struct json_object;
 void util_display_json_array(FILE *f_out, struct json_object *jarray,
 		unsigned long flags);
-struct json_object *util_bus_to_json(struct ndctl_bus *bus);
+struct json_object *util_bus_to_json(struct ndctl_bus *bus,
+		unsigned long flags);
 struct json_object *util_dimm_to_json(struct ndctl_dimm *dimm,
 		unsigned long flags);
 struct json_object *util_mapping_to_json(struct ndctl_mapping *mapping,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

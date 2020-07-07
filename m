Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA9B216439
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:57:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7153D1108DED2;
	Mon,  6 Jul 2020 19:57:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0B7F81108DED0
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:57:22 -0700 (PDT)
IronPort-SDR: yPOyp93AX40KKAOTyHsI+ZRCXz0T3/J45B82v/5HQrKQvYvbwrfhcJL3yn5qutmeFfWABvm2Ok
 7l5ftDZ1JxkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212503450"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="212503450"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:21 -0700
IronPort-SDR: FD2YvUV+bgElgAmfQc/fufJVVKiknvqolYPxzMwir6kq8idja3YmCJNUTC6apMTtrgySNY3dCC
 QA8TxJ5dBwtg==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="388367356"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:21 -0700
Subject: [ndctl PATCH 09/16] ndctl/dimm: Auto-arm firmware activation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:41:05 -0700
Message-ID: <159408966593.2386154.14767450894949502125.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: YS4HZKROB7YPE2GCCF5AJTBOS7IWCDKN
X-Message-ID-Hash: YS4HZKROB7YPE2GCCF5AJTBOS7IWCDKN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YS4HZKROB7YPE2GCCF5AJTBOS7IWCDKN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an option to control firmware-activation arming and enable it by
default. The arming process checks for the "arm overflow" condition and
disarms dimms if the last arming caused the overflow to be indicated. The
--force option skips checking for arm-overflow. The --disarm option toggles
arming off and can be specified without a firmware-image to just perform
the disarm operation in isolation.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-update-firmware.txt |   16 +++
 ndctl/dimm.c                                  |  125 +++++++++++++++++++++++--
 ndctl/lib/libndctl.c                          |   33 +++++++
 ndctl/lib/libndctl.sym                        |    2 
 ndctl/libndctl.h                              |    2 
 5 files changed, 166 insertions(+), 12 deletions(-)

diff --git a/Documentation/ndctl/ndctl-update-firmware.txt b/Documentation/ndctl/ndctl-update-firmware.txt
index bcf61abaa989..1080d62a20b9 100644
--- a/Documentation/ndctl/ndctl-update-firmware.txt
+++ b/Documentation/ndctl/ndctl-update-firmware.txt
@@ -50,7 +50,21 @@ include::xable-bus-options.txt[]
 -i::
 --force::
 	Ignore in-progress Address Range Scrub and try to submit the
-	firmware update.
+	firmware update, or ignore firmware activate arm overflows and
+	force-arm devices.
+
+-A::
+--arm::
+	Arm a device for firmware activation. This is enabled by default
+	when a firmware image is specified. Specify --no-arm to disable
+	this default. Otherwise, without a firmware image, this option can be
+	used to manually arm a device for firmware activate.
+
+-D::
+--disarm::
+	Disarm devices after uploading the firmware file, or manually
+	disarm devices when a firmware image is not specified.
+	--no-disarm is not accepted.
 
 -v::
 --verbose::
diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index e02f5dfdb889..90eb0b8013ae 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -59,10 +59,15 @@ static struct parameters {
 	bool master_pass;
 	bool human;
 	bool force;
+	bool arm;
+	bool arm_set;
+	bool disarm;
+	bool disarm_set;
 	bool index;
 	bool json;
 	bool verbose;
 } param = {
+	.arm = true,
 	.labelversion = "1.1",
 };
 
@@ -694,6 +699,72 @@ out:
 	return rc;
 }
 
+static enum ndctl_fwa_state fw_update_arm(struct ndctl_dimm *dimm)
+{
+	struct ndctl_bus *bus = ndctl_dimm_get_bus(dimm);
+	const char *devname = ndctl_dimm_get_devname(dimm);
+	enum ndctl_fwa_state state = ndctl_bus_get_fw_activate_state(bus);
+
+	if (state == NDCTL_FWA_INVALID) {
+		if (param.verbose)
+			err("%s: firmware activate capability not found\n",
+					devname);
+		return NDCTL_FWA_INVALID;
+	}
+
+	if (state == NDCTL_FWA_ARM_OVERFLOW && !param.force) {
+		err("%s: overflow detected skip arm\n", devname);
+		return NDCTL_FWA_INVALID;
+	}
+
+	state = ndctl_dimm_fw_activate_arm(dimm);
+	if (state != NDCTL_FWA_ARMED) {
+		err("%s: failed to arm\n", devname);
+		return NDCTL_FWA_INVALID;
+	}
+
+	if (param.force)
+		return state;
+
+	state = ndctl_bus_get_fw_activate_state(bus);
+	if (state == NDCTL_FWA_ARM_OVERFLOW) {
+		err("%s: arm aborted, tripped overflow\n", devname);
+		ndctl_dimm_fw_activate_disarm(dimm);
+		return NDCTL_FWA_INVALID;
+	}
+	return NDCTL_FWA_ARMED;
+}
+
+#define ARM_FAILURE_FATAL (1)
+#define ARM_FAILURE_OK (0)
+
+static int fw_update_toggle_arm(struct ndctl_dimm *dimm,
+		struct json_object *jdimms, bool arm_fatal)
+{
+	enum ndctl_fwa_state state;
+	struct json_object *jobj;
+	unsigned long flags;
+
+	if (param.disarm)
+		state = ndctl_dimm_fw_activate_disarm(dimm);
+	else if (param.arm)
+		state = fw_update_arm(dimm);
+	else
+		state = NDCTL_FWA_INVALID;
+
+	if (state == NDCTL_FWA_INVALID && arm_fatal)
+		return -ENXIO;
+
+	flags = UTIL_JSON_FIRMWARE;
+	if (isatty(1))
+		flags |= UTIL_JSON_HUMAN;
+	jobj = util_dimm_to_json(dimm, flags);
+	if (jobj)
+		json_object_array_add(jdimms, jobj);
+
+	return 0;
+}
+
 static int query_fw_finish_status(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
@@ -701,10 +772,8 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 	struct update_context *uctx = &actx->update;
 	struct fw_info *fw = &uctx->dimm_fw;
 	struct timespec now, before, after;
-	struct json_object *jobj;
 	enum ND_FW_STATUS status;
 	struct ndctl_cmd *cmd;
-	unsigned long flags;
 	uint64_t ver;
 	int rc;
 
@@ -765,12 +834,13 @@ again:
 			goto unref;
 		}
 
-		flags = UTIL_JSON_FIRMWARE;
-		if (isatty(1))
-			flags |= UTIL_JSON_HUMAN;
-		jobj = util_dimm_to_json(dimm, flags);
-		if (jobj)
-			json_object_array_add(actx->jdimms, jobj);
+		/*
+		 * Now try to arm/disarm firmware activation if
+		 * requested.  Failure to toggle the arm state is not
+		 * fatal, the success / failure will be inferred from
+		 * the emitted json state.
+		 */
+		fw_update_toggle_arm(dimm, actx->jdimms, ARM_FAILURE_OK);
 		rc = 0;
 		break;
 	case FW_EBADFW:
@@ -846,6 +916,10 @@ static int action_update(struct ndctl_dimm *dimm, struct action_context *actx)
 	const char *devname = ndctl_dimm_get_devname(dimm);
 	int rc;
 
+	if (!param.infile)
+		return fw_update_toggle_arm(dimm, actx->jdimms,
+				ARM_FAILURE_FATAL);
+
 	rc = ndctl_dimm_fw_update_supported(dimm);
 	switch (rc) {
 	case -ENOTTY:
@@ -1090,7 +1164,11 @@ OPT_STRING('i', "input", &param.infile, "input-file", \
 #define UPDATE_OPTIONS() \
 OPT_STRING('f', "firmware", &param.infile, "firmware-file", \
 	"firmware filename for update"), \
-OPT_BOOLEAN('i', "force", &param.force, "ignore ARS status, try to force update")
+OPT_BOOLEAN('i', "force", &param.force, "ignore ARS / arm status, try to force update"), \
+OPT_BOOLEAN_SET('A', "arm", &param.arm, &param.arm_set, \
+	"arm device for firmware activation (default)"), \
+OPT_BOOLEAN_SET('D', "disarm", &param.disarm, &param.disarm_set, \
+	"disarm device for firmware activation")
 
 #define INIT_OPTIONS() \
 OPT_BOOLEAN('f', "force", &param.force, \
@@ -1237,10 +1315,35 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 		}
 	}
 
+	if (param.arm_set && param.disarm_set) {
+		fprintf(stderr, "set either --arm, or --disarm, not both\n");
+		usage_with_options(u, options);
+	}
+
+	if (param.disarm_set && !param.disarm) {
+		fprintf(stderr, "--no-disarm syntax not supported\n");
+		usage_with_options(u, options);
+		return -EINVAL;
+	}
+
 	if (!param.infile) {
+		/*
+		 * Update needs an infile unless we are only being
+		 * called to toggle the arm state. Other actions either
+		 * do no need an input file, or are prepared for stdin.
+		 */
 		if (action == action_update) {
-			usage_with_options(u, options);
-			return -EINVAL;
+			if (!param.arm_set && !param.disarm_set) {
+				fprintf(stderr, "require --arm, or --disarm\n");
+				usage_with_options(u, options);
+				return -EINVAL;
+			}
+
+			if (param.arm_set && !param.arm) {
+				fprintf(stderr, "--no-arm syntax not supported\n");
+				usage_with_options(u, options);
+				return -EINVAL;
+			}
 		}
 		actx.f_in = stdin;
 	} else {
diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index f03635e99a83..d11b05f113d5 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -2097,6 +2097,39 @@ NDCTL_EXPORT int ndctl_dimm_enable(struct ndctl_dimm *dimm)
 	return 0;
 }
 
+static int dimm_set_arm(struct ndctl_dimm *dimm, bool arm)
+{
+	struct ndctl_ctx *ctx = ndctl_dimm_get_ctx(dimm);
+	char *path = dimm->dimm_buf;
+	int len = dimm->buf_len;
+
+	if (dimm->fwa_state == NDCTL_FWA_INVALID)
+		return NDCTL_FWA_INVALID;
+
+	if (snprintf(path, len, "%s/firmware_activate",
+				dimm->dimm_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				ndctl_dimm_get_devname(dimm));
+		return NDCTL_FWA_INVALID;
+	}
+
+	if (sysfs_write_attr(ctx, path, arm ? "arm" : "disarm") < 0)
+		return NDCTL_FWA_INVALID;
+	return NDCTL_FWA_ARMED;
+}
+
+NDCTL_EXPORT enum ndctl_fwa_state ndctl_dimm_fw_activate_disarm(
+		struct ndctl_dimm *dimm)
+{
+	return dimm_set_arm(dimm, false);
+}
+
+NDCTL_EXPORT enum ndctl_fwa_state ndctl_dimm_fw_activate_arm(
+		struct ndctl_dimm *dimm)
+{
+	return dimm_set_arm(dimm, true);
+}
+
 NDCTL_EXPORT enum ndctl_fwa_state ndctl_dimm_get_fw_activate_state(
 		struct ndctl_dimm *dimm)
 {
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index 37217036b0d8..269ac8693304 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -437,4 +437,6 @@ LIBNDCTL_24 {
 	ndctl_dimm_get_fw_activate_result;
 	ndctl_bus_get_fw_activate_state;
 	ndctl_bus_get_fw_activate_method;
+	ndctl_dimm_fw_activate_disarm;
+	ndctl_dimm_fw_activate_arm;
 } LIBNDCTL_23;
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index e66a52029481..04ca127767ac 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -729,6 +729,8 @@ enum ndctl_fwa_result {
 
 enum ndctl_fwa_state ndctl_dimm_get_fw_activate_state(struct ndctl_dimm *dimm);
 enum ndctl_fwa_result ndctl_dimm_get_fw_activate_result(struct ndctl_dimm *dimm);
+enum ndctl_fwa_state ndctl_dimm_fw_activate_disarm(struct ndctl_dimm *dimm);
+enum ndctl_fwa_state ndctl_dimm_fw_activate_arm(struct ndctl_dimm *dimm);
 
 int ndctl_cmd_xlat_firmware_status(struct ndctl_cmd *cmd);
 int ndctl_cmd_submit_xlat(struct ndctl_cmd *cmd);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

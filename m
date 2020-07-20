Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22F4227354
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 01:54:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B785F1243B19D;
	Mon, 20 Jul 2020 16:54:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 81B361243B19D
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 16:54:24 -0700 (PDT)
IronPort-SDR: bkAaRHr4JZZ6GO3FaQpRQW/YTPA109nSFxjg8cHgOBi8D2Ju0mpeoOZ5bRqvtXN21/hB0I0qbW
 m5LUsYUfqSfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="138128841"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="138128841"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 16:54:24 -0700
IronPort-SDR: gRougdFoO9ekmpXqRhaFXXT8Krn4Fr3H/wWpjbbBZC7n81v1DNupyMW1pOX/RAm4j0CrGqKo7j
 WVRR2JNnkC9g==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="283685143"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 16:54:24 -0700
Subject: [ndctl PATCH v2 3/4] ndctl/bus: Add 'activate-firmware' command
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 20 Jul 2020 16:38:07 -0700
Message-ID: <159528828747.994840.13953549435151179969.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159528827109.994840.13180558014653471832.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159528827109.994840.13180558014653471832.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: BHGIL6KIQPWUEZ6OXTRZYNOFL6VE3RRM
X-Message-ID-Hash: BHGIL6KIQPWUEZ6OXTRZYNOFL6VE3RRM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BHGIL6KIQPWUEZ6OXTRZYNOFL6VE3RRM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For platforms where firmware can be activated at runtime, trigger
that activation. The activation method, or system context while the
activation is performed is determined by the driver between "suspend" and
"live". Where "live" has no memory controller side-effects during the
activation and "suspend" indicates that the platform will take the memory
controller offline for a short period of time.

An override, to attempt "live" activation, is implemented in the --force
option to activate-firmware.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/Makefile.am                 |    3 
 Documentation/ndctl/ndctl-activate-firmware.txt |  146 +++++++++++++++++++++
 ndctl/action.h                                  |    1 
 ndctl/builtin.h                                 |    1 
 ndctl/bus.c                                     |  158 ++++++++++++++++++++++-
 ndctl/lib/libndctl.c                            |   86 +++++++++++++
 ndctl/lib/libndctl.sym                          |    5 +
 ndctl/libndctl.h                                |    5 +
 ndctl/ndctl.c                                   |    1 
 9 files changed, 397 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ndctl/ndctl-activate-firmware.txt

diff --git a/Documentation/ndctl/Makefile.am b/Documentation/ndctl/Makefile.am
index b8e239107ff9..0278c783ea66 100644
--- a/Documentation/ndctl/Makefile.am
+++ b/Documentation/ndctl/Makefile.am
@@ -57,7 +57,8 @@ man1_MANS = \
 	ndctl-load-keys.1 \
 	ndctl-wait-overwrite.1 \
 	ndctl-read-infoblock.1 \
-	ndctl-write-infoblock.1
+	ndctl-write-infoblock.1 \
+	ndctl-activate-firmware.1
 
 EXTRA_DIST = $(man1_MANS)
 
diff --git a/Documentation/ndctl/ndctl-activate-firmware.txt b/Documentation/ndctl/ndctl-activate-firmware.txt
new file mode 100644
index 000000000000..bff534ed358a
--- /dev/null
+++ b/Documentation/ndctl/ndctl-activate-firmware.txt
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+
+ndctl-activate-firmware(1)
+==========================
+
+NAME
+----
+ndctl-activate-firmware - activate staged firmware on memory devices
+
+SYNOPSIS
+--------
+[verse]
+'ndctl activate-firmware' [<bus-id> <bus-id2> ... <bus-idN>] [<options>]
+
+Some persistent memory devices run a firmware locally on the device /
+"DIMM" to perform tasks like media management, capacity provisioning,
+and health monitoring. The process of updating that firmware typically
+involves a reboot because it has implications for in-flight memory
+transactions. However, reboots can be costly for systems that can not
+tolerate extended downtime.
+
+The kernel detects platforms that expose support for
+runtime-firmware-activation (FWA). The 'ndctl update-firmware' stages
+new firmware binaries, but if the platform supports FWA it will
+additionally arm the devices for activation. Then 'ndctl
+activate-firmware' may attempt to activate the firmware live. However,
+if the platform indicates that the memory controller will be taken
+off-line for the duration of the update "activate_method == suspend"
+then the default policy for firmware activation is to inject a truncated
+hibernate cycle to freeze devices and applications before the hard
+quiesce is injected by the platform, and then resume the system.
+
+*DANGER* the activate-firmware command includes a --force option to tell
+the driver bypass the hibernation cycle and perform the update "live".
+I.e. it arranges for applications and devices to race the platform
+injected quiesce period. This option should only be used explicit
+knowledge that the platform quiesce time will not trigger completion
+timeout violations for any devices in the system.
+
+EXAMPLES
+--------
+
+Check for any buses that support activation without triggering an
+activation:
+
+----
+# ndctl activate-firmware all --dry-run
+ACPI.NFIT: ndbus1: has no devices that support firmware update.
+nfit_test.1: ndbus3: has no devices that support firmware update.
+e820: ndbus0: has no devices that support firmware update.
+[
+  {
+    "provider":"nfit_test.0",
+    "dev":"ndbus1",
+    "scrub_state":"idle",
+    "firmware":{
+      "activate_method":"suspend",
+      "activate_state":"idle"
+    },
+    "dimms":[
+      {
+...
+----
+
+
+Check that a specific bus supports activation without performing an activation:
+
+----
+# ndctl activate-firmware nfit_test.0 --dry-run --force
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
+...
+]
+----
+
+The result is equivalent to 'ndctl list -BFDu' upon successful
+activation.
+
+The 'ndctl list' command can also enumerate the default activation
+method:
+
+----
+# ndctl list -b nfit_test.0 -BF
+[
+  {
+    "provider":"nfit_test.0",
+    "dev":"ndbus2",
+    "scrub_state":"idle",
+    "firmware":{
+      "activate_method":"suspend",
+      "activate_state":"idle"
+    }
+  }
+]
+----
+
+OPTIONS
+-------
+-n::
+--dry-run::
+	Perform all actions related to activation including honoring
+	--idle and --force, but skip the final execution of the
+	activation. The overrides are undone before the command
+	completes. Any failed overrides will be reported as error
+	messages.
+
+-I::
+--idle::
+	Implied by default, this option controls whether the platform
+	will attempt to increase the completion timeout of all devices
+	in the system and validate that the max completion timeout
+	satisfies the time needed to perform the activation. This
+	validation step can be overridden by specifying --no-idle.
+
+-f::
+--force::
+	The activation method defaults to the reported
+	"bus.firmware.activate_method" property. When the method is
+	"live" then this --force option is ignored. When the method is
+	"reset" no runtime activation is attempted. When the method is
+	"suspend" this option indicates to the driver to bypass the
+	hibernate cycle to activate firmware.  in the bus When the
+	reported "activate_method" is "suspend" the kernel driver may
+	support overriding the suspend requirement and instead issue the
+	firmware-activation live. *CAUTION* this may lead to undefined
+	system behavior if device completion timeouts are violated for
+	in-flight memory operations.
+
+-v::
+--verbose::
+	Emit debug messages for the firmware activation procedure
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkndctl:ndctl-update-firmware[1],
+https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf[Intel Optane PMem DSM Interface]
diff --git a/ndctl/action.h b/ndctl/action.h
index bcf6bf3196c6..51f8ee6f4bce 100644
--- a/ndctl/action.h
+++ b/ndctl/action.h
@@ -14,6 +14,7 @@ enum device_action {
 	ACTION_WAIT,
 	ACTION_START,
 	ACTION_CLEAR,
+	ACTION_ACTIVATE,
 	ACTION_READ_INFOBLOCK,
 	ACTION_WRITE_INFOBLOCK,
 };
diff --git a/ndctl/builtin.h b/ndctl/builtin.h
index 8aeada86c1a7..5de7379ce1b4 100644
--- a/ndctl/builtin.h
+++ b/ndctl/builtin.h
@@ -24,6 +24,7 @@ int cmd_init_labels(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_check_labels(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_inject_error(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_wait_scrub(int argc, const char **argv, struct ndctl_ctx *ctx);
+int cmd_activate_firmware(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_start_scrub(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_list(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx);
diff --git a/ndctl/bus.c b/ndctl/bus.c
index 6d5bafb86fe4..47053c8af389 100644
--- a/ndctl/bus.c
+++ b/ndctl/bus.c
@@ -10,14 +10,19 @@
 #include <util/json.h>
 #include <util/filter.h>
 #include <json-c/json.h>
-#include <util/parse-options.h>
 #include <ndctl/libndctl.h>
+#include <util/parse-options.h>
 #include <ccan/array_size/array_size.h>
 
 static struct {
 	bool verbose;
+	bool force;
+	bool idle;
+	bool dryrun;
 	unsigned int poll_interval;
-} param;
+} param = {
+	.idle = true,
+};
 
 
 #define BASE_OPTIONS() \
@@ -26,6 +31,13 @@ static struct {
 #define WAIT_OPTIONS() \
 	OPT_UINTEGER('p', "poll", &param.poll_interval, "poll interval (seconds)")
 
+#define ACTIVATE_OPTIONS() \
+	OPT_BOOLEAN('I', "idle", &param.idle, \
+			"allow platform-injected idle over activate (default)"), \
+	OPT_BOOLEAN('f', "force", &param.force, "try to force live activation"), \
+	OPT_BOOLEAN('n', "dry-run", &param.dryrun, \
+			"perform all setup/validation steps, skip the activate")
+
 static const struct option start_options[] = {
 	BASE_OPTIONS(),
 	OPT_END(),
@@ -37,6 +49,82 @@ static const struct option wait_options[] = {
 	OPT_END(),
 };
 
+static const struct option activate_options[] = {
+	BASE_OPTIONS(),
+	ACTIVATE_OPTIONS(),
+	OPT_END(),
+};
+
+static int activate_firmware(struct ndctl_bus *bus)
+{
+	const char *provider = ndctl_bus_get_provider(bus);
+	const char *devname = ndctl_bus_get_devname(bus);
+	enum ndctl_fwa_method method;
+	bool do_clear_noidle = false;
+	enum ndctl_fwa_state state;
+	struct ndctl_dimm *dimm;
+	bool has_fwupd = false;
+	int rc;
+
+	ndctl_dimm_foreach(bus, dimm) {
+		rc = ndctl_dimm_fw_update_supported(dimm);
+		if (rc == 0) {
+			has_fwupd = true;
+			break;
+		}
+	}
+
+	if (!has_fwupd) {
+		fprintf(stderr, "%s: %s: has no devices that support firmware update.\n",
+				provider, devname);
+		return -EOPNOTSUPP;
+	}
+
+	method = ndctl_bus_get_fw_activate_method(bus);
+	if (method == NDCTL_FWA_METHOD_RESET) {
+		fprintf(stderr, "%s: %s: requires a platform reset to activate firmware\n",
+				provider, devname);
+		return -EOPNOTSUPP;
+	}
+
+	if (!param.idle) {
+		rc = ndctl_bus_set_fw_activate_noidle(bus);
+		if (rc) {
+			fprintf(stderr, "%s: %s: failed to disable platform idling.\n",
+					provider, devname);
+			/* not fatal, continue... */
+		}
+		do_clear_noidle = true;
+	}
+
+	if (method == NDCTL_FWA_METHOD_SUSPEND && param.force)
+		method = NDCTL_FWA_METHOD_LIVE;
+
+	rc = 0;
+	if (!param.dryrun) {
+		state = ndctl_bus_get_fw_activate_state(bus);
+		if (state != NDCTL_FWA_ARMED && state != NDCTL_FWA_ARM_OVERFLOW) {
+			fprintf(stderr, "%s: %s: no devices armed\n",
+					provider, devname);
+			rc = -ENXIO;
+			goto out;
+		}
+
+		rc = ndctl_bus_activate_firmware(bus, method);
+	}
+
+	if (rc) {
+		fprintf(stderr, "%s: %s: firmware activation failed (%s)\n",
+				provider, devname, strerror(-rc));
+		goto out;
+	}
+
+out:
+	if (do_clear_noidle)
+		ndctl_bus_clear_fw_activate_noidle(bus);
+	return rc;
+}
+
 static int scrub_action(struct ndctl_bus *bus, enum device_action action)
 {
 	switch (action) {
@@ -50,6 +138,36 @@ static int scrub_action(struct ndctl_bus *bus, enum device_action action)
 	}
 }
 
+static void collect_result(struct json_object *jbuses, struct ndctl_bus *bus,
+		enum device_action action)
+{
+	unsigned long flags = UTIL_JSON_FIRMWARE | UTIL_JSON_HUMAN;
+	struct json_object *jbus, *jdimms;
+	struct ndctl_dimm *dimm;
+
+	jbus = util_bus_to_json(bus, flags);
+	if (jbus)
+		json_object_array_add(jbuses, jbus);
+	if (action != ACTION_ACTIVATE)
+		return;
+
+	jdimms = json_object_new_array();
+	if (!jdimms)
+		return;
+
+	ndctl_dimm_foreach(bus, dimm) {
+		struct json_object *jdimm;
+
+		jdimm = util_dimm_to_json(dimm, flags);
+		if (jdimm)
+			json_object_array_add(jdimms, jdimm);
+	}
+	if (json_object_array_length(jdimms) > 0)
+		json_object_object_add(jbus, "dimms", jdimms);
+	else
+		json_object_put(jdimms);
+}
+
 static int bus_action(int argc, const char **argv, const char *usage,
 		const struct option *options, enum device_action action,
 		struct ndctl_ctx *ctx)
@@ -58,8 +176,8 @@ static int bus_action(int argc, const char **argv, const char *usage,
 		usage,
 		NULL
 	};
-	struct json_object *jbuses, *jbus;
 	int i, rc, success = 0, fail = 0;
+	struct json_object *jbuses;
 	struct ndctl_bus *bus;
 	const char *all = "all";
 
@@ -89,21 +207,31 @@ static int bus_action(int argc, const char **argv, const char *usage,
 			if (!util_bus_filter(bus, argv[i]))
 				continue;
 			found++;
-			rc = scrub_action(bus, action);
+			switch (action) {
+			case ACTION_WAIT:
+			case ACTION_START:
+				rc = scrub_action(bus, action);
+				break;
+			case ACTION_ACTIVATE:
+				rc = activate_firmware(bus);
+				break;
+			default:
+				rc = -EINVAL;
+			}
+
 			if (rc == 0) {
 				success++;
-				jbus = util_bus_to_json(bus, 0);
-				if (jbus)
-					json_object_array_add(jbuses, jbus);
+				collect_result(jbuses, bus, action);
 			} else if (!fail)
 				fail = rc;
+
 		}
 		if (!found && param.verbose)
 			fprintf(stderr, "no bus matches id: %s\n", argv[i]);
 	}
 
 	if (success)
-		util_display_json_array(stdout, jbuses, 0);
+		util_display_json_array(stdout, jbuses, UTIL_JSON_FIRMWARE);
 	else
 		json_object_put(jbuses);
 
@@ -141,3 +269,17 @@ int cmd_wait_scrub(int argc, const char **argv, struct ndctl_ctx *ctx)
 		return 0;
 	}
 }
+
+int cmd_activate_firmware(int argc, const char **argv, struct ndctl_ctx *ctx)
+{
+	char *usage = "ndctl activate-firmware[<bus-id> <bus-id2> ... <bus-idN>] [<options>]";
+	int rc = bus_action(argc, argv, usage, activate_options,
+			ACTION_ACTIVATE, ctx);
+
+	if (rc <= 0) {
+		fprintf(stderr, "error activating firmware: %s\n",
+				strerror(-rc));
+		return rc;
+	}
+	return 0;
+}
diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index a4bca6d05022..0c9ca0763082 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1504,6 +1504,92 @@ NDCTL_EXPORT enum ndctl_fwa_method ndctl_bus_get_fw_activate_method(struct ndctl
 	return bus->fwa_method;
 }
 
+NDCTL_EXPORT int ndctl_bus_activate_firmware(struct ndctl_bus *bus, enum ndctl_fwa_method method)
+{
+	struct ndctl_ctx *ctx = ndctl_bus_get_ctx(bus);
+	char *path = bus->bus_buf;
+	char buf[SYSFS_ATTR_SIZE];
+	int len = bus->buf_len;
+
+	if (snprintf(path, len, "%s/firmware/activate", bus->bus_path) >= len) {
+		err(ctx, "%s: buffer too small!\n", ndctl_bus_get_devname(bus));
+		return -ENOMEM;
+	}
+
+	switch (method) {
+	case NDCTL_FWA_METHOD_LIVE:
+	case NDCTL_FWA_METHOD_SUSPEND:
+		break;
+	default:
+		err(ctx, "%s: method: %d invalid\n", ndctl_bus_get_devname(bus), method);
+		return -EINVAL;
+	}
+
+	sprintf(buf, "%s\n", method == NDCTL_FWA_METHOD_LIVE ? "live" : "quiesce");
+
+	return sysfs_write_attr(ctx, path, buf);
+}
+
+static int write_fw_activate_noidle(struct ndctl_bus *bus, int arg)
+{
+	struct ndctl_ctx *ctx = ndctl_bus_get_ctx(bus);
+	char *path = bus->bus_buf;
+	char buf[SYSFS_ATTR_SIZE];
+	int len = bus->buf_len;
+
+	if (!ndctl_bus_has_nfit(bus))
+		return -EOPNOTSUPP;
+
+	if (snprintf(path, len, "%s/nfit/firmware_activate_noidle", bus->bus_path) >= len) {
+		err(ctx, "%s: buffer too small!\n", ndctl_bus_get_devname(bus));
+		return -ENOMEM;
+	}
+
+	sprintf(buf, "%d\n", arg);
+
+	return sysfs_write_attr(ctx, path, buf);
+}
+
+NDCTL_EXPORT int ndctl_bus_set_fw_activate_noidle(struct ndctl_bus *bus)
+{
+	return write_fw_activate_noidle(bus, 1);
+}
+
+NDCTL_EXPORT int ndctl_bus_clear_fw_activate_noidle(struct ndctl_bus *bus)
+{
+	return write_fw_activate_noidle(bus, 0);
+}
+
+static int write_fw_activate_nosuspend(struct ndctl_bus *bus, int arg)
+{
+	struct ndctl_ctx *ctx = ndctl_bus_get_ctx(bus);
+	char *path = bus->bus_buf;
+	char buf[SYSFS_ATTR_SIZE];
+	int len = bus->buf_len;
+
+	if (!ndctl_bus_has_nfit(bus))
+		return -EOPNOTSUPP;
+
+	if (snprintf(path, len, "%s/nfit/firmware_activate_nosuspend", bus->bus_path) >= len) {
+		err(ctx, "%s: buffer too small!\n", ndctl_bus_get_devname(bus));
+		return -ENOMEM;
+	}
+
+	sprintf(buf, "%d\n", arg);
+
+	return sysfs_write_attr(ctx, path, buf);
+}
+
+NDCTL_EXPORT int ndctl_bus_set_fw_activate_nosuspend(struct ndctl_bus *bus)
+{
+	return write_fw_activate_nosuspend(bus, 1);
+}
+
+NDCTL_EXPORT int ndctl_bus_clear_fw_activate_nosuspend(struct ndctl_bus *bus)
+{
+	return write_fw_activate_nosuspend(bus, 0);
+}
+
 static enum ndctl_fwa_result fwa_result_to_result(const char *result)
 {
 	if (strcmp(result, "none") == 0)
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index 269ac8693304..97353fe071e7 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -439,4 +439,9 @@ LIBNDCTL_24 {
 	ndctl_bus_get_fw_activate_method;
 	ndctl_dimm_fw_activate_disarm;
 	ndctl_dimm_fw_activate_arm;
+	ndctl_bus_set_fw_activate_noidle;
+	ndctl_bus_clear_fw_activate_noidle;
+	ndctl_bus_set_fw_activate_nosuspend;
+	ndctl_bus_clear_fw_activate_nosuspend;
+	ndctl_bus_activate_firmware;
 } LIBNDCTL_23;
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 04ca127767ac..9491b2602254 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -155,6 +155,11 @@ int ndctl_bus_start_scrub(struct ndctl_bus *bus);
 int ndctl_bus_has_error_injection(struct ndctl_bus *bus);
 enum ndctl_fwa_state ndctl_bus_get_fw_activate_state(struct ndctl_bus *bus);
 enum ndctl_fwa_method ndctl_bus_get_fw_activate_method(struct ndctl_bus *bus);
+int ndctl_bus_set_fw_activate_noidle(struct ndctl_bus *bus);
+int ndctl_bus_clear_fw_activate_noidle(struct ndctl_bus *bus);
+int ndctl_bus_set_fw_activate_nosuspend(struct ndctl_bus *bus);
+int ndctl_bus_clear_fw_activate_nosuspend(struct ndctl_bus *bus);
+int ndctl_bus_activate_firmware(struct ndctl_bus *bus, enum ndctl_fwa_method method);
 
 struct ndctl_dimm;
 struct ndctl_dimm *ndctl_dimm_get_first(struct ndctl_bus *bus);
diff --git a/ndctl/ndctl.c b/ndctl/ndctl.c
index 58cc9c7bb07e..eb5d8392d8e4 100644
--- a/ndctl/ndctl.c
+++ b/ndctl/ndctl.c
@@ -90,6 +90,7 @@ static struct cmd_struct commands[] = {
 	{ "update-firmware", { cmd_update_firmware } },
 	{ "inject-smart", { cmd_inject_smart } },
 	{ "wait-scrub", { cmd_wait_scrub } },
+	{ "activate-firmware", { cmd_activate_firmware } },
 	{ "start-scrub", { cmd_start_scrub } },
 	{ "setup-passphrase", { cmd_setup_passphrase } },
 	{ "update-passphrase", { cmd_update_passphrase } },
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

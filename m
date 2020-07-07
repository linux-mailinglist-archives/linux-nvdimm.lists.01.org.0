Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AD721643A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:57:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 871AB1108DED3;
	Mon,  6 Jul 2020 19:57:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10F821108DED3
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:57:28 -0700 (PDT)
IronPort-SDR: 7kOsUvuJpqmkJ+dw5EMSu9sQpfE4B22LX+pehYXgEXs3C2jiEN5Zcjl9Q7cYxVN5yW2j+ASGvj
 6fUfSOBIxLzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="209052933"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="209052933"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:27 -0700
IronPort-SDR: RrtngjtSoPV4FyRH5I8HOCX5NnNTNxAZLIC33YEVXW3vUnm77XYoQQSeh3Xwu0Yoq4ziwJ5zac
 +Z3qRKa8Ikzg==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="268066912"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:27 -0700
Subject: [ndctl PATCH 10/16] ndctl/bus: Add 'activate-firmware' command
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:41:11 -0700
Message-ID: <159408967149.2386154.15486921107066818391.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: J5RQE5GE5SZNLFRFO2GTJXZRNQ2WEFJ2
X-Message-ID-Hash: J5RQE5GE5SZNLFRFO2GTJXZRNQ2WEFJ2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J5RQE5GE5SZNLFRFO2GTJXZRNQ2WEFJ2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For platforms where firmware can be activated 'live' at runtime, trigger
that activation. There may also be buses that allow live activation to be
forced with the caveat that it may inflict undefined behavior on bus master
devices actively transmitting data over the activation / platform quiesce
event. In this case the platform makes a best effort to increase
completion timeouts, but if the timeout is violated it device specific how
a device may behave after it has signaled a timeout. Use "--force" with
caution.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/Makefile.am                 |    3 
 Documentation/ndctl/ndctl-activate-firmware.txt |  130 +++++++++++++++++
 ndctl/action.h                                  |    1 
 ndctl/builtin.h                                 |    1 
 ndctl/bus.c                                     |  173 ++++++++++++++++++++++-
 ndctl/lib/libndctl.c                            |   77 ++++++++++
 ndctl/lib/libndctl.sym                          |    5 +
 ndctl/libndctl.h                                |    5 +
 ndctl/ndctl.c                                   |    1 
 9 files changed, 388 insertions(+), 8 deletions(-)
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
index 000000000000..635299fbdc8e
--- /dev/null
+++ b/Documentation/ndctl/ndctl-activate-firmware.txt
@@ -0,0 +1,130 @@
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
+off-line for the duration of the update then the default policy for
+firmware activation is to wait for a suspend/resume cycle to quiesce the
+OS before the hard queisce is injected by the platform.
+
+*DANGER* the activate-firmware command includes a --force option to
+attempt to override this "suspend-required" policy. That option should
+only be used in emergencies, or with express knowledge that the platform
+quiesce time would not trigger completion timeout violations for any
+devices in the system.
+
+EXAMPLES
+--------
+Check the activation method without triggering an activation:
+
+----
+# ndctl activate-firmware all --dry-run
+ACPI.NFIT: ndbus1: has no devices that support firmware update.
+nfit_test.1: ndbus3: has no devices that support firmware update.
+e820: ndbus0: has no devices that support firmware update.
+nfit_test.0: ndbus2: requires a platform suspend event to activate firmware
+error activating firmware: Operation not supported
+----
+
+Check that the suspend requirement can be overridden without performing
+an activation:
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
+In this case you see that the dry-run activation result is displayed
+rather than the error message. The result is equivalent to 'ndctl list
+-BFDu' upon successful activation.
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
+	Perform all actions related to activation include honoring
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
+	exceeds the time needed to perform the activation. This
+	validation step can be overridden by specifying --no-idle.
+
+-f::
+--force::
+	When the reported "activate_method" is "suspend" the kernel
+	driver may support overriding the suspend requirement and
+	instead issue the firmware-activation live. *CAUTION* this may
+	lead to undefined system behavior if completion timeouts are
+	violated for in-flight memory operations. Alternatively if
+	"activate_method" reports "live" in the absence of an override
+	it is asserting that the driver detects no adverse quiesce
+	delays are injected to activate firmware.
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
index 6d5bafb86fe4..62f1303830a1 100644
--- a/ndctl/bus.c
+++ b/ndctl/bus.c
@@ -16,8 +16,13 @@
 
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
+			"attempt platform idle over activate (default)"), \
+	OPT_BOOLEAN('f', "force", &param.force, "try to force live activation"), \
+	OPT_BOOLEAN('n', "dry-run", &param.dryrun, \
+			"perform all setup/validation steps, skip the activate")
+
 static const struct option start_options[] = {
 	BASE_OPTIONS(),
 	OPT_END(),
@@ -37,6 +49,99 @@ static const struct option wait_options[] = {
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
+	bool do_clear_nosuspend = false;
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
+	if (method == NDCTL_FWA_METHOD_SUSPEND && !param.force) {
+		fprintf(stderr, "%s: %s: requires a platform suspend event to activate firmware\n",
+				provider, devname);
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (method == NDCTL_FWA_METHOD_SUSPEND) {
+		rc = ndctl_bus_set_fw_activate_nosuspend(bus);
+		if (rc) {
+			fprintf(stderr, "%s: %s: failed to force live activation.\n",
+					provider, devname);
+			goto out;
+		}
+		do_clear_nosuspend = true;
+	}
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
+		rc = ndctl_bus_activate_firmware(bus);
+	}
+
+	if (rc) {
+		fprintf(stderr, "%s: %s: live firmware activation failed (%s)\n",
+				provider, devname, strerror(-rc));
+		goto out;
+	}
+
+out:
+	if (do_clear_noidle)
+		ndctl_bus_clear_fw_activate_noidle(bus);
+	if (do_clear_nosuspend)
+		ndctl_bus_clear_fw_activate_nosuspend(bus);
+	return rc;
+}
+
 static int scrub_action(struct ndctl_bus *bus, enum device_action action)
 {
 	switch (action) {
@@ -50,6 +155,36 @@ static int scrub_action(struct ndctl_bus *bus, enum device_action action)
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
@@ -58,8 +193,8 @@ static int bus_action(int argc, const char **argv, const char *usage,
 		usage,
 		NULL
 	};
-	struct json_object *jbuses, *jbus;
 	int i, rc, success = 0, fail = 0;
+	struct json_object *jbuses;
 	struct ndctl_bus *bus;
 	const char *all = "all";
 
@@ -89,21 +224,31 @@ static int bus_action(int argc, const char **argv, const char *usage,
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
 
@@ -141,3 +286,17 @@ int cmd_wait_scrub(int argc, const char **argv, struct ndctl_ctx *ctx)
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
index d11b05f113d5..d44ca784e631 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1508,6 +1508,83 @@ NDCTL_EXPORT enum ndctl_fwa_method ndctl_bus_get_fw_activate_method(
 	return NDCTL_FWA_METHOD_RESET;
 }
 
+NDCTL_EXPORT int ndctl_bus_activate_firmware(struct ndctl_bus *bus)
+{
+	struct ndctl_ctx *ctx = ndctl_bus_get_ctx(bus);
+	char *path = bus->bus_buf;
+	char buf[SYSFS_ATTR_SIZE];
+	int len = bus->buf_len;
+
+	if (snprintf(path, len, "%s/firmware_activate", bus->bus_path) >= len) {
+		err(ctx, "%s: buffer too small!\n", ndctl_bus_get_devname(bus));
+		return -ENOMEM;
+	}
+
+	sprintf(buf, "activate\n");
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
index 04ca127767ac..97979e6cf5aa 100644
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
+int ndctl_bus_activate_firmware(struct ndctl_bus *bus);
 
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

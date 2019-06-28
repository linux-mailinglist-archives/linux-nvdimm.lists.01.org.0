Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D718A5A4E3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 21:11:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BCC722129EB8E;
	Fri, 28 Jun 2019 12:11:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4EC8A21945DC7
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 12:11:20 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jun 2019 12:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; d="scan'208";a="173564743"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga002.jf.intel.com with ESMTP; 28 Jun 2019 12:11:19 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v5 07/13] daxctl: add a new reconfigure-device command
Date: Fri, 28 Jun 2019 13:11:04 -0600
Message-Id: <20190628191110.21428-8-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628191110.21428-1-vishal.l.verma@intel.com>
References: <20190628191110.21428-1-vishal.l.verma@intel.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add a new command 'daxctl-reconfigure-device'. This is used to switch
the mode of a dax device between regular 'device_dax' and
'system-memory'. The command also uses the memory hotplug sysfs
interfaces to online the newly available memory when converting to
'system-ram', and to attempt to offline the memory when converting back
to a DAX device.

Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/Makefile.am |   2 +
 daxctl/builtin.h   |   1 +
 daxctl/daxctl.c    |   1 +
 daxctl/device.c    | 348 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 352 insertions(+)
 create mode 100644 daxctl/device.c

diff --git a/daxctl/Makefile.am b/daxctl/Makefile.am
index 94f73f9..66dcc7f 100644
--- a/daxctl/Makefile.am
+++ b/daxctl/Makefile.am
@@ -15,10 +15,12 @@ daxctl_SOURCES =\
 		daxctl.c \
 		list.c \
 		migrate.c \
+		device.c \
 		../util/json.c
 
 daxctl_LDADD =\
 	lib/libdaxctl.la \
 	../libutil.a \
 	$(UUID_LIBS) \
+	$(KMOD_LIBS) \
 	$(JSON_LIBS)
diff --git a/daxctl/builtin.h b/daxctl/builtin.h
index 00ef5e9..756ba2a 100644
--- a/daxctl/builtin.h
+++ b/daxctl/builtin.h
@@ -6,4 +6,5 @@
 struct daxctl_ctx;
 int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_migrate(int argc, const char **argv, struct daxctl_ctx *ctx);
+int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 #endif /* _DAXCTL_BUILTIN_H_ */
diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
index 2e41747..e1ba7b8 100644
--- a/daxctl/daxctl.c
+++ b/daxctl/daxctl.c
@@ -71,6 +71,7 @@ static struct cmd_struct commands[] = {
 	{ "list", .d_fn = cmd_list },
 	{ "help", .d_fn = cmd_help },
 	{ "migrate-device-model", .d_fn = cmd_migrate },
+	{ "reconfigure-device", .d_fn = cmd_reconfig_device },
 };
 
 int main(int argc, const char **argv)
diff --git a/daxctl/device.c b/daxctl/device.c
new file mode 100644
index 0000000..a1fb698
--- /dev/null
+++ b/daxctl/device.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <syslog.h>
+#include <unistd.h>
+#include <limits.h>
+#include <util/json.h>
+#include <util/filter.h>
+#include <json-c/json.h>
+#include <daxctl/libdaxctl.h>
+#include <util/parse-options.h>
+#include <ccan/array_size/array_size.h>
+
+static struct {
+	const char *dev;
+	const char *mode;
+	int region_id;
+	bool no_online;
+	bool do_offline;
+	bool human;
+	bool verbose;
+} param = {
+	.region_id = -1,
+};
+
+static enum daxctl_dev_mode reconfig_mode = DAXCTL_DEV_MODE_UNKNOWN;
+static unsigned long flags;
+
+enum device_action {
+	ACTION_RECONFIG,
+};
+
+#define BASE_OPTIONS() \
+OPT_INTEGER('r', "region", &param.region_id, "restrict to the given region"), \
+OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats"), \
+OPT_BOOLEAN('v', "verbose", &param.verbose, "emit more debug messages")
+
+#define RECONFIG_OPTIONS() \
+OPT_STRING('m', "mode", &param.mode, "mode", "mode to switch the device to"), \
+OPT_BOOLEAN('N', "no-online", &param.no_online, \
+	"don't auto-online memory sections"), \
+OPT_BOOLEAN('O', "attempt-offline", &param.do_offline, \
+		"attempt to offline memory sections")
+
+static const struct option reconfig_options[] = {
+	BASE_OPTIONS(),
+	RECONFIG_OPTIONS(),
+	OPT_END(),
+};
+
+static const char *parse_device_options(int argc, const char **argv,
+		enum device_action action, const struct option *options,
+		const char *usage, struct daxctl_ctx *ctx)
+{
+	const char * const u[] = {
+		usage,
+		NULL
+	};
+	int i, rc = 0;
+
+	argc = parse_options(argc, argv, options, u, 0);
+
+	/* Handle action-agnostic non-option arguments */
+	if (argc == 0) {
+		char *action_string;
+
+		switch (action) {
+		case ACTION_RECONFIG:
+			action_string = "reconfigure";
+			break;
+		default:
+			action_string = "<>";
+			break;
+		}
+		fprintf(stderr, "specify a device to %s, or \"all\"\n",
+			action_string);
+		rc = -EINVAL;
+	}
+	for (i = 1; i < argc; i++) {
+		fprintf(stderr, "unknown extra parameter \"%s\"\n", argv[i]);
+		rc = -EINVAL;
+	}
+
+	if (rc) {
+		usage_with_options(u, options);
+		return NULL;
+	}
+
+	/* Handle action-agnostic options */
+	if (param.verbose)
+		daxctl_set_log_priority(ctx, LOG_DEBUG);
+	if (param.human)
+		flags |= UTIL_JSON_HUMAN;
+
+	/* Handle action-specific options */
+	switch (action) {
+	case ACTION_RECONFIG:
+		if (!param.mode) {
+			fprintf(stderr, "error: a 'mode' option is required\n");
+			usage_with_options(u, reconfig_options);
+			rc = -EINVAL;
+		}
+		if (strcmp(param.mode, "system-ram") == 0) {
+			reconfig_mode = DAXCTL_DEV_MODE_RAM;
+			if (param.do_offline) {
+				fprintf(stderr,
+					"can't --attempt-offline for system-ram mode\n");
+				rc = -EINVAL;
+			}
+		} else if (strcmp(param.mode, "devdax") == 0) {
+			reconfig_mode = DAXCTL_DEV_MODE_DEVDAX;
+			if (param.no_online) {
+				fprintf(stderr,
+					"can't --no-online for devdax mode\n");
+				rc =  -EINVAL;
+			}
+		}
+		break;
+	}
+	if (rc) {
+		usage_with_options(u, options);
+		return NULL;
+	}
+
+	return argv[0];
+}
+
+static int disable_devdax_device(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	enum daxctl_dev_mode mode;
+	int rc;
+
+	mode = daxctl_dev_get_mode(dev);
+	if (mode < 0) {
+		fprintf(stderr, "%s: unable to determine current mode: %s\n",
+			devname, strerror(-mode));
+		return mode;
+	}
+	if (mode == DAXCTL_DEV_MODE_RAM) {
+		fprintf(stderr, "%s is in system-ram mode, nothing to do\n",
+			devname);
+		return 1;
+	}
+	rc = daxctl_dev_disable(dev);
+	if (rc) {
+		fprintf(stderr, "%s: disable failed: %s\n",
+			daxctl_dev_get_devname(dev), strerror(-rc));
+		return rc;
+	}
+	return 0;
+}
+
+static int reconfig_mode_system_ram(struct daxctl_dev *dev)
+{
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
+	const char *devname = daxctl_dev_get_devname(dev);
+	int rc, skip_enable = 0;
+
+	if (daxctl_dev_is_enabled(dev)) {
+		rc = disable_devdax_device(dev);
+		if (rc < 0)
+			return rc;
+		if (rc > 0)
+			skip_enable = 1;
+	}
+
+	if (!skip_enable) {
+		rc = daxctl_dev_enable_ram(dev);
+		if (rc)
+			return rc;
+	}
+
+	if (param.no_online)
+		return 0;
+
+	rc = daxctl_memory_set_online(mem);
+	if (rc < 0) {
+		fprintf(stderr, "%s: unable to online memory: %s\n",
+			devname, strerror(-rc));
+		return rc;
+	}
+	if (param.verbose)
+		fprintf(stderr, "%s: onlined %d memory sections\n",
+			devname, rc);
+
+	return 0;
+}
+
+static int disable_system_ram_device(struct daxctl_dev *dev)
+{
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
+	const char *devname = daxctl_dev_get_devname(dev);
+	enum daxctl_dev_mode mode;
+	int rc;
+
+	mode = daxctl_dev_get_mode(dev);
+	if (mode < 0) {
+		fprintf(stderr, "%s: unable to determine current mode: %s\n",
+			devname, strerror(-mode));
+		return mode;
+	}
+	if (mode == DAXCTL_DEV_MODE_DEVDAX) {
+		fprintf(stderr, "%s: already in devdax mode, nothing to do\n",
+			devname);
+		return 1;
+	}
+
+	if (param.do_offline) {
+		rc = daxctl_memory_set_offline(mem);
+		if (rc < 0) {
+			fprintf(stderr, "%s: unable to offline memory: %s\n",
+				devname, strerror(-rc));
+			return rc;
+		}
+		if (param.verbose)
+			fprintf(stderr, "%s: offlined %d memory sections\n",
+				devname, rc);
+	}
+
+	rc = daxctl_memory_is_online(mem);
+	if (rc < 0) {
+		fprintf(stderr, "%s: unable to determine online state: %s\n",
+			devname, strerror(-rc));
+		return rc;
+	}
+	if (rc > 0) {
+		if (param.verbose) {
+			fprintf(stderr, "%s: found %d memory sections online\n",
+				devname, rc);
+			fprintf(stderr, "%s: refusing to change modes\n",
+				devname);
+		}
+		return -EBUSY;
+	}
+	rc = daxctl_dev_disable(dev);
+	if (rc) {
+		fprintf(stderr, "%s: disable failed: %s\n",
+			daxctl_dev_get_devname(dev), strerror(-rc));
+		return rc;
+	}
+	return 0;
+}
+
+static int reconfig_mode_devdax(struct daxctl_dev *dev)
+{
+	int rc;
+
+	if (daxctl_dev_is_enabled(dev)) {
+		rc = disable_system_ram_device(dev);
+		if (rc)
+			return rc;
+	}
+
+	rc = daxctl_dev_enable_devdax(dev);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int do_reconfig(struct daxctl_dev *dev, enum daxctl_dev_mode mode,
+		struct json_object *jdevs)
+{
+	struct json_object *jdev;
+	int rc = 0;
+
+	switch (mode) {
+	case DAXCTL_DEV_MODE_RAM:
+		rc = reconfig_mode_system_ram(dev);
+		break;
+	case DAXCTL_DEV_MODE_DEVDAX:
+		rc = reconfig_mode_devdax(dev);
+		break;
+	default:
+		fprintf(stderr, "%s: unknown mode requested: %d\n",
+			daxctl_dev_get_devname(dev), mode);
+		rc = -EINVAL;
+	}
+
+	jdev = util_daxctl_dev_to_json(dev, flags);
+	if (jdevs && jdev)
+		json_object_array_add(jdevs, jdev);
+
+	return rc;
+}
+
+static int do_xaction_device(const char *device, enum device_action action,
+		struct daxctl_ctx *ctx, int *processed)
+{
+	struct json_object *jdevs = json_object_new_array();
+	struct daxctl_region *region;
+	struct daxctl_dev *dev;
+	int rc = -ENXIO;
+
+	*processed = 0;
+
+	daxctl_region_foreach(ctx, region) {
+		if (param.region_id >= 0 && param.region_id
+				!= daxctl_region_get_id(region))
+			continue;
+
+		daxctl_dev_foreach(region, dev) {
+			if (!util_daxctl_dev_filter(dev, device))
+				continue;
+
+			switch (action) {
+			case ACTION_RECONFIG:
+				rc = do_reconfig(dev, reconfig_mode, jdevs);
+				if (rc == 0)
+					(*processed)++;
+				break;
+			default:
+				rc = -EINVAL;
+				break;
+			}
+		}
+	}
+
+	/*
+	 * jdevs is the containing json array for all devices we are reporting
+	 * on. It therefore needs to be outside the region/device iterators,
+	 * and passed in to the do_<action> functions to add their objects to
+	 */
+	if (jdevs)
+		util_display_json_array(stdout, jdevs, flags);
+
+	return rc;
+}
+
+int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx)
+{
+	char *usage = "daxctl reconfigure-device <device> [<options>]";
+	const char *device = parse_device_options(argc, argv, ACTION_RECONFIG,
+			reconfig_options, usage, ctx);
+	int processed, rc;
+
+	rc = do_xaction_device(device, ACTION_RECONFIG, ctx, &processed);
+	if (rc < 0)
+		fprintf(stderr, "error reconfiguring devices: %s\n",
+				strerror(-rc));
+
+	fprintf(stderr, "reconfigured %d device%s\n", processed,
+			processed == 1 ? "" : "s");
+	return rc;
+}
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

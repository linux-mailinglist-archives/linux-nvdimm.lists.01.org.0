Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265AD16E5B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 02:39:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2AFE21255849;
	Tue,  7 May 2019 17:39:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BDF6F21255825
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 17:39:21 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 May 2019 17:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,443,1549958400"; d="scan'208";a="169427688"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga002.fm.intel.com with ESMTP; 07 May 2019 17:39:21 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 07/10] daxctl: add a new reconfigure-device command
Date: Tue,  7 May 2019 18:38:48 -0600
Message-Id: <20190508003851.32416-8-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508003851.32416-1-vishal.l.verma@intel.com>
References: <20190508003851.32416-1-vishal.l.verma@intel.com>
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
 daxctl/device.c    | 237 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 241 insertions(+)
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
index 0000000..12644c5
--- /dev/null
+++ b/daxctl/device.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
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
+static int dev_disable(struct daxctl_dev *dev)
+{
+	int rc;
+
+	if (!daxctl_dev_is_enabled(dev))
+		return 0;
+
+	rc = daxctl_dev_disable(dev);
+	if (rc)
+		fprintf(stderr, "%s: disable failed: %s\n",
+			daxctl_dev_get_devname(dev), strerror(-rc));
+
+	return rc;
+}
+
+static int reconfig_mode_ram(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	int rc;
+
+	rc = dev_disable(dev);
+	if (rc)
+		return rc;
+	rc = daxctl_dev_enable_ram(dev);
+	if (rc)
+		return rc;
+
+	if (param.no_online)
+		return 0;
+
+	rc = daxctl_dev_online_node(dev);
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
+static int reconfig_mode_devdax(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	int rc;
+
+	if (param.do_offline) {
+		rc = daxctl_dev_offline_node(dev);
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
+	rc = daxctl_dev_node_is_online(dev);
+	if (rc < 0) {
+		fprintf(stderr, "%s: unable to determine node state: %s\n",
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
+
+	rc = dev_disable(dev);
+	if (rc)
+		return rc;
+
+	rc = daxctl_dev_enable_devdax(dev);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int do_reconfig(struct daxctl_dev *dev, enum daxctl_dev_mode mode)
+{
+	int rc = 0;
+
+	switch (mode) {
+	case DAXCTL_DEV_MODE_RAM:
+		rc = reconfig_mode_ram(dev);
+		break;
+	case DAXCTL_DEV_MODE_DEVDAX:
+		rc = reconfig_mode_devdax(dev);
+		break;
+	default:
+		fprintf(stderr, "%s: unknown mode: %d\n",
+			daxctl_dev_get_devname(dev), mode);
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx)
+{
+	const struct option options[] = {
+		OPT_INTEGER('r', "region", &param.region_id,
+				"restrict to the given region"),
+		OPT_STRING('m', "mode", &param.mode, "mode",
+				"mode to switch the device to"),
+		OPT_BOOLEAN('N', "no-online", &param.no_online,
+				"don't auto-online memory sections"),
+		OPT_BOOLEAN('O', "attempt-offline", &param.do_offline,
+				"attempt to offline memory sections"),
+		OPT_BOOLEAN('u', "human", &param.human,
+				"use human friendly number formats"),
+		OPT_BOOLEAN('v', "verbose", &param.verbose,
+				"emit more debug messages"),
+		OPT_END(),
+	};
+	const char * const u[] = {
+		"daxctl reconfigure-device [<options>] <device> ...",
+		NULL
+	};
+	enum daxctl_dev_mode mode = DAXCTL_DEV_MODE_UNKNOWN;
+	struct json_object *jdevs = json_object_new_array();
+	struct daxctl_region *region;
+	struct json_object *jdev;
+	int i, rc = 0, done = 0;
+	unsigned long flags = 0;
+	struct daxctl_dev *dev;
+
+        argc = parse_options(argc, argv, options, u, 0);
+	if (argc == 0)
+		usage_with_options(u, options);
+	for (i = 0; i < argc; i++) {
+		if (strcmp(argv[i], "all") == 0) {
+			argv[0] = "all";
+			argc = 1;
+			break;
+		}
+	}
+
+	if (param.human)
+		flags |= UTIL_JSON_HUMAN;
+
+	if (!param.mode) {
+		fprintf(stderr, "error: a 'mode' option is required\n");
+		usage_with_options(u, options);
+	}
+	if (strcmp(param.mode, "system-ram") == 0) {
+		mode = DAXCTL_DEV_MODE_RAM;
+		if (param.do_offline) {
+			fprintf(stderr,
+				"can't --attempt-offline for system-ram mode\n");
+			return -EINVAL;
+		}
+	} else if (strcmp(param.mode, "devdax") == 0) {
+		mode = DAXCTL_DEV_MODE_DEVDAX;
+		if (param.no_online) {
+			fprintf(stderr,
+				"can't --no-online for devdax mode\n");
+			return -EINVAL;
+		}
+	}
+
+	daxctl_region_foreach(ctx, region) {
+		if (param.region_id >= 0 && param.region_id
+				!= daxctl_region_get_id(region))
+			continue;
+
+		daxctl_dev_foreach(region, dev) {
+			bool dev_requested = false;
+
+			for (i = 0; i < argc; i++) {
+				if ((strcmp(daxctl_dev_get_devname(dev),
+						argv[i]) == 0) ||
+						(strcmp(argv[i], "all") == 0)) {
+					dev_requested = true;
+					break;
+				}
+			}
+			if (dev_requested) {
+				rc = do_reconfig(dev, mode);
+				if (rc < 0)
+					goto out_err;
+				done++;
+				if (!jdevs)
+					continue;
+				jdev = util_daxctl_dev_to_json(dev, flags);
+				if (jdev)
+					json_object_array_add(jdevs, jdev);
+			}
+		}
+	}
+	if (jdevs)
+		util_display_json_array(stdout, jdevs, flags);
+
+	fprintf(stderr, "reconfigured %d device%s\n", done,
+		done == 1 ? "" : "s");
+	return 0;
+
+out_err:
+	fprintf(stderr, "error reconfiguring %s: %s\n",
+		daxctl_dev_get_devname(dev), strerror(-rc));
+	return rc;
+}
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

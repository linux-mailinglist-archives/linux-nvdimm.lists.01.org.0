Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B156C342
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 00:54:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24DEB212C01CF;
	Wed, 17 Jul 2019 15:56:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 03AE4212BF9BE
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 15:56:37 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 15:54:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,275,1559545200"; d="scan'208";a="191413587"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2019 15:54:09 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v6 09/13] daxctl: add commands to online and offline
 memory
Date: Wed, 17 Jul 2019 16:53:56 -0600
Message-Id: <20190717225400.9494-10-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717225400.9494-1-vishal.l.verma@intel.com>
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
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

Add two new commands:

  daxctl-online-memory
  daxctl-offline-memory

to manage the state of hot-plugged memory from the system-ram mode for
dax devices. This provides a way for the user to online/offline the
memory as a separate step from the reconfiguration. Without this, a user
that reconfigures a device into the system-ram mode with the --no-online
option, would have no way to later online the memory, and would have to
resort to shell scripting to online them manually via sysfs.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/builtin.h |   2 +
 daxctl/daxctl.c  |   2 +
 daxctl/device.c  | 138 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/daxctl/builtin.h b/daxctl/builtin.h
index 756ba2a..f5a0147 100644
--- a/daxctl/builtin.h
+++ b/daxctl/builtin.h
@@ -7,4 +7,6 @@ struct daxctl_ctx;
 int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_migrate(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx);
+int cmd_online_memory(int argc, const char **argv, struct daxctl_ctx *ctx);
+int cmd_offline_memory(int argc, const char **argv, struct daxctl_ctx *ctx);
 #endif /* _DAXCTL_BUILTIN_H_ */
diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
index e1ba7b8..1ab0732 100644
--- a/daxctl/daxctl.c
+++ b/daxctl/daxctl.c
@@ -72,6 +72,8 @@ static struct cmd_struct commands[] = {
 	{ "help", .d_fn = cmd_help },
 	{ "migrate-device-model", .d_fn = cmd_migrate },
 	{ "reconfigure-device", .d_fn = cmd_reconfig_device },
+	{ "online-memory", .d_fn = cmd_online_memory },
+	{ "offline-memory", .d_fn = cmd_offline_memory },
 };
 
 int main(int argc, const char **argv)
diff --git a/daxctl/device.c b/daxctl/device.c
index a1fb698..22cf0c8 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -30,6 +30,8 @@ static unsigned long flags;
 
 enum device_action {
 	ACTION_RECONFIG,
+	ACTION_ONLINE,
+	ACTION_OFFLINE,
 };
 
 #define BASE_OPTIONS() \
@@ -50,6 +52,11 @@ static const struct option reconfig_options[] = {
 	OPT_END(),
 };
 
+static const struct option memory_options[] = {
+	BASE_OPTIONS(),
+	OPT_END(),
+};
+
 static const char *parse_device_options(int argc, const char **argv,
 		enum device_action action, const struct option *options,
 		const char *usage, struct daxctl_ctx *ctx)
@@ -70,6 +77,12 @@ static const char *parse_device_options(int argc, const char **argv,
 		case ACTION_RECONFIG:
 			action_string = "reconfigure";
 			break;
+		case ACTION_ONLINE:
+			action_string = "online memory for";
+			break;
+		case ACTION_OFFLINE:
+			action_string = "offline memory for";
+			break;
 		default:
 			action_string = "<>";
 			break;
@@ -118,6 +131,10 @@ static const char *parse_device_options(int argc, const char **argv,
 			}
 		}
 		break;
+	case ACTION_ONLINE:
+	case ACTION_OFFLINE:
+		/* nothing special */
+		break;
 	}
 	if (rc) {
 		usage_with_options(u, options);
@@ -287,10 +304,82 @@ static int do_reconfig(struct daxctl_dev *dev, enum daxctl_dev_mode mode,
 	return rc;
 }
 
+static int do_xline(struct daxctl_dev *dev, enum device_action action)
+{
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
+	const char *devname = daxctl_dev_get_devname(dev);
+	enum daxctl_dev_mode mode;
+	int rc, num_online;
+
+	if (!daxctl_dev_is_enabled(dev)) {
+		fprintf(stderr,
+			"%s: memory operations not possible when disabled\n",
+			devname);
+		return -ENXIO;
+	}
+
+	mode = daxctl_dev_get_mode(dev);
+	if (mode < 0) {
+		fprintf(stderr, "%s: unable to determine current mode: %s\n",
+			devname, strerror(-mode));
+		return rc;
+	}
+	if (mode == DAXCTL_DEV_MODE_DEVDAX) {
+		fprintf(stderr,
+			"%s: memory operations are not applicable in devdax mode\n",
+			devname);
+		return -ENXIO;
+	}
+
+	/* We are enabled, and in the correct mode. Proceed. */
+	num_online = daxctl_memory_is_online(mem);
+	if (num_online < 0) {
+		fprintf(stderr, "%s: unable to determine online state: %s\n",
+			devname, strerror(-num_online));
+		return num_online;
+	}
+
+	switch (action) {
+	case ACTION_ONLINE:
+		if (num_online > 0)
+			fprintf(stderr, "%s: %d section%s already online\n",
+				devname, num_online,
+				num_online == 1 ? "" : "s");
+		rc = daxctl_memory_set_online(mem);
+		if (rc < 0) {
+			fprintf(stderr, "%s: unable to online memory: %s\n",
+				devname, strerror(-rc));
+			return rc;
+		}
+		fprintf(stderr, "%s: %d new section%s onlined\n", devname, rc,
+				rc == 1 ? "" : "s");
+		break;
+	case ACTION_OFFLINE:
+		if (num_online == 0) {
+			fprintf(stderr, "%s: all sections already offline\n",
+				devname);
+			return 0;
+		}
+		rc = daxctl_memory_set_offline(mem);
+		if (rc < 0) {
+			fprintf(stderr, "%s: unable to offline memory: %s\n",
+				devname, strerror(-rc));
+			return rc;
+		}
+		fprintf(stderr, "%s: %d section%s offlined\n", devname, rc,
+				rc == 1 ? "" : "s");
+		break;
+	default:
+		fprintf(stderr, "%s: invalid action: %d\n", devname, action);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int do_xaction_device(const char *device, enum device_action action,
 		struct daxctl_ctx *ctx, int *processed)
 {
-	struct json_object *jdevs = json_object_new_array();
+	struct json_object *jdevs = NULL;
 	struct daxctl_region *region;
 	struct daxctl_dev *dev;
 	int rc = -ENXIO;
@@ -308,10 +397,23 @@ static int do_xaction_device(const char *device, enum device_action action,
 
 			switch (action) {
 			case ACTION_RECONFIG:
+				/* reconfig needs jdevs, initialize it once */
+				if (!jdevs)
+					jdevs = json_object_new_array();
 				rc = do_reconfig(dev, reconfig_mode, jdevs);
 				if (rc == 0)
 					(*processed)++;
 				break;
+			case ACTION_ONLINE:
+				rc = do_xline(dev, action);
+				if (rc == 0)
+					(*processed)++;
+				break;
+			case ACTION_OFFLINE:
+				rc = do_xline(dev, action);
+				if (rc == 0)
+					(*processed)++;
+				break;
 			default:
 				rc = -EINVAL;
 				break;
@@ -346,3 +448,37 @@ int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx)
 			processed == 1 ? "" : "s");
 	return rc;
 }
+
+int cmd_online_memory(int argc, const char **argv, struct daxctl_ctx *ctx)
+{
+	char *usage = "daxctl online-memory <device> [<options>]";
+	const char *device = parse_device_options(argc, argv, ACTION_ONLINE,
+			memory_options, usage, ctx);
+	int processed, rc;
+
+	rc = do_xaction_device(device, ACTION_ONLINE, ctx, &processed);
+	if (rc < 0)
+		fprintf(stderr, "error onlining memory: %s\n",
+				strerror(-rc));
+
+	fprintf(stderr, "onlined memory for %d device%s\n", processed,
+			processed == 1 ? "" : "s");
+	return rc;
+}
+
+int cmd_offline_memory(int argc, const char **argv, struct daxctl_ctx *ctx)
+{
+	char *usage = "daxctl offline-memory <device> [<options>]";
+	const char *device = parse_device_options(argc, argv, ACTION_OFFLINE,
+			memory_options, usage, ctx);
+	int processed, rc;
+
+	rc = do_xaction_device(device, ACTION_OFFLINE, ctx, &processed);
+	if (rc < 0)
+		fprintf(stderr, "error offlining memory: %s\n",
+				strerror(-rc));
+
+	fprintf(stderr, "offlined memory for %d device%s\n", processed,
+			processed == 1 ? "" : "s");
+	return rc;
+}
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

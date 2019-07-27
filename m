Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F16775BB
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 03:52:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 90B56212E2594;
	Fri, 26 Jul 2019 18:54:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7B6E3212E15B1
 for <linux-nvdimm@lists.01.org>; Fri, 26 Jul 2019 18:54:46 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jul 2019 18:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,313,1559545200"; d="scan'208";a="369715473"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2019 18:52:19 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v8 09/13] daxctl: add commands to online and offline
 memory
Date: Fri, 26 Jul 2019 19:52:08 -0600
Message-Id: <20190727015212.27092-10-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190727015212.27092-1-vishal.l.verma@intel.com>
References: <20190727015212.27092-1-vishal.l.verma@intel.com>
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
 daxctl/builtin.h |  2 ++
 daxctl/daxctl.c  |  2 ++
 daxctl/device.c  | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

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
index 2629804..01d057e 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -39,6 +39,8 @@ static unsigned long flags;
 
 enum device_action {
 	ACTION_RECONFIG,
+	ACTION_ONLINE,
+	ACTION_OFFLINE,
 };
 
 #define BASE_OPTIONS() \
@@ -59,6 +61,11 @@ static const struct option reconfig_options[] = {
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
@@ -79,6 +86,12 @@ static const char *parse_device_options(int argc, const char **argv,
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
@@ -122,6 +135,10 @@ static const char *parse_device_options(int argc, const char **argv,
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
@@ -442,6 +459,33 @@ static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
 	return rc;
 }
 
+static int do_xline(struct daxctl_dev *dev, enum device_action action)
+{
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
+	const char *devname = daxctl_dev_get_devname(dev);
+	int rc;
+
+	if (!mem) {
+		fprintf(stderr,
+			"%s: memory operations are not applicable in devdax mode\n",
+			devname);
+		return -ENXIO;
+	}
+
+	switch (action) {
+	case ACTION_ONLINE:
+		rc = dev_online_memory(dev);
+		break;
+	case ACTION_OFFLINE:
+		rc = dev_offline_memory(dev);
+		break;
+	default:
+		fprintf(stderr, "%s: invalid action: %d\n", devname, action);
+		rc = -EINVAL;
+	}
+	return rc;
+}
+
 static int do_xaction_device(const char *device, enum device_action action,
 		struct daxctl_ctx *ctx, int *processed)
 {
@@ -467,6 +511,16 @@ static int do_xaction_device(const char *device, enum device_action action,
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
@@ -501,3 +555,37 @@ int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx)
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

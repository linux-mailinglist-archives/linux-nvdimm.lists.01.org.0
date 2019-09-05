Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FC2A97DD
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 03:13:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 87BFA2194EB77;
	Wed,  4 Sep 2019 18:14:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CEF7020260CF8
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 18:14:28 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 18:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; d="scan'208";a="190341687"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
 by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2019 18:13:26 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 2/2] libdaxctl: fix device reconfiguration with
 builtin drivers
Date: Wed,  4 Sep 2019 19:13:14 -0600
Message-Id: <20190905011314.18610-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190905011314.18610-1-vishal.l.verma@intel.com>
References: <20190905011314.18610-1-vishal.l.verma@intel.com>
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
 Brice Goglin <Brice.Goglin@inria.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

When the driver of a given reconfiguration mode is builtin, libdaxctl
isn't able to build a module lookup list using kmod. However, it doesn't
need to fail in this case, as it is acceptable for a driver to be
builtin.

Indeed, since even with a modalias lookup list, we still have to resolve
the target driver based on the mode using the module name, so relying on
the modalias lookup to keep us impervious to module name changes is
already flawed.

Simplify module loading greatly by removing the modalias lookups, and
directly getting the module from a named lookup. This transparently
fixes the problem when the driver may be builtin instead of being a
module.

Link: https://github.com/pmem/ndctl/issues/108
Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---

v2:
 - Remove modalias lookup lists entirely, and perform a simple name
   based lookup (Dan)
 - Fix the module expectation in the daxctl-devices unit test.

 daxctl/lib/libdaxctl-private.h |  1 -
 daxctl/lib/libdaxctl.c         | 75 ++++++++--------------------------
 test/daxctl-devices.sh         |  7 +++-
 3 files changed, 23 insertions(+), 60 deletions(-)

diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index 01091de..7ba3c46 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -75,7 +75,6 @@ struct daxctl_dev {
 	unsigned long long resource;
 	unsigned long long size;
 	struct kmod_module *module;
-	struct kmod_list *kmod_list;
 	struct daxctl_region *region;
 	struct daxctl_memory *mem;
 	int target_node;
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index d9f2c33..3d989a8 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -215,7 +215,7 @@ static void free_dev(struct daxctl_dev *dev, struct list_head *head)
 {
 	if (head)
 		list_del_from(head, &dev->list);
-	kmod_module_unref_list(dev->kmod_list);
+	kmod_module_unref(dev->module);
 	free(dev->dev_buf);
 	free(dev->dev_path);
 	free_mem(dev);
@@ -371,27 +371,6 @@ static bool device_model_is_dax_bus(struct daxctl_dev *dev)
 	return false;
 }
 
-static struct kmod_list *to_module_list(struct daxctl_ctx *ctx,
-		const char *alias)
-{
-	struct kmod_list *list = NULL;
-	int rc;
-
-	if (!ctx->kmod_ctx || !alias)
-		return NULL;
-	if (alias[0] == 0)
-		return NULL;
-
-	rc = kmod_module_new_from_lookup(ctx->kmod_ctx, alias, &list);
-	if (rc < 0 || !list) {
-		dbg(ctx, "failed to find modules for alias: %s %d list: %s\n",
-				alias, rc, list ? "populated" : "empty");
-		return NULL;
-	}
-
-	return list;
-}
-
 static int dev_is_system_ram_capable(struct daxctl_dev *dev)
 {
 	const char *devname = daxctl_dev_get_devname(dev);
@@ -489,7 +468,6 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 	struct daxctl_dev *dev, *dev_dup;
 	char buf[SYSFS_ATTR_SIZE];
 	struct stat st;
-	int rc;
 
 	if (!path)
 		return NULL;
@@ -527,14 +505,6 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 		goto err_read;
 	dev->buf_len = strlen(daxdev_base) + 50;
 
-	sprintf(path, "%s/modalias", daxdev_base);
-	rc = sysfs_read_attr(ctx, path, buf);
-	/* older kernels may be lack the modalias attribute */
-	if (rc < 0 && rc != -ENOENT)
-		goto err_read;
-	if (rc == 0)
-		dev->kmod_list = to_module_list(ctx, buf);
-
 	sprintf(path, "%s/target_node", daxdev_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dev->target_node = strtol(buf, NULL, 0);
@@ -873,38 +843,29 @@ static int daxctl_insert_kmod_for_mode(struct daxctl_dev *dev,
 {
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
-	struct kmod_list *iter;
-	int rc = -ENXIO;
+	struct kmod_module *kmod;
+	int rc;
 
-	if (dev->kmod_list == NULL) {
-		err(ctx, "%s: a modalias lookup list was not created\n",
-				devname);
+	rc = kmod_module_new_from_name(ctx->kmod_ctx, mod_name, &kmod);
+	if (rc < 0) {
+		err(ctx, "%s: failed getting module for: %s: %s\n",
+			devname, mod_name, strerror(-rc));
 		return rc;
 	}
 
-	kmod_list_foreach(iter, dev->kmod_list) {
-		struct kmod_module *mod = kmod_module_get_module(iter);
-		const char *name = kmod_module_get_name(mod);
-
-		if (strcmp(name, mod_name) != 0) {
-			kmod_module_unref(mod);
-			continue;
-		}
-		dbg(ctx, "%s inserting module: %s\n", devname, name);
-		rc = kmod_module_probe_insert_module(mod,
-				KMOD_PROBE_APPLY_BLACKLIST, NULL, NULL, NULL,
-				NULL);
-		if (rc < 0) {
-			err(ctx, "%s: insert failure: %d\n", devname, rc);
-			return rc;
-		}
-		dev->module = mod;
+	/* if the driver is builtin, this Just Works */
+	dbg(ctx, "%s inserting module: %s\n", devname,
+		kmod_module_get_name(kmod));
+	rc = kmod_module_probe_insert_module(kmod,
+			KMOD_PROBE_APPLY_BLACKLIST,
+			NULL, NULL, NULL, NULL);
+	if (rc < 0) {
+		err(ctx, "%s: insert failure: %d\n", devname, rc);
+		return rc;
 	}
+	dev->module = kmod;
 
-	if (rc == -ENXIO)
-		err(ctx, "%s: Unable to find module: %s in alias list\n",
-				devname, mod_name);
-	return rc;
+	return 0;
 }
 
 static int daxctl_dev_enable(struct daxctl_dev *dev, enum daxctl_dev_mode mode)
diff --git a/test/daxctl-devices.sh b/test/daxctl-devices.sh
index e236854..00f4715 100755
--- a/test/daxctl-devices.sh
+++ b/test/daxctl-devices.sh
@@ -21,8 +21,11 @@ find_testdev()
 	# The kmem driver is needed to change the device mode, only
 	# kernels >= v5.1 might have it available. Skip if not.
 	if ! modinfo kmem; then
-		printf "Unable to find kmem module\n"
-		exit $rc
+		# check if kmem is builtin
+		if ! grep -qF "kmem" "/lib/modules/$(uname -r)/modules.builtin"; then
+			printf "Unable to find kmem module\n"
+			exit $rc
+		fi
 	fi
 
 	# find a victim device
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

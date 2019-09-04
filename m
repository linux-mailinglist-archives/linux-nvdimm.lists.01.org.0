Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AD5A7804
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 03:08:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C763121962301;
	Tue,  3 Sep 2019 18:09:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D9D4F202110C5
 for <linux-nvdimm@lists.01.org>; Tue,  3 Sep 2019 18:09:45 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2019 18:08:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; d="scan'208";a="198904463"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga001.fm.intel.com with ESMTP; 03 Sep 2019 18:08:35 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 2/2] libdaxctl: fix device reconfiguration with builtin
 drivers
Date: Tue,  3 Sep 2019 19:08:19 -0600
Message-Id: <20190904010819.11012-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904010819.11012-1-vishal.l.verma@intel.com>
References: <20190904010819.11012-1-vishal.l.verma@intel.com>
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

Use the kmod 'initstate' to determine whether the target driver may be
builtin, and ensure it is available by probing it via a named lookup.
If it is available, skip the modalias based list walk, and bind to it
directly.

Link: https://github.com/pmem/ndctl/issues/108
Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index d9f2c33..7a65bed 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -868,6 +868,37 @@ DAXCTL_EXPORT int daxctl_dev_is_enabled(struct daxctl_dev *dev)
 	return is_enabled(path);
 }
 
+static int try_kmod_builtin(struct daxctl_dev *dev, const char *mod_name)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	struct kmod_module *kmod;
+	int rc = -ENXIO;
+
+	rc = kmod_module_new_from_name(ctx->kmod_ctx, mod_name, &kmod);
+	if (rc < 0) {
+		err(ctx, "%s: failed getting module for: %s: %s\n",
+			devname, mod_name, strerror(-rc));
+		return rc;
+	}
+
+	if (kmod_module_get_initstate(kmod) != KMOD_MODULE_BUILTIN)
+		return -ENXIO;
+
+	dbg(ctx, "%s inserting module: %s\n", devname,
+		kmod_module_get_name(kmod));
+	rc = kmod_module_probe_insert_module(kmod,
+			KMOD_PROBE_APPLY_BLACKLIST,
+			NULL, NULL, NULL, NULL);
+	if (rc < 0) {
+		err(ctx, "%s: insert failure: %d\n", devname, rc);
+		return rc;
+	}
+	dev->module = kmod;
+
+	return 0;
+}
+
 static int daxctl_insert_kmod_for_mode(struct daxctl_dev *dev,
 		const char *mod_name)
 {
@@ -877,6 +908,8 @@ static int daxctl_insert_kmod_for_mode(struct daxctl_dev *dev,
 	int rc = -ENXIO;
 
 	if (dev->kmod_list == NULL) {
+		if (try_kmod_builtin(dev, mod_name) == 0)
+			return 0;
 		err(ctx, "%s: a modalias lookup list was not created\n",
 				devname);
 		return rc;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

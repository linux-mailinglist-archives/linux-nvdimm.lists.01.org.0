Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0175D16E53
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 02:39:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 351EE2194EB78;
	Tue,  7 May 2019 17:39:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 10731211EDB5C
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 17:39:19 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 May 2019 17:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,443,1549958400"; d="scan'208";a="169427666"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga002.fm.intel.com with ESMTP; 07 May 2019 17:39:18 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 01/10] libdaxctl: add interfaces in support of device
 modes
Date: Tue,  7 May 2019 18:38:42 -0600
Message-Id: <20190508003851.32416-2-vishal.l.verma@intel.com>
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

In preparation for libdaxctl and daxctl to grow operational modes for
DAX devices, add the following supporting APIs:

  daxctl_dev_get_ctx
  daxctl_dev_is_enabled

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c   | 30 ++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym |  6 ++++++
 daxctl/libdaxctl.h       |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index c2e3a52..70f896b 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -559,6 +559,36 @@ static void dax_regions_init(struct daxctl_ctx *ctx)
 	}
 }
 
+static int is_enabled(const char *drvpath)
+{
+	struct stat st;
+
+	if (lstat(drvpath, &st) < 0 || !S_ISLNK(st.st_mode))
+		return 0;
+	else
+		return 1;
+}
+
+DAXCTL_EXPORT int daxctl_dev_is_enabled(struct daxctl_dev *dev)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char *path = dev->dev_buf;
+	int len = dev->buf_len;
+
+	if (snprintf(path, len, "%s/driver", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_dev_get_devname(dev));
+		return 0;
+	}
+
+	return is_enabled(path);
+}
+
+DAXCTL_EXPORT struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev)
+{
+	return dev->region->ctx;
+}
+
 DAXCTL_EXPORT struct daxctl_dev *daxctl_dev_get_first(struct daxctl_region *region)
 {
 	dax_devices_init(region);
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 84d3a69..c4af9a7 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -50,3 +50,9 @@ LIBDAXCTL_5 {
 global:
 	daxctl_region_get_path;
 } LIBDAXCTL_4;
+
+LIBDAXCTL_6 {
+global:
+	daxctl_dev_get_ctx;
+	daxctl_dev_is_enabled;
+} LIBDAXCTL_5;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 1d13ea2..e20ccb4 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -67,6 +67,8 @@ const char *daxctl_dev_get_devname(struct daxctl_dev *dev);
 int daxctl_dev_get_major(struct daxctl_dev *dev);
 int daxctl_dev_get_minor(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev);
+struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev);
+int daxctl_dev_is_enabled(struct daxctl_dev *dev);
 
 #define daxctl_dev_foreach(region, dev) \
         for (dev = daxctl_dev_get_first(region); \
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

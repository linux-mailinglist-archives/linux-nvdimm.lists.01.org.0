Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B081F134EC
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 23:32:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 395092194D387;
	Fri,  3 May 2019 14:32:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2086421237AA7
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 14:32:42 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 May 2019 14:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; d="scan'208";a="145838665"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga008.fm.intel.com with ESMTP; 03 May 2019 14:32:41 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 2/8] libdaxctl: cache 'subsystem' in daxctl_ctx
Date: Fri,  3 May 2019 15:32:25 -0600
Message-Id: <20190503213231.12280-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503213231.12280-1-vishal.l.verma@intel.com>
References: <20190503213231.12280-1-vishal.l.verma@intel.com>
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

The 'DAX subsystem' in effect is determined at region or device init
time, and dictates the sysfs base paths for all device/region
operations. In preparation for adding bind/unbind functionality, cache
the subsystem as determined at init time in the library context.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 70f896b..f8f5b8c 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -46,6 +46,7 @@ struct daxctl_ctx {
 	void *userdata;
 	int regions_init;
 	struct list_head regions;
+	enum dax_subsystem subsys;
 };
 
 /**
@@ -96,6 +97,7 @@ DAXCTL_EXPORT int daxctl_new(struct daxctl_ctx **ctx)
 	dbg(c, "log_priority=%d\n", c->ctx.log_priority);
 	*ctx = c;
 	list_head_init(&c->regions);
+	c->subsys = DAX_UNKNOWN;
 
 	return 0;
 }
@@ -454,14 +456,18 @@ static void dax_devices_init(struct daxctl_region *region)
 	for (i = 0; i < ARRAY_SIZE(dax_subsystems); i++) {
 		char *region_path;
 
-		if (i == DAX_BUS)
+		if (i == DAX_BUS) {
 			region_path = region->region_path;
-		else if (i == DAX_CLASS) {
+			if (ctx->subsys == DAX_UNKNOWN)
+				ctx->subsys = DAX_BUS;
+		} else if (i == DAX_CLASS) {
 			if (asprintf(&region_path, "%s/dax",
 						region->region_path) < 0) {
 				dbg(ctx, "region path alloc fail\n");
 				continue;
 			}
+			if (ctx->subsys == DAX_UNKNOWN)
+				ctx->subsys = DAX_CLASS;
 		} else
 			continue;
 		sysfs_device_parse(ctx, region_path, daxdev_fmt, region,
@@ -539,6 +545,8 @@ static void __dax_regions_init(struct daxctl_ctx *ctx, enum dax_subsystem subsys
 		free(dev_path);
 		if (!region)
 			err(ctx, "add_dax_region() for %s failed\n", de->d_name);
+		if (ctx->subsys == DAX_UNKNOWN)
+			ctx->subsys = subsys;
 	}
 	closedir(dir);
 }
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

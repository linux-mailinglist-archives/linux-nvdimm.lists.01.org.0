Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2778412C0FF
	for <lists+linux-nvdimm@lfdr.de>; Sun, 29 Dec 2019 08:50:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7020D10097F2D;
	Sat, 28 Dec 2019 23:53:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0AC010113693
	for <linux-nvdimm@lists.01.org>; Sat, 28 Dec 2019 23:53:51 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2019 23:50:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,370,1571727600";
   d="scan'208";a="420079514"
Received: from redhaire-mobl1.gar.corp.intel.com ([10.255.176.179])
  by fmsmga006.fm.intel.com with ESMTP; 28 Dec 2019 23:50:29 -0800
From: redhairer <redhairer.li@intel.com>
To: linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com
Subject: [PATCH 1/1] daxctl: Change region input type from INTEGER to STRING.
Date: Sun, 29 Dec 2019 15:50:13 +0800
Message-Id: <20191229075013.22620-1-redhairer.li@intel.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Message-ID-Hash: I3BN6CXNB3VKVCGYQGWSK4C7OSL6QIID
X-Message-ID-Hash: I3BN6CXNB3VKVCGYQGWSK4C7OSL6QIID
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: redhairer <redhairer.li@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I3BN6CXNB3VKVCGYQGWSK4C7OSL6QIID/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Allow daxctl to accept both <region-id>, and region name as region parameter.
For example:

    daxctl list -r region5
    daxctl list -r 5

Link: https://github.com/pmem/ndctl/issues/109
Signed-off-by: Redhairer Li <redhairer.li@intel.com>
---
 daxctl/device.c | 11 ++++-------
 daxctl/list.c   | 14 ++++++--------
 util/filter.c   | 16 ++++++++++++++++
 util/filter.h   |  2 ++
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index 72e506e..705f1f8 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -19,15 +19,13 @@
 static struct {
 	const char *dev;
 	const char *mode;
-	int region_id;
+	const char *region;
 	bool no_online;
 	bool no_movable;
 	bool force;
 	bool human;
 	bool verbose;
-} param = {
-	.region_id = -1,
-};
+} param;
 
 enum dev_mode {
 	DAXCTL_DEV_MODE_UNKNOWN,
@@ -51,7 +49,7 @@ enum device_action {
 };
 
 #define BASE_OPTIONS() \
-OPT_INTEGER('r', "region", &param.region_id, "restrict to the given region"), \
+OPT_STRING('r', "region", &param.region, "region-id", "filter by region"), \
 OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats"), \
 OPT_BOOLEAN('v', "verbose", &param.verbose, "emit more debug messages")
 
@@ -484,8 +482,7 @@ static int do_xaction_device(const char *device, enum device_action action,
 	*processed = 0;
 
 	daxctl_region_foreach(ctx, region) {
-		if (param.region_id >= 0 && param.region_id
-				!= daxctl_region_get_id(region))
+		if (!util_daxctl_region_filter(region, param.region))
 			continue;
 
 		daxctl_dev_foreach(region, dev) {
diff --git a/daxctl/list.c b/daxctl/list.c
index e56300d..6c6251b 100644
--- a/daxctl/list.c
+++ b/daxctl/list.c
@@ -44,10 +44,8 @@ static unsigned long listopts_to_flags(void)
 
 static struct {
 	const char *dev;
-	int region_id;
-} param = {
-	.region_id = -1,
-};
+	const char *region;
+} param;
 
 static int did_fail;
 
@@ -66,7 +64,8 @@ static int num_list_flags(void)
 int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx)
 {
 	const struct option options[] = {
-		OPT_INTEGER('r', "region", &param.region_id, "filter by region"),
+		OPT_STRING('r', "region", &param.region, "region-id",
+				"filter by region"),
 		OPT_STRING('d', "dev", &param.dev, "dev-id",
 				"filter by dax device instance name"),
 		OPT_BOOLEAN('D', "devices", &list.devs, "include dax device info"),
@@ -94,7 +93,7 @@ int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx)
 		usage_with_options(u, options);
 
 	if (num_list_flags() == 0) {
-		list.regions = param.region_id >= 0;
+		list.regions = !!param.region;
 		list.devs = !!param.dev;
 	}
 
@@ -106,8 +105,7 @@ int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx)
 	daxctl_region_foreach(ctx, region) {
 		struct json_object *jregion = NULL;
 
-		if (param.region_id >= 0 && param.region_id
-				!= daxctl_region_get_id(region))
+		if (!util_daxctl_region_filter(region, param.region))
 			continue;
 
 		if (list.regions) {
diff --git a/util/filter.c b/util/filter.c
index 1734bce..877d6c7 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -335,6 +335,22 @@ struct daxctl_dev *util_daxctl_dev_filter(struct daxctl_dev *dev,
 	return NULL;
 }
 
+struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
+		const char *ident)
+{
+	int region_id;
+
+	if (!ident || strcmp(ident, "all") == 0)
+		return region;
+
+	if ((sscanf(ident, "%d", &region_id) == 1
+       || sscanf(ident, "region%d", &region_id) == 1)
+			&& daxctl_region_get_id(region) == region_id)
+		return region;
+
+	return NULL;
+}
+
 static enum ndctl_namespace_mode mode_to_type(const char *mode)
 {
 	if (!mode)
diff --git a/util/filter.h b/util/filter.h
index c2cdddf..0c12b94 100644
--- a/util/filter.h
+++ b/util/filter.h
@@ -37,6 +37,8 @@ struct ndctl_region *util_region_filter_by_namespace(struct ndctl_region *region
 		const char *ident);
 struct daxctl_dev *util_daxctl_dev_filter(struct daxctl_dev *dev,
 		const char *ident);
+struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
+		const char *ident);
 
 struct json_object;
 
-- 
2.20.1.windows.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

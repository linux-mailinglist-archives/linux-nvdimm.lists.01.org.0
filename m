Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D722F2426
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 01:34:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E331100EB821;
	Mon, 11 Jan 2021 16:34:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 65913100EB82A
	for <linux-nvdimm@lists.01.org>; Mon, 11 Jan 2021 16:34:26 -0800 (PST)
IronPort-SDR: ecPu9cyNz8csp6lKVEtb9IgIFlf42qd6kndpG7+JOKGBvRp+WfIsU21nTLW/QFBATua/pcZxnw
 0MxRooAfvs2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177185581"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400";
   d="scan'208";a="177185581"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:26 -0800
IronPort-SDR: dLFy2R7vc+QxzXFpJ3FtCNo3ojkpsrMa2mHlysSznFSzBR3bKQULQm4NX5r7m1E9HvrWSuSpbL
 tonXzFrosXxQ==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400";
   d="scan'208";a="381212107"
Received: from ecbackus-mobl1.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.212.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:25 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl RFC PATCH 5/5] cxl/list: augment cxl-list with more data from the identify command
Date: Mon, 11 Jan 2021 17:34:03 -0700
Message-Id: <20210112003403.2944568-6-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112003403.2944568-1-vishal.l.verma@intel.com>
References: <20210112003403.2944568-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: Y3FC7FCFBWCKE3YCMD2YF6VOQCVR5GWA
X-Message-ID-Hash: Y3FC7FCFBWCKE3YCMD2YF6VOQCVR5GWA
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y3FC7FCFBWCKE3YCMD2YF6VOQCVR5GWA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Augment cxl-list with some more fields obtained from sending an
'Identify' command to the device. If/when these fields are added to the
sysfs representation of the memdev, the command submission detour can be
removed and replaced with data from sysfs.

Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 util/json.h |  3 ++-
 cxl/list.c  | 29 +++++++++++++++++++++++++++--
 util/json.c | 22 +++++++++++++++++++++-
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/util/json.h b/util/json.h
index 91918c8..831f9bb 100644
--- a/util/json.h
+++ b/util/json.h
@@ -6,6 +6,7 @@
 #include <stdbool.h>
 #include <ndctl/libndctl.h>
 #include <daxctl/libdaxctl.h>
+#include <cxl/libcxl.h>
 #include <ccan/short_types/short_types.h>
 
 enum util_json_flags {
@@ -57,5 +58,5 @@ struct json_object *util_dimm_firmware_to_json(struct ndctl_dimm *dimm,
 struct json_object *util_region_capabilities_to_json(struct ndctl_region *region);
 struct cxl_memdev;
 struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
-		unsigned long flags);
+		struct cxl_cmd *id, unsigned long flags);
 #endif /* __NDCTL_JSON_H__ */
diff --git a/cxl/list.c b/cxl/list.c
index 3d44244..7afe2b4 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
+#include <util/log.h>
 #include <util/json.h>
 #include <util/filter.h>
 #include <json-c/json.h>
@@ -16,6 +17,7 @@ static struct {
 	bool memdevs;
 	bool idle;
 	bool human;
+	bool verbose;
 } list;
 
 static unsigned long listopts_to_flags(void)
@@ -47,6 +49,19 @@ static int num_list_flags(void)
 	return list.memdevs;
 }
 
+struct cxl_cmd *memdev_identify(struct cxl_memdev *memdev)
+{
+	struct cxl_cmd *id;
+
+	id = cxl_cmd_new_identify(memdev);
+	if (!id)
+		return NULL;
+
+	if (cxl_cmd_submit(id) != 0)
+		return NULL;
+	return id;
+}
+
 int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 {
 	const struct option options[] = {
@@ -56,7 +71,9 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 			    "include CXL memory device info"),
 		OPT_BOOLEAN('i', "idle", &list.idle, "include idle devices"),
 		OPT_BOOLEAN('u', "human", &list.human,
-				"use human friendly number formats "),
+				"use human friendly number formats"),
+		OPT_BOOLEAN('v', "verbose", &list.verbose,
+				"enable verbose output"),
 		OPT_END(),
 	};
 	const char * const u[] = {
@@ -80,27 +97,35 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 
 	list_flags = listopts_to_flags();
 
+	if (list.verbose)
+		cxl_set_log_priority(ctx, LOG_DEBUG);
+
 	cxl_memdev_foreach(ctx, memdev) {
 		struct json_object *jdev = NULL;
+		struct cxl_cmd *id;
 
 		if (!util_cxl_memdev_filter(memdev, param.memdev))
 			continue;
 
 		if (list.memdevs) {
+			id = memdev_identify(memdev);
 			if (!jdevs) {
 				jdevs = json_object_new_array();
 				if (!jdevs) {
 					fail("\n");
+					cxl_cmd_unref(id);
 					continue;
 				}
 			}
 
-			jdev = util_cxl_memdev_to_json(memdev, list_flags);
+			jdev = util_cxl_memdev_to_json(memdev, id, list_flags);
 			if (!jdev) {
 				fail("\n");
+				cxl_cmd_unref(id);
 				continue;
 			}
 			json_object_array_add(jdevs, jdev);
+			cxl_cmd_unref(id);
 		}
 	}
 
diff --git a/util/json.c b/util/json.c
index a855571..24d4477 100644
--- a/util/json.c
+++ b/util/json.c
@@ -1432,10 +1432,11 @@ struct json_object *util_badblock_rec_to_json(u64 block, u64 count,
 }
 
 struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
-		unsigned long flags)
+		struct cxl_cmd *id, unsigned long flags)
 {
 	const char *devname = cxl_memdev_get_devname(memdev);
 	struct json_object *jdev, *jobj;
+	char fw_rev[0x10];
 
 	jdev = json_object_new_object();
 	if (!devname || !jdev)
@@ -1453,5 +1454,24 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	if (jobj)
 		json_object_object_add(jdev, "ram_size", jobj);
 
+	if (!id)
+		return jdev;
+
+	if (cxl_cmd_identify_get_fw_rev(id, fw_rev, 0x10) == 0) {
+		jobj = json_object_new_string(fw_rev);
+		if (jobj)
+			json_object_object_add(jdev, "fw_revision", jobj);
+	}
+
+	jobj = util_json_object_size(cxl_cmd_identify_get_partition_align(id),
+			flags);
+	if (jobj)
+		json_object_object_add(jdev, "partition_align", jobj);
+
+	jobj = util_json_object_size(cxl_cmd_identify_get_lsa_size(id),
+			flags);
+	if (jobj)
+		json_object_object_add(jdev, "lsa_size", jobj);
+
 	return jdev;
 }
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

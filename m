Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447E19E000
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 22:59:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EB11E10FC51D0;
	Fri,  3 Apr 2020 14:00:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F053010FC51C8
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 14:00:10 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Ki6Ka120979;
	Fri, 3 Apr 2020 20:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=bs3yV+txfQV5IjvGoxBdc1cn+5nmd09IIKrm+d4z+Go=;
 b=MvOapjs47WZAab4k7B0ZcX6Q82IZmyMYKNysbzUjMg7KU9xBSKbDRri3k/5TqwpDBJz6
 DuQzEw2kfNK92+xvPWUvIerOQ3P55qA77kCv0nT8/3rbxZTpp6yI4mq5oEZqDGH7ufEE
 VMYu8pAES3X10WkQ1SgCQ0b4cE2QHMo8lARjmisfXcFbKsVIFeI+0TB6L3jVC/tvSuk/
 BEszynHwoWH03Z9ICwc3F/sfK5H2KJp27rJ9/7uUKZgLP13gMKn3M4+QXrrZK56C+o31
 bX9l3R3qwpYTDrFWhyNgRFfqM2vWHkr3WQMU/XUDH/Jt27e3Z3YPBRfDtZipN5CQOTzN kw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 303yunnskr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KgPZK033110;
	Fri, 3 Apr 2020 20:59:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 302g4y664n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:19 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033KxIFP010518;
	Fri, 3 Apr 2020 20:59:18 GMT
Received: from paddy.uk.oracle.com (/10.175.206.152)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 03 Apr 2020 13:59:17 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 07/10] daxctl: add command to create device
Date: Fri,  3 Apr 2020 21:58:57 +0100
Message-Id: <20200403205900.18035-8-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403205900.18035-1-joao.m.martins@oracle.com>
References: <20200403205900.18035-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=1
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=1 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
Message-ID-Hash: ZUXXZDQ5SR6MB364HFPFDZ65KPKGIITB
X-Message-ID-Hash: ZUXXZDQ5SR6MB364HFPFDZ65KPKGIITB
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZUXXZDQ5SR6MB364HFPFDZ65KPKGIITB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a 'create-device' command which creates a devdax
region. So far the only new option is size, which when
omitted uses the entire available space. Example usage:

	$ daxctl reconfigure-device -s 0 dax0.0
	reconfigured 1 device

	$ daxctl create-device -s 4G -r 0
	[
	  {
	    "chardev":"dax0.1",
	    "size":4294967296,
	    "target_node":0,
	    "mode":"devdax"
	  }
	]
	created 1 device

Or using the whole available space like default behaviour
or ndctl-create-namespace:

	$ daxctl create-device
	[
	  {
	    "chardev":"dax0.1",
	    "size":120259084288,
	    "target_node":0,
	    "mode":"devdax"
	  }
	]
	created 1 device

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 daxctl/builtin.h |   1 +
 daxctl/daxctl.c  |   1 +
 daxctl/device.c  | 117 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/daxctl/builtin.h b/daxctl/builtin.h
index 8f344f86ad20..19b33933b91b 100644
--- a/daxctl/builtin.h
+++ b/daxctl/builtin.h
@@ -6,6 +6,7 @@
 struct daxctl_ctx;
 int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_migrate(int argc, const char **argv, struct daxctl_ctx *ctx);
+int cmd_create_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_disable_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_enable_device(int argc, const char **argv, struct daxctl_ctx *ctx);
diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
index a4699b3780bd..1f315168c513 100644
--- a/daxctl/daxctl.c
+++ b/daxctl/daxctl.c
@@ -71,6 +71,7 @@ static struct cmd_struct commands[] = {
 	{ "list", .d_fn = cmd_list },
 	{ "help", .d_fn = cmd_help },
 	{ "migrate-device-model", .d_fn = cmd_migrate },
+	{ "create-device", .d_fn = cmd_create_device },
 	{ "reconfigure-device", .d_fn = cmd_reconfig_device },
 	{ "online-memory", .d_fn = cmd_online_memory },
 	{ "offline-memory", .d_fn = cmd_offline_memory },
diff --git a/daxctl/device.c b/daxctl/device.c
index 596b6efca34d..c038abba8063 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -9,6 +9,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/sysmacros.h>
+#include <util/size.h>
 #include <util/json.h>
 #include <util/filter.h>
 #include <json-c/json.h>
@@ -20,6 +21,7 @@ static struct {
 	const char *dev;
 	const char *mode;
 	const char *region;
+	const char *size;
 	bool no_online;
 	bool no_movable;
 	bool force;
@@ -47,6 +49,7 @@ enum device_action {
 	ACTION_RECONFIG,
 	ACTION_ONLINE,
 	ACTION_OFFLINE,
+	ACTION_CREATE,
 	ACTION_DISABLE,
 	ACTION_ENABLE,
 };
@@ -63,10 +66,21 @@ OPT_BOOLEAN('N', "no-online", &param.no_online, \
 OPT_BOOLEAN('f', "force", &param.force, \
 		"attempt to offline memory sections before reconfiguration")
 
+#define CREATE_OPTIONS() \
+OPT_STRING('s', "size", &param.size, "size", "size to switch the device to")
+
 #define ZONE_OPTIONS() \
 OPT_BOOLEAN('\0', "no-movable", &param.no_movable, \
 		"online memory in ZONE_NORMAL")
 
+static const struct option create_options[] = {
+	BASE_OPTIONS(),
+	CREATE_OPTIONS(),
+	RECONFIG_OPTIONS(),
+	ZONE_OPTIONS(),
+	OPT_END(),
+};
+
 static const struct option reconfig_options[] = {
 	BASE_OPTIONS(),
 	CREATE_OPTIONS(),
@@ -104,12 +118,14 @@ static const char *parse_device_options(int argc, const char **argv,
 		usage,
 		NULL
 	};
+	unsigned long long units = 1;
 	int i, rc = 0;
 
 	argc = parse_options(argc, argv, options, u, 0);
 
 	/* Handle action-agnostic non-option arguments */
-	if (argc == 0) {
+	if (argc == 0 &&
+	    action != ACTION_CREATE) {
 		char *action_string;
 
 		switch (action) {
@@ -175,6 +191,10 @@ static const char *parse_device_options(int argc, const char **argv,
 			}
 		}
 		break;
+	case ACTION_CREATE:
+		if (param.size)
+			size = __parse_size64(param.size, &units);
+		/* fall through */
 	case ACTION_ONLINE:
 		if (param.no_movable)
 			mem_zone = MEM_ZONE_NORMAL;
@@ -446,6 +466,47 @@ static int reconfig_mode_devdax(struct daxctl_dev *dev)
 	return 0;
 }
 
+static int do_create(struct daxctl_region *region, long long val,
+		     struct json_object **jdevs)
+{
+	struct json_object *jdev;
+	struct daxctl_dev *dev;
+	int rc = 0;
+
+	if (daxctl_region_create_dev(region))
+		return -ENOSPC;
+
+	dev = daxctl_region_get_dev_seed(region);
+	if (!dev)
+		return -ENOSPC;
+
+	if (val == -1)
+		val = daxctl_region_get_available_size(region);
+
+	if (val <= 0)
+		return -ENOSPC;
+
+	rc = daxctl_dev_set_size(dev, val);
+	if (rc < 0)
+		return rc;
+
+	rc = daxctl_dev_enable_devdax(dev);
+	if (rc) {
+		fprintf(stderr, "%s: enable failed: %s\n",
+			daxctl_dev_get_devname(dev), strerror(-rc));
+		return rc;
+	}
+
+	*jdevs = json_object_new_array();
+	if (*jdevs) {
+		jdev = util_daxctl_dev_to_json(dev, flags);
+		if (jdev)
+			json_object_array_add(*jdevs, jdev);
+	}
+
+	return 0;
+}
+
 static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
 		struct json_object **jdevs)
 {
@@ -548,6 +609,42 @@ static int do_xble(struct daxctl_dev *dev, enum device_action action)
 	return rc;
 }
 
+static int do_xaction_region(enum device_action action,
+		struct daxctl_ctx *ctx, int *processed)
+{
+	struct json_object *jdevs = NULL;
+	struct daxctl_region *region;
+	int rc = -ENXIO;
+
+	*processed = 0;
+
+	daxctl_region_foreach(ctx, region) {
+		if (!util_daxctl_region_filter(region, param.region))
+			continue;
+
+		switch (action) {
+		case ACTION_CREATE:
+			rc = do_create(region, size, &jdevs);
+			if (rc == 0)
+				(*processed)++;
+			break;
+		default:
+			rc = -EINVAL;
+			break;
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
 static int do_xaction_device(const char *device, enum device_action action,
 		struct daxctl_ctx *ctx, int *processed)
 {
@@ -610,6 +707,24 @@ static int do_xaction_device(const char *device, enum device_action action,
 	return rc;
 }
 
+int cmd_create_device(int argc, const char **argv, struct daxctl_ctx *ctx)
+{
+	char *usage = "daxctl create-device [<options>]";
+	int processed, rc;
+
+	parse_device_options(argc, argv, ACTION_CREATE,
+			create_options, usage, ctx);
+
+	rc = do_xaction_region(ACTION_CREATE, ctx, &processed);
+	if (rc < 0)
+		fprintf(stderr, "error creating devices: %s\n",
+				strerror(-rc));
+
+	fprintf(stderr, "created %d device%s\n", processed,
+			processed == 1 ? "" : "s");
+	return rc;
+}
+
 int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx)
 {
 	char *usage = "daxctl reconfigure-device <device> [<options>]";
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

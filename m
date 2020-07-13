Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D139421DB3F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:09:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9036011812902;
	Mon, 13 Jul 2020 09:09:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8723011812902
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:09:07 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG21Kk124923;
	Mon, 13 Jul 2020 16:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=g0G2pLw+bxiW8GfO9Bf7h0+3e5MxnPE9tC51iqbaTYk=;
 b=QV+0I335Q0mRdS0zf/1Tfvyo0WK+jtCCno1h32jw9Q0sxLNLPTy4/iFjHmPz5l1Xwnch
 a26OpHBEdqCFdWhKil3vwYJMUKFFlLDocsc3mb+ze3heEW2AFI4VN2reA6EcYZXMZvwx
 zkSMQtf6sjpui7zMOsuR1MX6dcJnlp1HgmJOOyDU7kbhjJoYM5W3R1q1bD38GGJF27CP
 mK9Z8R7MDNPpYc0KFakkofMyj2WK3dFeUx50zJvCGciGZRtFCpYzbXpXPIsJHEgaCcPZ
 DdUIoFzBM/El9oV3pRBKAq2lI3sW4kiRuPrrXMkVdvpbmkqh2WswVbDtPAfioNdTzDf+ mQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 3274ur013p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 16:09:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG3YZv062734;
	Mon, 13 Jul 2020 16:09:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 327q6qgsty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 16:09:05 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DG94ra027627;
	Mon, 13 Jul 2020 16:09:04 GMT
Received: from paddy.uk.oracle.com (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 09:09:04 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2 07/10] daxctl: add command to create device
Date: Mon, 13 Jul 2020 17:08:34 +0100
Message-Id: <20200713160837.13774-8-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200713160837.13774-1-joao.m.martins@oracle.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=1 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
Message-ID-Hash: H4NHX5RGJW566K7R7IID4RSPSASK5QYS
X-Message-ID-Hash: H4NHX5RGJW566K7R7IID4RSPSASK5QYS
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H4NHX5RGJW566K7R7IID4RSPSASK5QYS/>
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
 Documentation/daxctl/Makefile.am              |   3 +-
 Documentation/daxctl/daxctl-create-device.txt | 105 ++++++++++++++++++++++++
 daxctl/builtin.h                              |   1 +
 daxctl/daxctl.c                               |   1 +
 daxctl/device.c                               | 111 +++++++++++++++++++++++++-
 5 files changed, 219 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/daxctl/daxctl-create-device.txt

diff --git a/Documentation/daxctl/Makefile.am b/Documentation/daxctl/Makefile.am
index e43d34183142..27e201dfc254 100644
--- a/Documentation/daxctl/Makefile.am
+++ b/Documentation/daxctl/Makefile.am
@@ -33,7 +33,8 @@ man1_MANS = \
 	daxctl-online-memory.1 \
 	daxctl-offline-memory.1 \
 	daxctl-disable-device.1 \
-	daxctl-enable-device.1
+	daxctl-enable-device.1 \
+	daxctl-create-device.1
 
 EXTRA_DIST = $(man1_MANS)
 
diff --git a/Documentation/daxctl/daxctl-create-device.txt b/Documentation/daxctl/daxctl-create-device.txt
new file mode 100644
index 000000000000..648d2541f833
--- /dev/null
+++ b/Documentation/daxctl/daxctl-create-device.txt
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+
+daxctl-create-device(1)
+=======================
+
+NAME
+----
+daxctl-create-device - Create a devdax device
+
+SYNOPSIS
+--------
+[verse]
+'daxctl create-device' [<options>]
+
+EXAMPLES
+--------
+
+* Creates dax0.1 with 4G of size
+----
+# daxctl create-device -s 4G
+[
+  {
+    "chardev":"dax0.1",
+    "size":4294967296,
+    "target_node":0,
+    "mode":"devdax"
+  }
+]
+----
+
+* Creates devices with fully available size on all regions
+----
+# daxctl create-device -u
+[
+  {
+    "chardev":"dax0.1",
+    "size":"15.63 GiB (16.78 GB)",
+    "target_node":0,
+    "mode":"devdax"
+  },
+  {
+    "chardev":"dax1.1",
+    "size":"15.63 GiB (16.78 GB)",
+    "target_node":1,
+    "mode":"devdax"
+  }
+]
+----
+
+* Creates dax0.1 with fully available size on region id 0
+----
+# daxctl create-device -r 0 -u
+{
+  "chardev":"dax0.1",
+  "size":"15.63 GiB (16.78 GB)",
+  "target_node":0,
+  "mode":"devdax"
+}
+----
+
+DESCRIPTION
+-----------
+
+Creates dax device in 'devdax' mode in dynamic regions. The resultant can also
+be convereted to the 'system-ram' mode which arranges for the dax range to be
+hot-plugged into the system as regular memory.
+
+'daxctl create-device' expects that the BIOS or kernel defines a range in the
+EFI memory map with EFI_MEMORY_SP. The resultant ranges mean that it's
+100% capacity is reserved for applications.
+
+OPTIONS
+-------
+-r::
+--region=::
+	Restrict the operation to devices belonging to the specified region(s).
+	A device-dax region is a contiguous range of memory that hosts one or
+	more /dev/daxX.Y devices, where X is the region id and Y is the device
+	instance id.
+
+-s::
+--size=::
+	For regions that support dax device cretion, set the device size
+	in bytes.  Otherwise it defaults to the maximum size specified by
+	region.  This option supports the suffixes "k" or "K" for KiB, "m" or
+	"M" for MiB, "g" or "G" for GiB and "t" or "T" for TiB.
+
+	The size must be a multiple of the region alignment.
+
+-u::
+--human::
+	By default the command will output machine-friendly raw-integer
+	data. Instead, with this flag, numbers representing storage size
+	will be formatted as human readable strings with units, other
+	fields are converted to hexadecimal strings.
+
+-v::
+--verbose::
+	Emit more debug messages
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkdaxctl:daxctl-list[1],daxctl-reconfigure-device[1],daxctl-destroy-device[1]
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
index 05a9247ecfde..c038abba8063 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -49,6 +49,7 @@ enum device_action {
 	ACTION_RECONFIG,
 	ACTION_ONLINE,
 	ACTION_OFFLINE,
+	ACTION_CREATE,
 	ACTION_DISABLE,
 	ACTION_ENABLE,
 };
@@ -72,6 +73,14 @@ OPT_STRING('s', "size", &param.size, "size", "size to switch the device to")
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
@@ -115,7 +124,8 @@ static const char *parse_device_options(int argc, const char **argv,
 	argc = parse_options(argc, argv, options, u, 0);
 
 	/* Handle action-agnostic non-option arguments */
-	if (argc == 0) {
+	if (argc == 0 &&
+	    action != ACTION_CREATE) {
 		char *action_string;
 
 		switch (action) {
@@ -181,6 +191,10 @@ static const char *parse_device_options(int argc, const char **argv,
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
@@ -452,6 +466,47 @@ static int reconfig_mode_devdax(struct daxctl_dev *dev)
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
@@ -554,6 +609,42 @@ static int do_xble(struct daxctl_dev *dev, enum device_action action)
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
@@ -616,6 +707,24 @@ static int do_xaction_device(const char *device, enum device_action action,
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
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

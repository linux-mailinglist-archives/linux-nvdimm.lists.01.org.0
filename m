Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76321DB41
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:09:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFC8711812903;
	Mon, 13 Jul 2020 09:09:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A543A11812905
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:09:10 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG2oG9153678;
	Mon, 13 Jul 2020 16:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=4s2mSg9kYaDxi57G6K467sUZRbv15wkylcd6Wz2Kx7Y=;
 b=NWUiI7bbBftlpuDLSqEVtpn5uK1/aqODF8O1xVrD1hn9AcCA4mfcC+8iWY//FrzbuwYY
 aM+kFRhDHRZf6qvZah5yJz+aQdXgwoXVLouHnzWfW2ORQu4S+EFtqDGfXkUUpK+iFw85
 tChaeZP1g4HrLuTiCNQlos+fWs/g/IK9LOAFn2Aj+Ai+1prX4Y7KTwebYScXX3wSMoY2
 EMxoUF46Q5aCq/GdKFGAWHEiNHxNOJNaj1ezckGw3QBwq6+Yp1t7arCmg8w0PZJwcQnF
 3aLc8rtoIMRhWCcBgHFxnMp60ed06w4Di9rlgKBi3AWwHM778ciIwehfz5R4GcHveR2O 3Q==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 32762n7v3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 16:09:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG3VBM127198;
	Mon, 13 Jul 2020 16:09:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 327qb11jqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 16:09:08 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06DG97qS010835;
	Mon, 13 Jul 2020 16:09:07 GMT
Received: from paddy.uk.oracle.com (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 09:09:07 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2 09/10] daxctl: add command to destroy device
Date: Mon, 13 Jul 2020 17:08:36 +0100
Message-Id: <20200713160837.13774-10-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200713160837.13774-1-joao.m.martins@oracle.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=1 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
Message-ID-Hash: LCLSLAV7MSCXESM2SIP5Q54VLPYFNVTA
X-Message-ID-Hash: LCLSLAV7MSCXESM2SIP5Q54VLPYFNVTA
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LCLSLAV7MSCXESM2SIP5Q54VLPYFNVTA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a 'destroy-device' command which destroys a
dax device. Like namespaces, the device needs to
be disabled in order to be destroyed. Example usage:

	$ daxctl disable-device dax0.1
	disabled 1 device
	$ daxctl destroy-device dax0.1
	destroyed 1 device

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/daxctl/Makefile.am               |  3 +-
 Documentation/daxctl/daxctl-destroy-device.txt | 63 ++++++++++++++++++++++++
 daxctl/builtin.h                               |  1 +
 daxctl/daxctl.c                                |  1 +
 daxctl/device.c                                | 66 ++++++++++++++++++++++++++
 5 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/daxctl/daxctl-destroy-device.txt

diff --git a/Documentation/daxctl/Makefile.am b/Documentation/daxctl/Makefile.am
index 27e201dfc254..2b3f92ca5b96 100644
--- a/Documentation/daxctl/Makefile.am
+++ b/Documentation/daxctl/Makefile.am
@@ -34,7 +34,8 @@ man1_MANS = \
 	daxctl-offline-memory.1 \
 	daxctl-disable-device.1 \
 	daxctl-enable-device.1 \
-	daxctl-create-device.1
+	daxctl-create-device.1 \
+	daxctl-destroy-device.1
 
 EXTRA_DIST = $(man1_MANS)
 
diff --git a/Documentation/daxctl/daxctl-destroy-device.txt b/Documentation/daxctl/daxctl-destroy-device.txt
new file mode 100644
index 000000000000..1c91cb2fab75
--- /dev/null
+++ b/Documentation/daxctl/daxctl-destroy-device.txt
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+daxctl-destroy-device(1)
+========================
+
+NAME
+----
+daxctl-destroy-device - Destroy a devdax device
+
+SYNOPSIS
+--------
+[verse]
+'daxctl destroy-device' <dax0.0> [<dax1.0>...<daxY.Z>] [<options>]
+
+EXAMPLES
+--------
+
+* Destroys dax0.1
+----
+# daxctl disable-device dax0.1
+disabled 1 device
+# daxctl destroy-device dax0.1
+destroyed 1 device
+----
+
+* Destroys all devices in region id 0
+----
+# daxctl disable-device -r 0 all
+disabled 3 devices
+# daxctl destroy-device -r 0 all
+destroyed 2 devices
+----
+
+DESCRIPTION
+-----------
+
+Destroys a dax device in 'devdax' mode.
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
+linkdaxctl:daxctl-list[1],daxctl-reconfigure-device[1],daxctl-create-device[1]
diff --git a/daxctl/builtin.h b/daxctl/builtin.h
index 19b33933b91b..29ba63ca17aa 100644
--- a/daxctl/builtin.h
+++ b/daxctl/builtin.h
@@ -7,6 +7,7 @@ struct daxctl_ctx;
 int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_migrate(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_create_device(int argc, const char **argv, struct daxctl_ctx *ctx);
+int cmd_destroy_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_disable_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_enable_device(int argc, const char **argv, struct daxctl_ctx *ctx);
diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
index 1f315168c513..bd5539900391 100644
--- a/daxctl/daxctl.c
+++ b/daxctl/daxctl.c
@@ -72,6 +72,7 @@ static struct cmd_struct commands[] = {
 	{ "help", .d_fn = cmd_help },
 	{ "migrate-device-model", .d_fn = cmd_migrate },
 	{ "create-device", .d_fn = cmd_create_device },
+	{ "destroy-device", .d_fn = cmd_destroy_device },
 	{ "reconfigure-device", .d_fn = cmd_reconfig_device },
 	{ "online-memory", .d_fn = cmd_online_memory },
 	{ "offline-memory", .d_fn = cmd_offline_memory },
diff --git a/daxctl/device.c b/daxctl/device.c
index c038abba8063..05293d6c38ee 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -52,6 +52,7 @@ enum device_action {
 	ACTION_CREATE,
 	ACTION_DISABLE,
 	ACTION_ENABLE,
+	ACTION_DESTROY,
 };
 
 #define BASE_OPTIONS() \
@@ -69,6 +70,10 @@ OPT_BOOLEAN('f', "force", &param.force, \
 #define CREATE_OPTIONS() \
 OPT_STRING('s', "size", &param.size, "size", "size to switch the device to")
 
+#define DESTROY_OPTIONS() \
+OPT_BOOLEAN('f', "force", &param.force, \
+		"attempt to disable before destroying device")
+
 #define ZONE_OPTIONS() \
 OPT_BOOLEAN('\0', "no-movable", &param.no_movable, \
 		"online memory in ZONE_NORMAL")
@@ -110,6 +115,12 @@ static const struct option enable_options[] = {
 	OPT_END(),
 };
 
+static const struct option destroy_options[] = {
+	BASE_OPTIONS(),
+	DESTROY_OPTIONS(),
+	OPT_END(),
+};
+
 static const char *parse_device_options(int argc, const char **argv,
 		enum device_action action, const struct option *options,
 		const char *usage, struct daxctl_ctx *ctx)
@@ -144,6 +155,9 @@ static const char *parse_device_options(int argc, const char **argv,
 		case ACTION_ENABLE:
 			action_string = "enable";
 			break;
+		case ACTION_DESTROY:
+			action_string = "destroy";
+			break;
 		default:
 			action_string = "<>";
 			break;
@@ -199,6 +213,7 @@ static const char *parse_device_options(int argc, const char **argv,
 		if (param.no_movable)
 			mem_zone = MEM_ZONE_NORMAL;
 		/* fall through */
+	case ACTION_DESTROY:
 	case ACTION_OFFLINE:
 	case ACTION_DISABLE:
 	case ACTION_ENABLE:
@@ -364,6 +379,35 @@ static int dev_resize(struct daxctl_dev *dev, unsigned long long val)
 	return 0;
 }
 
+static int dev_destroy(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	int rc;
+
+	if (daxctl_dev_is_enabled(dev) && !param.force) {
+		fprintf(stderr, "%s is active, specify --force for deletion\n",
+			devname);
+		return -ENXIO;
+	} else {
+		rc = daxctl_dev_disable(dev);
+		if (rc) {
+			fprintf(stderr, "%s: disable failed: %s\n",
+				daxctl_dev_get_devname(dev), strerror(-rc));
+			return rc;
+		}
+	}
+
+	rc = daxctl_dev_set_size(dev, 0);
+	if (rc < 0)
+		return rc;
+
+	rc = daxctl_region_destroy_dev(daxctl_dev_get_region(dev), dev);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
 static int disable_devdax_device(struct daxctl_dev *dev)
 {
 	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
@@ -689,6 +733,11 @@ static int do_xaction_device(const char *device, enum device_action action,
 				if (rc == 0)
 					(*processed)++;
 				break;
+			case ACTION_DESTROY:
+				rc = dev_destroy(dev);
+				if (rc == 0)
+					(*processed)++;
+				break;
 			default:
 				rc = -EINVAL;
 				break;
@@ -725,6 +774,23 @@ int cmd_create_device(int argc, const char **argv, struct daxctl_ctx *ctx)
 	return rc;
 }
 
+int cmd_destroy_device(int argc, const char **argv, struct daxctl_ctx *ctx)
+{
+	char *usage = "daxctl destroy-device <device> [<options>]";
+	const char *device = parse_device_options(argc, argv, ACTION_DESTROY,
+			destroy_options, usage, ctx);
+	int processed, rc;
+
+	rc = do_xaction_device(device, ACTION_DESTROY, ctx, &processed);
+	if (rc < 0)
+		fprintf(stderr, "error destroying devices: %s\n",
+				strerror(-rc));
+
+	fprintf(stderr, "destroyed %d device%s\n", processed,
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

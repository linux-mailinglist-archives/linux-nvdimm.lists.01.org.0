Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA419E002
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 22:59:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 22E1910FC51DA;
	Fri,  3 Apr 2020 14:00:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BC74A10FC51C4
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 14:00:13 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Khc4W179191;
	Fri, 3 Apr 2020 20:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Ez9oFwfxQpI5bFv79BMhsm0NMm0TPTt06fs3CmxGq+w=;
 b=y3DPvZQjj1wear7at7q7PYPQrhBxpA2p8Uff7kaueaHxuO15uym3mVdY5t/ot+JpHtg1
 hLYGs/WksUO1PycFUb4ru+5DY/qUqTt8h76GUb09peKl1eCUge8KVr9LRy6kAgOCAxK4
 eLIdKQuqWIZsqjalolc3xbi8mFf9HFocBCe3MOerRZff6mjErlm5wPe9WdMr1nBqln5o
 P6tfRBzddXTD/hodKQd9l6f+Hg/A885JwgNnuD/9ZJHKD8ZOnlNovlwrI7GjeXrI8kIJ
 2k5Ib9+A9+cPP0HJPHW6vO+dlsJaXJVPEzHM+VwVg0daRx3LWYawPAmsEp0TtCgB2r8G VA==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 303cevk6hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Kh3I8187980;
	Fri, 3 Apr 2020 20:59:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 302g2nxa24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:21 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033KxKwZ010527;
	Fri, 3 Apr 2020 20:59:21 GMT
Received: from paddy.uk.oracle.com (/10.175.206.152)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 03 Apr 2020 13:59:20 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 09/10] daxctl: add command to destroy device
Date: Fri,  3 Apr 2020 21:58:59 +0100
Message-Id: <20200403205900.18035-10-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403205900.18035-1-joao.m.martins@oracle.com>
References: <20200403205900.18035-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=1 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
Message-ID-Hash: IEHMISWGPJPRD23HANC7OI6GTGG3QAQN
X-Message-ID-Hash: IEHMISWGPJPRD23HANC7OI6GTGG3QAQN
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IEHMISWGPJPRD23HANC7OI6GTGG3QAQN/>
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
 daxctl/builtin.h |  1 +
 daxctl/daxctl.c  |  1 +
 daxctl/device.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

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
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

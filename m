Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503319DFFE
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 22:59:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A57BE10FC51CD;
	Fri,  3 Apr 2020 14:00:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 46B3410FC51C6
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 14:00:06 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Khl2N179253;
	Fri, 3 Apr 2020 20:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=9TvkpcDFwcS6flr+fvE/U4kfWAEXr9r/Y4cBsbpHfhM=;
 b=MM8MMuKbp/2XCdeHCTLQsPHrZ4N/7a8fLTijnkoE1aN831y4P/wGmIWqn6RfHZmKfUXW
 eCH5GyHNWVgFZclUT/WitH6KbyDdrWq93NgIUs0Q2CNQJiem5830B5Ca4iF4gIhqvdDj
 U+Ksnv2hTCOD+u+GKD+d3ktadicOcbWlqlRQ6DryiL2ddFPDxqKyM3Iu54ct4/xozJJN
 vuN4yN5sOQI7CBbEBelzmlO8cy4S1pxRCuc9GwftQL3Uy00PgQuu3gxZD20PsPEvwOyj
 MAYUmEqmSl6UQIyIQl2YuEeDNH6nlwyiQUMzY/HCEAlIB7KUHCahPbKK9/TgLHyOCyxZ VA==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 303cevk6h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KgEbZ047395;
	Fri, 3 Apr 2020 20:59:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 302ga5v0c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:14 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033KxDxN010474;
	Fri, 3 Apr 2020 20:59:14 GMT
Received: from paddy.uk.oracle.com (/10.175.206.152)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 03 Apr 2020 13:59:13 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 04/10] daxctl: add command to disable devdax device
Date: Fri,  3 Apr 2020 21:58:54 +0100
Message-Id: <20200403205900.18035-5-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403205900.18035-1-joao.m.martins@oracle.com>
References: <20200403205900.18035-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=1 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
Message-ID-Hash: KOSYN4J3J3HBI2CZ6AU2GYIVMUAB2GTX
X-Message-ID-Hash: KOSYN4J3J3HBI2CZ6AU2GYIVMUAB2GTX
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KOSYN4J3J3HBI2CZ6AU2GYIVMUAB2GTX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a 'disable-device' command, required prior to
reconfiguration or destruction of the dax device.

Mimmics the same functionality as seen in
ndctl-disable-namespace.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 daxctl/builtin.h |  1 +
 daxctl/daxctl.c  |  1 +
 daxctl/device.c  | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/daxctl/builtin.h b/daxctl/builtin.h
index f5a0147f0e11..c9848953bbd8 100644
--- a/daxctl/builtin.h
+++ b/daxctl/builtin.h
@@ -7,6 +7,7 @@ struct daxctl_ctx;
 int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_migrate(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx);
+int cmd_disable_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_online_memory(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_offline_memory(int argc, const char **argv, struct daxctl_ctx *ctx);
 #endif /* _DAXCTL_BUILTIN_H_ */
diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
index 1ab073200313..1707a9ff0791 100644
--- a/daxctl/daxctl.c
+++ b/daxctl/daxctl.c
@@ -74,6 +74,7 @@ static struct cmd_struct commands[] = {
 	{ "reconfigure-device", .d_fn = cmd_reconfig_device },
 	{ "online-memory", .d_fn = cmd_online_memory },
 	{ "offline-memory", .d_fn = cmd_offline_memory },
+	{ "disable-device", .d_fn = cmd_disable_device },
 };
 
 int main(int argc, const char **argv)
diff --git a/daxctl/device.c b/daxctl/device.c
index b483d2777ecb..7a49852f78f4 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -47,6 +47,7 @@ enum device_action {
 	ACTION_RECONFIG,
 	ACTION_ONLINE,
 	ACTION_OFFLINE,
+	ACTION_DISABLE,
 };
 
 #define BASE_OPTIONS() \
@@ -84,6 +85,11 @@ static const struct option offline_options[] = {
 	OPT_END(),
 };
 
+static const struct option disable_options[] = {
+	BASE_OPTIONS(),
+	OPT_END(),
+};
+
 static const char *parse_device_options(int argc, const char **argv,
 		enum device_action action, const struct option *options,
 		const char *usage, struct daxctl_ctx *ctx)
@@ -110,6 +116,9 @@ static const char *parse_device_options(int argc, const char **argv,
 		case ACTION_OFFLINE:
 			action_string = "offline memory for";
 			break;
+		case ACTION_DISABLE:
+			action_string = "disable";
+			break;
 		default:
 			action_string = "<>";
 			break;
@@ -162,6 +171,7 @@ static const char *parse_device_options(int argc, const char **argv,
 			mem_zone = MEM_ZONE_NORMAL;
 		/* fall through */
 	case ACTION_OFFLINE:
+	case ACTION_DISABLE:
 		/* nothing special */
 		break;
 	}
@@ -491,6 +501,35 @@ static int do_xline(struct daxctl_dev *dev, enum device_action action)
 	return rc;
 }
 
+static int do_xble(struct daxctl_dev *dev, enum device_action action)
+{
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
+	const char *devname = daxctl_dev_get_devname(dev);
+	int rc;
+
+	if (mem) {
+		fprintf(stderr,
+			"%s: status operations are only applicable in devdax mode\n",
+			devname);
+		return -ENXIO;
+	}
+
+	switch (action) {
+	case ACTION_DISABLE:
+		rc = daxctl_dev_disable(dev);
+		if (rc) {
+			fprintf(stderr, "%s: disable failed: %s\n",
+				daxctl_dev_get_devname(dev), strerror(-rc));
+			return rc;
+		}
+		break;
+	default:
+		fprintf(stderr, "%s: invalid action: %d\n", devname, action);
+		rc = -EINVAL;
+	}
+	return rc;
+}
+
 static int do_xaction_device(const char *device, enum device_action action,
 		struct daxctl_ctx *ctx, int *processed)
 {
@@ -525,6 +564,11 @@ static int do_xaction_device(const char *device, enum device_action action,
 				if (rc == 0)
 					(*processed)++;
 				break;
+			case ACTION_DISABLE:
+				rc = do_xble(dev, action);
+				if (rc == 0)
+					(*processed)++;
+				break;
 			default:
 				rc = -EINVAL;
 				break;
@@ -560,6 +604,23 @@ int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx)
 	return rc;
 }
 
+int cmd_disable_device(int argc, const char **argv, struct daxctl_ctx *ctx)
+{
+	char *usage = "daxctl disable-device <device>";
+	const char *device = parse_device_options(argc, argv, ACTION_DISABLE,
+			disable_options, usage, ctx);
+	int processed, rc;
+
+	rc = do_xaction_device(device, ACTION_DISABLE, ctx, &processed);
+	if (rc < 0)
+		fprintf(stderr, "error disabling device: %s\n",
+				strerror(-rc));
+
+	fprintf(stderr, "disabled %d device%s\n", processed,
+			processed == 1 ? "" : "s");
+	return rc;
+}
+
 int cmd_online_memory(int argc, const char **argv, struct daxctl_ctx *ctx)
 {
 	char *usage = "daxctl online-memory <device> [<options>]";
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7853319DFFF
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 22:59:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BCB0A10FC51CF;
	Fri,  3 Apr 2020 14:00:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AAE3010FC51D1
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 14:00:08 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KhrBL120829;
	Fri, 3 Apr 2020 20:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=USTu2J7yvTY2ZvVQPGRdkA4SrFEHXO9GFH83gY+Z7Es=;
 b=QjLw+CuwcRJizGD5T00zawZj6LCl1R9jRrwfyQfKTrLKI44+1eLUbSPlg8uh5Ms2GGgn
 lYPI6B6j+IU6JQZWrm/wL/u5wf3NKfyH0GwZH7yC0QzEYbdzCHRlQMDPlKZSt3xBkd13
 FZDFgwfNjabUF7He7n4pprLak6OGWAMALyAI+hT6qh3AY2LNApqKa1y0SnJ5VN97F7ca
 NQJVKR9bZVbD1eERvjCcT4uyHts8M1XNELq6tM5GuumYjpMOefYsswSR8WuMuJfmDUiq
 3t5Ku0MOxyUqZrXkWbxRGXUL6ytaDLmNhEaSh0I+2iS1mx/dEICv+lcRMPk8n3hg7jre /A==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 303yunnskg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KgEaI047380;
	Fri, 3 Apr 2020 20:59:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 302ga5v0ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033KxFVY010510;
	Fri, 3 Apr 2020 20:59:15 GMT
Received: from paddy.uk.oracle.com (/10.175.206.152)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 03 Apr 2020 13:59:14 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 05/10] daxctl: add command to enable devdax device
Date: Fri,  3 Apr 2020 21:58:55 +0100
Message-Id: <20200403205900.18035-6-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403205900.18035-1-joao.m.martins@oracle.com>
References: <20200403205900.18035-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=1 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
Message-ID-Hash: V24W2CHC3DB2IJ3TQYDKEHW4QMLDVMZO
X-Message-ID-Hash: V24W2CHC3DB2IJ3TQYDKEHW4QMLDVMZO
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V24W2CHC3DB2IJ3TQYDKEHW4QMLDVMZO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a 'enable-device' command, required prior to
reconfiguration of the dax device.

Mimics the same functionality as seen in
ndctl-enable-namespace.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 daxctl/builtin.h |  1 +
 daxctl/daxctl.c  |  1 +
 daxctl/device.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/daxctl/builtin.h b/daxctl/builtin.h
index c9848953bbd8..8f344f86ad20 100644
--- a/daxctl/builtin.h
+++ b/daxctl/builtin.h
@@ -8,6 +8,7 @@ int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_migrate(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_disable_device(int argc, const char **argv, struct daxctl_ctx *ctx);
+int cmd_enable_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_online_memory(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_offline_memory(int argc, const char **argv, struct daxctl_ctx *ctx);
 #endif /* _DAXCTL_BUILTIN_H_ */
diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
index 1707a9ff0791..a4699b3780bd 100644
--- a/daxctl/daxctl.c
+++ b/daxctl/daxctl.c
@@ -75,6 +75,7 @@ static struct cmd_struct commands[] = {
 	{ "online-memory", .d_fn = cmd_online_memory },
 	{ "offline-memory", .d_fn = cmd_offline_memory },
 	{ "disable-device", .d_fn = cmd_disable_device },
+	{ "enable-device", .d_fn = cmd_enable_device },
 };
 
 int main(int argc, const char **argv)
diff --git a/daxctl/device.c b/daxctl/device.c
index 7a49852f78f4..596b6efca34d 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -48,6 +48,7 @@ enum device_action {
 	ACTION_ONLINE,
 	ACTION_OFFLINE,
 	ACTION_DISABLE,
+	ACTION_ENABLE,
 };
 
 #define BASE_OPTIONS() \
@@ -90,6 +91,11 @@ static const struct option disable_options[] = {
 	OPT_END(),
 };
 
+static const struct option enable_options[] = {
+	BASE_OPTIONS(),
+	OPT_END(),
+};
+
 static const char *parse_device_options(int argc, const char **argv,
 		enum device_action action, const struct option *options,
 		const char *usage, struct daxctl_ctx *ctx)
@@ -119,6 +125,9 @@ static const char *parse_device_options(int argc, const char **argv,
 		case ACTION_DISABLE:
 			action_string = "disable";
 			break;
+		case ACTION_ENABLE:
+			action_string = "enable";
+			break;
 		default:
 			action_string = "<>";
 			break;
@@ -172,6 +181,7 @@ static const char *parse_device_options(int argc, const char **argv,
 		/* fall through */
 	case ACTION_OFFLINE:
 	case ACTION_DISABLE:
+	case ACTION_ENABLE:
 		/* nothing special */
 		break;
 	}
@@ -515,6 +525,14 @@ static int do_xble(struct daxctl_dev *dev, enum device_action action)
 	}
 
 	switch (action) {
+	case ACTION_ENABLE:
+		rc = daxctl_dev_enable_devdax(dev);
+		if (rc) {
+			fprintf(stderr, "%s: enable failed: %s\n",
+				daxctl_dev_get_devname(dev), strerror(-rc));
+			return rc;
+		}
+		break;
 	case ACTION_DISABLE:
 		rc = daxctl_dev_disable(dev);
 		if (rc) {
@@ -564,6 +582,11 @@ static int do_xaction_device(const char *device, enum device_action action,
 				if (rc == 0)
 					(*processed)++;
 				break;
+			case ACTION_ENABLE:
+				rc = do_xble(dev, action);
+				if (rc == 0)
+					(*processed)++;
+				break;
 			case ACTION_DISABLE:
 				rc = do_xble(dev, action);
 				if (rc == 0)
@@ -621,6 +644,23 @@ int cmd_disable_device(int argc, const char **argv, struct daxctl_ctx *ctx)
 	return rc;
 }
 
+int cmd_enable_device(int argc, const char **argv, struct daxctl_ctx *ctx)
+{
+	char *usage = "daxctl enable-device <device>";
+	const char *device = parse_device_options(argc, argv, ACTION_DISABLE,
+			enable_options, usage, ctx);
+	int processed, rc;
+
+	rc = do_xaction_device(device, ACTION_ENABLE, ctx, &processed);
+	if (rc < 0)
+		fprintf(stderr, "error enabling device: %s\n",
+				strerror(-rc));
+
+	fprintf(stderr, "enabled %d device%s\n", processed,
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

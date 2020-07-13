Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E5E21DB50
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:11:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A0E0411812918;
	Mon, 13 Jul 2020 09:11:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A3223118128FA
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:11:05 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG36Lt173950;
	Mon, 13 Jul 2020 16:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=v/GishVAFqCGPBy48bYcG//2iv3yh4KG4mjfMhq6f0U=;
 b=okm4H/IIO+X1OvGQwRaAQUT5O2+CGiZfOLfZ3uxTZZr3A4/ltW9vkx/DAfW4OvYqYEia
 UVFPNWnLiuLQs+NjH0fBmehLGuQk1te0ERHsKeQZJM9HEIM0pedXiTikjHmNFbMk37pA
 C0mWeop6riM5zwArxCktcJbec9q8yryvZMi7H5l4xqqYAxo7ELzEsGl+amu1md+dCqd8
 9TDb5iVKL5HGR4HXBD4tmUPTnGzoV5f8eADYhhb9XQ5VtEjWRX2YUJ3Z8A+koqhGm6dD
 V8XaKm6hD73aoziEnQnuCW/wquWeYiRci8qGVrR2aDHliSBIiczCY8TdalXoHBMzAHsJ wA==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 3275ckyydy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 16:11:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG3Xgd138168;
	Mon, 13 Jul 2020 16:09:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 327q0mhxq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 16:09:02 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DG91pi011424;
	Mon, 13 Jul 2020 16:09:01 GMT
Received: from paddy.uk.oracle.com (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 09:09:01 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2 05/10] daxctl: add command to enable devdax device
Date: Mon, 13 Jul 2020 17:08:32 +0100
Message-Id: <20200713160837.13774-6-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200713160837.13774-1-joao.m.martins@oracle.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
Message-ID-Hash: 3S7XVAAOSG2YJI3NVZUXJFNG3U22OCVB
X-Message-ID-Hash: 3S7XVAAOSG2YJI3NVZUXJFNG3U22OCVB
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3S7XVAAOSG2YJI3NVZUXJFNG3U22OCVB/>
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
 Documentation/daxctl/Makefile.am              |  3 +-
 Documentation/daxctl/daxctl-enable-device.txt | 59 +++++++++++++++++++++++++++
 daxctl/builtin.h                              |  1 +
 daxctl/daxctl.c                               |  1 +
 daxctl/device.c                               | 40 ++++++++++++++++++
 5 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/daxctl/daxctl-enable-device.txt

diff --git a/Documentation/daxctl/Makefile.am b/Documentation/daxctl/Makefile.am
index 1f070771cd95..e43d34183142 100644
--- a/Documentation/daxctl/Makefile.am
+++ b/Documentation/daxctl/Makefile.am
@@ -32,7 +32,8 @@ man1_MANS = \
 	daxctl-reconfigure-device.1 \
 	daxctl-online-memory.1 \
 	daxctl-offline-memory.1 \
-	daxctl-disable-device.1
+	daxctl-disable-device.1 \
+	daxctl-enable-device.1
 
 EXTRA_DIST = $(man1_MANS)
 
diff --git a/Documentation/daxctl/daxctl-enable-device.txt b/Documentation/daxctl/daxctl-enable-device.txt
new file mode 100644
index 000000000000..6410d92cafe9
--- /dev/null
+++ b/Documentation/daxctl/daxctl-enable-device.txt
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+daxctl-enable-device(1)
+=======================
+
+NAME
+----
+daxctl-enable-device - Enable a devdax device
+
+SYNOPSIS
+--------
+[verse]
+'daxctl enable-device' <dax0.0> [<dax1.0>...<daxY.Z>] [<options>]
+
+EXAMPLES
+--------
+
+* Enables dax0.1
+----
+# daxctl enable-device dax0.1
+enabled 1 device
+----
+
+* Enables all devices in region id 0
+----
+# daxctl enable-device -r 0 all
+enabled 3 devices
+----
+
+DESCRIPTION
+-----------
+
+Enables a dax device in 'devdax' mode.
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
index 20df2b844774..05a9247ecfde 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -50,6 +50,7 @@ enum device_action {
 	ACTION_ONLINE,
 	ACTION_OFFLINE,
 	ACTION_DISABLE,
+	ACTION_ENABLE,
 };
 
 #define BASE_OPTIONS() \
@@ -95,6 +96,11 @@ static const struct option disable_options[] = {
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
@@ -125,6 +131,9 @@ static const char *parse_device_options(int argc, const char **argv,
 		case ACTION_DISABLE:
 			action_string = "disable";
 			break;
+		case ACTION_ENABLE:
+			action_string = "enable";
+			break;
 		default:
 			action_string = "<>";
 			break;
@@ -178,6 +187,7 @@ static const char *parse_device_options(int argc, const char **argv,
 		/* fall through */
 	case ACTION_OFFLINE:
 	case ACTION_DISABLE:
+	case ACTION_ENABLE:
 		/* nothing special */
 		break;
 	}
@@ -521,6 +531,14 @@ static int do_xble(struct daxctl_dev *dev, enum device_action action)
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
@@ -570,6 +588,11 @@ static int do_xaction_device(const char *device, enum device_action action,
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
@@ -627,6 +650,23 @@ int cmd_disable_device(int argc, const char **argv, struct daxctl_ctx *ctx)
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
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

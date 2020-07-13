Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2321DB4F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:11:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 76F8211812916;
	Mon, 13 Jul 2020 09:11:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 11991118128FF
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:11:03 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG2B9D125089;
	Mon, 13 Jul 2020 16:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=/5cJdvZqwicZ2ywaLEdgmv/rSktSHf+hONT2vIXxwk8=;
 b=JzyFwS9WHQzpC69szgQXZJy+kjcfLD7yUYk6CRRLNMQUpwkSV7kXK9VO6KTDh7l8twD6
 L6yV9kaki9KqrciPe2neeJg17u/NY1o6VDpG+cJ56zCyu33XpGAPNOocfwPsiP0B+kO7
 sxO0YE/rizLe2Qkqqk6iM4e8LlVAxXN8SD+RVtajTHWYBgAs2XFRhxXvC38FMolOWpLD
 BfVh+mTzHPYf7+bWxkIQdgPJBO6BouQ4sJDPxTU4oAmi+dJy1elNPQ3YgmtWyQmLfGCq
 oixr/dUFTF8ktzftkT+Uaz9+D7FcDWNtykyw7wyhF5bcUrA7xqG/rD3axi1q2Q+AyVUc hg==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 3274ur01eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 16:11:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG4a06008077;
	Mon, 13 Jul 2020 16:09:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 327qbvu1w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 16:09:01 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DG90Z7011414;
	Mon, 13 Jul 2020 16:09:00 GMT
Received: from paddy.uk.oracle.com (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 09:09:00 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2 04/10] daxctl: add command to disable devdax device
Date: Mon, 13 Jul 2020 17:08:31 +0100
Message-Id: <20200713160837.13774-5-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200713160837.13774-1-joao.m.martins@oracle.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=1 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
Message-ID-Hash: 4QTNJNVLGUP3GZC7EKM53XKFQ6YZM55I
X-Message-ID-Hash: 4QTNJNVLGUP3GZC7EKM53XKFQ6YZM55I
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4QTNJNVLGUP3GZC7EKM53XKFQ6YZM55I/>
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
 Documentation/daxctl/Makefile.am               |  3 +-
 Documentation/daxctl/daxctl-disable-device.txt | 58 ++++++++++++++++++++++++
 daxctl/builtin.h                               |  1 +
 daxctl/daxctl.c                                |  1 +
 daxctl/device.c                                | 61 ++++++++++++++++++++++++++
 5 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/daxctl/daxctl-disable-device.txt

diff --git a/Documentation/daxctl/Makefile.am b/Documentation/daxctl/Makefile.am
index 7696e23cc9c0..1f070771cd95 100644
--- a/Documentation/daxctl/Makefile.am
+++ b/Documentation/daxctl/Makefile.am
@@ -31,7 +31,8 @@ man1_MANS = \
 	daxctl-migrate-device-model.1 \
 	daxctl-reconfigure-device.1 \
 	daxctl-online-memory.1 \
-	daxctl-offline-memory.1
+	daxctl-offline-memory.1 \
+	daxctl-disable-device.1
 
 EXTRA_DIST = $(man1_MANS)
 
diff --git a/Documentation/daxctl/daxctl-disable-device.txt b/Documentation/daxctl/daxctl-disable-device.txt
new file mode 100644
index 000000000000..383aeeb58150
--- /dev/null
+++ b/Documentation/daxctl/daxctl-disable-device.txt
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+daxctl-disable-device(1)
+========================
+
+NAME
+----
+daxctl-disable-device - Disables a devdax device
+
+SYNOPSIS
+--------
+[verse]
+'daxctl disable-device' [<options>]
+
+EXAMPLES
+--------
+
+* Disables dax0.1
+----
+# daxctl disable-device dax0.1
+----
+
+* Disables all devices in region id 0
+----
+# daxctl disable-device -r 0 all
+disabled 3 devices
+----
+
+DESCRIPTION
+-----------
+
+Disables a dax device in 'devdax' mode.
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
index 033e098eafe0..20df2b844774 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -49,6 +49,7 @@ enum device_action {
 	ACTION_RECONFIG,
 	ACTION_ONLINE,
 	ACTION_OFFLINE,
+	ACTION_DISABLE,
 };
 
 #define BASE_OPTIONS() \
@@ -89,6 +90,11 @@ static const struct option offline_options[] = {
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
@@ -116,6 +122,9 @@ static const char *parse_device_options(int argc, const char **argv,
 		case ACTION_OFFLINE:
 			action_string = "offline memory for";
 			break;
+		case ACTION_DISABLE:
+			action_string = "disable";
+			break;
 		default:
 			action_string = "<>";
 			break;
@@ -168,6 +177,7 @@ static const char *parse_device_options(int argc, const char **argv,
 			mem_zone = MEM_ZONE_NORMAL;
 		/* fall through */
 	case ACTION_OFFLINE:
+	case ACTION_DISABLE:
 		/* nothing special */
 		break;
 	}
@@ -497,6 +507,35 @@ static int do_xline(struct daxctl_dev *dev, enum device_action action)
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
@@ -531,6 +570,11 @@ static int do_xaction_device(const char *device, enum device_action action,
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
@@ -566,6 +610,23 @@ int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx)
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
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDBC21DB4E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:11:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 603A8117E12B1;
	Mon, 13 Jul 2020 09:11:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3D237118128FA
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:11:02 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG21Cx124931;
	Mon, 13 Jul 2020 16:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=NRrv/MewWLA7Zo9aIabo5WeLfhrLsA2v49PBPELlUqQ=;
 b=xZQkL92cHIZ/ZX2KFLNygKdkIYJjH+B59r9iuUOcwWcbKzP4g7Hp78vqPBQtV1l3QD8X
 0SA8N6iHxge83Hwz0Zoanw0U8qVO9PG7nQHnhwEAewEw65DagD8lfddzhVa/WunHXGDO
 X1xCfQLTEpI5EWMzMI4XcBJRdLJJwR/KECLxwo3ZuGcC12Zycs6mg3YrQcSk4czPbPu4
 JYQ3PemOzy+l7/zNfhYBct/PUgHfKwnWmsVQkxBpRuqYc//kVD6R53IaSbios+Qorx0W
 Pu4X4V/ZBZtwS5VJKZ5B7PlaSb59yX6ZVcwXf5H3ac0ZAooCoYLfOcJ61T+xRK7qnzxP 4w==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 3274ur01ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 16:11:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG3WmX127445;
	Mon, 13 Jul 2020 16:09:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 327qb11j9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 16:09:00 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DG8wcV011403;
	Mon, 13 Jul 2020 16:08:59 GMT
Received: from paddy.uk.oracle.com (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 09:08:58 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2 03/10] daxctl: add resize support in reconfigure-device
Date: Mon, 13 Jul 2020 17:08:30 +0100
Message-Id: <20200713160837.13774-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200713160837.13774-1-joao.m.martins@oracle.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=1 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
Message-ID-Hash: 3RNTK42HY2UJHZA6TXFHFFC553N6U5I4
X-Message-ID-Hash: 3RNTK42HY2UJHZA6TXFHFFC553N6U5I4
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3RNTK42HY2UJHZA6TXFHFFC553N6U5I4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the ability to change the size of an inactive dax
device. Uses of this includes adjusting existing devices
or enterily freeing the region device to make the space
available.

	$ daxctl disable-device dax0.0
	disabled 1 device
	$ daxctl reconfigure-device -s 0 dax0.0
	reconfigured 1 device
	$ daxctl reconfigure-device -s 4G dax0.0
	reconfigured 1 device

@size (-s) and @mode (-m) are mutually exclusive as the latter relates
to assigning memory to System-RAM through kmem as opposed
to reconfiguring dynamic dax devices.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/daxctl/daxctl-reconfigure-device.txt | 16 +++++++++++
 daxctl/device.c                                    | 32 ++++++++++++++++++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
index cb28fed24e52..8caae436faae 100644
--- a/Documentation/daxctl/daxctl-reconfigure-device.txt
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -75,6 +75,14 @@ daxctl_dev_get_target_node() or 'daxctl list')
 # numactl --cpunodebind=0-1 --membind=2 -- some-service --opt1 --opt2
 ----
 
+* Change the size of a dax device
+----
+# daxctl reconfigure-device dax0.1 -s 16G
+reconfigured 1 device
+# daxctl reconfigure-device dax0.1 -s 0
+reconfigured 1 device
+----
+
 DESCRIPTION
 -----------
 
@@ -120,6 +128,14 @@ OPTIONS
 	more /dev/daxX.Y devices, where X is the region id and Y is the device
 	instance id.
 
+-s::
+--size=::
+	For regions that support dax device creation, change the device size
+	in bytes. This option supports the suffixes "k" or "K" for KiB, "m" or
+	"M" for MiB, "g" or "G" for GiB and "t" or "T" for TiB.
+
+	The size must be a multiple of the region alignment.
+
 -m::
 --mode=::
 	Specify the mode to which the dax device(s) should be reconfigured.
diff --git a/daxctl/device.c b/daxctl/device.c
index 705f1f8ff7f6..033e098eafe0 100644
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
@@ -34,6 +36,7 @@ enum dev_mode {
 };
 
 static enum dev_mode reconfig_mode = DAXCTL_DEV_MODE_UNKNOWN;
+static long long size = -1;
 static unsigned long flags;
 
 enum memory_zone {
@@ -60,12 +63,16 @@ OPT_BOOLEAN('N', "no-online", &param.no_online, \
 OPT_BOOLEAN('f', "force", &param.force, \
 		"attempt to offline memory sections before reconfiguration")
 
+#define CREATE_OPTIONS() \
+OPT_STRING('s', "size", &param.size, "size", "size to switch the device to")
+
 #define ZONE_OPTIONS() \
 OPT_BOOLEAN('\0', "no-movable", &param.no_movable, \
 		"online memory in ZONE_NORMAL")
 
 static const struct option reconfig_options[] = {
 	BASE_OPTIONS(),
+	CREATE_OPTIONS(),
 	RECONFIG_OPTIONS(),
 	ZONE_OPTIONS(),
 	OPT_END(),
@@ -90,6 +97,7 @@ static const char *parse_device_options(int argc, const char **argv,
 		usage,
 		NULL
 	};
+	unsigned long long units = 1;
 	int i, rc = 0;
 
 	argc = parse_options(argc, argv, options, u, 0);
@@ -135,12 +143,14 @@ static const char *parse_device_options(int argc, const char **argv,
 	/* Handle action-specific options */
 	switch (action) {
 	case ACTION_RECONFIG:
-		if (!param.mode) {
-			fprintf(stderr, "error: a 'mode' option is required\n");
+		if (!param.size && !param.mode) {
+			fprintf(stderr, "error: a 'mode' or 'size' option is required\n");
 			usage_with_options(u, reconfig_options);
 			rc = -EINVAL;
 		}
-		if (strcmp(param.mode, "system-ram") == 0) {
+		if (param.size) {
+			size = __parse_size64(param.size, &units);
+		} else if (strcmp(param.mode, "system-ram") == 0) {
 			reconfig_mode = DAXCTL_DEV_MODE_RAM;
 			if (param.no_movable)
 				mem_zone = MEM_ZONE_NORMAL;
@@ -309,6 +319,17 @@ static int dev_offline_memory(struct daxctl_dev *dev)
 	return 0;
 }
 
+static int dev_resize(struct daxctl_dev *dev, unsigned long long val)
+{
+	int rc;
+
+	rc = daxctl_dev_set_size(dev, val);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
 static int disable_devdax_device(struct daxctl_dev *dev)
 {
 	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
@@ -418,6 +439,11 @@ static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
 	struct json_object *jdev;
 	int rc = 0;
 
+	if (size >= 0) {
+		rc = dev_resize(dev, size);
+		return rc;
+	}
+
 	switch (mode) {
 	case DAXCTL_DEV_MODE_RAM:
 		rc = reconfig_mode_system_ram(dev);
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

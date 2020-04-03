Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3719DFFD
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 22:59:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 89A9310FC51CA;
	Fri,  3 Apr 2020 14:00:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 159B510FC51CB
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 14:00:05 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KgsdB091302;
	Fri, 3 Apr 2020 20:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=fd+kj5hdUgEeSzZU5xxwpKSvsunJ1vivSskCCrtknrw=;
 b=jkLGlFdeXP74a1JMEvwbYPvnBccdBbDRRrHvzlPVwpFev8doRZmD0XQNVDwS4RqQNRkU
 p9xCQokkHF9+xhI20dCJS066bnvPEbY3OuYpL0zUAvlq9cFSjIoWU1sJgiXLZyUvmq7M
 krnPuwDZUwu9AxPojkWz1+6m1K7Fv0ICJJ9NPuWPIGfbX+SVpDErvCHZn2IuXK6vLKB9
 EH4D34cm5+SnSFpeOTQZ5KEscwvsVG9iCkWRe3AK1XJPAmB36Bca9qA293jV8s4+SlXG
 Idcsd50lS96z/Lv41i7oT2vLVX7tsrhV9PIZ5ZI2uUt/niiBzafc/2lwyFSgUinRlzGD lg==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 303aqj3p78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KgPum033055;
	Fri, 3 Apr 2020 20:59:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3030.oracle.com with ESMTP id 302g4y65yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:12 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033KxCH2017746;
	Fri, 3 Apr 2020 20:59:12 GMT
Received: from paddy.uk.oracle.com (/10.175.206.152)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 03 Apr 2020 13:59:11 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 03/10] daxctl: add resize support in reconfigure-device
Date: Fri,  3 Apr 2020 21:58:53 +0100
Message-Id: <20200403205900.18035-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403205900.18035-1-joao.m.martins@oracle.com>
References: <20200403205900.18035-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=1
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
Message-ID-Hash: IXLLV4J7EZCIIJY4FXQFUTZTKMYJOZ4O
X-Message-ID-Hash: IXLLV4J7EZCIIJY4FXQFUTZTKMYJOZ4O
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IXLLV4J7EZCIIJY4FXQFUTZTKMYJOZ4O/>
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
 daxctl/device.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index 705f1f8ff7f6..b483d2777ecb 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -34,6 +34,7 @@ enum dev_mode {
 };
 
 static enum dev_mode reconfig_mode = DAXCTL_DEV_MODE_UNKNOWN;
+static long long size = -1;
 static unsigned long flags;
 
 enum memory_zone {
@@ -66,6 +67,7 @@ OPT_BOOLEAN('\0', "no-movable", &param.no_movable, \
 
 static const struct option reconfig_options[] = {
 	BASE_OPTIONS(),
+	CREATE_OPTIONS(),
 	RECONFIG_OPTIONS(),
 	ZONE_OPTIONS(),
 	OPT_END(),
@@ -135,12 +137,14 @@ static const char *parse_device_options(int argc, const char **argv,
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
@@ -309,6 +313,17 @@ static int dev_offline_memory(struct daxctl_dev *dev)
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
@@ -418,6 +433,11 @@ static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
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
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

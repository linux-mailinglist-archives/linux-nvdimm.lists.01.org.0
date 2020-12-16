Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBB52DC938
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 23:48:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC336100EBB75;
	Wed, 16 Dec 2020 14:48:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27785100EBB76
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 14:48:54 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMi10q019589;
	Wed, 16 Dec 2020 22:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=B0dy9D2weTcjwqQA1i/KQqBz7OKzXzMiz4rqQduhPu4=;
 b=NdFkPr+6xzIBgYUOzWUpx69UnaAk2tjuiJuFt6W1RnnkprGIu5EbBQWjT5ZHnGiiaxZC
 144fLiJNqXxVEp33UF9SJvBleQd0lIINwx+tGl2XmuyzDYygKRh06TPennOuh+AfEqdM
 4Lq0Buw/T4Xhw/Txuf2eEgjyA3PGrJWo2TQ/ZiSeXPuJZTI2dpAs3Og4ej2Ea5JFAAMp
 Btx//6VEii+h1wXSu08eCbUlUxodjKqOyo2DDAK2vSFM69H2OOMHEYAYLPkvMfznAhUJ
 5Zb/okRQXsgj/4xdAdT2wNW5OBgT2oFfSe1r4ASpswgfgLJGY4u5clqoNsRI6Aw6990+ WA==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 35ckcbjyt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 22:48:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMj9Cp124697;
	Wed, 16 Dec 2020 22:48:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 35e6eshtqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 22:48:51 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BGMmoO0017701;
	Wed, 16 Dec 2020 22:48:50 GMT
Received: from paddy.uk.oracle.com (/10.175.172.71)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 14:48:49 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 3/5] daxctl: add align support in reconfigure-device
Date: Wed, 16 Dec 2020 22:48:31 +0000
Message-Id: <20201216224833.6229-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201216224833.6229-1-joao.m.martins@oracle.com>
References: <20201216224833.6229-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160141
Message-ID-Hash: RMHMOREJMY7RZWG36HDJJF6C4QYD4GRU
X-Message-ID-Hash: RMHMOREJMY7RZWG36HDJJF6C4QYD4GRU
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RMHMOREJMY7RZWG36HDJJF6C4QYD4GRU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an alignment option to reconfigure-device and use the newly added
libdaxctl API to set the alignment of the device prior to setting size.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 Documentation/daxctl/daxctl-reconfigure-device.txt | 12 +++++++++++
 daxctl/device.c                                    | 24 +++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
index 8caae436faae..272d5d80222d 100644
--- a/Documentation/daxctl/daxctl-reconfigure-device.txt
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -136,6 +136,18 @@ OPTIONS
 
 	The size must be a multiple of the region alignment.
 
+	This option is mutually exclusive with -m or --mode.
+
+-a::
+--align::
+	Applications that want to establish dax memory mappings with
+	page table entries greater than system base page size (4K on
+	x86) need a device that is sufficiently aligned. This defaults
+	to 2M. Note that "devdax" mode enforces all mappings to be
+	aligned to this value, i.e. it fails unaligned mapping attempts.
+
+	This option is mutually exclusive with -m or --mode.
+
 -m::
 --mode=::
 	Specify the mode to which the dax device(s) should be reconfigured.
diff --git a/daxctl/device.c b/daxctl/device.c
index 05293d6c38ee..a5394577908d 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -22,6 +22,7 @@ static struct {
 	const char *mode;
 	const char *region;
 	const char *size;
+	const char *align;
 	bool no_online;
 	bool no_movable;
 	bool force;
@@ -36,6 +37,7 @@ enum dev_mode {
 };
 
 static enum dev_mode reconfig_mode = DAXCTL_DEV_MODE_UNKNOWN;
+static long long align = -1;
 static long long size = -1;
 static unsigned long flags;
 
@@ -68,7 +70,8 @@ OPT_BOOLEAN('f', "force", &param.force, \
 		"attempt to offline memory sections before reconfiguration")
 
 #define CREATE_OPTIONS() \
-OPT_STRING('s', "size", &param.size, "size", "size to switch the device to")
+OPT_STRING('s', "size", &param.size, "size", "size to switch the device to"), \
+OPT_STRING('a', "align", &param.align, "align", "alignment to switch the device to")
 
 #define DESTROY_OPTIONS() \
 OPT_BOOLEAN('f', "force", &param.force, \
@@ -185,13 +188,18 @@ static const char *parse_device_options(int argc, const char **argv,
 	/* Handle action-specific options */
 	switch (action) {
 	case ACTION_RECONFIG:
-		if (!param.size && !param.mode) {
-			fprintf(stderr, "error: a 'mode' or 'size' option is required\n");
+		if (!param.size &&
+		    !param.align &&
+		    !param.mode) {
+			fprintf(stderr, "error: a 'align', 'mode' or 'size' option is required\n");
 			usage_with_options(u, reconfig_options);
 			rc = -EINVAL;
 		}
-		if (param.size) {
-			size = __parse_size64(param.size, &units);
+		if (param.size || param.align) {
+			if (param.size)
+				size = __parse_size64(param.size, &units);
+			if (param.align)
+				align = __parse_size64(param.align, &units);
 		} else if (strcmp(param.mode, "system-ram") == 0) {
 			reconfig_mode = DAXCTL_DEV_MODE_RAM;
 			if (param.no_movable)
@@ -558,6 +566,12 @@ static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
 	struct json_object *jdev;
 	int rc = 0;
 
+	if (align > 0) {
+		rc = daxctl_dev_set_align(dev, align);
+		if (rc < 0)
+			return rc;
+	}
+
 	if (size >= 0) {
 		rc = dev_resize(dev, size);
 		return rc;
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

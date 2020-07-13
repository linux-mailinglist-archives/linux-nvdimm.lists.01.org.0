Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A1721DB3D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:09:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 50119118128FE;
	Mon, 13 Jul 2020 09:09:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 57BFD118128FA
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:09:01 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG2sr8153766;
	Mon, 13 Jul 2020 16:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=WKwprZiq492CwV4bVGMZKAghzGepHyPSRuyoU/cWs9I=;
 b=lWM+ixZjBzWkSSKXctoQaZJpipmkO9BnIHhmJsrop5mbTZe6mG2mRTVdr9ZSXoLkadhO
 170LPMrEVmq4QP8m2DiBE5ktcNPGpwOW3XhuIJVumUgTurNDc4F6VP8Ic3M6B3lMGZGs
 5noiCu3wyv7LOsIa5wKFmnxqG8TE7xBFcaMYad1stQ++9gXZaX1eoFtsE0lfSZkuKLI2
 60/JXmoR1OaIePhOXR9bI/muwAMMnyhcG2OJtxaRZ9ssCn5MrEFxWh7VjItJ3kP+GxjO
 N5E63uFNt2DxR5CQ8EYJ4Mjocv9T8FlJucsLs2J34kAUoheSdpWYoaL246/uue5WVTHb XQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 32762n7v2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 16:08:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG3Wrg138095;
	Mon, 13 Jul 2020 16:08:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 327q0mhxgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 16:08:58 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DG8vI3011393;
	Mon, 13 Jul 2020 16:08:57 GMT
Received: from paddy.uk.oracle.com (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 09:08:57 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2 02/10] libdaxctl: add daxctl_dev_set_size()
Date: Mon, 13 Jul 2020 17:08:29 +0100
Message-Id: <20200713160837.13774-3-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200713160837.13774-1-joao.m.martins@oracle.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=1 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
Message-ID-Hash: NJXOYN7EFJ6QSDI2XXE5DZUIXYYH3ZRC
X-Message-ID-Hash: NJXOYN7EFJ6QSDI2XXE5DZUIXYYH3ZRC
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NJXOYN7EFJ6QSDI2XXE5DZUIXYYH3ZRC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an API for setting the size of a dax device.

This sysfs attribute is only writeable for a dynamic
dax device such as the one exported by hmem.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 daxctl/lib/libdaxctl.c   | 24 ++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym |  5 +++++
 daxctl/libdaxctl.h       |  1 +
 3 files changed, 30 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index ee4a069eb463..00d5f7fe61ad 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1019,6 +1019,30 @@ DAXCTL_EXPORT unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev)
 	return dev->size;
 }
 
+DAXCTL_EXPORT int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long size)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char buf[SYSFS_ATTR_SIZE];
+	char *path = dev->dev_buf;
+	int len = dev->buf_len;
+
+	if (snprintf(path, len, "%s/size", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+
+	sprintf(buf, "%#llx\n", size);
+	if (sysfs_write_attr(ctx, path, buf) < 0) {
+		err(ctx, "%s: failed to set size\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+
+	dev->size = size;
+	return 0;
+}
+
 DAXCTL_EXPORT int daxctl_dev_get_target_node(struct daxctl_dev *dev)
 {
 	return dev->target_node;
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 87d02366a917..d8b4137c76b7 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -75,3 +75,8 @@ global:
 	daxctl_memory_is_movable;
 	daxctl_memory_online_no_movable;
 } LIBDAXCTL_6;
+
+LIBDAXCTL_8 {
+global:
+	daxctl_dev_set_size;
+} LIBDAXCTL_7;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 6c545e1f3055..e3d482743cc6 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -68,6 +68,7 @@ int daxctl_dev_get_major(struct daxctl_dev *dev);
 int daxctl_dev_get_minor(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_resource(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev);
+int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long size);
 struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev);
 int daxctl_dev_is_enabled(struct daxctl_dev *dev);
 int daxctl_dev_disable(struct daxctl_dev *dev);
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

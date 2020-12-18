Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271682DDCE3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 03:17:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7BFAF100EB859;
	Thu, 17 Dec 2020 18:17:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A3710100EB84D
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 18:17:03 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI2G5JC014056;
	Fri, 18 Dec 2020 02:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=sYgGLcTcsQaq4OWP+USSdocYF/Hqfy6hUH9SkjvBDzs=;
 b=Q5TMI+fo/HWdVuWSbH/5b4arfA2zFRGDHXJWsQFKeV3A+ddWVwUhzw3S77fF+GbOiJjj
 eIGC7FXPZEG5TKpyJ1csOvodvYj/4DJ7c+c9e+BYvxawDTetwLDon/W1lqdzBf+o7PpN
 GBzIsgAiwnueaGkTaD9h4Nk/yRexmOrsY8yMz7UgHFsm/M9ORfWpw3ro7Gq5WUAPIHHN
 89ucd9dcishlnKgSYk+68WDrgszAGEt6rhQHROwVfhP2qLsfwYPjQzZlXBZmY6bSJyC/
 E338vYt2H/wQURCYLeyQDdg29dNMq+fQkUiTChPcz8Qu3fo+8DDUXA5FBGrQMEZGqJHU 5w==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 35cntmg9bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Dec 2020 02:17:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI25Iwa101402;
	Fri, 18 Dec 2020 02:15:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 35e6eu4aw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Dec 2020 02:15:01 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BI2F0JT026939;
	Fri, 18 Dec 2020 02:15:00 GMT
Received: from paddy.uk.oracle.com (/10.175.180.204)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Dec 2020 18:15:00 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 3/5] libdaxctl: add daxctl_dev_set_mapping()
Date: Fri, 18 Dec 2020 02:14:36 +0000
Message-Id: <20201218021438.8926-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218021438.8926-1-joao.m.martins@oracle.com>
References: <20201218021438.8926-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180013
Message-ID-Hash: MUG6NKKW6T2KOUI3FNL5WBBGOWT4KQNM
X-Message-ID-Hash: MUG6NKKW6T2KOUI3FNL5WBBGOWT4KQNM
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MUG6NKKW6T2KOUI3FNL5WBBGOWT4KQNM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This API adds the ability to manually pick a range within the region
device.  Such routine allows for a admin to restore the mappings of a
device after kexec. This is specially useful for hmem dynamic devdax
which do not persistent ranges allocation through say a e.g. namespace
label storage area. It also allows an userspace application to pick
it's own ranges, should it want to avoid relying on kernel's policy.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 daxctl/lib/libdaxctl.c   | 27 +++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym |  1 +
 daxctl/libdaxctl.h       |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 3781e9ed27d5..59fe84fee409 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1123,6 +1123,33 @@ DAXCTL_EXPORT int daxctl_dev_set_align(struct daxctl_dev *dev, unsigned long ali
 	return 0;
 }
 
+DAXCTL_EXPORT int daxctl_dev_set_mapping(struct daxctl_dev *dev,
+					unsigned long long start,
+					unsigned long long end)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	unsigned long long size = end - start + 1;
+	char buf[SYSFS_ATTR_SIZE];
+	char *path = dev->dev_buf;
+	int len = dev->buf_len;
+
+	if (snprintf(path, len, "%s/mapping", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+
+	sprintf(buf, "%#llx-%#llx\n", start, end);
+	if (sysfs_write_attr(ctx, path, buf) < 0) {
+		err(ctx, "%s: failed to set mapping\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+	dev->size += size;
+
+	return 0;
+}
+
 DAXCTL_EXPORT int daxctl_dev_get_target_node(struct daxctl_dev *dev)
 {
 	return dev->target_node;
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 08362b683678..a4e16848494b 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -89,4 +89,5 @@ global:
 	daxctl_mapping_get_end;
 	daxctl_mapping_get_offset;
 	daxctl_mapping_get_size;
+	daxctl_dev_set_mapping;
 } LIBDAXCTL_7;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index f94a72fed85b..09439c16d6df 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -73,6 +73,8 @@ unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev);
 int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long size);
 unsigned long daxctl_dev_get_align(struct daxctl_dev *dev);
 int daxctl_dev_set_align(struct daxctl_dev *dev, unsigned long align);
+int daxctl_dev_set_mapping(struct daxctl_dev *dev, unsigned long long start,
+			unsigned long long end);
 struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev);
 int daxctl_dev_is_enabled(struct daxctl_dev *dev);
 int daxctl_dev_disable(struct daxctl_dev *dev);
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541AD19E007
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 23:01:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94C6210FC51DE;
	Fri,  3 Apr 2020 14:02:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6DFC010FC51DC
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 14:02:08 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Kgl23091244;
	Fri, 3 Apr 2020 21:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=+OBMxDlek6YSV3REttEfzzAIGuM6AYK8mHwkdWYxYkA=;
 b=sFhJz+yd4mePI8VZEDazUQ7GLX9V7e6zOqiWUcqdZbbgV4so0huGDLRlcHnLJicouJm6
 cAPw1j5WbRrfEi7YlIAX614qh/cxr3T9G9LkD5igYIPP2sCcv6vnBnp2KsMSM9SJbftS
 Aa/TXcipBrh0TesewVGbC+5GIoryB99u4jMNLBxfyAr4kmR1Qmlzr92geNdRa1HL1oQn
 d16d9fQ8w8rTtEk3OLxb+2wtCJkEIpff91/yAOdLYDjCiVpHdhgCbkaDLjWb5SItCe43
 EU8C5NSXtLkbv+FdwYw7cklRJJh63TmzO31RogdQFXvpb4GUTSfqfhbl0CNB5UscskCZ KQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 303aqj3pft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 21:01:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033KgEfn047391;
	Fri, 3 Apr 2020 20:59:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 302ga5v0fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2020 20:59:17 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033KxGEk001068;
	Fri, 3 Apr 2020 20:59:16 GMT
Received: from paddy.uk.oracle.com (/10.175.206.152)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 03 Apr 2020 13:59:16 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 06/10] libdaxctl: add daxctl_region_create_dev()
Date: Fri,  3 Apr 2020 21:58:56 +0100
Message-Id: <20200403205900.18035-7-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403205900.18035-1-joao.m.martins@oracle.com>
References: <20200403205900.18035-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030165
Message-ID-Hash: FQPBOASC5T25B6NYGZO6JTZ7RDUHB3IC
X-Message-ID-Hash: FQPBOASC5T25B6NYGZO6JTZ7RDUHB3IC
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FQPBOASC5T25B6NYGZO6JTZ7RDUHB3IC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an API to create an empty seed device.

This sysfs attribute is only writeable for a dynamic
dax device such as the one exported by hmem.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 daxctl/lib/libdaxctl.c   | 26 ++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym |  1 +
 daxctl/libdaxctl.h       |  1 +
 3 files changed, 28 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 00d5f7fe61ad..d17ff7a02bad 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -583,6 +583,32 @@ DAXCTL_EXPORT unsigned long long daxctl_region_get_available_size(
 	return 0;
 }
 
+DAXCTL_EXPORT int daxctl_region_create_dev(struct daxctl_region *region)
+{
+	struct daxctl_ctx *ctx = daxctl_region_get_ctx(region);
+	char *path = region->region_buf;
+	int rc, len = region->buf_len;
+	char *num_devices;
+
+	if (snprintf(path, len, "%s/%s/create", region->region_path, attrs) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_region_get_devname(region));
+		return -EFAULT;
+	}
+
+	if (asprintf(&num_devices, "%d", 1) < 0) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_region_get_devname(region));
+		return -EFAULT;
+	}
+
+	rc = sysfs_write_attr(ctx, path, num_devices);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 DAXCTL_EXPORT struct daxctl_dev *daxctl_region_get_dev_seed(
 		struct daxctl_region *region)
 {
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index d8b4137c76b7..26987ba021ab 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -79,4 +79,5 @@ global:
 LIBDAXCTL_8 {
 global:
 	daxctl_dev_set_size;
+	daxctl_region_create_dev;
 } LIBDAXCTL_7;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index e3d482743cc6..a579ddd1d43c 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -56,6 +56,7 @@ unsigned long daxctl_region_get_align(struct daxctl_region *region);
 const char *daxctl_region_get_devname(struct daxctl_region *region);
 const char *daxctl_region_get_path(struct daxctl_region *region);
 
+int daxctl_region_create_dev(struct daxctl_region *region);
 struct daxctl_dev *daxctl_region_get_dev_seed(struct daxctl_region *region);
 
 struct daxctl_dev;
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

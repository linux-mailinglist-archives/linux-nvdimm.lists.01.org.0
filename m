Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC2D21DB40
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:09:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A431711812905;
	Mon, 13 Jul 2020 09:09:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F1F7911812903
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:09:09 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG2odv153693;
	Mon, 13 Jul 2020 16:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=WGLplW2NpfAwk85W5JfJubuEaQCeJRBR89eeTZsInvA=;
 b=gXyJmWWIE31Hjuvlr7942xDnOFxGKMIDYCZhKEwuvxcQdBAR99vqHJIPknAF1xxe9kwS
 hNI0DZl6SzT2z0qtsoFV1M8RyJ8vsDMpTCJbISp+uo31wKOaGtwRNM+RbBYXreR92BUn
 Li8qYDOmmm0GZibCIEULpi7Iv8jcex4tuKVoDfazcWgUF3O5aVhvA95mgbkux/Wk7saf
 sj9Yh0f0tynSrEhc2AUHCw8PMCIMu5ReEAGgUWCkZHqly9GJ+scI/iXnZO71pLsdhs6g
 pM2LV7O9x8yGTZdqFYvqlovvGxrMAdgrpIhfgXkbPuwo6mizfWbykXhPMePB4GL3iw0/ jQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 32762n7v3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 16:09:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG3XU3138108;
	Mon, 13 Jul 2020 16:09:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 327q0mhxwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 16:09:07 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DG961G011456;
	Mon, 13 Jul 2020 16:09:06 GMT
Received: from paddy.uk.oracle.com (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 09:09:05 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2 08/10] libdaxctl: add daxctl_region_destroy_dev()
Date: Mon, 13 Jul 2020 17:08:35 +0100
Message-Id: <20200713160837.13774-9-joao.m.martins@oracle.com>
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
Message-ID-Hash: WSXGPV32FRHKHHONGPLVOMPVKMJFARTP
X-Message-ID-Hash: WSXGPV32FRHKHHONGPLVOMPVKMJFARTP
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WSXGPV32FRHKHHONGPLVOMPVKMJFARTP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an API to destroy an empty device.

This 'delete' sysfs attribute is only writeable for a dynamic
dax device such as the one exported by hmem.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 daxctl/lib/libdaxctl.c   | 17 +++++++++++++++++
 daxctl/lib/libdaxctl.sym |  1 +
 daxctl/libdaxctl.h       |  1 +
 3 files changed, 19 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index d17ff7a02bad..9b43b68facfe 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -609,6 +609,23 @@ DAXCTL_EXPORT int daxctl_region_create_dev(struct daxctl_region *region)
 	return 0;
 }
 
+DAXCTL_EXPORT int daxctl_region_destroy_dev(struct daxctl_region *region,
+					    struct daxctl_dev *dev)
+{
+	struct daxctl_ctx *ctx = daxctl_region_get_ctx(region);
+	char *path = region->region_buf;
+	int rc, len = region->buf_len;
+
+	if (snprintf(path, len, "%s/%s/delete", region->region_path, attrs) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_region_get_devname(region));
+		return -EFAULT;
+	}
+
+	rc = sysfs_write_attr(ctx, path, daxctl_dev_get_devname(dev));
+	return rc;
+}
+
 DAXCTL_EXPORT struct daxctl_dev *daxctl_region_get_dev_seed(
 		struct daxctl_region *region)
 {
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 26987ba021ab..33c926411037 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -80,4 +80,5 @@ LIBDAXCTL_8 {
 global:
 	daxctl_dev_set_size;
 	daxctl_region_create_dev;
+	daxctl_region_destroy_dev;
 } LIBDAXCTL_7;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index a579ddd1d43c..2b14faad1895 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -61,6 +61,7 @@ struct daxctl_dev *daxctl_region_get_dev_seed(struct daxctl_region *region);
 
 struct daxctl_dev;
 struct daxctl_dev *daxctl_dev_get_first(struct daxctl_region *region);
+int daxctl_region_destroy_dev(struct daxctl_region *region, struct daxctl_dev *dev);
 struct daxctl_dev *daxctl_dev_get_next(struct daxctl_dev *dev);
 struct daxctl_region *daxctl_dev_get_region(struct daxctl_dev *dev);
 int daxctl_dev_get_id(struct daxctl_dev *dev);
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

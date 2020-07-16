Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D9D222B33
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 20:47:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8442011571BE9;
	Thu, 16 Jul 2020 11:47:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1D04B11078320
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 11:47:40 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIb28v145415;
	Thu, 16 Jul 2020 18:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=GHorhZpluozLUMVAc2bOZLOZIfO5aEfQ1y342YF9NEE=;
 b=jaRTKL52zzj7wXFKTOGkElyWhuSe8fB+ovrEDmB6734rK+UWAN4fJPkKs/9TgUL0s+kR
 C+LKF/UcZxzJNC3O6pcEYdYon3lPDROmn//9xY0bVgh2YbzxNd1ocuEPHr/E37SChlv9
 WYne4fq5kVaisDhjuQvlY2CNod2CxQuW2A5Q1VHFLQcpDNF4uiSkG6VvSUOFA8bLzKst
 CG/lvKTjeWs0AwyzI4kaMyL60shpsiUAUwAPNabUPVVlin2SCj32XUlhTQuildDhTXJT
 IoEG0lKLx/QfGP2Ws993igrW+3CQhgcQhCz7rj6BJbo47bOHbsE2/WftWvDkhfg3Z0Hk 4A==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 3275cmk6jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 18:47:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIbh09163631;
	Thu, 16 Jul 2020 18:47:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 327qbc77w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 18:47:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GIlaTi011674;
	Thu, 16 Jul 2020 18:47:36 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 11:47:36 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 1/8] daxctl: add daxctl_dev_{get,set}_align()
Date: Thu, 16 Jul 2020 19:47:00 +0100
Message-Id: <20200716184707.23018-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716184707.23018-1-joao.m.martins@oracle.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
Message-ID-Hash: 43ND2MGT7N37HM4ZIHC5QRQY4IEBXMAW
X-Message-ID-Hash: 43ND2MGT7N37HM4ZIHC5QRQY4IEBXMAW
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/43ND2MGT7N37HM4ZIHC5QRQY4IEBXMAW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for changing devices alignment.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 daxctl/lib/libdaxctl-private.h |  1 +
 daxctl/lib/libdaxctl.c         | 34 ++++++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym       |  2 ++
 daxctl/libdaxctl.h             |  2 ++
 4 files changed, 39 insertions(+)

diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index 9f9c70d6024f..b307a8bc9438 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -99,6 +99,7 @@ struct daxctl_dev {
 	struct list_node list;
 	unsigned long long resource;
 	unsigned long long size;
+	unsigned long align;
 	struct kmod_module *module;
 	struct daxctl_region *region;
 	struct daxctl_memory *mem;
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 9b43b68facfe..c62e04bcdfd1 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -498,6 +498,11 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 		goto err_read;
 	dev->size = strtoull(buf, NULL, 0);
 
+	sprintf(path, "%s/align", daxdev_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto err_read;
+	dev->align = strtoull(buf, NULL, 0);
+
 	dev->dev_path = strdup(daxdev_base);
 	if (!dev->dev_path)
 		goto err_read;
@@ -1086,6 +1091,35 @@ DAXCTL_EXPORT int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long
 	return 0;
 }
 
+DAXCTL_EXPORT unsigned long daxctl_dev_get_align(struct daxctl_dev *dev)
+{
+	return dev->align;
+}
+
+DAXCTL_EXPORT int daxctl_dev_set_align(struct daxctl_dev *dev, unsigned long align)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char buf[SYSFS_ATTR_SIZE];
+	char *path = dev->dev_buf;
+	int len = dev->buf_len;
+
+	if (snprintf(path, len, "%s/align", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+
+	sprintf(buf, "%#lx\n", align);
+	if (sysfs_write_attr(ctx, path, buf) < 0) {
+		err(ctx, "%s: failed to set align\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+
+	dev->align = align;
+	return 0;
+}
+
 DAXCTL_EXPORT int daxctl_dev_get_target_node(struct daxctl_dev *dev)
 {
 	return dev->target_node;
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 33c926411037..c3d08179c9fd 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -81,4 +81,6 @@ global:
 	daxctl_dev_set_size;
 	daxctl_region_create_dev;
 	daxctl_region_destroy_dev;
+	daxctl_dev_get_align;
+	daxctl_dev_set_align;
 } LIBDAXCTL_7;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 2b14faad1895..b0bb5d78d357 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -71,6 +71,8 @@ int daxctl_dev_get_minor(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_resource(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev);
 int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long size);
+unsigned long daxctl_dev_get_align(struct daxctl_dev *dev);
+int daxctl_dev_set_align(struct daxctl_dev *dev, unsigned long align);
 struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev);
 int daxctl_dev_is_enabled(struct daxctl_dev *dev);
 int daxctl_dev_disable(struct daxctl_dev *dev);
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

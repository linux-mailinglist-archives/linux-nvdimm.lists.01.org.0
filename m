Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 190F02DC93B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 23:50:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6986F100EBB76;
	Wed, 16 Dec 2020 14:50:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 318BF100EBB6A
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 14:50:48 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMo3Ms082290;
	Wed, 16 Dec 2020 22:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=zd4DWanfqlYel8d5/JrZV9dgcdZyRI4GapvwGpL5KBc=;
 b=UVoClXfSoOy8OrTx4V0aK183L2ZYef6T9HQPVeFbr8518BLiplw8Su6ZEadfgIHrH1XK
 zI4N28tpkCQQioimLKuY6pKlcEK2zWVRSToLUuRmcgnZCM7WCu/q4Klcw+guv8/twLBd
 BbCStwefw1nwHNpKHvVwGMDytWVwB1qhdJDQA7ITNQrdbKefduHB1U9+jJgclbIA2yi/
 ojLj94GGCqIm0+c/xLEVrSi0npzP//Y3njT8FDaoGwgpsapL3yA/oYMnwtByngXrK+ps
 Eaccl+aMS+6cqAIIKh/fCUGd783aar6hOuLcDcF3FhwKH5EnGj1uHsX7VA0db6d+u7Cb Fg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 35cntmas26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 22:50:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMjAGm125005;
	Wed, 16 Dec 2020 22:48:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 35e6eshtnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 22:48:46 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BGMmjj4001200;
	Wed, 16 Dec 2020 22:48:45 GMT
Received: from paddy.uk.oracle.com (/10.175.172.71)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 14:48:45 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 1/5] daxctl: add daxctl_dev_{get,set}_align()
Date: Wed, 16 Dec 2020 22:48:29 +0000
Message-Id: <20201216224833.6229-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201216224833.6229-1-joao.m.martins@oracle.com>
References: <20201216224833.6229-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160142
Message-ID-Hash: AY7J2PW22VUALZ5CSKOPITHN42ZRMN7D
X-Message-ID-Hash: AY7J2PW22VUALZ5CSKOPITHN42ZRMN7D
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AY7J2PW22VUALZ5CSKOPITHN42ZRMN7D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for changing devices alignment.

On kernels that do not support per-device align sysfs property
we set it to 0.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 daxctl/lib/libdaxctl-private.h |  1 +
 daxctl/lib/libdaxctl.c         | 36 ++++++++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym       |  2 ++
 daxctl/libdaxctl.h             |  2 ++
 4 files changed, 41 insertions(+)

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
index 9b43b68facfe..39871427c799 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -498,6 +498,13 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 		goto err_read;
 	dev->size = strtoull(buf, NULL, 0);
 
+	/* Device align attribute is only available in v5.10 or up */
+	sprintf(path, "%s/align", daxdev_base);
+	if (!sysfs_read_attr(ctx, path, buf))
+		dev->align = strtoull(buf, NULL, 0);
+	else
+		dev->align = 0;
+
 	dev->dev_path = strdup(daxdev_base);
 	if (!dev->dev_path)
 		goto err_read;
@@ -1086,6 +1093,35 @@ DAXCTL_EXPORT int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long
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

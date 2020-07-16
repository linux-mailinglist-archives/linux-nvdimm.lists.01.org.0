Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24928222B40
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 20:49:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7216A11571BEB;
	Thu, 16 Jul 2020 11:49:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 13DC611571BE9
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 11:49:45 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIcGTo059705;
	Thu, 16 Jul 2020 18:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=UK336btG/X7IpIfPfmuRoEp+2U5ISMmotevSo3n2BzQ=;
 b=DjpCF+U4boUR60iXlZfqG3jETSuf4TghocF8Jef2I25dFgMSGg29/rlgtT5ciE3sF2LS
 whBUzNhfg9e0hU7J37okp04TkPLlA2ipZOZxzXJr4sE7nf+1Q3+vXUG7SpVxnvZpMx2E
 oSogiiZB+Vbml0wEWcNFP1pK9t/WyN99pChPnuAEYUqlLEVwoe1Tb3Z10WTuqjJaFCvO
 uJJVgWnve2r3Qo0iGyOHYCCpJfWvINubWgkZNPCmW1RObKvom6RXTJQDe+9ZXJcXuFqQ
 93rfkpaAXhehm0J5XFIGB3bmL5x2M04HCXKwENINnW/88T5lGwxuTQJWVUqF+PmtX4BK 4A==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 3274urk8yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 18:49:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIbjfF095910;
	Thu, 16 Jul 2020 18:47:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 327q0u0bqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 18:47:42 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GIlgaV000520;
	Thu, 16 Jul 2020 18:47:42 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 11:47:41 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 5/8] libdaxctl: add mapping iterator APIs
Date: Thu, 16 Jul 2020 19:47:04 +0100
Message-Id: <20200716184707.23018-6-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716184707.23018-1-joao.m.martins@oracle.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=3 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
Message-ID-Hash: POW3S6VOEDGKTT3EAWJIKEECK7NAXN7W
X-Message-ID-Hash: POW3S6VOEDGKTT3EAWJIKEECK7NAXN7W
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/POW3S6VOEDGKTT3EAWJIKEECK7NAXN7W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the following APIs to be able to iterate over a
dynamic device-dax mapping list, as well as fetching
each of the mapping attributes.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 daxctl/lib/libdaxctl-private.h |  8 ++++
 daxctl/lib/libdaxctl.c         | 91 +++++++++++++++++++++++++++++++++++++++++-
 daxctl/lib/libdaxctl.sym       |  6 +++
 daxctl/libdaxctl.h             | 12 ++++++
 4 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index b307a8bc9438..6d05aefbeda0 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -91,6 +91,12 @@ struct daxctl_region {
 	struct list_head devices;
 };
 
+struct daxctl_mapping {
+	struct daxctl_dev *dev;
+	unsigned long long pgoff, start, end;
+	struct list_node list;
+};
+
 struct daxctl_dev {
 	int id, major, minor;
 	void *dev_buf;
@@ -104,6 +110,8 @@ struct daxctl_dev {
 	struct daxctl_region *region;
 	struct daxctl_memory *mem;
 	int target_node;
+	int num_mappings;
+	struct list_head mappings;
 };
 
 struct daxctl_memory {
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index c62e04bcdfd1..506cf4b93236 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -524,7 +524,8 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 			free(path);
 			return dev_dup;
 		}
-
+	dev->num_mappings = -1;
+	list_head_init(&dev->mappings);
 	list_add(&region->devices, &dev->list);
 	free(path);
 	return dev;
@@ -1148,6 +1149,94 @@ DAXCTL_EXPORT unsigned long daxctl_memory_get_block_size(struct daxctl_memory *m
 	return mem->block_size;
 }
 
+static void mappings_init(struct daxctl_dev *dev)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char buf[SYSFS_ATTR_SIZE];
+	char *path = dev->dev_buf;
+	int i;
+
+	if (dev->num_mappings != -1)
+		return;
+
+	dev->num_mappings = 0;
+	for (;;) {
+		struct daxctl_mapping *mapping;
+		unsigned long long pgoff, start, end;
+
+		i = dev->num_mappings;
+		mapping = calloc(1, sizeof(*mapping));
+		if (!mapping) {
+			err(ctx, "%s: mapping%u allocation failure\n",
+				daxctl_dev_get_devname(dev), i);
+			continue;
+		}
+
+		sprintf(path, "%s/mapping%d/start", dev->dev_path, i);
+		if (sysfs_read_attr(ctx, path, buf) < 0) {
+			free(mapping);
+			break;
+		}
+		start = strtoull(buf, NULL, 0);
+
+		sprintf(path, "%s/mapping%d/end", dev->dev_path, i);
+		if (sysfs_read_attr(ctx, path, buf) < 0) {
+			free(mapping);
+			break;
+		}
+		end = strtoull(buf, NULL, 0);
+
+		sprintf(path, "%s/mapping%d/page_offset", dev->dev_path, i);
+		if (sysfs_read_attr(ctx, path, buf) < 0) {
+			free(mapping);
+			break;
+		}
+		pgoff = strtoull(buf, NULL, 0);
+
+		mapping->dev = dev;
+		mapping->start = start;
+		mapping->end = end;
+		mapping->pgoff = pgoff;
+
+		dev->num_mappings++;
+		list_add(&dev->mappings, &mapping->list);
+	}
+}
+
+DAXCTL_EXPORT struct daxctl_mapping *daxctl_mapping_get_first(struct daxctl_dev *dev)
+{
+	mappings_init(dev);
+
+	return list_top(&dev->mappings, struct daxctl_mapping, list);
+}
+
+DAXCTL_EXPORT struct daxctl_mapping *daxctl_mapping_get_next(struct daxctl_mapping *mapping)
+{
+	struct daxctl_dev *dev = mapping->dev;
+
+	return list_next(&dev->mappings, mapping, list);
+}
+
+DAXCTL_EXPORT unsigned long long daxctl_mapping_get_start(struct daxctl_mapping *mapping)
+{
+	return mapping->start;
+}
+
+DAXCTL_EXPORT unsigned long long daxctl_mapping_get_end(struct daxctl_mapping *mapping)
+{
+	return mapping->end;
+}
+
+DAXCTL_EXPORT unsigned long long  daxctl_mapping_get_offset(struct daxctl_mapping *mapping)
+{
+	return mapping->pgoff;
+}
+
+DAXCTL_EXPORT unsigned long long daxctl_mapping_get_size(struct daxctl_mapping *mapping)
+{
+	return mapping->end - mapping->start + 1;
+}
+
 static int memblock_is_online(struct daxctl_memory *mem, char *memblock)
 {
 	struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index c3d08179c9fd..08362b683678 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -83,4 +83,10 @@ global:
 	daxctl_region_destroy_dev;
 	daxctl_dev_get_align;
 	daxctl_dev_set_align;
+	daxctl_mapping_get_first;
+	daxctl_mapping_get_next;
+	daxctl_mapping_get_start;
+	daxctl_mapping_get_end;
+	daxctl_mapping_get_offset;
+	daxctl_mapping_get_size;
 } LIBDAXCTL_7;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index b0bb5d78d357..f94a72fed85b 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -103,6 +103,18 @@ int daxctl_memory_online_no_movable(struct daxctl_memory *mem);
              region != NULL; \
              region = daxctl_region_get_next(region))
 
+struct daxctl_mapping;
+struct daxctl_mapping *daxctl_mapping_get_first(struct daxctl_dev *dev);
+struct daxctl_mapping *daxctl_mapping_get_next(struct daxctl_mapping *mapping);
+#define daxctl_mapping_foreach(dev, mapping) \
+        for (mapping = daxctl_mapping_get_first(dev); \
+             mapping != NULL; \
+             mapping = daxctl_mapping_get_next(mapping))
+unsigned long long daxctl_mapping_get_start(struct daxctl_mapping *mapping);
+unsigned long long daxctl_mapping_get_end(struct daxctl_mapping *mapping);
+unsigned long long  daxctl_mapping_get_offset(struct daxctl_mapping *mapping);
+unsigned long long daxctl_mapping_get_size(struct daxctl_mapping *mapping);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

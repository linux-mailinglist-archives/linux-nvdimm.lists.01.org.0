Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5990C2DDCD0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 03:15:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BF3E3100EB321;
	Thu, 17 Dec 2020 18:15:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 409E3100EB855
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 18:14:58 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI2DoW7069588;
	Fri, 18 Dec 2020 02:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=6MBEvjCkL2aXmE5D8EqV1A4XQpQVwnU2JNtG0eD/Qg4=;
 b=DTrayLGzmWtMpj1yFXNQOUj/Vd9kCY+D9VyMeiOhWSn9FAdHRE80IhYaGkVIOq8Yhqal
 3C94m40C3+rER7Dhg+26Krioo0Jd4K85gcxDii1QJiovMgUvDMWq3PcVEJtcxGNG1nlq
 RDbVLXe8MbMHwJcHZpHI793KTq3jWl4+AEn8Dtd8uvy4iPF7g2aocVSFh9feSFcvI46B
 X6ivqA8IR2FrOJ2wU4G4q68Bv6RpJ02qIRqNHfO+FiWz4L04NDxzHbMSEl6RDMyD5ZYd
 OUdCZj2KXA4eLJhyUtG1rY/fXwzhYqJQTmA4+qcCLqmx4kYx5o5zO5yQBonE/hiVSeK5 vA==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 35ckcbrfx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Dec 2020 02:14:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI25Ipf077684;
	Fri, 18 Dec 2020 02:14:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 35g3rfgvc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Dec 2020 02:14:55 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BI2Es81014216;
	Fri, 18 Dec 2020 02:14:54 GMT
Received: from paddy.uk.oracle.com (/10.175.180.204)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Dec 2020 18:14:54 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 1/5] libdaxctl: add mapping iterator APIs
Date: Fri, 18 Dec 2020 02:14:34 +0000
Message-Id: <20201218021438.8926-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218021438.8926-1-joao.m.martins@oracle.com>
References: <20201218021438.8926-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180013
Message-ID-Hash: 7G6BRAOOIGOAJRV5MZEAILV7QW6DA3DG
X-Message-ID-Hash: 7G6BRAOOIGOAJRV5MZEAILV7QW6DA3DG
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7G6BRAOOIGOAJRV5MZEAILV7QW6DA3DG/>
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
index 39871427c799..3781e9ed27d5 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -526,7 +526,8 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
 			free(path);
 			return dev_dup;
 		}
-
+	dev->num_mappings = -1;
+	list_head_init(&dev->mappings);
 	list_add(&region->devices, &dev->list);
 	free(path);
 	return dev;
@@ -1150,6 +1151,94 @@ DAXCTL_EXPORT unsigned long daxctl_memory_get_block_size(struct daxctl_memory *m
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

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728992229F9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 19:31:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B73B211C74C4A;
	Thu, 16 Jul 2020 10:31:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E235111C74C44
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 10:31:45 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GHN4xR193981;
	Thu, 16 Jul 2020 17:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=hdbqw5KJtL/8FiSm6BteZ+byamhVX4rllUDAAyl7GXY=;
 b=mwZGVAV43myYzRaa93s4sqs3X624SbR5zXj2cAPgd55SX4wDznVwRkxaztOpoQE3Xvhq
 kk3zW2vI+y4bU8waOT8R5aT99JSAfYnb+B1Zs4Q8c0H3818munADNTbTOrYx3/Q3rFVT
 1j02u2RpHj4aKsRoKxH1bQ1YS2Jl1Dlbykr1gPb4fpBH1iOskboXGxXAVBkKlHMjIxpM
 eqWVf91O9fe3R7CU1bjl2rPQ26xaSH2It71ipnCtV0gEiPv8MG2uSar1OTh8b2dvOWgK
 QLe60xAB7xSa8oX0vr4JY9F6kugZsi8CWiU7Nh0MWk2THUJi5mHS9LiNWKg3gJ/g9Rsy JA==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 3275cmjtf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 17:31:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GHHiTJ005707;
	Thu, 16 Jul 2020 17:29:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 327q0tvk41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 17:29:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GHTd3t019092;
	Thu, 16 Jul 2020 17:29:39 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 10:29:39 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 2/4] device-dax: Add an 'align' attribute
Date: Thu, 16 Jul 2020 18:29:11 +0100
Message-Id: <20200716172913.19658-3-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716172913.19658-1-joao.m.martins@oracle.com>
References: <20200716172913.19658-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160126
Message-ID-Hash: FOOYL3VPXNDZDXRYW23QV6B6UJI7T6HJ
X-Message-ID-Hash: FOOYL3VPXNDZDXRYW23QV6B6UJI7T6HJ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FOOYL3VPXNDZDXRYW23QV6B6UJI7T6HJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce a device align attribute. While doing so,
rename the region align attribute to be more explicitly
named as so, but keep it named as @align to retain the API
for tools like daxctl.

Changes on align may not always be valid, when say certain
mappings were created with 2M and then we switch to 1G. So, we
validate all ranges against the new value being attempted,
post resizing.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/dax/bus.c | 101 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 2578651c596e..eb384dd6a376 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -230,14 +230,15 @@ static ssize_t region_size_show(struct device *dev,
 static struct device_attribute dev_attr_region_size = __ATTR(size, 0444,
 		region_size_show, NULL);
 
-static ssize_t align_show(struct device *dev,
+static ssize_t region_align_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct dax_region *dax_region = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%u\n", dax_region->align);
 }
-static DEVICE_ATTR_RO(align);
+static struct device_attribute dev_attr_region_align =
+		__ATTR(align, 0400, region_align_show, NULL);
 
 #define for_each_dax_region_resource(dax_region, res) \
 	for (res = (dax_region)->res.child; res; res = res->sibling)
@@ -488,7 +489,7 @@ static umode_t dax_region_visible(struct kobject *kobj, struct attribute *a,
 static struct attribute *dax_region_attributes[] = {
 	&dev_attr_available_size.attr,
 	&dev_attr_region_size.attr,
-	&dev_attr_align.attr,
+	&dev_attr_region_align.attr,
 	&dev_attr_create.attr,
 	&dev_attr_seed.attr,
 	&dev_attr_delete.attr,
@@ -855,14 +856,13 @@ static ssize_t size_show(struct device *dev,
 	return sprintf(buf, "%llu\n", size);
 }
 
-static bool alloc_is_aligned(struct dax_region *dax_region,
-		resource_size_t size)
+static bool alloc_is_aligned(resource_size_t size, unsigned long align)
 {
 	/*
 	 * The minimum mapping granularity for a device instance is a
 	 * single subsection, unless the arch says otherwise.
 	 */
-	return IS_ALIGNED(size, max_t(unsigned long, dax_region->align,
+	return IS_ALIGNED(size, max_t(unsigned long, align,
 				memremap_compat_align()));
 }
 
@@ -958,7 +958,7 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		return dev_dax_shrink(dev_dax, size);
 
 	to_alloc = size - dev_size;
-	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dax_region, to_alloc),
+	if (dev_WARN_ONCE(dev, !alloc_is_aligned(to_alloc, dev_dax->align),
 			"resize of %pa misaligned\n", &to_alloc))
 		return -ENXIO;
 
@@ -1022,7 +1022,7 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		return rc;
 
-	if (!alloc_is_aligned(dax_region, val)) {
+	if (!alloc_is_aligned(val, dev_dax->align)) {
 		dev_dbg(dev, "%s: size: %lld misaligned\n", __func__, val);
 		return -EINVAL;
 	}
@@ -1041,6 +1041,87 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(size);
 
+static ssize_t align_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sprintf(buf, "%d\n", dev_dax->align);
+}
+
+static ssize_t dev_dax_set_align(struct dev_dax *dev_dax,
+				 unsigned long long align)
+{
+	resource_size_t dev_size = dev_dax_size(dev_dax);
+	struct device *dev = &dev_dax->dev;
+	ssize_t rc, i;
+
+	if (dev->driver)
+		return -EBUSY;
+
+	rc = -EINVAL;
+	if (dev_size > 0 && !alloc_is_aligned(dev_size, align)) {
+		dev_dbg(dev, "%s: align %llx invalid for size %llu\n",
+			__func__, align, dev_size);
+		return rc;
+	}
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		size_t len = range_len(&dev_dax->ranges[i].range);
+
+		if (!alloc_is_aligned(len, align)) {
+			dev_dbg(dev, "%s: align %llx invalid for range %ld\n",
+				__func__, align, i);
+			return rc;
+		}
+	}
+
+	switch (align) {
+	case PUD_SIZE:
+		if (!IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
+			break;
+		fallthrough;
+	case PMD_SIZE:
+		if (!has_transparent_hugepage())
+			break;
+		fallthrough;
+	case PAGE_SIZE:
+		rc = 0;
+		break;
+	}
+
+	if (!rc)
+		dev_dax->align = align;
+
+	return rc;
+}
+
+static ssize_t align_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
+	unsigned long long val;
+	ssize_t rc;
+
+	rc = kstrtoull(buf, 0, &val);
+	if (rc)
+		return -ENXIO;
+
+	device_lock(dax_region->dev);
+	if (!dax_region->dev->driver) {
+		device_unlock(dax_region->dev);
+		return -ENXIO;
+	}
+
+	device_lock(dev);
+	rc = dev_dax_set_align(dev_dax, val);
+	device_unlock(dev);
+	device_unlock(dax_region->dev);
+	return rc == 0 ? len : rc;
+}
+static DEVICE_ATTR_RW(align);
+
 static int dev_dax_target_node(struct dev_dax *dev_dax)
 {
 	struct dax_region *dax_region = dev_dax->region;
@@ -1101,7 +1182,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 		return 0;
 	if (a == &dev_attr_numa_node.attr && !IS_ENABLED(CONFIG_NUMA))
 		return 0;
-	if (a == &dev_attr_size.attr && is_static(dax_region))
+	if ((a == &dev_attr_align.attr ||
+	     a == &dev_attr_size.attr) && is_static(dax_region))
 		return 0444;
 	return a->mode;
 }
@@ -1110,6 +1192,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_size.attr,
 	&dev_attr_target_node.attr,
+	&dev_attr_align.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
 	NULL,
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1012E298D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Dec 2020 04:31:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B69D0100EBBB9;
	Thu, 24 Dec 2020 19:31:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=tiantao6@hisilicon.com; receiver=<UNKNOWN> 
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EDAB2100EBBB3
	for <linux-nvdimm@lists.01.org>; Thu, 24 Dec 2020 19:31:10 -0800 (PST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D2CB91ts5zM979
	for <linux-nvdimm@lists.01.org>; Fri, 25 Dec 2020 11:30:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Fri, 25 Dec 2020 11:31:01 +0800
From: Tian Tao <tiantao6@hisilicon.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>
Subject: [PATCH] nvdimm: Switch to using the new API kobj_to_dev()
Date: Fri, 25 Dec 2020 11:31:05 +0800
Message-ID: <1608867065-52320-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Message-ID-Hash: DT6UJF5XNGUG3PXOHQ7I72OICMZF5BYQ
X-Message-ID-Hash: DT6UJF5XNGUG3PXOHQ7I72OICMZF5BYQ
X-MailFrom: tiantao6@hisilicon.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DT6UJF5XNGUG3PXOHQ7I72OICMZF5BYQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

fixed the following coccicheck:
drivers/nvdimm//namespace_devs.c:1626:60-61: WARNING opportunity for
kobj_to_dev().
drivers/nvdimm//region_devs.c:762:60-61: WARNING opportunity for
kobj_to_dev().

since container_of(kobj, typeof(*dev), kobj) and
container_of(kobj, struct device, kobj) are the same, so also
replace container_of(kobj, typeof(*dev), kobj) with the new kobj_to_dev.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/nvdimm/bus.c            | 2 +-
 drivers/nvdimm/core.c           | 2 +-
 drivers/nvdimm/dimm_devs.c      | 4 ++--
 drivers/nvdimm/namespace_devs.c | 2 +-
 drivers/nvdimm/region_devs.c    | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 2304c61..cf2b70b 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -713,7 +713,7 @@ static struct attribute *nd_numa_attributes[] = {
 static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
 		int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 
 	if (!IS_ENABLED(CONFIG_NUMA))
 		return 0;
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 7de592d..431e47a 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -503,7 +503,7 @@ static DEVICE_ATTR_ADMIN_RW(activate);
 
 static umode_t nvdimm_bus_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 	enum nvdimm_fwa_capability cap;
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index b59032e..76ee2c3 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -418,7 +418,7 @@ static struct attribute *nvdimm_attributes[] = {
 
 static umode_t nvdimm_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
 	if (a != &dev_attr_security.attr && a != &dev_attr_frozen.attr)
@@ -534,7 +534,7 @@ static struct attribute *nvdimm_firmware_attributes[] = {
 
 static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 	struct nvdimm *nvdimm = to_nvdimm(dev);
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 6da67f4..1d11ca7 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1623,7 +1623,7 @@ static struct attribute *nd_namespace_attributes[] = {
 static umode_t namespace_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 
 	if (a == &dev_attr_resource.attr && is_namespace_blk(dev))
 		return 0;
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119..92adfaf 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -644,7 +644,7 @@ static struct attribute *nd_region_attributes[] = {
 
 static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nd_region *nd_region = to_nd_region(dev);
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
 	int type = nd_region_to_nstype(nd_region);
@@ -759,7 +759,7 @@ REGION_MAPPING(31);
 
 static umode_t mapping_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nd_region *nd_region = to_nd_region(dev);
 
 	if (n < nd_region->ndr_mappings)
-- 
2.7.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

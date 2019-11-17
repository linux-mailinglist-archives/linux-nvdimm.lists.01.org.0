Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E9EFFB2C
	for <lists+linux-nvdimm@lfdr.de>; Sun, 17 Nov 2019 18:59:53 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C62D100DC3E1;
	Sun, 17 Nov 2019 10:00:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 12797100DC425
	for <linux-nvdimm@lists.01.org>; Sun, 17 Nov 2019 10:00:56 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:50 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400";
   d="scan'208";a="405855083"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:50 -0800
Subject: [PATCH v2 11/18] libnvdimm: Simplify root read-only definition for
 the 'resource' attribute
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 17 Nov 2019 09:45:33 -0800
Message-ID: <157401273394.43284.12148079363063773132.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: VTDPFGUMHTYV5LMQJ2QI7Q2QEWGEFBKB
X-Message-ID-Hash: VTDPFGUMHTYV5LMQJ2QI7Q2QEWGEFBKB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VTDPFGUMHTYV5LMQJ2QI7Q2QEWGEFBKB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Rather than update the permission in ->is_visible() set the permission
directly at declaration time.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309905534.1582359.13927459228885931097.stgit@dwillia2-desk3.amr.corp.intel.com
---
 drivers/nvdimm/namespace_devs.c |    9 +++------
 drivers/nvdimm/pfn_devs.c       |   10 +---------
 drivers/nvdimm/region_devs.c    |   10 +++-------
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 05d99a8b3175..032dc61725ff 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1303,7 +1303,7 @@ static ssize_t resource_show(struct device *dev,
 		return -ENXIO;
 	return sprintf(buf, "%#llx\n", (unsigned long long) res->start);
 }
-static DEVICE_ATTR_RO(resource);
+static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
 static const unsigned long blk_lbasize_supported[] = { 512, 520, 528,
 	4096, 4104, 4160, 4224, 0 };
@@ -1619,11 +1619,8 @@ static umode_t namespace_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 
-	if (a == &dev_attr_resource.attr) {
-		if (is_namespace_blk(dev))
-			return 0;
-		return 0400;
-	}
+	if (a == &dev_attr_resource.attr && is_namespace_blk(dev))
+		return 0;
 
 	if (is_namespace_pmem(dev) || is_namespace_blk(dev)) {
 		if (a == &dev_attr_size.attr)
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 17ceac5b5313..b94f7a7e94b8 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -218,7 +218,7 @@ static ssize_t resource_show(struct device *dev,
 
 	return rc;
 }
-static DEVICE_ATTR_RO(resource);
+static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
 static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -269,16 +269,8 @@ static struct attribute *nd_pfn_attributes[] = {
 	NULL,
 };
 
-static umode_t pfn_visible(struct kobject *kobj, struct attribute *a, int n)
-{
-	if (a == &dev_attr_resource.attr)
-		return 0400;
-	return a->mode;
-}
-
 static struct attribute_group nd_pfn_attribute_group = {
 	.attrs = nd_pfn_attributes,
-	.is_visible = pfn_visible,
 };
 
 const struct attribute_group *nd_pfn_attribute_groups[] = {
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0afc1973e938..be3e429e86af 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -553,7 +553,7 @@ static ssize_t resource_show(struct device *dev,
 
 	return sprintf(buf, "%#llx\n", nd_region->ndr_start);
 }
-static DEVICE_ATTR_RO(resource);
+static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
 static ssize_t persistence_domain_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -605,12 +605,8 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 	if (!is_memory(dev) && a == &dev_attr_badblocks.attr)
 		return 0;
 
-	if (a == &dev_attr_resource.attr) {
-		if (is_memory(dev))
-			return 0400;
-		else
-			return 0;
-	}
+	if (a == &dev_attr_resource.attr && !is_memory(dev))
+		return 0;
 
 	if (a == &dev_attr_deep_flush.attr) {
 		int has_flush = nvdimm_has_flush(nd_region);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

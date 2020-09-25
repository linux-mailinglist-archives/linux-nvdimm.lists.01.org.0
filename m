Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 055C0279182
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 21:31:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A9F0015508B27;
	Fri, 25 Sep 2020 12:31:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7BE8415508B21
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 12:31:36 -0700 (PDT)
IronPort-SDR: FvZ2yehQt0CfDxeBUA3XuThzmgf5hHinAkeQ2+eT+RrbGSj8Msk7kRwO/4U+OiyqN8MHSY/OZ1
 wBc3I9BqOAcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="149272236"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="149272236"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:31:36 -0700
IronPort-SDR: VMbc7ZmBQB/F8HKZReuENs4o+rZepmL6hLQ53EkUQItqX8nx6NIeOUZnodDC+yf9ejTO0Iw0Rz
 xkvwopeQ9iCQ==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="349880741"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:31:36 -0700
Subject: [PATCH v5 17/17] device-dax: add a range mapping allocation
 attribute
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Fri, 25 Sep 2020 12:13:15 -0700
Message-ID: <160106119570.30709.4548889722645210610.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: BA3276KPPE3LYHGNTJWHLAZIXMIVAEGG
X-Message-ID-Hash: BA3276KPPE3LYHGNTJWHLAZIXMIVAEGG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, dave.hansen@linux.intel.com, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BA3276KPPE3LYHGNTJWHLAZIXMIVAEGG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Joao Martins <joao.m.martins@oracle.com>

Add a sysfs attribute which denotes a range from the dax region to be
allocated.  It's an write only @mapping sysfs attribute in the format of
'<start>-<end>' to allocate a range.  @start and @end use hexadecimal
values and the @pgoff is implicitly ordered wrt to previous writes to
@mapping sysfs e.g.  a write of a range of length 1G the pgoff is
0..1G(-4K), a second write will use @pgoff for 1G+4K..<size>.

This range mapping interface is useful for:

 1) Application which want to implement its own allocation logic,
 and thus pick the desired ranges from dax_region.

 2) For use cases like VMM fast restart[0] where after kexec we
 want to the same gpa<->phys mappings (as originally created
 before kexec).

[0] https://static.sched.com/hosted_files/kvmforum2019/66/VMM-fast-restart_kvmforum2019.pdf

Link: https://lkml.kernel.org/r/159643106970.4062302.10402616567780784722.stgit@dwillia2-desk3.amr.corp.intel.com
Link: https://lore.kernel.org/r/20200716172913.19658-5-joao.m.martins@oracle.com
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 0ac4a9c0fd18..27513d311242 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1043,6 +1043,67 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(size);
 
+static ssize_t range_parse(const char *opt, size_t len, struct range *range)
+{
+	unsigned long long addr = 0;
+	char *start, *end, *str;
+	ssize_t rc = EINVAL;
+
+	str = kstrdup(opt, GFP_KERNEL);
+	if (!str)
+		return rc;
+
+	end = str;
+	start = strsep(&end, "-");
+	if (!start || !end)
+		goto err;
+
+	rc = kstrtoull(start, 16, &addr);
+	if (rc)
+		goto err;
+	range->start = addr;
+
+	rc = kstrtoull(end, 16, &addr);
+	if (rc)
+		goto err;
+	range->end = addr;
+
+err:
+	kfree(str);
+	return rc;
+}
+
+static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
+	size_t to_alloc;
+	struct range r;
+	ssize_t rc;
+
+	rc = range_parse(buf, len, &r);
+	if (rc)
+		return rc;
+
+	rc = -ENXIO;
+	device_lock(dax_region->dev);
+	if (!dax_region->dev->driver) {
+		device_unlock(dax_region->dev);
+		return rc;
+	}
+	device_lock(dev);
+
+	to_alloc = range_len(&r);
+	if (alloc_is_aligned(dev_dax, to_alloc))
+		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
+	device_unlock(dev);
+	device_unlock(dax_region->dev);
+
+	return rc == 0 ? len : rc;
+}
+static DEVICE_ATTR_WO(mapping);
+
 static ssize_t align_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1175,6 +1236,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 		return 0;
 	if (a == &dev_attr_numa_node.attr && !IS_ENABLED(CONFIG_NUMA))
 		return 0;
+	if (a == &dev_attr_mapping.attr && is_static(dax_region))
+		return 0;
 	if ((a == &dev_attr_align.attr ||
 	     a == &dev_attr_size.attr) && is_static(dax_region))
 		return 0444;
@@ -1184,6 +1247,7 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_size.attr,
+	&dev_attr_mapping.attr,
 	&dev_attr_target_node.attr,
 	&dev_attr_align.attr,
 	&dev_attr_resource.attr,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 736612846D8
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Oct 2020 09:13:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25E481557A1B0;
	Tue,  6 Oct 2020 00:13:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 903271557A1AE
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 00:13:26 -0700 (PDT)
IronPort-SDR: RPWegC3k+LZYlvYTv2DqB3o2eIn6RCrark28VWVKUYJSl3FRaoZpX+EYgNQFYkyjbvchizpiZB
 JaQuMyKWMa0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163620307"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400";
   d="scan'208";a="163620307"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:26 -0700
IronPort-SDR: XivimXtqlVbpdgrXaCu3isyj/RVjyclZa0SqHgnuigdrm4auQgTCKcnqROf8o+nB3rX6iuGMHA
 cD57abKZmLNw==
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400";
   d="scan'208";a="342009084"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:25 -0700
Subject: [PATCH v6 02/11] device-dax/kmem: introduce dax_kmem_range()
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Mon, 05 Oct 2020 23:54:56 -0700
Message-ID: <160196729611.2166475.17062304475053542512.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 2MWQNVIS5MOSYOVYAVCNTWOW4TCJPJMS
X-Message-ID-Hash: 2MWQNVIS5MOSYOVYAVCNTWOW4TCJPJMS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: david@redhat.com, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Brice Goglin <Brice.Goglin@inria.fr>, Jia He <justin.he@arm.com>, joao.m.martins@oracle.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2MWQNVIS5MOSYOVYAVCNTWOW4TCJPJMS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Towards removing the mode specific @dax_kmem_res attribute from the
generic 'struct dev_dax', and preparing for multi-range support, teach
the driver to calculate the hotplug range from the device range. The
hotplug range is the trivially calculated memory-block-size aligned
version of the device range.

Cc: David Hildenbrand <david@redhat.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jia He <justin.he@arm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/kmem.c |   40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 5bb133df147d..b0d6a99cf12d 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -19,13 +19,20 @@ static const char *kmem_name;
 /* Set if any memory will remain added when the driver will be unloaded. */
 static bool any_hotremove_failed;
 
+static struct range dax_kmem_range(struct dev_dax *dev_dax)
+{
+	struct range range;
+
+	/* memory-block align the hotplug range */
+	range.start = ALIGN(dev_dax->range.start, memory_block_size_bytes());
+	range.end = ALIGN_DOWN(dev_dax->range.end + 1, memory_block_size_bytes()) - 1;
+	return range;
+}
+
 int dev_dax_kmem_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct range *range = &dev_dax->range;
-	resource_size_t kmem_start;
-	resource_size_t kmem_size;
-	resource_size_t kmem_end;
+	struct range range = dax_kmem_range(dev_dax);
 	struct resource *new_res;
 	const char *new_res_name;
 	int numa_node;
@@ -44,25 +51,14 @@ int dev_dax_kmem_probe(struct device *dev)
 		return -EINVAL;
 	}
 
-	/* Hotplug starting at the beginning of the next block: */
-	kmem_start = ALIGN(range->start, memory_block_size_bytes());
-
-	kmem_size = range_len(range);
-	/* Adjust the size down to compensate for moving up kmem_start: */
-	kmem_size -= kmem_start - range->start;
-	/* Align the size down to cover only complete blocks: */
-	kmem_size &= ~(memory_block_size_bytes() - 1);
-	kmem_end = kmem_start + kmem_size;
-
 	new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
 	if (!new_res_name)
 		return -ENOMEM;
 
 	/* Region is permanently reserved if hotremove fails. */
-	new_res = request_mem_region(kmem_start, kmem_size, new_res_name);
+	new_res = request_mem_region(range.start, range_len(&range), new_res_name);
 	if (!new_res) {
-		dev_warn(dev, "could not reserve region [%pa-%pa]\n",
-			 &kmem_start, &kmem_end);
+		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n", range.start, range.end);
 		kfree(new_res_name);
 		return -EBUSY;
 	}
@@ -96,9 +92,8 @@ int dev_dax_kmem_probe(struct device *dev)
 static int dev_dax_kmem_remove(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct range range = dax_kmem_range(dev_dax);
 	struct resource *res = dev_dax->dax_kmem_res;
-	resource_size_t kmem_start = res->start;
-	resource_size_t kmem_size = resource_size(res);
 	const char *res_name = res->name;
 	int rc;
 
@@ -108,12 +103,11 @@ static int dev_dax_kmem_remove(struct device *dev)
 	 * there is no way to hotremove this memory until reboot because device
 	 * unbind will succeed even if we return failure.
 	 */
-	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
+	rc = remove_memory(dev_dax->target_node, range.start, range_len(&range));
 	if (rc) {
 		any_hotremove_failed = true;
-		dev_err(dev,
-			"DAX region %pR cannot be hotremoved until the next reboot\n",
-			res);
+		dev_err(dev, "%#llx-%#llx cannot be hotremoved until the next reboot\n",
+				range.start, range.end);
 		return rc;
 	}
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

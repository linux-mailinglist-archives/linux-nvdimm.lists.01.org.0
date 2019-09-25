Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E136BE6EE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 23:13:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 32BB2200C6C8E;
	Wed, 25 Sep 2019 14:16:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C157E200C6C8B
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 14:16:07 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 14:13:55 -0700
X-IronPort-AV: E=Sophos;i="5.64,549,1559545200"; d="scan'208";a="183386359"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 14:13:54 -0700
From: ira.weiny@intel.com
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH V3] libnvdimm/namsepace: Don't set claim_class on error
Date: Wed, 25 Sep 2019 14:13:48 -0700
Message-Id: <20190925211348.14082-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Ira Weiny <ira.weiny@intel.com>

Don't leave claim_class set to an invalid value if an error occurs in
btt_claim_class().

While we are here change the return type of __holder_class_store() to be
clear about the values it is returning.

This was found via code inspection.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
V1->V2
	Add space after variable declaration...

V2->V3
	Fix oneliner
	Rebase without Dan Carpenter's patch and give him Reported-by
		credit

 drivers/nvdimm/namespace_devs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index a16e52251a30..eef885c59f47 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1510,16 +1510,20 @@ static ssize_t holder_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(holder);
 
-static ssize_t __holder_class_store(struct device *dev, const char *buf)
+static int __holder_class_store(struct device *dev, const char *buf)
 {
 	struct nd_namespace_common *ndns = to_ndns(dev);
 
 	if (dev->driver || ndns->claim)
 		return -EBUSY;
 
-	if (sysfs_streq(buf, "btt"))
-		ndns->claim_class = btt_claim_class(dev);
-	else if (sysfs_streq(buf, "pfn"))
+	if (sysfs_streq(buf, "btt")) {
+		int rc = btt_claim_class(dev);
+
+		if (rc < NVDIMM_CCLASS_NONE)
+			return rc;
+		ndns->claim_class = rc;
+	} else if (sysfs_streq(buf, "pfn"))
 		ndns->claim_class = NVDIMM_CCLASS_PFN;
 	else if (sysfs_streq(buf, "dax"))
 		ndns->claim_class = NVDIMM_CCLASS_DAX;
@@ -1528,10 +1532,6 @@ static ssize_t __holder_class_store(struct device *dev, const char *buf)
 	else
 		return -EINVAL;
 
-	/* btt_claim_class() could've returned an error */
-	if (ndns->claim_class < 0)
-		return ndns->claim_class;
-
 	return 0;
 }
 
@@ -1539,7 +1539,7 @@ static ssize_t holder_class_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
-	ssize_t rc;
+	int rc;
 
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
@@ -1547,7 +1547,7 @@ static ssize_t holder_class_store(struct device *dev,
 	rc = __holder_class_store(dev, buf);
 	if (rc >= 0)
 		rc = nd_namespace_label_update(nd_region, dev);
-	dev_dbg(dev, "%s(%zd)\n", rc < 0 ? "fail " : "", rc);
+	dev_dbg(dev, "%s(%d)\n", rc < 0 ? "fail " : "", rc);
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

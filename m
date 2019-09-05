Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CDBAA79D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 17:46:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E57D20277241;
	Thu,  5 Sep 2019 08:47:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8893421959CB2
 for <linux-nvdimm@lists.01.org>; Thu,  5 Sep 2019 08:47:21 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x85FbiVu121719; Thu, 5 Sep 2019 11:46:23 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uu3wdv70h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 11:46:20 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x85FjffG003388;
 Thu, 5 Sep 2019 15:46:19 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 2uqgh7axpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 15:46:19 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x85FkHMX34603300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Sep 2019 15:46:17 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83F48136053;
 Thu,  5 Sep 2019 15:46:17 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25B7E13604F;
 Thu,  5 Sep 2019 15:46:16 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.35.243])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Sep 2019 15:46:15 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v9 1/7] libnvdimm/region: Rewrite _probe_success() to
 _advance_seeds()
Date: Thu,  5 Sep 2019 21:15:57 +0530
Message-Id: <20190905154603.10349-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905154603.10349-1-aneesh.kumar@linux.ibm.com>
References: <20190905154603.10349-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-05_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050147
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Dan Williams <dan.j.williams@intel.com>

The nd_region_probe_success() helper collides seed management with
nvdimm->busy tracking. Given the 'busy' increment is handled internal to the
nd_region driver 'probe' path move the decrement to the 'remove' path.
With that cleanup the routine can be renamed to the more descriptive
nd_region_advance_seeds().

The change is prompted by an incoming need to optionally advance the
seeds on other events besides 'probe' success.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/bus.c            |  7 +---
 drivers/nvdimm/namespace_devs.c | 34 ++++++++++++++---
 drivers/nvdimm/nd-core.h        |  3 +-
 drivers/nvdimm/region_devs.c    | 68 +++++----------------------------
 4 files changed, 41 insertions(+), 71 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 798c5c4aea9c..9b64e68a20b8 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -95,10 +95,8 @@ static int nvdimm_bus_probe(struct device *dev)
 	rc = nd_drv->probe(dev);
 	debug_nvdimm_unlock(dev);
 
-	if (rc == 0)
-		nd_region_probe_success(nvdimm_bus, dev);
-	else
-		nd_region_disable(nvdimm_bus, dev);
+	if (rc == 0 && dev->parent && is_nd_region(dev->parent))
+		nd_region_advance_seeds(to_nd_region(dev->parent), dev);
 	nvdimm_bus_probe_end(nvdimm_bus);
 
 	dev_dbg(&nvdimm_bus->dev, "END: %s.probe(%s) = %d\n", dev->driver->name,
@@ -121,7 +119,6 @@ static int nvdimm_bus_remove(struct device *dev)
 		rc = nd_drv->remove(dev);
 		debug_nvdimm_unlock(dev);
 	}
-	nd_region_disable(nvdimm_bus, dev);
 
 	dev_dbg(&nvdimm_bus->dev, "%s.remove(%s) = %d\n", dev->driver->name,
 			dev_name(dev), rc);
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index a16e52251a30..3be81f7b9ed3 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2462,6 +2462,27 @@ static struct device **create_namespaces(struct nd_region *nd_region)
 	return devs;
 }
 
+static void deactivate_labels(void *region)
+{
+	struct nd_region *nd_region = region;
+	int i;
+
+	for (i = 0; i < nd_region->ndr_mappings; i++) {
+		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
+		struct nvdimm_drvdata *ndd = nd_mapping->ndd;
+		struct nvdimm *nvdimm = nd_mapping->nvdimm;
+
+		mutex_lock(&nd_mapping->lock);
+		nd_mapping_free_labels(nd_mapping);
+		mutex_unlock(&nd_mapping->lock);
+
+		put_ndd(ndd);
+		nd_mapping->ndd = NULL;
+		if (ndd)
+			atomic_dec(&nvdimm->busy);
+	}
+}
+
 static int init_active_labels(struct nd_region *nd_region)
 {
 	int i;
@@ -2519,16 +2540,17 @@ static int init_active_labels(struct nd_region *nd_region)
 			mutex_unlock(&nd_mapping->lock);
 		}
 
-		if (j >= count)
-			continue;
+		if (j < count)
+			break;
+	}
 
-		mutex_lock(&nd_mapping->lock);
-		nd_mapping_free_labels(nd_mapping);
-		mutex_unlock(&nd_mapping->lock);
+	if (i < nd_region->ndr_mappings) {
+		deactivate_labels(nd_region);
 		return -ENOMEM;
 	}
 
-	return 0;
+	return devm_add_action_or_reset(&nd_region->dev, deactivate_labels,
+			nd_region);
 }
 
 int nd_region_register_namespaces(struct nd_region *nd_region, int *err)
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 0ac52b6eb00e..945658cc32ec 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -128,13 +128,12 @@ int __init nvdimm_bus_init(void);
 void nvdimm_bus_exit(void);
 void nvdimm_devs_exit(void);
 void nd_region_devs_exit(void);
-void nd_region_probe_success(struct nvdimm_bus *nvdimm_bus, struct device *dev);
 struct nd_region;
+void nd_region_advance_seeds(struct nd_region *nd_region, struct device *dev);
 void nd_region_create_ns_seed(struct nd_region *nd_region);
 void nd_region_create_btt_seed(struct nd_region *nd_region);
 void nd_region_create_pfn_seed(struct nd_region *nd_region);
 void nd_region_create_dax_seed(struct nd_region *nd_region);
-void nd_region_disable(struct nvdimm_bus *nvdimm_bus, struct device *dev);
 int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus);
 void nvdimm_bus_destroy_ndctl(struct nvdimm_bus *nvdimm_bus);
 void nd_synchronize(void);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index af30cbe7a8ea..57de49b79d7d 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -715,85 +715,37 @@ void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
 }
 
 /*
- * Upon successful probe/remove, take/release a reference on the
- * associated interleave set (if present), and plant new btt + namespace
- * seeds.  Also, on the removal of a BLK region, notify the provider to
- * disable the region.
+ * When a namespace is activated create new seeds for the next
+ * namespace, or namespace-personality to be configured.
  */
-static void nd_region_notify_driver_action(struct nvdimm_bus *nvdimm_bus,
-		struct device *dev, bool probe)
+void nd_region_advance_seeds(struct nd_region *nd_region, struct device *dev)
 {
-	struct nd_region *nd_region;
-
-	if (!probe && is_nd_region(dev)) {
-		int i;
-
-		nd_region = to_nd_region(dev);
-		for (i = 0; i < nd_region->ndr_mappings; i++) {
-			struct nd_mapping *nd_mapping = &nd_region->mapping[i];
-			struct nvdimm_drvdata *ndd = nd_mapping->ndd;
-			struct nvdimm *nvdimm = nd_mapping->nvdimm;
-
-			mutex_lock(&nd_mapping->lock);
-			nd_mapping_free_labels(nd_mapping);
-			mutex_unlock(&nd_mapping->lock);
-
-			put_ndd(ndd);
-			nd_mapping->ndd = NULL;
-			if (ndd)
-				atomic_dec(&nvdimm->busy);
-		}
-	}
-	if (dev->parent && is_nd_region(dev->parent) && probe) {
-		nd_region = to_nd_region(dev->parent);
-		nvdimm_bus_lock(dev);
-		if (nd_region->ns_seed == dev)
-			nd_region_create_ns_seed(nd_region);
-		nvdimm_bus_unlock(dev);
-	}
-	if (is_nd_btt(dev) && probe) {
+	nvdimm_bus_lock(dev);
+	if (nd_region->ns_seed == dev) {
+		nd_region_create_ns_seed(nd_region);
+	} else if (is_nd_btt(dev)) {
 		struct nd_btt *nd_btt = to_nd_btt(dev);
 
-		nd_region = to_nd_region(dev->parent);
-		nvdimm_bus_lock(dev);
 		if (nd_region->btt_seed == dev)
 			nd_region_create_btt_seed(nd_region);
 		if (nd_region->ns_seed == &nd_btt->ndns->dev)
 			nd_region_create_ns_seed(nd_region);
-		nvdimm_bus_unlock(dev);
-	}
-	if (is_nd_pfn(dev) && probe) {
+	} else if (is_nd_pfn(dev)) {
 		struct nd_pfn *nd_pfn = to_nd_pfn(dev);
 
-		nd_region = to_nd_region(dev->parent);
-		nvdimm_bus_lock(dev);
 		if (nd_region->pfn_seed == dev)
 			nd_region_create_pfn_seed(nd_region);
 		if (nd_region->ns_seed == &nd_pfn->ndns->dev)
 			nd_region_create_ns_seed(nd_region);
-		nvdimm_bus_unlock(dev);
-	}
-	if (is_nd_dax(dev) && probe) {
+	} else if (is_nd_dax(dev)) {
 		struct nd_dax *nd_dax = to_nd_dax(dev);
 
-		nd_region = to_nd_region(dev->parent);
-		nvdimm_bus_lock(dev);
 		if (nd_region->dax_seed == dev)
 			nd_region_create_dax_seed(nd_region);
 		if (nd_region->ns_seed == &nd_dax->nd_pfn.ndns->dev)
 			nd_region_create_ns_seed(nd_region);
-		nvdimm_bus_unlock(dev);
 	}
-}
-
-void nd_region_probe_success(struct nvdimm_bus *nvdimm_bus, struct device *dev)
-{
-	nd_region_notify_driver_action(nvdimm_bus, dev, true);
-}
-
-void nd_region_disable(struct nvdimm_bus *nvdimm_bus, struct device *dev)
-{
-	nd_region_notify_driver_action(nvdimm_bus, dev, false);
+	nvdimm_bus_unlock(dev);
 }
 
 static ssize_t mappingN(struct device *dev, char *buf, int n)
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

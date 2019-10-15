Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36372D79DC
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Oct 2019 17:33:33 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AE9AA10FCB788;
	Tue, 15 Oct 2019 08:36:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C5BAC10FCB787
	for <linux-nvdimm@lists.01.org>; Tue, 15 Oct 2019 08:36:27 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9FFDCUO185794;
	Tue, 15 Oct 2019 11:33:27 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vng3t9h1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2019 11:33:23 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9FFUJMR028336;
	Tue, 15 Oct 2019 15:33:11 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma05wdc.us.ibm.com with ESMTP id 2vk6f74g2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2019 15:33:11 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9FFXAg319661198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2019 15:33:10 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1748F6A047;
	Tue, 15 Oct 2019 15:33:10 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B3A06A04D;
	Tue, 15 Oct 2019 15:33:08 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.40.163])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2019 15:33:07 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH V1 2/2] libnvdimm/nsio: Rename devm_nsio_enable/disable to devm_nsio_probe_enable/disable
Date: Tue, 15 Oct 2019 21:03:02 +0530
Message-Id: <20191015153302.15750-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
References: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=929 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910150135
Message-ID-Hash: EM5LO2JSHYM4PZIVK76CUNWNWXEDM6R6
X-Message-ID-Hash: EM5LO2JSHYM4PZIVK76CUNWNWXEDM6R6
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EM5LO2JSHYM4PZIVK76CUNWNWXEDM6R6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These functions are now only used while probing namespace. Update the name
to indicate the same.

No functional change in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/dax/pmem/core.c | 4 ++--
 drivers/nvdimm/claim.c  | 8 ++++----
 drivers/nvdimm/nd.h     | 8 ++++----
 drivers/nvdimm/pmem.c   | 4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 6eb6dfdf19bf..dec7b5a89d63 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -28,13 +28,13 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	nsio = to_nd_namespace_io(&ndns->dev);
 
 	/* parse the 'pfn' info block via ->rw_bytes */
-	rc = devm_nsio_enable(dev, nsio);
+	rc = devm_nsio_probe_enable(dev, nsio);
 	if (rc)
 		return ERR_PTR(rc);
 	rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
 	if (rc)
 		return ERR_PTR(rc);
-	devm_nsio_disable(dev, nsio);
+	devm_nsio_probe_disable(dev, nsio);
 
 	/* reserve the metadata area, device-dax will reserve the data */
 	pfn_sb = nd_pfn->pfn_sb;
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 9f2e6646fcd4..93e26ca021ee 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -300,7 +300,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 	return rc;
 }
 
-int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
+int devm_nsio_probe_enable(struct device *dev, struct nd_namespace_io *nsio)
 {
 	struct resource *res = &nsio->res;
 	struct nd_namespace_common *ndns = &nsio->common;
@@ -323,9 +323,9 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
 
 	return PTR_ERR_OR_ZERO(nsio->addr);
 }
-EXPORT_SYMBOL_GPL(devm_nsio_enable);
+EXPORT_SYMBOL_GPL(devm_nsio_probe_enable);
 
-void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio)
+void devm_nsio_probe_disable(struct device *dev, struct nd_namespace_io *nsio)
 {
 	struct resource *res = &nsio->res;
 
@@ -333,4 +333,4 @@ void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio)
 	devm_exit_badblocks(dev, &nsio->bb);
 	devm_release_mem_region(dev, res->start, resource_size(res));
 }
-EXPORT_SYMBOL_GPL(devm_nsio_disable);
+EXPORT_SYMBOL_GPL(devm_nsio_probe_disable);
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index f51d51aa2f96..5ae8f17ff3d3 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -376,20 +376,20 @@ void nvdimm_badblocks_populate(struct nd_region *nd_region,
 #define MAX_STRUCT_PAGE_SIZE 64
 
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
-int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio);
-void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio);
+int devm_nsio_probe_enable(struct device *dev, struct nd_namespace_io *nsio);
+void devm_nsio_probe_disable(struct device *dev, struct nd_namespace_io *nsio);
 #else
 static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
 				   struct dev_pagemap *pgmap)
 {
 	return -ENXIO;
 }
-static inline int devm_nsio_enable(struct device *dev,
+static inline int devm_nsio_probe_enable(struct device *dev,
 		struct nd_namespace_io *nsio)
 {
 	return -ENXIO;
 }
-static inline void devm_nsio_disable(struct device *dev,
+static inline void devm_nsio_probe_disable(struct device *dev,
 		struct nd_namespace_io *nsio)
 {
 }
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 69956e49ec56..58706bae4d71 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -381,7 +381,7 @@ static int pmem_attach_disk(struct device *dev,
 	}
 
 	/* we're attaching a block device, disable raw namespace access */
-	devm_nsio_disable(dev, nsio);
+	devm_nsio_probe_disable(dev, nsio);
 
 	dev_set_drvdata(dev, pmem);
 	pmem->phys_addr = res->start;
@@ -497,7 +497,7 @@ static int nd_pmem_probe(struct device *dev)
 	if (IS_ERR(ndns))
 		return PTR_ERR(ndns);
 
-	if (devm_nsio_enable(dev, to_nd_namespace_io(&ndns->dev)))
+	if (devm_nsio_probe_enable(dev, to_nd_namespace_io(&ndns->dev)))
 		return -ENXIO;
 
 	if (is_nd_btt(dev))
-- 
2.21.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

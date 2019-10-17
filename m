Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E4CDA672
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Oct 2019 09:29:02 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BBC2110FD2228;
	Thu, 17 Oct 2019 00:31:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B4A2210FD2228
	for <linux-nvdimm@lists.01.org>; Thu, 17 Oct 2019 00:31:47 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H7OLJ7121137;
	Thu, 17 Oct 2019 03:28:46 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vpk3ehp5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2019 03:28:46 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9H7QIXu021201;
	Thu, 17 Oct 2019 07:28:45 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by ppma01dal.us.ibm.com with ESMTP id 2vk6f7xc17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2019 07:28:45 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9H7Sii553543422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2019 07:28:44 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26AFF112063;
	Thu, 17 Oct 2019 07:28:44 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD35C112061;
	Thu, 17 Oct 2019 07:28:42 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.35.94])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 17 Oct 2019 07:28:42 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v2] libnvdimm/nsio: differentiate between probe mapping and runtime mapping
Date: Thu, 17 Oct 2019 12:58:39 +0530
Message-Id: <20191017072839.31766-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=652 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170064
Message-ID-Hash: QX6X7LFPBMRNFTRMGZTQYFKCFOR2JJVB
X-Message-ID-Hash: QX6X7LFPBMRNFTRMGZTQYFKCFOR2JJVB
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QX6X7LFPBMRNFTRMGZTQYFKCFOR2JJVB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

nvdimm core currently maps the full namespace to an ioremap range
while probing the namespace mode. This can result in probe failures
on architectures that have limited ioremap space.

For example, with a large btt namespace that consumes most of I/O remap
range, depending on the sequence of namespace initialization, we can find
a pfn namespace initialization failure due to unavailable I/O remap space
which we use for temporary mapping.

nvdimm core can avoid this failure by only mapping the reserver block area to
check for pfn superblock type and map the full namespace resource only before
using the namespace.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
Changes from V1:
* update changelog
* update patch based on review feedback.

 drivers/dax/pmem/core.c   |  2 +-
 drivers/nvdimm/claim.c    |  7 +++----
 drivers/nvdimm/nd.h       |  4 ++--
 drivers/nvdimm/pfn.h      |  6 ++++++
 drivers/nvdimm/pfn_devs.c |  5 -----
 drivers/nvdimm/pmem.c     | 15 ++++++++++++---
 6 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 6eb6dfdf19bf..f174dbfbe1c4 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -28,7 +28,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	nsio = to_nd_namespace_io(&ndns->dev);
 
 	/* parse the 'pfn' info block via ->rw_bytes */
-	rc = devm_nsio_enable(dev, nsio);
+	rc = devm_nsio_enable(dev, nsio, info_block_reserve());
 	if (rc)
 		return ERR_PTR(rc);
 	rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 2985ca949912..d89d2c039e25 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -300,12 +300,12 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 	return rc;
 }
 
-int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
+int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio, unsigned long size)
 {
 	struct resource *res = &nsio->res;
 	struct nd_namespace_common *ndns = &nsio->common;
 
-	nsio->size = resource_size(res);
+	nsio->size = size;
 	if (!devm_request_mem_region(dev, res->start, resource_size(res),
 				dev_name(&ndns->dev))) {
 		dev_warn(dev, "could not reserve region %pR\n", res);
@@ -318,8 +318,7 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
 	nvdimm_badblocks_populate(to_nd_region(ndns->dev.parent), &nsio->bb,
 			&nsio->res);
 
-	nsio->addr = devm_memremap(dev, res->start, resource_size(res),
-			ARCH_MEMREMAP_PMEM);
+	nsio->addr = devm_memremap(dev, res->start, size, ARCH_MEMREMAP_PMEM);
 
 	return PTR_ERR_OR_ZERO(nsio->addr);
 }
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ee5c04070ef9..93d3c760c0f3 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -376,7 +376,7 @@ void nvdimm_badblocks_populate(struct nd_region *nd_region,
 #define MAX_STRUCT_PAGE_SIZE 64
 
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
-int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio);
+int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio, unsigned long size);
 void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio);
 #else
 static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
@@ -385,7 +385,7 @@ static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
 	return -ENXIO;
 }
 static inline int devm_nsio_enable(struct device *dev,
-		struct nd_namespace_io *nsio)
+		struct nd_namespace_io *nsio, unsigned long size)
 {
 	return -ENXIO;
 }
diff --git a/drivers/nvdimm/pfn.h b/drivers/nvdimm/pfn.h
index acb19517f678..f4856c87d01c 100644
--- a/drivers/nvdimm/pfn.h
+++ b/drivers/nvdimm/pfn.h
@@ -36,4 +36,10 @@ struct nd_pfn_sb {
 	__le64 checksum;
 };
 
+static inline u32 info_block_reserve(void)
+{
+	return ALIGN(SZ_8K, PAGE_SIZE);
+}
+
+
 #endif /* __NVDIMM_PFN_H */
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 60d81fae06ee..e49aa9a0fd04 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -635,11 +635,6 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
 }
 EXPORT_SYMBOL(nd_pfn_probe);
 
-static u32 info_block_reserve(void)
-{
-	return ALIGN(SZ_8K, PAGE_SIZE);
-}
-
 /*
  * We hotplug memory at sub-section granularity, pad the reserved area
  * from the previous section base to the namespace base address.
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index f9f76f6ba07b..3c188ffeff11 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -491,17 +491,26 @@ static int pmem_attach_disk(struct device *dev,
 static int nd_pmem_probe(struct device *dev)
 {
 	int ret;
+	struct nd_namespace_io *nsio;
 	struct nd_namespace_common *ndns;
 
 	ndns = nvdimm_namespace_common_probe(dev);
 	if (IS_ERR(ndns))
 		return PTR_ERR(ndns);
 
-	if (devm_nsio_enable(dev, to_nd_namespace_io(&ndns->dev)))
-		return -ENXIO;
+	nsio = to_nd_namespace_io(&ndns->dev);
 
-	if (is_nd_btt(dev))
+	if (is_nd_btt(dev)) {
+		/*
+		 * Map with resource size
+		 */
+		if (devm_nsio_enable(dev, nsio, resource_size(&nsio->res)))
+			return -ENXIO;
 		return nvdimm_namespace_attach_btt(ndns);
+	}
+
+	if (devm_nsio_enable(dev, nsio, info_block_reserve()))
+		return -ENXIO;
 
 	if (is_nd_pfn(dev))
 		return pmem_attach_disk(dev, ndns);
-- 
2.21.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

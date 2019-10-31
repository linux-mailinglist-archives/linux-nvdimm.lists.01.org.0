Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EE9EAE05
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 11:58:22 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 787E6100DC406;
	Thu, 31 Oct 2019 03:58:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B0CD1100DC404
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 03:58:47 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VAr6On014378;
	Thu, 31 Oct 2019 06:58:18 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vyv89vetk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2019 06:58:08 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9VAsaGu022962;
	Thu, 31 Oct 2019 10:57:52 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma04wdc.us.ibm.com with ESMTP id 2vxwh5efk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2019 10:57:52 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9VAvowv64618942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2019 10:57:50 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90EC47805C;
	Thu, 31 Oct 2019 10:57:50 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2557E7805E;
	Thu, 31 Oct 2019 10:57:49 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.39.184])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu, 31 Oct 2019 10:57:48 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v4 2/2] libnvdimm/namespace: Differentiate between probe mapping and runtime mapping
Date: Thu, 31 Oct 2019 16:27:41 +0530
Message-Id: <20191031105741.102793-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031105741.102793-1-aneesh.kumar@linux.ibm.com>
References: <20191031105741.102793-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310111
Message-ID-Hash: 2D5XMYGXSUUN6RMZ5BBBWKAP7NTEC33D
X-Message-ID-Hash: 2D5XMYGXSUUN6RMZ5BBBWKAP7NTEC33D
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2D5XMYGXSUUN6RMZ5BBBWKAP7NTEC33D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The nvdimm core currently maps the full namespace to an ioremap range
while probing the namespace mode. This can result in probe failures on
architectures that have limited ioremap space.

For example, with a large btt namespace that consumes most of I/O remap
range, depending on the sequence of namespace initialization, the user
can find a pfn namespace initialization failure due to unavailable I/O
remap space which nvdimm core uses for temporary mapping.

nvdimm core can avoid this failure by only mapping the reserved info
block area to check for pfn superblock type and map the full namespace
resource only before using the namespace.

Given that personalities like BTT can be layered on top of any namespace
type create a generic form of devm_nsio_enable (devm_namespace_enable)
and use it inside the per-personality attach routines. Now
devm_namespace_enable() is always paired with disable unless the mapping
is going to be used for long term runtime access.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/20191017073308.32645-1-aneesh.kumar@linux.ibm.com
[djbw: reworks to move devm_namespace_{en,dis}able into *attach helpers]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/pmem/core.c         |  6 +++---
 drivers/nvdimm/btt.c            | 10 ++++++++--
 drivers/nvdimm/claim.c          | 14 ++++++--------
 drivers/nvdimm/namespace_devs.c | 17 +++++++++++++++++
 drivers/nvdimm/nd-core.h        | 16 ++++++++++++++++
 drivers/nvdimm/nd.h             | 22 +++++++++-------------
 drivers/nvdimm/pfn_devs.c       | 18 +++++++++++-------
 drivers/nvdimm/pmem.c           | 17 +++++++++++++----
 8 files changed, 83 insertions(+), 37 deletions(-)

diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 6eb6dfdf19bf..2bedf8414fff 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -25,20 +25,20 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	ndns = nvdimm_namespace_common_probe(dev);
 	if (IS_ERR(ndns))
 		return ERR_CAST(ndns);
-	nsio = to_nd_namespace_io(&ndns->dev);
 
 	/* parse the 'pfn' info block via ->rw_bytes */
-	rc = devm_nsio_enable(dev, nsio);
+	rc = devm_namespace_enable(dev, ndns, nd_info_block_reserve());
 	if (rc)
 		return ERR_PTR(rc);
 	rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
 	if (rc)
 		return ERR_PTR(rc);
-	devm_nsio_disable(dev, nsio);
+	devm_namespace_disable(dev, ndns);
 
 	/* reserve the metadata area, device-dax will reserve the data */
 	pfn_sb = nd_pfn->pfn_sb;
 	offset = le64_to_cpu(pfn_sb->dataoff);
+	nsio = to_nd_namespace_io(&ndns->dev);
 	if (!devm_request_mem_region(dev, nsio->res.start, offset,
 				dev_name(&ndns->dev))) {
 		dev_warn(dev, "could not reserve metadata\n");
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3e9f45aec8d1..8cb890a987b0 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1674,7 +1674,8 @@ int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
 	struct nd_region *nd_region;
 	struct btt_sb *btt_sb;
 	struct btt *btt;
-	size_t rawsize;
+	size_t size, rawsize;
+	int rc;
 
 	if (!nd_btt->uuid || !nd_btt->ndns || !nd_btt->lbasize) {
 		dev_dbg(&nd_btt->dev, "incomplete btt configuration\n");
@@ -1685,6 +1686,11 @@ int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
 	if (!btt_sb)
 		return -ENOMEM;
 
+	size = nvdimm_namespace_capacity(ndns);
+	rc = devm_namespace_enable(&nd_btt->dev, ndns, size);
+	if (rc)
+		return rc;
+
 	/*
 	 * If this returns < 0, that is ok as it just means there wasn't
 	 * an existing BTT, and we're creating a new one. We still need to
@@ -1693,7 +1699,7 @@ int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
 	 */
 	nd_btt_version(nd_btt, ndns, btt_sb);
 
-	rawsize = nvdimm_namespace_capacity(ndns) - nd_btt->initial_offset;
+	rawsize = size - nd_btt->initial_offset;
 	if (rawsize < ARENA_MIN_SIZE) {
 		dev_dbg(&nd_btt->dev, "%s must be at least %ld bytes\n",
 				dev_name(&ndns->dev),
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 2985ca949912..45964acba944 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -300,13 +300,14 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 	return rc;
 }
 
-int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
+int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio,
+		resource_size_t size)
 {
 	struct resource *res = &nsio->res;
 	struct nd_namespace_common *ndns = &nsio->common;
 
-	nsio->size = resource_size(res);
-	if (!devm_request_mem_region(dev, res->start, resource_size(res),
+	nsio->size = size;
+	if (!devm_request_mem_region(dev, res->start, size,
 				dev_name(&ndns->dev))) {
 		dev_warn(dev, "could not reserve region %pR\n", res);
 		return -EBUSY;
@@ -318,12 +319,10 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
 	nvdimm_badblocks_populate(to_nd_region(ndns->dev.parent), &nsio->bb,
 			&nsio->res);
 
-	nsio->addr = devm_memremap(dev, res->start, resource_size(res),
-			ARCH_MEMREMAP_PMEM);
+	nsio->addr = devm_memremap(dev, res->start, size, ARCH_MEMREMAP_PMEM);
 
 	return PTR_ERR_OR_ZERO(nsio->addr);
 }
-EXPORT_SYMBOL_GPL(devm_nsio_enable);
 
 void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio)
 {
@@ -331,6 +330,5 @@ void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio)
 
 	devm_memunmap(dev, nsio->addr);
 	devm_exit_badblocks(dev, &nsio->bb);
-	devm_release_mem_region(dev, res->start, resource_size(res));
+	devm_release_mem_region(dev, res->start, nsio->size);
 }
-EXPORT_SYMBOL_GPL(devm_nsio_disable);
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index cca0a3ba1d2c..c72d37b43028 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1759,6 +1759,23 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 }
 EXPORT_SYMBOL(nvdimm_namespace_common_probe);
 
+int devm_namespace_enable(struct device *dev, struct nd_namespace_common *ndns,
+		resource_size_t size)
+{
+	if (is_namespace_blk(&ndns->dev))
+		return 0;
+	return devm_nsio_enable(dev, to_nd_namespace_io(&ndns->dev), size);
+}
+EXPORT_SYMBOL_GPL(devm_namespace_enable);
+
+void devm_namespace_disable(struct device *dev, struct nd_namespace_common *ndns)
+{
+	if (is_namespace_blk(&ndns->dev))
+		return;
+	devm_nsio_disable(dev, to_nd_namespace_io(&ndns->dev));
+}
+EXPORT_SYMBOL_GPL(devm_namespace_disable);
+
 static struct device **create_namespace_io(struct nd_region *nd_region)
 {
 	struct nd_namespace_io *nsio;
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 25fa121104d0..25ae33da987d 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -171,6 +171,22 @@ ssize_t nd_namespace_store(struct device *dev,
 struct nd_pfn *to_nd_pfn_safe(struct device *dev);
 bool is_nvdimm_bus(struct device *dev);
 
+#if IS_ENABLED(CONFIG_ND_CLAIM)
+int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio,
+		resource_size_t size);
+void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio);
+#else
+static inline int devm_nsio_enable(struct device *dev,
+		struct nd_namespace_io *nsio, resource_size_t size)
+{
+	return -ENXIO;
+}
+
+void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio)
+{
+}
+#endif
+
 #ifdef CONFIG_PROVE_LOCKING
 extern struct class *nd_class;
 
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ee5c04070ef9..a9f338d01a55 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -212,6 +212,11 @@ struct nd_dax {
 	struct nd_pfn nd_pfn;
 };
 
+static inline u32 nd_info_block_reserve(void)
+{
+	return ALIGN(SZ_8K, PAGE_SIZE);
+}
+
 enum nd_async_mode {
 	ND_SYNC,
 	ND_ASYNC,
@@ -370,29 +375,20 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 unsigned int pmem_sector_size(struct nd_namespace_common *ndns);
 void nvdimm_badblocks_populate(struct nd_region *nd_region,
 		struct badblocks *bb, const struct resource *res);
+int devm_namespace_enable(struct device *dev, struct nd_namespace_common *ndns,
+		resource_size_t size);
+void devm_namespace_disable(struct device *dev,
+		struct nd_namespace_common *ndns);
 #if IS_ENABLED(CONFIG_ND_CLAIM)
-
 /* max struct page size independent of kernel config */
 #define MAX_STRUCT_PAGE_SIZE 64
-
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
-int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio);
-void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio);
 #else
 static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
 				   struct dev_pagemap *pgmap)
 {
 	return -ENXIO;
 }
-static inline int devm_nsio_enable(struct device *dev,
-		struct nd_namespace_io *nsio)
-{
-	return -ENXIO;
-}
-static inline void devm_nsio_disable(struct device *dev,
-		struct nd_namespace_io *nsio)
-{
-}
 #endif
 int nd_blk_region_init(struct nd_region *nd_region);
 int nd_region_activate(struct nd_region *nd_region);
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index fc2cd412861a..da6b3b0865a0 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -382,6 +382,15 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
 	meta_start = (SZ_4K + sizeof(*pfn_sb)) >> 9;
 	meta_num = (le64_to_cpu(pfn_sb->dataoff) >> 9) - meta_start;
 
+	/*
+	 * re-enable the namespace with correct size so that we can access
+	 * the device memmap area.
+	 */
+	devm_namespace_disable(&nd_pfn->dev, ndns);
+	rc = devm_namespace_enable(&nd_pfn->dev, ndns, le64_to_cpu(pfn_sb->dataoff));
+	if (rc)
+		return rc;
+
 	do {
 		unsigned long zero_len;
 		u64 nsoff;
@@ -635,11 +644,6 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
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
@@ -653,7 +657,7 @@ static unsigned long init_altmap_base(resource_size_t base)
 
 static unsigned long init_altmap_reserve(resource_size_t base)
 {
-	unsigned long reserve = info_block_reserve() >> PAGE_SHIFT;
+	unsigned long reserve = nd_info_block_reserve() >> PAGE_SHIFT;
 	unsigned long base_pfn = PHYS_PFN(base);
 
 	reserve += base_pfn - SUBSECTION_ALIGN_DOWN(base_pfn);
@@ -668,7 +672,7 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 	u64 offset = le64_to_cpu(pfn_sb->dataoff);
 	u32 start_pad = __le32_to_cpu(pfn_sb->start_pad);
 	u32 end_trunc = __le32_to_cpu(pfn_sb->end_trunc);
-	u32 reserve = info_block_reserve();
+	u32 reserve = nd_info_block_reserve();
 	struct nd_namespace_common *ndns = nd_pfn->ndns;
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	resource_size_t base = nsio->res.start + start_pad;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index f9f76f6ba07b..7a6f4501dcda 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -372,6 +372,10 @@ static int pmem_attach_disk(struct device *dev,
 	if (!pmem)
 		return -ENOMEM;
 
+	rc = devm_namespace_enable(dev, ndns, nd_info_block_reserve());
+	if (rc)
+		return rc;
+
 	/* while nsio_rw_bytes is active, parse a pfn info block if present */
 	if (is_nd_pfn(dev)) {
 		nd_pfn = to_nd_pfn(dev);
@@ -381,7 +385,7 @@ static int pmem_attach_disk(struct device *dev,
 	}
 
 	/* we're attaching a block device, disable raw namespace access */
-	devm_nsio_disable(dev, nsio);
+	devm_namespace_disable(dev, ndns);
 
 	dev_set_drvdata(dev, pmem);
 	pmem->phys_addr = res->start;
@@ -497,15 +501,16 @@ static int nd_pmem_probe(struct device *dev)
 	if (IS_ERR(ndns))
 		return PTR_ERR(ndns);
 
-	if (devm_nsio_enable(dev, to_nd_namespace_io(&ndns->dev)))
-		return -ENXIO;
-
 	if (is_nd_btt(dev))
 		return nvdimm_namespace_attach_btt(ndns);
 
 	if (is_nd_pfn(dev))
 		return pmem_attach_disk(dev, ndns);
 
+	ret = devm_namespace_enable(dev, ndns, nd_info_block_reserve());
+	if (ret)
+		return ret;
+
 	ret = nd_btt_probe(dev, ndns);
 	if (ret == 0)
 		return -ENXIO;
@@ -532,6 +537,10 @@ static int nd_pmem_probe(struct device *dev)
 		return -ENXIO;
 	else if (ret == -EOPNOTSUPP)
 		return ret;
+
+	/* probe complete, attach handles namespace enabling */
+	devm_namespace_disable(dev, ndns);
+
 	return pmem_attach_disk(dev, ndns);
 }
 
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

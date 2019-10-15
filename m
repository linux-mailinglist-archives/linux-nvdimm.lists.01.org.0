Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3863D79DA
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Oct 2019 17:33:26 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C66D10FCB785;
	Tue, 15 Oct 2019 08:36:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 397E910FCB783
	for <linux-nvdimm@lists.01.org>; Tue, 15 Oct 2019 08:36:20 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9FFEtBI129433;
	Tue, 15 Oct 2019 11:33:10 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vng361x63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2019 11:33:09 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9FFX0Sv005192;
	Tue, 15 Oct 2019 15:33:09 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma03dal.us.ibm.com with ESMTP id 2vk6f8upjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2019 15:33:09 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9FFX7va59310464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2019 15:33:07 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50DE66A047;
	Tue, 15 Oct 2019 15:33:07 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 746A06A054;
	Tue, 15 Oct 2019 15:33:05 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.40.163])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2019 15:33:04 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH V1 1/2] libnvdimm/nsio: differentiate between probe mapping and runtime mapping
Date: Tue, 15 Oct 2019 21:03:01 +0530
Message-Id: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910150135
Message-ID-Hash: UQ4BMXUX3F7BOVKIBTZVKFF2P3HV4FSY
X-Message-ID-Hash: UQ4BMXUX3F7BOVKIBTZVKFF2P3HV4FSY
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UQ4BMXUX3F7BOVKIBTZVKFF2P3HV4FSY/>
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

nvdimm core can avoid this failure by only mapping the reserver block area to
check for pfn superblock type and map the full namespace resource only before
using the namespace. nvdimm core use ioremap range only for the raw and btt
namespace and we can limit the max namespace size for these two modes. For
both fsdax and devdax this change enables nvdimm to map namespace larger
that ioremap limit.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/blk.c      |  2 +-
 drivers/nvdimm/btt.c      | 13 ++++++++++++-
 drivers/nvdimm/claim.c    |  2 +-
 drivers/nvdimm/nd.h       |  2 +-
 drivers/nvdimm/pfn.h      |  6 ++++++
 drivers/nvdimm/pfn_devs.c |  5 -----
 drivers/nvdimm/pmem.c     |  2 +-
 7 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 677d6f45b5c4..755192332269 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -302,7 +302,7 @@ static int nd_blk_probe(struct device *dev)
 
 	ndns->rw_bytes = nsblk_rw_bytes;
 	if (is_nd_btt(dev))
-		return nvdimm_namespace_attach_btt(ndns);
+		return nvdimm_namespace_attach_btt(dev, ndns);
 	else if (nd_btt_probe(dev, ndns) == 0) {
 		/* we'll come back as btt-blk */
 		return -ENXIO;
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3e9f45aec8d1..a1e213e8ef81 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1668,9 +1668,12 @@ static void btt_fini(struct btt *btt)
 	}
 }
 
-int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
+int nvdimm_namespace_attach_btt(struct device *dev,
+		struct nd_namespace_common *ndns)
 {
+	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	struct nd_btt *nd_btt = to_nd_btt(ndns->claim);
+	struct resource *res = &nsio->res;
 	struct nd_region *nd_region;
 	struct btt_sb *btt_sb;
 	struct btt *btt;
@@ -1685,6 +1688,14 @@ int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
 	if (!btt_sb)
 		return -ENOMEM;
 
+	/*
+	 * Remove the old mapping and do the full mapping.
+	 */
+	devm_memunmap(dev, nsio->addr);
+	nsio->addr = devm_memremap(dev, res->start, resource_size(res),
+			ARCH_MEMREMAP_PMEM);
+	if (IS_ERR(nsio->addr))
+		return -ENXIO;
 	/*
 	 * If this returns < 0, that is ok as it just means there wasn't
 	 * an existing BTT, and we're creating a new one. We still need to
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 2985ca949912..9f2e6646fcd4 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -318,7 +318,7 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
 	nvdimm_badblocks_populate(to_nd_region(ndns->dev.parent), &nsio->bb,
 			&nsio->res);
 
-	nsio->addr = devm_memremap(dev, res->start, resource_size(res),
+	nsio->addr = devm_memremap(dev, res->start, info_block_reserve(),
 			ARCH_MEMREMAP_PMEM);
 
 	return PTR_ERR_OR_ZERO(nsio->addr);
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ee5c04070ef9..f51d51aa2f96 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -363,7 +363,7 @@ struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
 resource_size_t nvdimm_namespace_capacity(struct nd_namespace_common *ndns);
 bool nvdimm_namespace_locked(struct nd_namespace_common *ndns);
 struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev);
-int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns);
+int nvdimm_namespace_attach_btt(struct device *dev, struct nd_namespace_common *ndns);
 int nvdimm_namespace_detach_btt(struct nd_btt *nd_btt);
 const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		char *name);
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
index f9f76f6ba07b..69956e49ec56 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -501,7 +501,7 @@ static int nd_pmem_probe(struct device *dev)
 		return -ENXIO;
 
 	if (is_nd_btt(dev))
-		return nvdimm_namespace_attach_btt(ndns);
+		return nvdimm_namespace_attach_btt(dev, ndns);
 
 	if (is_nd_pfn(dev))
 		return pmem_attach_disk(dev, ndns);
-- 
2.21.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2FA1EB6C2
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jun 2020 09:49:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 44B0810106A07;
	Tue,  2 Jun 2020 00:44:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 688B910106A06
	for <linux-nvdimm@lists.01.org>; Tue,  2 Jun 2020 00:44:50 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0527ilLF178262;
	Tue, 2 Jun 2020 03:49:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bkjmnqd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 03:49:36 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0527kTM2186023;
	Tue, 2 Jun 2020 03:49:36 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bkjmnqcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 03:49:36 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0527jeRa007188;
	Tue, 2 Jun 2020 07:49:35 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma04dal.us.ibm.com with ESMTP id 31bf49vuhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 07:49:35 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0527nXQe39191032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2020 07:49:33 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE12CC6057;
	Tue,  2 Jun 2020 07:49:33 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE5E2C6055;
	Tue,  2 Jun 2020 07:49:29 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.34.130])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2020 07:49:29 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [RFC PATCH v2 4/5] powerpc/papr_scm: disable MAP_SYNC for newer hardware
Date: Tue,  2 Jun 2020 13:19:08 +0530
Message-Id: <20200602074909.36738-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602074909.36738-1-aneesh.kumar@linux.ibm.com>
References: <20200602074909.36738-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_08:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 cotscore=-2147483648 clxscore=1015 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020047
Message-ID-Hash: XN6ZCRTTTRIIAY3QCXFEV3KRVBGLHIYH
X-Message-ID-Hash: XN6ZCRTTTRIIAY3QCXFEV3KRVBGLHIYH
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XN6ZCRTTTRIIAY3QCXFEV3KRVBGLHIYH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 17 ++++++++++++++++-
 drivers/nvdimm/of_pmem.c                  |  7 +++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index f35592423380..30474d4cd109 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -30,6 +30,7 @@ struct papr_scm_priv {
 	uint64_t block_size;
 	int metadata_size;
 	bool is_volatile;
+	bool disable_map_sync;
 
 	uint64_t bound_addr;
 
@@ -340,11 +341,18 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	ndr_desc.mapping = &mapping;
 	ndr_desc.num_mappings = 1;
 	ndr_desc.nd_set = &p->nd_set;
+	set_bit(ND_REGION_SYNC_ENABLED, &ndr_desc.flags);
 
 	if (p->is_volatile)
 		p->region = nvdimm_volatile_region_create(p->bus, &ndr_desc);
 	else {
 		set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
+		/*
+		 * for a persistent region, check if the platform needs to
+		 * force MAP_SYNC disable.
+		 */
+		if (p->disable_map_sync)
+			clear_bit(ND_REGION_SYNC_ENABLED, &ndr_desc.flags);
 		p->region = nvdimm_pmem_region_create(p->bus, &ndr_desc);
 	}
 	if (!p->region) {
@@ -365,7 +373,7 @@ err:	nvdimm_bus_unregister(p->bus);
 
 static int papr_scm_probe(struct platform_device *pdev)
 {
-	struct device_node *dn = pdev->dev.of_node;
+	struct device_node *dn;
 	u32 drc_index, metadata_size;
 	u64 blocks, block_size;
 	struct papr_scm_priv *p;
@@ -373,6 +381,10 @@ static int papr_scm_probe(struct platform_device *pdev)
 	u64 uuid[2];
 	int rc;
 
+	dn = dev_of_node(&pdev->dev);
+	if (!dn)
+		return -ENXIO;
+
 	/* check we have all the required DT properties */
 	if (of_property_read_u32(dn, "ibm,my-drc-index", &drc_index)) {
 		dev_err(&pdev->dev, "%pOF: missing drc-index!\n", dn);
@@ -402,6 +414,9 @@ static int papr_scm_probe(struct platform_device *pdev)
 	/* optional DT properties */
 	of_property_read_u32(dn, "ibm,metadata-size", &metadata_size);
 
+	if (of_device_is_compatible(dn, "ibm,pmemory-v2"))
+		p->disable_map_sync = true;
+
 	p->dn = dn;
 	p->drc_index = drc_index;
 	p->block_size = block_size;
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 6826a274a1f1..a6cc3488e552 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -59,12 +59,19 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 		ndr_desc.res = &pdev->resource[i];
 		ndr_desc.of_node = np;
 		set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
+		set_bit(ND_REGION_SYNC_ENABLED, &ndr_desc.flags);
 
 		if (is_volatile)
 			region = nvdimm_volatile_region_create(bus, &ndr_desc);
 		else {
 			set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
+			/*
+			 * for a persistent region, check for newer device
+			 */
+			if (of_device_is_compatible(np, "pmem-region-v2"))
+				clear_bit(ND_REGION_SYNC_ENABLED, &ndr_desc.flags);
 			region = nvdimm_pmem_region_create(bus, &ndr_desc);
+
 		}
 
 		if (!region)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

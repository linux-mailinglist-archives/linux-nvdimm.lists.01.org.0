Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186941F4E21
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jun 2020 08:24:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC9B9100A302C;
	Tue,  9 Jun 2020 23:24:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D2007100991A2
	for <linux-nvdimm@lists.01.org>; Tue,  9 Jun 2020 23:24:36 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05A6234o140608;
	Wed, 10 Jun 2020 02:24:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31jkhw2d21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2020 02:24:33 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05A63Ac7144625;
	Wed, 10 Jun 2020 02:24:33 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31jkhw2d1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2020 02:24:32 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05A6Kvig012698;
	Wed, 10 Jun 2020 06:24:31 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by ppma01wdc.us.ibm.com with ESMTP id 31g2s8w8q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2020 06:24:31 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05A6OVAO14287462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2020 06:24:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35314AC05B;
	Wed, 10 Jun 2020 06:24:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 236E5AC05E;
	Wed, 10 Jun 2020 06:24:28 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.58.158])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2020 06:24:27 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v5 09/10] powerpc/pmem: Disable synchronous fault by default
Date: Wed, 10 Jun 2020 11:53:42 +0530
Message-Id: <20200610062343.492293-10-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610062343.492293-1-aneesh.kumar@linux.ibm.com>
References: <20200610062343.492293-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_02:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 priorityscore=1501
 cotscore=-2147483648 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100041
Message-ID-Hash: KMVQSBMKHPGLSLHO4TKBYKBVLDN262DL
X-Message-ID-Hash: KMVQSBMKHPGLSLHO4TKBYKBVLDN262DL
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KMVQSBMKHPGLSLHO4TKBYKBVLDN262DL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds a kernel config option that controls whether MAP_SYNC is enabled by
default. With POWER10, architecture is adding new pmem flush and sync
instructions. The kernel should prevent the usage of MAP_SYNC if applications
are not using the new instructions on newer hardware.

This config allows user to control whether MAP_SYNC should be enabled by
default or not.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/platforms/Kconfig.cputype    |  9 +++++++++
 arch/powerpc/platforms/pseries/papr_scm.c | 17 ++++++++++++++++-
 drivers/nvdimm/of_pmem.c                  |  7 +++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d349603fb889..abcc163b8dc6 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -383,6 +383,15 @@ config PPC_KUEP
 
 	  If you're unsure, say Y.
 
+config ARCH_MAP_SYNC_DISABLE
+	bool "Disable synchronous fault support (MAP_SYNC)"
+	default y
+	help
+	  Disable support for synchronous fault with nvdimm namespaces.
+
+	  If you're unsure, say Y.
+
+
 config PPC_HAVE_KUAP
 	bool
 
diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index ad506e7003c9..b970d2dbe589 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -30,6 +30,7 @@ struct papr_scm_priv {
 	uint64_t block_size;
 	int metadata_size;
 	bool is_volatile;
+	bool disable_map_sync;
 
 	uint64_t bound_addr;
 
@@ -353,11 +354,18 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	ndr_desc.num_mappings = 1;
 	ndr_desc.nd_set = &p->nd_set;
 	ndr_desc.flush = papr_scm_flush_sync;
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
@@ -378,7 +386,7 @@ err:	nvdimm_bus_unregister(p->bus);
 
 static int papr_scm_probe(struct platform_device *pdev)
 {
-	struct device_node *dn = pdev->dev.of_node;
+	struct device_node *dn;
 	u32 drc_index, metadata_size;
 	u64 blocks, block_size;
 	struct papr_scm_priv *p;
@@ -386,6 +394,10 @@ static int papr_scm_probe(struct platform_device *pdev)
 	u64 uuid[2];
 	int rc;
 
+	dn = dev_of_node(&pdev->dev);
+	if (!dn)
+		return -ENXIO;
+
 	/* check we have all the required DT properties */
 	if (of_property_read_u32(dn, "ibm,my-drc-index", &drc_index)) {
 		dev_err(&pdev->dev, "%pOF: missing drc-index!\n", dn);
@@ -415,6 +427,9 @@ static int papr_scm_probe(struct platform_device *pdev)
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

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F3B133BEA
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 07:53:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EBB8A10097DC3;
	Tue,  7 Jan 2020 22:56:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B780C10097DBA
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 22:56:14 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0086qsx7092371;
	Wed, 8 Jan 2020 01:52:55 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xcu57at74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2020 01:52:54 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0086pMKZ025449;
	Wed, 8 Jan 2020 06:52:43 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by ppma01wdc.us.ibm.com with ESMTP id 2xajb6hwk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2020 06:52:43 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0086qZ4q23855418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2020 06:52:36 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8C146A047;
	Wed,  8 Jan 2020 06:52:35 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 805D66A051;
	Wed,  8 Jan 2020 06:52:34 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.204.201.20])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2020 06:52:34 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v3 3/6] libnvdimm/namespace: Validate namespace size when creating new namespace.
Date: Wed,  8 Jan 2020 12:22:16 +0530
Message-Id: <20200108065219.171221-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
References: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_01:2020-01-07,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=902
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=1
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080058
Message-ID-Hash: IABFT3H6PVOFBXKXHUJQMFTAYMT34G7I
X-Message-ID-Hash: IABFT3H6PVOFBXKXHUJQMFTAYMT34G7I
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IABFT3H6PVOFBXKXHUJQMFTAYMT34G7I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Architectures like ppc64 use different page size than PAGE_SIZE to map
direct-map address range. The kernel needs to make sure the namespace size is aligned
correctly for the direct-map page size.

kernel log will contain the below details
[  939.620064] nd namespace0.3: 1071644672 is not 16384K aligned

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/namespace_devs.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 0751fd4b7d4a..8567d8969014 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -891,6 +891,17 @@ static int grow_dpa_allocation(struct nd_region *nd_region,
 	return 0;
 }
 
+static unsigned long nvdimm_validate_namespace_size(struct nd_region *nd_region,
+		unsigned long size, unsigned long align_size)
+{
+	u32 remainder;
+
+	div_u64_rem(size, align_size * nd_region->ndr_mappings, &remainder);
+	if (remainder)
+		return align_size * nd_region->ndr_mappings;
+	return 0;
+}
+
 static void nd_namespace_pmem_set_resource(struct nd_region *nd_region,
 		struct nd_namespace_pmem *nspm, resource_size_t size)
 {
@@ -949,7 +960,8 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 	struct nd_mapping *nd_mapping;
 	struct nvdimm_drvdata *ndd;
 	struct nd_label_id label_id;
-	u32 flags = 0, remainder;
+	unsigned long map_size;
+	u32 flags = 0;
 	int rc, i, id = -1;
 	u8 *uuid = NULL;
 
@@ -980,10 +992,9 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 		return -ENXIO;
 	}
 
-	div_u64_rem(val, PAGE_SIZE * nd_region->ndr_mappings, &remainder);
-	if (remainder) {
-		dev_dbg(dev, "%llu is not %ldK aligned\n", val,
-				(PAGE_SIZE * nd_region->ndr_mappings) / SZ_1K);
+	map_size = nvdimm_validate_namespace_size(nd_region, val, arch_namespace_align_size());
+	if (map_size) {
+		dev_err(dev, "%llu is not %ldK aligned\n", val, map_size / SZ_1K);
 		return -EINVAL;
 	}
 
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8084CA7E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Jun 2019 11:17:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3E98B2129EBA2;
	Thu, 20 Jun 2019 02:17:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C51712129EBA2
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 02:17:26 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5K94a1m146189; Thu, 20 Jun 2019 05:17:14 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t85ymbm00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Jun 2019 05:17:14 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5K94kWQ032608;
 Thu, 20 Jun 2019 09:17:14 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01wdc.us.ibm.com with ESMTP id 2t4ra70ntr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Jun 2019 09:17:14 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5K9HDaN33489158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 09:17:13 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 834BEAE062;
 Thu, 20 Jun 2019 09:17:13 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D4FCAE060;
 Thu, 20 Jun 2019 09:17:12 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.35.143])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 20 Jun 2019 09:17:11 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v4 2/6] mm/nvdimm: Add page size and struct page size to pfn
 superblock
Date: Thu, 20 Jun 2019 14:46:22 +0530
Message-Id: <20190620091626.31824-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620091626.31824-1-aneesh.kumar@linux.ibm.com>
References: <20190620091626.31824-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-20_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200068
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This is needed so that we don't wrongly initialize a namespace
which doesn't have enough space reserved for holding struct pages
with the current kernel.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/pfn.h      |  5 ++++-
 drivers/nvdimm/pfn_devs.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/pfn.h b/drivers/nvdimm/pfn.h
index 7381673b7b70..acb19517f678 100644
--- a/drivers/nvdimm/pfn.h
+++ b/drivers/nvdimm/pfn.h
@@ -29,7 +29,10 @@ struct nd_pfn_sb {
 	/* minor-version-2 record the base alignment of the mapping */
 	__le32 align;
 	/* minor-version-3 guarantee the padding and flags are zero */
-	u8 padding[4000];
+	/* minor-version-4 record the page size and struct page size */
+	__le32 page_size;
+	__le16 page_struct_size;
+	u8 padding[3994];
 	__le64 checksum;
 };
 
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 2537aa338bd0..cd722de0ae03 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -460,6 +460,15 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 	if (__le16_to_cpu(pfn_sb->version_minor) < 2)
 		pfn_sb->align = 0;
 
+	if (__le16_to_cpu(pfn_sb->version_minor) < 4) {
+		/*
+		 * For a large part we use PAGE_SIZE. But we
+		 * do have some accounting code using SZ_4K.
+		 */
+		pfn_sb->page_struct_size = cpu_to_le16(64);
+		pfn_sb->page_size = cpu_to_le32(PAGE_SIZE);
+	}
+
 	switch (le32_to_cpu(pfn_sb->mode)) {
 	case PFN_MODE_RAM:
 	case PFN_MODE_PMEM:
@@ -475,6 +484,20 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		align = 1UL << ilog2(offset);
 	mode = le32_to_cpu(pfn_sb->mode);
 
+	if (le32_to_cpu(pfn_sb->page_size) != PAGE_SIZE) {
+		dev_err(&nd_pfn->dev,
+			"init failed, page size mismatch %d\n",
+			le32_to_cpu(pfn_sb->page_size));
+		return -EOPNOTSUPP;
+	}
+
+	if (le16_to_cpu(pfn_sb->page_struct_size) != sizeof(struct page)) {
+		dev_err(&nd_pfn->dev,
+			"init failed, struct page size mismatch %d\n",
+			le16_to_cpu(pfn_sb->page_struct_size));
+		return -EOPNOTSUPP;
+	}
+
 	if (!nd_pfn->uuid) {
 		/*
 		 * When probing a namepace via nd_pfn_probe() the uuid
@@ -723,8 +746,10 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	memcpy(pfn_sb->uuid, nd_pfn->uuid, 16);
 	memcpy(pfn_sb->parent_uuid, nd_dev_to_uuid(&ndns->dev), 16);
 	pfn_sb->version_major = cpu_to_le16(1);
-	pfn_sb->version_minor = cpu_to_le16(3);
+	pfn_sb->version_minor = cpu_to_le16(4);
 	pfn_sb->align = cpu_to_le32(nd_pfn->align);
+	pfn_sb->page_struct_size = cpu_to_le16(sizeof(struct page));
+	pfn_sb->page_size = cpu_to_le32(PAGE_SIZE);
 	checksum = nd_sb_checksum((struct nd_gen_sb *) pfn_sb);
 	pfn_sb->checksum = cpu_to_le64(checksum);
 
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

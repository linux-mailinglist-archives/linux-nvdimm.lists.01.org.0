Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D00142CD6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jan 2020 15:08:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C785B10097DC1;
	Mon, 20 Jan 2020 06:11:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 87BD510097DBA
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 06:11:36 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KE3CjJ147323;
	Mon, 20 Jan 2020 09:08:16 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgh9u0ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 09:08:16 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00KE64LO042717;
	Mon, 20 Jan 2020 09:08:16 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgh9u0kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 09:08:15 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00KE4sdG000641;
	Mon, 20 Jan 2020 14:08:15 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma03wdc.us.ibm.com with ESMTP id 2xksn5u7xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 14:08:15 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KE8EH163308144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2020 14:08:14 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F756BE051;
	Mon, 20 Jan 2020 14:08:14 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C9F8BE04F;
	Mon, 20 Jan 2020 14:08:12 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.71.225])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2020 14:08:12 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, jmoyer@redhat.com
Subject: [PATCH v4 4/6] libnvdimm/namespace: Validate namespace size when creating a new namespace.
Date: Mon, 20 Jan 2020 19:37:47 +0530
Message-Id: <20200120140749.69549-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
References: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200122
Message-ID-Hash: CHZ37JRN55CPU2FLLD23PGJ6SO2FTBXH
X-Message-ID-Hash: CHZ37JRN55CPU2FLLD23PGJ6SO2FTBXH
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CHZ37JRN55CPU2FLLD23PGJ6SO2FTBXH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Kernel should validate the namespace size against SUBSECTION_SIZE rather than
PAGE_SIZE. blk namespace continues to use old rule so that the new kernel don't
break the creation of blk namespaces.

Use the new helper arch_namespace_align_size() so that architecture specific
restrictions are also taken care of.

kernel log will contain the below details
[  939.620064] nd namespace0.3: 1071644672 is not 16384K aligned

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/namespace_devs.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 0e2c90730ce3..e318566ae135 100644
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
@@ -945,11 +956,13 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 {
 	resource_size_t allocated = 0, available = 0;
 	struct nd_region *nd_region = to_nd_region(dev->parent);
+	unsigned long align_size = arch_namespace_align_size();
 	struct nd_namespace_common *ndns = to_ndns(dev);
 	struct nd_mapping *nd_mapping;
 	struct nvdimm_drvdata *ndd;
 	struct nd_label_id label_id;
-	u32 flags = 0, remainder;
+	unsigned long map_size;
+	u32 flags = 0;
 	int rc, i, id = -1;
 	u8 *uuid = NULL;
 
@@ -967,6 +980,8 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 		uuid = nsblk->uuid;
 		flags = NSLABEL_FLAG_LOCAL;
 		id = nsblk->id;
+		/* Let's not break blk region */
+		align_size = PAGE_SIZE;
 	}
 
 	/*
@@ -980,10 +995,9 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 		return -ENXIO;
 	}
 
-	div_u64_rem(val, PAGE_SIZE * nd_region->ndr_mappings, &remainder);
-	if (remainder) {
-		dev_dbg(dev, "%llu is not %ldK aligned\n", val,
-				(PAGE_SIZE * nd_region->ndr_mappings) / SZ_1K);
+	map_size = nvdimm_validate_namespace_size(nd_region, val, align_size);
+	if (map_size) {
+		dev_err(dev, "%llu is not %ldK aligned\n", val, map_size / SZ_1K);
 		return -EINVAL;
 	}
 
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C910C525
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Nov 2019 09:31:41 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD0D7101134ED;
	Thu, 28 Nov 2019 00:35:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7BCD3101134EB
	for <linux-nvdimm@lists.01.org>; Thu, 28 Nov 2019 00:35:00 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAS8MJbX006933;
	Thu, 28 Nov 2019 03:31:36 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2whh5fbt87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2019 03:31:35 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAS8UCuu012749;
	Thu, 28 Nov 2019 08:31:35 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by ppma05wdc.us.ibm.com with ESMTP id 2wevd7c1ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2019 08:31:35 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAS8VVQi45809932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2019 08:31:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB7BAC059;
	Thu, 28 Nov 2019 08:31:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7893AC05E;
	Thu, 28 Nov 2019 08:31:23 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.39.131])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 28 Nov 2019 08:31:23 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v2 3/6] libnvdimm/namespace: Validate namespace size when creating new namespace.
Date: Thu, 28 Nov 2019 14:00:54 +0530
Message-Id: <20191128083057.141425-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128083057.141425-1-aneesh.kumar@linux.ibm.com>
References: <20191128083057.141425-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=835
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=1 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280071
Message-ID-Hash: 3XWT4DXUFN22I5JBPEUJUEZNBAVLIDHR
X-Message-ID-Hash: 3XWT4DXUFN22I5JBPEUJUEZNBAVLIDHR
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3XWT4DXUFN22I5JBPEUJUEZNBAVLIDHR/>
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
index d77d9c9e449d..0e4c04765cb8 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -917,6 +917,17 @@ static int grow_dpa_allocation(struct nd_region *nd_region,
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
@@ -975,7 +986,8 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 	struct nd_mapping *nd_mapping;
 	struct nvdimm_drvdata *ndd;
 	struct nd_label_id label_id;
-	u32 flags = 0, remainder;
+	unsigned long map_size;
+	u32 flags = 0;
 	int rc, i, id = -1;
 	u8 *uuid = NULL;
 
@@ -1006,10 +1018,9 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
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
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

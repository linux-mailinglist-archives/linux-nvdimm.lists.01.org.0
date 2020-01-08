Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0C133BEB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 07:53:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C69110097DC6;
	Tue,  7 Jan 2020 22:56:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3BEB110097DC7
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 22:56:26 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0086r6tl016407;
	Wed, 8 Jan 2020 01:53:06 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xb9514k64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2020 01:53:06 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0086pHOA020127;
	Wed, 8 Jan 2020 06:52:35 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma04dal.us.ibm.com with ESMTP id 2xajb6tc0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2020 06:52:35 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0086qYBZ64618792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2020 06:52:34 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6A676A054;
	Wed,  8 Jan 2020 06:52:33 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6404C6A047;
	Wed,  8 Jan 2020 06:52:32 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.204.201.20])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2020 06:52:32 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v3 2/6] libnvdimm/namespace: Validate namespace start addr and size
Date: Wed,  8 Jan 2020 12:22:15 +0530
Message-Id: <20200108065219.171221-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
References: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_01:2020-01-07,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=935 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=1 mlxscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080058
Message-ID-Hash: XAZPSPIXWD5VF7FTDFXWEMAKTDEG57UI
X-Message-ID-Hash: XAZPSPIXWD5VF7FTDFXWEMAKTDEG57UI
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XAZPSPIXWD5VF7FTDFXWEMAKTDEG57UI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Make sure namespace start addr and size are properly aligned as per architecture
restrictions. If the namespace is not aligned we mark the namespace 'disabled'

Architectures like ppc64 use different page size than PAGE_SIZE to map
direct-map address range. The kernel needs to make sure the namespace size is aligned
correctly for the direct-map page size.

kernel log will contain information as below.

[    5.810939] nd_pmem namespace0.1: invalid size/SPA
[    5.810969] nd_pmem: probe of namespace0.1 failed with error -95

and the namespace will be marked 'disabled'

  {
    "dev":"namespace0.1",
    "mode":"fsdax",
    "map":"mem",
    "size":1071644672,
    "uuid":"25577a00-c012-421d-89ca-3ee189e08848",
    "sector_size":512,
    "state":"disabled"
  },

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/namespace_devs.c | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 032dc61725ff..0751fd4b7d4a 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1113,6 +1113,40 @@ resource_size_t nvdimm_namespace_capacity(struct nd_namespace_common *ndns)
 }
 EXPORT_SYMBOL(nvdimm_namespace_capacity);
 
+static bool nvdimm_valid_namespace(struct nd_namespace_common *ndns, resource_size_t size)
+{
+	struct device *dev = &ndns->dev;
+	struct nd_region *nd_region = to_nd_region(dev->parent);
+	unsigned long align_size = arch_namespace_align_size();
+	struct resource *res;
+	u32 remainder;
+
+	if (is_namespace_blk(dev))
+		return true;
+
+	div_u64_rem(size, align_size * nd_region->ndr_mappings, &remainder);
+	if (remainder)
+		return false;
+
+	if (is_namespace_pmem(dev)) {
+		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
+
+		res = &nspm->nsio.res;
+	} else if (is_namespace_io(dev)) {
+		struct nd_namespace_io *nsio = to_nd_namespace_io(dev);
+
+		res = &nsio->res;
+	} else
+		/* cannot reach */
+		return false;
+
+	div_u64_rem(res->start, align_size * nd_region->ndr_mappings, &remainder);
+	if (remainder)
+		return false;
+
+	return true;
+}
+
 bool nvdimm_namespace_locked(struct nd_namespace_common *ndns)
 {
 	int i;
@@ -1739,6 +1773,11 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 		return ERR_PTR(-ENODEV);
 	}
 
+	if (!nvdimm_valid_namespace(ndns, size)) {
+		dev_err(&ndns->dev, "invalid size/SPA");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	if (is_namespace_pmem(&ndns->dev)) {
 		struct nd_namespace_pmem *nspm;
 
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

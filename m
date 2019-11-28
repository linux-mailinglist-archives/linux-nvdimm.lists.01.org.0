Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6242510C523
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Nov 2019 09:31:27 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1CCB101134E9;
	Thu, 28 Nov 2019 00:34:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3D0A6101134E8
	for <linux-nvdimm@lists.01.org>; Thu, 28 Nov 2019 00:34:47 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAS8MEA6026260;
	Thu, 28 Nov 2019 03:31:23 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2whmt0d8p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2019 03:31:23 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAS8UBTJ001015;
	Thu, 28 Nov 2019 08:31:22 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by ppma03wdc.us.ibm.com with ESMTP id 2wevd6v14u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2019 08:31:22 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAS8VLMY37945688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2019 08:31:22 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEA66AC060;
	Thu, 28 Nov 2019 08:31:21 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24115AC059;
	Thu, 28 Nov 2019 08:31:16 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.39.131])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 28 Nov 2019 08:31:14 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v2 2/6] libnvdimm/namespace: Validate namespace start addr and size
Date: Thu, 28 Nov 2019 14:00:53 +0530
Message-Id: <20191128083057.141425-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128083057.141425-1-aneesh.kumar@linux.ibm.com>
References: <20191128083057.141425-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=832 bulkscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 spamscore=0 suspectscore=1 mlxscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280071
Message-ID-Hash: E7WTHVPKNMKWWNLCMKN7Q7DV2V5U5QN5
X-Message-ID-Hash: E7WTHVPKNMKWWNLCMKN7Q7DV2V5U5QN5
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E7WTHVPKNMKWWNLCMKN7Q7DV2V5U5QN5/>
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
index cca0a3ba1d2c..d77d9c9e449d 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1139,6 +1139,40 @@ resource_size_t nvdimm_namespace_capacity(struct nd_namespace_common *ndns)
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
@@ -1735,6 +1769,11 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
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
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

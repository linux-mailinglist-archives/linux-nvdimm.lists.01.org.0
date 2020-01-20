Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEB142CD4
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jan 2020 15:08:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F7F410097DB1;
	Mon, 20 Jan 2020 06:11:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D762810097DAB
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 06:11:31 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KE3HN5135348;
	Mon, 20 Jan 2020 09:08:11 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg37u0g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 09:08:11 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00KE3VDB136855;
	Mon, 20 Jan 2020 09:08:11 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg37u0fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 09:08:10 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00KE6uXu003131;
	Mon, 20 Jan 2020 14:08:10 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by ppma02dal.us.ibm.com with ESMTP id 2xksn6g21n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 14:08:10 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KE89dw51052948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2020 14:08:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB783BE05B;
	Mon, 20 Jan 2020 14:08:08 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D823FBE053;
	Mon, 20 Jan 2020 14:08:06 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.71.225])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2020 14:08:06 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, jmoyer@redhat.com
Subject: [PATCH v4 2/6] libnvdimm/namespace: Validate namespace start addr and size
Date: Mon, 20 Jan 2020 19:37:45 +0530
Message-Id: <20200120140749.69549-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
References: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001200122
Message-ID-Hash: TUJ3LWM6OWQEP6G3VLABI43O7O6CA5G4
X-Message-ID-Hash: TUJ3LWM6OWQEP6G3VLABI43O7O6CA5G4
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TUJ3LWM6OWQEP6G3VLABI43O7O6CA5G4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Make sure namespace start addr and size are properly aligned as per architecture
restrictions. If the namespace is not aligned kernel mark the namespace 'disabled'

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
 drivers/nvdimm/namespace_devs.c | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 032dc61725ff..0e2c90730ce3 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1113,6 +1113,51 @@ resource_size_t nvdimm_namespace_capacity(struct nd_namespace_common *ndns)
 }
 EXPORT_SYMBOL(nvdimm_namespace_capacity);
 
+static bool nvdimm_valid_namespace(struct device *dev,
+		struct nd_namespace_common *ndns, resource_size_t size)
+{
+	struct device *ndns_dev = &ndns->dev;
+	struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
+	unsigned long map_size = arch_namespace_map_size();
+	struct resource *res;
+	u32 remainder;
+
+	/*
+	 * Don't validate the start and size for blk namespace type
+	 */
+	if (is_namespace_blk(ndns_dev))
+		return true;
+
+	/*
+	 * For btt and raw namespace kernel use ioremap. Assume both can work
+	 * with PAGE_SIZE alignment.
+	 */
+	if (is_nd_btt(dev) || is_namespace_io(ndns_dev))
+		map_size = PAGE_SIZE;
+
+	div_u64_rem(size, map_size * nd_region->ndr_mappings, &remainder);
+	if (remainder)
+		return false;
+
+	if (is_namespace_pmem(ndns_dev)) {
+		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(ndns_dev);
+
+		res = &nspm->nsio.res;
+	} else if (is_namespace_io(ndns_dev)) {
+		struct nd_namespace_io *nsio = to_nd_namespace_io(ndns_dev);
+
+		res = &nsio->res;
+	} else
+		/* cannot reach */
+		return false;
+
+	div_u64_rem(res->start, map_size * nd_region->ndr_mappings, &remainder);
+	if (remainder)
+		return false;
+
+	return true;
+}
+
 bool nvdimm_namespace_locked(struct nd_namespace_common *ndns)
 {
 	int i;
@@ -1739,6 +1784,11 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 		return ERR_PTR(-ENODEV);
 	}
 
+	if (!nvdimm_valid_namespace(dev, ndns, size)) {
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

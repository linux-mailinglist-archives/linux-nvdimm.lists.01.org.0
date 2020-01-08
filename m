Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68236133BE9
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 07:52:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C7E6710097DBE;
	Tue,  7 Jan 2020 22:56:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0980710097DAD
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 22:56:13 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0086qqEN180087;
	Wed, 8 Jan 2020 01:52:53 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2xctgqedem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2020 01:52:52 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0086pG6I021550;
	Wed, 8 Jan 2020 06:52:39 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma02dal.us.ibm.com with ESMTP id 2xajb72ah9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2020 06:52:39 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0086qcen52363758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2020 06:52:38 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A7C06A047;
	Wed,  8 Jan 2020 06:52:38 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87F3E6A04D;
	Wed,  8 Jan 2020 06:52:36 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.204.201.20])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2020 06:52:36 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v3 4/6] libnvdimm/namespace: Add debug check while initializing namespace resource size.
Date: Wed,  8 Jan 2020 12:22:17 +0530
Message-Id: <20200108065219.171221-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
References: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_01:2020-01-07,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=1 mlxscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080058
Message-ID-Hash: SMAYHEFCYLTOJDDPPO4Y2Q5EWBCSI46K
X-Message-ID-Hash: SMAYHEFCYLTOJDDPPO4Y2Q5EWBCSI46K
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMAYHEFCYLTOJDDPPO4Y2Q5EWBCSI46K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This should enable us to catch if we are initializing the namespace with a wrong
size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/namespace_devs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 8567d8969014..99e6140bb19d 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -941,6 +941,18 @@ static void nd_namespace_pmem_set_resource(struct nd_region *nd_region,
  out:
 	res->start = nd_region->ndr_start + offset;
 	res->end = res->start + size - 1;
+#ifdef CONFIG_DEBUG_VM
+	if (size) {
+		unsigned long map_size;
+
+		map_size = nvdimm_validate_namespace_size(nd_region, size, arch_namespace_align_size());
+		WARN_ON(map_size);
+
+		map_size = nvdimm_validate_namespace_size(nd_region, res->start, arch_namespace_align_size());
+		WARN_ON(map_size);
+
+	}
+#endif
 }
 
 static bool uuid_not_set(const u8 *uuid, struct device *dev, const char *where)
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

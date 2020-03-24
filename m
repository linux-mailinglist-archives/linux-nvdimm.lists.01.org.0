Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C581903F1
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 04:48:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BBEB10FC388D;
	Mon, 23 Mar 2020 20:49:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E2CB810FC363F
	for <linux-nvdimm@lists.01.org>; Mon, 23 Mar 2020 20:49:24 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O3Xrmc014710;
	Mon, 23 Mar 2020 23:48:31 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuuwyy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2020 23:48:31 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02O3ljDW027176;
	Tue, 24 Mar 2020 03:48:30 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by ppma04dal.us.ibm.com with ESMTP id 2ywawfjwr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2020 03:48:30 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02O3mTYu13763264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 03:48:29 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93642112063;
	Tue, 24 Mar 2020 03:48:29 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AFEF112061;
	Tue, 24 Mar 2020 03:48:28 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.71.202])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2020 03:48:28 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v3] libnvdimm: Update persistence domain value for of_pmem and papr_scm device
Date: Tue, 24 Mar 2020 09:18:21 +0530
Message-Id: <20200324034821.60869-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_10:2020-03-23,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240015
Message-ID-Hash: EPS33ILM37OOZQ4UBWXESKLHGXDLAPIA
X-Message-ID-Hash: EPS33ILM37OOZQ4UBWXESKLHGXDLAPIA
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EPS33ILM37OOZQ4UBWXESKLHGXDLAPIA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently, kernel shows the below values
	"persistence_domain":"cpu_cache"
	"persistence_domain":"memory_controller"
	"persistence_domain":"unknown"

"cpu_cache" indicates no extra instructions is needed to ensure the persistence
of data in the pmem media on power failure.

"memory_controller" indicates cpu cache flush instructions are required to flush
the data. Platform provides mechanisms to automatically flush outstanding
write data from memory controler to pmem on system power loss.

Based on the above use memory_controller for non volatile regions on ppc64.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
Changes from V1:
* update commit message and retain ADR details in comment

 arch/powerpc/platforms/pseries/papr_scm.c | 4 +++-
 drivers/nvdimm/of_pmem.c                  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 0b4467e378e5..922a4fc3b61b 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -361,8 +361,10 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 
 	if (p->is_volatile)
 		p->region = nvdimm_volatile_region_create(p->bus, &ndr_desc);
-	else
+	else {
+		set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
 		p->region = nvdimm_pmem_region_create(p->bus, &ndr_desc);
+	}
 	if (!p->region) {
 		dev_err(dev, "Error registering region %pR from %pOF\n",
 				ndr_desc.res, p->dn);
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 8224d1431ea9..6826a274a1f1 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -62,8 +62,10 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 
 		if (is_volatile)
 			region = nvdimm_volatile_region_create(bus, &ndr_desc);
-		else
+		else {
+			set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
 			region = nvdimm_pmem_region_create(bus, &ndr_desc);
+		}
 
 		if (!region)
 			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
-- 
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

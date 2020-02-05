Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CB41525D0
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 06:21:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 407D41007B1FE;
	Tue,  4 Feb 2020 21:24:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E433F1007B1FC
	for <linux-nvdimm@lists.01.org>; Tue,  4 Feb 2020 21:24:35 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0155ElM4107351;
	Wed, 5 Feb 2020 00:21:16 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn2928j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2020 00:21:16 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0155GIZP015540;
	Wed, 5 Feb 2020 05:21:15 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma03dal.us.ibm.com with ESMTP id 2xykc9aapj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2020 05:21:15 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0155LEC651446124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2020 05:21:14 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F34C8C605A;
	Wed,  5 Feb 2020 05:21:13 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45CAFC6061;
	Wed,  5 Feb 2020 05:21:12 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.204.201.20])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2020 05:21:11 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v2] libnvdimm: Update persistence domain value for of_pmem and papr_scm device
Date: Wed,  5 Feb 2020 10:50:56 +0530
Message-Id: <20200205052056.74604-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_09:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=1 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002050042
Message-ID-Hash: IN5BGSJIGBFAH4XNYCU5WRL63SG4WRUG
X-Message-ID-Hash: IN5BGSJIGBFAH4XNYCU5WRL63SG4WRUG
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IN5BGSJIGBFAH4XNYCU5WRL63SG4WRUG/>
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

"memory_controller" indicates platform provided instructions need to be issued
as per documented sequence to make sure data get flushed so that it is
guaranteed to be on pmem media in case of system power loss.

Based on the above use memory_controller for non volatile regions on ppc64.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 7 ++++++-
 drivers/nvdimm/of_pmem.c                  | 4 +++-
 include/linux/libnvdimm.h                 | 1 -
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 7525635a8536..ffcd0d7a867c 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -359,8 +359,13 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 
 	if (p->is_volatile)
 		p->region = nvdimm_volatile_region_create(p->bus, &ndr_desc);
-	else
+	else {
+		/*
+		 * We need to flush things correctly to guarantee persistance
+		 */
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
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 0f366706b0aa..771d888a5ed7 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -54,7 +54,6 @@ enum {
 	/*
 	 * Platform provides mechanisms to automatically flush outstanding
 	 * write data from memory controler to pmem on system power loss.
-	 * (ADR)
 	 */
 	ND_REGION_PERSIST_MEMCTRL = 2,
 
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

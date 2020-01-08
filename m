Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84BC133BE5
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 07:49:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 42A8A10097DA7;
	Tue,  7 Jan 2020 22:52:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 934FF10097E17
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 22:52:38 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0086lVmX140152;
	Wed, 8 Jan 2020 01:49:15 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2xctgqeb1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2020 01:49:15 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0086k02K006811;
	Wed, 8 Jan 2020 06:49:15 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma05wdc.us.ibm.com with ESMTP id 2xajb69xc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2020 06:49:14 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0086nD3u50790878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2020 06:49:13 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A29C16E04E;
	Wed,  8 Jan 2020 06:49:13 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 094A36E04C;
	Wed,  8 Jan 2020 06:49:11 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.204.201.20])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2020 06:49:11 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [RFC PATCH] libnvdimm: Update the meaning for persistence_domain values
Date: Wed,  8 Jan 2020 12:19:05 +0530
Message-Id: <20200108064905.170394-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_01:2020-01-07,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=1 mlxscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080057
Message-ID-Hash: 4WY42ZCATFVUMGRTJEYLHCCWDUFLPC67
X-Message-ID-Hash: 4WY42ZCATFVUMGRTJEYLHCCWDUFLPC67
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4WY42ZCATFVUMGRTJEYLHCCWDUFLPC67/>
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

This patch updates the meaning of these values such that

"cpu_cache" indicates no extra instructions is needed to ensure the persistence
of data in the pmem media on power failure.

"memory_controller" indicates platform provided instructions need to be issued
as per documented sequence to make sure data flushed is guaranteed to be on pmem
media in case of system power loss.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 7 ++++++-
 include/linux/libnvdimm.h                 | 6 +++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index c2ef320ba1bf..26a5ef263758 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -360,8 +360,13 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 
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
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index f2a33f2e3ba8..9126737377e1 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -52,9 +52,9 @@ enum {
 	 */
 	ND_REGION_PERSIST_CACHE = 1,
 	/*
-	 * Platform provides mechanisms to automatically flush outstanding
-	 * write data from memory controler to pmem on system power loss.
-	 * (ADR)
+	 * Platform provides instructions to flush data such that on completion
+	 * of the instructions, data flushed is guaranteed to be on pmem even
+	 * in case of a system power loss.
 	 */
 	ND_REGION_PERSIST_MEMCTRL = 2,
 
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2C5210504
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 09:28:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8A4B01143B073;
	Wed,  1 Jul 2020 00:28:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B14C1143B072
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jul 2020 00:28:54 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06173YU2145041;
	Wed, 1 Jul 2020 03:28:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31ycjarj9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 03:28:48 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0617Saw8022459;
	Wed, 1 Jul 2020 03:28:39 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31ycjarhah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 03:28:39 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0617Fv11027185;
	Wed, 1 Jul 2020 07:23:51 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma04dal.us.ibm.com with ESMTP id 31wwr95phs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 07:23:51 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0617NoM253215568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2020 07:23:50 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DE4513605E;
	Wed,  1 Jul 2020 07:23:50 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10743136063;
	Wed,  1 Jul 2020 07:23:47 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.79.220.179])
	by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2020 07:23:46 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v7 6/7] powerpc/pmem: Avoid the barrier in flush routines
Date: Wed,  1 Jul 2020 12:52:34 +0530
Message-Id: <20200701072235.223558-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701072235.223558-1-aneesh.kumar@linux.ibm.com>
References: <20200701072235.223558-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=930 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 cotscore=-2147483648 bulkscore=0 clxscore=1015 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010050
Message-ID-Hash: LURU5YTSWIYU5GJZEWIS3MPHV4QOGHVZ
X-Message-ID-Hash: LURU5YTSWIYU5GJZEWIS3MPHV4QOGHVZ
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LURU5YTSWIYU5GJZEWIS3MPHV4QOGHVZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

nvdimm expect the flush routines to just mark the cache clean. The barrier
that mark the store globally visible is done in nvdimm_flush().

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/lib/pmem.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
index 5a61aaeb6930..21210fa676e5 100644
--- a/arch/powerpc/lib/pmem.c
+++ b/arch/powerpc/lib/pmem.c
@@ -19,9 +19,6 @@ static inline void __clean_pmem_range(unsigned long start, unsigned long stop)
 
 	for (i = 0; i < size >> shift; i++, addr += bytes)
 		asm volatile(PPC_DCBSTPS(%0, %1): :"i"(0), "r"(addr): "memory");
-
-
-	asm volatile(PPC_PHWSYNC ::: "memory");
 }
 
 static inline void __flush_pmem_range(unsigned long start, unsigned long stop)
@@ -34,9 +31,6 @@ static inline void __flush_pmem_range(unsigned long start, unsigned long stop)
 
 	for (i = 0; i < size >> shift; i++, addr += bytes)
 		asm volatile(PPC_DCBFPS(%0, %1): :"i"(0), "r"(addr): "memory");
-
-
-	asm volatile(PPC_PHWSYNC ::: "memory");
 }
 
 static inline void clean_pmem_range(unsigned long start, unsigned long stop)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

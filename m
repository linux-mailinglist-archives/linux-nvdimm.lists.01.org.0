Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFF61D0595
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 May 2020 05:48:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2CA7111AC81FE;
	Tue, 12 May 2020 20:45:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B436911AC81FB
	for <linux-nvdimm@lists.01.org>; Tue, 12 May 2020 20:45:21 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D3X7To003825;
	Tue, 12 May 2020 23:47:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3101m6k9c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2020 23:47:47 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04D3XQRe004886;
	Tue, 12 May 2020 23:47:46 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3101m6k9bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2020 23:47:46 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04D3eYwt021122;
	Wed, 13 May 2020 03:47:45 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by ppma01dal.us.ibm.com with ESMTP id 3100ubc9wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2020 03:47:45 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04D3lhsI28574170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2020 03:47:43 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC11D6A04F;
	Wed, 13 May 2020 03:47:43 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D9876A047;
	Wed, 13 May 2020 03:47:40 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.102.3.92])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2020 03:47:40 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org
Subject: [PATCH v2 1/5] powerpc/pmem: Add new instructions for persistent storage and sync
Date: Wed, 13 May 2020 09:17:01 +0530
Message-Id: <20200513034705.172983-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_08:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=999 adultscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130026
Message-ID-Hash: 5MTFNHSV6LF3KCWGVO35VIDG6WNVXJNP
X-Message-ID-Hash: 5MTFNHSV6LF3KCWGVO35VIDG6WNVXJNP
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alistair@popple.id.au, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5MTFNHSV6LF3KCWGVO35VIDG6WNVXJNP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

POWER10 introduces two new variants of dcbf instructions (dcbstps and dcbfps)
that can be used to write modified locations back to persistent storage.

Additionally, POWER10 also introduce phwsync and plwsync which can be used
to establish order of these writes to persistent storage.

This patch exposes these instructions to the rest of the kernel. The existing
dcbf and hwsync instructions in P9 are adequate to enable appropriate
synchronization with OpenCAPI-hosted persistent storage. Hence the new
instructions are added as a variant of the old ones that old hardware
won't differentiate.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index c1df75edde44..45eccd842f84 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -216,6 +216,8 @@
 #define PPC_INST_STWCX			0x7c00012d
 #define PPC_INST_LWSYNC			0x7c2004ac
 #define PPC_INST_SYNC			0x7c0004ac
+#define PPC_INST_PHWSYNC		0x7c8004ac
+#define PPC_INST_PLWSYNC		0x7ca004ac
 #define PPC_INST_SYNC_MASK		0xfc0007fe
 #define PPC_INST_ISYNC			0x4c00012c
 #define PPC_INST_LXVD2X			0x7c000698
@@ -281,6 +283,8 @@
 #define PPC_INST_TABORT			0x7c00071d
 #define PPC_INST_TSR			0x7c0005dd
 
+#define PPC_INST_DCBF			0x7c0000ac
+
 #define PPC_INST_NAP			0x4c000364
 #define PPC_INST_SLEEP			0x4c0003a4
 #define PPC_INST_WINKLE			0x4c0003e4
@@ -529,6 +533,14 @@
 #define STBCIX(s,a,b)		stringify_in_c(.long PPC_INST_STBCIX | \
 				       __PPC_RS(s) | __PPC_RA(a) | __PPC_RB(b))
 
+#define	PPC_DCBFPS(a, b)	stringify_in_c(.long PPC_INST_DCBF |	\
+				       ___PPC_RA(a) | ___PPC_RB(b) | (4 << 21))
+#define	PPC_DCBSTPS(a, b)	stringify_in_c(.long PPC_INST_DCBF |	\
+				       ___PPC_RA(a) | ___PPC_RB(b) | (6 << 21))
+
+#define	PPC_PHWSYNC		stringify_in_c(.long PPC_INST_PHWSYNC)
+#define	PPC_PLWSYNC		stringify_in_c(.long PPC_INST_PLWSYNC)
+
 /*
  * Define what the VSX XX1 form instructions will look like, then add
  * the 128 bit load store instructions based on that.
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

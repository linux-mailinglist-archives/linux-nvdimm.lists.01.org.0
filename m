Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B35C20CEF2
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 15:57:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D1D69111AFBBA;
	Mon, 29 Jun 2020 06:57:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EFD4D1118BAE6
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 06:57:54 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TDXtaP086596;
	Mon, 29 Jun 2020 09:57:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ydk914r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 09:57:50 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TDY28s086982;
	Mon, 29 Jun 2020 09:57:49 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ydk914qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 09:57:49 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TDsKnB009467;
	Mon, 29 Jun 2020 13:57:48 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by ppma05wdc.us.ibm.com with ESMTP id 31wwr8fr82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 13:57:48 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TDvm1i37880296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2020 13:57:48 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0306FAE064;
	Mon, 29 Jun 2020 13:57:48 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ABE3AE05F;
	Mon, 29 Jun 2020 13:57:44 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.77.197.62])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2020 13:57:44 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v6 2/8] powerpc/pmem: Add new instructions for persistent storage and sync
Date: Mon, 29 Jun 2020 19:27:16 +0530
Message-Id: <20200629135722.73558-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 cotscore=-2147483648
 impostorscore=0 spamscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290091
Message-ID-Hash: 5QCTPLLAZ2MTIKZO3H52SGYMLXYJPV6A
X-Message-ID-Hash: 5QCTPLLAZ2MTIKZO3H52SGYMLXYJPV6A
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5QCTPLLAZ2MTIKZO3H52SGYMLXYJPV6A/>
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
dcbf and hwsync instructions in P8 and P9 are adequate to enable appropriate
synchronization with OpenCAPI-hosted persistent storage. Hence the new
instructions are added as a variant of the old ones that old hardware
won't differentiate.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 2a39c716c343..1ad014e4633e 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -219,6 +219,8 @@
 #define PPC_INST_STWCX			0x7c00012d
 #define PPC_INST_LWSYNC			0x7c2004ac
 #define PPC_INST_SYNC			0x7c0004ac
+#define PPC_INST_PHWSYNC		0x7c8004ac
+#define PPC_INST_PLWSYNC		0x7ca004ac
 #define PPC_INST_SYNC_MASK		0xfc0007fe
 #define PPC_INST_ISYNC			0x4c00012c
 #define PPC_INST_LXVD2X			0x7c000698
@@ -284,6 +286,8 @@
 #define PPC_INST_TABORT			0x7c00071d
 #define PPC_INST_TSR			0x7c0005dd
 
+#define PPC_INST_DCBF			0x7c0000ac
+
 #define PPC_INST_NAP			0x4c000364
 #define PPC_INST_SLEEP			0x4c0003a4
 #define PPC_INST_WINKLE			0x4c0003e4
@@ -532,6 +536,14 @@
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

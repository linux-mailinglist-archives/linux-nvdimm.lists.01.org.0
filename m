Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A551D8FA0
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 May 2020 07:55:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B867711EA6785;
	Mon, 18 May 2020 22:52:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8809611EA6781
	for <linux-nvdimm@lists.01.org>; Mon, 18 May 2020 22:52:15 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04J5Weml148298;
	Tue, 19 May 2020 01:55:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312wshjvec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 01:55:24 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04J5X6OR149340;
	Tue, 19 May 2020 01:55:24 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312wshjve1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 01:55:24 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04J5sTFL005337;
	Tue, 19 May 2020 05:55:23 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma04dal.us.ibm.com with ESMTP id 313wjy7muf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 05:55:23 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04J5tLXf7864828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2020 05:55:21 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 147D17805F;
	Tue, 19 May 2020 05:55:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 670377805C;
	Tue, 19 May 2020 05:55:19 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.81.200])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2020 05:55:19 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org
Subject: [PATCH v3 3/7] powerpc/pmem: Add flush routines using new pmem store and sync instruction
Date: Tue, 19 May 2020 11:24:58 +0530
Message-Id: <20200519055502.128318-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519055502.128318-1-aneesh.kumar@linux.ibm.com>
References: <20200519055502.128318-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_01:2020-05-15,2020-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 cotscore=-2147483648 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005190048
Message-ID-Hash: EMW7XYKN6ZEOQXMLEPVULJXUZL5ONC2R
X-Message-ID-Hash: EMW7XYKN6ZEOQXMLEPVULJXUZL5ONC2R
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alistair@popple.id.au, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EMW7XYKN6ZEOQXMLEPVULJXUZL5ONC2R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Start using dcbstps; phwsync; sequence for flushing persistent memory range.
The new instructions are implemented as a variant of dcbf and hwsync and on
P8 and P9 they will be executed as those instructions. We avoid using them on
older hardware. This helps to avoid difficult to debug bugs.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/lib/pmem.c | 50 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
index 0666a8d29596..5a61aaeb6930 100644
--- a/arch/powerpc/lib/pmem.c
+++ b/arch/powerpc/lib/pmem.c
@@ -9,20 +9,62 @@
 
 #include <asm/cacheflush.h>
 
+static inline void __clean_pmem_range(unsigned long start, unsigned long stop)
+{
+	unsigned long shift = l1_dcache_shift();
+	unsigned long bytes = l1_dcache_bytes();
+	void *addr = (void *)(start & ~(bytes - 1));
+	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
+	unsigned long i;
+
+	for (i = 0; i < size >> shift; i++, addr += bytes)
+		asm volatile(PPC_DCBSTPS(%0, %1): :"i"(0), "r"(addr): "memory");
+
+
+	asm volatile(PPC_PHWSYNC ::: "memory");
+}
+
+static inline void __flush_pmem_range(unsigned long start, unsigned long stop)
+{
+	unsigned long shift = l1_dcache_shift();
+	unsigned long bytes = l1_dcache_bytes();
+	void *addr = (void *)(start & ~(bytes - 1));
+	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
+	unsigned long i;
+
+	for (i = 0; i < size >> shift; i++, addr += bytes)
+		asm volatile(PPC_DCBFPS(%0, %1): :"i"(0), "r"(addr): "memory");
+
+
+	asm volatile(PPC_PHWSYNC ::: "memory");
+}
+
+static inline void clean_pmem_range(unsigned long start, unsigned long stop)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		return __clean_pmem_range(start, stop);
+}
+
+static inline void flush_pmem_range(unsigned long start, unsigned long stop)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		return __flush_pmem_range(start, stop);
+}
+
 /*
  * CONFIG_ARCH_HAS_PMEM_API symbols
  */
 void arch_wb_cache_pmem(void *addr, size_t size)
 {
 	unsigned long start = (unsigned long) addr;
-	flush_dcache_range(start, start + size);
+	clean_pmem_range(start, start + size);
 }
 EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 
 void arch_invalidate_pmem(void *addr, size_t size)
 {
 	unsigned long start = (unsigned long) addr;
-	flush_dcache_range(start, start + size);
+	flush_pmem_range(start, start + size);
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
 
@@ -35,7 +77,7 @@ long __copy_from_user_flushcache(void *dest, const void __user *src,
 	unsigned long copied, start = (unsigned long) dest;
 
 	copied = __copy_from_user(dest, src, size);
-	flush_dcache_range(start, start + size);
+	clean_pmem_range(start, start + size);
 
 	return copied;
 }
@@ -45,7 +87,7 @@ void *memcpy_flushcache(void *dest, const void *src, size_t size)
 	unsigned long start = (unsigned long) dest;
 
 	memcpy(dest, src, size);
-	flush_dcache_range(start, start + size);
+	clean_pmem_range(start, start + size);
 
 	return dest;
 }
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

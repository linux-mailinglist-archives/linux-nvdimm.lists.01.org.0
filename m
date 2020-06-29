Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913DB20CEF7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 15:58:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 55418111B33DC;
	Mon, 29 Jun 2020 06:58:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A9E7111B33D4
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 06:58:14 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TDaF5B015151;
	Mon, 29 Jun 2020 09:58:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31ycg2ke3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 09:58:08 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TDkQfC063038;
	Mon, 29 Jun 2020 09:58:08 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31ycg2ke32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 09:58:08 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TDsPWw009489;
	Mon, 29 Jun 2020 13:58:07 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by ppma05wdc.us.ibm.com with ESMTP id 31wwr8fr9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 13:58:07 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TDw7bJ54264298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2020 13:58:07 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 277A8AE05C;
	Mon, 29 Jun 2020 13:58:07 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA8DDAE05F;
	Mon, 29 Jun 2020 13:58:03 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.77.197.62])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2020 13:58:03 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v6 7/8] powerpc/pmem: Add WARN_ONCE to catch the wrong usage of pmem flush functions.
Date: Mon, 29 Jun 2020 19:27:21 +0530
Message-Id: <20200629135722.73558-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 cotscore=-2147483648 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290091
Message-ID-Hash: PJFD6NY745SOHWHVRCSEPQIW55I4FMQE
X-Message-ID-Hash: PJFD6NY745SOHWHVRCSEPQIW55I4FMQE
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PJFD6NY745SOHWHVRCSEPQIW55I4FMQE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We only support persistent memory on P8 and above. This is enforced by the
firmware and further checked on virtualzied platform during platform init.
Add WARN_ONCE in pmem flush routines to catch the wrong usage of these.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/cacheflush.h | 2 ++
 arch/powerpc/lib/pmem.c               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 95782f77d768..1ab0fa660497 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -103,6 +103,8 @@ static inline void  arch_pmem_flush_barrier(void)
 {
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		asm volatile(PPC_PHWSYNC ::: "memory");
+	else
+		WARN_ONCE(1, "Using pmem flush on older hardware.");
 }
 
 #include <asm-generic/cacheflush.h>
diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
index 21210fa676e5..f40bd908d28d 100644
--- a/arch/powerpc/lib/pmem.c
+++ b/arch/powerpc/lib/pmem.c
@@ -37,12 +37,14 @@ static inline void clean_pmem_range(unsigned long start, unsigned long stop)
 {
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		return __clean_pmem_range(start, stop);
+	WARN_ONCE(1, "Using pmem flush on older hardware.");
 }
 
 static inline void flush_pmem_range(unsigned long start, unsigned long stop)
 {
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		return __flush_pmem_range(start, stop);
+	WARN_ONCE(1, "Using pmem flush on older hardware.");
 }
 
 /*
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

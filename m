Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0445A142CD5
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jan 2020 15:08:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A342C10097DB8;
	Mon, 20 Jan 2020 06:11:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ACCB210097DAB
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 06:11:33 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KE3DSi047663;
	Mon, 20 Jan 2020 09:08:14 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xmfyxudg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 09:08:14 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00KE3SQw049383;
	Mon, 20 Jan 2020 09:08:14 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xmfyxudfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 09:08:13 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00KE4wG1009469;
	Mon, 20 Jan 2020 14:08:18 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by ppma01wdc.us.ibm.com with ESMTP id 2xksn6375d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 14:08:18 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KE8B7K32047494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2020 14:08:11 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1A2FBE04F;
	Mon, 20 Jan 2020 14:08:11 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C7D0BE054;
	Mon, 20 Jan 2020 14:08:09 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.71.225])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2020 14:08:09 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, jmoyer@redhat.com
Subject: [PATCH v4 3/6] libnvdimm/namespace: Add arch dependent callback for namespace create time validation
Date: Mon, 20 Jan 2020 19:37:46 +0530
Message-Id: <20200120140749.69549-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
References: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=878 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200122
Message-ID-Hash: MDKV2TEI4DYQJPIJJVL2EGVQT6GRSOC4
X-Message-ID-Hash: MDKV2TEI4DYQJPIJJVL2EGVQT6GRSOC4
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MDKV2TEI4DYQJPIJJVL2EGVQT6GRSOC4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Namespace start address and size should be multiple of subsection size to avoid
handling complex partial subsection addition and removal of memory. Even though
subsection size is arch independent (2M), architectures do impose further
restrictions w.r.t namespace size/start addr based on direct-mapping  page size.

This patch adds an arch callback for supporting arch specific restrictions w.r.t
namespace size. This is different from arch_namespace_map_size() in that this
validates against SUBSECTION_SIZE. Ideally, kernel should use the same restrictions
during namespace initialization too. But that prevents an existing unaligned
namespace initialization to fail. The kernel now allows such namespace initialization
so that an existing installation is not broken.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/arm64/mm/flush.c     |  7 +++++++
 arch/powerpc/lib/pmem.c   | 11 +++++++++++
 arch/x86/mm/pageattr.c    |  6 ++++++
 include/linux/libnvdimm.h |  1 +
 4 files changed, 25 insertions(+)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 95cb5538bc6e..32b4ba57cc95 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -97,4 +97,11 @@ unsigned long arch_namespace_map_size(void)
 	return PAGE_SIZE;
 }
 EXPORT_SYMBOL_GPL(arch_namespace_map_size);
+
+unsigned long arch_namespace_align_size(void)
+{
+	return (1UL << SUBSECTION_SHIFT);
+}
+EXPORT_SYMBOL_GPL(arch_namespace_align_size);
+
 #endif
diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
index 63dca24e4a18..cdf4248c536c 100644
--- a/arch/powerpc/lib/pmem.c
+++ b/arch/powerpc/lib/pmem.c
@@ -35,6 +35,17 @@ unsigned long arch_namespace_map_size(void)
 }
 EXPORT_SYMBOL_GPL(arch_namespace_map_size);
 
+unsigned long arch_namespace_align_size(void)
+{
+	unsigned long sub_section_size = (1UL << SUBSECTION_SHIFT);
+
+	if (radix_enabled())
+		return sub_section_size;
+	return max(sub_section_size, (1UL << mmu_psize_defs[mmu_linear_psize].shift));
+
+}
+EXPORT_SYMBOL_GPL(arch_namespace_align_size);
+
 /*
  * CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE symbols
  */
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index d78b5082f376..1dea3e822e1a 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -316,6 +316,12 @@ unsigned long arch_namespace_map_size(void)
 }
 EXPORT_SYMBOL_GPL(arch_namespace_map_size);
 
+unsigned long arch_namespace_align_size(void)
+{
+	return (1UL << SUBSECTION_SHIFT);
+}
+EXPORT_SYMBOL_GPL(arch_namespace_align_size);
+
 
 static void __cpa_flush_all(void *arg)
 {
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index a3476dbd2656..0f366706b0aa 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -285,4 +285,5 @@ static inline void arch_invalidate_pmem(void *addr, size_t size)
 #endif
 
 unsigned long arch_namespace_map_size(void);
+unsigned long arch_namespace_align_size(void);
 #endif /* __LIBNVDIMM_H__ */
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

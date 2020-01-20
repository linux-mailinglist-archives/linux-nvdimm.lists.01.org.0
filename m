Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0DD142CD7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jan 2020 15:08:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB19910097DDC;
	Mon, 20 Jan 2020 06:11:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 45F0310097DC0
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 06:11:38 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KE46Oe080122;
	Mon, 20 Jan 2020 09:08:19 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xkxhwykky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 09:08:19 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00KE4k1T082206;
	Mon, 20 Jan 2020 09:08:10 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xkxhwykjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 09:08:10 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00KE4r5H000522;
	Mon, 20 Jan 2020 14:08:07 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma02dal.us.ibm.com with ESMTP id 2xksn6g217-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 14:08:07 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KE86jj42664446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2020 14:08:06 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20271BE058;
	Mon, 20 Jan 2020 14:08:06 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E97DCBE04F;
	Mon, 20 Jan 2020 14:08:03 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.71.225])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2020 14:08:03 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, jmoyer@redhat.com
Subject: [PATCH v4 1/6] libnvdimm/namespace: Make namespace size validation arch dependent
Date: Mon, 20 Jan 2020 19:37:44 +0530
Message-Id: <20200120140749.69549-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
References: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200122
Message-ID-Hash: 56BN6FWJ63DVBWJ6VTQ6EPB6Z66QIGSI
X-Message-ID-Hash: 56BN6FWJ63DVBWJ6VTQ6EPB6Z66QIGSI
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/56BN6FWJ63DVBWJ6VTQ6EPB6Z66QIGSI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The page size used to map the namespace is arch dependent. For example
architectures like ppc64 use 16MB page size for direct-mapping. If the namespace
size is not aligned to the mapping page size, users can observe kernel crash
during namespace init and destroy.

This is due to kernel doing partial map/unmap of the resource range

BUG: Unable to handle kernel data access at 0xc001000406000000
Faulting instruction address: 0xc000000000090790
NIP [c000000000090790] arch_add_memory+0xc0/0x130
LR [c000000000090744] arch_add_memory+0x74/0x130
Call Trace:
 arch_add_memory+0x74/0x130 (unreliable)
 memremap_pages+0x74c/0xa30
 devm_memremap_pages+0x3c/0xa0
 pmem_attach_disk+0x188/0x770
 nvdimm_bus_probe+0xd8/0x470
 really_probe+0x148/0x570
 driver_probe_device+0x19c/0x1d0
 device_driver_attach+0xcc/0x100
 bind_store+0x134/0x1c0
 drv_attr_store+0x44/0x60
 sysfs_kf_write+0x74/0xc0
 kernfs_fop_write+0x1b4/0x290
 __vfs_write+0x3c/0x70
 vfs_write+0xd0/0x260
 ksys_write+0xdc/0x130
 system_call+0x5c/0x68

Kernel should also ensure that namespace size is also mulitple of subsection size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/arm64/mm/flush.c     | 6 ++++++
 arch/powerpc/lib/pmem.c   | 9 +++++++++
 arch/x86/mm/pageattr.c    | 7 +++++++
 include/linux/libnvdimm.h | 1 +
 4 files changed, 23 insertions(+)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index ac485163a4a7..95cb5538bc6e 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -91,4 +91,10 @@ void arch_invalidate_pmem(void *addr, size_t size)
 	__inval_dcache_area(addr, size);
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
+
+unsigned long arch_namespace_map_size(void)
+{
+	return PAGE_SIZE;
+}
+EXPORT_SYMBOL_GPL(arch_namespace_map_size);
 #endif
diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
index 0666a8d29596..63dca24e4a18 100644
--- a/arch/powerpc/lib/pmem.c
+++ b/arch/powerpc/lib/pmem.c
@@ -26,6 +26,15 @@ void arch_invalidate_pmem(void *addr, size_t size)
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
 
+unsigned long arch_namespace_map_size(void)
+{
+	if (radix_enabled())
+		return PAGE_SIZE;
+	return (1UL << mmu_psize_defs[mmu_linear_psize].shift);
+
+}
+EXPORT_SYMBOL_GPL(arch_namespace_map_size);
+
 /*
  * CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE symbols
  */
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 1b99ad05b117..d78b5082f376 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -310,6 +310,13 @@ void arch_invalidate_pmem(void *addr, size_t size)
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
 
+unsigned long arch_namespace_map_size(void)
+{
+	return PAGE_SIZE;
+}
+EXPORT_SYMBOL_GPL(arch_namespace_map_size);
+
+
 static void __cpa_flush_all(void *arg)
 {
 	unsigned long cache = (unsigned long)arg;
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 9df091bd30ba..a3476dbd2656 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -284,4 +284,5 @@ static inline void arch_invalidate_pmem(void *addr, size_t size)
 }
 #endif
 
+unsigned long arch_namespace_map_size(void);
 #endif /* __LIBNVDIMM_H__ */
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C93102E5
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Feb 2021 03:40:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 148DF100EAB00;
	Thu,  4 Feb 2021 18:40:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E0E1B100EAAE3
	for <linux-nvdimm@lists.01.org>; Thu,  4 Feb 2021 18:40:18 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1152WCAr085383;
	Thu, 4 Feb 2021 21:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ZiRm4Mrwiruj8mZh6Z1HK5K5UhjVumOmWXRKUYoLkOQ=;
 b=KU16l9Y3KqA/qdLe3WavxJGeYVALQ5NvDQ0zHUarZ4ewIdCi5ArGPxYLzTAjlRHSmoy9
 lO1GovmNJO7NT4GxfPLiVwGqLmAk1VRBh4ya9rfjAEBhVNNwjtysdf5q01ovlSvxkRjq
 BYe4ueq4OzjhuEptC41ecLz2gkW1fedqTLQpl1QcCStn6XEn0Whz8HLGIzDhdp3yAXMz
 /7hVMoAd0Sd/SxPRLBvLwn98RuI4KjAfyb56ZdA9NtFrTc9xAfLe3Vf/sINpTI+25fx/
 FsjJWxCfjx3wlk4RJrvsghmV135+mAyf/GChS2hSeQDyfmGI/GJEcQtU20mI29T84tk4 XA==
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 36gv5f1gn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Feb 2021 21:40:15 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1152cSdx023921;
	Fri, 5 Feb 2021 02:40:14 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma04dal.us.ibm.com with ESMTP id 36ex3pe5k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Feb 2021 02:40:14 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1152eDG913697580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Feb 2021 02:40:13 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 155DE136051;
	Fri,  5 Feb 2021 02:40:13 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44253136055;
	Fri,  5 Feb 2021 02:40:09 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.102.1.215])
	by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
	Fri,  5 Feb 2021 02:40:08 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] mm/pmem: Avoid inserting hugepage PTE entry with fsdax if hugepage support is disabled
Date: Fri,  5 Feb 2021 08:09:56 +0530
Message-Id: <20210205023956.417587-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_13:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050011
Message-ID-Hash: DVOQA3IHEY42BRVVLBRVCO57GEANKJMR
X-Message-ID-Hash: DVOQA3IHEY42BRVVLBRVCO57GEANKJMR
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DVOQA3IHEY42BRVVLBRVCO57GEANKJMR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Differentiate between hardware not supporting hugepages and user disabling THP
via 'echo never > /sys/kernel/mm/transparent_hugepage/enabled'

For the devdax namespace, the kernel handles the above via the
supported_alignment attribute and failing to initialize the namespace
if the namespace align value is not supported on the platform.

For the fsdax namespace, the kernel will continue to initialize
the namespace. This can result in the kernel creating a huge pte
entry even though the hardware don't support the same.

We do want hugepage support with pmem even if the end-user disabled THP
via sysfs file (/sys/kernel/mm/transparent_hugepage/enabled). Hence
differentiate between hardware/firmware lacking support vs user-controlled
disable of THP and prevent a huge fault if the hardware lacks hugepage
support.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/huge_mm.h | 15 +++++++++------
 mm/huge_memory.c        |  6 +++++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 6a19f35f836b..ba973efcd369 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -78,6 +78,7 @@ static inline vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn,
 }
 
 enum transparent_hugepage_flag {
+	TRANSPARENT_HUGEPAGE_NEVER_DAX,
 	TRANSPARENT_HUGEPAGE_FLAG,
 	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
@@ -123,6 +124,13 @@ extern unsigned long transparent_hugepage_flags;
  */
 static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
+
+	/*
+	 * If the hardware/firmware marked hugepage support disabled.
+	 */
+	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
+		return false;
+
 	if (vma->vm_flags & VM_NOHUGEPAGE)
 		return false;
 
@@ -134,12 +142,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
 		return true;
-	/*
-	 * For dax vmas, try to always use hugepage mappings. If the kernel does
-	 * not support hugepages, fsdax mappings will fallback to PAGE_SIZE
-	 * mappings, and device-dax namespaces, that try to guarantee a given
-	 * mapping size, will fail to enable
-	 */
+
 	if (vma_is_dax(vma))
 		return true;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9237976abe72..d698b7e27447 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -386,7 +386,11 @@ static int __init hugepage_init(void)
 	struct kobject *hugepage_kobj;
 
 	if (!has_transparent_hugepage()) {
-		transparent_hugepage_flags = 0;
+		/*
+		 * Hardware doesn't support hugepages, hence disable
+		 * DAX PMD support.
+		 */
+		transparent_hugepage_flags = 1 << TRANSPARENT_HUGEPAGE_NEVER_DAX;
 		return -EINVAL;
 	}
 
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

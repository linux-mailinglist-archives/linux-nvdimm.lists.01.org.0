Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E62E5137692
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jan 2020 20:05:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1A8F910096C99;
	Fri, 10 Jan 2020 11:09:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A60EA100978DF
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 11:09:14 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00AJ3CH8110888;
	Fri, 10 Jan 2020 19:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=91h706fXsdEJXZDnw67zTo1mSfBkU/j9Erd5I1z7aCg=;
 b=CrULY4cfFvZsA2qw7NIKPR6egO/hAPbaNQDQeIddAlyjfmNf1Eu7rlxJDD/C7SWOFlb4
 9FssiPbqhbHhrXyUFQNfA+/whTHpQmArL4bk0lhHg8iFDxVB8nEtCrg1leogQp7KL8d/
 cg3EF1XYzYE6iLJtVGueP1TEFX+eQ3IFLsVLqxSaIGn68F22OMey6y7SwAOCE8K03WVZ
 4FES+ozykOyjgQRqbzlfhx5Jx+8f5EtIkLQc5icI/NZsuR9nGjlgOEkWdyMSfNnVnR+e
 BSHpYCrrxgINh2JOT56+QBxKIDT2FqGWz04t14mdO+ttS7R3qna5FMqoU3Wqoi2kPatj hw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2xakbrbyq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2020 19:04:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00AJ4A0l069372;
	Fri, 10 Jan 2020 19:04:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2xevfebv47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2020 19:04:53 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00AJ4qpm014575;
	Fri, 10 Jan 2020 19:04:52 GMT
Received: from paddy.uk.oracle.com (/10.175.192.165)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 10 Jan 2020 11:04:52 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH RFC 03/10] mm: Add pud support for _PAGE_SPECIAL
Date: Fri, 10 Jan 2020 19:03:06 +0000
Message-Id: <20200110190313.17144-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200110190313.17144-1-joao.m.martins@oracle.com>
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100154
Message-ID-Hash: AGCIKPR7PRI3YJPOHP7OIYUNWMYOV4R3
X-Message-ID-Hash: AGCIKPR7PRI3YJPOHP7OIYUNWMYOV4R3
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Barret Rhoden <brho@google.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Matthew Wilcox <willy@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AGCIKPR7PRI3YJPOHP7OIYUNWMYOV4R3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently vmf_insert_pfn_pud only works with devmap
and BUG_ON otherwise. Add support for handling
page special when pfn_t has it marked with PFN_SPECIAL.

Usage of this type of pages aren't expected to do GUP
hence return no pages on gup_huge_pud() much like how
it is done for ptes on gup_pte_range() and for pmds on
gup_huge_pmd().

This allows device-dax to handle 1G hugepages without
struct pages.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/pgtable.h | 18 +++++++++++++++++-
 mm/gup.c                       |  3 +++
 mm/huge_memory.c               |  8 +++++---
 mm/memory.c                    |  3 ++-
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 60351c0c15fe..2027c063fa16 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -261,7 +261,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static inline int pud_trans_huge(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pud_val(pud) & (_PAGE_PSE|_PAGE_DEVMAP|_PAGE_SPECIAL)) == _PAGE_PSE;
 }
 #endif
 
@@ -300,6 +300,17 @@ static inline int pmd_special(pmd_t pmd)
 {
 	return !!(pmd_flags(pmd) & _PAGE_SPECIAL);
 }
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static inline int pud_special(pud_t pud)
+{
+	return !!(pud_flags(pud) & _PAGE_SPECIAL);
+}
+#else
+static inline int pud_special(pud_t pud)
+{
+	return 0;
+}
 #endif
 
 #endif
@@ -487,6 +498,11 @@ static inline pud_t pud_mkhuge(pud_t pud)
 	return pud_set_flags(pud, _PAGE_PSE);
 }
 
+static inline pud_t pud_mkspecial(pud_t pud)
+{
+	return pud_set_flags(pud, _PAGE_SPECIAL);
+}
+
 static inline pud_t pud_mkyoung(pud_t pud)
 {
 	return pud_set_flags(pud, _PAGE_ACCESSED);
diff --git a/mm/gup.c b/mm/gup.c
index ba5f10535392..ae4abe5878ad 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2123,6 +2123,9 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
 	}
 
+	if (pud_special(orig))
+		return 0;
+
 	refs = 0;
 	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 	do {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 06ad4d6f7477..cff707163bc1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -879,6 +879,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pud_mkdevmap(entry);
+	else if (pfn_t_special(pfn))
+		entry = pud_mkspecial(entry);
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
@@ -901,8 +903,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
+	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -2031,7 +2032,8 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)) ||
+		   pud_special(*pud))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
diff --git a/mm/memory.c b/mm/memory.c
index db99684d2cb3..109643219e1b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1201,7 +1201,8 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(*pud) || pud_devmap(*pud) ||
+		    pud_special(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				VM_BUG_ON_VMA(!rwsem_is_locked(&tlb->mm->mmap_sem), vma);
 				split_huge_pud(vma, pud, addr);
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

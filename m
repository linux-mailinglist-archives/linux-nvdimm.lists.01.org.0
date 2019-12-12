Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F8511D53A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 19:23:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5CA561011366F;
	Thu, 12 Dec 2019 10:26:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3gyxyxqqkdewp5v2u22uzs.q20zw18b-19rw00zw676.ef.25u@flex--brho.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2A6931011366E
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 10:26:20 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id q5so1350204pfh.1
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 10:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IvHeRx1oBCh9J6TLvVWdv2Gb1z0rpMzGcWyY+BXVgxo=;
        b=MAdkof8C2KW30AALfnNJO3vr9VoF0vmBXanMXL/vR51qGyvIZkGihOmBNe+C0or/8I
         NpO/KCC3oEKNcwp7NIyw7WnD6H+rCsDvTI30S8NWdXPxMl0MDaFljsm9JXiaxGx8tZCO
         d4KLSyqgiZeCGiJqkepl0hPb47CUKa9ToIY3jibKjBu4kZUmg7uhITO9RyP7k+b0KyoU
         zEcEs3lkMbzHsbNJ2xA4Mv3lS6SzC0mJbsHZ2qOxVL621b4e0Gt/qvA+mGVTzX9rJKB5
         /8rQMuMbnVTaGER/Xvhr4PwqP6nQELiDlJ6qv20w9iVMpmIsQeJffxIkfXKhEXwrX/ah
         Gvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IvHeRx1oBCh9J6TLvVWdv2Gb1z0rpMzGcWyY+BXVgxo=;
        b=sDMLBw37kw2FxlChK2fmsi2o34wG/IwSlXUINshJkd4cvxHCiIhA0PrnnTCHK5+ag8
         NvBYi3Dk/JaV1DGXAos3fWOXRHButjs3vxfE3ZIBRQ6mC9veUCN9sGvutzBUZ92xFZ5W
         JzeYIPTV4/3a0sAzRXf9Pw9bgKGYJ8eyPFBORCY1QTd1HkM6UgcnAe3MHtp3PSCFbl8D
         BdAENMnxW1+R2XzraB4Wno3HjN76pcr+bAEMfz10TaCTX1zfZQDqQySSYcUOSIHQ1UE1
         xznkuOSZGXF0tQpIVUDxqOH6lsOJ03Jz6NXZbboc+IgM6/ObRxBLvJ0fwLwgfNBXBDHG
         p/JA==
X-Gm-Message-State: APjAAAXvSEUFhtLU+bMpr0xC+wxljmRejz5k9+DyfZT/B0DmV+yaLVcu
	yhqHU/MT2vhL03Not8eYZXsXLKzg
X-Google-Smtp-Source: APXvYqwVXoFFdqVc4oFKrnkNNIY1YlbI3lRBL8mXjnVcsOoBTjQ2NnV0mup2jeDoJ+6bSYWUQLoZOkJ/
X-Received: by 2002:a63:a508:: with SMTP id n8mr11683668pgf.278.1576174977297;
 Thu, 12 Dec 2019 10:22:57 -0800 (PST)
Date: Thu, 12 Dec 2019 13:22:37 -0500
In-Reply-To: <20191212182238.46535-1-brho@google.com>
Message-Id: <20191212182238.46535-2-brho@google.com>
Mime-Version: 1.0
References: <20191212182238.46535-1-brho@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v5 1/2] mm: make dev_pagemap_mapping_shift() externally visible
From: Barret Rhoden <brho@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID-Hash: 4OJTY5CQ7IJ5DS7KZO2XXVEQB7QIAURT
X-Message-ID-Hash: 4OJTY5CQ7IJ5DS7KZO2XXVEQB7QIAURT
X-MailFrom: 3gYXyXQQKDEwp5v2u22uzs.q20zw18B-19rw00zw676.EF.25u@flex--brho.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4OJTY5CQ7IJ5DS7KZO2XXVEQB7QIAURT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

KVM has a use case for determining the size of a dax mapping.

The KVM code has easy access to the address and the mm, and
dev_pagemap_mapping_shift() needs only those parameters.  It was
deriving them from page and vma.  This commit changes those parameters
from (page, vma) to (address, mm).

Signed-off-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h  |  3 +++
 mm/memory-failure.c | 38 +++-----------------------------------
 mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a2adf95b3f9c..bfd1882dd5c6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1013,6 +1013,9 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 #define page_ref_zero_or_close_to_overflow(page) \
 	((unsigned int) page_ref_count(page) + 127u <= 127u)
 
+unsigned long dev_pagemap_mapping_shift(unsigned long address,
+					struct mm_struct *mm);
+
 static inline void get_page(struct page *page)
 {
 	page = compound_head(page);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3151c87dff73..bafa464c8290 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -261,40 +261,6 @@ void shake_page(struct page *p, int access)
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
-static unsigned long dev_pagemap_mapping_shift(struct page *page,
-		struct vm_area_struct *vma)
-{
-	unsigned long address = vma_address(page, vma);
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset(vma->vm_mm, address);
-	if (!pgd_present(*pgd))
-		return 0;
-	p4d = p4d_offset(pgd, address);
-	if (!p4d_present(*p4d))
-		return 0;
-	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
-		return 0;
-	if (pud_devmap(*pud))
-		return PUD_SHIFT;
-	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
-		return 0;
-	if (pmd_devmap(*pmd))
-		return PMD_SHIFT;
-	pte = pte_offset_map(pmd, address);
-	if (!pte_present(*pte))
-		return 0;
-	if (pte_devmap(*pte))
-		return PAGE_SHIFT;
-	return 0;
-}
-
 /*
  * Failure handling: if we can't find or can't kill a process there's
  * not much we can do.	We just print a message and ignore otherwise.
@@ -324,7 +290,9 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	}
 	tk->addr = page_address_in_vma(p, vma);
 	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
+		tk->size_shift =
+			dev_pagemap_mapping_shift(vma_address(page, vma),
+						  vma->vm_mm);
 	else
 		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
 
diff --git a/mm/util.c b/mm/util.c
index 3ad6db9a722e..59984e6b40ab 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -901,3 +901,37 @@ int memcmp_pages(struct page *page1, struct page *page2)
 	kunmap_atomic(addr1);
 	return ret;
 }
+
+unsigned long dev_pagemap_mapping_shift(unsigned long address,
+					struct mm_struct *mm)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd))
+		return 0;
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		return 0;
+	pud = pud_offset(p4d, address);
+	if (!pud_present(*pud))
+		return 0;
+	if (pud_devmap(*pud))
+		return PUD_SHIFT;
+	pmd = pmd_offset(pud, address);
+	if (!pmd_present(*pmd))
+		return 0;
+	if (pmd_devmap(*pmd))
+		return PMD_SHIFT;
+	pte = pte_offset_map(pmd, address);
+	if (!pte_present(*pte))
+		return 0;
+	if (pte_devmap(*pte))
+		return PAGE_SHIFT;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pagemap_mapping_shift);
-- 
2.24.0.525.g8f36a354ae-goog
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

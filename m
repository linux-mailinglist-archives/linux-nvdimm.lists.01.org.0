Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4771E11BF3B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Dec 2019 22:32:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2F5FD10113630;
	Wed, 11 Dec 2019 13:35:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f4a; helo=mail-qv1-xf4a.google.com; envelope-from=3agdxxqqkdomgwmtlttlqj.htrqnszc-sainrrqnxyx.fg.twl@flex--brho.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0CEEB10113628
	for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 13:35:47 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id c22so122152qvc.1
        for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 13:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sDaCcLT3BcQJ23kfy/HaXZtjLV54Z/X5vMBQ4m0F9ws=;
        b=EsxnNiRNv8If11+vloXSQ7nwWN1lItAewnF+sLDaSlmolmYksUpNvpwBYaM7L41HUd
         uWxT5Uu6Hic1c/J1Y90egmD8MQQddHSFtNUFiZ5CgltHtE64rJa9kd7xChSG2D/6uEYH
         tso9FlUjwcWCykQdNsAPbyh3GEyMbxk8q6nPIK6Itca/A4kuMsDUiiPT4l8tKvAc7+4P
         TfcrFl85CPUmcmMtw5eYhoZX333AYEy6qoWY13yAKMWwOQP/bqViTLN5LEzAoWkVYn4+
         9YSHcl3zD7aKQyQ02OdDsUczHpKePD6qPvej9G3oRirDEbrbz7oIgSvbjWHtU4syo/ie
         grnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sDaCcLT3BcQJ23kfy/HaXZtjLV54Z/X5vMBQ4m0F9ws=;
        b=dDJ5221M2pa87w2JIRgp2XPkYAMdoTcb6rPm7tSWpracIU6YfO3c7+N0Xa9ciPUiDD
         0kUuWMZgOnPnA0BWwLoNl9UozSAgEIYEr1iffw2p4YZbjt8DL5zwVDaNlotVL3+BglLG
         gKuZ14Eu7AiUGZQzjkcwZm8QTlKU796s0M0Sgo0SiyZhyV1b69nAv+Wg57xgwBv7GYoU
         Vy14UwrU6oHapstibO1KDpVjBaeWFUT4Hvty2z0EUZJ9TnCjxo4YYtFEoD2oO5sAxHHo
         37eYwyY+Hn3Iyiwjf1EErELZapGQ2qFciML8KBkAE5eChiVlPd5ZjA8aQp1kXBII/wFs
         M56w==
X-Gm-Message-State: APjAAAVP4a1C8nRxrk4NwMggDAZpbR2/dyb/teC2/tvYyKbK7A4bNASU
	G/g4E7XlHuXS9k6un8zRwhrXbzOh
X-Google-Smtp-Source: APXvYqymtB08I22rTfCyFtgWxWJ8AqN73LVOvZo61CMncBXCwtep0KelAX9VW18l1EiAV26YFXB+Df9C
X-Received: by 2002:a05:6214:209:: with SMTP id i9mr5144868qvt.54.1576099944237;
 Wed, 11 Dec 2019 13:32:24 -0800 (PST)
Date: Wed, 11 Dec 2019 16:32:06 -0500
In-Reply-To: <20191211213207.215936-1-brho@google.com>
Message-Id: <20191211213207.215936-2-brho@google.com>
Mime-Version: 1.0
References: <20191211213207.215936-1-brho@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v4 1/2] mm: make dev_pagemap_mapping_shift() externally visible
From: Barret Rhoden <brho@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID-Hash: 2ZRP3YBXTPOE77CM77OZZLLPX34R75OG
X-Message-ID-Hash: 2ZRP3YBXTPOE77CM77OZZLLPX34R75OG
X-MailFrom: 3aGDxXQQKDOMGWMTLTTLQJ.HTRQNSZc-SaINRRQNXYX.fg.TWL@flex--brho.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2ZRP3YBXTPOE77CM77OZZLLPX34R75OG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

KVM has a use case for determining the size of a dax mapping.  The KVM
code has easy access to the address and the mm; hence the change in
parameters.

Signed-off-by: Barret Rhoden <brho@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h  |  3 +++
 mm/memory-failure.c | 38 +++-----------------------------------
 mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8b0ef04b6d15..f88bcc6a3bd1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -998,6 +998,9 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 #define page_ref_zero_or_close_to_overflow(page) \
 	((unsigned int) page_ref_count(page) + 127u <= 127u)
 
+unsigned long dev_pagemap_mapping_shift(unsigned long address,
+					struct mm_struct *mm);
+
 static inline void get_page(struct page *page)
 {
 	page = compound_head(page);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 41c634f45d45..9dc487e73d9b 100644
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
@@ -318,7 +284,9 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 
 	tk->addr = page_address_in_vma(p, vma);
 	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
+		tk->size_shift =
+			dev_pagemap_mapping_shift(vma_address(page, vma),
+						  vma->vm_mm);
 	else
 		tk->size_shift = page_shift(compound_head(p));
 
diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..553fbe1692ed 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -911,3 +911,37 @@ int memcmp_pages(struct page *page1, struct page *page2)
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

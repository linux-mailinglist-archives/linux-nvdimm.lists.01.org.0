Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB78111BF3C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Dec 2019 22:32:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A566810113633;
	Wed, 11 Dec 2019 13:35:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e49; helo=mail-vs1-xe49.google.com; envelope-from=3bgdxxqqkdockaqxpxxpun.lxvurwdg-wemrvvurbcb.jk.xap@flex--brho.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4981B10113634
	for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 13:35:52 -0800 (PST)
Received: by mail-vs1-xe49.google.com with SMTP id j9so25417vsn.15
        for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 13:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cpnhXnLglixPPYBVn7HgN2if2evOi/FjwLYbdxu/Tg4=;
        b=BjkB4hQuCzNvgDg1hIM+zGyYK1u8CTBOSJ20PWcYUmmzJm0EEozkJ9Q1YxNVhZbr/H
         giphN6cCCXbh58OitPnHXjObIa6Lisbnnsvi3GVkeLZDzoZtLarfyhvxTCAT5FC1bQn/
         ABMbYqeYtHThYG5cKkpxH4rsuDwQQYbSC5IR8WViXW4NXf5GbkrJH0PqNj87OVn+HzCx
         wv3VAMzPpJ9mH4AeUf1vyZP60dMKx7RiDbRa3LFMKTxz2A61K7XqIDr8FG353vLUY1pP
         mooYYKMADxjb8XPiPdZTRxvh/hp+RiCzYIWeKWEuaT29+ds4KLwo96ik7QNi4n675Sop
         aasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cpnhXnLglixPPYBVn7HgN2if2evOi/FjwLYbdxu/Tg4=;
        b=Yg9C/+LmRx2ybiO5I8GUZyhs+/84CZonJaatz8Hksqfxu9npD4AEQMFbw0+2rYY5p1
         7lfOAM35rHEa2whfSZc7HwaK05tmBV5yaOIchWdwe2KxLZ2Vqw4ZVza6DrWaSaM0u/6s
         xpb0g/ObxcgvIsgkDyBtIw4w4EjXrrF+RDANcNsg6ZSTOCoRpS4moLCuJTMJK1NbE/PB
         Ab/NGcB6CtXDXQvH5aJP423LsCL2ihChO17+3DyzYBYIObaV5atDLGFMofRjQALvt6gi
         K1oDOv+J0RsOnD/jWZJidLAxNDqiMCrz6kXWgnfdo9aebaOb9nfPUN0vChCASAYmHIDA
         HV6g==
X-Gm-Message-State: APjAAAVVprOVuMAPifcay4WsqGFR89f8oj6tU30xExifFfMCy9Cw/VG8
	yK8J2mEne8JYzJm9plBcKVuZpGGB
X-Google-Smtp-Source: APXvYqz6qNfUF/2RBgQj1i0wA7WRKTT/3zMghj8ls7WH3mm9ABUYccruj1nHyEp3pYmgO7zVmf0M+JNp
X-Received: by 2002:a1f:ac57:: with SMTP id v84mr5840002vke.90.1576099948361;
 Wed, 11 Dec 2019 13:32:28 -0800 (PST)
Date: Wed, 11 Dec 2019 16:32:07 -0500
In-Reply-To: <20191211213207.215936-1-brho@google.com>
Message-Id: <20191211213207.215936-3-brho@google.com>
Mime-Version: 1.0
References: <20191211213207.215936-1-brho@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
From: Barret Rhoden <brho@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID-Hash: 26WSZC6JBAGZKLWRJOYCJUUSXKLIRVGI
X-Message-ID-Hash: 26WSZC6JBAGZKLWRJOYCJUUSXKLIRVGI
X-MailFrom: 3bGDxXQQKDOcKaQXPXXPUN.LXVURWdg-WeMRVVURbcb.jk.XaP@flex--brho.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/26WSZC6JBAGZKLWRJOYCJUUSXKLIRVGI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This change allows KVM to map DAX-backed files made of huge pages with
huge mappings in the EPT/TDP.

DAX pages are not PageTransCompound.  The existing check is trying to
determine if the mapping for the pfn is a huge mapping or not.  For
non-DAX maps, e.g. hugetlbfs, that means checking PageTransCompound.
For DAX, we can check the page table itself.

Note that KVM already faulted in the page (or huge page) in the host's
page table, and we hold the KVM mmu spinlock.  We grabbed that lock in
kvm_mmu_notifier_invalidate_range_end, before checking the mmu seq.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6f92b40d798c..cd07bc4e595f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3384,6 +3384,35 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 	return -EFAULT;
 }
 
+static bool pfn_is_huge_mapped(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+	unsigned long hva;
+
+	if (!is_zone_device_page(page))
+		return PageTransCompoundMap(page);
+
+	/*
+	 * DAX pages do not use compound pages.  The page should have already
+	 * been mapped into the host-side page table during try_async_pf(), so
+	 * we can check the page tables directly.
+	 */
+	hva = gfn_to_hva(kvm, gfn);
+	if (kvm_is_error_hva(hva))
+		return false;
+
+	/*
+	 * Our caller grabbed the KVM mmu_lock with a successful
+	 * mmu_notifier_retry, so we're safe to walk the page table.
+	 */
+	switch (dev_pagemap_mapping_shift(hva, current->mm)) {
+	case PMD_SHIFT:
+	case PUD_SIZE:
+		return true;
+	}
+	return false;
+}
+
 static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 					gfn_t gfn, kvm_pfn_t *pfnp,
 					int *levelp)
@@ -3398,8 +3427,8 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 	 * here.
 	 */
 	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
-	    !kvm_is_zone_device_pfn(pfn) && level == PT_PAGE_TABLE_LEVEL &&
-	    PageTransCompoundMap(pfn_to_page(pfn)) &&
+	    level == PT_PAGE_TABLE_LEVEL &&
+	    pfn_is_huge_mapped(vcpu->kvm, gfn, pfn) &&
 	    !mmu_gfn_lpage_is_disallowed(vcpu, gfn, PT_DIRECTORY_LEVEL)) {
 		unsigned long mask;
 		/*
@@ -6015,8 +6044,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		 * mapping if the indirect sp has level = 1.
 		 */
 		if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
-		    !kvm_is_zone_device_pfn(pfn) &&
-		    PageTransCompoundMap(pfn_to_page(pfn))) {
+		    pfn_is_huge_mapped(kvm, sp->gfn, pfn)) {
 			pte_list_remove(rmap_head, sptep);
 
 			if (kvm_available_flush_tlb_with_range())
-- 
2.24.0.525.g8f36a354ae-goog
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

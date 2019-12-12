Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3911D53C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 19:23:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 77A2C1011366F;
	Thu, 12 Dec 2019 10:26:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com; envelope-from=3hyxyxqqkdfat9z6y66y3w.u64305cf-5dv04430aba.ij.69y@flex--brho.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE08D10113671
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 10:26:23 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v2so1904795pgv.6
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 10:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QJzS5cf1va+nrqwiPMy+1/CZ1shjgAqUeBFnOuHAc2s=;
        b=Ba0ZrxLur6jY5/yOkxJ3TztRuqj4f0wSiJ88PrOZrz6TKvyfeg1L/B0CGclVQMSKMS
         fKntKcN+MxF41ny/fjJJQzA/TxZnRfVwqE4Abw4zWB1eEXysAMU83K8rIwXbt5IfGWXL
         rTV7A36Z09p7odDbSD00a4mbTY0Lvu0IyNj4tT49mjw31Q5L9IhFdG8cXyX4r40FjVEo
         hjq3LR16hnJ3NKy94C2uwvo9okl0CTJT0ZPXdKG5OjVbxKPM8y7IX0CWAy14neVt1hO7
         4Os1UMSWnkdTVnbXe37U4lvvoG1ujSbhU8yfBrGa1meSA02y74bsiSjr7iBssE0ojlWA
         XmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QJzS5cf1va+nrqwiPMy+1/CZ1shjgAqUeBFnOuHAc2s=;
        b=oY/S6Glejmf+eo0wRcuEVScs5gQAX3KDbejzH5zaSlTVlU+FpySafNd6V64pivdWKY
         pUmhfG3qk/wnBqa2QpbRWgJpUlbsxZiIEeu8ZX8QAb0Q4L/OHvfHdEnDAbUlMeMFEBH/
         NX+C1W0J9IEa1HeQQl8o3RvbYa/6Cq5/DacUoXrPkdw+mok2lEXl5ylppamCOpoeUNNH
         hGjczkAbxXdw6Fn639/H7V9LkfAK707w5aiw+fWYDSkX5GDkqGG1S03cPAKgQYVwgany
         bFATR1WSlu0ETfBlAD9le4ham7hUiNktZQ7ulTGJgCarKn50Gjg/PMMhv3PDmZUxsEaU
         zZ5A==
X-Gm-Message-State: APjAAAWDTug1WEkfZfa8do6PxpMhgU6JLubmNLxDNApxbCw6zsC0Ex7Z
	wxnSNG3mBXTlBV2kazevIIVxJaIn
X-Google-Smtp-Source: APXvYqx3OSYyAEpeU1hpMzeLCwi0nWCUbjiyweJI73Oot2AiHdC93XItct57lFn8p5M9ukNOGXwyBoTV
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr11986210pgs.21.1576174981140;
 Thu, 12 Dec 2019 10:23:01 -0800 (PST)
Date: Thu, 12 Dec 2019 13:22:38 -0500
In-Reply-To: <20191212182238.46535-1-brho@google.com>
Message-Id: <20191212182238.46535-3-brho@google.com>
Mime-Version: 1.0
References: <20191212182238.46535-1-brho@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
From: Barret Rhoden <brho@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID-Hash: SCRNMCHWHJOI2EHU5N6BQBFNNHKR33UE
X-Message-ID-Hash: SCRNMCHWHJOI2EHU5N6BQBFNNHKR33UE
X-MailFrom: 3hYXyXQQKDFAt9z6y66y3w.u64305CF-5Dv04430ABA.IJ.69y@flex--brho.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SCRNMCHWHJOI2EHU5N6BQBFNNHKR33UE/>
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
 arch/x86/kvm/mmu/mmu.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7269130ea5e2..ea8f6951398b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3328,6 +3328,30 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
 	__direct_pte_prefetch(vcpu, sp, sptep);
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
+	return dev_pagemap_mapping_shift(hva, current->mm) > PAGE_SHIFT;
+}
+
 static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 					gfn_t gfn, kvm_pfn_t *pfnp,
 					int *levelp)
@@ -3342,8 +3366,8 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 	 * here.
 	 */
 	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
-	    !kvm_is_zone_device_pfn(pfn) && level == PT_PAGE_TABLE_LEVEL &&
-	    PageTransCompoundMap(pfn_to_page(pfn))) {
+	    level == PT_PAGE_TABLE_LEVEL &&
+	    pfn_is_huge_mapped(vcpu->kvm, gfn, pfn)) {
 		unsigned long mask;
 
 		/*
@@ -5957,8 +5981,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
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

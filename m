Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E971134D48
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 21:27:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D861A10097DA4;
	Wed,  8 Jan 2020 12:30:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D2C3B10097DEE
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jan 2020 12:30:25 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 12:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600";
   d="scan'208";a="211658374"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 12:27:06 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 06/14] KVM: x86/mmu: Refactor THP adjust to prep for changing query
Date: Wed,  8 Jan 2020 12:24:40 -0800
Message-Id: <20200108202448.9669-7-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108202448.9669-1-sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID-Hash: SMCJBUVXPFIQA5XP4HZSRI6ZU47UUN7H
X-Message-ID-Hash: SMCJBUVXPFIQA5XP4HZSRI6ZU47UUN7H
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, Barret Rhoden <brho@google.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMCJBUVXPFIQA5XP4HZSRI6ZU47UUN7H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Refactor transparent_hugepage_adjust() in preparation for walking the
host page tables to identify hugepage mappings, initially for THP pages,
and eventualy for HugeTLB and DAX-backed pages as well.  The latter
cases support 1gb pages, i.e. the adjustment logic needs access to the
max allowed level.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c         | 44 +++++++++++++++++-----------------
 arch/x86/kvm/mmu/paging_tmpl.h |  3 +--
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8ca6cd04cdf1..30836899be73 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3329,33 +3329,34 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
 	__direct_pte_prefetch(vcpu, sp, sptep);
 }
 
-static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
-					gfn_t gfn, kvm_pfn_t *pfnp,
+static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
+					int max_level, kvm_pfn_t *pfnp,
 					int *levelp)
 {
 	kvm_pfn_t pfn = *pfnp;
 	int level = *levelp;
+	kvm_pfn_t mask;
+
+	if (max_level == PT_PAGE_TABLE_LEVEL || level > PT_PAGE_TABLE_LEVEL)
+		return;
+
+	if (is_error_noslot_pfn(pfn) || kvm_is_reserved_pfn(pfn) ||
+	    kvm_is_zone_device_pfn(pfn))
+		return;
+
+	if (!kvm_is_transparent_hugepage(pfn))
+		return;
+
+	level = PT_DIRECTORY_LEVEL;
 
 	/*
-	 * Check if it's a transparent hugepage. If this would be an
-	 * hugetlbfs page, level wouldn't be set to
-	 * PT_PAGE_TABLE_LEVEL and there would be no adjustment done
-	 * here.
+	 * mmu_notifier_retry() was successful and mmu_lock is held, so
+	 * the pmd can't be split from under us.
 	 */
-	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
-	    !kvm_is_zone_device_pfn(pfn) && level == PT_PAGE_TABLE_LEVEL &&
-	    kvm_is_transparent_hugepage(pfn)) {
-		unsigned long mask;
-
-		/*
-		 * mmu_notifier_retry() was successful and mmu_lock is held, so
-		 * the pmd can't be split from under us.
-		 */
-		*levelp = level = PT_DIRECTORY_LEVEL;
-		mask = KVM_PAGES_PER_HPAGE(level) - 1;
-		VM_BUG_ON((gfn & mask) != (pfn & mask));
-		*pfnp = pfn & ~mask;
-	}
+	*levelp = level;
+	mask = KVM_PAGES_PER_HPAGE(level) - 1;
+	VM_BUG_ON((gfn & mask) != (pfn & mask));
+	*pfnp = pfn & ~mask;
 }
 
 static void disallowed_hugepage_adjust(struct kvm_shadow_walk_iterator it,
@@ -3395,8 +3396,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, int write,
 	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa)))
 		return RET_PF_RETRY;
 
-	if (likely(max_level > PT_PAGE_TABLE_LEVEL))
-		transparent_hugepage_adjust(vcpu, gfn, &pfn, &level);
+	transparent_hugepage_adjust(vcpu, gfn, max_level, &pfn, &level);
 
 	trace_kvm_mmu_spte_requested(gpa, level, pfn);
 	for_each_shadow_entry(vcpu, gpa, it) {
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index b53bed3c901c..0029f7870865 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -673,8 +673,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 	gfn = gw->gfn | ((addr & PT_LVL_OFFSET_MASK(gw->level)) >> PAGE_SHIFT);
 	base_gfn = gfn;
 
-	if (max_level > PT_PAGE_TABLE_LEVEL)
-		transparent_hugepage_adjust(vcpu, gw->gfn, &pfn, &hlevel);
+	transparent_hugepage_adjust(vcpu, gw->gfn, max_level, &pfn, &hlevel);
 
 	trace_kvm_mmu_spte_requested(addr, gw->level, pfn);
 
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

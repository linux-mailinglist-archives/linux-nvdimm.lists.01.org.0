Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE20134D5D
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 21:27:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A530710097DD0;
	Wed,  8 Jan 2020 12:30:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E05910097DEE
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jan 2020 12:30:26 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 12:27:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600";
   d="scan'208";a="211658398"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 12:27:07 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 13/14] KVM: x86/mmu: Remove lpage_is_disallowed() check from set_spte()
Date: Wed,  8 Jan 2020 12:24:47 -0800
Message-Id: <20200108202448.9669-14-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108202448.9669-1-sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID-Hash: C3UYIMVHNQHIVEQ3GK5Y3GXEWXX65XCU
X-Message-ID-Hash: C3UYIMVHNQHIVEQ3GK5Y3GXEWXX65XCU
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, Barret Rhoden <brho@google.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C3UYIMVHNQHIVEQ3GK5Y3GXEWXX65XCU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove the late "lpage is disallowed" check from set_spte() now that the
initial check is performed after acquiring mmu_lock.  Fold the guts of
the remaining helper, __mmu_gfn_lpage_is_disallowed(), into
kvm_mmu_hugepage_adjust() to eliminate the unnecessary slot !NULL check.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f2667fe0dc75..1e4e0ac169a7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1264,28 +1264,6 @@ static void unaccount_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 	list_del(&sp->lpage_disallowed_link);
 }
 
-static bool __mmu_gfn_lpage_is_disallowed(gfn_t gfn, int level,
-					  struct kvm_memory_slot *slot)
-{
-	struct kvm_lpage_info *linfo;
-
-	if (slot) {
-		linfo = lpage_info_slot(gfn, slot, level);
-		return !!linfo->disallow_lpage;
-	}
-
-	return true;
-}
-
-static bool mmu_gfn_lpage_is_disallowed(struct kvm_vcpu *vcpu, gfn_t gfn,
-					int level)
-{
-	struct kvm_memory_slot *slot;
-
-	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-	return __mmu_gfn_lpage_is_disallowed(gfn, level, slot);
-}
-
 static inline bool memslot_valid_for_gpte(struct kvm_memory_slot *slot,
 					  bool no_dirty_log)
 {
@@ -3078,18 +3056,6 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	spte |= (u64)pfn << PAGE_SHIFT;
 
 	if (pte_access & ACC_WRITE_MASK) {
-
-		/*
-		 * Legacy code to handle an obsolete scenario where a different
-		 * vcpu creates new sp in the window between this vcpu's query
-		 * of lpage_is_disallowed() and acquiring mmu_lock.  No longer
-		 * necessary now that lpage_is_disallowed() is called after
-		 * acquiring mmu_lock.
-		 */
-		if (level > PT_PAGE_TABLE_LEVEL &&
-		    mmu_gfn_lpage_is_disallowed(vcpu, gfn, level))
-			goto done;
-
 		spte |= PT_WRITABLE_MASK | SPTE_MMU_WRITEABLE;
 
 		/*
@@ -3121,7 +3087,6 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 set_pte:
 	if (mmu_spte_update(sptep, spte))
 		ret |= SET_SPTE_NEED_REMOTE_TLB_FLUSH;
-done:
 	return ret;
 }
 
@@ -3309,6 +3274,7 @@ static int kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 				   int max_level, kvm_pfn_t *pfnp)
 {
 	struct kvm_memory_slot *slot;
+	struct kvm_lpage_info *linfo;
 	kvm_pfn_t pfn = *pfnp;
 	kvm_pfn_t mask;
 	int level;
@@ -3326,7 +3292,8 @@ static int kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 
 	max_level = min(max_level, kvm_x86_ops->get_lpage_level());
 	for ( ; max_level > PT_PAGE_TABLE_LEVEL; max_level--) {
-		if (!__mmu_gfn_lpage_is_disallowed(gfn, max_level, slot))
+		linfo = lpage_info_slot(gfn, slot, max_level);
+		if (!linfo->disallow_lpage)
 			break;
 	}
 
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

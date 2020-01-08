Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51780134D4F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 21:27:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1092810097DB8;
	Wed,  8 Jan 2020 12:30:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0FE2310097DEE
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jan 2020 12:30:26 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 12:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600";
   d="scan'208";a="211658380"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 12:27:06 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 08/14] KVM: x86/mmu: Drop level optimization from fast_page_fault()
Date: Wed,  8 Jan 2020 12:24:42 -0800
Message-Id: <20200108202448.9669-9-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108202448.9669-1-sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID-Hash: ZW6P7JE3CCUQCNOI3Q6PFBJELM6BAS2K
X-Message-ID-Hash: ZW6P7JE3CCUQCNOI3Q6PFBJELM6BAS2K
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, Barret Rhoden <brho@google.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZW6P7JE3CCUQCNOI3Q6PFBJELM6BAS2K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove fast_page_fault()'s optimization to stop the shadow walk if the
iterator level drops below the intended map level.  The intended map
level is only acccurate for HugeTLB mappings (THP mappings are detected
after fast_page_fault()), i.e. it's not required for correctness, and
a future patch will also move HugeTLB mapping detection to after
fast_page_fault().

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4bd7f745b56d..7d78d1d996ed 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3593,7 +3593,7 @@ static bool is_access_allowed(u32 fault_err_code, u64 spte)
  * - true: let the vcpu to access on the same address again.
  * - false: let the real page fault path to fix it.
  */
-static bool fast_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, int level,
+static bool fast_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    u32 error_code)
 {
 	struct kvm_shadow_walk_iterator iterator;
@@ -3611,8 +3611,7 @@ static bool fast_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, int level,
 		u64 new_spte;
 
 		for_each_shadow_entry_lockless(vcpu, cr2_or_gpa, iterator, spte)
-			if (!is_shadow_present_pte(spte) ||
-			    iterator.level < level)
+			if (!is_shadow_present_pte(spte))
 				break;
 
 		sp = page_header(__pa(iterator.sptep));
@@ -4223,7 +4222,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	if (level > PT_PAGE_TABLE_LEVEL)
 		gfn &= ~(KVM_PAGES_PER_HPAGE(level) - 1);
 
-	if (fast_page_fault(vcpu, gpa, level, error_code))
+	if (fast_page_fault(vcpu, gpa, error_code))
 		return RET_PF_RETRY;
 
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

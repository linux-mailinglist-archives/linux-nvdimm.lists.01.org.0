Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F28C5134D4B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 21:27:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EEACB10097DAB;
	Wed,  8 Jan 2020 12:30:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EB3F010097DEE
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jan 2020 12:30:25 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 12:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600";
   d="scan'208";a="211658377"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 12:27:06 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/14] KVM: x86/mmu: Walk host page tables to find THP mappings
Date: Wed,  8 Jan 2020 12:24:41 -0800
Message-Id: <20200108202448.9669-8-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108202448.9669-1-sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID-Hash: EJO3CUZ6VUA4VPXTHHWDTY5WKA37255O
X-Message-ID-Hash: EJO3CUZ6VUA4VPXTHHWDTY5WKA37255O
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, Barret Rhoden <brho@google.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EJO3CUZ6VUA4VPXTHHWDTY5WKA37255O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Explicitly walk the host page tables to identify THP mappings instead
of relying solely on the metadata in struct page.  This sets the stage
for using a common method of identifying huge mappings regardless of the
underlying implementation (HugeTLB vs THB vs DAX), and hopefully avoids
the pitfalls of relying on metadata to identify THP mappings, e.g. see
commit 169226f7e0d2 ("mm: thp: handle page cache THP correctly in
PageTransCompoundMap") and the need for KVM to explicitly check for a
THP compound page.  KVM will also naturally work with 1gb THP pages, if
they are ever supported.

Walking the tables for THP mappings is likely marginally slower than
querying metadata, but a future patch will reuse the walk to identify
HugeTLB mappings, at which point eliminating the existing VMA lookup for
HugeTLB will make this a net positive.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Barret Rhoden <brho@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 30836899be73..4bd7f745b56d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3329,6 +3329,41 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
 	__direct_pte_prefetch(vcpu, sp, sptep);
 }
 
+static int host_pfn_mapping_level(struct kvm_vcpu *vcpu, gfn_t gfn,
+				  kvm_pfn_t pfn)
+{
+	struct kvm_memory_slot *slot;
+	unsigned long hva;
+	pte_t *pte;
+	int level;
+
+	BUILD_BUG_ON(PT_PAGE_TABLE_LEVEL != (int)PG_LEVEL_4K ||
+		     PT_DIRECTORY_LEVEL != (int)PG_LEVEL_2M ||
+		     PT_PDPE_LEVEL != (int)PG_LEVEL_1G);
+
+	if (!PageCompound(pfn_to_page(pfn)))
+		return PT_PAGE_TABLE_LEVEL;
+
+	/*
+	 * Manually do the equivalent of kvm_vcpu_gfn_to_hva() to avoid the
+	 * "writable" check in __gfn_to_hva_many(), which will always fail on
+	 * read-only memslots due to gfn_to_hva() assuming writes.  Earlier
+	 * page fault steps have already verified the guest isn't writing a
+	 * read-only memslot.
+	 */
+	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+	if (!memslot_valid_for_gpte(slot, true))
+		return PT_PAGE_TABLE_LEVEL;
+
+	hva = __gfn_to_hva_memslot(slot, gfn);
+
+	pte = lookup_address_in_mm(vcpu->kvm->mm, hva, &level);
+	if (unlikely(!pte))
+		return PT_PAGE_TABLE_LEVEL;
+
+	return level;
+}
+
 static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 					int max_level, kvm_pfn_t *pfnp,
 					int *levelp)
@@ -3344,10 +3379,11 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 	    kvm_is_zone_device_pfn(pfn))
 		return;
 
-	if (!kvm_is_transparent_hugepage(pfn))
+	level = host_pfn_mapping_level(vcpu, gfn, pfn);
+	if (level == PT_PAGE_TABLE_LEVEL)
 		return;
 
-	level = PT_DIRECTORY_LEVEL;
+	level = min(level, max_level);
 
 	/*
 	 * mmu_notifier_retry() was successful and mmu_lock is held, so
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

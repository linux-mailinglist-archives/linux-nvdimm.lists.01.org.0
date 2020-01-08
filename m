Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A620A134D5A
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 21:27:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4A03110097DC9;
	Wed,  8 Jan 2020 12:30:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3826410097DEE
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jan 2020 12:30:26 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 12:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600";
   d="scan'208";a="211658387"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 12:27:06 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 10/14] KVM: x86/mmu: Remove obsolete gfn restoration in FNAME(fetch)
Date: Wed,  8 Jan 2020 12:24:44 -0800
Message-Id: <20200108202448.9669-11-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108202448.9669-1-sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID-Hash: QOISZPZTAXRRJHMF5WRJTU2GCJCJ5LPU
X-Message-ID-Hash: QOISZPZTAXRRJHMF5WRJTU2GCJCJ5LPU
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, Barret Rhoden <brho@google.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QOISZPZTAXRRJHMF5WRJTU2GCJCJ5LPU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove logic to retrieve the original gfn now that HugeTLB mappings are
are identified in FNAME(fetch), i.e. FNAME(page_fault) no longer adjusts
the level or gfn.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 841506a55815..0560982eda8b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -621,7 +621,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 	struct kvm_shadow_walk_iterator it;
 	unsigned direct_access, access = gw->pt_access;
 	int top_level, hlevel, ret;
-	gfn_t gfn, base_gfn;
+	gfn_t base_gfn = gw->gfn;
 
 	direct_access = gw->pte_access;
 
@@ -666,13 +666,6 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 			link_shadow_page(vcpu, it.sptep, sp);
 	}
 
-	/*
-	 * FNAME(page_fault) might have clobbered the bottom bits of
-	 * gw->gfn, restore them from the virtual address.
-	 */
-	gfn = gw->gfn | ((addr & PT_LVL_OFFSET_MASK(gw->level)) >> PAGE_SHIFT);
-	base_gfn = gfn;
-
 	hlevel = kvm_mmu_hugepage_adjust(vcpu, gw->gfn, max_level, &pfn);
 
 	trace_kvm_mmu_spte_requested(addr, gw->level, pfn);
@@ -684,9 +677,9 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		 * We cannot overwrite existing page tables with an NX
 		 * large page, as the leaf could be executable.
 		 */
-		disallowed_hugepage_adjust(it, gfn, &pfn, &hlevel);
+		disallowed_hugepage_adjust(it, gw->gfn, &pfn, &hlevel);
 
-		base_gfn = gfn & ~(KVM_PAGES_PER_HPAGE(it.level) - 1);
+		base_gfn = gw->gfn & ~(KVM_PAGES_PER_HPAGE(it.level) - 1);
 		if (it.level == hlevel)
 			break;
 
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

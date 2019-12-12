Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD9611D416
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 18:34:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2E65E10113664;
	Thu, 12 Dec 2019 09:37:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A0D1710113661
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 09:37:36 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 09:34:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600";
   d="scan'208";a="364042068"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga004.jf.intel.com with ESMTP; 12 Dec 2019 09:34:13 -0800
Date: Thu, 12 Dec 2019 09:34:13 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Barret Rhoden <brho@google.com>
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
Message-ID: <20191212173413.GC3163@linux.intel.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191211213207.215936-3-brho@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Message-ID-Hash: SOIKCAQY77F6KGZKSTJMIYPOHQSWBETD
X-Message-ID-Hash: SOIKCAQY77F6KGZKSTJMIYPOHQSWBETD
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SOIKCAQY77F6KGZKSTJMIYPOHQSWBETD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 11, 2019 at 04:32:07PM -0500, Barret Rhoden wrote:
> This change allows KVM to map DAX-backed files made of huge pages with
> huge mappings in the EPT/TDP.
> 
> DAX pages are not PageTransCompound.  The existing check is trying to
> determine if the mapping for the pfn is a huge mapping or not.  For
> non-DAX maps, e.g. hugetlbfs, that means checking PageTransCompound.
> For DAX, we can check the page table itself.
> 
> Note that KVM already faulted in the page (or huge page) in the host's
> page table, and we hold the KVM mmu spinlock.  We grabbed that lock in
> kvm_mmu_notifier_invalidate_range_end, before checking the mmu seq.
> 
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6f92b40d798c..cd07bc4e595f 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3384,6 +3384,35 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  	return -EFAULT;
>  }
>  
> +static bool pfn_is_huge_mapped(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn)
> +{
> +	struct page *page = pfn_to_page(pfn);
> +	unsigned long hva;
> +
> +	if (!is_zone_device_page(page))
> +		return PageTransCompoundMap(page);
> +
> +	/*
> +	 * DAX pages do not use compound pages.  The page should have already
> +	 * been mapped into the host-side page table during try_async_pf(), so
> +	 * we can check the page tables directly.
> +	 */
> +	hva = gfn_to_hva(kvm, gfn);
> +	if (kvm_is_error_hva(hva))
> +		return false;
> +
> +	/*
> +	 * Our caller grabbed the KVM mmu_lock with a successful
> +	 * mmu_notifier_retry, so we're safe to walk the page table.
> +	 */
> +	switch (dev_pagemap_mapping_shift(hva, current->mm)) {
> +	case PMD_SHIFT:
> +	case PUD_SIZE:

I assume this means DAX can have 1GB pages?  I ask because KVM's THP logic
has historically relied on THP only supporting 2MB.  I cleaned this up in
a recent series[*], which is in kvm/queue, but I obviously didn't actually
test whether or not KVM would correctly handle 1GB non-hugetlbfs pages.

The easiest thing is probably to rebase on kvm/queue.  You'll need to do
that anyways, and I suspect doing so will help shake out any hiccups.

[*] https://lkml.kernel.org/r/20191206235729.29263-1-sean.j.christopherson@intel.com

> +		return true;
> +	}
> +	return false;
> +}
> +
>  static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
>  					gfn_t gfn, kvm_pfn_t *pfnp,
>  					int *levelp)
> @@ -3398,8 +3427,8 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
>  	 * here.
>  	 */
>  	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
> -	    !kvm_is_zone_device_pfn(pfn) && level == PT_PAGE_TABLE_LEVEL &&
> -	    PageTransCompoundMap(pfn_to_page(pfn)) &&
> +	    level == PT_PAGE_TABLE_LEVEL &&
> +	    pfn_is_huge_mapped(vcpu->kvm, gfn, pfn) &&
>  	    !mmu_gfn_lpage_is_disallowed(vcpu, gfn, PT_DIRECTORY_LEVEL)) {
>  		unsigned long mask;
>  		/*
> @@ -6015,8 +6044,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
>  		 * mapping if the indirect sp has level = 1.
>  		 */
>  		if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
> -		    !kvm_is_zone_device_pfn(pfn) &&
> -		    PageTransCompoundMap(pfn_to_page(pfn))) {
> +		    pfn_is_huge_mapped(kvm, sp->gfn, pfn)) {
>  			pte_list_remove(rmap_head, sptep);
>  
>  			if (kvm_available_flush_tlb_with_range())
> -- 
> 2.24.0.525.g8f36a354ae-goog
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

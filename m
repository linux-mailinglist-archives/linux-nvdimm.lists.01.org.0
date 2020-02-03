Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AFF1511D9
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 22:34:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 58D9E1007B8F5;
	Mon,  3 Feb 2020 13:38:08 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DFA5D10097E04
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 13:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RopiKUB7iog3vHCG/dVyQVRi17HY++IdZnq14RjmMqo=; b=qCNcTepKO/3xSSn/r68TuzJnKt
	b2OiqCyvcFUUCCCK6Cv9cMtmbBCWvbSY9HbCzoQ+nTTK6Pxo9KdDl8xjsD8mavlTxr7ffgM4bY5jI
	AODGNG2a/KJ1GGnInvzU2bGXJQvPtn8Zr75YRh7YBiM2wN1RwLhSBO+Dpq/R4gXUvmr2f4yVsBA2O
	+HQNwoIKHINdjxW34l2NoVYFStBBu88xEuAh/WLw1BQ9ds7XH6Lcjx9XTY2FLc8xLwLXQAOjFquka
	NX3t2BWf08QbBO6vk11n1FqvqNxg6EvK59GsxvC8Ev6WMc16PJw/v/43KKDud2wKo2JGkG+ghrgsv
	0jE6UybQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iyjMg-0004O9-7p; Mon, 03 Feb 2020 21:34:42 +0000
Date: Mon, 3 Feb 2020 13:34:42 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH RFC 01/10] mm: Add pmd support for _PAGE_SPECIAL
Message-ID: <20200203213442.GK8731@bombadil.infradead.org>
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
 <20200110190313.17144-2-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200110190313.17144-2-joao.m.martins@oracle.com>
Message-ID-Hash: WIBWZPXMODO4SW2W7DPOC7TK7VH3O4PC
X-Message-ID-Hash: WIBWZPXMODO4SW2W7DPOC7TK7VH3O4PC
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Barret Rhoden <brho@google.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WIBWZPXMODO4SW2W7DPOC7TK7VH3O4PC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 10, 2020 at 07:03:04PM +0000, Joao Martins wrote:
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -293,6 +293,15 @@ static inline int pgd_devmap(pgd_t pgd)
>  {
>  	return 0;
>  }
> +#endif
> +
> +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> +static inline int pmd_special(pmd_t pmd)
> +{
> +	return !!(pmd_flags(pmd) & _PAGE_SPECIAL);
> +}
> +#endif

The ifdef/endif don't make much sense here; x86 does have PTE_SPECIAL,
and this is an x86 header file, so that can be assumed.

> +++ b/mm/gup.c
> @@ -2079,6 +2079,9 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
>  	}
>  
> +	if (pmd_special(orig))
> +		return 0;

Here, you're calling it unconditionally.  I think you need a pmd_special()
conditionally defined in include/asm-generic/pgtable.h

+#ifndef CONFIG_ARCH_HAS_PTE_SPECIAL
+static inline bool pmd_special(pmd_t pmd)
+{
+	return false;
+}
+#endif

(oh, and plese use bool instead of int; I know that's different from
pte_special(), but pte_special() predates bool and nobody's done the work
to convert it yet)

> +++ b/mm/huge_memory.c
> @@ -791,6 +791,8 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
>  	if (pfn_t_devmap(pfn))
>  		entry = pmd_mkdevmap(entry);
> +	else if (pfn_t_special(pfn))
> +		entry = pmd_mkspecial(entry);

Again, we'll need a generic one.

> @@ -823,8 +825,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
>  	 * but we need to be consistent with PTEs and architectures that
>  	 * can't support a 'special' bit.
>  	 */
> -	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
> -			!pfn_t_devmap(pfn));
> +	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));

Should that rather be ...

+	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
+			!pfn_t_devmap(pfn) && !pfn_t_special(pfn));

I also think this comment needs adjusting:

        /*
         * There is no pmd_special() but there may be special pmds, e.g.
         * in a direct-access (dax) mapping, so let's just replicate the
         * !CONFIG_ARCH_HAS_PTE_SPECIAL case from vm_normal_page() here.
         */

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DCF2FC0E9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 Jan 2021 21:25:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 836CB100EBB7E;
	Tue, 19 Jan 2021 12:25:39 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B96CE100EBB7D
	for <linux-nvdimm@lists.01.org>; Tue, 19 Jan 2021 12:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3skarH8usgooZsIjjZg9m11Y8vaFLaunY8jfnB6wGPQ=; b=IcFHUlBLm4M8B7XITZrlaPwJZk
	PxLbfPfkfkOKcDtLlhfkXiUHka5CvTPb7hLgrgmT3Ja+UqcHjN9zY1H6Tmg+WZOu5IRktFRwdo/cS
	V9j3hg1Ow8RITENXtDtJLmBCwghrrgT8ZPHCKw/4HQvv4xpai+rfbtNKnht6rSRWFZHmep0AFdaLc
	WpT0BIFZXKaOI1hvNwPxLTcH2Gpj0LlBuWbpsOxA9rDZtRWPCXjXziJFZX6g2OZYB33LP00RMcFkb
	3de7nf3N03r6bUtfXPBA8XywS5tDj8kVNevPplCpPm+FZKgebPUFH+9MEl3Zc+oBbVK/fmh04LESS
	xKXNl/dg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l1xW1-00EmeP-RV; Tue, 19 Jan 2021 20:22:22 +0000
Date: Tue, 19 Jan 2021 20:22:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v14 05/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210119202213.GI2260413@casper.infradead.org>
References: <20201203062949.5484-1-rppt@kernel.org>
 <20201203062949.5484-6-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201203062949.5484-6-rppt@kernel.org>
Message-ID-Hash: CDDZRKEN6KKT5HKYGIPDGUAHD3S36PRM
X-Message-ID-Hash: CDDZRKEN6KKT5HKYGIPDGUAHD3S36PRM
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon
  <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CDDZRKEN6KKT5HKYGIPDGUAHD3S36PRM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 03, 2020 at 08:29:44AM +0200, Mike Rapoport wrote:
> +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> +{
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> +	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	pgoff_t offset = vmf->pgoff;
> +	vm_fault_t ret = 0;
> +	unsigned long addr;
> +	struct page *page;
> +	int err;
> +
> +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> +		return vmf_error(-EINVAL);
> +
> +	page = find_get_page(mapping, offset);
> +	if (!page) {
> +
> +		page = secretmem_alloc_page(vmf->gfp_mask);
> +		if (!page)
> +			return vmf_error(-ENOMEM);

Just use VM_FAULT_OOM directly.

> +		err = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
> +		if (unlikely(err))
> +			goto err_put_page;

What if the error is EEXIST because somebody else raced with you to add
a new page to the page cache?

> +		err = set_direct_map_invalid_noflush(page, 1);
> +		if (err)
> +			goto err_del_page_cache;

Does this work correctly if somebody else has a reference to the page
in the meantime?

> +		addr = (unsigned long)page_address(page);
> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +
> +		__SetPageUptodate(page);

Once you've added it to the cache, somebody else can come along and try
to lock it.  They will set PageWaiter.  Now you call __SetPageUptodate
and wipe out their PageWaiter bit.  So you won't wake them up when you
unlock.

You can call __SetPageUptodate before adding it to the page cache,
but once it's visible to another thread, you can't do that.

> +		ret = VM_FAULT_LOCKED;
> +	}
> +
> +	vmf->page = page;

You're supposed to return the page locked, so use find_lock_page() instead
of find_get_page().

> +	return ret;
> +
> +err_del_page_cache:
> +	delete_from_page_cache(page);
> +err_put_page:
> +	put_page(page);
> +	return vmf_error(err);
> +}
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

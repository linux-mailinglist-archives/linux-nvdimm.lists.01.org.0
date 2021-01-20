Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF92FD363
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 16:05:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4F3E100EB83E;
	Wed, 20 Jan 2021 07:05:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DE929100EB83E
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 07:05:25 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A01A23356;
	Wed, 20 Jan 2021 15:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1611155125;
	bh=9874V4EQF8pGhQeRtiLlHuHTZWGypK1q+CZx02TXhZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVer5+wzd/VviGPx62NgeNadLX736EMkLOQOVHuy+k8sx0BcR+ivCEkKsnZIoxtnT
	 GpWkXKSHUVrX3tMi+iQiZNVYUchhp0zB4TrjPy0CuHAyWgurs4kWeeuPwxfawgBGve
	 xWg9JGEgJG54bZgaB141RZ4cuaX9zxlmp5uYxxVFC9vITcsuqfvwAakLkytsiWOGfL
	 pNtcU5EE62T/qNQ15LxVmcJccjD7XRVg6hOvj3C8536te+4LBKab+YM8J44PRYhLZX
	 NgPhXfCDCBlcUFMljfwDktrV1a/D2LNFJaqimj3Xi9rVUzUTR1HHM4iQVtrs0WE0Q2
	 /+v3XgxNylKfQ==
Date: Wed, 20 Jan 2021 17:05:10 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v14 05/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210120150510.GO1106298@kernel.org>
References: <20201203062949.5484-1-rppt@kernel.org>
 <20201203062949.5484-6-rppt@kernel.org>
 <20210119202213.GI2260413@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119202213.GI2260413@casper.infradead.org>
Message-ID-Hash: VZO6CAHTAEZPR4XTJ2L7327P2HKDZAUV
X-Message-ID-Hash: VZO6CAHTAEZPR4XTJ2L7327P2HKDZAUV
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon
  <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VZO6CAHTAEZPR4XTJ2L7327P2HKDZAUV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 19, 2021 at 08:22:13PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 03, 2020 at 08:29:44AM +0200, Mike Rapoport wrote:
> > +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > +{
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > +	struct inode *inode = file_inode(vmf->vma->vm_file);
> > +	pgoff_t offset = vmf->pgoff;
> > +	vm_fault_t ret = 0;
> > +	unsigned long addr;
> > +	struct page *page;
> > +	int err;
> > +
> > +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > +		return vmf_error(-EINVAL);
> > +
> > +	page = find_get_page(mapping, offset);
> > +	if (!page) {
> > +
> > +		page = secretmem_alloc_page(vmf->gfp_mask);
> > +		if (!page)
> > +			return vmf_error(-ENOMEM);
> 
> Just use VM_FAULT_OOM directly.
 
Ok.

> > +		err = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
> > +		if (unlikely(err))
> > +			goto err_put_page;
> 
> What if the error is EEXIST because somebody else raced with you to add
> a new page to the page cache?

Right, for -EEXIST I need a retry here, thanks.

> > +		err = set_direct_map_invalid_noflush(page, 1);
> > +		if (err)
> > +			goto err_del_page_cache;
> 
> Does this work correctly if somebody else has a reference to the page
> in the meantime?

Yes, it does. If somebody else won the race that page was dropped from the
direct map and this call would be essentially a nop. And anyway, the very
next patch changes the way pages are removed from the direct map ;-)

> > +		addr = (unsigned long)page_address(page);
> > +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +
> > +		__SetPageUptodate(page);
> 
> Once you've added it to the cache, somebody else can come along and try
> to lock it.  They will set PageWaiter.  Now you call __SetPageUptodate
> and wipe out their PageWaiter bit.  So you won't wake them up when you
> unlock.
> 
> You can call __SetPageUptodate before adding it to the page cache,
> but once it's visible to another thread, you can't do that.

Will fix.

> > +		ret = VM_FAULT_LOCKED;
> > +	}
> > +
> > +	vmf->page = page;
> 
> You're supposed to return the page locked, so use find_lock_page() instead
> of find_get_page().

Ok/
 
> > +	return ret;
> > +
> > +err_del_page_cache:
> > +	delete_from_page_cache(page);
> > +err_put_page:
> > +	put_page(page);
> > +	return vmf_error(err);
> > +}

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

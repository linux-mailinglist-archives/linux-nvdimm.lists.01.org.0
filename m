Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BCF2B3308
	for <lists+linux-nvdimm@lfdr.de>; Sun, 15 Nov 2020 09:53:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 82D7E100EF270;
	Sun, 15 Nov 2020 00:53:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 53C25100EF26F
	for <linux-nvdimm@lists.01.org>; Sun, 15 Nov 2020 00:53:24 -0800 (PST)
Received: from kernel.org (unknown [77.125.7.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 3E7962242E;
	Sun, 15 Nov 2020 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1605430403;
	bh=zogKbmLR5WuYYhS1A9PyjE2BBFUNYgIBXxOPOFu4jUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lX2fpz594y7d/5i/mEef+AbbnIJzikgvOzNnoqSfFlQrJb9q90Elp66aOiMYcs1zs
	 TTHjnJQu5Da13GIKSCOa/J3DAETZs6oYZ3AL3AqwfPmxmxZFENcF3lAkHuh559m70/
	 7Mni0kOKQphJSxWriCKyHTtX74+IDbuZ2lYSWHfw=
Date: Sun, 15 Nov 2020 10:53:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 4/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201115085307.GV4758@kernel.org>
References: <20201110151444.20662-1-rppt@kernel.org>
 <20201110151444.20662-5-rppt@kernel.org>
 <20201113135848.GF17076@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201113135848.GF17076@casper.infradead.org>
Message-ID-Hash: 6XS4QHQIZWWZPQCICETBP26ZTEND7DGX
X-Message-ID-Hash: 6XS4QHQIZWWZPQCICETBP26ZTEND7DGX
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.ker
 nel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6XS4QHQIZWWZPQCICETBP26ZTEND7DGX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 13, 2020 at 01:58:48PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 10, 2020 at 05:14:39PM +0200, Mike Rapoport wrote:
> > +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > +{
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > +	struct inode *inode = file_inode(vmf->vma->vm_file);
> > +	pgoff_t offset = vmf->pgoff;
> > +	unsigned long addr;
> > +	struct page *page;
> > +	int ret = 0;
> > +
> > +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > +		return vmf_error(-EINVAL);
> > +
> > +	page = find_get_entry(mapping, offset);
> 
> Why did you decide to use find_get_entry() here?  You don't handle
> swap or shadow entries.

Right, I've missed that. 

> > +	if (!page) {
> > +		page = secretmem_alloc_page(vmf->gfp_mask);
> > +		if (!page)
> > +			return vmf_error(-EINVAL);
> 
> Why is this EINVAL and not ENOMEM?

Ah, I was annoyed by OOMs I got when I simulated various allocation
failures, so I changed it to get SIGBUS instead and than forgot to restore.
Will fix.

> > +		ret = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
> > +		if (unlikely(ret))
> > +			goto err_put_page;
> > +
> > +		ret = set_direct_map_invalid_noflush(page, 1);
> > +		if (ret)
> > +			goto err_del_page_cache;
> > +
> > +		addr = (unsigned long)page_address(page);
> > +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +
> > +		__SetPageUptodate(page);
> > +
> > +		ret = VM_FAULT_LOCKED;
> > +	}
> > +
> > +	vmf->page = page;
> > +	return ret;
> 
> Does sparse not warn you about this abuse of vm_fault_t?  Separate out
> 'ret' and 'err'.
 
Will fix.

> Andrew, please fold in this fix.  I suspect Mike will want to fix
> the other things I mention above.
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 3dfdbd85ba00..09ca27f21661 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -172,7 +172,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>  		return vmf_error(-EINVAL);
>  
> -	page = find_get_entry(mapping, offset);
> +	page = find_get_page(mapping, offset);
>  	if (!page) {
>  		page = secretmem_alloc_page(ctx, vmf->gfp_mask);
>  		if (!page)

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

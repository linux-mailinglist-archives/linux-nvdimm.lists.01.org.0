Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368EF2B1CC7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Nov 2020 14:59:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6DE0A100EB827;
	Fri, 13 Nov 2020 05:59:21 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C06D100EBB9A
	for <linux-nvdimm@lists.01.org>; Fri, 13 Nov 2020 05:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kLz22mCweLR//KhTGZZOStZT7C8x0TEcQ4+GK8a3nck=; b=hxEERjlxxEGjzKsTREmAdvVMX3
	IS8qSDrsGEqirPWQHguhpGtopsaES8pCsNt+5gHN8a/l860hbWdnv6UVaJOHhGDnFQnRtRL9NEZwl
	2fcVThumtrCipwpdqKaCwPmlfcghO0WScHCRcAU1iMyaTWAGG/jBa37pH6nsqY35UG7jilrUB+aWP
	Cf/AoroggY7hCjRgzQQcjmCTa0hZmV6VXmztqO0wdT3NMa5zgbf/5yIxQaBty5jexorzuyz41NXfF
	d6LgpX1xryRRN/FkiBND/OVPDPCEATMfBEwLPQlSYWYq21IP2C/aDonZmnwPhyokSwlrknmvJAjZ8
	ZU/3bYeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdZbE-0003f3-8l; Fri, 13 Nov 2020 13:58:48 +0000
Date: Fri, 13 Nov 2020 13:58:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v8 4/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201113135848.GF17076@casper.infradead.org>
References: <20201110151444.20662-1-rppt@kernel.org>
 <20201110151444.20662-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201110151444.20662-5-rppt@kernel.org>
Message-ID-Hash: TWINF5N6R3ROQE7HBF52OOQPPIFUAPSW
X-Message-ID-Hash: TWINF5N6R3ROQE7HBF52OOQPPIFUAPSW
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.ker
 nel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TWINF5N6R3ROQE7HBF52OOQPPIFUAPSW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 10, 2020 at 05:14:39PM +0200, Mike Rapoport wrote:
> +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> +{
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> +	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	pgoff_t offset = vmf->pgoff;
> +	unsigned long addr;
> +	struct page *page;
> +	int ret = 0;
> +
> +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> +		return vmf_error(-EINVAL);
> +
> +	page = find_get_entry(mapping, offset);

Why did you decide to use find_get_entry() here?  You don't handle
swap or shadow entries.

> +	if (!page) {
> +		page = secretmem_alloc_page(vmf->gfp_mask);
> +		if (!page)
> +			return vmf_error(-EINVAL);

Why is this EINVAL and not ENOMEM?

> +		ret = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
> +		if (unlikely(ret))
> +			goto err_put_page;
> +
> +		ret = set_direct_map_invalid_noflush(page, 1);
> +		if (ret)
> +			goto err_del_page_cache;
> +
> +		addr = (unsigned long)page_address(page);
> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +
> +		__SetPageUptodate(page);
> +
> +		ret = VM_FAULT_LOCKED;
> +	}
> +
> +	vmf->page = page;
> +	return ret;

Does sparse not warn you about this abuse of vm_fault_t?  Separate out
'ret' and 'err'.


Andrew, please fold in this fix.  I suspect Mike will want to fix
the other things I mention above.

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 3dfdbd85ba00..09ca27f21661 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -172,7 +172,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
 		return vmf_error(-EINVAL);
 
-	page = find_get_entry(mapping, offset);
+	page = find_get_page(mapping, offset);
 	if (!page) {
 		page = secretmem_alloc_page(ctx, vmf->gfp_mask);
 		if (!page)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

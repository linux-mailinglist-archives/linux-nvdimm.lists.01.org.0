Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FFA2C236F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Nov 2020 12:00:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F35F100EB82D;
	Tue, 24 Nov 2020 03:00:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=cmarinas@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CC64A100EF252
	for <linux-nvdimm@lists.01.org>; Tue, 24 Nov 2020 02:59:57 -0800 (PST)
Received: from gaia (unknown [95.146.230.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id BBA3E2076B;
	Tue, 24 Nov 2020 10:59:50 +0000 (UTC)
Date: Tue, 24 Nov 2020 10:59:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v11 4/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201124105947.GA5527@gaia>
References: <20201124092556.12009-1-rppt@kernel.org>
 <20201124092556.12009-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201124092556.12009-5-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: W2FI2BDYLQ3FMT4ARLHWXZOEWCBGQOA3
X-Message-ID-Hash: W2FI2BDYLQ3FMT4ARLHWXZOEWCBGQOA3
X-MailFrom: cmarinas@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel
 .org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W2FI2BDYLQ3FMT4ARLHWXZOEWCBGQOA3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Mike,

On Tue, Nov 24, 2020 at 11:25:51AM +0200, Mike Rapoport wrote:
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
> +
> +		err = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
> +		if (unlikely(err))
> +			goto err_put_page;
> +
> +		err = set_direct_map_invalid_noflush(page, 1);
> +		if (err)
> +			goto err_del_page_cache;

On arm64, set_direct_map_default_noflush() returns 0 if !rodata_full but
no pgtable changes happen since the linear map can be a mix of small and
huge pages. The arm64 implementation doesn't break large mappings. I
presume we don't want to tell the user that the designated memory is
"secret" but the kernel silently ignored it.

We could change the arm64 set_direct_map* to return an error, however, I
think it would be pretty unexpected for the user to get a fault when
trying to access it. It may be better to return a -ENOSYS or something
on the actual syscall if the fault-in wouldn't be allowed later.

Alternatively, we could make the linear map always use pages on arm64,
irrespective of other config or cmdline options (maybe not justified
unless we have clear memsecret users). Yet another idea is to get
set_direct_map* to break pmd/pud mappings into pte but that's not always
possible without a stop_machine() and potentially disabling the MMU.

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
> +
> +err_del_page_cache:
> +	delete_from_page_cache(page);
> +err_put_page:
> +	put_page(page);
> +	return vmf_error(err);
> +}

-- 
Catalin
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

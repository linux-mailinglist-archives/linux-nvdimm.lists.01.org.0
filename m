Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94B234774
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jul 2020 16:10:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C7D29128E42CD;
	Fri, 31 Jul 2020 07:10:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=cmarinas@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 64F89128CBC2C
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 07:10:39 -0700 (PDT)
Received: from gaia (unknown [95.146.230.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 52369206DA;
	Fri, 31 Jul 2020 14:10:34 +0000 (UTC)
Date: Fri, 31 Jul 2020 15:10:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 3/7] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200731141031.GD29569@gaia>
References: <20200727162935.31714-1-rppt@kernel.org>
 <20200727162935.31714-4-rppt@kernel.org>
 <20200730162209.GB3128@gaia>
 <20200730204409.GB534153@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200730204409.GB534153@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: B2VUHDWYETYTHAKHYSB6ZCGCWITPFWSH
X-Message-ID-Hash: B2VUHDWYETYTHAKHYSB6ZCGCWITPFWSH
X-MailFrom: cmarinas@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.
 org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B2VUHDWYETYTHAKHYSB6ZCGCWITPFWSH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 30, 2020 at 11:44:09PM +0300, Mike Rapoport wrote:
> On Thu, Jul 30, 2020 at 05:22:10PM +0100, Catalin Marinas wrote:
> > On Mon, Jul 27, 2020 at 07:29:31PM +0300, Mike Rapoport wrote:
> > > For instance, the following example will create an uncached mapping (error
> > > handling is omitted):
> > > 
> > > 	fd = memfd_secret(SECRETMEM_UNCACHED);
> > > 	ftruncate(fd, MAP_SIZE);
> > > 	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
[...]
> > > +static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
> > > +{
> > > +	struct secretmem_ctx *ctx = file->private_data;
> > > +	unsigned long mode = ctx->mode;
> > > +	unsigned long len = vma->vm_end - vma->vm_start;
> > > +
> > > +	if (!mode)
> > > +		return -EINVAL;
> > > +
> > > +	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> > > +		return -EINVAL;
> > > +
> > > +	if (mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
> > > +		return -EAGAIN;
> > > +
> > > +	switch (mode) {
> > > +	case SECRETMEM_UNCACHED:
> > > +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > +		fallthrough;
> > > +	case SECRETMEM_EXCLUSIVE:
> > > +		vma->vm_ops = &secretmem_vm_ops;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	vma->vm_flags |= VM_LOCKED;
> > > +
> > > +	return 0;
> > > +}
> > 
> > I think the uncached mapping is not the right thing for arm/arm64. First
> > of all, pgprot_noncached() gives us Strongly Ordered (Device memory)
> > semantics together with not allowing unaligned accesses. I suspect the
> > semantics are different on x86.
>  
> Hmm, on x86 it's also Strongly Ordered, but I didn't find any alignment
> restrictions. Is there a mode for arm64 that can provide similar
> semantics?
> 
> Would it make sence to use something like
> 
> #define pgprot_uncached(prot) \
> 	__pgprot_modify(prot, PTE_ATTRINDX_MASK, \
> 			PTE_ATTRINDX(MT_NORMAL_NC) | PTE_PXN)
> 
> or is it too weak?

Reading Elena's email, that's about preventing speculative loads. While
the arm64 Normal NC is non-cacheable (equivalent to write-combine), a
CPU is allowed to speculatively read from it. A carefully crafted gadget
could leave an imprint on a different part of the cache via speculative
execution based on a value in the secret memory. So IIUC, we want memory
that cannot be speculatively loaded from and that would be Device memory
on arm64 (with the alignment restrictions).

Now, I think we could relax this to Device_GRE. So maybe add a
pgprot_nospec() and allow architectures to define whatever they find
suitable. The exact semantics will be different between architectures.

> > The second, more serious problem, is that I can't find any place where
> > the caches are flushed for the page mapped on fault. When a page is
> > allocated, assuming GFP_ZERO, only the caches are guaranteed to be
> > zeroed. Exposing this subsequently to user space as uncached would allow
> > the user to read stale data prior to zeroing. The arm64
> > set_direct_map_default_noflush() doesn't do any cache maintenance.
> 
> Well, the idea of uncached mappings came from Elena [1] to prevent
> possibility of side channels that leak user space memory. So I think
> even without cache flushing after the allocation, user space is
> protected as all its memory accesses bypass cache so even after the page
> is freed there won't be stale data in the cache.
> 
> I think that it makes sense to limit SECRETMEM_UNCACHED only for
> architectures that define an appropriate protection, e.g.
> pgprot_uncahced(). For x86 it can be aliased to pgprot_noncached() and
> other architecures can define their versions.

Indeed, though as I said above, maybe use a name that suggests no
speculation since non-cacheable doesn't always guarantee that. Something
like pgprot_nospec() and SECRETMEM_NOSPEC.

However, your implementation still has the problem that such memory must
have the caches flushed before being mapped in user-space, otherwise we
leak other secrets via such pages to the caller. The only generic API we
have in the kernel for such things is the DMA one. If hch doesn't mind,
you could abuse it and call arch_dma_prep_coherent() prior to
set_direct_map_invalid_noflush() (if the mapping is non-cacheable).

-- 
Catalin
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

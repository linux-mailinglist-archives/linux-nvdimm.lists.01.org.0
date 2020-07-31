Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D23E23491F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jul 2020 18:22:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6466112918A65;
	Fri, 31 Jul 2020 09:22:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=cmarinas@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8549612918A61
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 09:22:42 -0700 (PDT)
Received: from gaia (unknown [95.146.230.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1B0052177B;
	Fri, 31 Jul 2020 16:22:36 +0000 (UTC)
Date: Fri, 31 Jul 2020 17:22:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/7] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200731162234.GF29569@gaia>
References: <20200727162935.31714-1-rppt@kernel.org>
 <20200727162935.31714-4-rppt@kernel.org>
 <20200730162209.GB3128@gaia>
 <20200731142905.GA67415@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200731142905.GA67415@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: MBGGTEVDAZ4KERO536EKRS4YWEKGTOV2
X-Message-ID-Hash: MBGGTEVDAZ4KERO536EKRS4YWEKGTOV2
X-MailFrom: cmarinas@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel
 @vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MBGGTEVDAZ4KERO536EKRS4YWEKGTOV2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 31, 2020 at 03:29:05PM +0100, Mark Rutland wrote:
> On Thu, Jul 30, 2020 at 05:22:10PM +0100, Catalin Marinas wrote:
> > On Mon, Jul 27, 2020 at 07:29:31PM +0300, Mike Rapoport wrote:
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
> > The second, more serious problem, is that I can't find any place where
> > the caches are flushed for the page mapped on fault. When a page is
> > allocated, assuming GFP_ZERO, only the caches are guaranteed to be
> > zeroed. Exposing this subsequently to user space as uncached would allow
> > the user to read stale data prior to zeroing. The arm64
> > set_direct_map_default_noflush() doesn't do any cache maintenance.
> 
> It's also worth noting that in a virtual machine this is liable to be
> either broken (with a potential loss of coherency if the host has a
> cacheable alias as existing KVM hosts have), or pointless (if the host
> uses S2FWB to upgrade Stage-1 attribues to cacheable as existing KVM
> hosts also have).
> 
> I think that trying to avoid the data caches creates many more problems
> than it solves, and I don't think there's a strong justification for
> trying to support that on arm64 to begin with, so I'd rather entirely
> opt-out on supporting SECRETMEM_UNCACHED.

Good point, I forgot the virtualisation aspect. So unless there is a
hypervisor API to unmap it from the host memory, the uncached option
isn't of much use on arm64.

-- 
Catalin
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

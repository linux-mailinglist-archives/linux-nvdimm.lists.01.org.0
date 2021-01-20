Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF1B2FD4D9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 17:04:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 14325100EB848;
	Wed, 20 Jan 2021 08:04:37 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7EBBA100EB847
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 08:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=saaFHJth3qz3xI0Dro7UHa0PgnHwAKKwZMU5+56dtJE=; b=ZACVPHDnW8nMnHToaApes5g3Rw
	YvejBi+ndU51oeSrxqqcYYLAwliMBGBXghPXPYc7XG0lsgIcf+/IvR9eJvgtCr1Y5bxBLOsNZcLBQ
	vxSb7WDqPTplOeChJJO0bdqf2couRLArJqCqj+JJHVlMqYUasnii5Ahu8a9pr17qMCP5jWMHxkGSS
	q6aEdJuVPlms8bTXRO0qZ2BUkaKlzq/5TxYAwU0Ad6+fh/jU8PXLs9HsRV6qDt9A/EPq+R0dOuJcM
	Lpx6Y1tpfz20HDKCh6YfbGEj7XSx+aNMkVsZzAS1FtW9RnCqIaJmYKn7ticVopJumXn3gPadcnzNH
	uNwqFTFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l2Fvu-00Fsqd-9M; Wed, 20 Jan 2021 16:02:37 +0000
Date: Wed, 20 Jan 2021 16:02:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v14 05/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210120160210.GK2260413@casper.infradead.org>
References: <20201203062949.5484-1-rppt@kernel.org>
 <20201203062949.5484-6-rppt@kernel.org>
 <20210119202213.GI2260413@casper.infradead.org>
 <20210120150510.GO1106298@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210120150510.GO1106298@kernel.org>
Message-ID-Hash: SFQDUDVBJ4QIUXF55IEQR53KJ5P5MJS3
X-Message-ID-Hash: SFQDUDVBJ4QIUXF55IEQR53KJ5P5MJS3
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon
  <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SFQDUDVBJ4QIUXF55IEQR53KJ5P5MJS3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 20, 2021 at 05:05:10PM +0200, Mike Rapoport wrote:
> On Tue, Jan 19, 2021 at 08:22:13PM +0000, Matthew Wilcox wrote:
> > On Thu, Dec 03, 2020 at 08:29:44AM +0200, Mike Rapoport wrote:
> > > +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > > +{
> > > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > > +	struct inode *inode = file_inode(vmf->vma->vm_file);
> > > +	pgoff_t offset = vmf->pgoff;
> > > +	vm_fault_t ret = 0;
> > > +	unsigned long addr;
> > > +	struct page *page;
> > > +	int err;
> > > +
> > > +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > > +		return vmf_error(-EINVAL);
> > > +
> > > +	page = find_get_page(mapping, offset);
> > > +	if (!page) {
> > > +
> > > +		page = secretmem_alloc_page(vmf->gfp_mask);
> > > +		if (!page)
> > > +			return vmf_error(-ENOMEM);
> > 
> > Just use VM_FAULT_OOM directly.
>  
> Ok.
> 
> > > +		err = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
> > > +		if (unlikely(err))
> > > +			goto err_put_page;
> > 
> > What if the error is EEXIST because somebody else raced with you to add
> > a new page to the page cache?
> 
> Right, for -EEXIST I need a retry here, thanks.
> 
> > > +		err = set_direct_map_invalid_noflush(page, 1);
> > > +		if (err)
> > > +			goto err_del_page_cache;
> > 
> > Does this work correctly if somebody else has a reference to the page
> > in the meantime?
> 
> Yes, it does. If somebody else won the race that page was dropped from the
> direct map and this call would be essentially a nop. And anyway, the very
> next patch changes the way pages are removed from the direct map ;-)

What I'm thinking is:

thread A page faults
doesn't find page
allocates page
adds page to page cache
				thread B page faults
				does find page in page cache
set direct map invalid fails
deletes from page cache
				... ?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

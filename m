Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1DC2CBA3F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Dec 2020 11:14:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C858100EBBC7;
	Wed,  2 Dec 2020 02:14:35 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D690D100EBBC6
	for <linux-nvdimm@lists.01.org>; Wed,  2 Dec 2020 02:14:32 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A56B67373; Wed,  2 Dec 2020 11:14:27 +0100 (CET)
Date: Wed, 2 Dec 2020 11:14:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v3 3/6] mm: support THP migration to device private
 memory
Message-ID: <20201202101426.GC7597@lst.de>
References: <20201106005147.20113-1-rcampbell@nvidia.com> <20201106005147.20113-4-rcampbell@nvidia.com> <20201106080322.GE31341@lst.de> <a7b8b90c-09b7-2009-0784-908b61f61ef2@nvidia.com> <20201109091415.GC28918@lst.de> <bbf1f0df-85f3-5887-050e-beb2aad750f2@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bbf1f0df-85f3-5887-050e-beb2aad750f2@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: 3IM37YW4XF654JN7ONRXQ7KV7PNF5B7N
X-Message-ID-Hash: 3IM37YW4XF654JN7ONRXQ7KV7PNF5B7N
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org, nouveau@lists.freedesktop.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Bharata B Rao <bharata@linux.ibm.com>, Zi Yan <ziy@nvidia.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Yang Shi <yang.shi@linux.alibaba.com>, Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Logan Gunthorpe <logang@deltatee.com>, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3IM37YW4XF654JN7ONRXQ7KV7PNF5B7N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[adding a few of the usual suspects]

On Wed, Nov 11, 2020 at 03:38:42PM -0800, Ralph Campbell wrote:
> There are 4 types of ZONE_DEVICE struct pages:
> MEMORY_DEVICE_PRIVATE, MEMORY_DEVICE_FS_DAX, MEMORY_DEVICE_GENERIC, and
> MEMORY_DEVICE_PCI_P2PDMA.
>
> Currently, memremap_pages() allocates struct pages for a physical address range
> with a page_ref_count(page) of one and increments the pgmap->ref per CPU
> reference count by the number of pages created since each ZONE_DEVICE struct
> page has a pointer to the pgmap.
>
> The struct pages are not freed until memunmap_pages() is called which
> calls put_page() which calls put_dev_pagemap() which releases a reference to
> pgmap->ref. memunmap_pages() blocks waiting for pgmap->ref reference count
> to be zero. As far as I can tell, the put_page() in memunmap_pages() has to
> be the *last* put_page() (see MEMORY_DEVICE_PCI_P2PDMA).
> My RFC [1] breaks this put_page() -> put_dev_pagemap() connection so that
> the struct page reference count can go to zero and back to non-zero without
> changing the pgmap->ref reference count.
>
> Q1: Is that safe? Is there some code that depends on put_page() dropping
> the pgmap->ref reference count as part of memunmap_pages()?
> My testing of [1] seems OK but I'm sure there are lots of cases I didn't test.

It should be safe, but the audit you've done is important to make sure
we do not miss anything important.

> MEMORY_DEVICE_PCI_P2PDMA:
> Struct pages are created in pci_p2pdma_add_resource() and represent device
> memory accessible by PCIe bar address space. Memory is allocated with
> pci_alloc_p2pmem() based on a byte length but the gen_pool_alloc_owner()
> call will allocate memory in a minimum of PAGE_SIZE units.
> Reference counting is +1 per *allocation* on the pgmap->ref reference count.
> Note that this is not +1 per page which is what put_page() expects. So
> currently, a get_page()/put_page() works OK because the page reference count
> only goes 1->2 and 2->1. If it went to zero, the pgmap->ref reference count
> would be incorrect if the allocation size was greater than one page.
>
> I see pci_alloc_p2pmem() is called by nvme_alloc_sq_cmds() and
> pci_p2pmem_alloc_sgl() to create a command queue and a struct scatterlist *.
> Looks like sg_page(sg) returns the ZONE_DEVICE struct page of the scatterlist.
> There are a huge number of places sg_page() is called so it is hard to tell
> whether or not get_page()/put_page() is ever called on MEMORY_DEVICE_PCI_P2PDMA
> pages.

Nothing should call get_page/put_page on them, as they are not treated
as refcountable memory.  More importantly nothing is allowed to keep
a reference longer than the time of the I/O.

> pci_p2pmem_virt_to_bus() will return the physical address and I guess
> pfn_to_page(physaddr >> PAGE_SHIFT) could return the struct page.
>
> Since there is a clear allocation/free, pci_alloc_p2pmem() can probably be
> modified to increment/decrement the MEMORY_DEVICE_PCI_P2PDMA struct page
> reference count. Or maybe just leave it at one like it is now.

And yes, doing that is probably a sensible safe guard.

> MEMORY_DEVICE_FS_DAX:
> Struct pages are created in pmem_attach_disk() and virtio_fs_setup_dax() with
> an initial reference count of one.
> The problem I see is that there are 3 states that are important:
> a) memory is free and not allocated to any file (page_ref_count() == 0).
> b) memory is allocated to a file and in the page cache (page_ref_count() == 1).
> c) some gup() or I/O has a reference even after calling unmap_mapping_pages()
>    (page_ref_count() > 1). ext4_break_layouts() basically waits until the
>    page_ref_count() == 1 with put_page() calling wake_up_var(&page->_refcount)
>    to wake up ext4_break_layouts().
> The current code doesn't seem to distinguish (a) and (b). If we want to use
> the 0->1 reference count to signal (c), then the page cache would have hold
> entries with a page_ref_count() == 0 which doesn't match the general page cache

I think the sensible model here is to grab a reference when it is
added to the page cache.  That is exactly how normal system memory pages
work.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DA77B8F8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Jul 2019 07:07:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7568C212E8433;
	Tue, 30 Jul 2019 22:10:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=obuil.liubo@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7D74F212E13C8
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 22:10:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d17so65210712qtj.8
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 22:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zaYsNFY5qEzjaDZ2NFrMjLxUGuOXjiz3gZ6Lx9T3hm8=;
 b=iMAQGkNoxULTd5UF4Sx3hVuUcWg3yi5DUIHcTIz6rbRQEiS4E5SbA5UMYdOZ/5HpYP
 VWWYhL9OjQGhyafY333xIy/QTWWIf+AaxgYu4zn4+WSuzEY5v29M/j/MTk9ODJ38s/1L
 fjjjcjjuJHjsfttXvgyfQDq407CJb+8OUrjOVCDUulPirQ3jgT8uDeXpAubJTUb2TdZS
 gHtL0KsaReTf+BHzHgJttBTHiZiO/6hDjSd7GQTvEoUfgolDm6Kw+4exyF2i7qBhB7xh
 EkWntgyYl9e8M4Gajv1TbjOoMWxP/MXEfeIcqh6MzkVepYwchZqOl2tqdfrXg3F0KKJY
 YrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zaYsNFY5qEzjaDZ2NFrMjLxUGuOXjiz3gZ6Lx9T3hm8=;
 b=SKlDuODhPsd6OP96iiJ9Mkyyp7qOuFHD3+g9iqlg1NNbqaBGMkAcaYEoMuFJ8YoML/
 szNZbwSe/vvGtiTGHE70Jidg84tTrKTyfqK8AmXa4MmWnMHsCEYDapK2njSJA8NWfVL5
 mzWsJKtHx3QAar1UavXtt/DPkJ+YvOSb1nW2unw8MrhADV5YoKVLTtZan4OWcy2y31V0
 2jTqlE0eB/IWwVsFXhlRCZJGV7iPP1TLRn9DqvFHlrD9eydwClvjgzBOmC4AVadCWqeR
 LeeD+gd0Fl8ob/CsEOHkHcYPqTyaMy6qp+2ph+UJXDocHNhqsGJ7yxWQDaapyLCTDPfk
 5XqA==
X-Gm-Message-State: APjAAAWQqMxfm1yPLKCFVgQoMk6G/m9LA5qc3HfOVu6Kz4QPZCWhDe+B
 SPp8/IODszR0T1uzyXLuIvLc7T8Bt4ddr7D3C5w=
X-Google-Smtp-Source: APXvYqzaq/mpBf40JyN+M/ibAQNTEtMypcH7X97FlExCYf7HRjfaqs52XXDDULghT04jo7R60p+Z/k0qvEupbXEVagc=
X-Received: by 2002:ac8:53c7:: with SMTP id c7mr82431211qtq.162.1564549675473; 
 Tue, 30 Jul 2019 22:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <152669369110.34337.14271778212195820353.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152669371377.34337.10697370528066177062.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CANQeFDCHUMP5su8ckoekeOWjEVBb2kN4VfiHuq8xnz8o8hWXvw@mail.gmail.com>
 <CAPcyv4h6Wgursr6rMV42EFzH-7DJscrBrCFPqhiJp6ocYS9qmw@mail.gmail.com>
In-Reply-To: <CAPcyv4h6Wgursr6rMV42EFzH-7DJscrBrCFPqhiJp6ocYS9qmw@mail.gmail.com>
From: Liu Bo <obuil.liubo@gmail.com>
Date: Tue, 30 Jul 2019 22:07:44 -0700
Message-ID: <CANQeFDAh5WB5cDGLCYboQBXmi_nVsFgLyHJbNDHdG1u87iMJ+w@mail.gmail.com>
Subject: Re: [PATCH v11 4/7] mm, fs,
 dax: handle layout changes to pinned dax mappings
To: Dan Williams <dan.j.williams@intel.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jul 30, 2019 at 8:58 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Jul 30, 2019 at 7:27 PM Liu Bo <obuil.liubo@gmail.com> wrote:
> >
> > Hi Dan,
> >
> >
> > (Sorry for replying in a very old thread.)
> >
> >
> > On Fri, May 18, 2018 at 6:45 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > Background:
> > >
> > > get_user_pages() in the filesystem pins file backed memory pages for
> > > access by devices performing dma. However, it only pins the memory pages
> > > not the page-to-file offset association. If a file is truncated the
> > > pages are mapped out of the file and dma may continue indefinitely into
> > > a page that is owned by a device driver. This breaks coherency of the
> > > file vs dma, but the assumption is that if userspace wants the
> > > file-space truncated it does not matter what data is inbound from the
> > > device, it is not relevant anymore. The only expectation is that dma can
> > > safely continue while the filesystem reallocates the block(s).
> > >
> > > Problem:
> > >
> > > This expectation that dma can safely continue while the filesystem
> > > changes the block map is broken by dax. With dax the target dma page
> > > *is* the filesystem block. The model of leaving the page pinned for dma,
> > > but truncating the file block out of the file, means that the filesytem
> > > is free to reallocate a block under active dma to another file and now
> > > the expected data-incoherency situation has turned into active
> > > data-corruption.
> > >
> > > Solution:
> > >
> > > Defer all filesystem operations (fallocate(), truncate()) on a dax mode
> > > file while any page/block in the file is under active dma. This solution
> > > assumes that dma is transient. Cases where dma operations are known to
> > > not be transient, like RDMA, have been explicitly disabled via
> > > commits like 5f1d43de5416 "IB/core: disable memory registration of
> > > filesystem-dax vmas".
> > >
> > > The dax_layout_busy_page() routine is called by filesystems with a lock
> > > held against mm faults (i_mmap_lock) to find pinned / busy dax pages.
> > > The process of looking up a busy page invalidates all mappings
> > > to trigger any subsequent get_user_pages() to block on i_mmap_lock.
> > > The filesystem continues to call dax_layout_busy_page() until it finally
> > > returns no more active pages. This approach assumes that the page
> > > pinning is transient, if that assumption is violated the system would
> > > have likely hung from the uncompleted I/O.
> > >
> > > Cc: Jeff Moyer <jmoyer@redhat.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Cc: Matthew Wilcox <mawilcox@microsoft.com>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> > > Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Reported-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  fs/dax.c            |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/dax.h |    7 ++++
> > >  2 files changed, 104 insertions(+)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index aaec72ded1b6..e8f61ea690f7 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -351,6 +351,19 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
> > >         }
> > >  }
> > >
> > > +static struct page *dax_busy_page(void *entry)
> > > +{
> > > +       unsigned long pfn;
> > > +
> > > +       for_each_mapped_pfn(entry, pfn) {
> > > +               struct page *page = pfn_to_page(pfn);
> > > +
> > > +               if (page_ref_count(page) > 1)
> > > +                       return page;
> > > +       }
> > > +       return NULL;
> > > +}
> > > +
> > >  /*
> > >   * Find radix tree entry at given index. If it points to an exceptional entry,
> > >   * return it with the radix tree entry locked. If the radix tree doesn't
> > > @@ -492,6 +505,90 @@ static void *grab_mapping_entry(struct address_space *mapping, pgoff_t index,
> > >         return entry;
> > >  }
> > >
> > > +/**
> > > + * dax_layout_busy_page - find first pinned page in @mapping
> > > + * @mapping: address space to scan for a page with ref count > 1
> > > + *
> > > + * DAX requires ZONE_DEVICE mapped pages. These pages are never
> > > + * 'onlined' to the page allocator so they are considered idle when
> > > + * page->count == 1. A filesystem uses this interface to determine if
> > > + * any page in the mapping is busy, i.e. for DMA, or other
> > > + * get_user_pages() usages.
> > > + *
> > > + * It is expected that the filesystem is holding locks to block the
> > > + * establishment of new mappings in this address_space. I.e. it expects
> > > + * to be able to run unmap_mapping_range() and subsequently not race
> > > + * mapping_mapped() becoming true.
> > > + */
> > > +struct page *dax_layout_busy_page(struct address_space *mapping)
> > > +{
> > > +       pgoff_t indices[PAGEVEC_SIZE];
> > > +       struct page *page = NULL;
> > > +       struct pagevec pvec;
> > > +       pgoff_t index, end;
> > > +       unsigned i;
> > > +
> > > +       /*
> > > +        * In the 'limited' case get_user_pages() for dax is disabled.
> > > +        */
> > > +       if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> > > +               return NULL;
> > > +
> > > +       if (!dax_mapping(mapping) || !mapping_mapped(mapping))
> > > +               return NULL;
> > > +
> > > +       pagevec_init(&pvec);
> > > +       index = 0;
> > > +       end = -1;
> > > +
> > > +       /*
> > > +        * If we race get_user_pages_fast() here either we'll see the
> > > +        * elevated page count in the pagevec_lookup and wait, or
> > > +        * get_user_pages_fast() will see that the page it took a reference
> > > +        * against is no longer mapped in the page tables and bail to the
> > > +        * get_user_pages() slow path.  The slow path is protected by
> > > +        * pte_lock() and pmd_lock(). New references are not taken without
> > > +        * holding those locks, and unmap_mapping_range() will not zero the
> > > +        * pte or pmd without holding the respective lock, so we are
> > > +        * guaranteed to either see new references or prevent new
> > > +        * references from being established.
> > > +        */
> > > +       unmap_mapping_range(mapping, 0, 0, 1);
> >
> > Why do we have to unmap the whole address space prior to check busy pages?
> > Can we have a variate of dax_layout_busy_page() to only unmap a sub
> > set  of the whole address space?
> >
>
> This is due to the location in xfs where layouts are broken vs where
> the file range is mapped to physical blocks for the truncate
> operation. I ultimately decided the reworks needed for that
> optimization were large and that the relative performance gain was
> small. Do you have performance numbers to the contrary? Feel free to
> copy the linux-nvdimm list on future mails, no need for this to be a
> private discussion.

Thanks a lot for the prompt reply.

For virtiofs[1]'s dax mode, it also suffers the same race problem
between dax-DMA(mmap+directIO) and fs truncate/punch_hole, besides, it
maintains a kind of resource named dax mapping range for IO
operations, which is similar to the block concept in filesystem and
sometimes we need to reclaim some dax mapping ranges in background.
So it might end up the same race problem when this reclaim process and
dax-dma(mmap+directIO) run concurrently, however, since reclaim is not
a user-triggered operations as truncate, it might be triggered
frequently on the fly by virtiofs itself, now if that happened, mmap
workloads would be impacted significantly by the reclaim because of
reclaim unmapping  the whole address space of inode.

As every dax mapping range is 2M for now, a ideal solution is to have
layout_checking unmap only that specific 2M range so that other areas
in mmap ranges are good to go.

[1]: https://virtio-fs.gitlab.io/

thanks,
liubo
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

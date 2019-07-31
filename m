Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEDB7D1A8
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Aug 2019 01:03:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A0E20212FD40C;
	Wed, 31 Jul 2019 16:05:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::742; helo=mail-qk1-x742.google.com;
 envelope-from=obuil.liubo@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5A9D9212FD3FA
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 16:05:30 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r6so50533124qkc.0
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 16:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+wKIT3YRrcqVhbfbdny2s22b14TaGPW+a+toAVlLVl4=;
 b=od5pwm0uGYVbBVSgrGjDmZGngmdQiZOP+dXDbe98KYUYwHlPQw8TFUMvic02CFg3oO
 GKlYwD7BcTRcLQMWAeL2WZzcUikx1YccbovpZUTinUnu5CKXE5dKz+kiykBT0ovwyNYm
 Yi9VxH9TFToVLaPWMNMEd0N9T7Vt4oovOVyrWI/S6Q7un9Xe+p9EHkZ5dB4ut6xSBeig
 skJU6nZUEjx87Bm7JCXOOmOk1jCgw2y1mDNwDnqUXid0nWSmC39zzOvHTzW47gFiFOD5
 fiOoCuOcz62IsV6jQWEwohoDeY9HAw/6EdolM8TDmdPE0afjPXf4T6cS5sbbgUAmW0lI
 HZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+wKIT3YRrcqVhbfbdny2s22b14TaGPW+a+toAVlLVl4=;
 b=Q5HcIIOtvChmd8rRKH1GYnJPCalfTio7kYHPe7mXowJlpNjbqnF0k1vHiUJFfZ4CgI
 sl+oQ46Qfk61oigrGT51EUGd8T9fDDk0GKFrzE3GhwjAyW0iV+CDDwHsgq64kcgLiuYM
 EEYGB8hd+/R7StglPNpdOLBTt3IIQhmmspmcBpZzmMZKLwTpK6EgPgs4/ymS8mr2Gqur
 5qLEcMeaB+RKCwgKsFZbkZk3sqDPd/Pk1uaOfdnphsuelS/Bb0+gu0Jfwh+C7BiSCC0j
 h8eSbTLEUzVUlYnl+cB6jGQWTWdZWDxkDfgz9s7Rl4v/JGIi6Rzt3eh+XPS0KabBCcbF
 cR2Q==
X-Gm-Message-State: APjAAAUVdVqJ6fA+rE2wHCs6JJk9gLTwNLiVIxqsg+VSrgJ9Do01CDwy
 VYKGCwa4EeydPevXXo5JmZP5mkK7lCUwGb03Aic=
X-Google-Smtp-Source: APXvYqxsL35quDA+IfSiHHdwpBDFdrLVStWzPiBSgFE2/sl6KjeLDWmfVVYcA0dJO1rZpjpALRwpy3W706WeevtVmSc=
X-Received: by 2002:a37:a013:: with SMTP id j19mr85668921qke.401.1564614178535; 
 Wed, 31 Jul 2019 16:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <152669369110.34337.14271778212195820353.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152669371377.34337.10697370528066177062.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CANQeFDCHUMP5su8ckoekeOWjEVBb2kN4VfiHuq8xnz8o8hWXvw@mail.gmail.com>
 <CAPcyv4h6Wgursr6rMV42EFzH-7DJscrBrCFPqhiJp6ocYS9qmw@mail.gmail.com>
 <CANQeFDAh5WB5cDGLCYboQBXmi_nVsFgLyHJbNDHdG1u87iMJ+w@mail.gmail.com>
 <CAPcyv4hfVhYVFszxJO3vDeDAtz_THZROgv8orFXfddEOaGjUBA@mail.gmail.com>
In-Reply-To: <CAPcyv4hfVhYVFszxJO3vDeDAtz_THZROgv8orFXfddEOaGjUBA@mail.gmail.com>
From: Liu Bo <obuil.liubo@gmail.com>
Date: Wed, 31 Jul 2019 16:02:47 -0700
Message-ID: <CANQeFDBAhjdsdjjKz_Qv6bgOQzquy9h+sAuxUunn2-Hs64bs-g@mail.gmail.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 31, 2019 at 12:16 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Jul 30, 2019 at 10:07 PM Liu Bo <obuil.liubo@gmail.com> wrote:
> > On Tue, Jul 30, 2019 at 8:58 PM Dan Williams <dan.j.williams@intel.com> wrote:
> [..]
> > > > > +/**
> > > > > + * dax_layout_busy_page - find first pinned page in @mapping
> > > > > + * @mapping: address space to scan for a page with ref count > 1
> > > > > + *
> > > > > + * DAX requires ZONE_DEVICE mapped pages. These pages are never
> > > > > + * 'onlined' to the page allocator so they are considered idle when
> > > > > + * page->count == 1. A filesystem uses this interface to determine if
> > > > > + * any page in the mapping is busy, i.e. for DMA, or other
> > > > > + * get_user_pages() usages.
> > > > > + *
> > > > > + * It is expected that the filesystem is holding locks to block the
> > > > > + * establishment of new mappings in this address_space. I.e. it expects
> > > > > + * to be able to run unmap_mapping_range() and subsequently not race
> > > > > + * mapping_mapped() becoming true.
> > > > > + */
> > > > > +struct page *dax_layout_busy_page(struct address_space *mapping)
> > > > > +{
> > > > > +       pgoff_t indices[PAGEVEC_SIZE];
> > > > > +       struct page *page = NULL;
> > > > > +       struct pagevec pvec;
> > > > > +       pgoff_t index, end;
> > > > > +       unsigned i;
> > > > > +
> > > > > +       /*
> > > > > +        * In the 'limited' case get_user_pages() for dax is disabled.
> > > > > +        */
> > > > > +       if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> > > > > +               return NULL;
> > > > > +
> > > > > +       if (!dax_mapping(mapping) || !mapping_mapped(mapping))
> > > > > +               return NULL;
> > > > > +
> > > > > +       pagevec_init(&pvec);
> > > > > +       index = 0;
> > > > > +       end = -1;
> > > > > +
> > > > > +       /*
> > > > > +        * If we race get_user_pages_fast() here either we'll see the
> > > > > +        * elevated page count in the pagevec_lookup and wait, or
> > > > > +        * get_user_pages_fast() will see that the page it took a reference
> > > > > +        * against is no longer mapped in the page tables and bail to the
> > > > > +        * get_user_pages() slow path.  The slow path is protected by
> > > > > +        * pte_lock() and pmd_lock(). New references are not taken without
> > > > > +        * holding those locks, and unmap_mapping_range() will not zero the
> > > > > +        * pte or pmd without holding the respective lock, so we are
> > > > > +        * guaranteed to either see new references or prevent new
> > > > > +        * references from being established.
> > > > > +        */
> > > > > +       unmap_mapping_range(mapping, 0, 0, 1);
> > > >
> > > > Why do we have to unmap the whole address space prior to check busy pages?
> > > > Can we have a variate of dax_layout_busy_page() to only unmap a sub
> > > > set  of the whole address space?
> > > >
> > >
> > > This is due to the location in xfs where layouts are broken vs where
> > > the file range is mapped to physical blocks for the truncate
> > > operation. I ultimately decided the reworks needed for that
> > > optimization were large and that the relative performance gain was
> > > small. Do you have performance numbers to the contrary? Feel free to
> > > copy the linux-nvdimm list on future mails, no need for this to be a
> > > private discussion.
> >
> > Thanks a lot for the prompt reply.
> >
> > For virtiofs[1]'s dax mode, it also suffers the same race problem
> > between dax-DMA(mmap+directIO) and fs truncate/punch_hole, besides, it
> > maintains a kind of resource named dax mapping range for IO
> > operations, which is similar to the block concept in filesystem and
> > sometimes we need to reclaim some dax mapping ranges in background.
> > So it might end up the same race problem when this reclaim process and
> > dax-dma(mmap+directIO) run concurrently, however, since reclaim is not
> > a user-triggered operations as truncate, it might be triggered
> > frequently on the fly by virtiofs itself, now if that happened, mmap
> > workloads would be impacted significantly by the reclaim because of
> > reclaim unmapping  the whole address space of inode.
> >
> > As every dax mapping range is 2M for now, a ideal solution is to have
> > layout_checking unmap only that specific 2M range so that other areas
> > in mmap ranges are good to go.
>
> There are larger problems with DAX-dma into a guest mapping. There is
> no mechanism to coordinate a host-fs truncate with the completion of
> guest-dma like what we do with the "layout break" implementation when
> fs and dma are coordinated in the same kernel. The only way,
> presently, to safely assign a dma-initiator device to a guest with DAX
> mapped memory is to use device-dax on the host side where truncate /
> hole punch just isn't supported. Maybe virtio-fs could invent some
> paravirtualized side channel for this coordination, but it does not
> exist today.

I might have mistaken you, this 'dax mapping range' concept is
maintained by virtiofs _inside_ guest, it is corresponding to the
qemu's mmio window that are used for virtiofs.

It seems fine to me if we just unmap a range of the inode's address
space and check busy dax entries against this range, but I'm not sure,
could you please suggest?

thanks,
liubo
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

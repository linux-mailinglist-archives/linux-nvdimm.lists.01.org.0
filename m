Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5740E323538
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Feb 2021 02:32:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 71093100F225D;
	Tue, 23 Feb 2021 17:32:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 39BEF100F225A
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 17:32:22 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a22so423516ejv.9
        for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BzWzSMy6H2fKaT6wDPfgdGVM2lphxwe7fjsWLK8ZsE4=;
        b=S75Qch0ZOea7fh5SP9tMaw8ApZ3bEDxJO1l9QkpiBXeoIJGJ40yXpr1WktRrEViy3D
         vijr1JJSKl1rZgNb1bzAKWw9GR/43vYcydkbd/anpDloO7xO2ODxp1Hps6Rie67Ov8DQ
         I+2Ywacc2vCwjEO2ApRfBzs329z5yGUwawppt7NpEPadCzuOtaWkQCu4OGozKmdxwDs8
         7DrfpQo6uRf/T66mj4TJAREDUZFgM8Um1n4t9IP8U/2vDd6s6Jcs4Q/l3dVgjflFBaN9
         aLE0IJtbQgdR3x2B39xqV9j+BJSVQ2gu2fUUPMNSVkXgKdgJHmN74G2ZhP3zdWAR8pKk
         hQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BzWzSMy6H2fKaT6wDPfgdGVM2lphxwe7fjsWLK8ZsE4=;
        b=bqveScjl7U+GMGq/v9zrKRc/dk70LUpNHMDCSexRYpq8zXbryZZj9dvnSFbQaXy9cw
         vRoEs4eMbChk86didjjZ5WR88ZD+v+HChX3kJd0zG8Xv6ftfj3HuhNy57qZq45khcGsu
         h1njjU2CcItrRzUQnGKI9vtcRo1h0g+Sxv2CHJ4QPXwiXEtbsgBBGNm40IMhqtEJMz3B
         M1cy1c5F6dSj0WV+a5DLS+NpeXtMZOFjo20pc2Rr28W29BvYs/wcsGl9LOThS4ZoZCex
         mLEzASUno6XdAfXrD9X/YOvQViadljjTw3DXASme+NwA6jfbFxtHetyN/5q9LreeGNnu
         xT0g==
X-Gm-Message-State: AOAM533tndJKXi4vqkYlxOZlakRgd3KzGooWB8UKFyeORMSdP1qUUJry
	T/fYhMQGwMZqxZRBhSyxCDVgNmWLj8YxWJkgHTySAg==
X-Google-Smtp-Source: ABdhPJweeOqjTTK2aT3IWCvDjLq0yad1F25BQovQcrNlUrurFfezD/l7/vcOUTDDJ4QHuLwgfbeO1bJ/899s1E/jfdA=
X-Received: by 2002:a17:907:3fa3:: with SMTP id hr35mr1175229ejc.418.1614130341190;
 Tue, 23 Feb 2021 17:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
 <6a18179e-65f7-367d-89a9-d5162f10fef0@oracle.com> <CAPcyv4joomjhZYaCBNrYjvATSYgECfHYOZy=n_QVKqX7D_ReZQ@mail.gmail.com>
 <20210223185435.GO2643399@ziepe.ca> <CAPcyv4gnga5py0j+_1y_9tAxi98+FmYrtOVy7xQTHJ1zJhz2ZA@mail.gmail.com>
 <20210223230723.GP2643399@ziepe.ca> <CAPcyv4hAHaGZ52TtZxTyYtQQVMKW+MaqYDsDKJe94o-cNZNv4g@mail.gmail.com>
 <20210224010017.GQ2643399@ziepe.ca>
In-Reply-To: <20210224010017.GQ2643399@ziepe.ca>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Feb 2021 17:32:16 -0800
Message-ID: <CAPcyv4i+PZhYZiePf2PaH0dT5jDfkmkDX-3usQy1fAhf6LPyfw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Jason Gunthorpe <jgg@ziepe.ca>
Message-ID-Hash: FDADZ2RBHMFAVXJFYYMWFEMK2LCNUQRO
X-Message-ID-Hash: FDADZ2RBHMFAVXJFYYMWFEMK2LCNUQRO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Ralph Campbell <rcampbell@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FDADZ2RBHMFAVXJFYYMWFEMK2LCNUQRO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 23, 2021 at 5:00 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Feb 23, 2021 at 04:14:01PM -0800, Dan Williams wrote:
> > [ add Ralph ]
> >
> > On Tue, Feb 23, 2021 at 3:07 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Feb 23, 2021 at 02:48:20PM -0800, Dan Williams wrote:
> > > > On Tue, Feb 23, 2021 at 10:54 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Tue, Feb 23, 2021 at 08:44:52AM -0800, Dan Williams wrote:
> > > > >
> > > > > > > The downside would be one extra lookup in dev_pagemap tree
> > > > > > > for other pgmap->types (P2P, FSDAX, PRIVATE). But just one
> > > > > > > per gup-fast() call.
> > > > > >
> > > > > > I'd guess a dev_pagemap lookup is faster than a get_user_pages slow
> > > > > > path. It should be measurable that this change is at least as fast or
> > > > > > faster than falling back to the slow path, but it would be good to
> > > > > > measure.
> > > > >
> > > > > What is the dev_pagemap thing doing in gup fast anyhow?
> > > > >
> > > > > I've been wondering for a while..
> > > >
> > > > It's there to synchronize against dax-device removal. The device will
> > > > suspend removal awaiting all page references to be dropped, but
> > > > gup-fast could be racing device removal. So gup-fast checks for
> > > > pte_devmap() to grab a live reference to the device before assuming it
> > > > can pin a page.
> > >
> > > From the perspective of CPU A it can't tell if CPU B is doing a HW
> > > page table walk or a GUP fast when it invalidates a page table. The
> > > design of gup-fast is supposed to be the same as the design of a HW
> > > page table walk, and the tlb invalidate CPU A does when removing a
> > > page from a page table is supposed to serialize against both a HW page
> > > table walk and gup-fast.
> > >
> > > Given that the HW page table walker does not do dev_pagemap stuff, why
> > > does gup-fast?
> >
> > gup-fast historically assumed that the 'struct page' and memory
> > backing the page-table walk could not physically be removed from the
> > system during its walk because those pages were allocated from the
> > page allocator before being mapped into userspace.
>
> No, I'd say gup-fast assumes that any non-special PTE it finds in a
> page table must have a struct page.
>
> If something wants to remove that struct page it must first remove all
> the PTEs pointing at it from the entire system and flush the TLBs,
> which directly prevents a future gup-fast from running and trying to
> access the struct page. No extra locking needed
>
> > implied elevated reference on any page that gup-fast would be asked to
> > walk, or pte_special() is there to "say wait, nevermind this isn't a
> > page allocator page fallback to gup-slow()".
>
> pte_special says there is no struct page, and some of those cases can
> be fixed up in gup-slow.
>
> > > Can you sketch the exact race this is protecting against?
> >
> > Thread1 mmaps /mnt/daxfile1 from a "mount -o dax" filesystem and
> > issues direct I/O with that mapping as the target buffer, Thread2 does
> > "echo "namespace0.0" > /sys/bus/nd/drivers/nd_pmem/unbind". Without
> > the dev_pagemap check reference gup-fast could execute
> > get_page(pte_page(pte)) on a page that doesn't even exist anymore
> > because the driver unbind has already performed remove_pages().
>
> Surely the unbind either waits for all the VMAs to be destroyed or
> zaps them before allowing things to progress to remove_pages()?

If we're talking about device-dax this is precisely what it does, zaps
and prevents new faults from resolving, but filesystem-dax...

> Having a situation where the CPU page tables still point at physical
> pages that have been removed sounds so crazy/insecure, that can't be
> what is happening, can it??

Hmm, that may be true and an original dax bug! The unbind of a
block-device from underneath the filesystem does trigger the
filesystem to emergency shutdown / go read-only, but unless that
process also includes a global zap of all dax mappings not only is
that violating expectations of "page-tables to disappearing memory",
but the filesystem may also want to guarantee that no further dax
writes can happen after shutdown. Right now I believe it only assumes
that mmap I/O will come from page writeback so there's no need to
bother applications with mappings to page cache, but dax mappings need
to be ripped away.

/me goes to look at what filesytems guarantee when the block-device is
surprise removed out from under them.

In any event, this accelerates the effort to go implement
fs-global-dax-zap at the request of the device driver.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

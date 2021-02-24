Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C9D323470
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Feb 2021 01:14:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BCF5A100F2242;
	Tue, 23 Feb 2021 16:14:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 090C8100EB33C
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 16:14:07 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c6so506440ede.0
        for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 16:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLJHJxH7tTmQkhw5tNgwiSSOljZxViPOSF8nXy5WWfU=;
        b=jwLWHoalomh7mZYDd6f08ljdmp1NrN76kqY92StAT7tyl1cxzrxARguiZzVFDC3QsA
         8yH7pk+Br8oB95JokcDWQxFtsGIvwV82t47BPCQgtsyRjr6VR4mtT2C+KkGZCTZ1bR0S
         VO6hF1qheKSseiel8Ymwp+FDPfWAw+V10wrRqfBLmM4DxFoxRQmiJef7azeeN+/0Dsb9
         duJMGWqePS7oY+11zggkukfRJshIAXOgAwhP1Rfbaivy5wPhQV9tyspTf1FQ5cPCnDXS
         44/J2aLE7NawJCOuvxjimXGlcQObOFVmvn8i1wcDeYpNh2l+OCi2Nykl9encVyg2MWH1
         iTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLJHJxH7tTmQkhw5tNgwiSSOljZxViPOSF8nXy5WWfU=;
        b=DVR3kndOTC0gDxtAopzIa9XqyaHd91ZRXQZjYRDVTghyb8oTZV7OSS33tKM3vyIrzv
         Vg6EaoZ+aLzb+pVBk6kv7NbfQeNjJ5hmM9oVFcx3eKPC3kZrzfV2oXI4YqARUINBWdqK
         c7gwkMt2qTc8rniyx+rROLOswCGDQg+R9Wa5o+p0hIOKeIpguYQfKI1d2GG9cwT5Cv5k
         W8wk/1S+MHssUmMHp8SK28b7lwXNdkP6Cu+AJDHB+vX2m1BueCmb7ClgWQS6ewCu7iJk
         6aOI8qJW5rGb251T/V38lLOs9Q3n3F46M/eLgJui70i5bBN6BuBQCJ0LJ6kidK+/7hw+
         9WqA==
X-Gm-Message-State: AOAM531KkoPFwboZsD+GYov93jWFExf1G5+IU+Xbn8D3tRw3bR64kd1c
	Lkq1MtrCray95/nMLIMxBV4u4wfOCNiNaR21VCSjMQ==
X-Google-Smtp-Source: ABdhPJxkmsixyDMgZwiRPFz7g1wKznwwN5YVqpozccKEnIhEeJptpOXzGwk1UXrRI++d9AmrNXsfBib4IrHb2IbuuIg=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr30090604edc.97.1614125645812;
 Tue, 23 Feb 2021 16:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
 <6a18179e-65f7-367d-89a9-d5162f10fef0@oracle.com> <CAPcyv4joomjhZYaCBNrYjvATSYgECfHYOZy=n_QVKqX7D_ReZQ@mail.gmail.com>
 <20210223185435.GO2643399@ziepe.ca> <CAPcyv4gnga5py0j+_1y_9tAxi98+FmYrtOVy7xQTHJ1zJhz2ZA@mail.gmail.com>
 <20210223230723.GP2643399@ziepe.ca>
In-Reply-To: <20210223230723.GP2643399@ziepe.ca>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Feb 2021 16:14:01 -0800
Message-ID: <CAPcyv4hAHaGZ52TtZxTyYtQQVMKW+MaqYDsDKJe94o-cNZNv4g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Jason Gunthorpe <jgg@ziepe.ca>
Message-ID-Hash: 2UD3PNKMUSSZJI4RRQNQJB3LD7MASS3E
X-Message-ID-Hash: 2UD3PNKMUSSZJI4RRQNQJB3LD7MASS3E
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Ralph Campbell <rcampbell@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2UD3PNKMUSSZJI4RRQNQJB3LD7MASS3E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ add Ralph ]

On Tue, Feb 23, 2021 at 3:07 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Feb 23, 2021 at 02:48:20PM -0800, Dan Williams wrote:
> > On Tue, Feb 23, 2021 at 10:54 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Feb 23, 2021 at 08:44:52AM -0800, Dan Williams wrote:
> > >
> > > > > The downside would be one extra lookup in dev_pagemap tree
> > > > > for other pgmap->types (P2P, FSDAX, PRIVATE). But just one
> > > > > per gup-fast() call.
> > > >
> > > > I'd guess a dev_pagemap lookup is faster than a get_user_pages slow
> > > > path. It should be measurable that this change is at least as fast or
> > > > faster than falling back to the slow path, but it would be good to
> > > > measure.
> > >
> > > What is the dev_pagemap thing doing in gup fast anyhow?
> > >
> > > I've been wondering for a while..
> >
> > It's there to synchronize against dax-device removal. The device will
> > suspend removal awaiting all page references to be dropped, but
> > gup-fast could be racing device removal. So gup-fast checks for
> > pte_devmap() to grab a live reference to the device before assuming it
> > can pin a page.
>
> From the perspective of CPU A it can't tell if CPU B is doing a HW
> page table walk or a GUP fast when it invalidates a page table. The
> design of gup-fast is supposed to be the same as the design of a HW
> page table walk, and the tlb invalidate CPU A does when removing a
> page from a page table is supposed to serialize against both a HW page
> table walk and gup-fast.
>
> Given that the HW page table walker does not do dev_pagemap stuff, why
> does gup-fast?

gup-fast historically assumed that the 'struct page' and memory
backing the page-table walk could not physically be removed from the
system during its walk because those pages were allocated from the
page allocator before being mapped into userspace. So there is an
implied elevated reference on any page that gup-fast would be asked to
walk, or pte_special() is there to "say wait, nevermind this isn't a
page allocator page fallback to gup-slow()". pte_devmap() is there to
say "wait, there is no implied elevated reference for this page, check
and hold dev_pagemap alive until a page reference can be taken". So it
splits the difference between pte_special() and typical page allocator
pages.

> Can you sketch the exact race this is protecting against?

Thread1 mmaps /mnt/daxfile1 from a "mount -o dax" filesystem and
issues direct I/O with that mapping as the target buffer, Thread2 does
"echo "namespace0.0" > /sys/bus/nd/drivers/nd_pmem/unbind". Without
the dev_pagemap check reference gup-fast could execute
get_page(pte_page(pte)) on a page that doesn't even exist anymore
because the driver unbind has already performed remove_pages().

Effectively the same percpu_ref that protects the pmem0 block device
from new command submissions while the device is dying also prevents
new dax page references being taken while the device is dying.

This could be solved with the traditional gup-fast rules if the device
driver could tell the filesystem to unmap all dax files and force them
to re-fault through the gup-slow path to see that the device is now
dying. I'll likely be working on that sooner rather than later given
some of the expectations of the CXL persistent memory "dirty shutdown"
detection.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

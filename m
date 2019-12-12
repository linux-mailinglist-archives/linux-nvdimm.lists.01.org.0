Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5F11D431
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 18:37:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80BCC10113665;
	Thu, 12 Dec 2019 09:40:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DD1D10113664
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 09:40:56 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id 6so1064511oix.7
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85/Q4O/XPGPhGcxW85SoqxJkDWVGa36c4g0JD0LKUdQ=;
        b=2QiartKIZdQPCbLz3nE7oYW8NvdklpGuw+X/svYmd9KVlu553fO1rCfkF6KUg/yadG
         HIQRj6DFW4Gnh2+XqLfpISpj0DQ0TmfshCBvuCHn/u9Kt0Ixx5njGPl26Y+KXqdC1kPU
         sQvB5a0wbVjTrf0FqZ7HgLinJ5CTZ3uLcXdTbINhtBaH/7Ej6RXaxxVrf9ifEDGylntD
         4K9sJvTSvFu8WJK6x73GzLtnjQDvHmU1Z/nwpMDzHJiw5p0G4im6aR5UD7iNk84xDYkB
         eAw2it3p6Sux2nAsZnBOVAKMTff+JnLEjDlV2yW59y0lgwa0SSiRAxEz0VkkrTo10WHE
         PqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85/Q4O/XPGPhGcxW85SoqxJkDWVGa36c4g0JD0LKUdQ=;
        b=Zj7sqeucE0IepoODgYM1yjF4oqb+IqEPo6qcOCKnvl3q7+/KLbWOjyBbChkAYkYvvu
         Ad4TLaS17va8K31wSJEL4KyXHHwkhnt/SNY4Sh0ChCUW6e4cLSVk4sW1jt1iNK17kvhK
         cu2h2+FTegx1eYD/zqkT8YFeN/DEqlcwzVPYYgNbb6oTq3AbFNH0EqKNxrQf2Nvbk3Z8
         UuLX8arcl0FMKa7HQomjf0PmMWNX6lPeCie8KSVn/XLFkbizW3ze9z+as9FC2JYmWzqi
         zZPFtjqsRzJpxf088qOWL0gEZKVGJJj5xETEda4CKeATb29STzYPWAhqG5YYEFNbFsUE
         KALQ==
X-Gm-Message-State: APjAAAUKD3bSLSBZjzgf5eN6WZ+jepYyGGR2676dKC0d6+AAFqvA5WCz
	nuVZo0Y+OYNu+LPEfHZj6rWnJtd+fCxWy6l9M5kSWQ==
X-Google-Smtp-Source: APXvYqxkKbPEIWyIE11O/eFe/uZfpTjQS8MTcmCNROdykD4QjszsKgHaTbUlwhezWkREESo+GM2t81PKbYRhc/Ha2R4=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr6051900oij.0.1576172253406;
 Thu, 12 Dec 2019 09:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20191211213207.215936-1-brho@google.com> <20191211213207.215936-3-brho@google.com>
 <20191212173413.GC3163@linux.intel.com>
In-Reply-To: <20191212173413.GC3163@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Dec 2019 09:37:22 -0800
Message-ID: <CAPcyv4hkz8XCETELBaUOjHQf3=VyVB=KWeRVEPYejvdsg3_MWA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To: Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID-Hash: YJ3RECS6HCLMZQWWG7Q5F4PMXVWEIQZ7
X-Message-ID-Hash: YJ3RECS6HCLMZQWWG7Q5F4PMXVWEIQZ7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zeng, Jason" <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YJ3RECS6HCLMZQWWG7Q5F4PMXVWEIQZ7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 12, 2019 at 9:34 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Wed, Dec 11, 2019 at 04:32:07PM -0500, Barret Rhoden wrote:
> > This change allows KVM to map DAX-backed files made of huge pages with
> > huge mappings in the EPT/TDP.
> >
> > DAX pages are not PageTransCompound.  The existing check is trying to
> > determine if the mapping for the pfn is a huge mapping or not.  For
> > non-DAX maps, e.g. hugetlbfs, that means checking PageTransCompound.
> > For DAX, we can check the page table itself.
> >
> > Note that KVM already faulted in the page (or huge page) in the host's
> > page table, and we hold the KVM mmu spinlock.  We grabbed that lock in
> > kvm_mmu_notifier_invalidate_range_end, before checking the mmu seq.
> >
> > Signed-off-by: Barret Rhoden <brho@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 36 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 6f92b40d798c..cd07bc4e595f 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3384,6 +3384,35 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >       return -EFAULT;
> >  }
> >
> > +static bool pfn_is_huge_mapped(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn)
> > +{
> > +     struct page *page = pfn_to_page(pfn);
> > +     unsigned long hva;
> > +
> > +     if (!is_zone_device_page(page))
> > +             return PageTransCompoundMap(page);
> > +
> > +     /*
> > +      * DAX pages do not use compound pages.  The page should have already
> > +      * been mapped into the host-side page table during try_async_pf(), so
> > +      * we can check the page tables directly.
> > +      */
> > +     hva = gfn_to_hva(kvm, gfn);
> > +     if (kvm_is_error_hva(hva))
> > +             return false;
> > +
> > +     /*
> > +      * Our caller grabbed the KVM mmu_lock with a successful
> > +      * mmu_notifier_retry, so we're safe to walk the page table.
> > +      */
> > +     switch (dev_pagemap_mapping_shift(hva, current->mm)) {
> > +     case PMD_SHIFT:
> > +     case PUD_SIZE:
>
> I assume this means DAX can have 1GB pages?

Correct, it can. Not in the filesystem-dax case, but device-dax
supports 1GB pages.

> I ask because KVM's THP logic
> has historically relied on THP only supporting 2MB.  I cleaned this up in
> a recent series[*], which is in kvm/queue, but I obviously didn't actually
> test whether or not KVM would correctly handle 1GB non-hugetlbfs pages.

Yeah, since device-dax is the only path to support longterm page
pinning for vfio device assignment, testing with device-dax + 1GB
pages would be a useful sanity check.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

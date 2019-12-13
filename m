Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962611E9E8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Dec 2019 19:13:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F67B10097F07;
	Fri, 13 Dec 2019 10:16:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6DCDD10097F06
	for <linux-nvdimm@lists.01.org>; Fri, 13 Dec 2019 10:16:47 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id a124so1540168oii.13
        for <linux-nvdimm@lists.01.org>; Fri, 13 Dec 2019 10:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1cqQGOHLxt9WnlMRPGWtbihZqq/TPUJMIUsmupkqQc=;
        b=Z37IwFuamUtHj2UGycAzTlRIcOH/54EKCkDpaxP7Qp3MLa22kc/Usl9HnTrRe+y3QV
         jmlzBiBcgKWz0AkFOWkABdgtG4hYJTy1l4UIT6yWZWyPw9dRV6jw8VgbCyBLWLKiWGEX
         vM6Poow6sLwsq/ysxLVntPEkC62ExQjZKQkH6702/0HtxVqhTzpHmVb6lnPrLaCqpsEL
         zgjoMLNDG4MeH71UbAFhH4TqD4PJMpQDpjWWrZvQirUHWydeRNzmnynyQH4+Xkyz7ims
         L+1U3HsYxKKlN5qI/Ha+t6ww7rmUaJZ9hBlYoQDd0mpeknpPM1bHMMTuLHN+KJ75i+eW
         EFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1cqQGOHLxt9WnlMRPGWtbihZqq/TPUJMIUsmupkqQc=;
        b=Jm6D7XxuuyTikIhzlNjlIc6Q4ws8TfT8PwsoeFtAzpPqqLQDvjzQaHFbT1s7FEeq//
         2EvpFMLPFrk2NEMNqHxL3io5XQ4r6rPnhCxRlHrL0AaMV+Ei/Z/sopZlNtZpds9SqTAK
         NqAdOfLuou4CplIFl7K2g5AymeZwL05h0GlulNnvpPXRgAOcAIlnp7QXF+JitE8jC0RC
         4E776OIsNGq6s4ScFLJnT87nwjFVq6O97Kd4JvmdVBUJ1jO98NcvnyB/dCEWuhawnMu1
         cv8hTrPVo8jiDw1WnyeuOVnI2gQTSE98vQnAgelAm8vVOII+qCcM7QpsJLDz3V27w+Zi
         DntQ==
X-Gm-Message-State: APjAAAXc9oUAQco8XeqY1SQn1DT2AbXjkwajYdUTrG83j6Yn1Wfi2AE4
	1KqZgv1+EY2+quRuT9h7BD7MTIepUG+znxRLCgYSzw==
X-Google-Smtp-Source: APXvYqxZoubPWEAIaOvxFMZ9FPSoIReuNH6FLAi59sGYLvNzO+lWknFm2sHcIblMBoPXq/5GgUFCfD2MPq696t8Tmuc=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr7971550oie.105.1576260803989;
 Fri, 13 Dec 2019 10:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20191212182238.46535-1-brho@google.com> <20191212182238.46535-2-brho@google.com>
 <20191213174702.GB31552@linux.intel.com>
In-Reply-To: <20191213174702.GB31552@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Dec 2019 10:13:13 -0800
Message-ID: <CAPcyv4ia3mp9d24fBiSXh2m_T4sLHnJHeg6VLw2AZmk8DAD7qQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm: make dev_pagemap_mapping_shift() externally visible
To: Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID-Hash: 5UMXXXQIHS3X3QTZPTZE7E2N7PTQYXFY
X-Message-ID-Hash: 5UMXXXQIHS3X3QTZPTZE7E2N7PTQYXFY
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zeng, Jason" <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5UMXXXQIHS3X3QTZPTZE7E2N7PTQYXFY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 13, 2019 at 9:47 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Thu, Dec 12, 2019 at 01:22:37PM -0500, Barret Rhoden wrote:
> > KVM has a use case for determining the size of a dax mapping.
> >
> > The KVM code has easy access to the address and the mm, and
> > dev_pagemap_mapping_shift() needs only those parameters.  It was
> > deriving them from page and vma.  This commit changes those parameters
> > from (page, vma) to (address, mm).
> >
> > Signed-off-by: Barret Rhoden <brho@google.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  include/linux/mm.h  |  3 +++
> >  mm/memory-failure.c | 38 +++-----------------------------------
> >  mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 40 insertions(+), 35 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index a2adf95b3f9c..bfd1882dd5c6 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1013,6 +1013,9 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
> >  #define page_ref_zero_or_close_to_overflow(page) \
> >       ((unsigned int) page_ref_count(page) + 127u <= 127u)
> >
> > +unsigned long dev_pagemap_mapping_shift(unsigned long address,
> > +                                     struct mm_struct *mm);
> > +
> >  static inline void get_page(struct page *page)
> >  {
> >       page = compound_head(page);
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 3151c87dff73..bafa464c8290 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -261,40 +261,6 @@ void shake_page(struct page *p, int access)
> >  }
> >  EXPORT_SYMBOL_GPL(shake_page);
> >
> > -static unsigned long dev_pagemap_mapping_shift(struct page *page,
> > -             struct vm_area_struct *vma)
> > -{
> > -     unsigned long address = vma_address(page, vma);
> > -     pgd_t *pgd;
> > -     p4d_t *p4d;
> > -     pud_t *pud;
> > -     pmd_t *pmd;
> > -     pte_t *pte;
> > -
> > -     pgd = pgd_offset(vma->vm_mm, address);
> > -     if (!pgd_present(*pgd))
> > -             return 0;
> > -     p4d = p4d_offset(pgd, address);
> > -     if (!p4d_present(*p4d))
> > -             return 0;
> > -     pud = pud_offset(p4d, address);
> > -     if (!pud_present(*pud))
> > -             return 0;
> > -     if (pud_devmap(*pud))
> > -             return PUD_SHIFT;
> > -     pmd = pmd_offset(pud, address);
> > -     if (!pmd_present(*pmd))
> > -             return 0;
> > -     if (pmd_devmap(*pmd))
> > -             return PMD_SHIFT;
> > -     pte = pte_offset_map(pmd, address);
> > -     if (!pte_present(*pte))
> > -             return 0;
> > -     if (pte_devmap(*pte))
> > -             return PAGE_SHIFT;
> > -     return 0;
> > -}
> > -
> >  /*
> >   * Failure handling: if we can't find or can't kill a process there's
> >   * not much we can do.       We just print a message and ignore otherwise.
> > @@ -324,7 +290,9 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
> >       }
> >       tk->addr = page_address_in_vma(p, vma);
> >       if (is_zone_device_page(p))
> > -             tk->size_shift = dev_pagemap_mapping_shift(p, vma);
> > +             tk->size_shift =
> > +                     dev_pagemap_mapping_shift(vma_address(page, vma),
> > +                                               vma->vm_mm);
> >       else
> >               tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
> >
> > diff --git a/mm/util.c b/mm/util.c
> > index 3ad6db9a722e..59984e6b40ab 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -901,3 +901,37 @@ int memcmp_pages(struct page *page1, struct page *page2)
> >       kunmap_atomic(addr1);
> >       return ret;
> >  }
> > +
> > +unsigned long dev_pagemap_mapping_shift(unsigned long address,
> > +                                     struct mm_struct *mm)
> > +{
> > +     pgd_t *pgd;
> > +     p4d_t *p4d;
> > +     pud_t *pud;
> > +     pmd_t *pmd;
> > +     pte_t *pte;
> > +
> > +     pgd = pgd_offset(mm, address);
> > +     if (!pgd_present(*pgd))
> > +             return 0;
> > +     p4d = p4d_offset(pgd, address);
> > +     if (!p4d_present(*p4d))
> > +             return 0;
> > +     pud = pud_offset(p4d, address);
> > +     if (!pud_present(*pud))
> > +             return 0;
> > +     if (pud_devmap(*pud))
> > +             return PUD_SHIFT;
> > +     pmd = pmd_offset(pud, address);
> > +     if (!pmd_present(*pmd))
> > +             return 0;
> > +     if (pmd_devmap(*pmd))
> > +             return PMD_SHIFT;
> > +     pte = pte_offset_map(pmd, address);
> > +     if (!pte_present(*pte))
> > +             return 0;
> > +     if (pte_devmap(*pte))
> > +             return PAGE_SHIFT;
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pagemap_mapping_shift);
>
> This is basically a rehash of lookup_address_in_pgd(), and doesn't provide
> exactly what KVM needs.  E.g. KVM works with levels instead of shifts, and
> it would be nice to provide the pte so that KVM can sanity check that the
> pfn from this walk matches the pfn it plans on mapping.
>
> Instead of exporting dev_pagemap_mapping_shift(), what about relacing it
> with a patch to introduce lookup_address_mm() and export that?
>
> dev_pagemap_mapping_shift() could then wrap the new helper (if you want),
> and KVM could do lookup_address_mm() for querying the size of ZONE_DEVICE
> pages.

All of the above sounds great to me. Should have looked that much
harder when implementing dev_pagemap_mapping_shift() originally.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

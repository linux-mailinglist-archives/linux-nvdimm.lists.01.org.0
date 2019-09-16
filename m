Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 116E8B3FB8
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Sep 2019 19:46:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1352821962301;
	Mon, 16 Sep 2019 10:45:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1BA1F202BB9AC
 for <linux-nvdimm@lists.01.org>; Mon, 16 Sep 2019 10:45:50 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g19so565825otg.13
 for <linux-nvdimm@lists.01.org>; Mon, 16 Sep 2019 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QMOOvJcCOxvJGsQgO09ry9PIYgCnyHRaKHcmKjPMZDE=;
 b=sGHgEALCuEWB5ciy5vD0LBEP7OLBzMNFaPlQpilKVRzFeMz5JJHbuFQLj4PpNzUxPp
 FPdyG5nmqrAHieCHI3kNe4+51PPvluEc2panvSJRp/Vr78fXeOMN9J9AO8MNb2YDHmNY
 /B/x8b6XVp+VTZMNTlc4LHA6oWdGlrcPKrTrl0BLRV0W+5L1oFNWOqLJX5YXtM0en7/r
 orWUlsrnBAdgXUkqvm50ASXBbVpsUCnJMXSFFyNz3g675XJaH9ifvjpIjcc7Zpnm2tHU
 AHRzvUC/EUHEfUhb6CDI+p2UWpvUDtd/dXlfR4skq7vfp6oCyOXgqn9GU1VDcWJKaHL5
 3piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QMOOvJcCOxvJGsQgO09ry9PIYgCnyHRaKHcmKjPMZDE=;
 b=uZCvv955shzEfYDSIt1dCNP5hlc6KToIjpP/PW4qMfbFJvs9q2uj9d1uiYmxYpDvp/
 6lxgnk+FT6kuJpy7HBzLpnpnbOCsXk3hWUvbMEVcMf56cQoUzwE7538tYtGUsBNnZokG
 /EB/szvEHQ/cF/pndvz21vEvdfcYbCyY9br657jdBSKsvjYaanG+iqmv/LVdAMYoH+Ix
 cTVxtap0p74mc60jygenutVsTNAYwVyitSvh26CN8MMrELMxvX2ti/lyEu5BkbnnJ9nk
 H3WJ5LyyvuEjs/j5qco+3I52bfEFVeuvwERl4vwwlI5eNA2JbAnwd9bbEEUIn05WyMKT
 aCow==
X-Gm-Message-State: APjAAAVKN2de5bzAF3PxlFGoe1A7HyEuOwLPygjPm5Ww5GE28vMc8G1u
 JPslv7Mg+wV+8/lwOsSx9VD59Il6tg2hIun1PJ31+Q==
X-Google-Smtp-Source: APXvYqz8wwo7dB4Y3wRdLSUJkJjWQZmRljho5XvoU+unxbG7cxvDpcHYJWPfu6CFzQU4tdjicuiHDUtxjbkXi176AnU=
X-Received: by 2002:a9d:3a6:: with SMTP id f35mr263028otf.363.1568655981118;
 Mon, 16 Sep 2019 10:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190910062826.10041-1-aneesh.kumar@linux.ibm.com>
 <20190910062826.10041-2-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190910062826.10041-2-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 16 Sep 2019 10:46:10 -0700
Message-ID: <CAPcyv4ia0_GUu+=j-ecCuJkqaE5dVENNQxK_S-mO_KBmuA=9hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/nvdimm: Update vmemmap_populated to check
 sub-section range
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Sep 9, 2019 at 11:29 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> With commit: 7cc7867fb061 ("mm/devm_memremap_pages: enable sub-section remap")
> pmem namespaces are remapped in 2M chunks. On architectures like ppc64 we
> can map the memmap area using 16MB hugepage size and that can cover
> a memory range of 16G.
>
> While enabling new pmem namespaces, since memory is added in sub-section chunks,
> before creating a new memmap mapping, kernel should check whether there is an
> existing memmap mapping covering the new pmem namespace. Currently, this is
> validated by checking whether the section covering the range is already
> initialized or not. Considering there can be multiple namespaces in the same
> section this can result in wrong validation. Update this to check for
> sub-sections in the range. This is done by checking for all pfns in the range we
> are mapping.
>
> We could optimize this by checking only just one pfn in each sub-section. But
> since this is not fast-path we keep this simple.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/mm/init_64.c | 45 ++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 4e08246acd79..7710ccdc19a2 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -70,30 +70,24 @@ EXPORT_SYMBOL_GPL(kernstart_addr);
>
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>  /*
> - * Given an address within the vmemmap, determine the pfn of the page that
> - * represents the start of the section it is within.  Note that we have to
> - * do this by hand as the proffered address may not be correctly aligned.
> - * Subtraction of non-aligned pointers produces undefined results.
> - */
> -static unsigned long __meminit vmemmap_section_start(unsigned long page)
> -{
> -       unsigned long offset = page - ((unsigned long)(vmemmap));
> -
> -       /* Return the pfn of the start of the section. */
> -       return (offset / sizeof(struct page)) & PAGE_SECTION_MASK;
> -}
> -
> -/*
> - * Check if this vmemmap page is already initialised.  If any section
> + * Check if this vmemmap page is already initialised.  If any sub section
>   * which overlaps this vmemmap page is initialised then this page is
>   * initialised already.
>   */
> -static int __meminit vmemmap_populated(unsigned long start, int page_size)
> +
> +static int __meminit vmemmap_populated(unsigned long start, int size)
>  {
> -       unsigned long end = start + page_size;
> -       start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
> +       unsigned long end = start + size;
>
> -       for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
> +       /* start is size aligned and it is always > sizeof(struct page) */
> +       VM_BUG_ON(start & sizeof(struct page));

If start is size aligned why not include that assumption in the VM_BUG_ON()?

Otherwise it seems this patch could be reduced simply by:

s/PAGE_SECTION_MASK/PAGE_SUBSECTION_MASK/
s/PAGES_PER_SECTION/PAGES_PER_SUBSECTION/

...and leave the vmemmap_section_start() function in place? In other
words this path used to guarantee that 'start' was aligned to the
minimum mem-hotplug granularity, the change looks ok on the surface,
but it seems a subtle change in semantics.

Can you get an ack from a powerpc maintainer, or maybe this patch
should route through the powerpc tree?

I'll take patch1 through the nvdimm tree.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

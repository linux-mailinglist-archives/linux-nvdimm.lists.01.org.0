Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95822B46F4
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Sep 2019 07:47:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8C44202C80B2;
	Mon, 16 Sep 2019 22:47:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com;
 envelope-from=oohall@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 58442202C80A3
 for <linux-nvdimm@lists.01.org>; Mon, 16 Sep 2019 22:47:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q1so4785011ion.1
 for <linux-nvdimm@lists.01.org>; Mon, 16 Sep 2019 22:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6RTu8mE0v8dDzYFU771cljv6JSmKaSheGyrYg8GFnos=;
 b=e2f6c1/XWZIUlyABDGWPqDH92TAnXh9UNCH7VsTpFc9v0ZEDy3QTX9wMTiiCb4JDqp
 Omocuftdsg8gZIwEvldle+h+Fxmx2QAKREIn3gONWvw2KmaochhumihkIMdJv94n0bse
 iQ2tz5j7/btzEo87BnOjDLw/TBA7mVLam4Cc619yAjLotJGwYLvqamHZfcvicWZWAdic
 FXl/LZiTnLGJ4qDbxVILNJu0BDsA78Y0WAdBlWVooVhVJWRTeNa51miI+PxPnSjQ2Yeq
 KXXx1WiAK5PyxZS9zLtPUH4tthuRhxJfaCAiGSpnVxpp9VZSQFfGd8sVXXwAiAv4kmlb
 YD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6RTu8mE0v8dDzYFU771cljv6JSmKaSheGyrYg8GFnos=;
 b=JzIAJ8godwevFSJDl11I6aYvbVQfGPQqUOt5ejn2dEi5lBLMNfnvxgUBlFu2jo0Afz
 JgRwQ/iDq1RYKYw95WHK32WZON8g5wzvCze6LiligsAQfXP0v+ILkIStSFNBIMwCES4g
 AnvXWB0mcLblC5GhUKy5jcxGnSYxLnbR7YI2mYYMvW6bNPulCIZ1uKyH+EEkQkx4ypUG
 bPr6iUOvdzCSEoVa77OnUULfN7mrOAdF7/It+VG8UKetFNTgEWrdQyRsx79CuXFrlKWe
 2umgNVyQb+o/UQCkv1VbFhDvzDSY+OCtpKMFhfwH7Iigm8N8iPR/h8qA9Of0W2u5FN/x
 yGHg==
X-Gm-Message-State: APjAAAU1DTF7+tO5F9q035PIQ/YWH7Hy2/fi9my/IUM3LDacQf8ptztM
 nQVnAalXE7P9cjKwrPaYnvy76fp0ufcCQehG1U8=
X-Google-Smtp-Source: APXvYqxRbU0svRR+/zO+uKSQK699vKFI+qTrhvXN9zA9kBJkNttGfjNZu91MvkXroCin3BWBnyWEf9EQRv2FLHs7KHE=
X-Received: by 2002:a5d:9b02:: with SMTP id y2mr1794945ion.146.1568699258149; 
 Mon, 16 Sep 2019 22:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190910062826.10041-1-aneesh.kumar@linux.ibm.com>
 <20190910062826.10041-2-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190910062826.10041-2-aneesh.kumar@linux.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Tue, 17 Sep 2019 15:47:26 +1000
Message-ID: <CAOSf1CH=6DZkVT5JK5wuFiq_y3EVefXoOdEc3m2E8CXp5_VfHA@mail.gmail.com>
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
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 10, 2019 at 4:29 PM Aneesh Kumar K.V
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

If you want to go with Dan's suggestion of keeping the function and
using PAGE_SUBSECTION_MASK then can you fold the pfn_to_page() below
into vmemmap_section_start()? The current behaviour of returning a pfn
makes no sense to me.

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

> -       for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
> +       /* start is size aligned and it is always > sizeof(struct page) */
> +       VM_BUG_ON(start & sizeof(struct page));

Shouldn't the test be: start & (sizeof(struct page) - 1)?
VM_BUG_ON(start != ALIGN(start, page_size)) would be clearer.

> +       for (; start < end; start += sizeof(struct page))
> +               /*
> +                * pfn valid check here is intended to really check
> +                * whether we have any subsection already initialized
> +                * in this range. We keep it simple by checking every
> +                * pfn in the range.
> +                */
>                 if (pfn_valid(page_to_pfn((struct page *)start)))
>                         return 1;

Having a few lines of separation between the for () and the loop body
always looks a bit sketch, even if it's just a comment. Wrapping the
block in braces or moving the comment above the loop is probably a
good idea.

Looks fine otherwise
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

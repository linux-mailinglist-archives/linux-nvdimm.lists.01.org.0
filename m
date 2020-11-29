Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611792C79C7
	for <lists+linux-nvdimm@lfdr.de>; Sun, 29 Nov 2020 16:54:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8ED28100EC1FB;
	Sun, 29 Nov 2020 07:54:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com; envelope-from=shakeelb@google.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8EBC5100EC1FA
	for <linux-nvdimm@lists.01.org>; Sun, 29 Nov 2020 07:53:59 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id v14so15668593lfo.3
        for <linux-nvdimm@lists.01.org>; Sun, 29 Nov 2020 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3PuJ9ydxTViJxhC8bUeJS1Nnpydv/VEM9Wi1gMrMaBs=;
        b=isTAhbDaUuUXk1VQ3ndJOQ/CuS5MKUiZU9CQF6PymdXpFUOWrtmdwQbOetQXqfuYcu
         DN+OBA9qL3A9IiYDok2MOFG354WJgz9qAUvm/bYWWVPi9WyZ1PJ1lNfGjJRLoAZLO2Vg
         uRTzD4pVG+cV2/ymy6+tsxqoVguJfYNDW/2RvIvgoZeWEzlw11EW3XkkvoYk35tVWwPn
         HfZCQVeqGtpyFhpd4OUy9FJVmyQdiOL8EaFCqmL+9cNs+NvTNNL4303WZgB9szddFdV8
         BfgLnmnM0DdbVQ1i8kfeHCJ1NEzilifWALzo17ajgIx/BZAN0Q0Iv6ejITAt4NtpIu5W
         GSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3PuJ9ydxTViJxhC8bUeJS1Nnpydv/VEM9Wi1gMrMaBs=;
        b=XVcODiwUhhPkwZuq1rh//aztOpR9wuhDz+e9nkfs2q02OYo+EuESDqqL+D4+HtJxwo
         4UVRrQzwzSigySmK7HyeD9YztzpMxK+6TuuuKF6B1O4g0mv2Xx8dvVMCsKp7AMGREZVI
         lTrPtWZEEj9hCn5qGOVxBpbYLvGW8fI8DwaLbf8DbJWazQsRsVbHB6/vh2GR6IlN2Vkf
         TpEhmWLjyfkCcSlBKKF7D93jY5KRseFHLpa6akoj8YAZs22fo0lTQXQMkubLmjixd/mf
         hoUHhIOiKZmjXO2LkTWfB33KYcAwnBTOebfzZ81A8Cc4wamKCd/5TTW/9/feKoMxW76Q
         sujQ==
X-Gm-Message-State: AOAM53136t2vMM8D7i/cm9daYkF4eaOqCxMTgczX1oEQRGFD1hm8BGe4
	MO+HEYxRlgzIM4tZjIgmWTGqf5e6HLB+XWtw6gkWJw==
X-Google-Smtp-Source: ABdhPJzudR+9Ib3gs3Y02i4BAQQW5kNsVm6Yid+szIpP/1AQJ9ils7ZN++n24NpQOPLTFTgkysS30jlcr9Wp5KFuvz0=
X-Received: by 2002:ac2:43b1:: with SMTP id t17mr7446330lfl.385.1606665236632;
 Sun, 29 Nov 2020 07:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20201125092208.12544-1-rppt@kernel.org> <20201125092208.12544-8-rppt@kernel.org>
In-Reply-To: <20201125092208.12544-8-rppt@kernel.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Sun, 29 Nov 2020 07:53:45 -0800
Message-ID: <CALvZod4MoXod_YkbO+4k2=PS=xdMVbZa2HWWuUnMZ1G9hSr+Jw@mail.gmail.com>
Subject: Re: [PATCH v12 07/10] secretmem: add memcg accounting
To: Mike Rapoport <rppt@kernel.org>
Message-ID-Hash: WVLEGBCSDBJAMMZZSHC6TGXUJEFDAAG4
X-Message-ID-Hash: WVLEGBCSDBJAMMZZSHC6TGXUJEFDAAG4
X-MailFrom: shakeelb@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deac
 on <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WVLEGBCSDBJAMMZZSHC6TGXUJEFDAAG4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 25, 2020 at 1:51 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Account memory consumed by secretmem to memcg. The accounting is updated
> when the memory is actually allocated and freed.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/filemap.c   |  3 ++-
>  mm/secretmem.c | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 249cf489f5df..cf7f1dc9f4b8 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -42,6 +42,7 @@
>  #include <linux/psi.h>
>  #include <linux/ramfs.h>
>  #include <linux/page_idle.h>
> +#include <linux/secretmem.h>
>  #include "internal.h"
>
>  #define CREATE_TRACE_POINTS
> @@ -844,7 +845,7 @@ static noinline int __add_to_page_cache_locked(struct page *page,
>         page->mapping = mapping;
>         page->index = offset;
>
> -       if (!huge) {
> +       if (!huge && !page_is_secretmem(page)) {
>                 error = mem_cgroup_charge(page, current->mm, gfp);
>                 if (error)
>                         goto error;
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 52a900a135a5..eb6628390444 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -18,6 +18,7 @@
>  #include <linux/memblock.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/secretmem.h>
> +#include <linux/memcontrol.h>
>  #include <linux/set_memory.h>
>  #include <linux/sched/signal.h>
>
> @@ -44,6 +45,32 @@ struct secretmem_ctx {
>
>  static struct cma *secretmem_cma;
>
> +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> +{
> +       int err;
> +
> +       err = memcg_kmem_charge_page(page, gfp, order);
> +       if (err)
> +               return err;
> +
> +       /*
> +        * seceremem caches are unreclaimable kernel allocations, so treat
> +        * them as unreclaimable slab memory for VM statistics purposes
> +        */
> +       mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> +                           PAGE_SIZE << order);

Please use mod_lruvec_page_state() instead, so we get the memcg stats too.

BTW I think secretmem deserves a vmstat entry instead of overloading
NR_SLAB_UNRECLAIMABLE_B.

> +
> +       return 0;
> +}
> +
> +static void secretmem_unaccount_pages(struct page *page, int order)
> +{
> +
> +       mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> +                           -PAGE_SIZE << order);
> +       memcg_kmem_uncharge_page(page, order);
> +}
> +
>  static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  {
>         unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
> @@ -56,10 +83,14 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>         if (!page)
>                 return -ENOMEM;
>
> -       err = set_direct_map_invalid_noflush(page, nr_pages);
> +       err = secretmem_account_pages(page, gfp, PMD_PAGE_ORDER);
>         if (err)
>                 goto err_cma_release;
>
> +       err = set_direct_map_invalid_noflush(page, nr_pages);
> +       if (err)
> +               goto err_memcg_uncharge;
> +
>         addr = (unsigned long)page_address(page);
>         err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
>         if (err)
> @@ -76,6 +107,8 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>          * won't fail
>          */
>         set_direct_map_default_noflush(page, nr_pages);
> +err_memcg_uncharge:
> +       secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
>  err_cma_release:
>         cma_release(secretmem_cma, page, nr_pages);
>         return err;
> @@ -302,6 +335,7 @@ static void secretmem_cleanup_chunk(struct gen_pool *pool,
>         int i;
>
>         set_direct_map_default_noflush(page, nr_pages);
> +       secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
>
>         for (i = 0; i < nr_pages; i++)
>                 clear_highpage(page + i);
> --
> 2.28.0
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

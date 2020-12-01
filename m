Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 693522CA87D
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Dec 2020 17:44:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D4E9100ED49C;
	Tue,  1 Dec 2020 08:44:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 18E25100ED48A
	for <linux-nvdimm@lists.01.org>; Tue,  1 Dec 2020 08:44:42 -0800 (PST)
Received: from kernel.org (unknown [87.71.85.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id DAF89206B7;
	Tue,  1 Dec 2020 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1606841081;
	bh=GUtX0hNx32YEEtCdAUkzC5OF7zPy+e78biDig6Frozg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvfnhaSLv1jMRih6i9BkZFwqT83+9p5JD98gXcO7JIrkTzOBB+rRro5U9QgAxqQSV
	 7dt/xWjtLVQEVt1Ex5jrQh1zNLQMN4ovnZ42jokTz+d8CL1J4Neq9s1+q39AS5euFb
	 +V52ld2bkVC2Nmbbgl6GFHYT0sShRwKokRlnOllM=
Date: Tue, 1 Dec 2020 18:44:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v13 07/10] secretmem: add memcg accounting
Message-ID: <20201201164424.GC751215@kernel.org>
References: <20201201074559.27742-1-rppt@kernel.org>
 <20201201074559.27742-8-rppt@kernel.org>
 <CALvZod4bTBGf7DS=5EUCeU810p5C1aqf5sB0n1N8sc4jt5W3Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALvZod4bTBGf7DS=5EUCeU810p5C1aqf5sB0n1N8sc4jt5W3Tg@mail.gmail.com>
Message-ID-Hash: HAPJCSF2HSNI24ZUUGJ7RP2B56ZO5XR4
X-Message-ID-Hash: HAPJCSF2HSNI24ZUUGJ7RP2B56ZO5XR4
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deac
 on <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HAPJCSF2HSNI24ZUUGJ7RP2B56ZO5XR4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 01, 2020 at 08:26:28AM -0800, Shakeel Butt wrote:
> On Mon, Nov 30, 2020 at 11:47 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Account memory consumed by secretmem to memcg. The accounting is updated
> > when the memory is actually allocated and freed.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Acked-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/filemap.c   |  3 ++-
> >  mm/secretmem.c | 36 +++++++++++++++++++++++++++++++++++-
> >  2 files changed, 37 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 249cf489f5df..cf7f1dc9f4b8 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -42,6 +42,7 @@
> >  #include <linux/psi.h>
> >  #include <linux/ramfs.h>
> >  #include <linux/page_idle.h>
> > +#include <linux/secretmem.h>
> >  #include "internal.h"
> >
> >  #define CREATE_TRACE_POINTS
> > @@ -844,7 +845,7 @@ static noinline int __add_to_page_cache_locked(struct page *page,
> >         page->mapping = mapping;
> >         page->index = offset;
> >
> > -       if (!huge) {
> > +       if (!huge && !page_is_secretmem(page)) {
> >                 error = mem_cgroup_charge(page, current->mm, gfp);
> >                 if (error)
> >                         goto error;
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index 52a900a135a5..5e3e5102ad4c 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/pseudo_fs.h>
> >  #include <linux/secretmem.h>
> > +#include <linux/memcontrol.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/sched/signal.h>
> >
> > @@ -44,6 +45,32 @@ struct secretmem_ctx {
> >
> >  static struct cma *secretmem_cma;
> >
> > +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> > +{
> > +       int err;
> > +
> > +       err = memcg_kmem_charge_page(page, gfp, order);
> > +       if (err)
> > +               return err;
> > +
> > +       /*
> > +        * seceremem caches are unreclaimable kernel allocations, so treat
> > +        * them as unreclaimable slab memory for VM statistics purposes
> > +        */
> > +       mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> > +                             PAGE_SIZE << order);
> > +
> > +       return 0;
> > +}
> > +
> > +static void secretmem_unaccount_pages(struct page *page, int order)
> > +{
> > +
> > +       mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> > +                           -PAGE_SIZE << order);
> 
> mod_lruvec_page_state()

Argh... Will fix.

> > +       memcg_kmem_uncharge_page(page, order);
> > +}
> > +
> >  static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
> >  {
> >         unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
> > @@ -56,10 +83,14 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
> >         if (!page)
> >                 return -ENOMEM;
> >
> > -       err = set_direct_map_invalid_noflush(page, nr_pages);
> > +       err = secretmem_account_pages(page, gfp, PMD_PAGE_ORDER);
> >         if (err)
> >                 goto err_cma_release;
> >
> > +       err = set_direct_map_invalid_noflush(page, nr_pages);
> > +       if (err)
> > +               goto err_memcg_uncharge;
> > +
> >         addr = (unsigned long)page_address(page);
> >         err = gen_pool_add(pool, addr, PMD_SIZE, NUMA_NO_NODE);
> >         if (err)
> > @@ -76,6 +107,8 @@ static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
> >          * won't fail
> >          */
> >         set_direct_map_default_noflush(page, nr_pages);
> > +err_memcg_uncharge:
> > +       secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
> >  err_cma_release:
> >         cma_release(secretmem_cma, page, nr_pages);
> >         return err;
> > @@ -302,6 +335,7 @@ static void secretmem_cleanup_chunk(struct gen_pool *pool,
> >         int i;
> >
> >         set_direct_map_default_noflush(page, nr_pages);
> > +       secretmem_unaccount_pages(page, PMD_PAGE_ORDER);
> >
> >         for (i = 0; i < nr_pages; i++)
> >                 clear_highpage(page + i);
> > --
> > 2.28.0
> >

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

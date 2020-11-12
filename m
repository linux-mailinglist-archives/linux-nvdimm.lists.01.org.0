Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 703F52B07F7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Nov 2020 15:59:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65DBD100ED4A9;
	Thu, 12 Nov 2020 06:58:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 60254100ED4A8
	for <linux-nvdimm@lists.01.org>; Thu, 12 Nov 2020 06:56:48 -0800 (PST)
Received: from kernel.org (unknown [77.125.7.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 566A022201;
	Thu, 12 Nov 2020 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1605193007;
	bh=QkVICLAO4ozuqf3Bt0mUjabumvXMRV/qPjzZ7U10aJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iak4/IvzTZDhTLRXHEmbJYF+IHtHGQSZqe12VKzkSpaDbDqIvEPyBuT8j1ZMZkL7P
	 sxndVf5ZvuLfKKos4xIYzBSsfmBnEEE707F0PBrZqhUFCfrF3XMAMq2Nf2X4t5chOP
	 PKQWsilG0fJ4aSXI1Exn3KDnpPmFrzW2Ouszqhbk=
Date: Thu, 12 Nov 2020 16:56:30 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201112145630.GN4758@kernel.org>
References: <20201110151444.20662-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201110151444.20662-1-rppt@kernel.org>
Message-ID-Hash: GRIPASCAVFQDAVQ2BGBRDJAB7DYNUDSF
X-Message-ID-Hash: GRIPASCAVFQDAVQ2BGBRDJAB7DYNUDSF
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.o
 rg, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GRIPASCAVFQDAVQ2BGBRDJAB7DYNUDSF/>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

It'll be great if this can be pulled back to mmotm for wider exposure to
testing and fuzzing.

On Tue, Nov 10, 2020 at 05:14:35PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> This is an implementation of "secret" mappings backed by a file descriptor.
> 
> The file descriptor backing secret memory mappings is created using a
> dedicated memfd_secret system call The desired protection mode for the
> memory is configured using flags parameter of the system call. The mmap()
> of the file descriptor created with memfd_secret() will create a "secret"
> memory mapping. The pages in that mapping will be marked as not present in
> the direct map and will have desired protection bits set in the user page
> table. For instance, current implementation allows uncached mappings.
> 
> Although normally Linux userspace mappings are protected from other users,
> such secret mappings are useful for environments where a hostile tenant is
> trying to trick the kernel into giving them access to other tenants
> mappings.
> 
> Additionally, in the future the secret mappings may be used as a mean to
> protect guest memory in a virtual machine host.
> 
> For demonstration of secret memory usage we've created a userspace library
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/secret-memory-preloader.git
> 
> that does two things: the first is act as a preloader for openssl to
> redirect all the OPENSSL_malloc calls to secret memory meaning any secret
> keys get automatically protected this way and the other thing it does is
> expose the API to the user who needs it. We anticipate that a lot of the
> use cases would be like the openssl one: many toolkits that deal with
> secret keys already have special handling for the memory to try to give
> them greater protection, so this would simply be pluggable into the
> toolkits without any need for user application modification.
> 
> Hiding secret memory mappings behind an anonymous file allows (ab)use of
> the page cache for tracking pages allocated for the "secret" mappings as
> well as using address_space_operations for e.g. page migration callbacks.
> 
> The anonymous file may be also used implicitly, like hugetlb files, to
> implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
> ABIs in the future.
> 
> To limit fragmentation of the direct map to splitting only PUD-size pages,
> I've added an amortizing cache of PMD-size pages to each file descriptor
> that is used as an allocation pool for the secret memory areas.
> 
> As the memory allocated by secretmem becomes unmovable, we use CMA to back
> large page caches so that page allocator won't be surprised by failing attempt
> to migrate these pages.
> 
> v8:
> * Use CMA for all secretmem allocations as David suggested
> * Update memcg accounting after transtion to CMA
> * Prevent hibernation when there are active secretmem users
> * Add zeroing of the memory before releasing it back to cma/page allocator
> * Rebase on v5.10-rc2-mmotm-2020-11-07-21-40
> 
> v7: https://lore.kernel.org/lkml/20201026083752.13267-1-rppt@kernel.org
> * Use set_direct_map() instead of __kernel_map_pages() to ensure error
>   handling in case the direct map update fails
> * Add accounting of large pages used to reduce the direct map fragmentation
> * Teach get_user_pages() and frieds to refuse get/pin secretmem pages
> 
> v6: https://lore.kernel.org/lkml/20200924132904.1391-1-rppt@kernel.org
> * Silence the warning about missing syscall, thanks to Qian Cai
> * Replace spaces with tabs in Kconfig additions, per Randy
> * Add a selftest.
> 
> v5: https://lore.kernel.org/lkml/20200916073539.3552-1-rppt@kernel.org
> * rebase on v5.9-rc5
> * drop boot time memory reservation patch
> 
> v4: https://lore.kernel.org/lkml/20200818141554.13945-1-rppt@kernel.org
> * rebase on v5.9-rc1
> * Do not redefine PMD_PAGE_ORDER in fs/dax.c, thanks Kirill
> * Make secret mappings exclusive by default and only require flags to
>   memfd_secret() system call for uncached mappings, thanks again Kirill :)
> 
> v3: https://lore.kernel.org/lkml/20200804095035.18778-1-rppt@kernel.org
> * Squash kernel-parameters.txt update into the commit that added the
>   command line option.
> * Make uncached mode explicitly selectable by architectures. For now enable
>   it only on x86.
> 
> v2: https://lore.kernel.org/lkml/20200727162935.31714-1-rppt@kernel.org
> * Follow Michael's suggestion and name the new system call 'memfd_secret'
> * Add kernel-parameters documentation about the boot option
> * Fix i386-tinyconfig regression reported by the kbuild bot.
>   CONFIG_SECRETMEM now depends on !EMBEDDED to disable it on small systems
>   from one side and still make it available unconditionally on
>   architectures that support SET_DIRECT_MAP.
> 
> v1: https://lore.kernel.org/lkml/20200720092435.17469-1-rppt@kernel.org
> 
> Mike Rapoport (9):
>   mm: add definition of PMD_PAGE_ORDER
>   mmap: make mlock_future_check() global
>   set_memory: allow set_direct_map_*_noflush() for multiple pages
>   mm: introduce memfd_secret system call to create "secret" memory areas
>   secretmem: use PMD-size pages to amortize direct map fragmentation
>   secretmem: add memcg accounting
>   PM: hibernate: disable when there are active secretmem users
>   arch, mm: wire up memfd_secret system call were relevant
>   secretmem: test: add basic selftest for memfd_secret(2)
> 
>  arch/Kconfig                              |   7 +
>  arch/arm64/include/asm/cacheflush.h       |   4 +-
>  arch/arm64/include/asm/unistd.h           |   2 +-
>  arch/arm64/include/asm/unistd32.h         |   2 +
>  arch/arm64/include/uapi/asm/unistd.h      |   1 +
>  arch/arm64/mm/pageattr.c                  |  10 +-
>  arch/riscv/include/asm/set_memory.h       |   4 +-
>  arch/riscv/include/asm/unistd.h           |   1 +
>  arch/riscv/mm/pageattr.c                  |   8 +-
>  arch/x86/Kconfig                          |   1 +
>  arch/x86/entry/syscalls/syscall_32.tbl    |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
>  arch/x86/include/asm/set_memory.h         |   4 +-
>  arch/x86/mm/pat/set_memory.c              |   8 +-
>  fs/dax.c                                  |  11 +-
>  include/linux/pgtable.h                   |   3 +
>  include/linux/secretmem.h                 |  30 ++
>  include/linux/set_memory.h                |   4 +-
>  include/linux/syscalls.h                  |   1 +
>  include/uapi/asm-generic/unistd.h         |   6 +-
>  include/uapi/linux/magic.h                |   1 +
>  include/uapi/linux/secretmem.h            |   8 +
>  kernel/power/hibernate.c                  |   5 +-
>  kernel/power/snapshot.c                   |   4 +-
>  kernel/sys_ni.c                           |   2 +
>  mm/Kconfig                                |   5 +
>  mm/Makefile                               |   1 +
>  mm/filemap.c                              |   2 +-
>  mm/gup.c                                  |  10 +
>  mm/internal.h                             |   3 +
>  mm/mmap.c                                 |   5 +-
>  mm/secretmem.c                            | 451 ++++++++++++++++++++++
>  mm/vmalloc.c                              |   5 +-
>  scripts/checksyscalls.sh                  |   4 +
>  tools/testing/selftests/vm/.gitignore     |   1 +
>  tools/testing/selftests/vm/Makefile       |   3 +-
>  tools/testing/selftests/vm/memfd_secret.c | 298 ++++++++++++++
>  tools/testing/selftests/vm/run_vmtests    |  17 +
>  38 files changed, 895 insertions(+), 39 deletions(-)
>  create mode 100644 include/linux/secretmem.h
>  create mode 100644 include/uapi/linux/secretmem.h
>  create mode 100644 mm/secretmem.c
>  create mode 100644 tools/testing/selftests/vm/memfd_secret.c
> 
> 
> base-commit: 9f8ce377d420db12b19d6a4f636fecbd88a725a5
> -- 
> 2.28.0
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

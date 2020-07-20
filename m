Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61773225B6D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 11:25:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9854F123757CB;
	Mon, 20 Jul 2020 02:24:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 20DD0100A302D
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 02:24:58 -0700 (PDT)
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B05072176B;
	Mon, 20 Jul 2020 09:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595237097;
	bh=DZJgFWT9EBpxUAxDadsCWuChLAtXVn8oZMtP9QRL6C8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZTwUZAfjeouKDVccICNkfWj3AXzdsSuDk2rXgQ1No8faUuhgdJkyGv8pNjSwr1p8s
	 KG+pxfIgNxDLMiwrUoHqNrpWJhB5PtUOQUvLH6+XLLQNsMur9U/3CoZ5gGNVXCI9pB
	 je+UNlkcrWBPmVpDOLe0ai7+vZwqHYtU7Ofhrs9o=
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] mm: introduce secretmemfd system call to create "secret" memory areas
Date: Mon, 20 Jul 2020 12:24:29 +0300
Message-Id: <20200720092435.17469-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: UZQ3GH6V5MOLNM7FYGOIGXCZZV7RHSIU
X-Message-ID-Hash: UZQ3GH6V5MOLNM7FYGOIGXCZZV7RHSIU
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kv
 ack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UZQ3GH6V5MOLNM7FYGOIGXCZZV7RHSIU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is the third version of "secret" mappings implementation backed by a
file descriptor. 

The file descriptor is created using a dedicated secretmemfd system call
The desired protection mode for the memory is configured using flags
parameter of the system call. The mmap() of the file descriptor created
with secretmemfd() will create a "secret" memory mapping. The pages in that
mapping will be marked as not present in the direct map and will have
desired protection bits set in the user page table. For instance, current
implementation allows uncached mappings.

Although normally Linux userspace mappings are protected from other users, 
such secret mappings are useful for environments where a hostile tenant is
trying to trick the kernel into giving them access to other tenants
mappings.

Additionally, the secret mappings may be used as a mean to protect guest
memory in a virtual machine host.

For demonstration of secret memory usage we've created a userspace library
[1] that does two things: the first is act as a preloader for openssl to
redirect all the OPENSSL_malloc calls to secret memory meaning any secret
keys get automatically protected this way and the other thing it does is
expose the API to the user who needs it. We anticipate that a lot of the
use cases would be like the openssl one: many toolkits that deal with
secret keys already have special handling for the memory to try to give
them greater protection, so this would simply be pluggable into the
toolkits without any need for user application modification.

I've hesitated whether to continue to use new flags to memfd_create() or to
add a new system call and I've decided to use a new system call after I've
started to look into man pages update. There would have been two completely
independent descriptions and I think it would have been very confusing.

Hiding secret memory mappings behind an anonymous file allows (ab)use of
the page cache for tracking pages allocated for the "secret" mappings as
well as using address_space_operations for e.g. page migration callbacks.

The anonymous file may be also used implicitly, like hugetlb files, to
implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
ABIs in the future.

As the fragmentation of the direct map was one of the major concerns raised
during the previous postings, I've added an amortizing cache of PMD-size
pages to each file descriptor and an ability to reserve large chunks of the
physical memory at boot time and then use this memory as an allocation pool
for the secret memory areas.

In addition, I've tried to find some numbers that show the benefit of using
larger pages in the direct map, but I couldn't find anything so I've run a
couple of benchmarks from phoronix-test-suite on my laptop (i7-8650U with
32G RAM).

I've tested three variants: the default with 28G of the physical memory
covered with 1G pages, then I disabled 1G pages using "nogbpages" in the
kernel command line and at last I've forced the entire direct map to use 4K
pages using a simple patch to arch/x86/mm/init.c.
I've made runs of the benchmarks with SSD and tmpfs.

Surprisingly, the results does not show huge advantage for large pages. For
instance, here the results for kernel build with 'make -j8', in seconds:

                        |  1G    |  2M    |  4K
------------------------+--------+--------+---------
ssd, mitigations=on	| 308.75 | 317.37 | 314.9 
ssd, mitigations=off	| 305.25 | 295.32 | 304.92 
ram, mitigations=on	| 301.58 | 322.49 | 306.54 
ram, mitigations=off	| 299.32 | 288.44 | 310.65

All the results I have are available at [2].
If anybody is interested in plain text, please let me know.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rppt/secret-memory-preloader.git/
[2] https://docs.google.com/spreadsheets/d/1tdD-cu8e93vnfGsTFxZ5YdaEfs2E1GELlvWNOGkJV2U/edit?usp=sharing

Mike Rapoport (6):
  mm: add definition of PMD_PAGE_ORDER
  mmap: make mlock_future_check() global
  mm: introduce secretmemfd system call to create "secret" memory areas
  arch, mm: wire up secretmemfd system call were relevant
  mm: secretmem: use PMD-size pages to amortize direct map fragmentation
  mm: secretmem: add ability to reserve memory at boot

 arch/arm64/include/asm/unistd32.h      |   2 +
 arch/arm64/include/uapi/asm/unistd.h   |   1 +
 arch/riscv/include/asm/unistd.h        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/dax.c                               |  10 +-
 include/linux/pgtable.h                |   3 +
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   7 +-
 include/uapi/linux/magic.h             |   1 +
 include/uapi/linux/secretmem.h         |   9 +
 mm/Kconfig                             |   4 +
 mm/Makefile                            |   1 +
 mm/internal.h                          |   3 +
 mm/mmap.c                              |   5 +-
 mm/secretmem.c                         | 450 +++++++++++++++++++++++++
 16 files changed, 491 insertions(+), 9 deletions(-)
 create mode 100644 include/uapi/linux/secretmem.h
 create mode 100644 mm/secretmem.c


base-commit: f932d58abc38c898d7d3fe635ecb2b821a256f54
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

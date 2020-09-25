Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F2627851B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 12:31:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1F02F154B1BF3;
	Fri, 25 Sep 2020 03:31:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by ml01.01.org (Postfix) with ESMTP id 832DE154ABA2D
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 03:31:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1AE91045;
	Fri, 25 Sep 2020 03:31:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.16.138])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1DFE3F718;
	Fri, 25 Sep 2020 03:31:21 -0700 (PDT)
Date: Fri, 25 Sep 2020 11:31:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200925103114.GA7407@C02TD0UTHF1T.local>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <8435eff6-7fa9-d923-45e5-d8850e4c6d73@redhat.com>
 <20200925095029.GX2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200925095029.GX2628@hirez.programming.kicks-ass.net>
Message-ID-Hash: GDBMQOSFDKSLPEU2VNQPCPSPOLHMHZAH
X-Message-ID-Hash: GDBMQOSFDKSLPEU2VNQPCPSPOLHMHZAH
X-MailFrom: mark.rutland@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-ar
 m-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GDBMQOSFDKSLPEU2VNQPCPSPOLHMHZAH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Sorry to come to this so late; I've been meaning to provide feedback on
this for a while but have been indisposed for a bit due to an injury.

On Fri, Sep 25, 2020 at 11:50:29AM +0200, Peter Zijlstra wrote:
> On Fri, Sep 25, 2020 at 11:00:30AM +0200, David Hildenbrand wrote:
> > On 25.09.20 09:41, Peter Zijlstra wrote:
> > > On Thu, Sep 24, 2020 at 04:29:03PM +0300, Mike Rapoport wrote:
> > >> From: Mike Rapoport <rppt@linux.ibm.com>
> > >>
> > >> Removing a PAGE_SIZE page from the direct map every time such page is
> > >> allocated for a secret memory mapping will cause severe fragmentation of
> > >> the direct map. This fragmentation can be reduced by using PMD-size pages
> > >> as a pool for small pages for secret memory mappings.
> > >>
> > >> Add a gen_pool per secretmem inode and lazily populate this pool with
> > >> PMD-size pages.
> > > 
> > > What's the actual efficacy of this? Since the pmd is per inode, all I
> > > need is a lot of inodes and we're in business to destroy the directmap,
> > > no?
> > > 
> > > Afaict there's no privs needed to use this, all a process needs is to
> > > stay below the mlock limit, so a 'fork-bomb' that maps a single secret
> > > page will utterly destroy the direct map.
> > > 
> > > I really don't like this, at all.
> > 
> > As I expressed earlier, I would prefer allowing allocation of secretmem
> > only from a previously defined CMA area. This would physically locally
> > limit the pain.
> 
> Given that this thing doesn't have a migrate hook, that seems like an
> eminently reasonable contraint. Because not only will it mess up the
> directmap, it will also destroy the ability of the page-allocator /
> compaction to re-form high order blocks by sprinkling holes throughout.
> 
> Also, this is all very close to XPFO, yet I don't see that mentioned
> anywhere.

Agreed. I think if we really need something like this, something between
XPFO and DEBUG_PAGEALLOC would be generally better, since:

* Secretmem puts userspace in charge of kernel internals (AFAICT without
  any ulimits?), so that seems like an avenue for malicious or buggy
  userspace to exploit and trigger DoS, etc. The other approaches leave
  the kernel in charge at all times, and it's a system-level choice
  which is easier to reason about and test.

* Secretmem interaction with existing ABIs is unclear. Should uaccess
  primitives work for secretmem? If so, this means that it's not valid
  to transform direct uaccesses in syscalls etc into accesses via the
  linear/direct map. If not, how do we prevent syscalls? The other
  approaches are clear that this should always work, but the kernel
  should avoid mappings wherever possible.

* The uncached option doesn't work in a number of situations, such as
  systems which are purely cache coherent at all times, or where the
  hypervisor has overridden attributes. The kernel cannot even know that
  whther this works as intended. On its own this doens't solve a
  particular problem, and I think this is a solution looking for a
  problem.

... and fundamentally, this seems like a "more security, please" option
that is going to be abused, since everyone wants security, regardless of
how we say it *should* be used. The few use-cases that may make sense
(e.g. protection of ketys and/or crypto secrrets), aren't going to be
able to rely on this (since e.g. other uses may depelete memory pools),
so this is going to be best-effort. With all that in mind, I struggle to
beleive that this is going to be worth the maintenance cost (e.g. with
any issues arising from uaccess, IO, etc).

Overall, I would prefer to not see this syscall in the kernel.

> Further still, it has this HAVE_SECRETMEM_UNCACHED nonsense which is
> completely unused. I'm not at all sure exposing UNCACHED to random
> userspace is a sane idea.

I agree the uncached stuff should be removed. It is at best misleading
since the kernel can't guarantee it does what it says, I think it's
liable to lead to issues in future (e.g. since it can cause memory
operations to raise different exceptions relative to what they can
today), and as above it seems like a solution looking for a problem.

Thanks,
Mark.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

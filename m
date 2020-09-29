Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E427CE77
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Sep 2020 15:07:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05ACD154330BF;
	Tue, 29 Sep 2020 06:07:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 36E07152CC040
	for <linux-nvdimm@lists.01.org>; Tue, 29 Sep 2020 06:07:44 -0700 (PDT)
Received: from kernel.org (unknown [87.71.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 3D11420848;
	Tue, 29 Sep 2020 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601384863;
	bh=UZ0iM96aIv5qmIGrHFQ3nNuGd8q14qoW3IN+2hfXGCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ff4cS6H09wsob6fG8dvSzyj1LvUQfBbkOpFxI0sSdU98FA9rPjkXt2iow0J8KbiXE
	 zb+Di1ti/4IJRmKz0SOIT14xl6TtZOwVL/UB+NG+rI/tt+P8xz5F0/dp4cG22+QEa+
	 PIvBVdUoENxn2sQrb9B2BEdjgzVtwRerxkMIPhoA=
Date: Tue, 29 Sep 2020 16:07:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200929130723.GH2142832@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <8435eff6-7fa9-d923-45e5-d8850e4c6d73@redhat.com>
 <20200925095029.GX2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200925095029.GX2628@hirez.programming.kicks-ass.net>
Message-ID-Hash: QPYUN44YLOPNI7UX3G3LVPTKNREW754P
X-Message-ID-Hash: QPYUN44YLOPNI7UX3G3LVPTKNREW754P
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linu
 x-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QPYUN44YLOPNI7UX3G3LVPTKNREW754P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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

It's close to XPFO in the sense it removes pages from the kernel page
table. But unlike XPFO memfd_secret() does not mean allowing access to
these pages in the kernel until they are freed by the user. And, unlike
XPFO, it does not require TLB flushing all over the place.

> Further still, it has this HAVE_SECRETMEM_UNCACHED nonsense which is
> completely unused. I'm not at all sure exposing UNCACHED to random
> userspace is a sane idea.

The uncached mappings were originally proposed as a mean "... to prevent
or considerably restrict speculation on such pages" [1] as a comment to
my initial proposal to use mmap(MAP_EXCLUSIVE).

I've added the ability to create uncached mappings into the fd-based
implementation of the exclusive mappings as it is indeed can reduce
availability of side channels and the implementation was quite straight
forward.

[1] https://lore.kernel.org/linux-mm/2236FBA76BA1254E88B949DDB74E612BA4EEC0CE@IRSMSX102.ger.corp.intel.com/

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

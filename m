Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7567627D0B3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Sep 2020 16:12:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A6AA314B8E430;
	Tue, 29 Sep 2020 07:12:46 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7AF2E14B8E42D
	for <linux-nvdimm@lists.01.org>; Tue, 29 Sep 2020 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uS4mSgZTkE8/yrp3bjIeofv5zSFueI/JPFpcZg97ITA=; b=Fet6JWpIHhg7C+L/9n6jl3qceR
	VVGXF/cZiowcX1njtqGv3BVchgxxt+6pfaX0K/uodq5lwCY0uql6owL+D3yGk3K+um/uu5HFMGNTz
	7GQ5JZFIrAz1xjMr6CkqtNIt5CbKpTU8W8M6fT/AN5hqCewA4nMHg/DVwPf+0Au1I8pjgJgN0wyim
	2Lm8otroeLSxIf8DDf05XIxzYfAnQajPM/6vNFT4lc1LYPhaFUjBKU3R697WR+vBRmU/2QzcP0Bye
	R7v9MBE42kpKHmluJKOu5uwD73LJzyd4frQSP7sWbi/6nijp3lKc2BqXIIPYz+X8Bf4UcF7dvbpYT
	sesw27Yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNGMf-0006Z5-8p; Tue, 29 Sep 2020 14:12:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E2C9303F45;
	Tue, 29 Sep 2020 16:12:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1F4DD2022B66B; Tue, 29 Sep 2020 16:12:16 +0200 (CEST)
Date: Tue, 29 Sep 2020 16:12:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200929141216.GO2628@hirez.programming.kicks-ass.net>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <20200929130529.GE2142832@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200929130529.GE2142832@kernel.org>
Message-ID-Hash: JKICNVEHC5FFBMVNYQXKJC6MMNOSG6QI
X-Message-ID-Hash: JKICNVEHC5FFBMVNYQXKJC6MMNOSG6QI
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linu
 x-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JKICNVEHC5FFBMVNYQXKJC6MMNOSG6QI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 29, 2020 at 04:05:29PM +0300, Mike Rapoport wrote:
> On Fri, Sep 25, 2020 at 09:41:25AM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 24, 2020 at 04:29:03PM +0300, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > Removing a PAGE_SIZE page from the direct map every time such page is
> > > allocated for a secret memory mapping will cause severe fragmentation of
> > > the direct map. This fragmentation can be reduced by using PMD-size pages
> > > as a pool for small pages for secret memory mappings.
> > > 
> > > Add a gen_pool per secretmem inode and lazily populate this pool with
> > > PMD-size pages.
> > 
> > What's the actual efficacy of this? Since the pmd is per inode, all I
> > need is a lot of inodes and we're in business to destroy the directmap,
> > no?
> > 
> > Afaict there's no privs needed to use this, all a process needs is to
> > stay below the mlock limit, so a 'fork-bomb' that maps a single secret
> > page will utterly destroy the direct map.
> 
> This indeed will cause 1G pages in the direct map to be split into 2M
> chunks, but I disagree with 'destroy' term here. Citing the cover letter
> of an earlier version of this series:

It will drop them down to 4k pages. Given enough inodes, and allocating
only a single sekrit page per pmd, we'll shatter the directmap into 4k.

>   I've tried to find some numbers that show the benefit of using larger
>   pages in the direct map, but I couldn't find anything so I've run a
>   couple of benchmarks from phoronix-test-suite on my laptop (i7-8650U
>   with 32G RAM).

Existing benchmarks suck at this, but FB had a load that had a
deterministic enough performance regression to bisect to a directmap
issue, fixed by:

  7af0145067bc ("x86/mm/cpa: Prevent large page split when ftrace flips RW on kernel text")

>   I've tested three variants: the default with 28G of the physical
>   memory covered with 1G pages, then I disabled 1G pages using
>   "nogbpages" in the kernel command line and at last I've forced the
>   entire direct map to use 4K pages using a simple patch to
>   arch/x86/mm/init.c.  I've made runs of the benchmarks with SSD and
>   tmpfs.
>   
>   Surprisingly, the results does not show huge advantage for large
>   pages. For instance, here the results for kernel build with
>   'make -j8', in seconds:

Your benchmark should stress the TLB of your uarch, such that additional
pressure added by the shattered directmap shows up.

And no, I don't have one either.

>                         |  1G    |  2M    |  4K
>   ----------------------+--------+--------+---------
>   ssd, mitigations=on	| 308.75 | 317.37 | 314.9
>   ssd, mitigations=off	| 305.25 | 295.32 | 304.92
>   ram, mitigations=on	| 301.58 | 322.49 | 306.54
>   ram, mitigations=off	| 299.32 | 288.44 | 310.65

These results lack error data, but assuming the reults are significant,
then this very much makes a case for 1G mappings. 5s on a kernel builds
is pretty good.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

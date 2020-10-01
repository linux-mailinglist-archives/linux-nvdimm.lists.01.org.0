Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7532F27FB2B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Oct 2020 10:14:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A4BAD1558FF7B;
	Thu,  1 Oct 2020 01:14:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA6B61558FF76
	for <linux-nvdimm@lists.01.org>; Thu,  1 Oct 2020 01:14:47 -0700 (PDT)
Received: from kernel.org (unknown [87.71.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4E72520BED;
	Thu,  1 Oct 2020 08:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601540087;
	bh=OQ5Rl7mvGEVxEAedAezsC2iYk6ORsvLvfeXsvmSGzK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k835WoUyIOxQs1vszUiMSjhhSn11jUXQ4TGNaslDPJ9EKG6CIPIx1unOuP857BqXd
	 F1ArPeyz1k6Gs5CuzXCCFTlGWQZkxC6BH30SPuw/qvNv/yezU2G1NGKT7Dtwd3B07I
	 0dXT3c8NBDcUtoxf2jYtr1TPrqgIIGcfASC6m31I=
Date: Thu, 1 Oct 2020 11:14:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20201001081430.GA3537283@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <20200929130529.GE2142832@kernel.org>
 <20200929141216.GO2628@hirez.programming.kicks-ass.net>
 <20200929145813.GA3226834@linux.ibm.com>
 <20200929151552.GS2628@hirez.programming.kicks-ass.net>
 <20200930102745.GC3226834@linux.ibm.com>
 <20200930150928.GR20115@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930150928.GR20115@casper.infradead.org>
Message-ID-Hash: K6ECMECMPCOR67PKHXJDR7BMGUW5JEJU
X-Message-ID-Hash: K6ECMECMPCOR67PKHXJDR7BMGUW5JEJU
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, lin
 ux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K6ECMECMPCOR67PKHXJDR7BMGUW5JEJU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 30, 2020 at 04:09:28PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 30, 2020 at 01:27:45PM +0300, Mike Rapoport wrote:
> > On Tue, Sep 29, 2020 at 05:15:52PM +0200, Peter Zijlstra wrote:
> > > On Tue, Sep 29, 2020 at 05:58:13PM +0300, Mike Rapoport wrote:
> > > > On Tue, Sep 29, 2020 at 04:12:16PM +0200, Peter Zijlstra wrote:
> > > 
> > > > > It will drop them down to 4k pages. Given enough inodes, and allocating
> > > > > only a single sekrit page per pmd, we'll shatter the directmap into 4k.
> > > > 
> > > > Why? Secretmem allocates PMD-size page per inode and uses it as a pool
> > > > of 4K pages for that inode. This way it ensures that
> > > > __kernel_map_pages() is always called on PMD boundaries.
> > > 
> > > Oh, you unmap the 2m page upfront? I read it like you did the unmap at
> > > the sekrit page alloc, not the pool alloc side of things.
> > > 
> > > Then yes, but then you're wasting gobs of memory. Basically you can pin
> > > 2M per inode while only accounting a single page.
> > 
> > Right, quite like THP :)
> 
> Huh?  THP accounts every page it allocates.  If you allocate 2MB,
> it accounts 512 pages.

I meant that secremem allocates 2M in advance like THP and not that it
similar because only page is accounted.
Anyway, the intention was to account the entrire 2M chunk (512 pages),
so I'll recheck the accounting and I'll fix it if I missed something.

> And THP are reclaimable by vmscan, this is obviously not.

True, this is more like mlock in that sense.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

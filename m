Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD72E26D35D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 08:02:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4851147AACA0;
	Wed, 16 Sep 2020 23:02:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4F46E147AAC86
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 23:02:17 -0700 (PDT)
Received: from kernel.org (unknown [87.71.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A0884208A9;
	Thu, 17 Sep 2020 06:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600322537;
	bh=CIn6WbP0PnrQ3swBmqoXOV/7IIFuke5wts27Oqfqgg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vux4kkpHuXcUr7JNEHn4Ta2uTVvfxtbJ9itAdl2PBkK6QyIeLEPF/IgXqabss0x27
	 PzEi/Ljvi7tKISYtA19lM11TCsz3Xb6kP/FhycSx/lQzYL5iW0K3kS8LlY4wG3QD8o
	 sB0DVP4rSIY6tB2sseLZOZLHziJ/3k7brwfFikrY=
Date: Thu, 17 Sep 2020 09:02:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200917060204.GO2142832@kernel.org>
References: <20200916073539.3552-1-rppt@kernel.org>
 <20200916162020.0d68c2bd6711024cfcaa8bd7@linux-foundation.org>
 <CAKgNAkiSRDoZWKkBLB03X_knOeoeKVTy2oLmMopZ5vK8UZSAPg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKgNAkiSRDoZWKkBLB03X_knOeoeKVTy2oLmMopZ5vK8UZSAPg@mail.gmail.com>
Message-ID-Hash: 7AHZD4QJ3S3T74NNIZRYAGF7SGW735ZM
X-Message-ID-Hash: 7AHZD4QJ3S3T74NNIZRYAGF7SGW735ZM
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-ker
 nel@lists.infradead.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7AHZD4QJ3S3T74NNIZRYAGF7SGW735ZM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 17, 2020 at 07:46:12AM +0200, Michael Kerrisk (man-pages) wrote:
> On Thu, 17 Sep 2020 at 01:20, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 16 Sep 2020 10:35:34 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> >
> > > This is an implementation of "secret" mappings backed by a file descriptor.
> > > I've dropped the boot time reservation patch for now as it is not strictly
> > > required for the basic usage and can be easily added later either with or
> > > without CMA.
> >
> > It seems early days for this, especially as regards reviewer buyin.
> > But I'll toss it in there to get it some additional testing.
> >
> > A test suite in tools/testging/selftests/ would be helpful, especially
> > for arch maintainers.
> >
> > I assume that user-facing manpage alterations are planned?

> I was just about to write a mail into this thread when I saw this :-).
> 
> So far, I don't think I saw a manual page patch. Mike, how about it?

It is planned :)

I have a draft, but I'm waiting for consensus about the uncached
mappings before sending it out.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

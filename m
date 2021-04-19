Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066143641A0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 14:25:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 625AE100ED4BB;
	Mon, 19 Apr 2021 05:25:17 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 53190100ED49E
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CpUXgyXNu2L6aDoABWkfEW3c8xEi9KV0vjBOP+ZePLk=; b=iQPnFaPBrCivR61heeMKYPHCvt
	pCkxUp9NhouUvSBFQbKd7Fhrz1AZsx3Q2HZw+IDT8EHnokduaSFYutUpfRsDIS9zau7bYybxvA1ff
	pFuhFl2IUQxSd7XRlYtlj+FFgppBw6LQsud2DK1DXCxjC27lUaR1zxXyZRCerN1ljbP11kgtjJLqD
	N3p32/8yEAIzdAsbm2eTCBPbMAghI+Qr4ApaAjdCTvfikAf7G0xc6BI0IOM72rhvFT7X+pD+yabkm
	HNtjrKvSh/m2oRc0ljDrhGv2UnUnfK5uxuGIjbM8MIST4BHLYve7TzvctYq/QernMV8JatSft25WL
	KBRcr6Lg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lYSua-00Diet-6d; Mon, 19 Apr 2021 12:22:16 +0000
Date: Mon, 19 Apr 2021 13:21:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
Message-ID: <20210419122156.GZ2531743@casper.infradead.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <20210419112302.GX2531743@casper.infradead.org>
 <YH1v4XVzfXC1dYND@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YH1v4XVzfXC1dYND@kernel.org>
Message-ID-Hash: K7DWUPWZI6Q3FUKSWGU676ICS66HBFOA
X-Message-ID-Hash: K7DWUPWZI6Q3FUKSWGU676ICS66HBFOA
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, S
 huah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K7DWUPWZI6Q3FUKSWGU676ICS66HBFOA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 19, 2021 at 02:56:17PM +0300, Mike Rapoport wrote:
> On Mon, Apr 19, 2021 at 12:23:02PM +0100, Matthew Wilcox wrote:
> > So you're calling page_is_secretmem() on a struct page without having
> > a refcount on it.  That is definitely not allowed.  secretmem seems to
> > be full of these kinds of races; I know this isn't the first one I've
> > seen in it.  I don't think this patchset is ready for this merge window.
> 
> There were races in the older version that did caching of large pages and
> those were fixed then, but this is anyway irrelevant because all that code
> was dropped in the latest respins.
> 
> I don't think that the fix of the race in gup_pte_range is that significant
> to wait 3 more months because of it.

I have no particular interest in secretmem, but it seems that every time
I come across it while looking at something else, I see these kinds of
major mistakes in it.  That says to me it's not ready and hasn't seen
enough review.

> > With that fixed, you'll have a head page that you can use for testing,
> > which means you don't need to test PageCompound() (because you know the
> > page isn't PageTail), you can just test PageHead().
> 
> I can't say I follow you here. page_is_secretmem() is intended to be a
> generic test, so I don't see how it will get PageHead() if it is called
> from other places.

static inline bool head_is_secretmem(struct page *head)
{
	if (PageHead(head))
		return false;
	...
}

static inline bool page_is_secretmem(struct page *page)
{
	if (PageTail(page))
		return false;
	return head_is_secretmem(page);
}

(yes, calling it head is a misnomer, because it's not necessarily a head,
it might be a base page, but until we have a name for pages which might
be a head page or a base page, it'll have to do ...)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

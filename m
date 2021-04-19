Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F853640D6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 13:48:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 39BFA100EC1D4;
	Mon, 19 Apr 2021 04:48:06 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A686F100EF264
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bwPuhmLV9iDdbBtA80aP2NeOoPck37vPl2v0l8S8dJw=; b=ZKgd+wiWxB4OjJM0AIDMQSKXxR
	mK2R/z3oqKh1PUQkJXhvcIcCeNtKgp8OXUyGgAszjnbvM4jRpHJ8CjWbc7hBN1U6HbdDGK+UorYOc
	MFcMKMdSOPfBZbD7GWLjHFe+LP+3z+b1cJWnPckDm478VhnIuObWzbqtK9sHaZ8jwmo1+eWrdBGQa
	v1kBE40Vi4xvSvLhZ0bnDkcLGvuPRT/cK5/47tFYec+ZGcwN2cVCQO61pGGxpuB3lYinJPup2TnB4
	GZ/ajfYkgk2Tj5Ry8+D2ggrOGM4MLh5XgrDlBR0M9Vx/aMmMy+8h8RgjgqInD8p/8jeX+er7cc13j
	MOHIVxrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lYSJB-00Dg11-HM; Mon, 19 Apr 2021 11:43:29 +0000
Date: Mon, 19 Apr 2021 12:43:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
Message-ID: <20210419114317.GY2531743@casper.infradead.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
 <YH1PE4oWeicpJT9g@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YH1PE4oWeicpJT9g@kernel.org>
Message-ID-Hash: 7RES3Q2EGLX5YMZXZYLMALMCTO74UR4F
X-Message-ID-Hash: 7RES3Q2EGLX5YMZXZYLMALMCTO74UR4F
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, S
 huah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7RES3Q2EGLX5YMZXZYLMALMCTO74UR4F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 19, 2021 at 12:36:19PM +0300, Mike Rapoport wrote:
> Well, most if the -4.2% of the performance regression kbuild reported were
> due to repeated compount_head(page) in page_mapping(). So the whole point
> of this patch is to avoid calling page_mapping().

It's quite ludicrous how many times we call compound_head() in
page_mapping() today:

 page = compound_head(page);
 if (__builtin_expect(!!(PageSlab(page)), 0))
 if (__builtin_expect(!!(PageSwapCache(page)), 0)) {

TESTPAGEFLAG(Slab, slab, PF_NO_TAIL) expands to:

static __always_inline int PageSlab(struct page *page)
{
	PF_POISONED_CHECK(compound_head(page));
	return test_bit(PG_slab, &compound_head(page));
}

static __always_inline int PageSwapCache(struct page *page)
{
        page = compound_head(page);
        return PageSwapBacked(page) && test_bit(PG_swapcache, &page->flags);
}

but then!

TESTPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL) also expands like Slab does.

So that's six calls to compound_head(), depending what Kconfig options
you have enabled.

And folio_mapping() is one of the functions I add in the first batch of
patches, so review, etc will be helpful.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

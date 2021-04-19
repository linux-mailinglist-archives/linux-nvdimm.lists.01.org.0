Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C416636411A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 13:56:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08652100EC1DA;
	Mon, 19 Apr 2021 04:56:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E1DF3100EC1D4
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 04:56:38 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03A2761221;
	Mon, 19 Apr 2021 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1618833395;
	bh=6A/ev0xWFu6QEr1qRdJmTLcg7g1Q5yOrYX9lSKkBwrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxO9956IYPxD7CWbXB3fSSCXGQTBGoPbq8d0e6mudSqUOOR9D/a/frTDdxrhpXp3T
	 u3HOTCCCGMxCE/5oFsDEE7CL7oJo0UiFyE8XATL/PtjV1UyIMF3EyMmtXChnpmANf3
	 xvGP/jZELsbTCSFAeN0de19xcjENeBafkHrYYT3aIAMpwGMCplJXdJyijY7bDsnsxV
	 /MOKSwyo2LLpN1+M7yhhDDA1uJNr6IoUGDX83ZilzKhM+0TcMHp8KZpuLjiLSDsEjb
	 4PrIm8F9iUjdT44aR4dOTbKzDBo3Crs7XfVqwdx02xV+XZiDVN4SXOnKlpH/im2nqn
	 6aIPJA3ZtmO0Q==
Date: Mon, 19 Apr 2021 14:56:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
Message-ID: <YH1v4XVzfXC1dYND@kernel.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <20210419112302.GX2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210419112302.GX2531743@casper.infradead.org>
Message-ID-Hash: XFRWBURVQMTMAR2MDRHZCY6DG7JRNAEV
X-Message-ID-Hash: XFRWBURVQMTMAR2MDRHZCY6DG7JRNAEV
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, S
 huah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XFRWBURVQMTMAR2MDRHZCY6DG7JRNAEV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 19, 2021 at 12:23:02PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 19, 2021 at 11:42:18AM +0300, Mike Rapoport wrote:
> > The perf profile of the test indicated that the regression is caused by
> > page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_range):
> 
> Uhh ... you're calling it in the wrong place!
> 
>                 VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>                 page = pte_page(pte);
> 
>                 if (page_is_secretmem(page))
>                         goto pte_unmap;
> 
>                 head = try_grab_compound_head(page, 1, flags);
>                 if (!head)
>                         goto pte_unmap;
> 
> So you're calling page_is_secretmem() on a struct page without having
> a refcount on it.  That is definitely not allowed.  secretmem seems to
> be full of these kinds of races; I know this isn't the first one I've
> seen in it.  I don't think this patchset is ready for this merge window.

There were races in the older version that did caching of large pages and
those were fixed then, but this is anyway irrelevant because all that code
was dropped in the latest respins.

I don't think that the fix of the race in gup_pte_range is that significant
to wait 3 more months because of it.
 
> With that fixed, you'll have a head page that you can use for testing,
> which means you don't need to test PageCompound() (because you know the
> page isn't PageTail), you can just test PageHead().

I can't say I follow you here. page_is_secretmem() is intended to be a
generic test, so I don't see how it will get PageHead() if it is called
from other places.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

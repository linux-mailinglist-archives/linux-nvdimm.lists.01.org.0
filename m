Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9373649C7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 20:25:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E99F2100EB83B;
	Mon, 19 Apr 2021 11:24:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C2E42100EB827
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 11:24:55 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E6B9611EE;
	Mon, 19 Apr 2021 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1618856690;
	bh=YxOWGUrr9Arsoda9fsVSCB7Wv4rVHn47U+RWA4JnEik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eqgm4LWDn1T4KMIdCqYE+gjNg+SANj+00vJAZ20BOHkbCOUFadrvAoCiSfOO0vRry
	 cRCtQoRNQsNXz5MFoOsMVaaP5Gd9/+08n7XDGr80HYzIgK9xevo+a/Sm9FXoJXZjTk
	 HaSQiBdLsidEyOo5u5kxW/yk+MUsmi2kU2J8JYlAQ+COKbIhejTh20dmKGVs5wB+PQ
	 r8kxDIacMWEYzyfTRPMIDb6vu58wBn7mPmvUnoXAazvSjaTq6lhypXTWnItI4BvjoA
	 TnqdMG0PIIF9yA1redNzhKMCU4jKQXwnIlYMZ9uunZfCkBYwZUzqLYKrPmPwfNOjpf
	 8Nh3U2mR23q7w==
Date: Mon, 19 Apr 2021 21:24:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
Message-ID: <YH3K3sBFbNFOxTV+@kernel.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <20210419112302.GX2531743@casper.infradead.org>
 <YH1v4XVzfXC1dYND@kernel.org>
 <20210419122156.GZ2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210419122156.GZ2531743@casper.infradead.org>
Message-ID-Hash: UANCMSBWYJMRTT6FQX7SVSVHBXCNNXGI
X-Message-ID-Hash: UANCMSBWYJMRTT6FQX7SVSVHBXCNNXGI
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, S
 huah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UANCMSBWYJMRTT6FQX7SVSVHBXCNNXGI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 19, 2021 at 01:21:56PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 19, 2021 at 02:56:17PM +0300, Mike Rapoport wrote:
> 
> > > With that fixed, you'll have a head page that you can use for testing,
> > > which means you don't need to test PageCompound() (because you know the
> > > page isn't PageTail), you can just test PageHead().
> > 
> > I can't say I follow you here. page_is_secretmem() is intended to be a
> > generic test, so I don't see how it will get PageHead() if it is called
> > from other places.
> 
> static inline bool head_is_secretmem(struct page *head)
> {
> 	if (PageHead(head))
> 		return false;
> 	...
> }
> 
> static inline bool page_is_secretmem(struct page *page)
> {
> 	if (PageTail(page))
> 		return false;
> 	return head_is_secretmem(page);
> }
> 
> (yes, calling it head is a misnomer, because it's not necessarily a head,
> it might be a base page, but until we have a name for pages which might
> be a head page or a base page, it'll have to do ...)

To me this looks less clean and readable and in the end we have an extra
check for PG_Head if that won't get optimized away.

Does not seem to me there would be a measurable difference, but if this is
important for future conversion to folio I don't mind using
{head,page}_is_secretmem.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

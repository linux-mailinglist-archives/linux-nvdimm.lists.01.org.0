Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6575C302E07
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 Jan 2021 22:38:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6283100EBBCE;
	Mon, 25 Jan 2021 13:38:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 60BE6100EBBCD
	for <linux-nvdimm@lists.01.org>; Mon, 25 Jan 2021 13:38:34 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A683E2083E;
	Mon, 25 Jan 2021 21:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1611610714;
	bh=oBbSa76JFc7v8+y55SX0g1Mr9sPSRsNOv4tmWq7xrRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubeXULCeE5ESYXoKbbpQZvbpm7KD3rJtLMZd3bLMpG+Yf8ZlUgaes9e13MakOokA9
	 iEgnWl6tWG8fgiW+VJGsU1Vz4qkDtXaocuKZT5gFf6r99ZgN3QhYKOTmMnfoGOogzo
	 zlSt15bli+VWxniwjlxtECCstKhhIQyCjc9aSnUV55QlpbsGcamdfknFZPmcXMuxob
	 G02UJe9Qaa5X7Qu+hPXzpNUvjCDYeTaIEq+run7rkZRwSUoqDGVquo06czJpfyCKh6
	 lYHTox8ewX/SByv9aTWjggJVW9TsgcM9496MPOix7WOWD0WDa1bKzdlfYuPxgdGr6W
	 86DtTT5jWaIDg==
Date: Mon, 25 Jan 2021 23:38:17 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
Message-ID: <20210125213817.GM6332@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-9-rppt@kernel.org>
 <20210125165451.GT827@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210125165451.GT827@dhcp22.suse.cz>
Message-ID-Hash: VONGQZ7UYDZUAQDRFK6OCJYGJRUOSBGL
X-Message-ID-Hash: VONGQZ7UYDZUAQDRFK6OCJYGJRUOSBGL
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VONGQZ7UYDZUAQDRFK6OCJYGJRUOSBGL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 25, 2021 at 05:54:51PM +0100, Michal Hocko wrote:
> On Thu 21-01-21 14:27:20, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Account memory consumed by secretmem to memcg. The accounting is updated
> > when the memory is actually allocated and freed.
> 
> What does this mean?

That means that the accounting is updated when secretmem does cma_alloc()
and cma_relase().

> What are the lifetime rules?

Hmm, what do you mean by lifetime rules?

> [...]
> 
> > +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> > +{
> > +	int err;
> > +
> > +	err = memcg_kmem_charge_page(page, gfp, order);
> > +	if (err)
> > +		return err;
> > +
> > +	/*
> > +	 * seceremem caches are unreclaimable kernel allocations, so treat
> > +	 * them as unreclaimable slab memory for VM statistics purposes
> > +	 */
> > +	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> > +			      PAGE_SIZE << order);
> 
> A lot of memcg accounted memory is not reclaimable. Why do you abuse
> SLAB counter when this is not a slab owned memory? Why do you use the
> kmem accounting API when __GFP_ACCOUNT should give you the same without
> this details?

I cannot use __GFP_ACCOUNT because cma_alloc() does not use gfp.
Besides, kmem accounting with __GFP_ACCOUNT does not seem
to update stats and there was an explicit request for statistics:
 
https://lore.kernel.org/lkml/CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com/

As for (ab)using NR_SLAB_UNRECLAIMABLE_B, as it was already discussed here:

https://lore.kernel.org/lkml/20201129172625.GD557259@kernel.org/

I think that a dedicated stats counter would be too much at the moment and
NR_SLAB_UNRECLAIMABLE_B is the only explicit stat for unreclaimable memory.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

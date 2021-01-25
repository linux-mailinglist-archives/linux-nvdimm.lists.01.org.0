Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11637302DEC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 Jan 2021 22:35:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A92A100EC1E9;
	Mon, 25 Jan 2021 13:35:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8CDCC100EC1DF
	for <linux-nvdimm@lists.01.org>; Mon, 25 Jan 2021 13:35:43 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F8A2229C6;
	Mon, 25 Jan 2021 21:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1611610543;
	bh=2Di0IbIXl1xn2Q918lq0pHS35BBSv9IAQLWTpnF3034=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cy17SSKvvNvxfTqzme3GulWvb12hmNhkF7DBhyy2a+M5IaoGf8exm+dMOhwdI3cnD
	 O9Y6le+GeozBAOlFWKkpEB+vZ71maF7XrODlor4nn34mqAaY2SmcJJTy1/7R4Vzp0U
	 bPshjl150D1+6AqGJJwRZluiwgpDdWOErZGjlhYbAQhuHLMYpqQxkt2okbl3QmaaEV
	 +AvTUTAKQGnim5uoCQhk9nL/vcRX66pRqMexDaS2sIjDuNGgW078c+2BX0w5Eu0hmE
	 oc6a5eiysTeaoVlQWOTzqTt5FOVdCY/F5kyVzE2NWYn7vW0p6El384BwmC/nQzLCGf
	 IjSwSAhpZJ+aA==
Date: Mon, 25 Jan 2021 23:35:26 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
Message-ID: <20210125213526.GK6332@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-9-rppt@kernel.org>
 <20210125161706.GE308988@casper.infradead.org>
 <CALvZod7rn_5oXT6Z+iRCeMX_iMRO9G_8FnwSRGpJJwyBz5Wpnw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALvZod7rn_5oXT6Z+iRCeMX_iMRO9G_8FnwSRGpJJwyBz5Wpnw@mail.gmail.com>
Message-ID-Hash: RYVIXM3BQINUYMQFIJ32YG75AS22GLO7
X-Message-ID-Hash: RYVIXM3BQINUYMQFIJ32YG75AS22GLO7
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deac
 on <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RYVIXM3BQINUYMQFIJ32YG75AS22GLO7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 25, 2021 at 09:18:04AM -0800, Shakeel Butt wrote:
> On Mon, Jan 25, 2021 at 8:20 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Jan 21, 2021 at 02:27:20PM +0200, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > Account memory consumed by secretmem to memcg. The accounting is updated
> > > when the memory is actually allocated and freed.

I though about doing per-page accounting, but then one would be able to
create a lot of secretmem file descriptors, use only a page from each while
actual memory consumption will be way higher.

> > I think this is wrong.  It fails to account subsequent allocators from
> > the same PMD.  If you want to track like this, you need separate pools
> > per memcg.
> >
> 
> Are these secretmem pools shared between different jobs/memcgs?

A secretmem pool is per anonymous file descriptor and this file descriptor
can be shared only explicitly between several processes. So, the secretmem
pool should not be shared between different jobs/memcg. Of course, it's
possible to spread threads of a process across different memcgs, but in
that case the accounting will be similar to what's happening today with
sl*b. The first thread to cause kmalloc() will be charged for the
allocation of the entire slab and subsequent allocations from that slab
will not be accounted.

That said, having a pool per memcg will add ton of complexity with very
dubious value.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

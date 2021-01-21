Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FE22FDDBC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 01:15:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 58A41100EB339;
	Wed, 20 Jan 2021 16:15:20 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 014B4100EBBBE
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 16:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cwu2zXGrhPIC6ERSbgMr9vODEIjubNUIY3egpnasEkM=; b=Titc2oh6mm6H8HrBnURdMCnuAy
	B7tmu7WO5lk/dTol8pnvJFj1ALNIg2a0ayyvvXkEw9Hp66wKGgQ/BlGHZARXS97TlLGZY8EiZPMmA
	ut30VcvnrKuPicxn8sbUQh1rQkfX6UOTVdhCPtU2awociCaRbIMPQ6MoLPRkjOOtwQ9FsIa0xGjnZ
	/CSZq9i88CQi3WQl2rKH0j35vKzcRO3qR1A3h4r5WrMR6t4JOLRaCJ41q5mPTRUZf67Q1bFGxlKNx
	5TkXSuCjJgxzJqjcJLYOACHaEtsrrVT7zqfOOOSI8cncXQ7oKbdLlZuACe9kpbaLDbLfrC+jRu/zm
	xaT3mp2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l2Nah-00GNk2-9O; Thu, 21 Jan 2021 00:12:57 +0000
Date: Thu, 21 Jan 2021 00:12:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v15 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20210121001247.GN2260413@casper.infradead.org>
References: <20210120180612.1058-1-rppt@kernel.org>
 <20210120180612.1058-8-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210120180612.1058-8-rppt@kernel.org>
Message-ID-Hash: FGTGKQOD44ONVSZLSAOCADMBKIVRC7K3
X-Message-ID-Hash: FGTGKQOD44ONVSZLSAOCADMBKIVRC7K3
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon
  <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FGTGKQOD44ONVSZLSAOCADMBKIVRC7K3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 20, 2021 at 08:06:08PM +0200, Mike Rapoport wrote:
> +static int secretmem_pool_increase(struct secretmem_ctx *ctx, gfp_t gfp)
>  {
> +	unsigned long nr_pages = (1 << PMD_PAGE_ORDER);
> +	struct gen_pool *pool = ctx->pool;
> +	unsigned long addr;
> +	struct page *page;
> +	int err;
> +
> +	page = cma_alloc(secretmem_cma, nr_pages, PMD_SIZE, gfp & __GFP_NOWARN);
> +	if (!page)
> +		return -ENOMEM;

Does cma_alloc() zero the pages it allocates?  If not, where do we avoid
leaking kernel memory to userspace?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

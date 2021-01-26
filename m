Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41B304109
	for <lists+linux-nvdimm@lfdr.de>; Tue, 26 Jan 2021 15:56:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2215100EB83A;
	Tue, 26 Jan 2021 06:56:38 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6FE5E100EB839
	for <linux-nvdimm@lists.01.org>; Tue, 26 Jan 2021 06:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AfVmvy0+ars8vSXgUaa4Ou66AyTq8tua1GFfd4k4JEw=; b=nAP0nDbV1kwONwbXFxyftiqDWQ
	jHiVYK1NDKnF8QM69l3dG2FMsAL3iwGEI4VIpsVWD8NwGnDS/qwfGpm/s7IvdCmdZxN6z0NBOUOMX
	YsXcAxL04Ph78LoBwNMMvjI8JoSKao4Y2A92kUpREHLGb8TP6wqGFn4Z5Qa6E4pplksDWHdn/YL/T
	u1awwBPfVKq2MKlAnFFBbUPwFq/kxETbl3BSIto9xDeIvrQZNrjdM6PseQVL1Nu+JuoDOKC4BRjze
	R1vY4iXhTAIC177ONzK6Rj9jUVuhpyOkmi7Bw4tq7Ewm0jKEb9qOFULDXkvUQhNufow0/F7nS9cKe
	A0rXnu7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l4Pe2-005lWp-2r; Tue, 26 Jan 2021 14:48:57 +0000
Date: Tue, 26 Jan 2021 14:48:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
Message-ID: <20210126144838.GL308988@casper.infradead.org>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-9-rppt@kernel.org>
 <20210125165451.GT827@dhcp22.suse.cz>
 <20210125213817.GM6332@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210125213817.GM6332@kernel.org>
Message-ID-Hash: R6YLAXEHZ75JQH2OIMI2EIHHZLP5SQFC
X-Message-ID-Hash: R6YLAXEHZ75JQH2OIMI2EIHHZLP5SQFC
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Anders
 en <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R6YLAXEHZ75JQH2OIMI2EIHHZLP5SQFC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 25, 2021 at 11:38:17PM +0200, Mike Rapoport wrote:
> I cannot use __GFP_ACCOUNT because cma_alloc() does not use gfp.
> Besides, kmem accounting with __GFP_ACCOUNT does not seem
> to update stats and there was an explicit request for statistics:
>  
> https://lore.kernel.org/lkml/CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com/
> 
> As for (ab)using NR_SLAB_UNRECLAIMABLE_B, as it was already discussed here:
> 
> https://lore.kernel.org/lkml/20201129172625.GD557259@kernel.org/
> 
> I think that a dedicated stats counter would be too much at the moment and
> NR_SLAB_UNRECLAIMABLE_B is the only explicit stat for unreclaimable memory.

That's not true -- Mlocked is also unreclaimable.  And doesn't this
feel more like mlocked memory than unreclaimable slab?  It's also
Unevictable, so could be counted there instead.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

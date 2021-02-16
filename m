Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F331CE69
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Feb 2021 17:51:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56A2B100EB349;
	Tue, 16 Feb 2021 08:51:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 59254100EB347
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 08:51:37 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1613494295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fv1cqvwsI0OzZQzjo9Fzqiw9J9sAKYM15trtTiADU8I=;
	b=m+7A3yBnlzXwcSFUtKDR2Y9JcLQQ7GBKZLbjSDY4uRJe8Oprcc1t3A0Yb4nCpmSjJzTq71
	m2lvwh4POgKc94rijkZTo8EsctDQ8udo5YFmIVVBqcDZmQE+zdGsrWJMYIvr1Q40Hpav5m
	AI5AIoiWGkF74EgEjx/NO759Sl7hNIs=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 93467AE05;
	Tue, 16 Feb 2021 16:51:35 +0000 (UTC)
Date: Tue, 16 Feb 2021 17:51:34 +0100
From: Michal Hocko <mhocko@suse.com>
To: James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCv4FhseXJ8cZ62/@dhcp22.suse.cz>
References: <20210214091954.GM242749@kernel.org>
 <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
 <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
 <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
 <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
 <YCrJjYmr7A2nO6lA@dhcp22.suse.cz>
 <12c3890b233c8ec8e3967352001a7b72a8e0bfd0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12c3890b233c8ec8e3967352001a7b72a8e0bfd0.camel@linux.ibm.com>
Message-ID-Hash: QBOA7CFUUVLQ65PJJPM5YGZSDM2UCGZ3
X-Message-ID-Hash: QBOA7CFUUVLQ65PJJPM5YGZSDM2UCGZ3
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QBOA7CFUUVLQ65PJJPM5YGZSDM2UCGZ3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 16-02-21 08:25:39, James Bottomley wrote:
> On Mon, 2021-02-15 at 20:20 +0100, Michal Hocko wrote:
> [...]
> > > >   What kind of flags are we talking about and why would that be a
> > > > problem with memfd_create interface? Could you be more specific
> > > > please?
> > > 
> > > You mean what were the ioctl flags in the patch series linked
> > > above? They were SECRETMEM_EXCLUSIVE and SECRETMEM_UNCACHED in
> > > patch 3/5. 
> > 
> > OK I see. How many potential modes are we talking about? A few or
> > potentially many?
>  
> Well I initially thought there were two (uncached or not) until you
> came up with the migratable or non-migratable, which affects the
> security properties.  But now there's also potential for hardware
> backing, like mktme,  described by flags as well.

I do not remember details about mktme but from what I still recall it
had keys associated with direct maps. Is the key management something
that fits into flags management?

> I suppose you could
> also use RDT to restrict which cache the data goes into: say L1 but not
> L2 on to lessen the impact of fully uncached (although the big thrust
> of uncached was to blunt hyperthread side channels).  So there is
> potential for quite a large expansion even though I'd be willing to bet
> that a lot of the modes people have thought about turn out not to be
> very effective in the field.

Are those very HW specific features really viable through a generic
syscall? Don't get me wrong but I find it much more likely somebody will
want a hugetlb (pretty HW independent) without a direct map than a very
close to the HW caching mode soon.

But thanks for the clarification anyway.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

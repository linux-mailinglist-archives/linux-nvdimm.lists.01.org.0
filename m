Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25092319B94
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Feb 2021 10:02:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5DA7100EBBD1;
	Fri, 12 Feb 2021 01:02:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F180B100EC1E4
	for <linux-nvdimm@lists.01.org>; Fri, 12 Feb 2021 01:02:22 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1613120541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fuLAmxR9iwO43/C3LbcJHqR7LRiBnZEE0LsKt1rN5RA=;
	b=maIJbN5v88UD3goki+HrDViBKPQKMVtsrMuVzNcWnDhTSddOOLE9kT0LL00VEyFKn1w2wu
	hBoG4RHY3X+r3uWP/goD/p/Dg7u5wWxfs7ea54Ma6J6j7ggOCIfWOJ3R2fAi1nMYOg65X0
	v0fJhu0jSZq0pBodruezPHImvLU92w8=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 0E22FB176;
	Fri, 12 Feb 2021 09:02:21 +0000 (UTC)
Date: Fri, 12 Feb 2021 10:02:18 +0100
From: Michal Hocko <mhocko@suse.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCZEGuLK94szKZDf@dhcp22.suse.cz>
References: <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
 <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <20210211112008.GH242749@kernel.org>
 <YCUjck0I8qgjB24i@dhcp22.suse.cz>
 <20210211225929.GK242749@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210211225929.GK242749@kernel.org>
Message-ID-Hash: 46TXRRD4OS6QPKJDSV6AZMTM5UQVRM4X
X-Message-ID-Hash: 46TXRRD4OS6QPKJDSV6AZMTM5UQVRM4X
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/46TXRRD4OS6QPKJDSV6AZMTM5UQVRM4X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri 12-02-21 00:59:29, Mike Rapoport wrote:
> On Thu, Feb 11, 2021 at 01:30:42PM +0100, Michal Hocko wrote:
[...]
> > Have a look how hugetlb proliferates through our MM APIs. I strongly
> > suspect this is strong signal that this won't be any different.
> > 
> > > And even if yes, adding SECRETMEM_HUGE
> > > flag seems to me less confusing than saying "from kernel x.y you can use
> > > MFD_CREATE | MFD_SECRET | MFD_HUGE" etc for all possible combinations.
> > 
> > I really fail to see your point. This is a standard model we have. It is
> > quite natural that flags are added. Moreover adding a new syscall will
> > not make it any less of a problem.
> 
> Nowadays adding a new syscall is not as costly as it used to be. And I
> think it'll provide better extensibility when new features would be added
> to secretmem. 
> 
> For instance, for creating a secretmem fd backed with sealing we'd have
> 
> 	memfd_secretm(SECRETMEM_HUGE);

You mean SECRETMEM_HUGE_1G_AND_SEALED or SECRET_HUGE_2MB_WITHOUT_SEALED?
This would be rather an antipatern to our flags design, no? Really there
are orthogonal requirements here and there is absolutely zero reason
to smash everything into a single thing. It is just perfectly fine to
combine those functionalities without a pre-described way how to do
that.

> rather than
> 
> 	memfd_create(MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_SECRET);
> 
> 
> Besides, if we overload memfd_secret we add complexity to flags validation
> of allowable flag combinations even with the simplest initial
> implementation.

This is the least of my worry, really. The existing code in
memfd_create, unlike others legacy interfaces, allows extensions just
fine.

> And what it will become when more features are added to secretmem?

Example?

> > > > I by no means do not insist one way or the other but from what I have
> > > > seen so far I have a feeling that the interface hasn't been thought
> > > > through enough.
> > > 
> > > It has been, but we have different thoughts about it ;-)
> > 
> > Then you must be carrying a lot of implicit knowledge which I want you
> > to document.
> 
> I don't have any implicit knowledge, we just have a different perspective.

OK, I will stop discussing now because it doesn't really seem to lead
anywhere.

Just to recap my current understanding. Your main argument so far is
that this is somehow special and you believe it would be confusing
to use an existing interface. I beg to disagree here because memfd
interface is exactly a way to get a file handle to describe a memory
which is what you want. About the only thing that secretmem is special
is that it only operates on mapped areas and read/write interface is
not supported (but I do not see a fundamental reason this couldn't be
added in the future). All the rest is just operating on a memory backed
file. I envison the hugetlb support will follow and sealing sounds like
a useful thing to be requested as well.  All that would have to be
added to a new syscall over time and then we will land at two parallel
interface supporting a largerly overlapping feature set.

To me all the above sounds to be much stronher argument than your worry
this might be confusing.

I will not insist on this but you should have some more thought on those
arguments.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4424F318945
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 12:20:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B76D100EA939;
	Thu, 11 Feb 2021 03:20:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 76EC2100EA938
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 03:20:28 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14FAC64DCF;
	Thu, 11 Feb 2021 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1613042428;
	bh=rXRK0H6A/K2Wb0tbxmc7ZILxeVB76yptr2cmsMFQE74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3VWHvs0bXUxcCXOc97N7vSXyLqVUcEV92kaL6OdVxecAKxAQ7ns6LLG+vegpOVde
	 U9dBh6sezDjn5D92Ll5noX1Vr+yCYEIk5R0rIUlhKrjSS7aOZ0i+PaR/+DQIweUHh6
	 8FzOzWyaxJsUOVv2GFc6tXB0iA4Kh3UCZBlISlSmmeVmiew2dh6clqSD3WkV3s59X7
	 15MQmJD2s7JLI/6iNb4Cojk2vx4RU0Y7gohP8KiCudLNjAvDZFFfG0p33iCbt4dNcP
	 wEYFcHPp1StbE/lV4MGjTaz8WVMajl7z6z/1pA+KZbglGlxEBvUgFNkTEZP1OvrqS8
	 dLaGA+Ls37rug==
Date: Thu, 11 Feb 2021 13:20:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210211112008.GH242749@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
 <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
Message-ID-Hash: C7IAPF7YC6TEXBI4Y3XWFM4ELU4OJ6DJ
X-Message-ID-Hash: C7IAPF7YC6TEXBI4Y3XWFM4ELU4OJ6DJ
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C7IAPF7YC6TEXBI4Y3XWFM4ELU4OJ6DJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 11, 2021 at 09:39:38AM +0100, Michal Hocko wrote:
> On Thu 11-02-21 09:13:19, Mike Rapoport wrote:
> > On Tue, Feb 09, 2021 at 02:17:11PM +0100, Michal Hocko wrote:
> > > On Tue 09-02-21 11:09:38, Mike Rapoport wrote:
> [...]
> > > > Citing my older email:
> > > > 
> > > >     I've hesitated whether to continue to use new flags to memfd_create() or to
> > > >     add a new system call and I've decided to use a new system call after I've
> > > >     started to look into man pages update. There would have been two completely
> > > >     independent descriptions and I think it would have been very confusing.
> > > 
> > > Could you elaborate? Unmapping from the kernel address space can work
> > > both for sealed or hugetlb memfds, no? Those features are completely
> > > orthogonal AFAICS. With a dedicated syscall you will need to introduce
> > > this functionality on top if that is required. Have you considered that?
> > > I mean hugetlb pages are used to back guest memory very often. Is this
> > > something that will be a secret memory usecase?
> > > 
> > > Please be really specific when giving arguments to back a new syscall
> > > decision.
> > 
> > Isn't "syscalls have completely independent description" specific enough?
> 
> No, it's not as you can see from questions I've had above. More on that
> below.
> 
> > We are talking about API here, not the implementation details whether
> > secretmem supports large pages or not.
> > 
> > The purpose of memfd_create() is to create a file-like access to memory.
> > The purpose of memfd_secret() is to create a way to access memory hidden
> > from the kernel.
> > 
> > I don't think overloading memfd_create() with the secretmem flags because
> > they happen to return a file descriptor will be better for users, but
> > rather will be more confusing.
> 
> This is quite a subjective conclusion. I could very well argue that it
> would be much better to have a single syscall to get a fd backed memory
> with spedific requirements (sealing, unmapping from the kernel address
> space). 

> Neither of us would be clearly right or wrong.

100% agree :)

> A more important point is a future extensibility and usability, though.
> So let's just think of few usecases I have outlined above. Is it
> unrealistic to expect that secret memory should be sealable? What about
> hugetlb? Because if the answer is no then a new API is a clear win as the
> combination of flags would never work and then we would just suffer from
> the syscall multiplexing without much gain. On the other hand if
> combination of the functionality is to be expected then you will have to
> jam it into memfd_create and copy the interface likely causing more
> confusion. See what I mean?

I see your point, but I think that overloading memfd_create definitely gets
us into syscall multiplexing from day one and support for seals and huge
pages in the secretmem will not make it less of a multiplexer.

Sealing is anyway controlled via fcntl() and I don't think
MFD_ALLOW_SEALING makes much sense for the secretmem because it is there to
prevent rogue file sealing in tmpfs/hugetlbfs.

As for the huge pages, I'm not sure at all that supporting huge pages in
secretmem will involve hugetlbfs. And even if yes, adding SECRETMEM_HUGE
flag seems to me less confusing than saying "from kernel x.y you can use
MFD_CREATE | MFD_SECRET | MFD_HUGE" etc for all possible combinations.
 
> I by no means do not insist one way or the other but from what I have
> seen so far I have a feeling that the interface hasn't been thought
> through enough.

It has been, but we have different thoughts about it ;-)

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

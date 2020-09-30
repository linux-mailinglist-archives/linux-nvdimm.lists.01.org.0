Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64F27E6BC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 12:35:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D3DF154AC99C;
	Wed, 30 Sep 2020 03:35:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A92A61545C4B8
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 03:35:25 -0700 (PDT)
Received: from kernel.org (unknown [87.71.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7F6D62071E;
	Wed, 30 Sep 2020 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601462125;
	bh=SzkDe746rX0ODWGVw7fDdaVyUZrEV+gM3E8swkXbMbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKhmviR7RakW6A11UWNT5ZnPb8uwHbZGJ7h8lD3kaL9kXhV36bE4HhoR+/vz33Mhg
	 MZsGnqTwp+vEmRtvpupcTHKJZOyDerAKfWNGjQ5XLmLmvO7wymY3GajpjZH4do/Pa4
	 U6C3rjeog953uQ4NSrLfTOZ44e0M4M9L8g8QNuUE=
Date: Wed, 30 Sep 2020 13:35:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200930103507.GK2142832@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-4-rppt@kernel.org>
 <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
 <20200929130602.GF2142832@kernel.org>
 <839fbb26254dc9932dcff3c48a3a4ab038c016ea.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <839fbb26254dc9932dcff3c48a3a4ab038c016ea.camel@intel.com>
Message-ID-Hash: NMZIRV7U7DNKSZEJUHBLKIJ6YGYZJVNQ
X-Message-ID-Hash: NMZIRV7U7DNKSZEJUHBLKIJ6YGYZJVNQ
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>, "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "will@kernel.org" <will@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "idan.yaniv@ibm.com" <idan.yaniv@ibm.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "tglx@linutronix.de" <tglx@linutronix.de>, "lin
 ux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "x86@kernel.org" <x86@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>, "tycho@tycho.ws" <tycho@tycho.ws>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NMZIRV7U7DNKSZEJUHBLKIJ6YGYZJVNQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 29, 2020 at 08:06:03PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2020-09-29 at 16:06 +0300, Mike Rapoport wrote:
> > On Tue, Sep 29, 2020 at 04:58:44AM +0000, Edgecombe, Rick P wrote:
> > > On Thu, 2020-09-24 at 16:29 +0300, Mike Rapoport wrote:
> > > > Introduce "memfd_secret" system call with the ability to create
> > > > memory
> > > > areas visible only in the context of the owning process and not
> > > > mapped not
> > > > only to other processes but in the kernel page tables as well.
> > > > 
> > > > The user will create a file descriptor using the memfd_secret()
> > > > system call
> > > > where flags supplied as a parameter to this system call will
> > > > define
> > > > the
> > > > desired protection mode for the memory associated with that file
> > > > descriptor.
> > > > 
> > > >   Currently there are two protection modes:
> > > > 
> > > > * exclusive - the memory area is unmapped from the kernel direct
> > > > map
> > > > and it
> > > >                is present only in the page tables of the owning
> > > > mm.
> > > 
> > > Seems like there were some concerns raised around direct map
> > > efficiency, but in case you are going to rework this...how does
> > > this
> > > memory work for the existing kernel functionality that does things
> > > like
> > > this?
> > > 
> > > get_user_pages(, &page);
> > > ptr = kmap(page);
> > > foo = *ptr;
> > > 
> > > Not sure if I'm missing something, but I think apps could cause the
> > > kernel to access a not-present page and oops.
> > 
> > The idea is that this memory should not be accessible by the kernel,
> > so
> > the sequence you describe should indeed fail.
> > 
> > Probably oops would be to noisy and in this case the report needs to
> > be
> > less verbose.
> 
> I was more concerned that it could cause kernel instabilities.

I think kernel recovers nicely from such sort of page fault, at least on
x86.

> I see, so it should not be accessed even at the userspace address? I
> wonder if it should be prevented somehow then. At least
> get_user_pages() should be prevented I think. Blocking copy_*_user()
> access might not be simple.
> 
> I'm also not so sure that a user would never have any possible reason
> to copy data from this memory into the kernel, even if it's just
> convenience. In which case a user setup could break if a specific
> kernel implementation switched to get_user_pages()/kmap() from using
> copy_*_user(). So seems maybe a bit thorny without fully blocking
> access from the kernel, or deprecating that pattern.
> 
> You should probably call out these "no passing data to/from the kernel"
> expectations, unless I missed them somewhere.

You are right, I should have been more explicit in the description of
the expected behavoir. 

Our thinking was that copy_*user() would work in the context of the
process that "owns" the secretmem and gup() would not allow access in
general, unless requested with certail (yet another) FOLL_ flag.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

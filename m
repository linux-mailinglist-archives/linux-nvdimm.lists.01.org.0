Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4CF2A40B6
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 10:53:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AEDE716522D93;
	Tue,  3 Nov 2020 01:53:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E14E116522D91
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 01:53:01 -0800 (PST)
Received: from kernel.org (unknown [87.71.17.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 0BBB92080C;
	Tue,  3 Nov 2020 09:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604397181;
	bh=lh70U56vprDGYqn/Uu8IBJ+iWmElKUpwOZcmksn3MyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djsvb14SN0dTNdL0dHydqIGZTQQJIWeDKAvtb0veCp5Ix1gEvvQVcFhgeonkgf1/J
	 RQrD7O/5SRUemCadMxWpVVfGhzdDbjksjDdqo9s8ZkUJfcSYo4rTs7bMtgSd2XHOjJ
	 QvgAK34USsCDWELlPKdltzRhz93byDZzTNIknty0=
Date: Tue, 3 Nov 2020 11:52:47 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201103095247.GH4879@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <9c38ac3b-c677-6a87-ce82-ec53b69eaf71@redhat.com>
 <20201102174308.GF4879@kernel.org>
 <d4cb2c87-4744-3929-cedd-2be78625a741@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4cb2c87-4744-3929-cedd-2be78625a741@redhat.com>
Message-ID-Hash: Q22Y5ZYVFAJAQFR7QSFWDZ4I4NRFXWXZ
X-Message-ID-Hash: Q22Y5ZYVFAJAQFR7QSFWDZ4I4NRFXWXZ
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, lin
 ux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q22Y5ZYVFAJAQFR7QSFWDZ4I4NRFXWXZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 02, 2020 at 06:51:09PM +0100, David Hildenbrand wrote:
> > > Assume you have a system with quite some ZONE_MOVABLE memory (esp. in
> > > virtualized environments), eating up a significant amount of !ZONE_MOVABLE
> > > memory dynamically at runtime can lead to non-obvious issues. It looks like
> > > you have plenty of free memory, but the kernel might still OOM when trying
> > > to do kernel allocations e.g., for pagetables. With CMA we at least know
> > > what we're dealing with - it behaves like ZONE_MOVABLE except for the owner
> > > that can place unmovable pages there. We can use it to compute statically
> > > the amount of ZONE_MOVABLE memory we can have in the system without doing
> > > harm to the system.
> > 
> > Why would you say that secretmem allocates from !ZONE_MOVABLE?
> > If we put boot time reservations aside, the memory allocation for
> > secretmem follows the same rules as the memory allocations for any file
> > descriptor. That means we allocate memory with GFP_HIGHUSER_MOVABLE.
> 
> Oh, okay - I missed that! I had the impression that pages are unmovable and
> allocating from ZONE_MOVABLE would be a violation of that?
> 
> > After the allocation the memory indeed becomes unmovable but it's not
> > like we are eating memory from other zones here.
> 
> ... and here you have your problem. That's a no-no. We only allow it in very
> special cases where it can't be avoided - e.g., vfio having to pin guest
> memory when passing through memory to VMs.
> 
> Hotplug memory, online it to ZONE_MOVABLE. Allocate secretmem. Try to unplug
> the memory again -> endless loop in offline_pages().
> 
> Or have a CMA area that gets used with GFP_HIGHUSER_MOVABLE. Allocate
> secretmem. The owner of the area tries to allocate memory - always fails.
> Purpose of CMA destroyed.
> 
> > 
> > > Ideally, we would want to support page migration/compaction and allow for
> > > allocation from ZONE_MOVABLE as well. Would involve temporarily mapping,
> > > copying, unmapping. Sounds feasible, but not sure which roadblocks we would
> > > find on the way.
> > 
> > We can support migration/compaction with temporary mapping. The first
> > roadblock I've hit there was that migration allocates 4K destination
> > page and if we use it in secret map we are back to scrambling the direct
> > map into 4K pieces. It still sounds feasible but not as trivial :)
> 
> That sounds like the proper way for me to do it then.
 
Although migration of secretmem pages sounds feasible now, there maybe
other issues I didn't see because I'm not very familiar with
migration/compaction code.

I've looked again at CMA and I'm inclined to agree with you that using
CMA for secretmem allocations could be the right thing. 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

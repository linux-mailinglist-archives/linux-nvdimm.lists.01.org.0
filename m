Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3DC2A31D3
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Nov 2020 18:43:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD53C164E1A24;
	Mon,  2 Nov 2020 09:43:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF52F164D859F
	for <linux-nvdimm@lists.01.org>; Mon,  2 Nov 2020 09:43:22 -0800 (PST)
Received: from kernel.org (unknown [87.71.17.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id F163621D91;
	Mon,  2 Nov 2020 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604339002;
	bh=4lTOK6nJwjmoOAObnnRBOTKd0fl9eQpxyGZlvj7NIPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaQHhcNIPlO/3Y1BDKIiRptwVm/gNfTOsggLuTFWgEEfzGk4JpghqGJiTK1uJXPww
	 xcrmfo2wowW6SunTYD97zxQcWOPYPEwCUuK+Opbf1HTskJ6CenmFJitmkrFyumA+RF
	 614VdGzOVlHHOfs2z6uhOZXESicNeUeTW56l5apA=
Date: Mon, 2 Nov 2020 19:43:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201102174308.GF4879@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <9c38ac3b-c677-6a87-ce82-ec53b69eaf71@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9c38ac3b-c677-6a87-ce82-ec53b69eaf71@redhat.com>
Message-ID-Hash: GNDKUPKB6Z72UMDRIEN22FVNKSONLZHE
X-Message-ID-Hash: GNDKUPKB6Z72UMDRIEN22FVNKSONLZHE
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, lin
 ux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GNDKUPKB6Z72UMDRIEN22FVNKSONLZHE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 02, 2020 at 10:11:12AM +0100, David Hildenbrand wrote:
> On 24.09.20 15:28, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > This is an implementation of "secret" mappings backed by a file descriptor.
> > I've dropped the boot time reservation patch for now as it is not strictly
> > required for the basic usage and can be easily added later either with or
> > without CMA.
> 
> Hi Mike,
> 
> I'd like to stress again that I'd prefer *any* secretmem allocations going
> via CMA as long as these pages are unmovable. The user can allocate a
> non-significant amount of unmovable allocations only fenced by the mlock
> limit, which behave very different to mlocked pages - they are not movable
> for page compaction/migration.
> 
> Assume you have a system with quite some ZONE_MOVABLE memory (esp. in
> virtualized environments), eating up a significant amount of !ZONE_MOVABLE
> memory dynamically at runtime can lead to non-obvious issues. It looks like
> you have plenty of free memory, but the kernel might still OOM when trying
> to do kernel allocations e.g., for pagetables. With CMA we at least know
> what we're dealing with - it behaves like ZONE_MOVABLE except for the owner
> that can place unmovable pages there. We can use it to compute statically
> the amount of ZONE_MOVABLE memory we can have in the system without doing
> harm to the system.

Why would you say that secretmem allocates from !ZONE_MOVABLE?
If we put boot time reservations aside, the memory allocation for
secretmem follows the same rules as the memory allocations for any file
descriptor. That means we allocate memory with GFP_HIGHUSER_MOVABLE.
After the allocation the memory indeed becomes unmovable but it's not
like we are eating memory from other zones here.

Maybe I'm missing something, but it seems to me that using CMA for any
secretmem allocation would needlessly complicate things.

> Ideally, we would want to support page migration/compaction and allow for
> allocation from ZONE_MOVABLE as well. Would involve temporarily mapping,
> copying, unmapping. Sounds feasible, but not sure which roadblocks we would
> find on the way.

We can support migration/compaction with temporary mapping. The first
roadblock I've hit there was that migration allocates 4K destination
page and if we use it in secret map we are back to scrambling the direct
map into 4K pieces. It still sounds feasible but not as trivial :)

But again, there is nothing in the current form of secretmem that
prevents allocation from ZONE_MOVABLE.

> [...]
> 
> > I've hesitated whether to continue to use new flags to memfd_create() or to
> > add a new system call and I've decided to use a new system call after I've
> > started to look into man pages update. There would have been two completely
> > independent descriptions and I think it would have been very confusing.
> 
> This was also raised on lwn.net by "dullfire" [1]. I do wonder if it would
> be the right place as well.

I lean towards a dedicated syscall because, as I said, to me it would
seem less confusing.

> [1] https://lwn.net/Articles/835342/#Comments
> 
> > 
> > Hiding secret memory mappings behind an anonymous file allows (ab)use of
> > the page cache for tracking pages allocated for the "secret" mappings as
> > well as using address_space_operations for e.g. page migration callbacks.
> > 
> > The anonymous file may be also used implicitly, like hugetlb files, to
> > implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
> > ABIs in the future.
> > 
> > As the fragmentation of the direct map was one of the major concerns raised
> > during the previous postings, I've added an amortizing cache of PMD-size
> > pages to each file descriptor that is used as an allocation pool for the
> > secret memory areas.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

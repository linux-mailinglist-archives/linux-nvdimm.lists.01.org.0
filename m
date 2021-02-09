Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70865314FF0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 14:17:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 964B6100EAB5F;
	Tue,  9 Feb 2021 05:17:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9474B100EAB4A
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 05:17:14 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1612876633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hscVwXWbZS59k2Mrx2EQB55XPrmNAr7Nf/1W616aiRA=;
	b=phJYgl2FDdsaxXzglirq+9E/PFvQ09SmMOXMZhmQCkX3xnUui6gyQgU8pq6VCgFZRP1Nj7
	4ywYD8QcYFjpmTT73fbyJ99EI01XOD13cuJJ02YYNRiktCaeLBu0orc/YuPfY4sb+PIX+n
	y3DWzu+Qklmtk5MHIoO/Fx8xciQgqDo=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 9362BAD6A;
	Tue,  9 Feb 2021 13:17:12 +0000 (UTC)
Date: Tue, 9 Feb 2021 14:17:11 +0100
From: Michal Hocko <mhocko@suse.com>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210209090938.GP299309@linux.ibm.com>
Message-ID-Hash: 3RLR2N6RTIZ2KHLLB65GTMIL74EQVI6T
X-Message-ID-Hash: 3RLR2N6RTIZ2KHLLB65GTMIL74EQVI6T
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho And
 ersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3RLR2N6RTIZ2KHLLB65GTMIL74EQVI6T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 09-02-21 11:09:38, Mike Rapoport wrote:
> On Tue, Feb 09, 2021 at 09:47:08AM +0100, Michal Hocko wrote:
> > On Mon 08-02-21 23:26:05, Mike Rapoport wrote:
> > > On Mon, Feb 08, 2021 at 11:49:22AM +0100, Michal Hocko wrote:
> > > > On Mon 08-02-21 10:49:17, Mike Rapoport wrote:
> > [...]
> > > > > The file descriptor based memory has several advantages over the
> > > > > "traditional" mm interfaces, such as mlock(), mprotect(), madvise(). It
> > > > > paves the way for VMMs to remove the secret memory range from the process;
> > > > 
> > > > I do not understand how it helps to remove the memory from the process
> > > > as the interface explicitly allows to add a memory that is removed from
> > > > all other processes via direct map.
> > > 
> > > The current implementation does not help to remove the memory from the
> > > process, but using fd-backed memory seems a better interface to remove
> > > guest memory from host mappings than mmap. As Andy nicely put it:
> > > 
> > > "Getting fd-backed memory into a guest will take some possibly major work in
> > > the kernel, but getting vma-backed memory into a guest without mapping it
> > > in the host user address space seems much, much worse."
> > 
> > OK, so IIUC this means that the model is to hand over memory from host
> > to guest. I thought the guest would be under control of its address
> > space and therefore it operates on the VMAs. This would benefit from
> > an additional and more specific clarification.
> 
> How guest would operate on VMAs if the interface between host and guest is
> virtual hardware?

I have to say that I am not really familiar with this area so my view
might be misleading or completely wrong. I thought that the HW address
ranges are mapped to the guest process and therefore have a VMA.

> If you mean qemu (or any other userspace part of VMM that uses KVM), so one
> of the points Andy mentioned back than is to remove mappings of the guest
> memory from the qemu process.
>  
> > > > > As secret memory implementation is not an extension of tmpfs or hugetlbfs,
> > > > > usage of a dedicated system call rather than hooking new functionality into
> > > > > memfd_create(2) emphasises that memfd_secret(2) has different semantics and
> > > > > allows better upwards compatibility.
> > > > 
> > > > What is this supposed to mean? What are differences?
> > > 
> > > Well, the phrasing could be better indeed. That supposed to mean that
> > > they differ in the semantics behind the file descriptor: memfd_create
> > > implements sealing for shmem and hugetlbfs while memfd_secret implements
> > > memory hidden from the kernel.
> > 
> > Right but why memfd_create model is not sufficient for the usecase?
> > Please note that I am arguing against. To be honest I do not really care
> > much. Using an existing scheme is usually preferable from my POV but
> > there might be real reasons why shmem as a backing "storage" is not
> > appropriate.
>    
> Citing my older email:
> 
>     I've hesitated whether to continue to use new flags to memfd_create() or to
>     add a new system call and I've decided to use a new system call after I've
>     started to look into man pages update. There would have been two completely
>     independent descriptions and I think it would have been very confusing.

Could you elaborate? Unmapping from the kernel address space can work
both for sealed or hugetlb memfds, no? Those features are completely
orthogonal AFAICS. With a dedicated syscall you will need to introduce
this functionality on top if that is required. Have you considered that?
I mean hugetlb pages are used to back guest memory very often. Is this
something that will be a secret memory usecase?

Please be really specific when giving arguments to back a new syscall
decision.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

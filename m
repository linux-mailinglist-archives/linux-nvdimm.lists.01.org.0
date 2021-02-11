Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA72318592
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 08:13:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5172100EBBBE;
	Wed, 10 Feb 2021 23:13:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 54B0B100EC1DF
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 23:13:38 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ABFC64E70;
	Thu, 11 Feb 2021 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1613027617;
	bh=mFb5e+mcFjieGwWXbuKlq9q0UpNNbyeAq1/dwdNreuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r612v7W+RCFxSqtS+kG65T2iZaVwzZel4btR0FeMO2RkiMdOJ50IMLVhWxhHEVjeq
	 RWIWvUmaSjvpNuRiWAmSDAzQxhntPIcqMrjyseEOwkEKs8om6hanjiK/XvklN5gvM6
	 4IRSCxhZL6+efdSsP/rZVDzTJVVy90foUNPuGiwSGjLg9nOaHA3e8aP5tOIg2ASxIJ
	 Sp6nUBHKEK6j6j934tjzENjbujdOFEbYvxhqtUewKvYJI0DUbn0exEQp0qLWLIqa56
	 Txi+Gq3TeUWe+Arxca2HZee6BKF625xZfgl8d82Twk0iYyM/fBr2k70XriEGyOWcL0
	 DaEcHGkrjBISA==
Date: Thu, 11 Feb 2021 09:13:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210211071319.GF242749@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
Message-ID-Hash: SUJLVJR63Q7JWMI7FKU5KP4APNGZ37W7
X-Message-ID-Hash: SUJLVJR63Q7JWMI7FKU5KP4APNGZ37W7
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SUJLVJR63Q7JWMI7FKU5KP4APNGZ37W7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 09, 2021 at 02:17:11PM +0100, Michal Hocko wrote:
> On Tue 09-02-21 11:09:38, Mike Rapoport wrote:
> > On Tue, Feb 09, 2021 at 09:47:08AM +0100, Michal Hocko wrote:
> > > 
> > > OK, so IIUC this means that the model is to hand over memory from host
> > > to guest. I thought the guest would be under control of its address
> > > space and therefore it operates on the VMAs. This would benefit from
> > > an additional and more specific clarification.
> > 
> > How guest would operate on VMAs if the interface between host and guest is
> > virtual hardware?
> 
> I have to say that I am not really familiar with this area so my view
> might be misleading or completely wrong. I thought that the HW address
> ranges are mapped to the guest process and therefore have a VMA.

There is a qemu process that currently has mappings of what guest sees as
its physical memory, but qemu is a part of hypervisor, i.e. host.
 
> > Citing my older email:
> > 
> >     I've hesitated whether to continue to use new flags to memfd_create() or to
> >     add a new system call and I've decided to use a new system call after I've
> >     started to look into man pages update. There would have been two completely
> >     independent descriptions and I think it would have been very confusing.
> 
> Could you elaborate? Unmapping from the kernel address space can work
> both for sealed or hugetlb memfds, no? Those features are completely
> orthogonal AFAICS. With a dedicated syscall you will need to introduce
> this functionality on top if that is required. Have you considered that?
> I mean hugetlb pages are used to back guest memory very often. Is this
> something that will be a secret memory usecase?
> 
> Please be really specific when giving arguments to back a new syscall
> decision.

Isn't "syscalls have completely independent description" specific enough?

We are talking about API here, not the implementation details whether
secretmem supports large pages or not.

The purpose of memfd_create() is to create a file-like access to memory.
The purpose of memfd_secret() is to create a way to access memory hidden
from the kernel.

I don't think overloading memfd_create() with the secretmem flags because
they happen to return a file descriptor will be better for users, but
rather will be more confusing.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

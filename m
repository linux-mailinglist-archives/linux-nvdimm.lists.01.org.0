Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAE22B7690
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Nov 2020 07:57:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC3D4100EBBC0;
	Tue, 17 Nov 2020 22:57:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D90D5100EBBA2
	for <linux-nvdimm@lists.01.org>; Tue, 17 Nov 2020 22:57:21 -0800 (PST)
Received: from kernel.org (unknown [77.125.7.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C5BB624654;
	Wed, 18 Nov 2020 06:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1605682641;
	bh=p9re6A1RRg6oU6SsuX3QRE0t8ggbYYLXloFK2ojmgAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U45SNSKJGotiPIakEwaAseiV27AsVkyTNt66bCAHLcpiM1G9GhxPaQQlROUaXdH9c
	 rZ2SGl1DirjI0HjrC5eRlRQ7rEdibP7yq1sGHKXfUjmBvTCB1ZAiMR3V9ZcpXtRamU
	 6btiE8gvCG8QTrNMjF7yXVOnKyB3lsNIE30mk1FQ=
Date: Wed, 18 Nov 2020 08:57:06 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 8/9] arch, mm: wire up memfd_secret system call were
 relevant
Message-ID: <20201118065706.GL370813@kernel.org>
References: <20201117162932.13649-1-rppt@kernel.org>
 <20201117162932.13649-9-rppt@kernel.org>
 <X7QFMhQlyBMI1wXE@trantor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X7QFMhQlyBMI1wXE@trantor>
Message-ID-Hash: LXCBPAVBJDNYLH3YUDTC4QW3TSS3SXDA
X-Message-ID-Hash: LXCBPAVBJDNYLH3YUDTC4QW3TSS3SXDA
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel
 .org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LXCBPAVBJDNYLH3YUDTC4QW3TSS3SXDA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 17, 2020 at 05:15:30PM +0000, Catalin Marinas wrote:
> On Tue, Nov 17, 2020 at 06:29:31PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Wire up memfd_secret system call on architectures that define
> > ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm64/include/asm/unistd.h        | 2 +-
> >  arch/arm64/include/asm/unistd32.h      | 2 ++
> >  arch/arm64/include/uapi/asm/unistd.h   | 1 +
> >  arch/riscv/include/asm/unistd.h        | 1 +
> >  arch/x86/entry/syscalls/syscall_32.tbl | 1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
> >  include/linux/syscalls.h               | 1 +
> >  include/uapi/asm-generic/unistd.h      | 6 +++++-
> >  scripts/checksyscalls.sh               | 4 ++++
> >  9 files changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> > index 86a9d7b3eabe..949788f5ba40 100644
> > --- a/arch/arm64/include/asm/unistd.h
> > +++ b/arch/arm64/include/asm/unistd.h
> > @@ -38,7 +38,7 @@
> >  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
> >  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
> >  
> > -#define __NR_compat_syscalls		442
> > +#define __NR_compat_syscalls		443
> >  #endif
> >  
> >  #define __ARCH_WANT_SYS_CLONE
> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index 6c1dcca067e0..5279481ec95b 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
> >  __SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  #define __NR_watch_mount 441
> >  __SYSCALL(__NR_watch_mount, sys_watch_mount)
> > +/* 442 is memfd_secret, it is not implemented for 32-bit */
> > +__SYSCALL(442, sys_ni_syscall)
> 
> It now behaves correctly for compat but I don't think we need to
> increment __NR_compat_syscalls. The compat syscall handler already calls
> sys_ni_syscall() if out of range.

Ok, let's drop this change as well :)

> So the only arm64 change needed is defining __ARCH_WANT_MEMFD_SECRET
> (well, we don't have a use for it yet ;)).
> 
> -- 
> Catalin

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

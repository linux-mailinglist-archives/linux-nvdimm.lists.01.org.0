Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB8E2B3310
	for <lists+linux-nvdimm@lfdr.de>; Sun, 15 Nov 2020 09:57:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6C58100EF271;
	Sun, 15 Nov 2020 00:57:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B0A79100EF270
	for <linux-nvdimm@lists.01.org>; Sun, 15 Nov 2020 00:57:06 -0800 (PST)
Received: from kernel.org (unknown [77.125.7.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 224EC22450;
	Sun, 15 Nov 2020 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1605430626;
	bh=SUtFVZkBjnPG4BEsw28+x8DzSO0BcyIPD75+9xZ8F1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nA4M8UsTrs+9GlWcdh9/jFcMAMptctAK3t+3wr64R0pGeK4zorYnmfDnfR3Ad3XuM
	 4V9iKOl0BQeRQea+6ux/1qg3VYiBu+QNEGvj/FtyAXZ1cUxYcq8fcJg8nlVaicah0u
	 qQq3y46yY70qBqcgnfIM+bdn1hjhb9BA2nf7HDLQ=
Date: Sun, 15 Nov 2020 10:56:53 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v8 8/9] arch, mm: wire up memfd_secret system call were
 relevant
Message-ID: <20201115085653.GW4758@kernel.org>
References: <20201110151444.20662-1-rppt@kernel.org>
 <20201110151444.20662-9-rppt@kernel.org>
 <20201113122507.GC3212@gaia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201113122507.GC3212@gaia>
Message-ID-Hash: 5GZBSXUML4P5LPEXRNLYI2BAUWAXWDOM
X-Message-ID-Hash: 5GZBSXUML4P5LPEXRNLYI2BAUWAXWDOM
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.o
 rg, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5GZBSXUML4P5LPEXRNLYI2BAUWAXWDOM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 13, 2020 at 12:25:08PM +0000, Catalin Marinas wrote:
> Hi Mike,
> 
> On Tue, Nov 10, 2020 at 05:14:43PM +0200, Mike Rapoport wrote:
> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index 6c1dcca067e0..c71c3fe0b6cd 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
> >  __SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  #define __NR_watch_mount 441
> >  __SYSCALL(__NR_watch_mount, sys_watch_mount)
> > +#define __NR_memfd_secret 442
> > +__SYSCALL(__NR_memfd_secret, sys_memfd_secret)
> 
> arch/arm doesn't select ARCH_HAS_SET_DIRECT_MAP and doesn't support
> memfd_secret(), so I wouldn't add it to the compat layer.

Ok, I'll drop it.

> -- 
> Catalin

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822132D2029
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 02:35:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D54B8100EBB9C;
	Mon,  7 Dec 2020 17:35:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 762AB100EBB7E
	for <linux-nvdimm@lists.01.org>; Mon,  7 Dec 2020 17:35:03 -0800 (PST)
Date: Mon, 7 Dec 2020 17:34:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1607391302;
	bh=i3984NOIVWMaE+QFhgCLJtfILbc6/RSkG9XvGukRs7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:From;
	b=hca7faBpqEriF6FZPtd0wlbzAlfSR3EKfyTBaBt4dgDAVy9k1yPd7IQFpymwABy3h
	 s9qHHlOLbsb4kwF/DfCdj2T4PkbJ+5OVWDB3l03SlUvMWEw9yXHqVH08/s5GvFXorR
	 waVdV51wewfkqAeXxoNzsw4CAoe7ms/Mee6ucYrc=
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v14 09/10] arch, mm: wire up memfd_secret system call
 were relevant
Message-Id: <20201207173459.a4d4a3404e163314c29f0785@linux-foundation.org>
In-Reply-To: <20201207160006.GG1112728@linux.ibm.com>
References: <20201203062949.5484-1-rppt@kernel.org>
	<20201203062949.5484-10-rppt@kernel.org>
	<81631d3391abca3f41f2e19092b97a61d49f4e44.camel@redhat.com>
	<20201207160006.GG1112728@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: 2VY57FVLFWH6WLW3VGTE7UPTJOHYQ7VZ
X-Message-ID-Hash: 2VY57FVLFWH6WLW3VGTE7UPTJOHYQ7VZ
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Qian Cai <qcai@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@ty
 cho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2VY57FVLFWH6WLW3VGTE7UPTJOHYQ7VZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 7 Dec 2020 18:00:06 +0200 Mike Rapoport <rppt@linux.ibm.com> wrote:

> > 
> > I can't see where was it defined for arm64 after it looks like Andrew has
> > deleted the  above chunk. Thus, we have a warning using this .config:
> > 
> > https://cailca.coding.net/public/linux/mm/git/files/master/arm64.config
> > 
> > <stdin>:1539:2: warning: #warning syscall memfd_secret not implemented [-Wcpp]
> 
> I was under the impression that Andrew only removed the #ifdef...
> 
> Andrew, can you please restore syscall definition for memfd_secret() in
> include/uapi/asm-generic/unistd.h?
> 

urgh, OK, that seems to have got lost in the (moderate amount of)
conflict resolution).

--- a/include/uapi/asm-generic/unistd.h~arch-mm-wire-up-memfd_secret-system-call-were-relevant-fix
+++ a/include/uapi/asm-generic/unistd.h
@@ -863,9 +863,13 @@ __SYSCALL(__NR_process_madvise, sys_proc
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
 #define __NR_epoll_pwait2 442
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
+#ifdef __ARCH_WANT_MEMFD_SECRET
+#define __NR_memfd_secret 443
+__SYSCALL(__NR_memfd_secret, sys_memfd_secret)
+#endif
 
 #undef __NR_syscalls
-#define __NR_syscalls 443
+#define __NR_syscalls 444
 
 /*
  * 32 bit systems traditionally used different
_
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

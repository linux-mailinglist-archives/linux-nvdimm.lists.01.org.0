Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 009033883E3
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 May 2021 02:44:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D78EC100EB84D;
	Tue, 18 May 2021 17:44:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9AB68100EBB7F
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 17:44:26 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D59F6135B;
	Wed, 19 May 2021 00:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1621385064;
	bh=TaIIw0YYtenqp7/hfp+Brr2pi7x+J7tKiTwiGcf4BXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OWqlmtzTKs7bvcu6OsrPtdFoycSizT0julGnQ1nL89UDOP47oOx68Qc7/VuYXRLHl
	 PNVwvj+VZTjuZY29zaA8iT4YqSTgqnpaEgh3VOC71g9NKcI8TaUUyHgG2IXdNHcZ/n
	 vJFCM+BcjPVeDtUlkhRioxH5rtQ7jgaUQXdaR9z4=
Date: Tue, 18 May 2021 17:44:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v20 4/7] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-Id: <20210518174422.399ad118a051fe4c5b11d7ba@linux-foundation.org>
In-Reply-To: <20210518072034.31572-5-rppt@kernel.org>
References: <20210518072034.31572-1-rppt@kernel.org>
	<20210518072034.31572-5-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: WPMLV7GPILUWCHOMPIBRO5S5CRAZECAT
X-Message-ID-Hash: WPMLV7GPILUWCHOMPIBRO5S5CRAZECAT
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@in
 fradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WPMLV7GPILUWCHOMPIBRO5S5CRAZECAT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 18 May 2021 10:20:31 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Introduce "memfd_secret" system call with the ability to create memory
> areas visible only in the context of the owning process and not mapped not
> only to other processes but in the kernel page tables as well.
> 
> ...
>
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -901,4 +901,9 @@ config KMAP_LOCAL
>  # struct io_mapping based helper.  Selected by drivers that need them
>  config IO_MAPPING
>  	bool
> +
> +config SECRETMEM
> +	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> +	select STRICT_DEVMEM
> +
>  endmenu

WARNING: unmet direct dependencies detected for STRICT_DEVMEM
  Depends on [n]: MMU [=y] && DEVMEM [=n] && (ARCH_HAS_DEVMEM_IS_ALLOWED [=y] || GENERIC_LIB_DEVMEM_IS_ALLOWED [=n])
  Selected by [y]:
  - SECRETMEM [=y]

so I went back to the v19 version, with

--- a/mm/Kconfig~mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix
+++ a/mm/Kconfig
@@ -907,6 +907,5 @@ config IO_MAPPING
 
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
-	select STRICT_DEVMEM
 
 endmenu
_
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

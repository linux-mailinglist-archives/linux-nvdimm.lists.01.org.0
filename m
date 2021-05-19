Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B70E3885B4
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 May 2021 05:51:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AD821100EB823;
	Tue, 18 May 2021 20:51:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EEACC100ED497
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 20:50:56 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A22160698;
	Wed, 19 May 2021 03:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1621396255;
	bh=OHqMi61ZqX4ySIrfnisk/+K7U7qM/mCXhP8jYMj1P84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYAE07pQhQM8o7Wp7sXA/L3u7rt0s5M+ViFahOF7b94Od8vLSvNm59LWBWGahD5Td
	 //07qQooCrEAvIEElW9/DslmDL8J4D2K38vvD2y4ZIFnrbiE6mYEZP+qyMTJRbPQm4
	 ng7WKl+CsCMDiF9ZTD5yz79TwuhQ2Bmem6NORzx5sZia3oO9BeRuVTw7r2+9JG4Bn1
	 Y5+OK1WrxaIkzC5MuMQxoLI7XHdiQBfR4r9qxVwgO96jZTvNivIbQyXbGEcZ1Bo5sU
	 2a/tc6+FwBn7EtnfaddaIUUJMDcK0N4p6TdNf2HQST//b3D2Bl+XNTSL1haulJxm4I
	 yH1MAff7bIYkg==
Date: Wed, 19 May 2021 06:50:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v20 4/7] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <YKSLDYqwmANLcQJt@kernel.org>
References: <20210518072034.31572-1-rppt@kernel.org>
 <20210518072034.31572-5-rppt@kernel.org>
 <20210518174422.399ad118a051fe4c5b11d7ba@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210518174422.399ad118a051fe4c5b11d7ba@linux-foundation.org>
Message-ID-Hash: QR347CROG2TG232ZTUQUJLAMMNI3ID3R
X-Message-ID-Hash: QR347CROG2TG232ZTUQUJLAMMNI3ID3R
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@in
 fradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QR347CROG2TG232ZTUQUJLAMMNI3ID3R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 18, 2021 at 05:44:22PM -0700, Andrew Morton wrote:
> On Tue, 18 May 2021 10:20:31 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Introduce "memfd_secret" system call with the ability to create memory
> > areas visible only in the context of the owning process and not mapped not
> > only to other processes but in the kernel page tables as well.
> > 
> > ...
> >
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -901,4 +901,9 @@ config KMAP_LOCAL
> >  # struct io_mapping based helper.  Selected by drivers that need them
> >  config IO_MAPPING
> >  	bool
> > +
> > +config SECRETMEM
> > +	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> > +	select STRICT_DEVMEM
> > +
> >  endmenu
> 
> WARNING: unmet direct dependencies detected for STRICT_DEVMEM
>   Depends on [n]: MMU [=y] && DEVMEM [=n] && (ARCH_HAS_DEVMEM_IS_ALLOWED [=y] || GENERIC_LIB_DEVMEM_IS_ALLOWED [=n])
>   Selected by [y]:
>   - SECRETMEM [=y]
> 
> so I went back to the v19 version, with

Ouch, sorry, I forgot to remove that hunk, v19 is the correct version.
 
> --- a/mm/Kconfig~mm-introduce-memfd_secret-system-call-to-create-secret-memory-areas-fix
> +++ a/mm/Kconfig
> @@ -907,6 +907,5 @@ config IO_MAPPING
>  
>  config SECRETMEM
>  	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> -	select STRICT_DEVMEM
>  
>  endmenu
> _
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

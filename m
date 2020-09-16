Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2877F26C870
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 20:49:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4009714DF579F;
	Wed, 16 Sep 2020 11:49:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5C4F114DF579D
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 11:49:40 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7882922224
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600282179;
	bh=16sTH0SegakzZKBjY8U3FsytaAxRFzwi1y28PIc8vKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qatkcq3nv+S9pPj+P3JFSXG9oKzt2ivfBeSNtIFNuwDO8ZBcYBS3134yWRyvjTXiQ
	 4L7IXkhOodRGI+KFpKt3pj2oao09DdAJWwhNU7tUkWacyJbacCR2xaFA2YuokWC5fS
	 mD3KTRcCOuu+Cqd3yKSH66vZQHQDEZkKLTJ91ngA=
Received: by mail-wr1-f48.google.com with SMTP id w5so7963776wrp.8
        for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 11:49:39 -0700 (PDT)
X-Gm-Message-State: AOAM531fgSImPgo4JZxT3LdzyV+eTMI5b81O2dyQ6o4bCj5HL3XCDelN
	SoxVepseknRqQjpGrMKwQo7VibRWpnwKA/We59oeOQ==
X-Google-Smtp-Source: ABdhPJwUX3bHQLCL84qG4wIC/JlN+nYNkgmXwAB8lo/1k8NF8oo4sGXt7L/6GSwGvTFkR4oICcgx71syaFhCR+ehMOk=
X-Received: by 2002:a5d:5111:: with SMTP id s17mr28001448wrt.70.1600282177590;
 Wed, 16 Sep 2020 11:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200916072842.3502-1-rppt@kernel.org>
In-Reply-To: <20200916072842.3502-1-rppt@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 16 Sep 2020 11:49:25 -0700
X-Gmail-Original-Message-ID: <CALCETrV6nFQ4tzhxKPSnK+Ec=U8ojY0k_-G2EqEG-WMGT4TkUw@mail.gmail.com>
Message-ID: <CALCETrV6nFQ4tzhxKPSnK+Ec=U8ojY0k_-G2EqEG-WMGT4TkUw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
To: Mike Rapoport <rppt@kernel.org>
Message-ID-Hash: OPGPFAGV5SWLX2AIA2BMNZNRM3SBJCJP
X-Message-ID-Hash: OPGPFAGV5SWLX2AIA2BMNZNRM3SBJCJP
X-MailFrom: luto@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <
 linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-riscv@lists.infradead.org, X86 ML <x86@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OPGPFAGV5SWLX2AIA2BMNZNRM3SBJCJP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2020 at 12:28 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Hi,
>
> This is an implementation of "secret" mappings backed by a file descriptor.
> I've dropped the boot time reservation patch for now as it is not strictly
> required for the basic usage and can be easily added later either with or
> without CMA.
>
> v5 changes:
> * rebase on v5.9-rc5
> * drop boot time memory reservation patch
>
> v4 changes:
> * rebase on v5.9-rc1
> * Do not redefine PMD_PAGE_ORDER in fs/dax.c, thanks Kirill
> * Make secret mappings exclusive by default and only require flags to
>   memfd_secret() system call for uncached mappings, thanks again Kirill :)
>
> v3 changes:
> * Squash kernel-parameters.txt update into the commit that added the
>   command line option.
> * Make uncached mode explicitly selectable by architectures. For now enable
>   it only on x86.
>
> v2 changes:
> * Follow Michael's suggestion and name the new system call 'memfd_secret'
> * Add kernel-parameters documentation about the boot option
> * Fix i386-tinyconfig regression reported by the kbuild bot.
>   CONFIG_SECRETMEM now depends on !EMBEDDED to disable it on small systems
>   from one side and still make it available unconditionally on
>   architectures that support SET_DIRECT_MAP.
>
> The file descriptor backing secret memory mappings is created using a
> dedicated memfd_secret system call The desired protection mode for the
> memory is configured using flags parameter of the system call. The mmap()
> of the file descriptor created with memfd_secret() will create a "secret"
> memory mapping. The pages in that mapping will be marked as not present in
> the direct map and will have desired protection bits set in the user page
> table. For instance, current implementation allows uncached mappings.

I still have serious concerns with uncached mappings.  I'm not saying
I can't be convinced, but I'm not currently convinced that we should
allow user code to create UC mappings on x86.

--Andy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

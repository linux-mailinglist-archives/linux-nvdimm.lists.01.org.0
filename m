Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F06305257
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 Jan 2021 06:46:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8813A100EB85D;
	Tue, 26 Jan 2021 21:46:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=palmer@dabbelt.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 08BC4100EB859
	for <linux-nvdimm@lists.01.org>; Tue, 26 Jan 2021 21:46:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s15so419054plr.9
        for <linux-nvdimm@lists.01.org>; Tue, 26 Jan 2021 21:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pGwLX141izLDvx1hQTGiiwKO086AeFCYCtYAmNWi9wI=;
        b=AmTdH3IG4UQzJndI1D27UQJWy8ntwz3x96fLaGYHHI8DDA6H+Y68FXg1U5+ek6ovCn
         BQskNvflja4Kqe4HWtn3w42joJ9YUlN577FkgtA2wn8h4A+gee/IgXId+fkal+R9QLJn
         Na2PxVzgvj5x+O52bGPuCVBbamCyvJdweyNcbR3LECVkeySnNjL82VUJ/YR5uOBQj289
         qijz8MXoF7zeIeGbr1pzM0INdKa2u6ikLS6t9DFsADUNGVZIqVyByhitCvhByTi3r9Cb
         GFO8v3dk3dOPI8NCgIEvoLfRAsoSe8tDBOqTLpl21rRUuC+KF1FC+PjiJRruBMdfA3J+
         e4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pGwLX141izLDvx1hQTGiiwKO086AeFCYCtYAmNWi9wI=;
        b=nBIsoRJkC1vuPLMvDcOU+ILN2RbslwxIROri4Ne+LyDd6VfALAoEyv1FJQWqB/jVRO
         tRtrEy8CvPUouBGnkkXovuIdOVxODkFzeZOVSAQqAGIT1iin+zQ9GFVuRrgHmeG6Fy96
         8SfxCYQyOCZ1UypxE53gnLhBuUqOKvZ+ueYKWU+vTFR/aowgq/cej5qUXRJNjeXqGW2v
         wj+iYlsPHxH/Ge29jOwkTHVrlnxPUbWRdDfR7SUIaUxMk5mSd02wlkUolPjEobcbc8i5
         Wc2ORldXKfySVDS+XxyAca1gp151A64ckR9GIvOqMhlG+7bM3VC2G3Adi3hckINwW6zd
         S7Ww==
X-Gm-Message-State: AOAM533xQPTh000cMaL3SqJl5ZGW2Skg1b9yQCDi3oAO3NpIGr3qd0AK
	5eU52xbOZH7uh6tIR7kCi0oy2Q==
X-Google-Smtp-Source: ABdhPJzlYhGFSdTqcPKE8K2PIdYf+VA6n3sx73gQUwIFBNusPJfAV5LCpnY0tYvL1n4CZqElayMtXA==
X-Received: by 2002:a17:902:e8c9:b029:de:a2c7:e661 with SMTP id v9-20020a170902e8c9b02900dea2c7e661mr9611617plg.76.1611726379718;
        Tue, 26 Jan 2021 21:46:19 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 145sm840907pge.88.2021.01.26.21.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 21:46:18 -0800 (PST)
Date: Tue, 26 Jan 2021 21:46:18 -0800 (PST)
X-Google-Original-Date: Tue, 26 Jan 2021 21:46:11 PST (-0800)
Subject: Re: [PATCH v15 03/11] riscv/Kconfig: make direct map manipulation options depend on MMU
In-Reply-To: <20210123110041.GE6332@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: rppt@kernel.org
Message-ID: <mhng-0c84abc1-8ac8-4142-be1c-a269d8b345f8@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Message-ID-Hash: 7GOHRW3AQWLQUCGECXII7F5C6ATXOAPM
X-Message-ID-Hash: 7GOHRW3AQWLQUCGECXII7F5C6ATXOAPM
X-MailFrom: palmer@dabbelt.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, luto@kernel.org, Arnd Bergmann <arnd@arndb.de>, bp@alien8.de, catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com, david@redhat.com, elena.reshetova@intel.com, hpa@zytor.com, mingo@redhat.com, jejb@linux.ibm.com, kirill@shutemov.name, willy@infradead.org, mark.rutland@arm.com, rppt@linux.ibm.com, mtk.manpages@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>, peterz@infradead.org, rick.p.edgecombe@intel.com, guro@fb.com, shakeelb@google.com, shuah@kernel.org, tglx@linutronix.de, tycho@tycho.ws, will@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, lkp@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7GOHRW3AQWLQUCGECXII7F5C6ATXOAPM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On Sat, 23 Jan 2021 03:00:41 PST (-0800), rppt@kernel.org wrote:
> On Fri, Jan 22, 2021 at 08:12:30PM -0800, Palmer Dabbelt wrote:
>> On Wed, 20 Jan 2021 10:06:04 PST (-0800), rppt@kernel.org wrote:
>> > From: Mike Rapoport <rppt@linux.ibm.com>
>> >
>> > ARCH_HAS_SET_DIRECT_MAP and ARCH_HAS_SET_MEMORY configuration options have
>> > no meaning when CONFIG_MMU is disabled and there is no point to enable them
>> > for the nommu case.
>> >
>> > Add an explicit dependency on MMU for these options.
>> >
>> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> > Reported-by: kernel test robot <lkp@intel.com>
>> > ---
>> >  arch/riscv/Kconfig | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index d82303dcc6b6..d35ce19ab1fa 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -25,8 +25,8 @@ config RISCV
>> >  	select ARCH_HAS_KCOV
>> >  	select ARCH_HAS_MMIOWB
>> >  	select ARCH_HAS_PTE_SPECIAL
>> > -	select ARCH_HAS_SET_DIRECT_MAP
>> > -	select ARCH_HAS_SET_MEMORY
>> > +	select ARCH_HAS_SET_DIRECT_MAP if MMU
>> > +	select ARCH_HAS_SET_MEMORY if MMU
>> >  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
>> >  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>> >  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>>
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> LMK if you want this to go in via the RISC-V tree, otherwise I'm going to
>> assume it's going in along with the rest of these.  FWIW I see these in other
>> architectures without the MMU guard.
>
> Except arm, they all always have MMU=y and arm selects only
> ARCH_HAS_SET_MEMORY and has empty stubs for those when MMU=n.

OK, maybe I just checked ARM, then.  I was just making sure.

> Indeed I might have been over zealous adding ARCH_HAS_SET_MEMORY dependency
> on MMU, as riscv also has these stubs, but I thought that making this
> explicit is a nice thing.

It seems reasonable to me.

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

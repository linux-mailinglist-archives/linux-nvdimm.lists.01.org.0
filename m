Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C77BD3014CE
	for <lists+linux-nvdimm@lfdr.de>; Sat, 23 Jan 2021 12:01:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED288100EB34A;
	Sat, 23 Jan 2021 03:01:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 89AB7100ED480
	for <linux-nvdimm@lists.01.org>; Sat, 23 Jan 2021 03:01:04 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C54F233FC;
	Sat, 23 Jan 2021 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1611399663;
	bh=HKE6o3YvB1B4tteaWRG6KFCwQvpwQVukHCQUNVVJeeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKYTq7yJigGOEK8nATV4Dx0NmxniF8qJvpM8DaATKPfSpcwbXynIkCA3n3qe4gShc
	 P58WaSyJhlAC3agVkClm43lT0PT5xZ4J7SJtjlWxMDPo7Z7TJ5vikccGijHyX6Qk3T
	 csEAYzaE2dNiGaDYQSUa2ZRjDbWeimlY9AxOUezkEDzB+tFxoT4KWyZ3/mHJ42y/5p
	 pqq7kjj0H57u727QxLS0KIbNm35ZWU+0trHV9uXECzkWMwPCcm0Vf+ufzHv9e+UsoG
	 s6KF8VZU223mQTNtDCDxNRjB/Glv/5nT7EoghwQyPT8tKfrFHn5E34OlgLb+jD+RQt
	 FTlyibQtHA2wA==
Date: Sat, 23 Jan 2021 13:00:41 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v15 03/11] riscv/Kconfig: make direct map manipulation
 options depend on MMU
Message-ID: <20210123110041.GE6332@kernel.org>
References: <20210120180612.1058-4-rppt@kernel.org>
 <mhng-5cbc9b30-ac9a-4748-bf12-8f0de4c89f79@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <mhng-5cbc9b30-ac9a-4748-bf12-8f0de4c89f79@palmerdabbelt-glaptop>
Message-ID-Hash: TGPOQJAZFD4CIQ47QYU6NXO5TIGFX5DR
X-Message-ID-Hash: TGPOQJAZFD4CIQ47QYU6NXO5TIGFX5DR
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, luto@kernel.org, Arnd Bergmann <arnd@arndb.de>, bp@alien8.de, catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com, david@redhat.com, elena.reshetova@intel.com, hpa@zytor.com, mingo@redhat.com, jejb@linux.ibm.com, kirill@shutemov.name, willy@infradead.org, mark.rutland@arm.com, rppt@linux.ibm.com, mtk.manpages@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>, peterz@infradead.org, rick.p.edgecombe@intel.com, guro@fb.com, shakeelb@google.com, shuah@kernel.org, tglx@linutronix.de, tycho@tycho.ws, will@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, lkp@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TGPOQJAZFD4CIQ47QYU6NXO5TIGFX5DR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 22, 2021 at 08:12:30PM -0800, Palmer Dabbelt wrote:
> On Wed, 20 Jan 2021 10:06:04 PST (-0800), rppt@kernel.org wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > ARCH_HAS_SET_DIRECT_MAP and ARCH_HAS_SET_MEMORY configuration options have
> > no meaning when CONFIG_MMU is disabled and there is no point to enable them
> > for the nommu case.
> > 
> > Add an explicit dependency on MMU for these options.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  arch/riscv/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d82303dcc6b6..d35ce19ab1fa 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -25,8 +25,8 @@ config RISCV
> >  	select ARCH_HAS_KCOV
> >  	select ARCH_HAS_MMIOWB
> >  	select ARCH_HAS_PTE_SPECIAL
> > -	select ARCH_HAS_SET_DIRECT_MAP
> > -	select ARCH_HAS_SET_MEMORY
> > +	select ARCH_HAS_SET_DIRECT_MAP if MMU
> > +	select ARCH_HAS_SET_MEMORY if MMU
> >  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
> >  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> >  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> LMK if you want this to go in via the RISC-V tree, otherwise I'm going to
> assume it's going in along with the rest of these.  FWIW I see these in other
> architectures without the MMU guard.

Except arm, they all always have MMU=y and arm selects only
ARCH_HAS_SET_MEMORY and has empty stubs for those when MMU=n.

Indeed I might have been over zealous adding ARCH_HAS_SET_MEMORY dependency
on MMU, as riscv also has these stubs, but I thought that making this
explicit is a nice thing.
 
> Thanks!

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

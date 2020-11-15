Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B022B32FF
	for <lists+linux-nvdimm@lfdr.de>; Sun, 15 Nov 2020 09:46:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C488D100EF26F;
	Sun, 15 Nov 2020 00:45:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 64ED1100EF26E
	for <linux-nvdimm@lists.01.org>; Sun, 15 Nov 2020 00:45:55 -0800 (PST)
Received: from kernel.org (unknown [77.125.7.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AC352223FB;
	Sun, 15 Nov 2020 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1605429954;
	bh=I2e6oiG56Ipc+LYVEf48Tzpdu9e5X2SPeAjMkXGJ+FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvUrkC8DbWSBeGtX5LmBQbQw3erYKhs5cOaKJid6GDJMPM7nXXubIxoNcBB3oGNe7
	 rCwIs49LamtntTc1amgIjfXRya2sb8UfoqlV6jooN7E3J+NN/S80wRZL4M8ZXWanKD
	 tXrCqT3L+M5TGE/FDZPfoLrZTF0AQQmH6gi3Hxpk=
Date: Sun, 15 Nov 2020 10:45:39 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 4/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201115084539.GU4758@kernel.org>
References: <20201110151444.20662-1-rppt@kernel.org>
 <20201110151444.20662-5-rppt@kernel.org>
 <20201113140656.GG17076@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201113140656.GG17076@casper.infradead.org>
Message-ID-Hash: IBHF3DZGQU6JJQH5PGD63AUVKC5N2774
X-Message-ID-Hash: IBHF3DZGQU6JJQH5PGD63AUVKC5N2774
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.ker
 nel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IBHF3DZGQU6JJQH5PGD63AUVKC5N2774/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 13, 2020 at 02:06:56PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 10, 2020 at 05:14:39PM +0200, Mike Rapoport wrote:
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index c89c5444924b..d8d170fa5210 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -884,4 +884,7 @@ config ARCH_HAS_HUGEPD
> >  config MAPPING_DIRTY_HELPERS
> >          bool
> >  
> > +config SECRETMEM
> > +	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> 
> So I now have to build this in, whether I want it or not?

Why wouldn't anybody want this nice feature? ;-)

Now, seriously, I hesitated a lot about having a prompt here, but in the
end I've decided to go without it.

The added footprint is not so big, with x86 defconfig it's less than 8K
and with distro (I've checked with Fedora) config the difference is less
than 1k because they anyway have CMA=y.

As this is "security" feature, disros most probably would have this
enabled anyway, and I believe users that will see something like "Allow
hiding memory from the kernel" will hit Y there.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

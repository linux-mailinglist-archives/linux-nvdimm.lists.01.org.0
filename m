Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA98249C01
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 13:43:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 988FC134F0B79;
	Wed, 19 Aug 2020 04:42:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E3136134D27CC
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 04:42:56 -0700 (PDT)
Received: from kernel.org (unknown [87.70.91.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AB23E206FA;
	Wed, 19 Aug 2020 11:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597837376;
	bh=oRLqxLOhAk2wnqABtg3LIfVpl96FyLYFzASr1U/ua+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Z9IophMNzk8pDJ8BdCg/mK2k2gQuqV8UM0qQAmx+Sn6zj919AK6cSjrUfOGKNQT4
	 FgdC+v6CR36y9JK0bGfz3O20UZlSub/rKj1DDNqRtiGiQklQFxbD8gym7lAVbdhBXm
	 bYUybp6KP1/X0bvM8WCYlmLMym+12jW5T0ZamYZo=
Date: Wed, 19 Aug 2020 14:42:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200819114244.GT752365@kernel.org>
References: <20200818141554.13945-1-rppt@kernel.org>
 <e82ca20e-a88e-d7ff-e99b-4189aac54f3a@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e82ca20e-a88e-d7ff-e99b-4189aac54f3a@redhat.com>
Message-ID-Hash: 5DYBOH25CHW54G3T6QE5F65X2H3QBULP
X-Message-ID-Hash: 5DYBOH25CHW54G3T6QE5F65X2H3QBULP
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.o
 rg, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5DYBOH25CHW54G3T6QE5F65X2H3QBULP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 19, 2020 at 12:47:54PM +0200, David Hildenbrand wrote:
> On 18.08.20 16:15, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > This is an implementation of "secret" mappings backed by a file descriptor. 
> > 
> > v4 changes:
> > * rebase on v5.9-rc1
> > * Do not redefine PMD_PAGE_ORDER in fs/dax.c, thanks Kirill
> > * Make secret mappings exclusive by default and only require flags to
> >   memfd_secret() system call for uncached mappings, thanks again Kirill :)
> > 
> > v3 changes:
> > * Squash kernel-parameters.txt update into the commit that added the
> >   command line option.
> > * Make uncached mode explicitly selectable by architectures. For now enable
> >   it only on x86.
> > 
> > v2 changes:
> > * Follow Michael's suggestion and name the new system call 'memfd_secret'
> > * Add kernel-parameters documentation about the boot option
> > * Fix i386-tinyconfig regression reported by the kbuild bot.
> >   CONFIG_SECRETMEM now depends on !EMBEDDED to disable it on small systems
> >   from one side and still make it available unconditionally on
> >   architectures that support SET_DIRECT_MAP.
> > 
> > 
> > The file descriptor backing secret memory mappings is created using a
> > dedicated memfd_secret system call The desired protection mode for the
> > memory is configured using flags parameter of the system call. The mmap()
> > of the file descriptor created with memfd_secret() will create a "secret"
> > memory mapping. The pages in that mapping will be marked as not present in
> > the direct map and will have desired protection bits set in the user page
> > table. For instance, current implementation allows uncached mappings.
> > 
> > Although normally Linux userspace mappings are protected from other users, 
> > such secret mappings are useful for environments where a hostile tenant is
> > trying to trick the kernel into giving them access to other tenants
> > mappings.
> > 
> > Additionally, the secret mappings may be used as a mean to protect guest
> > memory in a virtual machine host.
> > 
> 
> Just a general question. I assume such pages (where the direct mapping
> was changed) cannot get migrated - I can spot a simple alloc_page(). So
> essentially a process can just allocate a whole bunch of memory that is
> unmovable, correct? Is there any limit? Is it properly accounted towards
> the process (memctl) ?

The memory as accounted in the same way like with mlock(), so normal
user won't be able to allocate more than RLIMIT_MEMLOCK.

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

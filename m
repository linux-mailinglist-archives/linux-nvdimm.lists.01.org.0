Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277027CE63
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Sep 2020 15:05:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 558E3153EB254;
	Tue, 29 Sep 2020 06:05:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3C952152CC040
	for <linux-nvdimm@lists.01.org>; Tue, 29 Sep 2020 06:05:47 -0700 (PDT)
Received: from kernel.org (unknown [87.71.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4CD4820848;
	Tue, 29 Sep 2020 13:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601384746;
	bh=w8jEjdPVhwgAP8ieOGmZq7rvrkzmFW13pl6Bcj/9DDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YfoO9Oo/YwKl80W7Ps/3xh0cfYEHin8QOUrn/iFqhLYw+b2DAWHKu9Y+mnqgIAACA
	 uQkYtRdB+liRGsxjQlUpAtvTPmGTHbQnf35XbZMDwXCeXkiEteBW7/GT/3ZbUZnHCL
	 kuQnBbyQK81Mz6jqRSLbGj/2AcjW0JSpMYmSqJQw=
Date: Tue, 29 Sep 2020 16:05:29 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200929130529.GE2142832@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
Message-ID-Hash: ABK7STUD2XE3BRUVUIWP7NNZRO2RRPLF
X-Message-ID-Hash: ABK7STUD2XE3BRUVUIWP7NNZRO2RRPLF
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linu
 x-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ABK7STUD2XE3BRUVUIWP7NNZRO2RRPLF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 25, 2020 at 09:41:25AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 24, 2020 at 04:29:03PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Removing a PAGE_SIZE page from the direct map every time such page is
> > allocated for a secret memory mapping will cause severe fragmentation of
> > the direct map. This fragmentation can be reduced by using PMD-size pages
> > as a pool for small pages for secret memory mappings.
> > 
> > Add a gen_pool per secretmem inode and lazily populate this pool with
> > PMD-size pages.
> 
> What's the actual efficacy of this? Since the pmd is per inode, all I
> need is a lot of inodes and we're in business to destroy the directmap,
> no?
> 
> Afaict there's no privs needed to use this, all a process needs is to
> stay below the mlock limit, so a 'fork-bomb' that maps a single secret
> page will utterly destroy the direct map.

This indeed will cause 1G pages in the direct map to be split into 2M
chunks, but I disagree with 'destroy' term here. Citing the cover letter
of an earlier version of this series:

  I've tried to find some numbers that show the benefit of using larger
  pages in the direct map, but I couldn't find anything so I've run a
  couple of benchmarks from phoronix-test-suite on my laptop (i7-8650U
  with 32G RAM).
  
  I've tested three variants: the default with 28G of the physical
  memory covered with 1G pages, then I disabled 1G pages using
  "nogbpages" in the kernel command line and at last I've forced the
  entire direct map to use 4K pages using a simple patch to
  arch/x86/mm/init.c.  I've made runs of the benchmarks with SSD and
  tmpfs.
  
  Surprisingly, the results does not show huge advantage for large
  pages. For instance, here the results for kernel build with
  'make -j8', in seconds:
  
                        |  1G    |  2M    |  4K
  ----------------------+--------+--------+---------
  ssd, mitigations=on	| 308.75 | 317.37 | 314.9
  ssd, mitigations=off	| 305.25 | 295.32 | 304.92
  ram, mitigations=on	| 301.58 | 322.49 | 306.54
  ram, mitigations=off	| 299.32 | 288.44 | 310.65
  
  All the results I have are available here:
 
  https://docs.google.com/spreadsheets/d/1tdD-cu8e93vnfGsTFxZ5YdaEfs2E1GELlvWNOGkJV2U/edit?usp=sharing

The numbers suggest that using smaller pages in the direct map does not
necessarily leads to performance degradation and some runs produced
better results with smaller pages in the direct map.

> I really don't like this, at all.
> 
> IIRC Kirill looked at merging the directmap. I think he ran into
> performance issues there, but we really need something like that before
> something like this lands.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

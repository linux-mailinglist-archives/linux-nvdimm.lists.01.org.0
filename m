Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB60B27EBED
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 17:10:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D3E301519864D;
	Wed, 30 Sep 2020 08:10:13 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BF2781519864C
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5MQ9wWjMl2wFlC5FFeBBoGdxqFKxERQlgHCfOe6SJqc=; b=BuH49sEnpXdPdqBuzbVs2V633x
	nj0QNsnZGyV7Ur1XjcD+GgLOUPiioSSgYAd5LQANsJHnqdR8DPJWazR4b6fyMIXitNoG7i2qACEk+
	x90zdteFRAk01MpO/bR6H/INrJI1XI2Z43TfeD0w4o67kW8JKU7F7v72SRgVVditUoo8hvSGVzDht
	IAsFpsrXy2rohggWiPlFlZ49/3gB8uDSMyALzcjv+0EyTng6cu9mrYkRLaKyDQJSYJSgaeqtXpg7T
	r4qwLvOvtVk6qnTcZdu5tJ+aiAkiq/I/XPzY9EzutGsKlZpzzVHG+lZEakQO08fZJbB9Z3UwWnHbB
	qlCH3W+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNdjU-0007EC-6u; Wed, 30 Sep 2020 15:09:28 +0000
Date: Wed, 30 Sep 2020 16:09:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200930150928.GR20115@casper.infradead.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <20200929130529.GE2142832@kernel.org>
 <20200929141216.GO2628@hirez.programming.kicks-ass.net>
 <20200929145813.GA3226834@linux.ibm.com>
 <20200929151552.GS2628@hirez.programming.kicks-ass.net>
 <20200930102745.GC3226834@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930102745.GC3226834@linux.ibm.com>
Message-ID-Hash: WD4ODP22ZJDJMLI7AVUZJ247WUC5Y62T
X-Message-ID-Hash: WD4ODP22ZJDJMLI7AVUZJ247WUC5Y62T
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Peter Zijlstra <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-
 arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WD4ODP22ZJDJMLI7AVUZJ247WUC5Y62T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 30, 2020 at 01:27:45PM +0300, Mike Rapoport wrote:
> On Tue, Sep 29, 2020 at 05:15:52PM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 29, 2020 at 05:58:13PM +0300, Mike Rapoport wrote:
> > > On Tue, Sep 29, 2020 at 04:12:16PM +0200, Peter Zijlstra wrote:
> > 
> > > > It will drop them down to 4k pages. Given enough inodes, and allocating
> > > > only a single sekrit page per pmd, we'll shatter the directmap into 4k.
> > > 
> > > Why? Secretmem allocates PMD-size page per inode and uses it as a pool
> > > of 4K pages for that inode. This way it ensures that
> > > __kernel_map_pages() is always called on PMD boundaries.
> > 
> > Oh, you unmap the 2m page upfront? I read it like you did the unmap at
> > the sekrit page alloc, not the pool alloc side of things.
> > 
> > Then yes, but then you're wasting gobs of memory. Basically you can pin
> > 2M per inode while only accounting a single page.
> 
> Right, quite like THP :)

Huh?  THP accounts every page it allocates.  If you allocate 2MB,
it accounts 512 pages.  And THP are reclaimable by vmscan, this is
obviously not.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

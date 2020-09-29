Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA2A27D288
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Sep 2020 17:16:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D022D1535B41F;
	Tue, 29 Sep 2020 08:16:17 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6A392149D9082
	for <linux-nvdimm@lists.01.org>; Tue, 29 Sep 2020 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rt/gWACyTIQuj5nIeNUdzNcwr8s1YVFasvFCFOsspG0=; b=C1EjOj6Mt1xdWZh3XPn8rkOVq0
	OxLNUps2Qyz7f+SRn0b0qVlwpJY3G1qjZJrXsr79+xSJN576WRyGRCJBvE33ahL+K3bAl6J52zeHS
	wSJqYA3kcEN4r81o5iv8mrkQNdTtpmXlgU0m94t4jobUJQw63e2MEofWlPsisf6M5B5+P7V7uo9JR
	L+B8gNbZ5jGR4O4c1ouioTzYDVNXI11/fjGCnBu9osfq4flDd/ZImbGrL1Nb/QcxcZUrcloACztpk
	f+A0BvS7dJrAKnyy1KN+GuPecThd5yRmSmk4dIzSCm/hex1K24N5dt/nnCwUMW+yOhjXGoH3qt8AN
	HBl2N0ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNHMC-0000zG-2k; Tue, 29 Sep 2020 15:15:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 191E5300F7A;
	Tue, 29 Sep 2020 17:15:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 004CF210E84D8; Tue, 29 Sep 2020 17:15:52 +0200 (CEST)
Date: Tue, 29 Sep 2020 17:15:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200929151552.GS2628@hirez.programming.kicks-ass.net>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <20200929130529.GE2142832@kernel.org>
 <20200929141216.GO2628@hirez.programming.kicks-ass.net>
 <20200929145813.GA3226834@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200929145813.GA3226834@linux.ibm.com>
Message-ID-Hash: OX5OSMLTRMVZ4C3BXYQZJD7SEYG5H6KQ
X-Message-ID-Hash: OX5OSMLTRMVZ4C3BXYQZJD7SEYG5H6KQ
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-a
 rm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OX5OSMLTRMVZ4C3BXYQZJD7SEYG5H6KQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 29, 2020 at 05:58:13PM +0300, Mike Rapoport wrote:
> On Tue, Sep 29, 2020 at 04:12:16PM +0200, Peter Zijlstra wrote:

> > It will drop them down to 4k pages. Given enough inodes, and allocating
> > only a single sekrit page per pmd, we'll shatter the directmap into 4k.
> 
> Why? Secretmem allocates PMD-size page per inode and uses it as a pool
> of 4K pages for that inode. This way it ensures that
> __kernel_map_pages() is always called on PMD boundaries.

Oh, you unmap the 2m page upfront? I read it like you did the unmap at
the sekrit page alloc, not the pool alloc side of things.

Then yes, but then you're wasting gobs of memory. Basically you can pin
2M per inode while only accounting a single page.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

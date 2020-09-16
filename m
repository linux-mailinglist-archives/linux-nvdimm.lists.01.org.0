Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BE626CF86
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 01:20:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0CD9E14542DF7;
	Wed, 16 Sep 2020 16:20:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3C1BB14542DF5
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 16:20:24 -0700 (PDT)
Received: from X1 (unknown [67.22.170.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AA81722205;
	Wed, 16 Sep 2020 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600298423;
	bh=g39pvrmQ7hfk10VvG24PcSf7yUXQxh3QrCaIs2OFPxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GGy3cWrY1KWygiIV+LN8jdTlPMczqnmnOowS6kdzNzT02rztNefpmWOud0sB5DuhW
	 tYPB2wewkh27YeY5ELsjeG6otz7U7l9BXGGjwZ40yc/FJb39YCYRFP4SKYro0qWLdA
	 08KKQW84Cld8I364URHf5f0fJMPvSvi2987Kgz9w=
Date: Wed, 16 Sep 2020 16:20:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-Id: <20200916162020.0d68c2bd6711024cfcaa8bd7@linux-foundation.org>
In-Reply-To: <20200916073539.3552-1-rppt@kernel.org>
References: <20200916073539.3552-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: DAALTM5KTSVB4INGCY2MZ5MP3Z7R2TAQ
X-Message-ID-Hash: DAALTM5KTSVB4INGCY2MZ5MP3Z7R2TAQ
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, l
 inux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DAALTM5KTSVB4INGCY2MZ5MP3Z7R2TAQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2020 10:35:34 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> This is an implementation of "secret" mappings backed by a file descriptor. 
> I've dropped the boot time reservation patch for now as it is not strictly
> required for the basic usage and can be easily added later either with or
> without CMA.

It seems early days for this, especially as regards reviewer buyin. 
But I'll toss it in there to get it some additional testing.

A test suite in tools/testging/selftests/ would be helpful, especially
for arch maintainers.

I assume that user-facing manpage alterations are planned?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

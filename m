Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3654D277DF5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 04:34:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BDB813D00029;
	Thu, 24 Sep 2020 19:34:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 274F613D00022
	for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 19:34:31 -0700 (PDT)
Received: from X1 (unknown [104.245.68.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 6CF7620888;
	Fri, 25 Sep 2020 02:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601001271;
	bh=Smg4DQZKLT8m1LXboOjRbYbEEA4933QtuIJr9GOx1d4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t2Am+bOL7aQc+oLElXbYFnp8Y1wlGgthaRTiSGvzkHwzblFnwyTLhHkGuKwh6cPPK
	 dGNyh6ea1G8zhcYz+2jZ/HAlJJzZS2Hb5uMncrKXCFHO9WgB/ShnWeWBcyoD4aVexB
	 fTMs8EfOHnI33GKShzqA790tDOYNu8QPGgMsLH84=
Date: Thu, 24 Sep 2020 19:34:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-Id: <20200924193428.6642e0cc3436bb67ddf8024a@linux-foundation.org>
In-Reply-To: <20200924132904.1391-1-rppt@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: NPWY54MZQJUOKS7NJJEFUHVATKLO5Q2E
X-Message-ID-Hash: NPWY54MZQJUOKS7NJJEFUHVATKLO5Q2E
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-ar
 m-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NPWY54MZQJUOKS7NJJEFUHVATKLO5Q2E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2020 16:28:58 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> This is an implementation of "secret" mappings backed by a file descriptor. 
> I've dropped the boot time reservation patch for now as it is not strictly
> required for the basic usage and can be easily added later either with or
> without CMA.
> 
> ...
> 
> The file descriptor backing secret memory mappings is created using a
> dedicated memfd_secret system call The desired protection mode for the
> memory is configured using flags parameter of the system call. The mmap()
> of the file descriptor created with memfd_secret() will create a "secret"
> memory mapping. The pages in that mapping will be marked as not present in
> the direct map and will have desired protection bits set in the user page
> table. For instance, current implementation allows uncached mappings.
> 
> Although normally Linux userspace mappings are protected from other users, 
> such secret mappings are useful for environments where a hostile tenant is
> trying to trick the kernel into giving them access to other tenants
> mappings.
> 
> Additionally, the secret mappings may be used as a mean to protect guest
> memory in a virtual machine host.
> 
> For demonstration of secret memory usage we've created a userspace library
> [1] that does two things: the first is act as a preloader for openssl to

I can find no [1].

I'm not a fan of the enumerated footnote thing.  Why not inline the url
right here so readers don't need to jump around?

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

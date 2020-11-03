Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B50262A46F2
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 14:52:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97BFE1652CDFD;
	Tue,  3 Nov 2020 05:52:27 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=80.241.56.172; helo=mout-p-202.mailbox.org; envelope-from=hagen@jauu.net; receiver=<UNKNOWN> 
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 844191652CDFD
	for <linux-nvdimm@lists.01.org>; Tue,  3 Nov 2020 05:52:25 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4CQWS671PfzQkKw;
	Tue,  3 Nov 2020 14:52:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
	by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
	with ESMTP id FlqcKCn97r9e; Tue,  3 Nov 2020 14:52:18 +0100 (CET)
Date: Tue, 3 Nov 2020 14:52:14 +0100 (CET)
From: Hagen Paul Pfeifer <hagen@jauu.net>
To: Mike Rapoport <rppt@kernel.org>
Message-ID: <1547601988.128687.1604411534845@office.mailbox.org>
In-Reply-To: <20201102154028.GD4879@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20201101110935.GA4105325@laniakea> <20201102154028.GD4879@kernel.org>
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -0.65 / 15.00 / 15.00
X-Rspamd-Queue-Id: D612C1723
X-Rspamd-UID: 9101f0
Message-ID-Hash: LTJRMML6UCMCIDA3EZOZKHZ5GIVFUCAC
X-Message-ID-Hash: LTJRMML6UCMCIDA3EZOZKHZ5GIVFUCAC
X-MailFrom: hagen@jauu.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kerne
 l.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LTJRMML6UCMCIDA3EZOZKHZ5GIVFUCAC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On 11/02/2020 4:40 PM Mike Rapoport <rppt@kernel.org> wrote:

> > Isn't memfd_secret currently *unnecessarily* designed to be a "one task
> > feature"? memfd_secret fulfills exactly two (generic) features:
> > 
> > - address space isolation from kernel (aka SECRET_EXCLUSIVE, not in kernel's
> >   direct map) - hide from kernel, great
> > - disabling processor's memory caches against speculative-execution vulnerabilities
> >   (spectre and friends, aka SECRET_UNCACHED), also great
> > 
> > But, what about the following use-case: implementing a hardened IPC mechanism
> > where even the kernel is not aware of any data and optionally via SECRET_UNCACHED
> > even the hardware caches are bypassed! With the patches we are so close to
> > achieving this.
> > 
> > How? Shared, SECRET_EXCLUSIVE and SECRET_UNCACHED mmaped pages for IPC
> > involved tasks required to know this mapping (and memfd_secret fd). After IPC
> > is done, tasks can copy sensitive data from IPC pages into memfd_secret()
> > pages, un-sensitive data can be used/copied everywhere.
> 
> As long as the task share the file descriptor, they can share the
> secretmem pages, pretty much like normal memfd.

Including process_vm_readv() and process_vm_writev()? Let's take a hypothetical
"dbus-daemon-secure" service that receives data from process A and wants to
copy/distribute it to data areas of N other processes. Much like dbus but without
SOCK_DGRAM rather direct copy into secretmem/mmap pages (ring-buffer). Should be
possible, right?

> > One missing piece is still the secure zeroization of the page(s) if the
> > mapping is closed by last process to guarantee a secure cleanup. This can
> > probably done as an general mmap feature, not coupled to memfd_secret() and
> > can be done independently ("reverse" MAP_UNINITIALIZED feature).
> 
> There are "init_on_alloc" and "init_on_free" kernel parameters that
> enable zeroing of the pages on alloc and on free globally.
> Anyway, I'll add zeroing of the freed memory to secretmem.

Great, this allows page-specific (thus runtime-performance-optimized) zeroing
of secured pages. init_on_free lowers the performance to much and is not precice
enough.

Hagen
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

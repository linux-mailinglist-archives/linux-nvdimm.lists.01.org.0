Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53D32A2E76
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Nov 2020 16:40:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2280016302AAF;
	Mon,  2 Nov 2020 07:40:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 59216162B9E66
	for <linux-nvdimm@lists.01.org>; Mon,  2 Nov 2020 07:40:42 -0800 (PST)
Received: from kernel.org (unknown [87.71.17.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 202C12222B;
	Mon,  2 Nov 2020 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604331641;
	bh=JULj2YQjQ3lL8L8mphnth/XMQ+6I1NJ7oIH3/fDK0iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0o11Hfll3daQtruT1vsISN+BbHP9yaMYQE4FQMEMibOkJCKqnhjRxA+eho5Laarv
	 OhRwtWZyY8Wy3q5T3/CRffMJ7SInY7t/Bd/Gdm1eHv/y6zMnVypYr0S7YhVNWRGAWn
	 75tM+sdcYEOnYl8dKrbNCJbF2bUOfaK/T5JUAaOI=
Date: Mon, 2 Nov 2020 17:40:28 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201102154028.GD4879@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20201101110935.GA4105325@laniakea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201101110935.GA4105325@laniakea>
Message-ID-Hash: HUIJBBGDQN2LIYB5UL7KDIEACKACVLKG
X-Message-ID-Hash: HUIJBBGDQN2LIYB5UL7KDIEACKACVLKG
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kerne
 l.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HUIJBBGDQN2LIYB5UL7KDIEACKACVLKG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 01, 2020 at 12:09:35PM +0100, Hagen Paul Pfeifer wrote:
> * Mike Rapoport | 2020-09-24 16:28:58 [+0300]:
> 
> >This is an implementation of "secret" mappings backed by a file descriptor. 
> >I've dropped the boot time reservation patch for now as it is not strictly
> >required for the basic usage and can be easily added later either with or
> >without CMA.
> 
> Isn't memfd_secret currently *unnecessarily* designed to be a "one task
> feature"? memfd_secret fulfills exactly two (generic) features:
> 
> - address space isolation from kernel (aka SECRET_EXCLUSIVE, not in kernel's
>   direct map) - hide from kernel, great
> - disabling processor's memory caches against speculative-execution vulnerabilities
>   (spectre and friends, aka SECRET_UNCACHED), also great
> 
> But, what about the following use-case: implementing a hardened IPC mechanism
> where even the kernel is not aware of any data and optionally via SECRET_UNCACHED
> even the hardware caches are bypassed! With the patches we are so close to
> achieving this.
> 
> How? Shared, SECRET_EXCLUSIVE and SECRET_UNCACHED mmaped pages for IPC
> involved tasks required to know this mapping (and memfd_secret fd). After IPC
> is done, tasks can copy sensitive data from IPC pages into memfd_secret()
> pages, un-sensitive data can be used/copied everywhere.

As long as the task share the file descriptor, they can share the
secretmem pages, pretty much like normal memfd.

> One missing piece is still the secure zeroization of the page(s) if the
> mapping is closed by last process to guarantee a secure cleanup. This can
> probably done as an general mmap feature, not coupled to memfd_secret() and
> can be done independently ("reverse" MAP_UNINITIALIZED feature).

There are "init_on_alloc" and "init_on_free" kernel parameters that
enable zeroing of the pages on alloc and on free globally.
Anyway, I'll add zeroing of the freed memory to secretmem.

> PS: thank you Mike for your effort!
> 
> See the following pseudo-code as an example:
> 
> 
> // simple assume file-descriptor and mapping is inherited
> // by child for simplicity, ptr is 
> int fd = memfd_secret(SECRETMEM_UNCACHED);
> ftruncate(fd, PAGE_SIZE);
> uint32_t *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
The ptr here will be visible to both parent and child.

> pid_t pid_other;
> 
> void signal_handler(int sig)
> {
> 	// update IPC data on shared, uncachaed, exclusive mapped page
> 	*ptr += 1;
> 	// inform other
> 	sleep(1);
> 	kill(pid_other, SIGUSR1);
> }
> 
> void ipc_loop(void)
> {
> 	signal(SIGUSR1, signal_handler);
> 	while (1) {
> 		sleep(1);
> 	}
> }
> 
> int main(void)
> {
> 	pid_t child_pid;
> 
> 	switch (child_pid = fork()) {
> 	case 0:
> 		pid_other = getppid();
> 		break;
> 	default:
> 		pid_other = child_pid
> 		break;
> 	}
> 	
> 	ipc_loop();
> }
> 
> 
> Hagen
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A762C0ECC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Nov 2020 16:28:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA2A3100EBBBF;
	Mon, 23 Nov 2020 07:28:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D3DC1100EF24E
	for <linux-nvdimm@lists.01.org>; Mon, 23 Nov 2020 07:28:39 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 2002320782
	for <linux-nvdimm@lists.01.org>; Mon, 23 Nov 2020 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1606145319;
	bh=brIo8Xk+cpg0T6s0IpQa46LwLk4mVPqFLLwG7n90WGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NQZmlnHOZiaM7ybcSwWzusNQy1pIzNLZhcrN2FxiI5VI77KySCK6gXqHvbc4GeRrP
	 YSCkK4YhIEwNNqxjz0cYUoQdSP0hpYXSadkkeXAKDctf0PJDujPReGf2go++Ttg8qu
	 rA7cZa4607GuG26Tp3k6RmHtRqCHyFe1H0bZsEVY=
Received: by mail-wm1-f53.google.com with SMTP id x22so581220wmc.5
        for <linux-nvdimm@lists.01.org>; Mon, 23 Nov 2020 07:28:39 -0800 (PST)
X-Gm-Message-State: AOAM530i5aNq1ooNIhvqYML4k+AlzsvTboig79iXVz9getkiozbXvHTt
	7gkjs+FGGCXeikrLLNNdRetHzDxsjLzGihClG1tEYw==
X-Google-Smtp-Source: ABdhPJzEhjqlImvathm/jOwbcq17IbRsly+UVqGOW3wf5Zw5ZyQfK4pkOn8rE+oX1x7EWd6oQaZF3bxA3Eqxcxk30tI=
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr24542133wmg.21.1606145315717;
 Mon, 23 Nov 2020 07:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20201123095432.5860-1-rppt@kernel.org>
In-Reply-To: <20201123095432.5860-1-rppt@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 23 Nov 2020 07:28:22 -0800
X-Gmail-Original-Message-ID: <CALCETrXr-9ABs7rzXcCrh1VXn-15AfpwjA6bQA7aU9Ta7DR+bw@mail.gmail.com>
Message-ID: <CALCETrXr-9ABs7rzXcCrh1VXn-15AfpwjA6bQA7aU9Ta7DR+bw@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
To: Mike Rapoport <rppt@kernel.org>
Message-ID-Hash: GUSMFCGPAWP2DBQLY2UENE5KYRV5XDZ6
X-Message-ID-Hash: GUSMFCGPAWP2DBQLY2UENE5KYRV5XDZ6
X-MailFrom: luto@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deac
 on <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-riscv@lists.infradead.org, X86 ML <x86@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GUSMFCGPAWP2DBQLY2UENE5KYRV5XDZ6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 23, 2020 at 1:54 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Hi,
>
> This is an implementation of "secret" mappings backed by a file descriptor.
>
> The file descriptor backing secret memory mappings is created using a
> dedicated memfd_secret system call The desired protection mode for the
> memory is configured using flags parameter of the system call. The mmap()
> of the file descriptor created with memfd_secret() will create a "secret"
> memory mapping. The pages in that mapping will be marked as not present in
> the direct map and will have desired protection bits set in the user page
> table. For instance, current implementation allows uncached mappings.

I'm still not ready to ACK uncached mappings on x86.  I'm fine with
the concept of allowing privileged users to create UC memory on x86
for testing and experimentation, but it's a big can of worms in
general.  The issues that immediately come to mind are:

- Performance and DoS potential.  UC will have bizarre, architecture-
and platform-dependent performance characteristics.  For all I know,
even the access semantics might be architecture dependent.  I'm not
convinced it's possible to write portable code in C using the uncached
feature.  I'm also concerned that certain operation (unaligned locks,
for example, and possibly any locked access) will trigger bus locks on
x86, which, depending on CPU and kernel config will either DoS all
other CPUs or send signals.  (Or cause the hypervisor to terminate or
otherwise penalize the the VM, which would be nasty.)

 - Correctness.  I have reports that different x86 hypervisors do
different things with UC mappings, including treating them as regular
WB mappings.  So the memory type you get out when you ask for
"uncached" might not actually be uncached.

UC is really an MMIO feature, not a "protect my data" feature.
Abusing it to protect data is certainly interesting, but I'm far from
convinced that it's wise.  I'm especially unconvinced that
monkey-patching a program to use uncached memory when it expects
regular malloced memory is a reasonable thing to do.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB373374875
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 May 2021 21:08:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 26DEB100EB33B;
	Wed,  5 May 2021 12:08:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7609100EB334
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 12:08:09 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F53D613BC;
	Wed,  5 May 2021 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1620241689;
	bh=hhpxxXD6aDeVp5ZewAeV19qTR1ebHSAlNlE2Ux5iOSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ug/m3Htuj/0ky54AF8kZ3lyLJYozDhbNWgyIX0TCxQniyIIVskzJR85jb1a8l24+P
	 wj3Uq3KGTcmSyyj8MjENJW/Q1S0V1k1C7Ipr+8QQ7aULrVrbnYhAQH9rFXWSlKHVc9
	 sXdVqWFVybXYIICA46jG/2KrFmKvLuINZAazEgtE=
Date: Wed, 5 May 2021 12:08:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-Id: <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
In-Reply-To: <20210303162209.8609-1-rppt@kernel.org>
References: <20210303162209.8609-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: 76LRK5IKRSMAOTPWUPM6OZXGGXWMT2TZ
X-Message-ID-Hash: 76LRK5IKRSMAOTPWUPM6OZXGGXWMT2TZ
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah 
 Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/76LRK5IKRSMAOTPWUPM6OZXGGXWMT2TZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed,  3 Mar 2021 18:22:00 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> This is an implementation of "secret" mappings backed by a file descriptor.
> 
> The file descriptor backing secret memory mappings is created using a
> dedicated memfd_secret system call The desired protection mode for the
> memory is configured using flags parameter of the system call. The mmap()
> of the file descriptor created with memfd_secret() will create a "secret"
> memory mapping. The pages in that mapping will be marked as not present in
> the direct map and will be present only in the page table of the owning mm.
> 
> Although normally Linux userspace mappings are protected from other users,
> such secret mappings are useful for environments where a hostile tenant is
> trying to trick the kernel into giving them access to other tenants
> mappings.

I continue to struggle with this and I don't recall seeing much
enthusiasm from others.  Perhaps we're all missing the value point and
some additional selling is needed.

Am I correct in understanding that the overall direction here is to
protect keys (and perhaps other things) from kernel bugs?  That if the
kernel was bug-free then there would be no need for this feature?  If
so, that's a bit sad.  But realistic I guess.

Is this intended to protect keys/etc after the attacker has gained the
ability to run arbitrary kernel-mode code?  If so, that seems
optimistic, doesn't it?

I think that a very complete description of the threats which this
feature addresses would be helpful.  
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

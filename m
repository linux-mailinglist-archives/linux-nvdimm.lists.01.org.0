Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C49530C93F
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 19:16:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E992D100EA2C0;
	Tue,  2 Feb 2021 10:16:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9F14E100EA2BF
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 10:16:11 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9084864F92;
	Tue,  2 Feb 2021 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1612289771;
	bh=jExAi6+S0KhwmLELocI6wMJuzz/tLWY8R7yvg8v3kSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDgDXp2MRosyELVG93hsa2FWpra6U+O1s/wok5z4I/qOXv7rdUmjG2axPtMIvq+YN
	 yBgA8wcWgNGCYn0pW2zVsZsv3wcPZETui3XjKumHzFywKHgYsDnq+d0PEjUY80BQCe
	 IzesvjbDuB+UAqmSCfbvnjKvS7w0UCcntNSHwnveAp/98Y5aklQbVLZ5aIeTMaBtIb
	 Y2S9E4/e0RHCm573D5HvZcykwBcZPsiKWKBYdn9Gm25wRz155OpIc0oI5MY1vEx2Z5
	 y6k9c5Z7N9NTPpMQGOvaiK4lasHyvoskCgCDKMvmuqHqWSSfiiKO+c0UX4uuveVSEz
	 Bmm6b/PXs32Ig==
Date: Tue, 2 Feb 2021 20:15:46 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20210202181546.GO242749@kernel.org>
References: <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
 <YBkcyQsky2scjEcP@dhcp22.suse.cz>
 <20210202124857.GN242749@kernel.org>
 <6653288a-dd02-f9de-ef6a-e8d567d71d53@redhat.com>
 <YBlUXdwV93xMIff6@dhcp22.suse.cz>
 <211f0214-1868-a5be-9428-7acfc3b73993@redhat.com>
 <YBlgCl8MQuuII22w@dhcp22.suse.cz>
 <d4fe580a-ef0e-e13f-9ee4-16fb8b6d65dd@redhat.com>
 <YBlicIupOyPF9f3D@dhcp22.suse.cz>
 <95625b83-f7e2-b27a-2b99-d231338047fb@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95625b83-f7e2-b27a-2b99-d231338047fb@redhat.com>
Message-ID-Hash: ZVAST3TD7WP2XW72L6FZZADQYH3QZZAX
X-Message-ID-Hash: ZVAST3TD7WP2XW72L6FZZADQYH3QZZAX
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@suse.com>, James Bottomley <jejb@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Anders
 en <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZVAST3TD7WP2XW72L6FZZADQYH3QZZAX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 02, 2021 at 03:34:29PM +0100, David Hildenbrand wrote:
> On 02.02.21 15:32, Michal Hocko wrote:
> > On Tue 02-02-21 15:26:20, David Hildenbrand wrote:
> > > On 02.02.21 15:22, Michal Hocko wrote:
> > > > On Tue 02-02-21 15:12:21, David Hildenbrand wrote:
> > > > [...]
> > > > > I think secretmem behaves much more like longterm GUP right now
> > > > > ("unmigratable", "lifetime controlled by user space", "cannot go on
> > > > > CMA/ZONE_MOVABLE"). I'd either want to reasonably well control/limit it or
> > > > > make it behave more like mlocked pages.
> > > > 
> > > > I thought I have already asked but I must have forgotten. Is there any
> > > > actual reason why the memory is not movable? Timing attacks?
> > > 
> > > I think the reason is simple: no direct map, no copying of memory.
> > 
> > This is an implementation detail though and not something terribly hard
> > to add on top later on. I was more worried there would be really
> > fundamental reason why this is not possible. E.g. security implications.
> 
> I don't remember all the details. Let's see what Mike thinks regarding
> migration (e.g., security concerns).

Thanks for considering me a security expert :-)

Yet, I cannot estimate how dangerous is the temporal exposure of
this data to the kernel via the direct map in the simple map/copy/unmap
sequence.

More secure way would be to map source and destination in a different page table
rather than in the direct map, similarly to the way text_poke() on x86
does.

I've left the migration callback empty for now because it can be added on
top and its implementation would depend on the way we do (or do not do)
pooling.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

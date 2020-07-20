Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84AB226D71
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 19:47:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CDC96123C8DA1;
	Mon, 20 Jul 2020 10:47:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 867F7123BEBAE
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 10:47:05 -0700 (PDT)
Received: from kernel.org (unknown [87.71.40.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 45F9D20709;
	Mon, 20 Jul 2020 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595267225;
	bh=h7xTJHL3tD3hyqROKlN47q+7JtwYj6iU2IDwcwmnD10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlqRcxTuXQfRrbeqatLbuRaOeADiac4H6X9sEArUzE5oRMfR8PHkKo5MsS8CqIiH2
	 30gUB8awpWvMVLHqbmwCRcCebqbRb3WB5zVyQMWCeasxnsnHVcByE17hsBPHomNYe/
	 2IYK/lsU5KfUy43NS89poYLzWTie5RjpZ+F0ezt8=
Date: Mon, 20 Jul 2020 20:46:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
Message-ID: <20200720174650.GD8593@kernel.org>
References: <20200720092435.17469-1-rppt@kernel.org>
 <20200720092435.17469-4-rppt@kernel.org>
 <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
 <20200720142053.GC8593@kernel.org>
 <CAK8P3a07jAec4hKyNMcha032TT6OXjYHaZZ4Za9ncDsvapeg8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a07jAec4hKyNMcha032TT6OXjYHaZZ4Za9ncDsvapeg8Q@mail.gmail.com>
Message-ID-Hash: QVNWTLDDKMREPBAU473BCS3DJ5D644CI
X-Message-ID-Hash: QVNWTLDDKMREPBAU473BCS3DJ5D644CI
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux 
 FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org, linux-riscv <linux-riscv@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linaro-mm-sig@lists.linaro.org, Sumit Semwal <sumit.semwal@linaro.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QVNWTLDDKMREPBAU473BCS3DJ5D644CI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2020 at 04:34:12PM +0200, Arnd Bergmann wrote:
> On Mon, Jul 20, 2020 at 4:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> > On Mon, Jul 20, 2020 at 01:30:13PM +0200, Arnd Bergmann wrote:
> > > On Mon, Jul 20, 2020 at 11:25 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > >
> > > > Introduce "secretmemfd" system call with the ability to create memory areas
> > > > visible only in the context of the owning process and not mapped not only
> > > > to other processes but in the kernel page tables as well.
> > > >
> > > > The user will create a file descriptor using the secretmemfd system call
> > > > where flags supplied as a parameter to this system call will define the
> > > > desired protection mode for the memory associated with that file
> > > > descriptor. Currently there are two protection modes:
> > > >
> > > > * exclusive - the memory area is unmapped from the kernel direct map and it
> > > >               is present only in the page tables of the owning mm.
> > > > * uncached  - the memory area is present only in the page tables of the
> > > >               owning mm and it is mapped there as uncached.
> > > >
> > > > For instance, the following example will create an uncached mapping (error
> > > > handling is omitted):
> > > >
> > > >         fd = secretmemfd(SECRETMEM_UNCACHED);
> > > >         ftruncate(fd, MAP_SIZE);
> > > >         ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> > > >                    fd, 0);
> > > >
> > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > I wonder if this should be more closely related to dmabuf file
> > > descriptors, which
> > > are already used for a similar purpose: sharing access to secret memory areas
> > > that are not visible to the OS but can be shared with hardware through device
> > > drivers that can import a dmabuf file descriptor.
> >
> > TBH, I didn't think about dmabuf, but my undestanding is that is this
> > case memory areas are not visible to the OS because they are on device
> > memory rather than normal RAM and when dmabuf is backed by the normal
> > RAM, the memory is visible to the OS.
> 
> No, dmabuf is normally about normal RAM that is shared between multiple
> devices, the idea is that you can have one driver allocate a buffer in RAM
> and export it to user space through a file descriptor. The application can then
> go and mmap() it or pass it into one or more other drivers.
> 
> This can be used e.g. for sharing a buffer between a video codec and the
> gpu, or between a crypto engine and another device that accesses
> unencrypted data while software can only observe the encrypted version.

For our usecase sharing is optional from one side and there are no
devices involved from the other.

As James pointed out, there is no match for the userspace API and if
there will emerge a usacase that requires integration of secretmem with
dma-buf, we'll deal with it then.

>        Arnd

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

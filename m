Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE26226234
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 16:34:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C3BB123A842C;
	Mon, 20 Jul 2020 07:34:36 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=212.227.126.130; helo=mout.kundenserver.de; envelope-from=arnd@arndb.de; receiver=<UNKNOWN> 
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15523123A8429
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 07:34:32 -0700 (PDT)
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1McY0L-1kXPSN1zAr-00cy84 for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020
 16:34:30 +0200
Received: by mail-qt1-f182.google.com with SMTP id w27so13129320qtb.7
        for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 07:34:30 -0700 (PDT)
X-Gm-Message-State: AOAM532xh8LnjKVrSdPXxp/uE6lG/EtsYZeSzhwL7iBERNr7jU1iNQ9f
	No8eM9Kc4BjHFStr4jzCFXeDXASvUnuIhhHN+1o=
X-Google-Smtp-Source: ABdhPJwIxgAdvjUjPU+4jzybDNb2QFZAVcL3HMLlxw2RLgRPrBNFIwh83Ml0UJm/YApy5c7tnsKEhhbWEGttCx/g1AI=
X-Received: by 2002:a37:b484:: with SMTP id d126mr21885286qkf.394.1595255668502;
 Mon, 20 Jul 2020 07:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
 <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com> <20200720142053.GC8593@kernel.org>
In-Reply-To: <20200720142053.GC8593@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Jul 2020 16:34:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07jAec4hKyNMcha032TT6OXjYHaZZ4Za9ncDsvapeg8Q@mail.gmail.com>
Message-ID: <CAK8P3a07jAec4hKyNMcha032TT6OXjYHaZZ4Za9ncDsvapeg8Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
To: Mike Rapoport <rppt@kernel.org>
X-Provags-ID: V03:K1:RK7eMrV3EY5IW/nAZdayNyYvn4wwIdQTE67on7V8t91G5fWO3jj
 GPH2y3VubFfvto0YIWQb59m2KCp7/vM7HvBbyc9R94X4tYnA5eZQ1a+Q/xWsUMtpEjrTUQ1
 5KxD+oRRq5a+fiij3YeZ9SDhOyQE2ZIB4bJeWsTMjP8fwvJEVyUXP+8hBBIAi7WYCaNZdaD
 c9zfKMeHIvBd6t/Znofzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TmNg0FRpIMA=:P6w1D1/0V6NMMwbo3rKCkV
 8YV0oTytm7W/u8xSNGhxVj7TbX62c2bI2rI+btq+J/xSKUa4rfNBBOClQ7Oy+aRNfz+D8iqck
 fgxssZi6HfNR2TSWiJlNwL1N2BxKzKe9x2HwYYGitkQeuxo9p6/loVFtdfWAS8/sfTl4bOK0+
 Zz/3eDq3IKO7pbexJOCpQSW0Qi7DhKvnK1LJ6g5sprv3TCYTj8DtlB3oZC1HMXfaAJzS2Mzv/
 +dP1F/ZQ0EFEC7oEry9MgL5j271NEGXZXcqS0MbrVuDAOnQwT+XVbf36/U5uFzPT60FlcWUkF
 dISvM5FjlgpruLtzBL3WSaZbVdr9TOcgen5GOWiNrHr6K6GulbBA3xhsrB6WUp+Zf1PIrCbRO
 nO/pz0/a8/wvzBlBBnmC4rbR8J5Zp89CK2FsdyZUtPZSIDh6yl9gfGNsp7fYDxcELauV5545K
 wV6xq83BBm7C7IpLZLG3M74mpemIkE4UdcLSqTVxn3o5J67HGuYZ1EskWI3ICtIYGQm0XPqz4
 O3xVE2YdCZQmEY8u5wupm2HiwlAzYU5zrDKthriCcfjFhFxToWFRU+Wnbc2r9ZWPcKp7qByWh
 c/RvxO2HHkP0WEOWpOkAobK4mfU0DqhuQgmCD2CJDaE2gI0Q8JGgcJ8yTRsogAgtELBeTKAn+
 oAYezuqJaqtwKNJqWNVfzAHHSLg+ZcwHkweH7DVj8EGN063Ma0BYWujC5cPeopuV8oq7k2mNA
 OJaual+rCaFp41tyCTwNMPvOh2s2pjc0cDFjbNI3SfIyV0kgYBUZJs49RraS9aACpF/w9l9Ji
 j+5C6Qm9VVDJ7tpXU4TpSbfR87MG/wt9PlagBkA5hfcrxRmOT0sag5x7VkSYRQfenYZfgmes3
 dkmKfUTqQyyLkNbgfi6NWZPGzJRLMJWQ0dHKvPWfF11Ugr7OXd/jR8vXlxmGbdZfgjgZTV+/W
 pxvx9onnH4TI3LqBiYo9FMNBuna/eHhR0a3yxnJ7NjXg7U2G+OkSo
Message-ID-Hash: 3AG4K4RUYDEVLFH6YAIBHRSSAYOFRIHA
X-Message-ID-Hash: 3AG4K4RUYDEVLFH6YAIBHRSSAYOFRIHA
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux 
 FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org, linux-riscv <linux-riscv@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linaro-mm-sig@lists.linaro.org, Sumit Semwal <sumit.semwal@linaro.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3AG4K4RUYDEVLFH6YAIBHRSSAYOFRIHA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2020 at 4:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> On Mon, Jul 20, 2020 at 01:30:13PM +0200, Arnd Bergmann wrote:
> > On Mon, Jul 20, 2020 at 11:25 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > Introduce "secretmemfd" system call with the ability to create memory areas
> > > visible only in the context of the owning process and not mapped not only
> > > to other processes but in the kernel page tables as well.
> > >
> > > The user will create a file descriptor using the secretmemfd system call
> > > where flags supplied as a parameter to this system call will define the
> > > desired protection mode for the memory associated with that file
> > > descriptor. Currently there are two protection modes:
> > >
> > > * exclusive - the memory area is unmapped from the kernel direct map and it
> > >               is present only in the page tables of the owning mm.
> > > * uncached  - the memory area is present only in the page tables of the
> > >               owning mm and it is mapped there as uncached.
> > >
> > > For instance, the following example will create an uncached mapping (error
> > > handling is omitted):
> > >
> > >         fd = secretmemfd(SECRETMEM_UNCACHED);
> > >         ftruncate(fd, MAP_SIZE);
> > >         ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> > >                    fd, 0);
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >
> > I wonder if this should be more closely related to dmabuf file
> > descriptors, which
> > are already used for a similar purpose: sharing access to secret memory areas
> > that are not visible to the OS but can be shared with hardware through device
> > drivers that can import a dmabuf file descriptor.
>
> TBH, I didn't think about dmabuf, but my undestanding is that is this
> case memory areas are not visible to the OS because they are on device
> memory rather than normal RAM and when dmabuf is backed by the normal
> RAM, the memory is visible to the OS.

No, dmabuf is normally about normal RAM that is shared between multiple
devices, the idea is that you can have one driver allocate a buffer in RAM
and export it to user space through a file descriptor. The application can then
go and mmap() it or pass it into one or more other drivers.

This can be used e.g. for sharing a buffer between a video codec and the
gpu, or between a crypto engine and another device that accesses
unencrypted data while software can only observe the encrypted version.

       Arnd
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

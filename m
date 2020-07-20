Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C89226F73
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 22:06:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0086D123FC25E;
	Mon, 20 Jul 2020 13:06:03 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=217.72.192.75; helo=mout.kundenserver.de; envelope-from=arnd@arndb.de; receiver=<UNKNOWN> 
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D6D37123FC25D
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 13:06:00 -0700 (PDT)
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M5PVb-1jwF0718Wj-001Qi6 for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020
 22:05:58 +0200
Received: by mail-qt1-f169.google.com with SMTP id d27so14285652qtg.4
        for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 13:05:57 -0700 (PDT)
X-Gm-Message-State: AOAM531gDC0tyj51pfk4TXDgPdsi6Qh4coDAOsLtQejgMC2QPS8zDquD
	y20NA/cJ18WvistHATNMFD9c933EVvDR4YYNxEs=
X-Google-Smtp-Source: ABdhPJzP8ED75eP/64ZTWgc8CqM8513IRGly4LjDrHp/zECs6vcVhK6MaJY0JaFbbN4kfnMI9cRAMEvStsrfDJyQR1k=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr25919753qtq.304.1595275555970;
 Mon, 20 Jul 2020 13:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
 <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
 <1595260305.4554.9.camel@linux.ibm.com> <CAK8P3a34kx4aAFY=-SBHX3suCLwxeZY7+YSRzct93YM_OFbSWA@mail.gmail.com>
 <1595272585.4554.28.camel@linux.ibm.com>
In-Reply-To: <1595272585.4554.28.camel@linux.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Jul 2020 22:05:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ExFSSw-SCL=dSXzyv4jnp=yQs=ZooKDrL_tQogazrjg@mail.gmail.com>
Message-ID: <CAK8P3a0ExFSSw-SCL=dSXzyv4jnp=yQs=ZooKDrL_tQogazrjg@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
To: "James E.J. Bottomley" <jejb@linux.ibm.com>
X-Provags-ID: V03:K1:hKHRHQ3uPphu7kdmNTfnICGGcbgvPiI7ba/Vrz9bupxTx2Yuct0
 1CkBSVY5ZmnnOZ4WdoM/VD3bIb+koxvLsWasCmGLNUMfuLgd0TcAFHyh1kpdZJdwnUaskLs
 ZEDMel7d+9Rog3gjl135mm1GJMCjwyRmMEskxhaV2iGy+OpncMFhl3QklRz7I9LlzMAk+Io
 PbIo7mSSJkn4RpoP9EBqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KImVqhETfKo=:UPBTKoeZ/N7/3KiM//J6Ro
 sk3ZMLxKgyWdf2cXajLeyQSxJThxvNZaO3z8g49Ewudh/OvAyXxrf/gX1+nSQ/JkBvDDtb4TE
 pGGthYkN2tzGWwWmw6tXauUrTw3eXfN8PivgR5BlvUZviWku0zhjze07KPQ67DqJKr0NkRQcA
 SNjG5tQj0gQKj0ZATMZv08heNaJlmB/2BPWIRhDKnJgAxFekHqPCjc6V51qKe9HZUAJK/1Y0R
 EFh9nno3QzJvagu2Xu1D3WSq+5EFcyRLyZSCTNeLDVAR+2PdpmJ/hVWaBdBs9E519oE4qcZhG
 eYZ3kdIMiRlYMubP1KYCZrKa/GmePaYFAN6SEgVOQ1LFgwxeGCtru/6qVsim2S6n7EQ4ckbqG
 aUSh3Oh/HnDhvRRrbuh5cKlxM4SlngDqsh3EJIXus5+6lNxXDPX7+BlOJUfLPlA8szoHe1gaT
 lGMsPRAAOna89exDk/BtN9EUKa/eOE979+qNXfSqjvtFr2ChYTzFfkDp9T9U9koGS9jA5cwK/
 8F5CuyueLSumSOUKg5peD3BBiRq3iooYMvNQ4uU2KKbos4mI2F1lPlTy6JddvWHsZvufYQFaw
 EWMMkXCulq5v73PuqD6ef8924lo8tML6ht9cNTVqIdpnB81i1VzTVKZvlBmuCfLDJdQ2sqYOp
 4mqs5UQYsaXToLlWUeD2z5wD+1R4bJR+kTEEP07lbHf8GqbkOKYlqoppY8eA6omOII5MudMmj
 3YZMwyk6efMv07QQRqTyBUVV8Xa1Qc9b9TKg5ozxYxus6W9plM/jtSiHnEZqFz2dVgCBgaOTQ
 XrQfB8geAxmFbfmCpmVGtREN9sBVr2Wl9g0YRRVky0xSUZOcSWKFeM/VnpY587H5ma8L81cVO
 Qi0lQIMyjiZupP9+tD9nCCgsRxYsVwDhO4q5Gp1vU4nVJ6esCDexpER1rq6XknsubH8npfsV2
 X5QklKGF4lK77ZnXjRLhgGN6yTXvlYQPeTGevDUSCYHMKCUXdk4K+
Message-ID-Hash: FLV6LT5F3KIWRVUL56PEYCIFNQG5SLX7
X-Message-ID-Hash: FLV6LT5F3KIWRVUL56PEYCIFNQG5SLX7
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux FS-de
 vel Mailing List <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org, linux-riscv <linux-riscv@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linaro-mm-sig@lists.linaro.org, Sumit Semwal <sumit.semwal@linaro.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FLV6LT5F3KIWRVUL56PEYCIFNQG5SLX7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2020 at 9:16 PM James Bottomley <jejb@linux.ibm.com> wrote:
> On Mon, 2020-07-20 at 20:08 +0200, Arnd Bergmann wrote:
> > On Mon, Jul 20, 2020 at 5:52 PM James Bottomley <jejb@linux.ibm.com>
> >
> > If there is no way the data stored in this new secret memory area
> > would relate to secret data in a TEE or some other hardware
> > device, then I agree that dma-buf has no value.
>
> Never say never, but current TEE designs tend to require full
> confidentiality for the entire execution.  What we're probing is
> whether we can improve security by doing an API that requires less than
> full confidentiality for the process.  I think if the API proves useful
> then we will get HW support for it, but it likely won't be in the
> current TEE of today form.

As I understand it, you normally have two kinds of buffers for the TEE:
one that may be allocated by Linux but is owned by the TEE itself
and not accessible by any process, and one that is used for
communication between the TEE and a user process.

The sharing would clearly work only for the second type: data that
a process wants to share with the TEE but as little else as possible.

A hypothetical example might be a process that passes encrypted
data to the TEE (which holds the key) for decryption, receives
decrypted data and then consumes that data in its own address
space. An electronic voting system (I know, evil example) might
receive encrypted ballots and sum them up this way without itself
having the secret key or anything else being able to observe
intermediate results.

> > > What we want is the ability to get an fd, set the properties and
> > > the size and mmap it.  This is pretty much a 100% overlap with the
> > > memfd API and not much overlap with the dmabuf one, which is why I
> > > don't think the interface is very well suited.
> >
> > Does that mean you are suggesting to use additional flags on
> > memfd_create() instead of a new system call?
>
> Well, that was what the previous patch did.  I'm agnostic on the
> mechanism for obtaining the fd: new syscall as this patch does or
> extension to memfd like the old one did.  All I was saying is that once
> you have the fd, the API you use on it is the same as the memfd API.

Ok.

I suppose we could even retrofit dma-buf underneath the
secretmemfd implementation if it ends up being useful later on,

      Arnd
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

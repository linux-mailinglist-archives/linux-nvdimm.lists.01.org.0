Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F200307912
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 16:07:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E43F100F225C;
	Thu, 28 Jan 2021 07:07:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com; envelope-from=shakeelb@google.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 261FB100F2251
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 07:07:39 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v24so8002563lfr.7
        for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 07:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gx1FZQ1uHuDZkl2l0QuCyhlDjtM4hAvEVSjKq4XHXek=;
        b=rNDrJmirIdtuQRNEjYCJqIahTLFcoP8DR9oYw737/DvxJ19UDGdrbCsIGle2umy0jD
         NXWAsRT1flRccegDPvkf55kCw2DNk8SqDIL58JVr3fvRjKunbCHaj8KABu2swU23b+Tn
         x+NU2ZIn6ek86dpsaDWMjLSj4H8o+tTQ3yC4aFlrBvOa8XcqzmKF2TQDerrN2R5pYJu+
         fAMFlALz41f7QuqjuFdkX9Gq9MHturSOMu64f3KjxUu+KSfCnR6HUHqw812RnfVk6aYa
         yoVqSkXCV6LgmIAb66X006PCDW1Z8Wnv3RYQ7I2XqpROsvJE5rsKOwyxmgJqOxI69qOR
         rdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gx1FZQ1uHuDZkl2l0QuCyhlDjtM4hAvEVSjKq4XHXek=;
        b=rlcmWVpxH3IXULN5l0IW/VTCq9MB7aIIy0wdP7z5XCdoMcrHC0WFkSY7Lytsx0NnE0
         x2I/q42Qtd8dqt+AlWHYEi1QicBaFyHXFjUN4lkgcl/sgvcBAfD1t9lgfCF7hc6lz8/y
         4iFAquVBnmnVUiAqEy3AluPdhl/BOjRGdiYhDzDbqC0THQ6RQnxTxXKzDIEuLEbE8CWR
         Ox6/5qrAk+95tHtqXzMOuOqMy1als8hMXUqGzo+9gjdrMDgrPyJvqt3nDthOwg5++/0I
         3Zcq1IQEoLsGsn/TdBqEp8Pk55LjqChl1IEmr9BfzgA1Kwry+b81wOQj9te/tg43Eg3j
         zYOA==
X-Gm-Message-State: AOAM532UMSg6L+IVQ68ggKrHHVhSAknuYV0FM9Lq5kHogDt9xE9Vus5b
	APPJeZflOcQqCwPBL0+0nyqZ/9j9ZTA15lM/tWwUyg==
X-Google-Smtp-Source: ABdhPJxzwr8HMJ6apJZ3CZOR5fR8XzuCeUvw1xC4eQd5oEBUK4Q1RF1OXJXRQ9M4PBPC4V1mLDTLd34b3MmjmhPEFbo=
X-Received: by 2002:ac2:5a41:: with SMTP id r1mr7813210lfn.117.1611846457199;
 Thu, 28 Jan 2021 07:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20210121122723.3446-1-rppt@kernel.org> <20210121122723.3446-9-rppt@kernel.org>
 <20210125161706.GE308988@casper.infradead.org> <CALvZod7rn_5oXT6Z+iRCeMX_iMRO9G_8FnwSRGpJJwyBz5Wpnw@mail.gmail.com>
 <20210125213526.GK6332@kernel.org>
In-Reply-To: <20210125213526.GK6332@kernel.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 28 Jan 2021 07:07:26 -0800
Message-ID: <CALvZod4__691+OBMcQMfszJzd0g3OTz95gK2vHoL+c5gw+h++Q@mail.gmail.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
To: Mike Rapoport <rppt@kernel.org>
Message-ID-Hash: FTDH4JRYXMG2LTMDIBGZ3XYSWN2B24HG
X-Message-ID-Hash: FTDH4JRYXMG2LTMDIBGZ3XYSWN2B24HG
X-MailFrom: shakeelb@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deac
 on <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FTDH4JRYXMG2LTMDIBGZ3XYSWN2B24HG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 25, 2021 at 1:35 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Jan 25, 2021 at 09:18:04AM -0800, Shakeel Butt wrote:
> > On Mon, Jan 25, 2021 at 8:20 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Jan 21, 2021 at 02:27:20PM +0200, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > >
> > > > Account memory consumed by secretmem to memcg. The accounting is updated
> > > > when the memory is actually allocated and freed.
>
> I though about doing per-page accounting, but then one would be able to
> create a lot of secretmem file descriptors, use only a page from each while
> actual memory consumption will be way higher.
>
> > > I think this is wrong.  It fails to account subsequent allocators from
> > > the same PMD.  If you want to track like this, you need separate pools
> > > per memcg.
> > >
> >
> > Are these secretmem pools shared between different jobs/memcgs?
>
> A secretmem pool is per anonymous file descriptor and this file descriptor
> can be shared only explicitly between several processes. So, the secretmem
> pool should not be shared between different jobs/memcg. Of course, it's
> possible to spread threads of a process across different memcgs, but in
> that case the accounting will be similar to what's happening today with
> sl*b.

I don't think memcg accounting for sl*b works like that.

> The first thread to cause kmalloc() will be charged for the
> allocation of the entire slab and subsequent allocations from that slab
> will not be accounted.

The latest kernel does object level memcg accounting. So, each
allocation from these threads will correctly charge their own memcgs.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

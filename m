Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C062B6F81
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Nov 2020 21:02:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3E15100EF26A;
	Tue, 17 Nov 2020 12:02:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com; envelope-from=shakeelb@google.com; receiver=<UNKNOWN> 
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1652F100EF245
	for <linux-nvdimm@lists.01.org>; Tue, 17 Nov 2020 12:02:14 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v20so25705464ljk.8
        for <linux-nvdimm@lists.01.org>; Tue, 17 Nov 2020 12:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSCHMMM0D0q85Saw3BGZ1mrSdRqytsRtsFlwlLFUG1Q=;
        b=U5ZlwbFbW6wzZ9SjWFK+Je9NtJURJfuA+CBtm8mpTtA3OAFV31Gt7/PVFooFI3hJSJ
         FPe5GnyQ9vo+K8E4DGvg2CmIfBjU80aj+PwOMi9JxkBrfyCFhmQwE8yG25tVzzpwHM/G
         +SLjkMHpsWn0eetojTcyUPdUG+YBEUlN6bkAREdia0RwgRe5Az5vSyoEcUpsdqwdqQS2
         wQsiqbs+NFvyybKCLcEoNJlXX+Q79meG+WhN0TKvoL+R5ZHI5kwQtcSrRMvmI503HpW4
         iQFfKDV7kGEefpCno1fqlRK8X77oqYAJVuKjI7LR9wx0wgLXu6vuCzgHwKA6G32zuy1F
         Z/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSCHMMM0D0q85Saw3BGZ1mrSdRqytsRtsFlwlLFUG1Q=;
        b=W6ZiHr5Af+ABHnKAaQzPCElpIUG4bB6+CCa2Ib9dLT+az+NPVU/+azo3NUrFP1WBEV
         V0yadmxALHdf45C8tNtNHSu7dt/JntGxLh47IZs8fEBku7mDtUeOiDYdkv80hNA/uW8x
         xJi2MTzsLNH8zaYM2G6gKfDCgGXp3oYa9LfjccGtEZQxkjM9WCEkAENblQwe/NbcO0eB
         UR3UNS1L/H3fuFaVzi/nk3dsjw6Sh5TpWXAsB93uEXMqBpn0JerwgefivKI0eEHv9EmM
         idjkYRL9nyuHchGUQlEZITqRc8/JC9juxnuRic5kb3klHVdnYBCb3Dexm/gC06a4Ihw7
         6fBQ==
X-Gm-Message-State: AOAM533a/Pr50bEvUxvq7qbvZ2uH/3IVDDboMJqSZwlUu63z3oOWRQcn
	SIkvSUD5d3PS3THxJnWEQpFUgbNm0SiLFK13wIatDg==
X-Google-Smtp-Source: ABdhPJzrteo1SoLGHTARp2PUs3U3i4VQkUG29Mj40M+A73s5OoqlPLDhJ7M0v+3kzosqo9RIkW4zU8tz5/C7FbMtdpI=
X-Received: by 2002:a05:651c:204c:: with SMTP id t12mr2581977ljo.347.1605643332643;
 Tue, 17 Nov 2020 12:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20201117162932.13649-1-rppt@kernel.org> <20201117162932.13649-7-rppt@kernel.org>
 <20201117193358.GB109785@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201117193358.GB109785@carbon.dhcp.thefacebook.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 17 Nov 2020 12:02:01 -0800
Message-ID: <CALvZod5mJnR2DXoYTbp9RX4uR7zVyqAPfD+XKpqXKgxaNyJ1VA@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] secretmem: add memcg accounting
To: Roman Gushchin <guro@fb.com>
Message-ID-Hash: 6H2AX4X7QJIMNWNCJBOXNCDHDU6TN2PB
X-Message-ID-Hash: 6H2AX4X7QJIMNWNCJBOXNCDHDU6TN2PB
X-MailFrom: shakeelb@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will D
 eacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6H2AX4X7QJIMNWNCJBOXNCDHDU6TN2PB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 17, 2020 at 11:49 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Nov 17, 2020 at 06:29:29PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Account memory consumed by secretmem to memcg. The accounting is updated
> > when the memory is actually allocated and freed.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
[snip]
> >
> > +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> > +{
> > +     int err;
> > +
> > +     err = memcg_kmem_charge_page(page, gfp, order);

I haven't looked at the whole series but it seems like these pages
will be mapped into the userspace, so this patch has dependency on
Roman's "mm: allow mapping
accounted kernel pages to userspace" patch series.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

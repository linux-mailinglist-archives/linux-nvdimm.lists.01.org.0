Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6CE2B7685
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Nov 2020 07:55:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B0318100EBBA2;
	Tue, 17 Nov 2020 22:55:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 994E2100ED4BA
	for <linux-nvdimm@lists.01.org>; Tue, 17 Nov 2020 22:55:25 -0800 (PST)
Received: from kernel.org (unknown [77.125.7.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 6554424655;
	Wed, 18 Nov 2020 06:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1605682525;
	bh=ijXF7PUCZPM+SCn0c+6woTjKwc8l6BuK+EQkKzOZoH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiKSsv9RDCQm1S/HmggqtrPvdJmgXqMRBK6MAHqh9Yd/MlSYNip+OwN+JVDWvyw4j
	 PaowVWNf6v5Qw5aC1zUcALKjA0MeiiAKYuhFd5N18H92PtIsqdOsAxh4AC1cLHAVVu
	 7NvCS9CGGb6cKrHrwQ+X3wdidxAmVeF4uLboBzI8=
Date: Wed, 18 Nov 2020 08:55:09 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v9 6/9] secretmem: add memcg accounting
Message-ID: <20201118065509.GK370813@kernel.org>
References: <20201117162932.13649-1-rppt@kernel.org>
 <20201117162932.13649-7-rppt@kernel.org>
 <20201117193358.GB109785@carbon.dhcp.thefacebook.com>
 <CALvZod5mJnR2DXoYTbp9RX4uR7zVyqAPfD+XKpqXKgxaNyJ1VA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALvZod5mJnR2DXoYTbp9RX4uR7zVyqAPfD+XKpqXKgxaNyJ1VA@mail.gmail.com>
Message-ID-Hash: MDZ3JW5SGGONGG66EJGH27KCR7XLIILB
X-Message-ID-Hash: MDZ3JW5SGGONGG66EJGH27KCR7XLIILB
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Roman Gushchin <guro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deac
 on <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MDZ3JW5SGGONGG66EJGH27KCR7XLIILB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 17, 2020 at 12:02:01PM -0800, Shakeel Butt wrote:
> On Tue, Nov 17, 2020 at 11:49 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Nov 17, 2020 at 06:29:29PM +0200, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > Account memory consumed by secretmem to memcg. The accounting is updated
> > > when the memory is actually allocated and freed.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> [snip]
> > >
> > > +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> > > +{
> > > +     int err;
> > > +
> > > +     err = memcg_kmem_charge_page(page, gfp, order);
> 
> I haven't looked at the whole series but it seems like these pages
> will be mapped into the userspace, so this patch has dependency on
> Roman's "mm: allow mapping
> accounted kernel pages to userspace" patch series.

Yes, that's why I rebased the patches on top of mmotm.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

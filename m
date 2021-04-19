Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD28363EA7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 11:36:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A5B92100EBB96;
	Mon, 19 Apr 2021 02:36:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4E7C0100EBB92
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 02:36:38 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE5486101D;
	Mon, 19 Apr 2021 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1618824997;
	bh=gKvvGKT7gwRRGsoZvfcNRGcz0Uq+afSf3EpowR/OLNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3lkwvjW/R0feyjsaGtC46WUvSA5fINd83XuQt+ZESQgLmLjszsOUu+LDUHEcKzFK
	 sigplCcojQ4mBEu6rER8dXQGEZqUGKDoigx7QfRx9QLVtR+aRgfcwkGniPnNZcwK1Y
	 esYRQZkAPosCP1G+VuLB3y59ckxByt6ogqqNClQC0M2eiZ92c2ENWNcdwDNmkJaobH
	 Q6eesP5D30kBeyc+SuhpDLAJuFI3pxzWfEnJtG1/zLkGk9o8TBN3uAS9cvmcCI24LT
	 EfVn9mOhYvqkGR2hQgso12puyTHP9lzT9F9imFG/PQhcsS3AMAg4DeKSgo5cUC9n88
	 820gRflNkMWuw==
Date: Mon, 19 Apr 2021 12:36:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
Message-ID: <YH1PE4oWeicpJT9g@kernel.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
Message-ID-Hash: ZHYIJWT7JIVFA4ADHGQ64THDVIS5NG4P
X-Message-ID-Hash: ZHYIJWT7JIVFA4ADHGQ64THDVIS5NG4P
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, S
 huah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZHYIJWT7JIVFA4ADHGQ64THDVIS5NG4P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 19, 2021 at 11:15:02AM +0200, David Hildenbrand wrote:
> On 19.04.21 10:42, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >=20
> > Kernel test robot reported -4.2% regression of will-it-scale.per_thread=
_ops
> > due to commit "mm: introduce memfd_secret system call to create "secret"
> > memory areas".
> >=20
> > The perf profile of the test indicated that the regression is caused by
> > page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_ran=
ge):
> >=20
> >   27.76  +2.5  30.23       perf-profile.children.cycles-pp.gup_pgd_range
> >    0.00  +3.2   3.19 =B1 2%  perf-profile.children.cycles-pp.page_mappi=
ng
> >    0.00  +3.7   3.66 =B1 2%  perf-profile.children.cycles-pp.page_is_se=
cretmem
> >=20
> > Further analysis showed that the slow down happens because neither
> > page_is_secretmem() nor page_mapping() are not inline and moreover,
> > multiple page flags checks in page_mapping() involve calling
> > compound_head() several times for the same page.
> >=20
> > Make page_is_secretmem() inline and replace page_mapping() with page fl=
ag
> > checks that do not imply page-to-head conversion.
> >=20
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >=20
> > @Andrew,
> > The patch is vs v5.12-rc7-mmots-2021-04-15-16-28, I'd appreciate if it =
would
> > be added as a fixup to the memfd_secret series.
> >=20
> >   include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
> >   mm/secretmem.c            | 12 +-----------
> >   2 files changed, 26 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> > index 907a6734059c..b842b38cbeb1 100644
> > --- a/include/linux/secretmem.h
> > +++ b/include/linux/secretmem.h
> > @@ -4,8 +4,32 @@
> >   #ifdef CONFIG_SECRETMEM
> > +extern const struct address_space_operations secretmem_aops;
> > +
> > +static inline bool page_is_secretmem(struct page *page)
> > +{
> > +	struct address_space *mapping;
> > +
> > +	/*
> > +	 * Using page_mapping() is quite slow because of the actual call
> > +	 * instruction and repeated compound_head(page) inside the
> > +	 * page_mapping() function.
> > +	 * We know that secretmem pages are not compound and LRU so we can
> > +	 * save a couple of cycles here.
> > +	 */
> > +	if (PageCompound(page) || !PageLRU(page))
> > +		return false;
>=20
> I'd assume secretmem pages are rare in basically every setup out there. So
> maybe throwing in a couple of likely()/unlikely() might make sense.

I'd say we could do unlikely(page_is_secretmem()) at call sites. Here I can
hardly estimate which pages are going to be checked.
=20
> > +
> > +	mapping =3D (struct address_space *)
> > +		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
> > +
>=20
> Not sure if open-coding page_mapping is really a good idea here -- or even
> necessary after the fast path above is in place. Anyhow, just my 2 cents.

Well, most if the -4.2% of the performance regression kbuild reported were
due to repeated compount_head(page) in page_mapping(). So the whole point
of this patch is to avoid calling page_mapping().

> The idea of the patch makes sense to me.

--=20
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6456A363F68
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 12:14:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4F61100EB827;
	Mon, 19 Apr 2021 03:14:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D5905100EB823
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 03:14:39 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E554261157;
	Mon, 19 Apr 2021 10:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1618827278;
	bh=5M87hSd1tRHqwQ2MYCWGR3C48wQgQUhK50aj8D9UnJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evAt2Kl5D6T9Cd0vvsQr+HGnZL0bjqZw0RQERf99o/a8ARSQONHlK5WsXoqQNk5HA
	 UuhF/Rrt5Zhrq6yRbbpHUSqFJnrvW93kg/buM/tDCb4j7nNpeebnLT19q5XvGHG0e1
	 49YiudzNJhVJYWtrWp69yUsf7ZicdxeuaJvb2o26MproyIrJfelmI05dnFpYTA1S+3
	 KPevq2k+QCdmg92H0H+J4u9YW1dfsBAUkpesDwdo/uZea8b1mg9JI4Syb8VXhzzjqw
	 IZ0ev45rLME8l/aMAEZNl8hE0npfiMbGut76Y1J7ozBko7t6Q5l7vUjPndFu66yHeo
	 n/6L17YFihFDg==
Date: Mon, 19 Apr 2021 13:14:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
Message-ID: <YH1X+0CMH/2yppHK@kernel.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
 <YH1PE4oWeicpJT9g@kernel.org>
 <f4d0c4bf-423b-e227-444b-f1ea722dc43f@redhat.com>
 <56d8b80c-ce2c-ed86-0eda-253768d8d463@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56d8b80c-ce2c-ed86-0eda-253768d8d463@redhat.com>
Message-ID-Hash: SMBGVZ4LQJ6NUXBVWFAJP7PW5TFRZME2
X-Message-ID-Hash: SMBGVZ4LQJ6NUXBVWFAJP7PW5TFRZME2
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, S
 huah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMBGVZ4LQJ6NUXBVWFAJP7PW5TFRZME2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 19, 2021 at 11:40:56AM +0200, David Hildenbrand wrote:
> On 19.04.21 11:38, David Hildenbrand wrote:
> > On 19.04.21 11:36, Mike Rapoport wrote:
> > > On Mon, Apr 19, 2021 at 11:15:02AM +0200, David Hildenbrand wrote:
> > > > On 19.04.21 10:42, Mike Rapoport wrote:
> > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > >=20
> > > > > Kernel test robot reported -4.2% regression of will-it-scale.per_=
thread_ops
> > > > > due to commit "mm: introduce memfd_secret system call to create "=
secret"
> > > > > memory areas".
> > > > >=20
> > > > > The perf profile of the test indicated that the regression is cau=
sed by
> > > > > page_is_secretmem() called from gup_pte_range() (inlined by gup_p=
gd_range):
> > > > >=20
> > > > >     27.76  +2.5  30.23       perf-profile.children.cycles-pp.gup_=
pgd_range
> > > > >      0.00  +3.2   3.19 =B1 2%  perf-profile.children.cycles-pp.pa=
ge_mapping
> > > > >      0.00  +3.7   3.66 =B1 2%  perf-profile.children.cycles-pp.pa=
ge_is_secretmem
> > > > >=20
> > > > > Further analysis showed that the slow down happens because neither
> > > > > page_is_secretmem() nor page_mapping() are not inline and moreove=
r,
> > > > > multiple page flags checks in page_mapping() involve calling
> > > > > compound_head() several times for the same page.
> > > > >=20
> > > > > Make page_is_secretmem() inline and replace page_mapping() with p=
age flag
> > > > > checks that do not imply page-to-head conversion.
> > > > >=20
> > > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > > ---
> > > > >=20
> > > > > @Andrew,
> > > > > The patch is vs v5.12-rc7-mmots-2021-04-15-16-28, I'd appreciate =
if it would
> > > > > be added as a fixup to the memfd_secret series.
> > > > >=20
> > > > >     include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
> > > > >     mm/secretmem.c            | 12 +-----------
> > > > >     2 files changed, 26 insertions(+), 12 deletions(-)
> > > > >=20
> > > > > diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> > > > > index 907a6734059c..b842b38cbeb1 100644
> > > > > --- a/include/linux/secretmem.h
> > > > > +++ b/include/linux/secretmem.h
> > > > > @@ -4,8 +4,32 @@
> > > > >     #ifdef CONFIG_SECRETMEM
> > > > > +extern const struct address_space_operations secretmem_aops;
> > > > > +
> > > > > +static inline bool page_is_secretmem(struct page *page)
> > > > > +{
> > > > > +	struct address_space *mapping;
> > > > > +
> > > > > +	/*
> > > > > +	 * Using page_mapping() is quite slow because of the actual call
> > > > > +	 * instruction and repeated compound_head(page) inside the
> > > > > +	 * page_mapping() function.
> > > > > +	 * We know that secretmem pages are not compound and LRU so we =
can
> > > > > +	 * save a couple of cycles here.
> > > > > +	 */
> > > > > +	if (PageCompound(page) || !PageLRU(page))
> > > > > +		return false;
> > > >=20
> > > > I'd assume secretmem pages are rare in basically every setup out th=
ere. So
> > > > maybe throwing in a couple of likely()/unlikely() might make sense.
> > >=20
> > > I'd say we could do unlikely(page_is_secretmem()) at call sites. Here=
 I can
> > > hardly estimate which pages are going to be checked.
> > > > > +
> > > > > +	mapping =3D (struct address_space *)
> > > > > +		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
> > > > > +
> > > >=20
> > > > Not sure if open-coding page_mapping is really a good idea here -- =
or even
> > > > necessary after the fast path above is in place. Anyhow, just my 2 =
cents.
> > >=20
> > > Well, most if the -4.2% of the performance regression kbuild reported=
 were
> > > due to repeated compount_head(page) in page_mapping(). So the whole p=
oint
> > > of this patch is to avoid calling page_mapping().
> >=20
> > I would have thought the fast path "(PageCompound(page) ||
> > !PageLRU(page))" would already avoid calling page_mapping() in many cas=
es.
>=20
> (and I do wonder if a generic page_mapping() optimization would make sense
> instead)

Not sure. Replacing page_mapping() with page_file_mapping() at the
call sites at fs/ and mm/ increased the defconfig image by nearly 2k
and page_file_mapping() is way simpler than page_mapping()

add/remove: 1/0 grow/shrink: 35/0 up/down: 1960/0 (1960)
Function                                     old     new   delta
shrink_page_list                            3414    3670    +256
__set_page_dirty_nobuffers                   242     349    +107
check_move_unevictable_pages                 904     987     +83
move_to_new_page                             591     671     +80
shrink_active_list                           912     970     +58
move_pages_to_lru                            911     965     +54
migrate_pages                               2500    2554     +54
shmem_swapin_page                           1145    1197     +52
shmem_undo_range                            1669    1719     +50
__test_set_page_writeback                    620     670     +50
__set_page_dirty_buffers                     187     237     +50
__pagevec_lru_add                            757     807     +50
__munlock_pagevec                           1155    1205     +50
__dump_page                                 1101    1151     +50
__cancel_dirty_page                          182     232     +50
__remove_mapping                             461     510     +49
rmap_walk_file                               402     449     +47
isolate_movable_page                         240     287     +47
test_clear_page_writeback                    668     714     +46
page_cache_pipe_buf_try_steal                171     217     +46
page_endio                                   246     290     +44
page_file_mapping                              -      43     +43
__isolate_lru_page_prepare                   254     297     +43
hugetlb_page_mapping_lock_write               39      81     +42
iomap_set_page_dirty                         110     151     +41
clear_page_dirty_for_io                      324     364     +40
wait_on_page_writeback_killable              118     157     +39
wait_on_page_writeback                       105     144     +39
set_page_dirty                               159     198     +39
putback_movable_page                          32      71     +39
page_mkclean                                 172     211     +39
mark_buffer_dirty                            176     215     +39
invalidate_inode_page                        122     161     +39
delete_from_page_cache                       139     178     +39
PageMovable                                   49      86     +37
isolate_migratepages_block                  2843    2872     +29
Total: Before=3D17068648, After=3D17070608, chg +0.01%
=20
> Willy can most probably give the best advise here :)

I think that's what folios are for :)

--=20
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

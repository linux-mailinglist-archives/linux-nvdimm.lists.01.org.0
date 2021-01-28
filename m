Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712C3077CF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 15:22:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0FF22100EB334;
	Thu, 28 Jan 2021 06:22:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0772B100EBB9D
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 06:22:25 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1611843744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTyYfHxVeLzGHWSwOvwq53dZzhDb7zJAaqQ20zEnBQo=;
	b=tZPG7U2mHgmh4/6Ua8sFwY4yt7lQFbxygTF8BprvvmlP27oDtQXZh768Yg/Z082E1URKI2
	T6aM07JvCtuFwwKMu68i5mCLMFi6oNtYXWMBP85PEnh58gWe1DppMZTjN+2kFnbapvgMwz
	Lu/rvPxkwQW+Nde41FMKFbLhE0rXHUY=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 540CCB141;
	Thu, 28 Jan 2021 14:22:24 +0000 (UTC)
Date: Thu, 28 Jan 2021 15:22:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
Message-ID: <YBLInhns9ysc4wNF@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-9-rppt@kernel.org>
 <20210125165451.GT827@dhcp22.suse.cz>
 <20210125213817.GM6332@kernel.org>
 <20210126144838.GL308988@casper.infradead.org>
 <20210126150555.GU827@dhcp22.suse.cz>
 <20210127184213.GA919963@carbon.dhcp.thefacebook.com>
 <YBJuwqItjCemDN5L@dhcp22.suse.cz>
 <CALvZod7YjXvaYoZ7HXq2sDkwvpjpLBA-jhrzxa48jEuBt6zLNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALvZod7YjXvaYoZ7HXq2sDkwvpjpLBA-jhrzxa48jEuBt6zLNQ@mail.gmail.com>
Message-ID-Hash: 3FVIQQJLRASTTX3JEVDZ2VL5MWOMR47Q
X-Message-ID-Hash: 3FVIQQJLRASTTX3JEVDZ2VL5MWOMR47Q
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Roman Gushchin <guro@fb.com>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho And
 ersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3FVIQQJLRASTTX3JEVDZ2VL5MWOMR47Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu 28-01-21 06:05:11, Shakeel Butt wrote:
> On Wed, Jan 27, 2021 at 11:59 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 27-01-21 10:42:13, Roman Gushchin wrote:
> > > On Tue, Jan 26, 2021 at 04:05:55PM +0100, Michal Hocko wrote:
> > > > On Tue 26-01-21 14:48:38, Matthew Wilcox wrote:
> > > > > On Mon, Jan 25, 2021 at 11:38:17PM +0200, Mike Rapoport wrote:
> > > > > > I cannot use __GFP_ACCOUNT because cma_alloc() does not use gfp.
> > > > > > Besides, kmem accounting with __GFP_ACCOUNT does not seem
> > > > > > to update stats and there was an explicit request for statistics:
> > > > > >
> > > > > > https://lore.kernel.org/lkml/CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com/
> > > > > >
> > > > > > As for (ab)using NR_SLAB_UNRECLAIMABLE_B, as it was already discussed here:
> > > > > >
> > > > > > https://lore.kernel.org/lkml/20201129172625.GD557259@kernel.org/
> > > > > >
> > > > > > I think that a dedicated stats counter would be too much at the moment and
> > > > > > NR_SLAB_UNRECLAIMABLE_B is the only explicit stat for unreclaimable memory.
> > > > >
> > > > > That's not true -- Mlocked is also unreclaimable.  And doesn't this
> > > > > feel more like mlocked memory than unreclaimable slab?  It's also
> > > > > Unevictable, so could be counted there instead.
> > > >
> > > > yes, that is indeed true, except the unreclaimable counter is tracking
> > > > the unevictable LRUs. These pages are not on any LRU and that can cause
> > > > some confusion. Maybe they shouldn't be so special and they should live
> > > > on unevistable LRU and get their stats automagically.
> > > >
> > > > I definitely do agree that this would be a better fit than NR_SLAB
> > > > abuse. But considering that this is somehow even more special than mlock
> > > > then a dedicated counter sounds as even better fit.
> > >
> > > I think it depends on how large these areas will be in practice.
> > > If they will be measured in single or double digits MBs, a separate entry
> > > is hardly a good choice: because of the batching the displayed value
> > > will be in the noise range, plus every new vmstat item adds to the
> > > struct mem_cgroup size.
> > >
> > > If it will be measured in GBs, of course, a separate counter is preferred.
> > > So I'd suggest to go with NR_SLAB (which should have been named NR_KMEM)
> > > as now and conditionally switch to a separate counter later.
> >
> > I really do not think the overall usage matters when it comes to abusing
> > other counters. Changing this in future will be always tricky and there
> > always be our favorite "Can this break userspace" question. Yes we dared
> > to change meaning of some counters but this is not generally possible.
> > Just have a look how accounting shmem as a page cache has turned out
> > being much more tricky than many like.
> >
> > Really if a separate counter is a big deal, for which I do not see any
> > big reason, then this should be accounted as unevictable (as suggested
> > by Matthew) and ideally pages of those mappings should be sitting in the
> > unevictable LRU as well unless there is a strong reason against.
> >
> 
> Why not decide based on the movability of these pages? If movable then
> unevictable LRU seems like the right way otherwise NR_SLAB.

I really do not follow. If the page is unevictable then why movability
matters? I also fail to see why NR_SLAB is even considered considering
this is completely outside of slab proper.

Really what is the point? What are we trying to achieve by stats? Do we
want to know how much secret memory is used because that is an
interesting/important information or do we just want to make some
accounting?

Just think at it from a practical point of view. I want to know how much
slab memory is used because it can give me an idea whether kernel is
consuming unexpected amount of memory. Now I have to subtract _some_
number to get that information. Where do I get that some number?

We have been creative with counters and it tends to kick back much more
often than it helps.

I really do not want this to turn into an endless bike shed but either
this should be accounted as a general type of memory (unevictable would
be a good fit because that is a userspace memory which is not
reclaimable) or it needs its own counter to tell how much of this
specific type of memory is used for this purpose.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

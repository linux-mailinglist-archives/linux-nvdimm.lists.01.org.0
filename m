Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5EC303752
	for <lists+linux-nvdimm@lfdr.de>; Tue, 26 Jan 2021 08:31:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F2BBD100EBB7D;
	Mon, 25 Jan 2021 23:31:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 18605100EBB7C
	for <linux-nvdimm@lists.01.org>; Mon, 25 Jan 2021 23:31:45 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1611646304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7zMRtj92K4aLVsKF/LtuTzpzMNc9rmo/TxWykS3K0E0=;
	b=fbzVzS60+bW4/eLvVlMg8GidpFB1jBrR7hcptqrY8DOrxY95Wqr6BYjafHEM6FDX7G5i/a
	47NUGFfcrm6l+Of7J1sWw4Lzuue/Bl54LKMg59hi6hWCs5djiniqInQ7mh6N/vOqeVmO+1
	dcHiiymtcGUHsS6UXafRNc9p1dmXURc=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 3F491AE61;
	Tue, 26 Jan 2021 07:31:44 +0000 (UTC)
Date: Tue, 26 Jan 2021 08:31:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
Message-ID: <20210126073142.GY827@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-9-rppt@kernel.org>
 <20210125165451.GT827@dhcp22.suse.cz>
 <20210125213817.GM6332@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210125213817.GM6332@kernel.org>
Message-ID-Hash: F4MS5OSQI7R57BRVZAW33SX4JB2F7X7Z
X-Message-ID-Hash: F4MS5OSQI7R57BRVZAW33SX4JB2F7X7Z
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F4MS5OSQI7R57BRVZAW33SX4JB2F7X7Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon 25-01-21 23:38:17, Mike Rapoport wrote:
> On Mon, Jan 25, 2021 at 05:54:51PM +0100, Michal Hocko wrote:
> > On Thu 21-01-21 14:27:20, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > Account memory consumed by secretmem to memcg. The accounting is updated
> > > when the memory is actually allocated and freed.
> > 
> > What does this mean?
> 
> That means that the accounting is updated when secretmem does cma_alloc()
> and cma_relase().
> 
> > What are the lifetime rules?
> 
> Hmm, what do you mean by lifetime rules?

OK, so let's start by reservation time (mmap time right?) then the
instantiation time (faulting in memory). What if the calling process of
the former has a different memcg context than the later. E.g. when you
send your fd or inherited fd over fork will move to a different memcg.

What about freeing path? E.g. when you punch a hole in the middle of
a mapping?

Please make sure to document all this.

> > [...]
> > 
> > > +static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
> > > +{
> > > +	int err;
> > > +
> > > +	err = memcg_kmem_charge_page(page, gfp, order);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/*
> > > +	 * seceremem caches are unreclaimable kernel allocations, so treat
> > > +	 * them as unreclaimable slab memory for VM statistics purposes
> > > +	 */
> > > +	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> > > +			      PAGE_SIZE << order);
> > 
> > A lot of memcg accounted memory is not reclaimable. Why do you abuse
> > SLAB counter when this is not a slab owned memory? Why do you use the
> > kmem accounting API when __GFP_ACCOUNT should give you the same without
> > this details?
> 
> I cannot use __GFP_ACCOUNT because cma_alloc() does not use gfp.

Other people are working on this to change. But OK, I do see that this
can be done later but it looks rather awkward.

> Besides, kmem accounting with __GFP_ACCOUNT does not seem
> to update stats and there was an explicit request for statistics:
>  
> https://lore.kernel.org/lkml/CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com/

charging and stats are two different things. You can still take care of
your stats without explicitly using the charging API. But this is a mere
detail. It just hit my eyes.

> As for (ab)using NR_SLAB_UNRECLAIMABLE_B, as it was already discussed here:
> 
> https://lore.kernel.org/lkml/20201129172625.GD557259@kernel.org/

Those arguments should be a part of the changelof.

> I think that a dedicated stats counter would be too much at the moment and
> NR_SLAB_UNRECLAIMABLE_B is the only explicit stat for unreclaimable memory.

Why do you think it would be too much? If the secret memory becomes a
prevalent memory user because it will happen to back the whole virtual
machine then hiding it into any existing counter would be less than
useful.

Please note that this all is a user visible stuff that will become PITA
(if possible) to change later on. You should really have strong
arguments in your justification here.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

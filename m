Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0DF30BAFF
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 10:35:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5C6C100EBB97;
	Tue,  2 Feb 2021 01:35:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 96BF7100EBBDE
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 01:35:08 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1612258506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q54UyAniLH3WTtqS2/eEFFAOsABqgVttGqq1oJHHl3o=;
	b=pwRKjSfmAAUl4rpfKIVMY6cCCIH0A1qOnaV8W5VBLKM6omzrGDOVmq/p9akJdMt/mFgkO8
	V2tc8GFVYU80SWASGLlyhGF0EaS9YLNXv/f0XhQU0L4onN+4ztKCsUfGmCzaoW6V54AWau
	ShSpuMgXIb5koikt2IimucJXrn9ZlD0=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 9998AB171;
	Tue,  2 Feb 2021 09:35:06 +0000 (UTC)
Date: Tue, 2 Feb 2021 10:35:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <YBkcyQsky2scjEcP@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org>
 <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz>
 <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
 <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
 <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
Message-ID-Hash: VOWVA2ERGKMYZHX2NNVGFMIY7L3JQ6OJ
X-Message-ID-Hash: VOWVA2ERGKMYZHX2NNVGFMIY7L3JQ6OJ
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VOWVA2ERGKMYZHX2NNVGFMIY7L3JQ6OJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon 01-02-21 08:56:19, James Bottomley wrote:
> On Fri, 2021-01-29 at 09:23 +0100, Michal Hocko wrote:
> > On Thu 28-01-21 13:05:02, James Bottomley wrote:
> > > Obviously the API choice could be revisited
> > > but do you have anything to add over the previous discussion, or is
> > > this just to get your access control?
> > 
> > Well, access control is certainly one thing which I still believe is
> > missing. But if there is a general agreement that the direct map
> > manipulation is not that critical then this will become much less of
> > a problem of course.
> 
> The secret memory is a scarce resource but it's not a facility that
> should only be available to some users.

How those two objectives go along? Or maybe our understanding of what
scrace really means here. If the pool of the secret memory is very limited
then you really need a way to stop one party from depriving others. More
on that below.

> > It all boils down whether secret memory is a scarce resource. With
> > the existing implementation it really is. It is effectivelly
> > repeating same design errors as hugetlb did. And look now, we have a
> > subtle and convoluted reservation code to track mmap requests and we
> > have a cgroup controller to, guess what, have at least some control
> > over distribution if the preallocated pool. See where am I coming
> > from?
> 
> I'm fairly sure rlimit is the correct way to control this.  The
> subtlety in both rlimit and memcg tracking comes from deciding to
> account under an existing category rather than having our own new one. 
> People don't like new stuff in accounting because it requires
> modifications to everything in userspace.  Accounting under and
> existing limit keeps userspace the same but leads to endless arguments
> about which limit it should be under.  It took us several patch set
> iterations to get to a fragile consensus on this which you're now
> disrupting for reasons you're not making clear.

I hoped I had made my points really clear. The existing scheme allows
one users (potentially adversary) to deplete the preallocated pool
and cause a shitstorm of OOM killer because there is no real way to
replenish the pool from the oom killer other than randomly keep killing
tasks until one happens to release its secret memory back to the
pool. Is that more clear now?

And no, rlimit and memcg limit will not save you from that because the
former is per process and later is hard to manage under a single limit
which might be order of magnitude larger than the secret memory pool
size. See the point?

I have also proposed potential ways out of this. Either the pool is not
fixed sized and you make it a regular unevictable memory (if direct map
fragmentation is not considered a major problem) or you need a careful
access control or you need SIGBUS on the mmap failure (to allow at least
some fallback mode to caller).

I do not see any other way around it. I might be missing some other
ways but so far I keep hearing that the existing scheme is just fine
because this has been discussed in the past and you have agreed it is
ok. Without any specifics...

Please keep in mind this is a user interface and it is due to careful
scrutiny. So rather than pushing back with "you are disrupting a
consensus" kinda feedback, please try to stay technical.

> > If the secret memory is more in line with mlock without any imposed
> > limit (other than available memory) in the end then, sure, using the
> > same access control as mlock sounds reasonable. Btw. if this is
> > really just a more restrictive mlock then is there any reason to not
> > hook this into the existing mlock infrastructure (e.g.
> > MCL_EXCLUSIVE)? Implications would be that direct map would be
> > handled on instantiation/tear down paths, migration would deal with
> > the same (if possible). Other than that it would be mlock like.
> 
> In the very first patch set we proposed a mmap flag to do this.  Under
> detailed probing it emerged that this suffers from several design
> problems: the KVM people want VMM to be able to remove the secret
> memory range from the process; there may be situations where sharing is
> useful and some people want to be able to seal the operations.  All of
> this ended up convincing everyone that a file descriptor based approach
> was better than a mmap one.

OK, fair enough. This belongs to the changelog IMHO. It is good to know
why existing interfaces do not match the need.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

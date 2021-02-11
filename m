Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF04318733
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 10:38:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 063D7100EAB0D;
	Thu, 11 Feb 2021 01:38:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 640DE100EAB06
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 01:38:06 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1613036284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgmP4ChnF5ylKST2wdnNkKGWWTfAZndBC/g6lnPZqtQ=;
	b=gFxEQ1HxiWSFhHn1jwSJVEwHxVpSlJMv6PB7Y1NSZ1/b8fSyhPfVk7yywgPmO4H7XJin/6
	OHl4FZuzyl9SmIpoocVwVNameXLeVOeaSYvQ7jYywhTiC1cf9hdrm6CSlrhOU+pV14KgLG
	e4bGEV2hXCQzrmyfIJHQUSLivHm63jQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 8538FADE3;
	Thu, 11 Feb 2021 09:38:04 +0000 (UTC)
Date: Thu, 11 Feb 2021 10:38:03 +0100
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCT6+9YW474IaKrm@dhcp22.suse.cz>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
 <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <0d66baec-1898-987b-7eaf-68a015c027ff@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0d66baec-1898-987b-7eaf-68a015c027ff@redhat.com>
Message-ID-Hash: 3O52KLFDRACZ3KLZ2PKVHAUQQA4ZRV4W
X-Message-ID-Hash: 3O52KLFDRACZ3KLZ2PKVHAUQQA4ZRV4W
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3O52KLFDRACZ3KLZ2PKVHAUQQA4ZRV4W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu 11-02-21 10:01:32, David Hildenbrand wrote:
[...]
> AFAIKS, we would need MFD_SECRET and disallow
> MFD_ALLOW_SEALING and MFD_HUGETLB.

Yes for an initial version. But I do expect a request to support both
features is just a matter of time.

> In addition, we could add MFD_SECRET_NEVER_MAP, which could disallow any kind of
> temporary mappings (eor migration). TBC.

I believe this is the mode Mike wants to have by default. A more relax
one would be an opt-in. MFD_SECRET_RELAXED which would allow temporal
mappings in the kernel for content copying (e.g. for migration).

> ---
> 
> Some random thoughts regarding files.
> 
> What is the page size of secretmem memory? Sometimes we use huge pages,
> sometimes we fallback to 4k pages. So I assume huge pages in general?

Unless there is an explicit request for hugetlb I would say the page
size is not really important like for any other fds. Huge pages can be
used transparently.
 
> What are semantics of MADV()/FALLOCATE() etc on such files?

I would expect the same semantic as regular shmem (memfd_create) except
the memory doesn't have _any_ backing storage which makes it
unevictable. So the reclaim related madv won't work but there shouldn't
be any real reason why e.g. MADV_DONTNEED, WILLNEED, DONT_FORK and
others don't work.

> I assume PUNCH_HOLE fails in a nice way? does it work?
> Does mremap()/mremap(FIXED) work/is it blocked?
> Does mprotect() fail in a nice way?

I do not see a reason why those shouldn't work.
 
> Is userfaultfd() properly fenced? Or does it even work (doubt)?
> 
> How does it behave if I mmap(FIXED) something in between?
> In which granularity can I do that (->page-size?)?

Again, nothing really exceptional here. This is a mapping like any
other from address space manipulation POV.

> What are other granularity restrictions (->page size)?
> 
> Don't want to open a big discussion here, just some random thoughts.
> Maybe it has all been already figured out and most of the answers
> above are "Fails with -EINVAL".

I think that the behavior should be really in sync with shmem semantic
as much as possible. Most operations should simply work with an
aditional direct map manipulation. There is no real reason to be
special. Some functionality might be missing, e.g. hugetlb support but
that has been traditionally added on top of shmem interface so nothing
really new here.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D75318A88
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 13:30:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04D31100EA2B0;
	Thu, 11 Feb 2021 04:30:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6CBFC100EA2AF
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 04:30:47 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1613046645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osI3lOxyWNnCWMwYvgacjyYRqS8PdApBu7r+l9GS1F8=;
	b=FGCfa/BPAaNMnKzWYBfMoLB55bV/2nWROmax5NShmeaFHcKLO/NerKPjx1ctr7FJZ/MDlK
	j39ZM2jnxpVR1DSUloBxejptFaGKNBgYEvf5Z1x0XO+JtJwHMbCmw7POQPPk2NJN9eW5Lk
	zmKurgl8D3XiuDQywu6d2sTB6/qoOf8=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id A9902ACD4;
	Thu, 11 Feb 2021 12:30:45 +0000 (UTC)
Date: Thu, 11 Feb 2021 13:30:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCUjck0I8qgjB24i@dhcp22.suse.cz>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
 <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <20210211112008.GH242749@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210211112008.GH242749@kernel.org>
Message-ID-Hash: 6J2EW3XOCZIWXJE6G24U64VZIU3EERGL
X-Message-ID-Hash: 6J2EW3XOCZIWXJE6G24U64VZIU3EERGL
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6J2EW3XOCZIWXJE6G24U64VZIU3EERGL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu 11-02-21 13:20:08, Mike Rapoport wrote:
[...]
> Sealing is anyway controlled via fcntl() and I don't think
> MFD_ALLOW_SEALING makes much sense for the secretmem because it is there to
> prevent rogue file sealing in tmpfs/hugetlbfs.

This doesn't really match my understanding. The primary usecase for the
sealing is to safely and predictably coordinate over shared memory. I
absolutely do not see why this would be incompatible with an additional
requirement to unmap the memory from the kernel to prevent additional
interference from the kernel side. Quite contrary it looks like a very
nice extension to this model.
 
> As for the huge pages, I'm not sure at all that supporting huge pages in
> secretmem will involve hugetlbfs.

Have a look how hugetlb proliferates through our MM APIs. I strongly
suspect this is strong signal that this won't be any different.

> And even if yes, adding SECRETMEM_HUGE
> flag seems to me less confusing than saying "from kernel x.y you can use
> MFD_CREATE | MFD_SECRET | MFD_HUGE" etc for all possible combinations.

I really fail to see your point. This is a standard model we have. It is
quite natural that flags are added. Moreover adding a new syscall will
not make it any less of a problem.

> > I by no means do not insist one way or the other but from what I have
> > seen so far I have a feeling that the interface hasn't been thought
> > through enough.
> 
> It has been, but we have different thoughts about it ;-)

Then you must be carrying a lot of implicit knowledge which I want you
to document.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

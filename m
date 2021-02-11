Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C8319629
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 23:59:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C038100EA2CA;
	Thu, 11 Feb 2021 14:59:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 857FF100EA2BE
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 14:59:48 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9786060201;
	Thu, 11 Feb 2021 22:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1613084387;
	bh=nwfYRIB3XPlsF/osjlzU/dWbZib+rLZZQ1WRBOk4t7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdTTKx4aSQ8hkEPYzAOR1T3elAMsY1CYPCHGk93b9t2QtZeB+UpZbCQ03b67p01io
	 0CPfT25fR779DcxgF9uIUTbjBbmoENZYCKOgteFMgvosv7pjW8MGdn6LH4gBSFgHUj
	 C+GlOtsFxDaZddY+gooLTQRqYN+gXU6P63ZLyimnf5sV79XHXrhf3OPikJO5K+WqVz
	 aFti4o9fRlC17Dt/5lLws2NpSmnDTkBYt8SfmbE5H+3Z3VRlSLutY3g5cUNrQHCicG
	 r70nCETUN3ChfKxxOHlvQhMKLRsiVdYThDq3/QJpacz+OX3DjQCWEhTrnn+5V3ktfc
	 vVYfnIhIRPWBw==
Date: Fri, 12 Feb 2021 00:59:29 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210211225929.GK242749@kernel.org>
References: <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com>
 <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org>
 <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <20210211112008.GH242749@kernel.org>
 <YCUjck0I8qgjB24i@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YCUjck0I8qgjB24i@dhcp22.suse.cz>
Message-ID-Hash: BC62PJIRG27XVA4XRFAP42LJJ442VZ3X
X-Message-ID-Hash: BC62PJIRG27XVA4XRFAP42LJJ442VZ3X
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BC62PJIRG27XVA4XRFAP42LJJ442VZ3X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 11, 2021 at 01:30:42PM +0100, Michal Hocko wrote:
> On Thu 11-02-21 13:20:08, Mike Rapoport wrote:
> [...]
> > Sealing is anyway controlled via fcntl() and I don't think
> > MFD_ALLOW_SEALING makes much sense for the secretmem because it is there to
> > prevent rogue file sealing in tmpfs/hugetlbfs.
> 
> This doesn't really match my understanding. The primary usecase for the
> sealing is to safely and predictably coordinate over shared memory. I
> absolutely do not see why this would be incompatible with an additional
> requirement to unmap the memory from the kernel to prevent additional
> interference from the kernel side. Quite contrary it looks like a very
> nice extension to this model.

I didn't mean that secretmem should not support sealing. I meant that
MFD_ALLOW_SEALING flag does not make sense. Unlike tmpfs, the secretmem fd
does not need protection from somebody unexpectedly sealing it.

> > As for the huge pages, I'm not sure at all that supporting huge pages in
> > secretmem will involve hugetlbfs.
> 
> Have a look how hugetlb proliferates through our MM APIs. I strongly
> suspect this is strong signal that this won't be any different.
> 
> > And even if yes, adding SECRETMEM_HUGE
> > flag seems to me less confusing than saying "from kernel x.y you can use
> > MFD_CREATE | MFD_SECRET | MFD_HUGE" etc for all possible combinations.
> 
> I really fail to see your point. This is a standard model we have. It is
> quite natural that flags are added. Moreover adding a new syscall will
> not make it any less of a problem.

Nowadays adding a new syscall is not as costly as it used to be. And I
think it'll provide better extensibility when new features would be added
to secretmem. 

For instance, for creating a secretmem fd backed with sealing we'd have

	memfd_secretm(SECRETMEM_HUGE);

rather than

	memfd_create(MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_SECRET);


Besides, if we overload memfd_secret we add complexity to flags validation
of allowable flag combinations even with the simplest initial
implementation.
And what it will become when more features are added to secretmem?
 
> > > I by no means do not insist one way or the other but from what I have
> > > seen so far I have a feeling that the interface hasn't been thought
> > > through enough.
> > 
> > It has been, but we have different thoughts about it ;-)
> 
> Then you must be carrying a lot of implicit knowledge which I want you
> to document.

I don't have any implicit knowledge, we just have a different perspective.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

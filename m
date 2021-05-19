Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41161388800
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 May 2021 09:13:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A0A11100F2270;
	Wed, 19 May 2021 00:13:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9F2B9100EB323
	for <linux-nvdimm@lists.01.org>; Wed, 19 May 2021 00:13:30 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 306EE6135B;
	Wed, 19 May 2021 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1621408407;
	bh=Ki50aQXwD1+I3Hw9xcIirZa4MRm+9KRJ+IEPHMwhBkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYyy/RZh+KV4+OBVGMz4vRqytOJ3S6neHrNHLUg1kHLXII61rwPkBThjJAvrsmUZo
	 FjnPqLIJ5kAx/qeZGbRsU6kB8hQ4Hhb8cAmXfxBQtvxU8dgEHEV4y4yEtokhAPiKIr
	 /MuOkK56iFsIUVMsvkPHddFEnBeu4T4s7c6IPe+YOzaeJb9MlSBih46lnNG19GWJXN
	 Dr+Kz+dEZLJXS9T0HxuiavOJs0HPv1T3S1Qsh+y5zhmE6RBkRzoRn73O2mfgQvXLJ6
	 Y/WFNcW+0oFbapTux4HghodwAEaeJ7uRFxUxBZQ17d8823037Btr6+DWDVvpylUSU6
	 pxMi/n2f2auLQ==
Date: Wed, 19 May 2021 10:13:09 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <YKS6herUjtCDz7ko@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
 <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
 <YKDJ1L7XpJRQgSch@kernel.org>
 <YKOP5x8PPbqzcsdK@dhcp22.suse.cz>
 <8e114f09-60e4-2343-1c42-1beaf540c150@redhat.com>
 <YKOXbNWvUsqM4uxb@dhcp22.suse.cz>
 <00644dd8-edac-d3fd-a080-0a175fa9bf13@redhat.com>
 <YKOgK9eQSfgoz6eE@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YKOgK9eQSfgoz6eE@dhcp22.suse.cz>
Message-ID-Hash: J32X7RDQAGN27ZYIDR2IULMJWDUM3O27
X-Message-ID-Hash: J32X7RDQAGN27ZYIDR2IULMJWDUM3O27
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysoc
 ki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J32X7RDQAGN27ZYIDR2IULMJWDUM3O27/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 18, 2021 at 01:08:27PM +0200, Michal Hocko wrote:
> On Tue 18-05-21 12:35:36, David Hildenbrand wrote:
> > On 18.05.21 12:31, Michal Hocko wrote:
> > >
> > > Although I have to say openly that I am not a great fan of VM_FAULT_OOM
> > > in general. It is usually a a wrong way to tell the handle the failure
> > > because it happens outside of the allocation context so you lose all the
> > > details (e.g. allocation constrains, numa policy etc.). Also whenever
> > > there is ENOMEM then the allocation itself has already made sure that
> > > all the reclaim attempts have been already depleted. Just consider an
> > > allocation with GFP_NOWAIT/NO_RETRY or similar to fail and propagate
> > > ENOMEM up the call stack. Turning that into the OOM killer sounds like a
> > > bad idea to me.  But that is a more general topic. I have tried to bring
> > > this up in the past but there was not much of an interest to fix it as
> > > it was not a pressing problem...
> > > 
> > 
> > I'm certainly interested; it would mean that we actually want to try
> > recovering from VM_FAULT_OOM in various cases, and as you state, we might
> > have to supply more information to make that work reliably.
> 
> Or maybe we want to get rid of VM_FAULT_OOM altogether... But this is
> really tangent to this discussion. The only relation is that this would
> be another place to check when somebody wants to go that direction.

If we are to get rid of VM_FAULT_OOM, vmf_error() would be updated and this
place will get the update automagically.

> > Having that said, I guess what we have here is just the same as when our
> > process fails to allocate a generic page table in __handle_mm_fault(), when
> > we fail p4d_alloc() and friends ...
> 
> From a quick look it is really similar in a sense that it effectively never
> happens and if it does then it certainly does the wrong thing. The point
> I was trying to make is that there is likely no need to go that way.

As David pointed out, failure to handle direct map in secretmem_fault() is
like any allocation failure in page fault handling and most of them result
in VM_FAULT_OOM, so I think that having vmf_error() in secretmem_fault() is
more consistent with the rest of the code than using VM_FAULT_SIGBUS.

Besides if the direct map manipulation failures would result in errors
other than -ENOMEM, having vmf_error() may prove useful.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C062387685
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 May 2021 12:31:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9981D100F2243;
	Tue, 18 May 2021 03:31:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 67A3F100F2240
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 03:31:11 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1621333869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11zOMNPLAXlfQ0IrA6mDqgUqLx9G4ocdGPmWlci12vs=;
	b=bCoq0/YrkDVfJ7aWUPtL/xVkLxy11Ug+HfDnAxDrJFs7J6MgrDlXYRSDS7vwtswRGIHJJl
	uObdMarvUwYFhAdiJHuWUmf5YEujX5yzqduBIhu8Ofk+r5f5M4cJzTltdLBU5nTztdSQFT
	kY0Rtk5Y/SQujsAoM5OCY/XuAUnk3fA=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 99DFCAFEC;
	Tue, 18 May 2021 10:31:09 +0000 (UTC)
Date: Tue, 18 May 2021 12:31:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <YKOXbNWvUsqM4uxb@dhcp22.suse.cz>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
 <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
 <YKDJ1L7XpJRQgSch@kernel.org>
 <YKOP5x8PPbqzcsdK@dhcp22.suse.cz>
 <8e114f09-60e4-2343-1c42-1beaf540c150@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8e114f09-60e4-2343-1c42-1beaf540c150@redhat.com>
Message-ID-Hash: I7OJTJATKPX5O3OLEKY6FQ2NN3WGGU4D
X-Message-ID-Hash: I7OJTJATKPX5O3OLEKY6FQ2NN3WGGU4D
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.ne
 t>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I7OJTJATKPX5O3OLEKY6FQ2NN3WGGU4D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 18-05-21 12:06:42, David Hildenbrand wrote:
> On 18.05.21 11:59, Michal Hocko wrote:
> > On Sun 16-05-21 10:29:24, Mike Rapoport wrote:
> > > On Fri, May 14, 2021 at 11:25:43AM +0200, David Hildenbrand wrote:
> > [...]
> > > > > +		if (!page)
> > > > > +			return VM_FAULT_OOM;
> > > > > +
> > > > > +		err = set_direct_map_invalid_noflush(page, 1);
> > > > > +		if (err) {
> > > > > +			put_page(page);
> > > > > +			return vmf_error(err);
> > > > 
> > > > Would we want to translate that to a proper VM_FAULT_..., which would most
> > > > probably be VM_FAULT_OOM when we fail to allocate a pagetable?
> > > 
> > > That's what vmf_error does, it translates -ESOMETHING to VM_FAULT_XYZ.
> > 
> > I haven't read through the rest but this has just caught my attention.
> > Is it really reasonable to trigger the oom killer when you cannot
> > invalidate the direct mapping. From a quick look at the code it is quite
> > unlikely to se ENOMEM from that path (it allocates small pages) but this
> > can become quite sublte over time. Shouldn't this simply SIGBUS if it
> > cannot manipulate the direct mapping regardless of the underlying reason
> > for that?
> > 
> 
> OTOH, it means our kernel zones are depleted, so we'd better reclaim somehow
> ...

Killing a userspace seems to be just a bad way around that.

Although I have to say openly that I am not a great fan of VM_FAULT_OOM
in general. It is usually a a wrong way to tell the handle the failure
because it happens outside of the allocation context so you lose all the
details (e.g. allocation constrains, numa policy etc.). Also whenever
there is ENOMEM then the allocation itself has already made sure that
all the reclaim attempts have been already depleted. Just consider an
allocation with GFP_NOWAIT/NO_RETRY or similar to fail and propagate
ENOMEM up the call stack. Turning that into the OOM killer sounds like a
bad idea to me.  But that is a more general topic. I have tried to bring
this up in the past but there was not much of an interest to fix it as
it was not a pressing problem...
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

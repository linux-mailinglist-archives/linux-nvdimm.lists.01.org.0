Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD333875E7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 May 2021 11:59:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 13AE6100EB350;
	Tue, 18 May 2021 02:59:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F0F55100EB34D
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 02:59:07 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1621331946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b8xv7F9R3YDRWAMnBTpPRwnYRLd13u+yXERM3M4MUTs=;
	b=JS/jDkcP1gH5mTt25RX5I6j86/cz/ZDydaWWHW2hqY8nQAAzE3DLIomRP5iqBIJVDfMfru
	o/w0GyCy15FdVoUInzSjJEpAT5R+5767DWCkHYFbUgNcLAIQDa3PDa25+ejFAKMWeiZdjA
	Bt7ymH4NrrKr2c/O8dhrS2VhugnQsAg=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id BEF56AEAC;
	Tue, 18 May 2021 09:59:05 +0000 (UTC)
Date: Tue, 18 May 2021 11:59:03 +0200
From: Michal Hocko <mhocko@suse.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <YKOP5x8PPbqzcsdK@dhcp22.suse.cz>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
 <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
 <YKDJ1L7XpJRQgSch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YKDJ1L7XpJRQgSch@kernel.org>
Message-ID-Hash: JDZOHKAALZ44JLPE2NYBX2VCEDWFRL5E
X-Message-ID-Hash: JDZOHKAALZ44JLPE2NYBX2VCEDWFRL5E
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysoc
 ki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JDZOHKAALZ44JLPE2NYBX2VCEDWFRL5E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun 16-05-21 10:29:24, Mike Rapoport wrote:
> On Fri, May 14, 2021 at 11:25:43AM +0200, David Hildenbrand wrote:
[...]
> > > +		if (!page)
> > > +			return VM_FAULT_OOM;
> > > +
> > > +		err = set_direct_map_invalid_noflush(page, 1);
> > > +		if (err) {
> > > +			put_page(page);
> > > +			return vmf_error(err);
> > 
> > Would we want to translate that to a proper VM_FAULT_..., which would most
> > probably be VM_FAULT_OOM when we fail to allocate a pagetable?
> 
> That's what vmf_error does, it translates -ESOMETHING to VM_FAULT_XYZ.

I haven't read through the rest but this has just caught my attention.
Is it really reasonable to trigger the oom killer when you cannot
invalidate the direct mapping. From a quick look at the code it is quite
unlikely to se ENOMEM from that path (it allocates small pages) but this
can become quite sublte over time. Shouldn't this simply SIGBUS if it
cannot manipulate the direct mapping regardless of the underlying reason
for that?
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

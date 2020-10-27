Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CFE29A82F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Oct 2020 10:49:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8DE4D16411158;
	Tue, 27 Oct 2020 02:49:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 361AD161C5249
	for <linux-nvdimm@lists.01.org>; Tue, 27 Oct 2020 02:49:01 -0700 (PDT)
Received: from kernel.org (unknown [87.70.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C7CAF20759;
	Tue, 27 Oct 2020 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603792140;
	bh=wcj6sqvr10YA2nIxp8QFswfSebjeDskPYpJl+9Hjv5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=li/s39XFgB24jJSUCjqf8zNKcx6M9bh+uU6phnSX6LJCJRBegjZ0SOdTEugjflO1e
	 WgquGhsCXXsZ3V2YD7JRAQc2nfgUEjBNCSoKoM6GZx5SGcpgMkSqE8zAapjDeCrodZ
	 Fc2zbcZd41+mXwuTSqYXiceoEMKXjGqiG53f7j/s=
Date: Tue, 27 Oct 2020 11:48:45 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v7 3/7] set_memory: allow set_direct_map_*_noflush() for
 multiple pages
Message-ID: <20201027094845.GJ1154158@kernel.org>
References: <20201026083752.13267-1-rppt@kernel.org>
 <20201026083752.13267-4-rppt@kernel.org>
 <e754ae3873e02e398e58091d586fe57e105803db.camel@intel.com>
 <9202c4c1-9f1f-175f-0a85-fc8c30bc5e3b@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9202c4c1-9f1f-175f-0a85-fc8c30bc5e3b@redhat.com>
Message-ID-Hash: PZXDW5K5O3D47MAGXOJNM7PLFCH2VY64
X-Message-ID-Hash: PZXDW5K5O3D47MAGXOJNM7PLFCH2VY64
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "tycho@tycho.ws" <tycho@tycho.ws>, "cl@linux.com" <cl@linux.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "will@kernel.org" <will@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kirill@shutemov.name" <kirill@shutemov.name>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "willy@infradead.org" <willy@infradead.org>, "luto@kernel.org" <luto@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "shuah@kernel.org" <shuah@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.
 01.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "mingo@redhat.com" <mingo@redhat.com>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PZXDW5K5O3D47MAGXOJNM7PLFCH2VY64/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 27, 2020 at 09:12:23AM +0100, David Hildenbrand wrote:
> On 26.10.20 20:01, Edgecombe, Rick P wrote:
> > On Mon, 2020-10-26 at 10:37 +0200, Mike Rapoport wrote:
> >> +++ b/arch/x86/mm/pat/set_memory.c
> >> @@ -2184,14 +2184,14 @@ static int __set_pages_np(struct page *page,
> >> int numpages)
> >>         return __change_page_attr_set_clr(&cpa, 0);
> >>  }
> >>  
> >> -int set_direct_map_invalid_noflush(struct page *page)
> >> +int set_direct_map_invalid_noflush(struct page *page, int numpages)
> >>  {
> >> -       return __set_pages_np(page, 1);
> >> +       return __set_pages_np(page, numpages);
> >>  }
> >>  
> >> -int set_direct_map_default_noflush(struct page *page)
> >> +int set_direct_map_default_noflush(struct page *page, int numpages)
> >>  {
> >> -       return __set_pages_p(page, 1);
> >> +       return __set_pages_p(page, numpages);
> >>  }
> > 
> > Somewhat related to your other series, this could result in large NP
> > pages and trip up hibernate.
> > 
> 
> It feels somewhat desirable to disable hibernation once secretmem is
> enabled, right? Otherwise you'll be writing out your secrets to swap,
> where they will remain even after booting up again ...
> 
> Skipping secretmem pages when hibernating is the wrong approach I guess ...

Completely agree.
I'll look into preventing hibernation from touching secretmem.

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

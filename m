Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB50627CE69
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Sep 2020 15:06:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 87BEF153EB255;
	Tue, 29 Sep 2020 06:06:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D43B152CC040
	for <linux-nvdimm@lists.01.org>; Tue, 29 Sep 2020 06:06:24 -0700 (PDT)
Received: from kernel.org (unknown [87.71.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 6DAC8207F7;
	Tue, 29 Sep 2020 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601384783;
	bh=dKs40EB0zUNqF3k8hOXDHChpW1qE+Tc5ZCaCj+fNcAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkoEdNeBwGUh5IVOWlI3TdmyaJCGl1uUtrsv4V7euPJfzeGsgVr9508rpCKlka84A
	 TsDcDOdrDS9A4AaYCoyZ7lmCOsiredZMHpJsZ/ljNuc5atPQsZJCW42/ujWY54vc/A
	 xHI6TcUVFoTK32LTlL0E1IvYKnm9SRUNQXn1aIps=
Date: Tue, 29 Sep 2020 16:06:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v6 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200929130602.GF2142832@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-4-rppt@kernel.org>
 <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d466e1f13ff615332fe1f513f6c1d763db28bd9a.camel@intel.com>
Message-ID-Hash: KSOGVDJE4KXF6PTMJEWRIMVE6YWW6J4U
X-Message-ID-Hash: KSOGVDJE4KXF6PTMJEWRIMVE6YWW6J4U
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "tycho@tycho.ws" <tycho@tycho.ws>, "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "will@kernel.org" <will@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "idan.yaniv@ibm.com" <idan.yaniv@ibm.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "willy@infradead.org" <willy@infradead.org>, "luto@kernel.org" <luto@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "shuah@kernel.org" <shuah@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-nvdimm@li
 sts.01.org" <linux-nvdimm@lists.01.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "mingo@redhat.com" <mingo@redhat.com>, "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KSOGVDJE4KXF6PTMJEWRIMVE6YWW6J4U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 29, 2020 at 04:58:44AM +0000, Edgecombe, Rick P wrote:
> On Thu, 2020-09-24 at 16:29 +0300, Mike Rapoport wrote:
> > Introduce "memfd_secret" system call with the ability to create
> > memory
> > areas visible only in the context of the owning process and not
> > mapped not
> > only to other processes but in the kernel page tables as well.
> > 
> > The user will create a file descriptor using the memfd_secret()
> > system call
> > where flags supplied as a parameter to this system call will define
> > the
> > desired protection mode for the memory associated with that file
> > descriptor.
> > 
> >  Currently there are two protection modes:
> > 
> > * exclusive - the memory area is unmapped from the kernel direct map
> > and it
> >               is present only in the page tables of the owning mm.
> 
> Seems like there were some concerns raised around direct map
> efficiency, but in case you are going to rework this...how does this
> memory work for the existing kernel functionality that does things like
> this?
> 
> get_user_pages(, &page);
> ptr = kmap(page);
> foo = *ptr;
> 
> Not sure if I'm missing something, but I think apps could cause the
> kernel to access a not-present page and oops.

The idea is that this memory should not be accessible by the kernel, so
the sequence you describe should indeed fail.

Probably oops would be to noisy and in this case the report needs to be
less verbose.

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

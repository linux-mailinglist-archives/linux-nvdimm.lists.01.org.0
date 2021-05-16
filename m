Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E611381D36
	for <lists+linux-nvdimm@lfdr.de>; Sun, 16 May 2021 09:13:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57BE6100EBB61;
	Sun, 16 May 2021 00:13:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 241BD100EC1D5
	for <linux-nvdimm@lists.01.org>; Sun, 16 May 2021 00:13:41 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE3C96115C;
	Sun, 16 May 2021 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1621149218;
	bh=IoT9uozjOozDjgXpC4P6jXJSumTP/QNdfBTNGYn48Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJGadq3iWVyp6JiaaARzML2nDhD/6cxgoukhLb//Cm1oiKYNlw2vGT6JTI7JDXvj2
	 sv01qcX7qz1P0swA1iAeer1zfo0u8w0FM+2xjAKXq5nty+4U8NND5Zd35VzjSdgPvo
	 tDXqQy0wo5sGVwSrA1ulFuVwtCplNbJ71DrU3dWxVebC/bnfBzEDBPZgIZbVXfd0Sk
	 QuBjs82K5fBUBM1+e1y5/3sAud3EurnH6Q3/XujCr4AuuRXHMRs0y7nWOwkAisAJxZ
	 RIgDFv5dORgRpVXtvZRRsIItfRvWQyJQI2ZhrWK1iaupqJoRD9qzvTr0ixi2Std5XI
	 RjQV7hOfflMCg==
Date: Sun, 16 May 2021 10:13:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v19 3/8] set_memory: allow set_direct_map_*_noflush() for
 multiple pages
Message-ID: <YKDGD0k990bBCEGG@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-4-rppt@kernel.org>
 <858e5561-bc7d-4ce1-5cb8-3c333199d52a@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <858e5561-bc7d-4ce1-5cb8-3c333199d52a@redhat.com>
Message-ID-Hash: RXY5RT5WEEUKMFEV6QGUVVL72ASHKA2F
X-Message-ID-Hash: RXY5RT5WEEUKMFEV6QGUVVL72ASHKA2F
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net
 >, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RXY5RT5WEEUKMFEV6QGUVVL72ASHKA2F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 14, 2021 at 10:43:29AM +0200, David Hildenbrand wrote:
> On 13.05.21 20:47, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The underlying implementations of set_direct_map_invalid_noflush() and
> > set_direct_map_default_noflush() allow updating multiple contiguous pages
> > at once.
> > 
> > Add numpages parameter to set_direct_map_*_noflush() to expose this
> > ability with these APIs.
> 
> AFAIKs, your patch #5 right now only calls it with 1 page, do we need this
> change at all? Feels like a leftover from older versions to me where we
> could have had more than a single page.

Right, will drop it. 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

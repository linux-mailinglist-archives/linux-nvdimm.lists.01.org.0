Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5C02D86FF
	for <lists+linux-nvdimm@lfdr.de>; Sat, 12 Dec 2020 15:00:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 89C9C100EBBD9;
	Sat, 12 Dec 2020 06:00:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 39FAF100ED490
	for <linux-nvdimm@lists.01.org>; Sat, 12 Dec 2020 05:59:59 -0800 (PST)
Date: Sat, 12 Dec 2020 15:59:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1607781598;
	bh=W+S3uDjo9SUaklycr1VwLEkb3P+e5VKfy1opxSFjfP4=;
	h=From:To:Cc:Subject:References:In-Reply-To:From;
	b=flXIgTj5QPdmF322uyfveGkWCvdiCUBTDqJEmaQAdBMU+9OnpTfe38HJDNJgc0lH8
	 G3M3nYjTvl4Jk0YTIcL5XhPPhChBAc7qxqYwpPq+/oyL9pin060A7R+FLePp8EI92r
	 GwnqdckCsl6axBY1CL4fx8yH/moiz2Z+oLa3jsxNsEo1pT2EOLhqIregvSKc55N4Zj
	 WuUAHrJAd8PgEDWlSYMQSNKmu4qJ1V3ZA+z2Yx8VyWB6hblUmlV0BHoIXeUaszFyMu
	 HjV36aGN0+weJj3fLUwesb3uBHEoXTzG37NgAFnxayD4MEFDMvTjDeUmf4Kr35XObN
	 Un6GIU6DTV1SA==
From: Mike Rapoport <rppt@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v14 10/10] secretmem: test: add basic selftest for
 memfd_secret(2)
Message-ID: <20201212135940.GD8946@kernel.org>
References: <20201203062949.5484-1-rppt@kernel.org>
 <20201203062949.5484-11-rppt@kernel.org>
 <248f928b-1383-48ea-8584-ec10146e60c9@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <248f928b-1383-48ea-8584-ec10146e60c9@nvidia.com>
Message-ID-Hash: ZJSOAJXB2KFC2NJV43O33A23UP3IB4O4
X-Message-ID-Hash: ZJSOAJXB2KFC2NJV43O33A23UP3IB4O4
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZJSOAJXB2KFC2NJV43O33A23UP3IB4O4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi John,

On Fri, Dec 11, 2020 at 10:16:23PM -0800, John Hubbard wrote:
> On 12/2/20 10:29 PM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> ...
> > +#include "../kselftest.h"
> > +
> > +#define fail(fmt, ...) ksft_test_result_fail(fmt, ##__VA_ARGS__)
> > +#define pass(fmt, ...) ksft_test_result_pass(fmt, ##__VA_ARGS__)
> > +#define skip(fmt, ...) ksft_test_result_skip(fmt, ##__VA_ARGS__)
> > +
> > +#ifdef __NR_memfd_secret
> > +
> > +#include <linux/secretmem.h>
> 
> Hi Mike,
> 
> Say, when I tried this out from today's linux-next, I had to delete the
> above line. In other words, the following was required in order to build:
> 
> diff --git a/tools/testing/selftests/vm/memfd_secret.c b/tools/testing/selftests/vm/memfd_secret.c
> index 79578dfd13e6..c878c2b841fc 100644
> --- a/tools/testing/selftests/vm/memfd_secret.c
> +++ b/tools/testing/selftests/vm/memfd_secret.c
> @@ -29,8 +29,6 @@
> 
>  #ifdef __NR_memfd_secret
> 
> -#include <linux/secretmem.h>
> -
>  #define PATTERN        0x55
> 
>  static const int prot = PROT_READ | PROT_WRITE;
> 
> 
> ...and that makes sense to me, because:
> 
> a) secretmem.h is not in the uapi, which this selftests/vm build system
>    expects (it runs "make headers_install" for us, which is *not* going
>    to pick up items in the kernel include dirs), and
> 
> b) There is nothing in secretmem.h that this test uses, anyway! Just these:
> 
> bool vma_is_secretmem(struct vm_area_struct *vma);
> bool page_is_secretmem(struct page *page);
> bool secretmem_active(void);
> 
> 
> ...or am I just Doing It Wrong? :)

You are perfectly right, I had a stale header in uapi from the prevoius
versions, the include in the test remained from then.

@Andrew, can you please add the hunk above as a fixup?

> thanks,
> -- 
> John Hubbard
> NVIDIA

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1839314169
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 22:13:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2EC7E100EAB62;
	Mon,  8 Feb 2021 13:13:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4DEDB100EAB60
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 13:13:49 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A15364E8F;
	Mon,  8 Feb 2021 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1612818828;
	bh=Hsw7u4NisXSHdMbN0miFLrU3qob/BtZRKy5D0WtD4mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqkWj9UrgaNlN7tor4WlT/PbjHoDhVkTAWVyRtiehKqBsBIlg2zRzOAntGDW+86wx
	 t9LmuXLRYqrHRZcBc7unC6XAhPNWrMcUUEvHAvwnkCUgMKqMFZnL9bm2GNE5aC4pUI
	 g9uqZwzHwFkcQ+XmsVzR8yYGxPKdKhbTnQ7myE7Mj0cV6qw47j0NdId0MJHEqRslub
	 /el3Boy5sSLWlkjK0Pm94QQLob4G/uLz4vRWnNapLgu2mZBiTSGLPUWdmMesgwLpz4
	 8w43a6xpBzhX2L15Qekz5VMG+RTL22BH8Ov5Tcl9FLLVyaJGQwK59/7ht8rPcFYKmt
	 XQ6gGB3oh8qzg==
Date: Mon, 8 Feb 2021 23:13:26 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210208211326.GV242749@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
 <4996348d-5710-d77d-bb14-d84e370b4a5c@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4996348d-5710-d77d-bb14-d84e370b4a5c@redhat.com>
Message-ID-Hash: VIOQO7BICA4UJUDPMPNQBTNZTY5LCH5Y
X-Message-ID-Hash: VIOQO7BICA4UJUDPMPNQBTNZTY5LCH5Y
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Anders
 en <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VIOQO7BICA4UJUDPMPNQBTNZTY5LCH5Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 08, 2021 at 10:27:18AM +0100, David Hildenbrand wrote:
> On 08.02.21 09:49, Mike Rapoport wrote:
> 
> Some questions (and request to document the answers) as we now allow to have
> unmovable allocations all over the place and I don't see a single comment
> regarding that in the cover letter:
> 
> 1. How will the issue of plenty of unmovable allocations for user space be
> tackled in the future?
> 
> 2. How has this issue been documented? E.g., interaction with ZONE_MOVABLE
> and CMA, alloc_conig_range()/alloc_contig_pages?.

Secretmem sets the mappings gfp mask to GFP_HIGHUSER, so it does not
allocate movable pages at the first place.
 
> 3. How are the plans to support migration in the future and which interface
> changes will be required? (Michal mentioned some good points to make this
> configurable via the interface, we should plan ahead and document)

The only interface change required is an addition of bit value for syscall
flags, I really think it can be documented with the addition of migration
or any other feature for that sake. 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

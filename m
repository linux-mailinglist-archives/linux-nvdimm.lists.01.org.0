Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF931364087
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 13:27:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E9FC100EC1D4;
	Mon, 19 Apr 2021 04:27:27 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CDF2A100EF265
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8kRAoc0QBubKYge5PVOcpXOSqRAXAMW8YeZW9/WtJU8=; b=Q4iGwzjsJleF1GjQOjyti4BwEQ
	kMflgbMlKiSgpC29OgqfVgGrZttP1HwPBGt8N93ehv3ya+xnOskH/kBy+D0N5vT5yUe/+g1v9z/Ma
	Cp4tIDAseOedgjInQg5yHqOEvZbooQDFHeYs8Sryde6A4fQ5slcDMthytLKrH2OJz/4qJDzam9eBn
	p6bjarnH+CdB1hRK/wAvjCp96Ow2EiDF9/3ydKwZwqane+/kvenBjEPU7O5eAiYLGTdXKzhzt0PGo
	DvZtg4i6iUXZmGxEIMN7nGJNjQ60ITQJypATNUfusbk15xxeHMt+n9rKsreyAJad/2eA7Z5Mlaiyn
	rBuUX32A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lYRza-00Dec0-Ty; Mon, 19 Apr 2021 11:23:12 +0000
Date: Mon, 19 Apr 2021 12:23:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
Message-ID: <20210419112302.GX2531743@casper.infradead.org>
References: <20210419084218.7466-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210419084218.7466-1-rppt@kernel.org>
Message-ID-Hash: ATO5GGNY3S5IRBDSWB772S2CDY6EC6P2
X-Message-ID-Hash: ATO5GGNY3S5IRBDSWB772S2CDY6EC6P2
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, S
 huah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ATO5GGNY3S5IRBDSWB772S2CDY6EC6P2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 19, 2021 at 11:42:18AM +0300, Mike Rapoport wrote:
> The perf profile of the test indicated that the regression is caused by
> page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_range):

Uhh ... you're calling it in the wrong place!

                VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
                page = pte_page(pte);

                if (page_is_secretmem(page))
                        goto pte_unmap;

                head = try_grab_compound_head(page, 1, flags);
                if (!head)
                        goto pte_unmap;

So you're calling page_is_secretmem() on a struct page without having
a refcount on it.  That is definitely not allowed.  secretmem seems to
be full of these kinds of races; I know this isn't the first one I've
seen in it.  I don't think this patchset is ready for this merge window.

With that fixed, you'll have a head page that you can use for testing,
which means you don't need to test PageCompound() (because you know the
page isn't PageTail), you can just test PageHead().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

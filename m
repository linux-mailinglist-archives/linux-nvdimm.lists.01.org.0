Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 250322B13DE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Nov 2020 02:35:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23D6E100EC1F9;
	Thu, 12 Nov 2020 17:35:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6CF52100EC1F8
	for <linux-nvdimm@lists.01.org>; Thu, 12 Nov 2020 17:35:04 -0800 (PST)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 6C4A3216C4;
	Fri, 13 Nov 2020 01:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1605231303;
	bh=7IlWDoYFw6qKRjH3BOF82R+49xhuW2KtSCCfIWH1mkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p0qhu8FlLRBehX3rgLy1uFImTw0miiTwEZpreJOS2JwqBOK7aypH/FXHF7H7cSQaJ
	 99y8LK9p6OmIEjarwU8D+b4yDZG1JvcRwCGKSU23kxdHuvZhv3MoS/AuK35nuazPZd
	 cG0gF1kwLqiFd64IeHBis7a9eoZv0ffsedBM0C8A=
Date: Thu, 12 Nov 2020 17:35:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v8 6/9] secretmem: add memcg accounting
Message-Id: <20201112173500.2556342ceefdbe0d66347ecd@linux-foundation.org>
In-Reply-To: <20201110151444.20662-7-rppt@kernel.org>
References: <20201110151444.20662-1-rppt@kernel.org>
	<20201110151444.20662-7-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: 3M5ZPRRVGU6ZHT2HSUKCIEQWXGXBCIE7
X-Message-ID-Hash: 3M5ZPRRVGU6ZHT2HSUKCIEQWXGXBCIE7
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.o
 rg, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3M5ZPRRVGU6ZHT2HSUKCIEQWXGXBCIE7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2020 17:14:41 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> Account memory consumed by secretmem to memcg. The accounting is updated
> when the memory is actually allocated and freed.

From: Andrew Morton <akpm@linux-foundation.org>
Subject: secretmem-add-memcg-accounting-fix

fix CONFIG_MEMCG=n build

Cc: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/filemap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/filemap.c~secretmem-add-memcg-accounting-fix
+++ a/mm/filemap.c
@@ -844,7 +844,7 @@ static noinline int __add_to_page_cache_
 	page->mapping = mapping;
 	page->index = offset;
 
-	if (!huge && !page->memcg_data) {
+	if (!huge && !page_memcg(page)) {
 		error = mem_cgroup_charge(page, current->mm, gfp);
 		if (error)
 			goto error;
_
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

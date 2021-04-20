Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85127365BAD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 17:01:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4087A100F226D;
	Tue, 20 Apr 2021 08:01:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 40681100F226B
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 08:01:17 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 755236024A;
	Tue, 20 Apr 2021 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1618930876;
	bh=YWZWy73tqvCKAkk9V8YhZ1ig6ylDklRIyvUgj9G3Qqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvfI48GQEUCgATQPRlh15VnMXoZu3ZrAzlargumz56omxGHSsgZ+X25Jm4uXtaP9d
	 ZD8syRRrFQUMViRfNfGpwdlmr2B9H0YhE5g8MUwgj77Qx2P2KF7DwOhOnpLzhAnjUK
	 78OGltrp46CIQR/BM0JZX4HYJTh1d4/YWOs9Mpqe8qVUCcsHXj6tcbDuq5s+irERZY
	 1RNUZhlewg3bN1Hm3jmlnu1QSIsyknis7N9xgq+PavSOMRHXHp3DG9eKucgLw1TPNM
	 wzWKpK6wyMtFcYr3RYfN9G6HVQdYyX+LHEnbZLQi8iWG535paN1bFibNloawn8SNOc
	 xGt5UMlHKdsOQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 1/2] secretmem/gup: don't check if page is secretmem without reference
Date: Tue, 20 Apr 2021 18:00:48 +0300
Message-Id: <20210420150049.14031-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210420150049.14031-1-rppt@kernel.org>
References: <20210420150049.14031-1-rppt@kernel.org>
MIME-Version: 1.0
Message-ID-Hash: YRAL62YN4QDFO7MCSGL4L65DL2CFMGAX
X-Message-ID-Hash: YRAL62YN4QDFO7MCSGL4L65DL2CFMGAX
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel B
 utt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YRAL62YN4QDFO7MCSGL4L65DL2CFMGAX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Mike Rapoport <rppt@linux.ibm.com>

The check in gup_pte_range() whether a page belongs to a secretmem mapping
is performed before grabbing the page reference.

To avoid potential race move the check after try_grab_compound_head().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/gup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index c3a17b189064..6515f82b0f32 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2080,13 +2080,15 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
-		if (page_is_secretmem(page))
-			goto pte_unmap;
-
 		head = try_grab_compound_head(page, 1, flags);
 		if (!head)
 			goto pte_unmap;
 
+		if (unlikely(page_is_secretmem(page))) {
+			put_compound_head(head, 1, flags);
+			goto pte_unmap;
+		}
+
 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
 			put_compound_head(head, 1, flags);
 			goto pte_unmap;
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

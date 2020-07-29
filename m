Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA5231834
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 05:36:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F7C312693ECD;
	Tue, 28 Jul 2020 20:36:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by ml01.01.org (Postfix) with ESMTP id AB1C712664311
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 20:36:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14AB831B;
	Tue, 28 Jul 2020 20:36:00 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D9883F66E;
	Tue, 28 Jul 2020 20:35:52 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH 6/6] arm64: fall back to vmemmap_populate_basepages if not aligned  with PMD_SIZE
Date: Wed, 29 Jul 2020 11:34:24 +0800
Message-Id: <20200729033424.2629-7-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Message-ID-Hash: M6W4VTZYOE7GTXSK4S5COXA6S74EG24S
X-Message-ID-Hash: M6W4VTZYOE7GTXSK4S5COXA6S74EG24S
X-MailFrom: justin.he@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <steve.capper@arm.com>, Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M6W4VTZYOE7GTXSK4S5COXA6S74EG24S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In dax pmem kmem (dax pmem used as RAM device) case, the start address
might not be aligned with PMD_SIZE
e.g.
240000000-33fdfffff : Persistent Memory
  240000000-2421fffff : namespace0.0
  242400000-2bfffffff : dax0.0
    242400000-2bfffffff : System RAM (kmem)
pfn_to_page(0x242400000) is fffffe0007e90000.

Without this patch, vmemmap_populate(fffffe0007e90000, ...) will incorrectly
create a pmd mapping [fffffe0007e00000, fffffe0008000000] which contains
fffffe0007e90000.

This adds the check and then falls back to vmemmap_populate_basepages()

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/mm/mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d69feb2cfb84..3b21bd47e801 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1102,6 +1102,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 
 	do {
 		next = pmd_addr_end(addr, end);
+		if (next - addr < PMD_SIZE) {
+			vmemmap_populate_basepages(start, next, node, altmap);
+			continue;
+		}
 
 		pgdp = vmemmap_pgd_populate(addr, node);
 		if (!pgdp)
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

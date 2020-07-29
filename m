Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6F231830
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 05:35:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6938C11460B21;
	Tue, 28 Jul 2020 20:35:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by ml01.01.org (Postfix) with ESMTP id 8B3111143B072
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 20:35:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1581D31B;
	Tue, 28 Jul 2020 20:35:44 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9ACF53F66E;
	Tue, 28 Jul 2020 20:35:36 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH 4/6] mm/page_alloc: adjust the start,end in dax pmem kmem case
Date: Wed, 29 Jul 2020 11:34:22 +0800
Message-Id: <20200729033424.2629-5-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Message-ID-Hash: YNDPXKMQGVGRJJYRDQSV7UGV6YCC6VOK
X-Message-ID-Hash: YNDPXKMQGVGRJJYRDQSV7UGV6YCC6VOK
X-MailFrom: justin.he@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <steve.capper@arm.com>, Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YNDPXKMQGVGRJJYRDQSV7UGV6YCC6VOK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are 3 cases when doing online pages:
 - normal RAM, should be aligned with memory block size
 - persistent memory with ZONE_DEVICE
 - persistent memory used as normal RAM (kmem) with ZONE_NORMAL, this patch
   tries to adjust the start_pfn/end_pfn after finding the corresponding
   resource range.

Without this patch, the check of __init_single_page when doing online memory
will be failed because those pages haven't been mapped in mmu(not present
from mmu's point of view).

Signed-off-by: Jia He <justin.he@arm.com>
---
 mm/page_alloc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e028b87ce294..13216ab3623f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5971,6 +5971,20 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (start_pfn == altmap->base_pfn)
 			start_pfn += altmap->reserve;
 		end_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
+	} else {
+		struct resource res;
+		int ret;
+
+		/* adjust the start,end in dax pmem kmem case */
+		ret = find_next_iomem_res(start_pfn << PAGE_SHIFT,
+			(end_pfn << PAGE_SHIFT) - 1,
+			IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+			IORES_DESC_PERSISTENT_MEMORY,
+			false, &res);
+		if (!ret) {
+			start_pfn = PFN_UP(res.start);
+			end_pfn = PFN_DOWN(res.end + 1);
+		}
 	}
 #endif
 
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

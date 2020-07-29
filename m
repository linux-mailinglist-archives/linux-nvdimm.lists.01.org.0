Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF54231832
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 05:35:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 85F4912664311;
	Tue, 28 Jul 2020 20:35:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by ml01.01.org (Postfix) with ESMTP id 8801A11460B21
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 20:35:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F46A31B;
	Tue, 28 Jul 2020 20:35:52 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93FEF3F66E;
	Tue, 28 Jul 2020 20:35:44 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH 5/6] device-dax: relax the memblock size alignment for kmem_start
Date: Wed, 29 Jul 2020 11:34:23 +0800
Message-Id: <20200729033424.2629-6-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Message-ID-Hash: OEULDM2NPRBIUIZTNTITSSNHABF2VJGU
X-Message-ID-Hash: OEULDM2NPRBIUIZTNTITSSNHABF2VJGU
X-MailFrom: justin.he@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <steve.capper@arm.com>, Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OEULDM2NPRBIUIZTNTITSSNHABF2VJGU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Previously, kmem_start in dev_dax_kmem_probe should be aligned with
SECTION_SIZE_BITS(30), i.e. 1G memblock size on arm64. Even with Dan
Williams' sub-section patch series, it was not helpful when adding the
dax pmem kmem to memblock:
$ndctl create-namespace -e namespace0.0 --mode=devdax --map=dev -s 2g -f -a 2M
$echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
$echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
$cat /proc/iomem
...
23c000000-23fffffff : System RAM
  23dd40000-23fecffff : reserved
  23fed0000-23fffffff : reserved
240000000-33fdfffff : Persistent Memory
  240000000-2403fffff : namespace0.0
  280000000-2bfffffff : dax0.0          <- boundary are aligned with 1G
    280000000-2bfffffff : System RAM (kmem)
$ lsmem
RANGE                                 SIZE  STATE REMOVABLE BLOCK
0x0000000040000000-0x000000023fffffff   8G online       yes   1-8
0x0000000280000000-0x00000002bfffffff   1G online       yes    10

Memory block size:         1G
Total online memory:       9G
Total offline memory:      0B
...
Hence there is a big gap between 0x2403fffff and 0x280000000 due to the 1G
alignment on arm64. More than that, only 1G memory is returned while 2G is
requested.

On x86, the gap is relatively small due to SECTION_SIZE_BITS(27).

Besides descreasing SECTION_SIZE_BITS on arm64, we can relax the alignment
when adding the kmem.
After this patch:
240000000-33fdfffff : Persistent Memory
  240000000-2421fffff : namespace0.0
  242400000-2bfffffff : dax0.0
    242400000-2bfffffff : System RAM (kmem)
$ lsmem
RANGE                                 SIZE  STATE REMOVABLE BLOCK
0x0000000040000000-0x00000002bfffffff  10G online       yes  1-10

Memory block size:         1G
Total online memory:      10G
Total offline memory:      0B

Notes, block 9-10 are the newly hotplug added.

This patches remove the tight alignment constraint of
memory_block_size_bytes(), but still keep the constraint from
online_pages_range().

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/dax/kmem.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index d77786dc0d92..849d0706dfe0 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -30,9 +30,20 @@ int dev_dax_kmem_probe(struct device *dev)
 	const char *new_res_name;
 	int numa_node;
 	int rc;
+	int order;
 
-	/* Hotplug starting at the beginning of the next block: */
-	kmem_start = ALIGN(res->start, memory_block_size_bytes());
+	/* kmem_start needn't be aligned with memory_block_size_bytes().
+	 * But given the constraint in online_pages_range(), adjust the
+	 * alignment of kmem_start and kmem_size
+	 */
+	kmem_size = resource_size(res);
+	order = min_t(int, MAX_ORDER - 1, get_order(kmem_size));
+	kmem_start = ALIGN(res->start, 1ul << (order + PAGE_SHIFT));
+	/* Adjust the size down to compensate for moving up kmem_start: */
+	kmem_size -= kmem_start - res->start;
+	/* Align the size down to cover only complete blocks: */
+	kmem_size &= ~((1ul << (order + PAGE_SHIFT)) - 1);
+	kmem_end = kmem_start + kmem_size;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -48,13 +59,6 @@ int dev_dax_kmem_probe(struct device *dev)
 			numa_node, res);
 	}
 
-	kmem_size = resource_size(res);
-	/* Adjust the size down to compensate for moving up kmem_start: */
-	kmem_size -= kmem_start - res->start;
-	/* Align the size down to cover only complete blocks: */
-	kmem_size &= ~(memory_block_size_bytes() - 1);
-	kmem_end = kmem_start + kmem_size;
-
 	new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
 	if (!new_res_name)
 		return -ENOMEM;
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

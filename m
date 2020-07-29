Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE10231829
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 05:35:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4AB91143B072;
	Tue, 28 Jul 2020 20:35:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by ml01.01.org (Postfix) with ESMTP id 75F6B12693EC9
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 20:35:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 309D631B;
	Tue, 28 Jul 2020 20:35:12 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A94CC3F66E;
	Tue, 28 Jul 2020 20:35:04 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem alignment
Date: Wed, 29 Jul 2020 11:34:18 +0800
Message-Id: <20200729033424.2629-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Message-ID-Hash: JFWKKAKU6KNYZS5EZ74NWGMHA3FVWNJ7
X-Message-ID-Hash: JFWKKAKU6KNYZS5EZ74NWGMHA3FVWNJ7
X-MailFrom: justin.he@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <steve.capper@arm.com>, Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JFWKKAKU6KNYZS5EZ74NWGMHA3FVWNJ7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When enabling dax pmem as RAM device on arm64, I noticed that kmem_start
addr in dev_dax_kmem_probe() should be aligned w/ SECTION_SIZE_BITS(30),i.e.
1G memblock size. Even Dan Williams' sub-section patch series [1] had been
upstream merged, it was not helpful due to hard limitation of kmem_start:
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
  280000000-2bfffffff : dax0.0          <- aligned with 1G boundary
    280000000-2bfffffff : System RAM
Hence there is a big gap between 0x2403fffff and 0x280000000 due to the 1G
alignment.
 
Without this series, if qemu creates a 4G bytes nvdimm device, we can only
use 2G bytes for dax pmem(kmem) in the worst case.
e.g.
240000000-33fdfffff : Persistent Memory 
We can only use the memblock between [240000000, 2ffffffff] due to the hard
limitation. It wastes too much memory space.

Decreasing the SECTION_SIZE_BITS on arm64 might be an alternative, but there
are too many concerns from other constraints, e.g. PAGE_SIZE, hugetlb,
SPARSEMEM_VMEMMAP, page bits in struct page ...

Beside decreasing the SECTION_SIZE_BITS, we can also relax the kmem alignment
with memory_block_size_bytes().

Tested on arm64 guest and x86 guest, qemu creates a 4G pmem device. dax pmem
can be used as ram with smaller gap. Also the kmem hotplug add/remove are both
tested on arm64/x86 guest.

This patch series (mainly patch6/6) is based on the fixing patch, ~v5.8-rc5 [2].

[1] https://lkml.org/lkml/2019/6/19/67
[2] https://lkml.org/lkml/2020/7/8/1546
Jia He (6):
  mm/memory_hotplug: remove redundant memory block size alignment check
  resource: export find_next_iomem_res() helper
  mm/memory_hotplug: allow pmem kmem not to align with memory_block_size
  mm/page_alloc: adjust the start,end in dax pmem kmem case
  device-dax: relax the memblock size alignment for kmem_start
  arm64: fall back to vmemmap_populate_basepages if not aligned  with
    PMD_SIZE

 arch/arm64/mm/mmu.c    |  4 ++++
 drivers/base/memory.c  | 24 ++++++++++++++++--------
 drivers/dax/kmem.c     | 22 +++++++++++++---------
 include/linux/ioport.h |  3 +++
 kernel/resource.c      |  3 ++-
 mm/memory_hotplug.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 mm/page_alloc.c        | 14 ++++++++++++++
 7 files changed, 90 insertions(+), 19 deletions(-)

-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

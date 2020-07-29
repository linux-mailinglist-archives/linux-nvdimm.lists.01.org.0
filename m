Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937523182A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 05:35:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 16D1D12693ECD;
	Tue, 28 Jul 2020 20:35:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by ml01.01.org (Postfix) with ESMTP id CB1E2124DA51E
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 20:35:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 288FB31B;
	Tue, 28 Jul 2020 20:35:20 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC23E3F66E;
	Tue, 28 Jul 2020 20:35:12 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH 1/6] mm/memory_hotplug: remove redundant memory block size alignment check
Date: Wed, 29 Jul 2020 11:34:19 +0800
Message-Id: <20200729033424.2629-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Message-ID-Hash: ZBYAH4VYQVDAGDBJDSJ675TNIDYLCENW
X-Message-ID-Hash: ZBYAH4VYQVDAGDBJDSJ675TNIDYLCENW
X-MailFrom: justin.he@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <steve.capper@arm.com>, Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZBYAH4VYQVDAGDBJDSJ675TNIDYLCENW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The alignment check has been done by check_hotplug_memory_range(). Hence
the redundant one in create_memory_block_devices() can be removed.

The similar redundant check is removed in remove_memory_block_devices().

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/base/memory.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 2b09b68b9f78..4a1691664c6c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -642,10 +642,6 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
 	unsigned long block_id;
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!IS_ALIGNED(start, memory_block_size_bytes()) ||
-			 !IS_ALIGNED(size, memory_block_size_bytes())))
-		return -EINVAL;
-
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
 		ret = init_memory_block(&mem, block_id, MEM_OFFLINE);
 		if (ret)
@@ -678,10 +674,6 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 	struct memory_block *mem;
 	unsigned long block_id;
 
-	if (WARN_ON_ONCE(!IS_ALIGNED(start, memory_block_size_bytes()) ||
-			 !IS_ALIGNED(size, memory_block_size_bytes())))
-		return;
-
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
 		mem = find_memory_block_by_id(block_id);
 		if (WARN_ON_ONCE(!mem))
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

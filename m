Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9121CA43
	for <lists+linux-nvdimm@lfdr.de>; Sun, 12 Jul 2020 18:43:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC22911591333;
	Sun, 12 Jul 2020 09:43:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3009311591335
	for <linux-nvdimm@lists.01.org>; Sun, 12 Jul 2020 09:43:11 -0700 (PDT)
IronPort-SDR: oxil0aeEooMbqmM33bK2xykCXnHeRrjBDK8w7g+dBSGoS7Rwn0vlf9RdLrlVj2iWlpU/XA+oAo
 WpIYP+uU5pNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="136684092"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800";
   d="scan'208";a="136684092"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:10 -0700
IronPort-SDR: 27vxU/aLlqv79KvYOLH2qbf9/YWf5mKnBzFqWATuXAothYSGPge8Rb4732ye8OfmhkyKLSeTVG
 CoQH6Nu/4FBw==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800";
   d="scan'208";a="458998429"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:10 -0700
Subject: [PATCH v2 09/22] arm64: Convert to generic memblock for numa-info
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 12 Jul 2020 09:26:54 -0700
Message-ID: <159457121480.754248.17292511837648775358.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: PJXPROCYZ3UO3WWLT4Z4KL3X4RN2TVS2
X-Message-ID-Hash: PJXPROCYZ3UO3WWLT4Z4KL3X4RN2TVS2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mike Rapoport <rppt@linux.ibm.com>, Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PJXPROCYZ3UO3WWLT4Z4KL3X4RN2TVS2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the existing memory_add_physaddr_to_nid() stub and add support for
phys_to_target_node() by selecting the generic CONFIG_MEMBLOCK_NUMAINFO
mechanism for querying firmware numa data at runtime.

Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Jia He <justin.he@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm64/Kconfig   |    1 +
 arch/arm64/mm/numa.c |   10 ----------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4a094bedcb2..cfef26ce8c0c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -65,6 +65,7 @@ config ARM64
 	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
 	select ARCH_KEEP_MEMBLOCK
+	select MEMBLOCK_NUMA_INFO
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_GNU_PROPERTY
 	select ARCH_USE_QUEUED_RWLOCKS
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index aafcee3e3f7e..73f8b49d485c 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -461,13 +461,3 @@ void __init arm64_numa_init(void)
 
 	numa_init(dummy_numa_init);
 }
-
-/*
- * We hope that we will be hotplugging memory on nodes we already know about,
- * such that acpi_get_node() succeeds and we never fall back to this...
- */
-int memory_add_physaddr_to_nid(u64 addr)
-{
-	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
-	return 0;
-}
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB703216612
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 07:59:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B09D1108DEB2;
	Mon,  6 Jul 2020 22:59:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by ml01.01.org (Postfix) with ESMTP id 11ED41108DEB2
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 22:59:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 381CCD6E;
	Mon,  6 Jul 2020 22:59:37 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 806363F68F;
	Mon,  6 Jul 2020 22:59:32 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
Date: Tue,  7 Jul 2020 13:59:15 +0800
Message-Id: <20200707055917.143653-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707055917.143653-1-justin.he@arm.com>
References: <20200707055917.143653-1-justin.he@arm.com>
Message-ID-Hash: NKB4TXX4DAHCGROOPEFLD4J5EX2AE6X7
X-Message-ID-Hash: NKB4TXX4DAHCGROOPEFLD4J5EX2AE6X7
X-MailFrom: justin.he@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NKB4TXX4DAHCGROOPEFLD4J5EX2AE6X7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This exports memory_add_physaddr_to_nid() for module driver to use.

memory_add_physaddr_to_nid() is a fallback option to get the nid in case
NUMA_NO_NID is detected.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/mm/numa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index aafcee3e3f7e..7eeb31740248 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
 
 /*
  * We hope that we will be hotplugging memory on nodes we already know about,
- * such that acpi_get_node() succeeds and we never fall back to this...
+ * such that acpi_get_node() succeeds. But when SRAT is not present, the node
+ * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
  */
 int memory_add_physaddr_to_nid(u64 addr)
 {
-	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

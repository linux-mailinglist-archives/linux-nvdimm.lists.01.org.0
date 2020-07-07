Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 993FB216616
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 07:59:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 700881108DED0;
	Mon,  6 Jul 2020 22:59:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by ml01.01.org (Postfix) with ESMTP id EF5601108E904
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 22:59:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6489531B;
	Mon,  6 Jul 2020 22:59:42 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5C823F68F;
	Mon,  6 Jul 2020 22:59:37 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node is invalid
Date: Tue,  7 Jul 2020 13:59:16 +0800
Message-Id: <20200707055917.143653-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707055917.143653-1-justin.he@arm.com>
References: <20200707055917.143653-1-justin.he@arm.com>
Message-ID-Hash: K5NDMHU2R567JOGYEJ3XRLETNA4JECOS
X-Message-ID-Hash: K5NDMHU2R567JOGYEJ3XRLETNA4JECOS
X-MailFrom: justin.he@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K5NDMHU2R567JOGYEJ3XRLETNA4JECOS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Previously, numa_off is set unconditionally at the end of dummy_numa_init(),
even with a fake numa node. Then ACPI detects node id as NUMA_NO_NODE(-1) in
acpi_map_pxm_to_node() because it regards numa_off as turning off the numa
node. Hence dev_dax->target_node is NUMA_NO_NODE on arm64 with fake numa.

Without this patch, pmem can't be probed as a RAM device on arm64 if SRAT table
isn't present:
$ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -a 64K
kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with invalid node: -1
kmem: probe of dax0.0 failed with error -22

This fixes it by using fallback memory_add_physaddr_to_nid() as nid.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
I noticed that on powerpc memory_add_physaddr_to_nid is not exported for module
driver. Set it to RFC due to this concern.

 drivers/dax/kmem.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 275aa5f87399..68e693ca6d59 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -28,20 +28,22 @@ int dev_dax_kmem_probe(struct device *dev)
 	resource_size_t kmem_end;
 	struct resource *new_res;
 	const char *new_res_name;
-	int numa_node;
+	int numa_node, new_node;
 	int rc;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
-	 * Without this check, there is a risk that slow memory
-	 * could be mixed in a node with faster memory, causing
-	 * unavoidable performance issues.
+	 * Without this check, there is a risk but not fatal that slow
+	 * memory could be mixed in a node with faster memory, causing
+	 * unavoidable performance issues. Furthermore, fallback node
+	 * id can be used when numa_node is invalid.
 	 */
 	numa_node = dev_dax->target_node;
 	if (numa_node < 0) {
-		dev_warn(dev, "rejecting DAX region %pR with invalid node: %d\n",
-			 res, numa_node);
-		return -EINVAL;
+		new_node = memory_add_physaddr_to_nid(kmem_start);
+		dev_info(dev, "changing nid from %d to %d for DAX region %pR\n",
+			numa_node, new_node, res);
+		numa_node = new_node;
 	}
 
 	/* Hotplug starting at the beginning of the next block: */
@@ -100,6 +102,7 @@ static int dev_dax_kmem_remove(struct device *dev)
 	resource_size_t kmem_start = res->start;
 	resource_size_t kmem_size = resource_size(res);
 	const char *res_name = res->name;
+	int numa_node = dev_dax->target_node;
 	int rc;
 
 	/*
@@ -108,7 +111,10 @@ static int dev_dax_kmem_remove(struct device *dev)
 	 * there is no way to hotremove this memory until reboot because device
 	 * unbind will succeed even if we return failure.
 	 */
-	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
+	if (numa_node < 0)
+		numa_node = memory_add_physaddr_to_nid(kmem_start);
+
+	rc = remove_memory(numa_node, kmem_start, kmem_size);
 	if (rc) {
 		any_hotremove_failed = true;
 		dev_err(dev,
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

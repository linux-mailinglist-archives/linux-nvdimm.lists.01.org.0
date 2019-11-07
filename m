Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C268BF266B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 05:12:25 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A702B100DC2AE;
	Wed,  6 Nov 2019 20:14:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A7177100DC2AA
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 20:14:51 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:12:19 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400";
   d="scan'208";a="206041327"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:12:19 -0800
Subject: [PATCH 16/16] libnvdimm/e820: Retrieve and populate correct
 'target_node' info
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 06 Nov 2019 19:58:03 -0800
Message-ID: <157309908326.1582359.13665017314935413372.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: NQJWQ27QA42D2JIJLWLNMYZNWEHETX5Y
X-Message-ID-Hash: NQJWQ27QA42D2JIJLWLNMYZNWEHETX5Y
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NQJWQ27QA42D2JIJLWLNMYZNWEHETX5Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the new memory_add_physaddr_to_target_node() and
numa_map_to_online_node() helpers to retrieve the correct id for
the 'numa_node' (online initiator) and 'target_node' (offline target
memory node) sysfs attributes.

Below is an example from a 4 numa node system where all the memory on
node2 is pmem / reserved. It should be noted that with the arrival of
the ACPI HMAT table and EFI Specific Purpose Memory the kernel will
start to see more platforms with reserved / performance differentiated
memory in its own numa node. Hence all the stakeholders on the Cc for
what is ostensibly a libnvdimm local patch.

=== Before ===

/* Notice no online memory on node2 at start */

# numactl --hardware
available: 3 nodes (0-1,3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
node 0 size: 3958 MB
node 0 free: 3708 MB
node 1 cpus: 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
node 1 size: 4027 MB
node 1 free: 3871 MB
node 3 cpus:
node 3 size: 3994 MB
node 3 free: 3971 MB
node distances:
node   0   1   3
  0:  10  21  21
  1:  21  10  21
  3:  21  21  10

/*
 * Put the pmem namespace into devdax mode so it can be assigned to the
 * kmem driver
 */

# ndctl create-namespace -e namespace0.0 -m devdax -f
{
  "dev":"namespace0.0",
  "mode":"devdax",
  "map":"dev",
  "size":"3.94 GiB (4.23 GB)",
  "uuid":"1650af9b-9ba3-4704-acd6-10178399d9a3",
  [..]
}

/* Online Persistent Memory as System RAM */

# daxctl reconfigure-device --mode=system-ram dax0.0
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
[
  {
    "chardev":"dax0.0",
    "size":4225761280,
    "target_node":0,
    "mode":"system-ram"
  }
]
reconfigured 1 device

/* Note that the memory is onlined by default to the wrong node, node0 */

# numactl --hardware
available: 3 nodes (0-1,3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
node 0 size: 7926 MB
node 0 free: 7655 MB
node 1 cpus: 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
node 1 size: 4027 MB
node 1 free: 3871 MB
node 3 cpus:
node 3 size: 3994 MB
node 3 free: 3971 MB
node distances:
node   0   1   3
  0:  10  21  21
  1:  21  10  21
  3:  21  21  10


=== After ===

/* Notice that the "phys_index" error messages are gone */

# daxctl reconfigure-device --mode=system-ram dax0.0
[
  {
    "chardev":"dax0.0",
    "size":4225761280,
    "target_node":2,
    "mode":"system-ram"
  }
]
reconfigured 1 device

/* Notice that node2 is now correctly populated */

# numactl --hardware
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
node 0 size: 3958 MB
node 0 free: 3793 MB
node 1 cpus: 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
node 1 size: 4027 MB
node 1 free: 3851 MB
node 2 cpus:
node 2 size: 3968 MB
node 2 free: 3968 MB
node 3 cpus:
node 3 size: 3994 MB
node 3 free: 3908 MB
node distances:
node   0   1   2   3
  0:  10  21  21  21
  1:  21  10  21  21
  2:  21  21  10  21
  3:  21  21  21  10

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/e820.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index b802291bcde1..23121dd6e494 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -20,11 +20,12 @@ static int e820_register_one(struct resource *res, void *data)
 {
 	struct nd_region_desc ndr_desc;
 	struct nvdimm_bus *nvdimm_bus = data;
+	int nid = memory_add_physaddr_to_target_node(res->start);
 
 	memset(&ndr_desc, 0, sizeof(ndr_desc));
 	ndr_desc.res = res;
-	ndr_desc.numa_node = memory_add_physaddr_to_nid(res->start);
-	ndr_desc.target_node = ndr_desc.numa_node;
+	ndr_desc.numa_node = numa_map_to_online_node(nid);
+	ndr_desc.target_node = nid;
 	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
 	if (!nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc))
 		return -ENXIO;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

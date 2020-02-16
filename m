Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D71B6160629
	for <lists+linux-nvdimm@lfdr.de>; Sun, 16 Feb 2020 21:16:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 15B741007A830;
	Sun, 16 Feb 2020 12:20:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E23081007B8E0
	for <linux-nvdimm@lists.01.org>; Sun, 16 Feb 2020 12:20:04 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 12:16:47 -0800
X-IronPort-AV: E=Sophos;i="5.70,450,1574150400";
   d="scan'208";a="381986279"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 12:16:47 -0800
Subject: [PATCH v5 0/6] Memory Hierarchy: Enable target node lookups for
 reserved memory
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 16 Feb 2020 12:00:42 -0800
Message-ID: <158188324272.894464.5941332130956525504.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: ISHPEJ6GPO4J3PPMW77G7RGWUPB7MOFX
X-Message-ID-Hash: ISHPEJ6GPO4J3PPMW77G7RGWUPB7MOFX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kbuild test robot <lkp@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ISHPEJ6GPO4J3PPMW77G7RGWUPB7MOFX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v4 [1]:
- Rename CONFIG_KEEP_NUMA to CONFIG_NUMA_KEEP_MEMINFO (Ingo)
- Rename __initdata_numa to __initdata_or_meminfo (Thomas)
- Capitalize NUMA throughout (Ingo)
- Replace explicit memcpy with implicit structure copy to address an 80
  column violation, and fixup a function definition line-wrap (Ingo)
- Rename numa_move_memblk() to numa_move_tail_memblk(), and remove the
  stale kernel-doc that implied @dst was optional (Thomas)
- Comment that phys_to_target_node() is an optional arch implementation
  detail that consumers must gate with "depends on $ARCH"
- Apply Ingo's conditional reviewed-by

[1]: http://lore.kernel.org/r/157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com

---

Merge notes: I believe this addresses all outstanding comments, barring
additional feedback I will push to libnvdimm-for-next.

---

Cover:

Arrange for platform NUMA info to be preserved for determining
'target_node' data. Where a 'target_node' is the node a reserved memory
range will become when it is onlined.

This new infrastructure is expected to be more valuable over time for
Memory Tiers / Hierarchy management as more platforms (via the ACPI HMAT
and EFI Specific Purpose Memory) publish reserved or "soft-reserved"
ranges to Linux. Linux system administrators will expect to be able to
interact with those ranges with a unique NUMA node number when/if that
memory is onlined via the dax_kmem driver [2].

One configuration that currently fails to properly convey the target
node for the resulting memory hotplug operation is persistent memory
defined by the memmap=nn!ss parameter. For example, today if node1 is a
memory only node, and all the memory from node1 is specified to
memmap=nn!ss and subsequently onlined, it will end up being onlined as
node0 memory. As it stands, memory_add_physaddr_to_nid() can only
identify online nodes and since node1 in this example has no online cpus
/ memory the target node is initialized node0.

The fix is to preserve rather than discard the numa_meminfo entries that
are relevant for reserved memory ranges, and to uplevel the node
distance helper for determining the "local" (closest) node relative to
an initiator node.

[2]: https://pmem.io/ndctl/daxctl-reconfigure-device.html

---

Dan Williams (6):
      ACPI: NUMA: Up-level "map to online node" functionality
      mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
      powerpc/papr_scm: Switch to numa_map_to_online_node()
      x86/mm: Introduce CONFIG_NUMA_KEEP_MEMINFO
      x86/NUMA: Provide a range-to-target_node lookup facility
      libnvdimm/e820: Retrieve and populate correct 'target_node' info


 arch/powerpc/platforms/pseries/papr_scm.c |   21 ---------
 arch/x86/Kconfig                          |    1 
 arch/x86/mm/numa.c                        |   67 +++++++++++++++++++++++------
 drivers/acpi/numa/srat.c                  |   41 ------------------
 drivers/nvdimm/e820.c                     |   18 ++------
 include/linux/acpi.h                      |   23 ++++++++++
 include/linux/numa.h                      |   30 +++++++++++++
 mm/Kconfig                                |    5 ++
 mm/mempolicy.c                            |   26 +++++++++++
 9 files changed, 140 insertions(+), 92 deletions(-)

base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

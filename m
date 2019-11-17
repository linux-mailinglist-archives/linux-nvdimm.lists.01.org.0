Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04CCFFB0C
	for <lists+linux-nvdimm@lfdr.de>; Sun, 17 Nov 2019 18:58:55 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 376D6100DC408;
	Sun, 17 Nov 2019 09:59:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BB186100DC404
	for <linux-nvdimm@lists.01.org>; Sun, 17 Nov 2019 09:59:56 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:58:50 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400";
   d="scan'208";a="199736051"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:58:50 -0800
Subject: [PATCH v2 00/18] Memory Hierarchy: Enable target node lookups for
 reserved memory
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sun, 17 Nov 2019 09:44:34 -0800
Message-ID: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: ZM3M7VXS2ZMHZ7KGF7JC4W4SSU655AIH
X-Message-ID-Hash: ZM3M7VXS2ZMHZ7KGF7JC4W4SSU655AIH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kbuild test robot <lkp@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZM3M7VXS2ZMHZ7KGF7JC4W4SSU655AIH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v1 [1]:
- Rework numa_map_to_online_node() to be compatible with papr_scm_node()
  (Aneesh)
- Export the 'target_node' attribute for nvdimm regions and namespaces
  (Aneesh)
- Rename memory_add_physaddr_to_target_nid() to phys_to_target_node()
  and make it independent of CONFIG_MEMORY_HOTPLUG=y. Put a weak
  definition in mm/mempolicy.c that can be overridden by an arch
  implementation.
- Fix various build reports (kbuild-robot)
- Collect some reviewed-by's from Aneesh.

[1]: https://lore.kernel.org/r/157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com/

---

As mentioned in the v1 cover letter [1] the libnvdimm device-type cleanup is
intertwined with the new target_node infrastructure. The more interesting
patches for arch and mm folks start at patch 14.

This new infrastructure will prove more valuable over time for Memory
Tiers / Hierarchy management as more platforms (via the ACPI HMAT and
EFI Specific Purpose Memory) publish reserved or "soft-reserved" ranges
to Linux. Linux system administrators will expect to be able to interact
with those ranges with a unique numa node number when/if that memory is
onlined via the dax_kmem driver [2].

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

The first 13 patches are cleanups to make sure that all nvdimm devices
and their children properly export a numa_node attribute, and add a
'target_node' attribute by default to regions and namespaces. The switch
to a device-type is less code and less error prone as a result.

Patch 14 - 17 are the core changes to allow numa node
information for offline memory to be tracked, and to provide a unified
node mapping distance helper across architectures
numa_map_to_online_node.

Patches 18 uses this new capability to fix the conveyance of target_node
information for memmap=nn!ss assignments. See patch 18 for more details
and the test case.

Given the timeframe to the v5.5 merge window I expect patch 14 - 18 will
likely miss due to not enough time to review, but posting them for
feedback nonetheless.

[2]: https://pmem.io/ndctl/daxctl-reconfigure-device.html

---

Dan Williams (18):
      libnvdimm: Move attribute groups to device type
      libnvdimm: Move region attribute group definition
      libnvdimm: Move nd_device_attribute_group to device_type
      libnvdimm: Move nd_numa_attribute_group to device_type
      libnvdimm: Move nd_region_attribute_group to device_type
      libnvdimm: Move nd_mapping_attribute_group to device_type
      libnvdimm: Move nvdimm_attribute_group to device_type
      libnvdimm: Move nvdimm_bus_attribute_group to device_type
      dax: Create a dax device_type
      dax: Simplify root read-only definition for the 'resource' attribute
      libnvdimm: Simplify root read-only definition for the 'resource' attribute
      dax: Add numa_node to the default device-dax attributes
      libnvdimm: Export the target_node attribute for regions and namespaces
      acpi/numa: Up-level "map to online node" functionality
      mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
      powerpc/papr_scm: Switch to numa_map_to_online_node()
      x86/numa: Provide a range-to-target_node lookup facility
      libnvdimm/e820: Retrieve and populate correct 'target_node' info


 arch/powerpc/platforms/pseries/papr_scm.c |   46 ------
 arch/x86/mm/numa.c                        |   76 +++++++++
 drivers/acpi/nfit/core.c                  |    7 -
 drivers/acpi/numa.c                       |   41 -----
 drivers/dax/bus.c                         |   22 ++-
 drivers/nvdimm/btt_devs.c                 |   24 +--
 drivers/nvdimm/bus.c                      |   44 +++++
 drivers/nvdimm/core.c                     |    8 +
 drivers/nvdimm/dax_devs.c                 |   27 +--
 drivers/nvdimm/dimm_devs.c                |   30 ++--
 drivers/nvdimm/e820.c                     |   31 ----
 drivers/nvdimm/namespace_devs.c           |   77 +++++-----
 drivers/nvdimm/nd.h                       |    5 -
 drivers/nvdimm/of_pmem.c                  |   13 --
 drivers/nvdimm/pfn_devs.c                 |   38 ++---
 drivers/nvdimm/region_devs.c              |  235 +++++++++++++++--------------
 include/linux/acpi.h                      |   23 +++
 include/linux/libnvdimm.h                 |    7 -
 include/linux/numa.h                      |   17 ++
 mm/mempolicy.c                            |   35 ++++
 20 files changed, 430 insertions(+), 376 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6ADF2643
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 05:10:57 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 170DB100DC3F9;
	Wed,  6 Nov 2019 20:13:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EADBA100DC3F7
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 20:13:22 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:10:52 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400";
   d="scan'208";a="192696501"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:10:52 -0800
Subject: [PATCH 00/16] Memory Hierarchy: Enable target node lookups for
 reserved memory
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 06 Nov 2019 19:56:35 -0800
Message-ID: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: EUKQBHXSKTYRPNI2425LTPORBWKHIDMW
X-Message-ID-Hash: EUKQBHXSKTYRPNI2425LTPORBWKHIDMW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EUKQBHXSKTYRPNI2425LTPORBWKHIDMW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Yes, this patch series looks like a pile of boring libnvdimm cleanups,
but buried at the end are some small gems that testing with libnvdimm
uncovered. These gems will prove more valuable over time for Memory
Hierarchy management as more platforms, via the ACPI HMAT and EFI
Specific Purpose Memory, publish reserved or "soft-reserved" ranges to
Linux. Linux system administrators will expect to be able to interact
with those ranges with a unique numa node number when/if that memory is
onlined via the dax_kmem driver [1].

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

The first 12 patches are cleanups to make sure that all nvdimm devices
and their children properly export a numa_node attribute. The switch to
a device-type is less code and less error prone as a result.

Patch 13 and 14 are the core changes (gems) to allow numa node
information for offline memory to be tracked.

Patches 15 and 16 use this new capability to fix the conveyance of numa
node information for memmap=nn!ss assignments. See patch 16 for more
details.

[1]: https://pmem.io/ndctl/daxctl-reconfigure-device.html

---

Dan Williams (16):
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
      acpi/mm: Up-level "map to online node" functionality
      x86/numa: Provide a range-to-target_node lookup facility
      libnvdimm/e820: Drop the wrapper around memory_add_physaddr_to_nid
      libnvdimm/e820: Retrieve and populate correct 'target_node' info


 arch/powerpc/platforms/pseries/papr_scm.c |   25 ---
 arch/x86/mm/numa.c                        |   72 ++++++++-
 drivers/acpi/nfit/core.c                  |    7 -
 drivers/acpi/numa.c                       |   41 -----
 drivers/dax/bus.c                         |   22 ++-
 drivers/nvdimm/btt_devs.c                 |   24 +--
 drivers/nvdimm/bus.c                      |   15 +-
 drivers/nvdimm/core.c                     |    8 +
 drivers/nvdimm/dax_devs.c                 |   27 +--
 drivers/nvdimm/dimm_devs.c                |   30 ++--
 drivers/nvdimm/e820.c                     |   30 ----
 drivers/nvdimm/namespace_devs.c           |   77 +++++-----
 drivers/nvdimm/nd.h                       |    5 -
 drivers/nvdimm/of_pmem.c                  |   13 --
 drivers/nvdimm/pfn_devs.c                 |   38 ++---
 drivers/nvdimm/region_devs.c              |  235 +++++++++++++++--------------
 include/linux/acpi.h                      |   23 +++
 include/linux/libnvdimm.h                 |    7 -
 include/linux/memory_hotplug.h            |    6 +
 include/linux/numa.h                      |    2 
 mm/mempolicy.c                            |   30 ++++
 21 files changed, 382 insertions(+), 355 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

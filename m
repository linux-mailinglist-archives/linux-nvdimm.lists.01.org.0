Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0287143207
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jan 2020 20:18:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A6AD10097DC0;
	Mon, 20 Jan 2020 11:22:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 07F2A10097DF5
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 11:22:10 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:18:51 -0800
X-IronPort-AV: E=Sophos;i="5.70,343,1574150400";
   d="scan'208";a="425268662"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:18:51 -0800
Subject: [PATCH v3 0/6] Memory Hierarchy: Enable target node lookups for
 reserved memory
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@redhat.com
Date: Mon, 20 Jan 2020 11:02:48 -0800
Message-ID: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: FAAX7K2FOZ674Z5PESRD7CSSB2YDIEC3
X-Message-ID-Hash: FAAX7K2FOZ674Z5PESRD7CSSB2YDIEC3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kbuild test robot <lkp@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FAAX7K2FOZ674Z5PESRD7CSSB2YDIEC3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v2 [1]:
- Fix numa_cleanup_meminfo() to skip trimming reserved ranges to max_pfn.

- Collect Michael's acked-by

[1]: http://lore.kernel.org/r/157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com

---

Merge notes:

x86 folks: This has an ack from Rafael for ACPI, and Michael for Power.
With an x86 ack I plan to take this through the libnvdimm tree provided
the x86 touches look ok to you.

---

Cover:

Arrange for platform numa info to be preserved for determining
'target_node' data. Where a 'target_node' is the node a reserved memory
range will become when it is onlined.

This new infrastructure is expected to be more valuable over time for
Memory Tiers / Hierarchy management as more platforms (via the ACPI HMAT
and EFI Specific Purpose Memory) publish reserved or "soft-reserved"
ranges to Linux. Linux system administrators will expect to be able to
interact with those ranges with a unique numa node number when/if that
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
      x86/mm: Introduce CONFIG_KEEP_NUMA
      x86/numa: Provide a range-to-target_node lookup facility
      libnvdimm/e820: Retrieve and populate correct 'target_node' info


 arch/powerpc/platforms/pseries/papr_scm.c |   21 --------
 arch/x86/Kconfig                          |    1 
 arch/x86/mm/numa.c                        |   74 +++++++++++++++++++++++------
 drivers/acpi/numa/srat.c                  |   41 ----------------
 drivers/nvdimm/e820.c                     |   18 ++-----
 include/linux/acpi.h                      |   23 +++++++++
 include/linux/numa.h                      |   23 +++++++++
 mm/Kconfig                                |    5 ++
 mm/mempolicy.c                            |   35 ++++++++++++++
 9 files changed, 149 insertions(+), 92 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

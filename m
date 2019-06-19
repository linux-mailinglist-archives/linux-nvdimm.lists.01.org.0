Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB04B1CC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 08:05:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8554321962301;
	Tue, 18 Jun 2019 23:05:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 743AF21296419
 for <linux-nvdimm@lists.01.org>; Tue, 18 Jun 2019 23:05:50 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jun 2019 23:05:50 -0700
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; d="scan'208";a="162111580"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jun 2019 23:05:49 -0700
Subject: [PATCH v10 00/13] mm: Sub-section memory hotplug support
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Tue, 18 Jun 2019 22:51:33 -0700
Message-ID: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Qian Cai <cai@lca.pw>,
 linux-nvdimm@lists.01.org, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Changes since v9 [1]:
- Fix multiple issues related to the fact that pfn_valid() has
  traditionally returned true for any pfn in an 'early' (onlined at
  boot) section regardless of whether that pfn represented 'System RAM'.
  Teach pfn_valid() to maintain its traditional behavior in the presence
  of subsections. Specifically, subsection precision for pfn_valid() is
  only considered for non-early / hot-plugged sections. (Qian)

- Related to the first item introduce a SECTION_IS_EARLY
  (->section_mem_map flag) to remove the existing hacks for determining
  an early section by looking at whether the usemap was allocated from the
  slab.

- Kill off the EEXIST hackery in __add_pages(). It breaks
  (arch_add_memory() false-positive) the detection of subsection
  collisions reported by section_activate(). It is also obviated by
  David's recent reworks to move the 'System RAM' request_region() earlier
  in the add_memory() sequence().

- Switch to an arch-independent / static subsection-size of 2MB.
  Otherwise, a per-arch subsection-size is a roadblock on the path to
  persistent memory namespace compatibility across archs. (Jeff)

- Update the changelog for "libnvdimm/pfn: Fix fsdax-mode namespace
  info-block zero-fields" to clarify that the "Cc: stable" is only there
  as safety measure for a distro that decides to backport "libnvdimm/pfn:
  Stop padding pmem namespaces to section alignment", otherwise there is
  no known bug exposure in older kernels. (Andrew)
  
- Drop some redundant subsection checks (Oscar)

- Collect some reviewed-bys

[1]: https://lore.kernel.org/lkml/155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com/

---

The memory hotplug section is an arbitrary / convenient unit for memory
hotplug. 'Section-size' units have bled into the user interface
('memblock' sysfs) and can not be changed without breaking existing
userspace. The section-size constraint, while mostly benign for typical
memory hotplug, has and continues to wreak havoc with 'device-memory'
use cases, persistent memory (pmem) in particular. Recall that pmem uses
devm_memremap_pages(), and subsequently arch_add_memory(), to allocate a
'struct page' memmap for pmem. However, it does not use the 'bottom
half' of memory hotplug, i.e. never marks pmem pages online and never
exposes the userspace memblock interface for pmem. This leaves an
opening to redress the section-size constraint.

To date, the libnvdimm subsystem has attempted to inject padding to
satisfy the internal constraints of arch_add_memory(). Beyond
complicating the code, leading to bugs [2], wasting memory, and limiting
configuration flexibility, the padding hack is broken when the platform
changes this physical memory alignment of pmem from one boot to the
next. Device failure (intermittent or permanent) and physical
reconfiguration are events that can cause the platform firmware to
change the physical placement of pmem on a subsequent boot, and device
failure is an everyday event in a data-center.

It turns out that sections are only a hard requirement of the
user-facing interface for memory hotplug and with a bit more
infrastructure sub-section arch_add_memory() support can be added for
kernel internal usages like devm_memremap_pages(). Here is an analysis
of the current design assumptions in the current code and how they are
addressed in the new implementation:

Current design assumptions:

- Sections that describe boot memory (early sections) are never
  unplugged / removed.

- pfn_valid(), in the CONFIG_SPARSEMEM_VMEMMAP=y, case devolves to a
  valid_section() check

- __add_pages() and helper routines assume all operations occur in
  PAGES_PER_SECTION units.

- The memblock sysfs interface only comprehends full sections

New design assumptions:

- Sections are instrumented with a sub-section bitmask to track (on x86)
  individual 2MB sub-divisions of a 128MB section.

- Partially populated early sections can be extended with additional
  sub-sections, and those sub-sections can be removed with
  arch_remove_memory(). With this in place we no longer lose usable memory
  capacity to padding.

- pfn_valid() is updated to look deeper than valid_section() to also check the
  active-sub-section mask. This indication is in the same cacheline as
  the valid_section() so the performance impact is expected to be
  negligible. So far the lkp robot has not reported any regressions.

- Outside of the core vmemmap population routines which are replaced,
  other helper routines like shrink_{zone,pgdat}_span() are updated to
  handle the smaller granularity. Core memory hotplug routines that deal
  with online memory are not touched.

- The existing memblock sysfs user api guarantees / assumptions are
  not touched since this capability is limited to !online
  !memblock-sysfs-accessible sections.

Meanwhile the issue reports continue to roll in from users that do not
understand when and how the 128MB constraint will bite them. The current
implementation relied on being able to support at least one misaligned
namespace, but that immediately falls over on any moderately complex
namespace creation attempt. Beyond the initial problem of 'System RAM'
colliding with pmem, and the unsolvable problem of physical alignment
changes, Linux is now being exposed to platforms that collide pmem
ranges with other pmem ranges by default [3]. In short,
devm_memremap_pages() has pushed the venerable section-size constraint
past the breaking point, and the simplicity of section-aligned
arch_add_memory() is no longer tenable.

These patches are exposed to the kbuild robot on a subsection-v10 branch
[4], and a preview of the unit test for this functionality is available
on the 'subsection-pending' branch of ndctl [5].

[2]: https://lore.kernel.org/r/155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com
[3]: https://github.com/pmem/ndctl/issues/76
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=subsection-v10
[5]: https://github.com/pmem/ndctl/commit/7c59b4867e1c

---

Dan Williams (13):
      mm/sparsemem: Introduce struct mem_section_usage
      mm/sparsemem: Introduce a SECTION_IS_EARLY flag
      mm/sparsemem: Add helpers track active portions of a section at boot
      mm/hotplug: Prepare shrink_{zone,pgdat}_span for sub-section removal
      mm/sparsemem: Convert kmalloc_section_memmap() to populate_section_memmap()
      mm/hotplug: Kill is_dev_zone() usage in __remove_pages()
      mm: Kill is_dev_zone() helper
      mm/sparsemem: Prepare for sub-section ranges
      mm/sparsemem: Support sub-section hotplug
      mm: Document ZONE_DEVICE memory-model implications
      mm/devm_memremap_pages: Enable sub-section remap
      libnvdimm/pfn: Fix fsdax-mode namespace info-block zero-fields
      libnvdimm/pfn: Stop padding pmem namespaces to section alignment


 Documentation/vm/memory-model.rst |   39 ++++
 arch/x86/mm/init_64.c             |    4 
 drivers/nvdimm/dax_devs.c         |    2 
 drivers/nvdimm/pfn.h              |   15 --
 drivers/nvdimm/pfn_devs.c         |   95 +++-------
 include/linux/memory_hotplug.h    |    7 -
 include/linux/mm.h                |    4 
 include/linux/mmzone.h            |   84 +++++++--
 kernel/memremap.c                 |   61 +++----
 mm/memory_hotplug.c               |  173 +++++++++----------
 mm/page_alloc.c                   |   16 +-
 mm/sparse-vmemmap.c               |   21 ++
 mm/sparse.c                       |  335 ++++++++++++++++++++++++-------------
 13 files changed, 494 insertions(+), 362 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

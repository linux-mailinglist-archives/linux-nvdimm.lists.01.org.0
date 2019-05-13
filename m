Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8E41BEEB
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 May 2019 23:02:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97D26212741E6;
	Mon, 13 May 2019 14:02:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 88C7D21268F9B
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 14:02:02 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4DKw7j7009376
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 17:02:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2sfexgttt8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 17:02:00 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <rppt@linux.ibm.com>;
 Mon, 13 May 2019 22:01:58 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 13 May 2019 22:01:53 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4DL1qrL54722776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2019 21:01:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 420FFA404D;
 Mon, 13 May 2019 21:01:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FEF5A4040;
 Mon, 13 May 2019 21:01:50 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.233])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 13 May 2019 21:01:50 +0000 (GMT)
Date: Tue, 14 May 2019 00:01:48 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v8 00/12] mm: Sub-section memory hotplug support
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19051321-4275-0000-0000-000003345D88
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051321-4276-0000-0000-00003843DADB
Message-Id: <20190513210148.GA21574@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-13_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130139
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
Cc: Michal Hocko <mhocko@suse.com>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 David Hildenbrand <david@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Anshuman Khandual <anshuman.khandual@arm.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, akpm@linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Dan,

On Mon, May 06, 2019 at 04:39:26PM -0700, Dan Williams wrote:
> Changes since v7 [1]:

Sorry for jumping late, but presuming there will be v9, it'd be great if it
would also include include updates to
Documentation/admin-guide/mm/memory-hotplug.rst and
Documentation/vm/memory-model.rst
 
> - Make subsection helpers pfn based rather than physical-address based
>   (Oscar and Pavel)
> 
> - Make subsection bitmap definition scalable for different section and
>   sub-section sizes across architectures. As a result:
> 
>       unsigned long map_active
> 
>   ...is converted to:
> 
>       DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION)
> 
>   ...and the helpers are renamed with a 'subsection' prefix. (Pavel)
> 
> - New in this version is a touch of arch/powerpc/include/asm/sparsemem.h
>   in "[PATCH v8 01/12] mm/sparsemem: Introduce struct mem_section_usage"
>   to define ARCH_SUBSECTION_SHIFT.
> 
> - Drop "mm/sparsemem: Introduce common definitions for the size and mask
>   of a section" in favor of Robin's "mm/memremap: Rename and consolidate
>   SECTION_SIZE" (Pavel)
> 
> - Collect some more Reviewed-by tags. Patches that still lack review
>   tags: 1, 3, 9 - 12
> 
> [1]: https://lore.kernel.org/lkml/155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> ---
> [merge logistics]
> 
> Hi Andrew,
> 
> These are too late for v5.2, I'm posting this v8 during the merge window
> to maintain the review momentum. 
> 
> ---
> [cover letter]
> 
> The memory hotplug section is an arbitrary / convenient unit for memory
> hotplug. 'Section-size' units have bled into the user interface
> ('memblock' sysfs) and can not be changed without breaking existing
> userspace. The section-size constraint, while mostly benign for typical
> memory hotplug, has and continues to wreak havoc with 'device-memory'
> use cases, persistent memory (pmem) in particular. Recall that pmem uses
> devm_memremap_pages(), and subsequently arch_add_memory(), to allocate a
> 'struct page' memmap for pmem. However, it does not use the 'bottom
> half' of memory hotplug, i.e. never marks pmem pages online and never
> exposes the userspace memblock interface for pmem. This leaves an
> opening to redress the section-size constraint.
> 
> To date, the libnvdimm subsystem has attempted to inject padding to
> satisfy the internal constraints of arch_add_memory(). Beyond
> complicating the code, leading to bugs [2], wasting memory, and limiting
> configuration flexibility, the padding hack is broken when the platform
> changes this physical memory alignment of pmem from one boot to the
> next. Device failure (intermittent or permanent) and physical
> reconfiguration are events that can cause the platform firmware to
> change the physical placement of pmem on a subsequent boot, and device
> failure is an everyday event in a data-center.
> 
> It turns out that sections are only a hard requirement of the
> user-facing interface for memory hotplug and with a bit more
> infrastructure sub-section arch_add_memory() support can be added for
> kernel internal usages like devm_memremap_pages(). Here is an analysis
> of the current design assumptions in the current code and how they are
> addressed in the new implementation:
> 
> Current design assumptions:
> 
> - Sections that describe boot memory (early sections) are never
>   unplugged / removed.
> 
> - pfn_valid(), in the CONFIG_SPARSEMEM_VMEMMAP=y, case devolves to a
>   valid_section() check
> 
> - __add_pages() and helper routines assume all operations occur in
>   PAGES_PER_SECTION units.
> 
> - The memblock sysfs interface only comprehends full sections
> 
> New design assumptions:
> 
> - Sections are instrumented with a sub-section bitmask to track (on x86)
>   individual 2MB sub-divisions of a 128MB section.
> 
> - Partially populated early sections can be extended with additional
>   sub-sections, and those sub-sections can be removed with
>   arch_remove_memory(). With this in place we no longer lose usable memory
>   capacity to padding.
> 
> - pfn_valid() is updated to look deeper than valid_section() to also check the
>   active-sub-section mask. This indication is in the same cacheline as
>   the valid_section() so the performance impact is expected to be
>   negligible. So far the lkp robot has not reported any regressions.
> 
> - Outside of the core vmemmap population routines which are replaced,
>   other helper routines like shrink_{zone,pgdat}_span() are updated to
>   handle the smaller granularity. Core memory hotplug routines that deal
>   with online memory are not touched.
> 
> - The existing memblock sysfs user api guarantees / assumptions are
>   not touched since this capability is limited to !online
>   !memblock-sysfs-accessible sections.
> 
> Meanwhile the issue reports continue to roll in from users that do not
> understand when and how the 128MB constraint will bite them. The current
> implementation relied on being able to support at least one misaligned
> namespace, but that immediately falls over on any moderately complex
> namespace creation attempt. Beyond the initial problem of 'System RAM'
> colliding with pmem, and the unsolvable problem of physical alignment
> changes, Linux is now being exposed to platforms that collide pmem
> ranges with other pmem ranges by default [3]. In short,
> devm_memremap_pages() has pushed the venerable section-size constraint
> past the breaking point, and the simplicity of section-aligned
> arch_add_memory() is no longer tenable.
> 
> These patches are exposed to the kbuild robot on my libnvdimm-pending
> branch [4], and a preview of the unit test for this functionality is
> available on the 'subsection-pending' branch of ndctl [5].
> 
> [2]: https://lore.kernel.org/r/155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com
> [3]: https://github.com/pmem/ndctl/issues/76
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=libnvdimm-pending
> [5]: https://github.com/pmem/ndctl/commit/7c59b4867e1c
> 
> ---
> 
> Dan Williams (11):
>       mm/sparsemem: Introduce struct mem_section_usage
>       mm/sparsemem: Add helpers track active portions of a section at boot
>       mm/hotplug: Prepare shrink_{zone,pgdat}_span for sub-section removal
>       mm/sparsemem: Convert kmalloc_section_memmap() to populate_section_memmap()
>       mm/hotplug: Kill is_dev_zone() usage in __remove_pages()
>       mm: Kill is_dev_zone() helper
>       mm/sparsemem: Prepare for sub-section ranges
>       mm/sparsemem: Support sub-section hotplug
>       mm/devm_memremap_pages: Enable sub-section remap
>       libnvdimm/pfn: Fix fsdax-mode namespace info-block zero-fields
>       libnvdimm/pfn: Stop padding pmem namespaces to section alignment
> 
> Robin Murphy (1):
>       mm/memremap: Rename and consolidate SECTION_SIZE
> 
> 
>  arch/powerpc/include/asm/sparsemem.h |    3 
>  arch/x86/mm/init_64.c                |    4 
>  drivers/nvdimm/dax_devs.c            |    2 
>  drivers/nvdimm/pfn.h                 |   15 -
>  drivers/nvdimm/pfn_devs.c            |   95 +++------
>  include/linux/memory_hotplug.h       |    7 -
>  include/linux/mm.h                   |    4 
>  include/linux/mmzone.h               |   93 +++++++--
>  kernel/memremap.c                    |   63 ++----
>  mm/hmm.c                             |    2 
>  mm/memory_hotplug.c                  |  172 +++++++++-------
>  mm/page_alloc.c                      |    8 -
>  mm/sparse-vmemmap.c                  |   21 +-
>  mm/sparse.c                          |  369 +++++++++++++++++++++++-----------
>  14 files changed, 511 insertions(+), 347 deletions(-)
> 

-- 
Sincerely yours,
Mike.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

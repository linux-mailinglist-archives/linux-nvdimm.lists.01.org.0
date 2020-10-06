Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2652846D6
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Oct 2020 09:13:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E543F1557A1AA;
	Tue,  6 Oct 2020 00:13:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB1991557A1A9
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 00:13:16 -0700 (PDT)
IronPort-SDR: ghjfh7pJ1nRQkVeLcLf2/X/MiUdqkyDWl6baSlpfZhPWnsBowZzqTWourHE4R773IT1EBK7GC0
 LG525Gt2NJVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="152159803"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400";
   d="scan'208";a="152159803"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:14 -0700
IronPort-SDR: vcgGUu7WlIYrv4VD8PDkh5CIoeMcIDP4+bChL0d+gnApWeoemTap4O0E7Nlwp5N91yARWoKuXp
 piFM9xB+kNoA==
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400";
   d="scan'208";a="460671753"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:13 -0700
Subject: [PATCH v6 00/11] device-dax: support sub-dividing soft-reserved
 ranges
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Mon, 05 Oct 2020 23:54:44 -0700
Message-ID: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: UMWPRVFSJ2PSIK26GENGPSRINARTAMU3
X-Message-ID-Hash: UMWPRVFSJ2PSIK26GENGPSRINARTAMU3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: david@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, joao.m.martins@oracle.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Hulk Robot <hulkci@huawei.com>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jia He <justin.he@arm.com>, =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jason Yan <yanaijie@huawei.com>, Paul Mackerras <paulus@ozlabs.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brice Goglin <Brice.Goglin@inria.fr>, Stefano Stabellini <sstabellini@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Dan Carpenter <dan.carpenter@oracle.com>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel@ffwll.ch>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UMWPRVFSJ2PSIK26GENGPSRINARTAMU3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v5 [1]:
- (David) Introduce range_len() to include/linux/range.h immediately in
  "device-dax: make pgmap optional for instance creation" rather than
  wait until "mm/memremap_pages: convert to 'struct range'" to move it.

- (David) David points out that release_mem_region() can not be used in
  the kmem driver since it depends on the resource range being busy at
  free. The dance the driver does to hand-off busy/free management to
  add_memory_driver_managed() breaks request_mem_region()'s assumptions
  and requires the driver to continue to use a open-coded
  release_resource() + kfree() sequence. For the new multi-range case,
  expand the driver-data to hold all the resulting 'struct resource'
  instances from mapping the ranges.

- (Boris) consolidate pgmap manipulation code in the
  xen_alloc_unpopulated_pages() path. Since this touched
  "mm/memremap_pages: convert to 'struct range'" with the pending fix from
  Dan, I folded in that fix and gave him a Reported-by credit.

[1]: http://lore.kernel.org/r/160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com

---

Hi Andrew,

As before patches that are in your tree and did not change as a result
of these updates are not re-sent. This set replaces:

device-dax-make-pgmap-optional-for-instance-creation.patch

...through...

device-dax-add-dis-contiguous-resource-support.patch

...in your stack.

I let this soak over the weekend in kbuild-robot visible tree and it
received a build success notification over 160 configs, and no other
regression notices.

---

The device-dax facility allows an address range to be directly mapped
through a chardev, or optionally hotplugged to the core kernel page
allocator as System-RAM. It is the mechanism for converting persistent
memory (pmem) to be used as another volatile memory pool i.e. the
current Memory Tiering hot topic on linux-mm.

In the case of pmem the nvdimm-namespace-label mechanism can sub-divide
it, but that labeling mechanism is not available / applicable to
soft-reserved ("EFI specific purpose") memory [2]. This series provides
a sysfs-mechanism for the daxctl utility to enable provisioning of
volatile-soft-reserved memory ranges.

The motivations for this facility are:

1/ Allow performance differentiated memory ranges to be split between
   kernel-managed and directly-accessed use cases.

2/ Allow physical memory to be provisioned along performance relevant
   address boundaries. For example, divide a memory-side cache [3] along
   cache-color boundaries.

3/ Parcel out soft-reserved memory to VMs using device-dax as a security
   / permissions boundary [4]. Specifically I have seen people (ab)using
   memmap=nn!ss (mark System-RAM as Persistent Memory) just to get the
   device-dax interface on custom address ranges. A follow-on for the VM
   use case is to teach device-dax to dynamically allocate 'struct page' at
   runtime to reduce the duplication of 'struct page' space in both the
   guest and the host kernel for the same physical pages.

[2]: http://lore.kernel.org/r/157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com
[3]: http://lore.kernel.org/r/154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com
[4]: http://lore.kernel.org/r/20200110190313.17144-1-joao.m.martins@oracle.com

---

Dan Williams (11):
      device-dax: make pgmap optional for instance creation
      device-dax/kmem: introduce dax_kmem_range()
      device-dax/kmem: move resource tracking to drvdata
      device-dax: add an allocation interface for device-dax instances
      device-dax: introduce 'struct dev_dax' typed-driver operations
      device-dax: introduce 'seed' devices
      drivers/base: make device_find_child_by_name() compatible with sysfs inputs
      device-dax: add resize support
      mm/memremap_pages: convert to 'struct range'
      mm/memremap_pages: support multiple ranges per invocation
      device-dax: add dis-contiguous resource support


 arch/powerpc/kvm/book3s_hv_uvmem.c     |   14 -
 drivers/base/core.c                    |    2 
 drivers/dax/bus.c                      |  708 ++++++++++++++++++++++++++++++--
 drivers/dax/bus.h                      |   11 
 drivers/dax/dax-private.h              |   23 +
 drivers/dax/device.c                   |   71 ++-
 drivers/dax/hmem/hmem.c                |   14 -
 drivers/dax/kmem.c                     |  198 ++++++---
 drivers/dax/pmem/compat.c              |    2 
 drivers/dax/pmem/core.c                |   14 -
 drivers/gpu/drm/nouveau/nouveau_dmem.c |   15 -
 drivers/nvdimm/badrange.c              |   26 +
 drivers/nvdimm/claim.c                 |   13 -
 drivers/nvdimm/nd.h                    |    3 
 drivers/nvdimm/pfn_devs.c              |   13 -
 drivers/nvdimm/pmem.c                  |   27 +
 drivers/nvdimm/region.c                |   21 +
 drivers/pci/p2pdma.c                   |   12 -
 drivers/xen/unpopulated-alloc.c        |   49 +-
 include/linux/memremap.h               |   11 
 include/linux/range.h                  |    6 
 lib/test_hmm.c                         |   51 +-
 mm/memremap.c                          |  299 ++++++++------
 tools/testing/nvdimm/dax-dev.c         |   22 +
 tools/testing/nvdimm/test/iomap.c      |    2 
 25 files changed, 1216 insertions(+), 411 deletions(-)

base-commit: d524ed85683d657593ac1e58098407bed0601a84
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

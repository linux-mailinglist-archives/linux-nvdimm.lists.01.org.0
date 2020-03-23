Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D62190272
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 01:10:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24EBE10FC3881;
	Mon, 23 Mar 2020 17:11:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5EDA110FC3881
	for <linux-nvdimm@lists.01.org>; Mon, 23 Mar 2020 17:11:35 -0700 (PDT)
IronPort-SDR: /RKbbLsM5md9PE+1Lj1lDNS9OIlt2+f8bx9Om8n6OgmucQveQbENo+pTbIupk0qO+apmhb38/P
 KNcCVqo/WkyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:10:38 -0700
IronPort-SDR: B+kpyitPx/n7Zb9g0kUHAXGHfUrwQuJx+43OeoEyejezJiIvvlLYEtlqTgyG1WGtb1wmPZulSO
 Ij1jHCK6WKfQ==
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200";
   d="scan'208";a="246362736"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:10:38 -0700
Subject: [PATCH 00/12] device-dax: Support sub-dividing soft-reserved ranges
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Mon, 23 Mar 2020 16:54:31 -0700
Message-ID: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: JUP6IRBE5RJ5QAMZEL7QA5XS4S45JDDU
X-Message-ID-Hash: JUP6IRBE5RJ5QAMZEL7QA5XS4S45JDDU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Ben Skeggs <bskeggs@redhat.com>, Paul Mackerras <paulus@ozlabs.org>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Joao Martins <joao.m.martins@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JUP6IRBE5RJ5QAMZEL7QA5XS4S45JDDU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The device-dax facility allows an address range to be directly mapped
through a chardev, or turned around and hotplugged to the core kernel
page allocator as System-RAM. It is the baseline mechanism for
converting persistent memory (pmem) to be used as another volatile
memory pool i.e. the current Memory Tiering hot topic on linux-mm.

In the case of pmem the nvdimm-namespace-label mechanism can sub-divide
it, but that labeling mechanism is not available / applicable to
soft-reserved ("EFI specific purpose") memory [1]. This series provides
a sysfs-mechanism for the daxctl utility to enable provisioning of
volatile-soft-reserved memory ranges.

The motivations for this facility are:

1/ Allow performance differentiated memory ranges to be split between
   kernel-managed and directly-accessed use cases.

2/ Allow physical memory to be provisioned along performance relevant
   address boundaries. For example, divide a memory-side cache [2] along
   cache-color boundaries.

3/ Parcel out soft-reserved memory to VMs using device-dax as a security
   / permissions boundary [3]. Specifically I have seen people (ab)using
   memmap=nn!ss (mark System-RAM as Peristent Memory) just to get the
   device-dax interface on custom address ranges.

The baseline for this series is today's next/master + "[PATCH v2 0/6]
Manual definition of Soft Reserved memory devices" [4].

Big thanks to Joao for the early testing and feedback on this series!

Given the dependencies on the memremap_pages() reworks in Andrew's tree
and the proximity to v5.7 this is clearly v5.8 material. The patches in
most need of a second opinion are the memremap_pages() reworks to switch
from 'struct resource' to 'struct range' and allow for an array of
ranges to be mapped at once.

[1]: https://lore.kernel.org/r/157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com/
[2]: https://lore.kernel.org/r/154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com/
[3]: https://lore.kernel.org/r/20200110190313.17144-1-joao.m.martins@oracle.com/
[4]: http://lore.kernel.org/r/158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com/

---

Dan Williams (12):
      device-dax: Drop the dax_region.pfn_flags attribute
      device-dax: Move instance creation parameters to 'struct dev_dax_data'
      device-dax: Make pgmap optional for instance creation
      device-dax: Kill dax_kmem_res
      device-dax: Add an allocation interface for device-dax instances
      device-dax: Introduce seed devices
      drivers/base: Make device_find_child_by_name() compatible with sysfs inputs
      device-dax: Add resize support
      mm/memremap_pages: Convert to 'struct range'
      mm/memremap_pages: Support multiple ranges per invocation
      device-dax: Add dis-contiguous resource support
      device-dax: Introduce 'mapping' devices


 arch/powerpc/kvm/book3s_hv_uvmem.c     |   14 -
 drivers/base/core.c                    |    2 
 drivers/dax/bus.c                      |  877 ++++++++++++++++++++++++++++++--
 drivers/dax/bus.h                      |   28 +
 drivers/dax/dax-private.h              |   36 +
 drivers/dax/device.c                   |   97 ++--
 drivers/dax/hmem/hmem.c                |   18 -
 drivers/dax/kmem.c                     |  170 +++---
 drivers/dax/pmem/compat.c              |    2 
 drivers/dax/pmem/core.c                |   22 +
 drivers/gpu/drm/nouveau/nouveau_dmem.c |    4 
 drivers/nvdimm/badrange.c              |   26 -
 drivers/nvdimm/claim.c                 |   13 
 drivers/nvdimm/nd.h                    |    3 
 drivers/nvdimm/pfn_devs.c              |   13 
 drivers/nvdimm/pmem.c                  |   27 +
 drivers/nvdimm/region.c                |   21 -
 drivers/pci/p2pdma.c                   |   12 
 include/linux/memremap.h               |    9 
 include/linux/range.h                  |    6 
 mm/memremap.c                          |  297 ++++++-----
 tools/testing/nvdimm/dax-dev.c         |   22 +
 tools/testing/nvdimm/test/iomap.c      |    2 
 23 files changed, 1318 insertions(+), 403 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

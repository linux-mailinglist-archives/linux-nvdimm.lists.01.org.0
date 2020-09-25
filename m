Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7527916F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 21:30:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 59801154F0013;
	Fri, 25 Sep 2020 12:30:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AC6DA154EAAFA
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 12:30:01 -0700 (PDT)
IronPort-SDR: waHvGoUoHbUkYoy6fwtEsr4rUaQFCuufrmc65AEVR0TVrM3PkGAc3lnda2jiprgeGKIfAy3bkd
 z6X2MCw5Gh3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="159016924"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="159016924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:00 -0700
IronPort-SDR: y/5TfPWHk/8Hzw/AbD1aVTu5a2nWwqjoPjcd88tCruatdGVYbHGCzI0P3Yd+oT8ukDm4vRpe5E
 TuzfWGzOQvaA==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400";
   d="scan'208";a="487581711"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:00 -0700
Subject: [PATCH v5 00/17] device-dax: support sub-dividing soft-reserved
 ranges
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Fri, 25 Sep 2020 12:11:39 -0700
Message-ID: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 7M4QEQHWH5X4PJH2RPGGE5MG4FEKN5SO
X-Message-ID-Hash: 7M4QEQHWH5X4PJH2RPGGE5MG4FEKN5SO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Hulk Robot <hulkci@huawei.com>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jia He <justin.he@arm.com>, =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Jason Yan <yanaijie@huawei.com>, Paul Mackerras <paulus@ozlabs.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brice Goglin <Brice.Goglin@inria.fr>, Stefano Stabellini <sstabellini@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel@ffwll.ch>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7M4QEQHWH5X4PJH2RPGGE5MG4FEKN5SO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v4 [1]:
- Rebased on
  device-dax-move-instance-creation-parameters-to-struct-dev_dax_data.patch
  in -mm [2]. I.e. patches that did not need fixups from v4 are not
  included.

- Folded all fixes

- Replaced "device-dax: kill dax_kmem_res" with:

      device-dax/kmem: introduce dax_kmem_range()
      device-dax/kmem: move resource name tracking to drvdata
      device-dax/kmem: replace release_resource() with release_mem_region()

  ...to address David's request to make those cleanups easier to review.
  Note that I dropped changes to how IORESOURCE_BUSY is manipulated since
  David and I are still debating the best way forward there.

- Broke out some of dax-bus reworks in "device-dax: introduce 'seed'
  devices" to a new "device-dax: introduce 'struct dev_dax' typed-driver
  operations"

- Added a conversion of xen_alloc_unallocated_pages() from pgmap.res to
  pgmap.range. I found it odd that there is no corresponding
  memunmap_pages() triggered by xen_free_unallocated_pages()?

- Not included, a conversion of virtio_fs to use pgmap.range for its new
  usage of devm_memremap_pages(). It appears the virtio_fs changes are
  merged after -mm? My mental model of -mm was that it applies on top of
  linux-next? In any event, Vivek, you will need to coordinate a
  conversion to pgmap.range for the virtio_fs dax-support merge. Maybe
  that should go through Andrew as well?

- Lowercase all the subject lines per akpm's preference

- Received a 0day robot build-success notification over 122 configs

- Thanks to Joao for looking after this set while I was out.

[1]: http://lore.kernel.org/r/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com
[2]: https://ozlabs.org/~akpm/mmots/broken-out/device-dax-move-instance-creation-parameters-to-struct-dev_dax_data.patch

---

Andrew, this series replaces

device-dax-make-pgmap-optional-for-instance-creation.patch

...through...

dax-hmem-introduce-dax_hmemregion_idle-parameter.patch

...in your stack.

Let me know if there is a different / preferred way to refresh a bulk of
patches in your queue when only a subset need updates.

---

The device-dax facility allows an address range to be directly mapped
through a chardev, or optionally hotplugged to the core kernel page
allocator as System-RAM. It is the mechanism for converting persistent
memory (pmem) to be used as another volatile memory pool i.e. the
current Memory Tiering hot topic on linux-mm.

In the case of pmem the nvdimm-namespace-label mechanism can sub-divide
it, but that labeling mechanism is not available / applicable to
soft-reserved ("EFI specific purpose") memory [3]. This series provides
a sysfs-mechanism for the daxctl utility to enable provisioning of
volatile-soft-reserved memory ranges.

The motivations for this facility are:

1/ Allow performance differentiated memory ranges to be split between
   kernel-managed and directly-accessed use cases.

2/ Allow physical memory to be provisioned along performance relevant
   address boundaries. For example, divide a memory-side cache [4] along
   cache-color boundaries.

3/ Parcel out soft-reserved memory to VMs using device-dax as a security
   / permissions boundary [5]. Specifically I have seen people (ab)using
   memmap=nn!ss (mark System-RAM as Persistent Memory) just to get the
   device-dax interface on custom address ranges. A follow-on for the VM
   use case is to teach device-dax to dynamically allocate 'struct page' at
   runtime to reduce the duplication of 'struct page' space in both the
   guest and the host kernel for the same physical pages.

[3]: http://lore.kernel.org/r/157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com
[4]: http://lore.kernel.org/r/154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com
[5]: http://lore.kernel.org/r/20200110190313.17144-1-joao.m.martins@oracle.com

---

Dan Williams (14):
      device-dax: make pgmap optional for instance creation
      device-dax/kmem: introduce dax_kmem_range()
      device-dax/kmem: move resource name tracking to drvdata
      device-dax/kmem: replace release_resource() with release_mem_region()
      device-dax: add an allocation interface for device-dax instances
      device-dax: introduce 'struct dev_dax' typed-driver operations
      device-dax: introduce 'seed' devices
      drivers/base: make device_find_child_by_name() compatible with sysfs inputs
      device-dax: add resize support
      mm/memremap_pages: convert to 'struct range'
      mm/memremap_pages: support multiple ranges per invocation
      device-dax: add dis-contiguous resource support
      device-dax: introduce 'mapping' devices
      device-dax: add an 'align' attribute

Joao Martins (3):
      device-dax: make align a per-device property
      dax/hmem: introduce dax_hmem.region_idle parameter
      device-dax: add a range mapping allocation attribute


 arch/powerpc/kvm/book3s_hv_uvmem.c     |   14 
 drivers/base/core.c                    |    2 
 drivers/dax/bus.c                      | 1039 ++++++++++++++++++++++++++++++--
 drivers/dax/bus.h                      |   11 
 drivers/dax/dax-private.h              |   58 ++
 drivers/dax/device.c                   |  112 ++-
 drivers/dax/hmem/hmem.c                |   17 -
 drivers/dax/kmem.c                     |  178 +++--
 drivers/dax/pmem/compat.c              |    2 
 drivers/dax/pmem/core.c                |   14 
 drivers/gpu/drm/nouveau/nouveau_dmem.c |   15 
 drivers/nvdimm/badrange.c              |   26 -
 drivers/nvdimm/claim.c                 |   13 
 drivers/nvdimm/nd.h                    |    3 
 drivers/nvdimm/pfn_devs.c              |   13 
 drivers/nvdimm/pmem.c                  |   27 -
 drivers/nvdimm/region.c                |   21 -
 drivers/pci/p2pdma.c                   |   12 
 drivers/xen/unpopulated-alloc.c        |   45 +
 include/linux/memremap.h               |   11 
 include/linux/range.h                  |    6 
 lib/test_hmm.c                         |   15 
 mm/memremap.c                          |  299 +++++----
 tools/testing/nvdimm/dax-dev.c         |   22 -
 tools/testing/nvdimm/test/iomap.c      |    2 
 25 files changed, 1557 insertions(+), 420 deletions(-)

base-commit: 6764736525f27a411ba2c0c430aaa2df7375f3ac
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

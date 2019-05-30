Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6630547
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 May 2019 01:13:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C25921962301;
	Thu, 30 May 2019 16:13:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BD82F2128A638
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 16:13:11 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 May 2019 16:13:10 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga001.jf.intel.com with ESMTP; 30 May 2019 16:13:10 -0700
Subject: [PATCH v2 0/8] EFI Specific Purpose Memory Support
From: Dan Williams <dan.j.williams@intel.com>
To: linux-efi@vger.kernel.org
Date: Thu, 30 May 2019 15:59:22 -0700
Message-ID: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: x86@kernel.org, kbuild test robot <lkp@intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-nvdimm@lists.01.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andy@infradead.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Changes since the initial RFC [1]
* Split the generic detection of the attribute from any policy /
  mechanism that leverages the EFI_MEMORY_SP designation (Ard).

* Various cleanups to the lib/memregion implementation (Willy)

* Rebase on v5.2-rc2

* Several fixes resulting from testing with efi_fake_mem and the
  work-in-progress patches that add HMAT support to qemu. Details in
  patch3 and patch8.

[1]: https://lore.kernel.org/lkml/155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com/

---

The EFI 2.8 Specification [2] introduces the EFI_MEMORY_SP ("specific
purpose") memory attribute. This attribute bit replaces the deprecated
ACPI HMAT "reservation hint" that was introduced in ACPI 6.2 and removed
in ACPI 6.3.

Given the increasing diversity of memory types that might be advertised
to the operating system, there is a need for platform firmware to hint
which memory ranges are free for the OS to use as general purpose memory
and which ranges are intended for application specific usage. For
example, an application with prior knowledge of the platform may expect
to be able to exclusively allocate a precious / limited pool of high
bandwidth memory. Alternatively, for the general purpose case, the
operating system may want to make the memory available on a best effort
basis as a unique numa-node with performance properties by the new
CONFIG_HMEM_REPORTING [3] facility.

In support of optionally allowing either application-exclusive and
core-kernel-mm managed access to differentiated memory, claim
EFI_MEMORY_SP ranges for exposure as device-dax instances by default.
Such instances can be directly owned / mapped by a
platform-topology-aware application. Alternatively, with the new kmem
facility [4], the administrator has the option to instead designate that
those memory ranges be hot-added to the core-kernel-mm as a unique
memory numa-node. In short, allow for the decision about what software
agent manages specific-purpose memory to be made at runtime.

The patches are based on the new HMAT+HMEM_REPORTING facilities merged
for v5.2-rc1. The implementation is tested with qemu emulation of HMAT
[5] plus the efi_fake_mem facility for applying the EFI_MEMORY_SP
attribute.

[2]: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1cf33aafb84
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308f
[5]: http://patchwork.ozlabs.org/cover/1096737/

---

Dan Williams (8):
      acpi: Drop drivers/acpi/hmat/ directory
      acpi/hmat: Skip publishing target info for nodes with no online memory
      efi: Enumerate EFI_MEMORY_SP
      x86, efi: Reserve UEFI 2.8 Specific Purpose Memory for dax
      lib/memregion: Uplevel the pmem "region" ida to a global allocator
      device-dax: Add a driver for "hmem" devices
      acpi/hmat: Register HMAT at device_initcall level
      acpi/hmat: Register "specific purpose" memory as an "hmem" device


 arch/x86/Kconfig                  |   20 +++++
 arch/x86/boot/compressed/eboot.c  |    5 +
 arch/x86/boot/compressed/kaslr.c  |    2
 arch/x86/include/asm/e820/types.h |    9 ++
 arch/x86/kernel/e820.c            |    9 ++
 arch/x86/kernel/setup.c           |    1
 arch/x86/platform/efi/efi.c       |   37 ++++++++-
 drivers/acpi/Kconfig              |   13 +++
 drivers/acpi/Makefile             |    2
 drivers/acpi/hmat.c               |  149 +++++++++++++++++++++++++++++++++----
 drivers/acpi/hmat/Kconfig         |   11 ---
 drivers/acpi/hmat/Makefile        |    2
 drivers/acpi/numa.c               |   15 +++-
 drivers/dax/Kconfig               |   27 +++++--
 drivers/dax/Makefile              |    2
 drivers/dax/hmem.c                |   58 ++++++++++++++
 drivers/firmware/efi/efi.c        |    5 +
 drivers/nvdimm/Kconfig            |    1
 drivers/nvdimm/core.c             |    1
 drivers/nvdimm/nd-core.h          |    1
 drivers/nvdimm/region_devs.c      |   13 +--
 include/linux/efi.h               |   15 ++++
 include/linux/ioport.h            |    1
 include/linux/memblock.h          |    7 ++
 include/linux/memregion.h         |   11 +++
 lib/Kconfig                       |    7 ++
 lib/Makefile                      |    1
 lib/memregion.c                   |   15 ++++
 mm/memblock.c                     |    4 +
 29 files changed, 387 insertions(+), 57 deletions(-)
 rename drivers/acpi/{hmat/hmat.c => hmat.c} (81%)
 delete mode 100644 drivers/acpi/hmat/Kconfig
 delete mode 100644 drivers/acpi/hmat/Makefile
 create mode 100644 drivers/dax/hmem.c
 create mode 100644 include/linux/memregion.h
 create mode 100644 lib/memregion.c
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

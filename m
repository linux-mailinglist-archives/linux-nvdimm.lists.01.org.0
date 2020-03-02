Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B280F17676F
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Mar 2020 23:36:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70E7410FC3602;
	Mon,  2 Mar 2020 14:36:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8ED8C1007B1EA
	for <linux-nvdimm@lists.01.org>; Mon,  2 Mar 2020 14:36:55 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 14:36:03 -0800
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400";
   d="scan'208";a="273921114"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 14:36:02 -0800
Subject: [PATCH 0/5] Manual definition of Soft Reserved memory devices
From: Dan Williams <dan.j.williams@intel.com>
To: linux-acpi@vger.kernel.org
Date: Mon, 02 Mar 2020 14:19:57 -0800
Message-ID: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: AVNMM4E4ZSZLEM5MV3MT2T3QIAJE4Y2M
X-Message-ID-Hash: AVNMM4E4ZSZLEM5MV3MT2T3QIAJE4Y2M
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jason Gunthorpe <jgg@ziepe.ca>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Brice Goglin <Brice.Goglin@inria.fr>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andy Lutomirski <luto@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AVNMM4E4ZSZLEM5MV3MT2T3QIAJE4Y2M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Given the current dearth of systems that supply an ACPI HMAT table, and
the utility of being able to manually define device-dax "hmem" instances
via the efi_fake_mem= option, relax the requirements for creating these
devices. Specifically, add an option (numa=nohmat) to optionally disable
consideration of the HMAT and update efi_fake_mem= to behave like
memmap=nn!ss in terms of delimiting device boundaries.

All review welcome of course, but the E820 changes want an x86
maintainer ack, the efi_fake_mem update needs Ard, and Rafael has
previously shepherded the HMAT changes. For the changes to
kernel/resource.c, where there is no clear maintainer, I just copied the
last few people to make thoughtful changes in that area. I am happy to
take these through the nvdimm tree along with these prerequisites
already in -next:

b2ca916ce392 ACPI: NUMA: Up-level "map to online node" functionality
4fcbe96e4d0b mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
575e23b6e13c powerpc/papr_scm: Switch to numa_map_to_online_node()
1e5d8e1e47af x86/mm: Introduce CONFIG_NUMA_KEEP_MEMINFO
5d30f92e7631 x86/NUMA: Provide a range-to-target_node lookup facility
7b27a8622f80 libnvdimm/e820: Retrieve and populate correct 'target_node' info

Tested with:

        numa=nohmat efi_fake_mem=4G@9G:0x40000,4G@13G:0x40000

...to create to device-dax instances:

	# daxctl list -RDu
	[
	  {
	    "path":"\/platform\/hmem.1",
	    "id":1,
	    "size":"4.00 GiB (4.29 GB)",
	    "align":2097152,
	    "devices":[
	      {
	        "chardev":"dax1.0",
	        "size":"4.00 GiB (4.29 GB)",
	        "target_node":3,
	        "mode":"devdax"
	      }
	    ]
	  },
	  {
	    "path":"\/platform\/hmem.0",
	    "id":0,
	    "size":"4.00 GiB (4.29 GB)",
	    "align":2097152,
	    "devices":[
	      {
	        "chardev":"dax0.0",
	        "size":"4.00 GiB (4.29 GB)",
	        "target_node":2,
	        "mode":"devdax"
	      }
	    ]
	  }
	]

---

Dan Williams (5):
      ACPI: NUMA: Add 'nohmat' option
      efi/fake_mem: Arrange for a resource entry per efi_fake_mem instance
      ACPI: HMAT: Refactor hmat_register_target_device to hmem_register_device
      resource: Report parent to walk_iomem_res_desc() callback
      ACPI: HMAT: Attach a device for each soft-reserved range


 arch/x86/kernel/e820.c              |   16 +++++-
 arch/x86/mm/numa.c                  |    4 +
 drivers/acpi/numa/hmat.c            |   71 +++-----------------------
 drivers/dax/Kconfig                 |    5 ++
 drivers/dax/Makefile                |    3 -
 drivers/dax/hmem/Makefile           |    6 ++
 drivers/dax/hmem/device.c           |   97 +++++++++++++++++++++++++++++++++++
 drivers/dax/hmem/hmem.c             |    2 -
 drivers/firmware/efi/x86_fake_mem.c |   12 +++-
 include/acpi/acpi_numa.h            |    1 
 include/linux/dax.h                 |    8 +++
 kernel/resource.c                   |    1 
 12 files changed, 156 insertions(+), 70 deletions(-)
 create mode 100644 drivers/dax/hmem/Makefile
 create mode 100644 drivers/dax/hmem/device.c
 rename drivers/dax/{hmem.c => hmem/hmem.c} (98%)

base-commit: 7b27a8622f802761d5c6abd6c37b22312a35343c
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

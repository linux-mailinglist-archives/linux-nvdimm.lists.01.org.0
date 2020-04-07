Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2471A1695
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Apr 2020 22:12:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0747811064B8A;
	Tue,  7 Apr 2020 13:13:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3205A11064B88
	for <linux-nvdimm@lists.01.org>; Tue,  7 Apr 2020 13:13:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v1so5648754edq.8
        for <linux-nvdimm@lists.01.org>; Tue, 07 Apr 2020 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ERdwo2RxKpDOK4p9sBgyD8EfDBQBiS1CeSk+4MbDuLo=;
        b=dbeS0MN9/EJQ3fggNXC1nK1uUYt10iU0apLVSEH2lCPObt7pASULUCRj1TKvWesF9I
         tXowpOaEr7WftjnKcNnCIB4CFb1nfq7F3xpZt25V0Ai46x3gA/vRVIatVe8OuIg2Rs9/
         kKGfqNxma3TP9sieXrLFktsbze97WTHdrk8gT1f58sPQYUTSReqS0aVL8y5OFkgTYO6J
         rNV9QVhFpR1ce36cDiGUVpLp2R+I1+ZU0fGC9Ydesw1/AfNOL1mj9MlqvO8VFjRyPs0+
         GMxNsQjRb2MDD6A81K6aw1NT1dowuIFjVNFzFcrmsAzJ54gd/IiDtwtMJQofT/YumJtg
         LETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ERdwo2RxKpDOK4p9sBgyD8EfDBQBiS1CeSk+4MbDuLo=;
        b=cesIJ7WiBciKIm7Fto3S+F7SaLHFuJ2EnFjH9N4aI7TWkWh7aE2t5a+4XWCED8aMZp
         ymPwZAwTKD9dk111WWTbVUJ305IznBh3YYFSEwwb/qM2JKnPmg6RwCv+ackGVRZJLL7W
         e/d3EXxqnsOuRwQTvbEkpqJWdyiE4ADTrZ4tx8Zd5N+Kquvo631siIxfr6/VwPWbFGXa
         vbuod5b8WSNziPuJ+7SHE3FVKg5qtZWF+vlBuoqWeDsNW52AqdpDNrl0c8KjB9KZ6Cqo
         HCDl8aeWEBAtcdrLTuHdFK9U/7zUR5q4itzNAYN2vvaonbwEpiFlo0u2JRQnwQycecYZ
         EtOw==
X-Gm-Message-State: AGi0PuY9f9ZoCM/9IuUHg81LGDj3FTYIEvR4MhUihywP35QoG/Oc5Ct7
	0Lh6XiUq3cvkdnlLEBbRo60wI/vFNtSJptQLNiBSNg==
X-Google-Smtp-Source: APiQypLqMHbkAGx/soX1aAJZjS9L9/SvTpTczi6DQRJcOKfWMPKuekU/GfNR+TM93ozNNo+VwLWJ/pK9ZkYy174pSrA=
X-Received: by 2002:aa7:c609:: with SMTP id h9mr3493057edq.93.1586290372385;
 Tue, 07 Apr 2020 13:12:52 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Apr 2020 13:12:41 -0700
Message-ID: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for v5.7
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: HVU2FAWGSPU5THNPED4X3LXNGJQKVEFT
X-Message-ID-Hash: HVU2FAWGSPU5THNPED4X3LXNGJQKVEFT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HVU2FAWGSPU5THNPED4X3LXNGJQKVEFT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.7

...to receive the libnvdimm and dax update for this cycle. There were
multiple touches outside of drivers/nvdimm/ this round to add cross
arch compatibility to the devm_memremap_pages() interface, enhance
numa information for persistent memory ranges, and add a
zero_page_range() dax operation. This cycle I switched from the
patchwork api to Konstantin's b4 script for collecting tags (from x86,
PowerPC, filesystem, and device-mapper folks), and everything looks to
have gone ok there. This has all appeared in -next with no reported
issues.

Given the current environment where one might need to step away on
short notice I thought it would be a good idea to highlight to you and
others a backup maintainer for libnvdimm. Vishal, has agreed to step
in if circumstances make me non-responsive for multiple days. Not
expecting anything, just being proactive.

---

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.7

for you to fetch changes up to f6d2b802f80d0ca89ee1f51c1781b3f79cdb25d5:

  Merge branch 'for-5.7/libnvdimm' into libnvdimm-for-next (2020-04-02
19:55:17 -0700)

----------------------------------------------------------------
libnvdimm for 5.7

- Add support for region alignment configuration and enforcement to
  fix compatibility across architectures and PowerPC page size
  configurations.

- Introduce 'zero_page_range' as a dax operation. This facilitates
  filesystem-dax operation without a block-device.

- Introduce phys_to_target_node() to facilitate drivers that want to
  know resulting numa node if a given reserved address range was
  onlined.

- Advertise a persistence-domain for of_pmem and papr_scm. The
  persistence domain indicates where cpu-store cycles need to reach in
  the platform-memory subsystem before the platform will consider them
  power-fail protected.

- Promote numa_map_to_online_node() to a cross-kernel generic facility.

- Save x86 numa information to allow for node-id lookups for reserved
  memory ranges, deploy that capability for the e820-pmem driver.

- Pick up some miscellaneous minor fixes, that missed v5.6-final,
  including a some smatch reports in the ioctl path and some unit test
  compilation fixups.

- Fixup some flexible-array declarations.

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      libnvdimm: Update persistence domain value for of_pmem and papr_scm device

Dan Carpenter (2):
      acpi/nfit: improve bounds checking for 'func'
      libnvdimm: Out of bounds read in __nd_ioctl()

Dan Williams (15):
      ACPI: NUMA: Up-level "map to online node" functionality
      mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
      powerpc/papr_scm: Switch to numa_map_to_online_node()
      x86/mm: Introduce CONFIG_NUMA_KEEP_MEMINFO
      x86/NUMA: Provide a range-to-target_node lookup facility
      libnvdimm/e820: Retrieve and populate correct 'target_node' info
      mm/memremap_pages: Kill unused __devm_memremap_pages()
      mm/memremap_pages: Introduce memremap_compat_align()
      libnvdimm/pfn: Prevent raw mode fallback if pfn-infoblock valid
      libnvdimm/namespace: Enforce memremap_compat_align()
      libnvdimm/region: Introduce NDD_LABELING
      libnvdimm/region: Introduce an 'align' attribute
      Merge branch 'for-5.6/libnvdimm-fixes' into libnvdimm-for-next
      Merge branch 'for-5.7/numa' into libnvdimm-for-next
      Merge branch 'for-5.7/libnvdimm' into libnvdimm-for-next

Gustavo A. R. Silva (3):
      ACPI: NFIT: Replace zero-length array with flexible-array member
      libnvdimm/label: Replace zero-length array with flexible-array member
      libnvdimm/region: Replace zero-length array with flexible-array member

Jan Kara (1):
      tools/testing/nvdimm: Fix compilation failure without
CONFIG_DEV_DAX_PMEM_COMPAT

Lukas Bulwahn (1):
      MAINTAINERS: clarify maintenance of nvdimm testing tool

Santosh Sivaraj (1):
      tools/test/nvdimm: Fix out of tree build

Vivek Goyal (7):
      pmem: Add functions for reading/writing page to/from pmem
      dax, pmem: Add a dax operation zero_page_range
      s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
      dm,dax: Add dax zero_page_range operation
      dax: Use new dax zero page method for zeroing a page
      dax,iomap: Add helper dax_iomap_zero() to zero a range
      dax: Move mandatory ->zero_page_range() check in alloc_dax()

YueHaibing (1):
      libnvdimm/region: Fix build error

 MAINTAINERS                               |   1 +
 arch/powerpc/Kconfig                      |   1 +
 arch/powerpc/mm/ioremap.c                 |  21 +++++
 arch/powerpc/platforms/pseries/papr_scm.c |  27 ++-----
 arch/x86/Kconfig                          |   1 +
 arch/x86/mm/numa.c                        |  67 +++++++++++----
 drivers/acpi/nfit/core.c                  |  14 ++--
 drivers/acpi/nfit/nfit.h                  |  13 +--
 drivers/acpi/numa/srat.c                  |  41 ----------
 drivers/dax/bus.c                         |   4 +-
 drivers/dax/super.c                       |  28 ++++++-
 drivers/md/dm-linear.c                    |  18 +++++
 drivers/md/dm-log-writes.c                |  17 ++++
 drivers/md/dm-stripe.c                    |  23 ++++++
 drivers/md/dm.c                           |  32 +++++++-
 drivers/nvdimm/bus.c                      |   6 +-
 drivers/nvdimm/dimm.c                     |   2 +-
 drivers/nvdimm/dimm_devs.c                |  95 +++++++++++++++++-----
 drivers/nvdimm/e820.c                     |  18 +----
 drivers/nvdimm/label.h                    |   2 +-
 drivers/nvdimm/namespace_devs.c           |  28 ++++++-
 drivers/nvdimm/nd.h                       |   7 +-
 drivers/nvdimm/of_pmem.c                  |   4 +-
 drivers/nvdimm/pfn.h                      |  12 +++
 drivers/nvdimm/pfn_devs.c                 |  40 +++++++--
 drivers/nvdimm/pmem.c                     | 101 ++++++++++++++---------
 drivers/nvdimm/region_devs.c              | 130 ++++++++++++++++++++++++++----
 drivers/s390/block/dcssblk.c              |  20 ++++-
 fs/dax.c                                  |  59 ++++++--------
 fs/iomap/buffered-io.c                    |   9 +--
 include/linux/acpi.h                      |  23 +++++-
 include/linux/dax.h                       |  21 ++---
 include/linux/device-mapper.h             |   3 +
 include/linux/io.h                        |   2 -
 include/linux/libnvdimm.h                 |   2 +
 include/linux/memremap.h                  |   8 ++
 include/linux/mmzone.h                    |   1 +
 include/linux/numa.h                      |  30 ++++++-
 lib/Kconfig                               |   3 +
 mm/Kconfig                                |   5 ++
 mm/mempolicy.c                            |  26 ++++++
 mm/memremap.c                             |  23 ++++++
 tools/testing/nvdimm/Kbuild               |   4 +-
 tools/testing/nvdimm/test/Kbuild          |   4 +-
 tools/testing/nvdimm/test/nfit.c          |   2 +
 45 files changed, 737 insertions(+), 261 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

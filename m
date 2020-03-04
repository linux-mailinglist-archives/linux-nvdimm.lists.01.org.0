Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A7817882F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 03:24:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F23610FC360A;
	Tue,  3 Mar 2020 18:25:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9006510FC3170
	for <linux-nvdimm@lists.01.org>; Tue,  3 Mar 2020 18:25:01 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:24:09 -0800
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400";
   d="scan'208";a="258595131"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:24:08 -0800
Subject: [PATCH v4 0/5] libnvdimm: Cross-arch compatible namespace alignment
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Tue, 03 Mar 2020 18:08:03 -0800
Message-ID: <158328768294.2223916.16551505954326988623.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: NVG7BO72QVRGAAIDEVXDTAJB6WIYT6YW
X-Message-ID-Hash: NVG7BO72QVRGAAIDEVXDTAJB6WIYT6YW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NVG7BO72QVRGAAIDEVXDTAJB6WIYT6YW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v3 [1]:
- Collect Aneesh's Reviewed-by for Patch1-Patch3

- Add commentary to "libnvdimm/namespace: Enforce
  memremap_compat_align()" to clarify alignment validation and why
  start_pad is deprecated (Aneesh)

[1]: http://lore.kernel.org/r/158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com

---

Patch "mm/memremap_pages: Introduce memremap_compat_align()" still
needs a PowerPC maintainer ack for the touches to
arch/powerpc/mm/ioremap.c.

---

Aneesh reports that PowerPC requires 16MiB alignment for the address
range passed to devm_memremap_pages(), and Jeff reports that it is
possible to create a misaligned namespace which blocks future namespace
creation in that region. Both of these issues require namespace
alignment to be managed at the region level rather than padding at the
namespace level which has been a broken approach to date.

Introduce memremap_compat_align() to indicate the hard requirements of
an arch's memremap_pages() implementation. Use the maximum known
memremap_compat_align() to set the default namespace alignment for
libnvdimm. Consult that alignment when allocating free space. Finally,
allow the default region alignment to be overridden to maintain the same
namespace creation capability as previous kernels (modulo dax operation
not being supported with a non-zero start_pad).

The ndctl unit tests, which have some misaligned namespace assumptions,
are updated to use the alignment override where necessary.

Thanks to Aneesh for early feedback and testing on this change to
alignment handling.

---

Dan Williams (5):
      mm/memremap_pages: Introduce memremap_compat_align()
      libnvdimm/pfn: Prevent raw mode fallback if pfn-infoblock valid
      libnvdimm/namespace: Enforce memremap_compat_align()
      libnvdimm/region: Introduce NDD_LABELING
      libnvdimm/region: Introduce an 'align' attribute


 arch/powerpc/Kconfig                      |    1 
 arch/powerpc/mm/ioremap.c                 |   21 +++++
 arch/powerpc/platforms/pseries/papr_scm.c |    2 
 drivers/acpi/nfit/core.c                  |    4 +
 drivers/nvdimm/dimm.c                     |    2 
 drivers/nvdimm/dimm_devs.c                |   95 +++++++++++++++++----
 drivers/nvdimm/namespace_devs.c           |   28 +++++-
 drivers/nvdimm/nd.h                       |    3 -
 drivers/nvdimm/pfn.h                      |   12 +++
 drivers/nvdimm/pfn_devs.c                 |   40 +++++++--
 drivers/nvdimm/region_devs.c              |  132 ++++++++++++++++++++++++++---
 include/linux/libnvdimm.h                 |    2 
 include/linux/memremap.h                  |    8 ++
 include/linux/mmzone.h                    |    1 
 lib/Kconfig                               |    3 +
 mm/memremap.c                             |   23 +++++
 16 files changed, 330 insertions(+), 47 deletions(-)

base-commit: 1d0827b75ee7df497f611a2ac412a88135fb0ef5
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

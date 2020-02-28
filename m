Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A0D174044
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 20:33:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E540010FC36ED;
	Fri, 28 Feb 2020 11:34:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C119210FC36D9
	for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 11:34:43 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 11:33:51 -0800
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400";
   d="scan'208";a="257212162"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 11:33:51 -0800
Subject: [PATCH v3 0/5] libnvdimm: Cross-arch compatible namespace alignment
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Fri, 28 Feb 2020 11:17:46 -0800
Message-ID: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: YOY3TJO2IDSLQG2Q2J53EU6KZR5VIZ6O
X-Message-ID-Hash: YOY3TJO2IDSLQG2Q2J53EU6KZR5VIZ6O
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YOY3TJO2IDSLQG2Q2J53EU6KZR5VIZ6O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v2 [1]:
- Fix up a missing space in flags_show() (Jeff)

- Prompted by Jeff saying that v2 only worked for him if
  memremap_compat_align() returned PAGE_SIZE (which defeats the purpose)
  I developed a new ndctl unit test that runs through the possible
  legacy configurations that the kernel needs to support. Several changes
  fell out as a result:

  - Update nd_pfn_validate() to add more -EOPNOTSUPP cases. That error
    code indicates "Stop, the pfn looks coherent, but invalid. Do not
    proceed with exposing a raw namespace, require the user to
    investigate whether the infoblock needs to be rewritten, or the
    kernel configuration (like PAGE_SIZE) needs to change."

  - Move the validation of fsdax and devdax infoblocks to
    nd_pfn_validate() so that the presence of non-zero 'start_pad' and
    'end_trunc' can be considered in the alignment validation.

  - Fail namespace creation when the base address is misaligned. A
    non-zero-start_pad prevents dax operation due to original bug of
    ->data_offset being base address relative when it should have been
    ->start_pad relative. So, reject all base address misaligned
    namespaces in nd_pfn_init().

[1]: http://lore.kernel.org/r/158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com

---

Review / merge logistics notes:

Patch "libnvdimm/namespace: Enforce memremap_compat_align()" has
changed enough that it needs to be reviewed again.

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
namespace creation capability as previous kernels.

The ndctl unit tests, which have some misaligned namespace assumptions,
are updated to use the alignment override where necessary.

Thanks to Aneesh for early feedback and testing on this improved
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
 drivers/nvdimm/namespace_devs.c           |   23 ++++-
 drivers/nvdimm/nd.h                       |    3 -
 drivers/nvdimm/pfn_devs.c                 |   34 ++++++-
 drivers/nvdimm/region_devs.c              |  132 ++++++++++++++++++++++++++---
 include/linux/libnvdimm.h                 |    2 
 include/linux/memremap.h                  |    8 ++
 include/linux/mmzone.h                    |    1 
 lib/Kconfig                               |    3 +
 mm/memremap.c                             |   23 +++++
 15 files changed, 307 insertions(+), 47 deletions(-)

base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

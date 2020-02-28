Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAAC17404A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 20:34:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 391F110FC36F4;
	Fri, 28 Feb 2020 11:35:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2D2A810FC36F4
	for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 11:35:00 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 11:34:08 -0800
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400";
   d="scan'208";a="439336541"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 11:34:07 -0800
Subject: [PATCH v3 3/5] libnvdimm/namespace: Enforce memremap_compat_align()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Fri, 28 Feb 2020 11:18:02 -0800
Message-ID: <158291748226.1609624.8971922874557923784.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 3VRVKDU4O4ZPIFL6MF47RIDKWYBO2YYU
X-Message-ID-Hash: 3VRVKDU4O4ZPIFL6MF47RIDKWYBO2YYU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3VRVKDU4O4ZPIFL6MF47RIDKWYBO2YYU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pmem driver on PowerPC crashes with the following signature when
instantiating misaligned namespaces that map their capacity via
memremap_pages().

    BUG: Unable to handle kernel data access at 0xc001000406000000
    Faulting instruction address: 0xc000000000090790
    NIP [c000000000090790] arch_add_memory+0xc0/0x130
    LR [c000000000090744] arch_add_memory+0x74/0x130
    Call Trace:
     arch_add_memory+0x74/0x130 (unreliable)
     memremap_pages+0x74c/0xa30
     devm_memremap_pages+0x3c/0xa0
     pmem_attach_disk+0x188/0x770
     nvdimm_bus_probe+0xd8/0x470

With the assumption that only memremap_pages() has alignment
constraints, enforce memremap_compat_align() for
pmem_should_map_pages(), nd_pfn, and nd_dax cases. This includes
preventing the creation of namespaces where the base address is
misaligned and cases there infoblock padding parameters are invalid.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Fixes: a3619190d62e ("libnvdimm/pfn: stop padding pmem namespaces to section alignment")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |   12 ++++++++++++
 drivers/nvdimm/pfn_devs.c       |   26 +++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 032dc61725ff..68e89855f779 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -10,6 +10,7 @@
 #include <linux/nd.h>
 #include "nd-core.h"
 #include "pmem.h"
+#include "pfn.h"
 #include "nd.h"
 
 static void namespace_io_release(struct device *dev)
@@ -1739,6 +1740,17 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 		return ERR_PTR(-ENODEV);
 	}
 
+	if (pmem_should_map_pages(dev)) {
+		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
+		struct resource *res = &nsio->res;
+
+		if (!IS_ALIGNED(res->start | (res->end + 1),
+					memremap_compat_align())) {
+			dev_err(&ndns->dev, "%pr misaligned, unable to map\n", res);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+	}
+
 	if (is_namespace_pmem(&ndns->dev)) {
 		struct nd_namespace_pmem *nspm;
 
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 79fe02d6f657..3bdd4b883d05 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -446,6 +446,7 @@ static bool nd_supported_alignment(unsigned long align)
 int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 {
 	u64 checksum, offset;
+	struct resource *res;
 	enum nd_pfn_mode mode;
 	struct nd_namespace_io *nsio;
 	unsigned long align, start_pad;
@@ -578,13 +579,14 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 	 * established.
 	 */
 	nsio = to_nd_namespace_io(&ndns->dev);
-	if (offset >= resource_size(&nsio->res)) {
+	res = &nsio->res;
+	if (offset >= resource_size(res)) {
 		dev_err(&nd_pfn->dev, "pfn array size exceeds capacity of %s\n",
 				dev_name(&ndns->dev));
 		return -EOPNOTSUPP;
 	}
 
-	if ((align && !IS_ALIGNED(nsio->res.start + offset + start_pad, align))
+	if ((align && !IS_ALIGNED(res->start + offset + start_pad, align))
 			|| !IS_ALIGNED(offset, PAGE_SIZE)) {
 		dev_err(&nd_pfn->dev,
 				"bad offset: %#llx dax disabled align: %#lx\n",
@@ -592,6 +594,18 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		return -EOPNOTSUPP;
 	}
 
+	if (!IS_ALIGNED(res->start + le32_to_cpu(pfn_sb->start_pad),
+				memremap_compat_align())) {
+		dev_err(&nd_pfn->dev, "resource start misaligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!IS_ALIGNED(res->end + 1 - le32_to_cpu(pfn_sb->end_trunc),
+				memremap_compat_align())) {
+		dev_err(&nd_pfn->dev, "resource end misaligned\n");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(nd_pfn_validate);
@@ -750,7 +764,13 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	start = nsio->res.start;
 	size = resource_size(&nsio->res);
 	npfns = PHYS_PFN(size - SZ_8K);
-	align = max(nd_pfn->align, SUBSECTION_SIZE);
+	align = max(nd_pfn->align, memremap_compat_align());
+	if (!IS_ALIGNED(start, memremap_compat_align())) {
+		dev_err(&nd_pfn->dev, "%s: start %pa misaligned to %#lx\n",
+				dev_name(&ndns->dev), &start,
+				memremap_compat_align());
+		return -EINVAL;
+	}
 	end_trunc = start + size - ALIGN_DOWN(start + size, align);
 	if (nd_pfn->mode == PFN_MODE_PMEM) {
 		/*
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

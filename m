Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C51DDB5E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 May 2020 01:54:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D5D71172D375;
	Thu, 21 May 2020 16:50:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A68F41172D36B
	for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 16:50:54 -0700 (PDT)
IronPort-SDR: m0NLuF1JgDXuvoIiCn86CYb1iMu7gjZhgdIJ3fD7n7ju0WvVOLH3W2CaL6VXF79pWODNdtRMdM
 a6KFJibw/wWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 16:54:28 -0700
IronPort-SDR: k0vW4pbr6l/1Px6LHbUd7ZEfDhfhIQRahtarteM5Dlds0i01/r2K8fKH3nQKnnI5d7iuKMppEp
 4SKoWa5fDIqQ==
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400";
   d="scan'208";a="440664864"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 16:54:28 -0700
Subject: [5.4-stable PATCH 6/7] libnvdimm/region: Introduce NDD_LABELING
From: Dan Williams <dan.j.williams@intel.com>
To: stable@vger.kernel.org
Date: Thu, 21 May 2020 16:38:16 -0700
Message-ID: <159010429637.1062454.16630290613007655390.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159010426294.1062454.8853083370975871627.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159010426294.1062454.8853083370975871627.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: XG77OGJCPKAWPYJSTHEJOUNZRCLVOE7G
X-Message-ID-Hash: XG77OGJCPKAWPYJSTHEJOUNZRCLVOE7G
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, hch@lst.de, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XG77OGJCPKAWPYJSTHEJOUNZRCLVOE7G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit a0e374525def2ef18a078523e1faefb5ce2b05e5 upstream.

The NDD_ALIASING flag is used to indicate where pmem capacity might
alias with blk capacity and require labeling. It is also used to
indicate whether the DIMM supports labeling. Separate this latter
capability into its own flag so that the NDD_ALIASING flag is scoped to
true aliased configurations.

To my knowledge aliased configurations only exist in the ACPI spec,
there are no known platforms that ship this support in production.

This clarity allows namespace-capacity alignment constraints around
interleave-ways to be relaxed.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Oliver O'Halloran <oohall@gmail.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/158041477856.3889308.4212605617834097674.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c |    2 +-
 drivers/acpi/nfit/core.c                  |    4 +++-
 drivers/nvdimm/dimm.c                     |    2 +-
 drivers/nvdimm/dimm_devs.c                |    9 +++++----
 drivers/nvdimm/namespace_devs.c           |    2 +-
 drivers/nvdimm/nd.h                       |    2 +-
 drivers/nvdimm/region_devs.c              |   10 +++++-----
 include/linux/libnvdimm.h                 |    2 ++
 8 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 66fd517c4816..d3cf791bc39f 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -347,7 +347,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	}
 
 	dimm_flags = 0;
-	set_bit(NDD_ALIASING, &dimm_flags);
+	set_bit(NDD_LABELING, &dimm_flags);
 
 	p->nvdimm = nvdimm_create(p->bus, p, papr_scm_dimm_groups,
 				dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 12d980aafc5f..702105b17dda 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2030,8 +2030,10 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 			continue;
 		}
 
-		if (nfit_mem->bdw && nfit_mem->memdev_pmem)
+		if (nfit_mem->bdw && nfit_mem->memdev_pmem) {
 			set_bit(NDD_ALIASING, &flags);
+			set_bit(NDD_LABELING, &flags);
+		}
 
 		/* collate flags across all memdevs for this dimm */
 		list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list) {
diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
index 64776ed15bb3..7d4ddc4d9322 100644
--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -99,7 +99,7 @@ static int nvdimm_probe(struct device *dev)
 	if (ndd->ns_current >= 0) {
 		rc = nd_label_reserve_dpa(ndd);
 		if (rc == 0)
-			nvdimm_set_aliasing(dev);
+			nvdimm_set_labeling(dev);
 	}
 	nvdimm_bus_unlock(dev);
 
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 196aa44c4936..def5c2846bea 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -32,7 +32,7 @@ int nvdimm_check_config_data(struct device *dev)
 
 	if (!nvdimm->cmd_mask ||
 	    !test_bit(ND_CMD_GET_CONFIG_DATA, &nvdimm->cmd_mask)) {
-		if (test_bit(NDD_ALIASING, &nvdimm->flags))
+		if (test_bit(NDD_LABELING, &nvdimm->flags))
 			return -ENXIO;
 		else
 			return -ENOTTY;
@@ -173,11 +173,11 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 	return rc;
 }
 
-void nvdimm_set_aliasing(struct device *dev)
+void nvdimm_set_labeling(struct device *dev)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
-	set_bit(NDD_ALIASING, &nvdimm->flags);
+	set_bit(NDD_LABELING, &nvdimm->flags);
 }
 
 void nvdimm_set_locked(struct device *dev)
@@ -322,8 +322,9 @@ static ssize_t flags_show(struct device *dev,
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
-	return sprintf(buf, "%s%s\n",
+	return sprintf(buf, "%s%s%s\n",
 			test_bit(NDD_ALIASING, &nvdimm->flags) ? "alias " : "",
+			test_bit(NDD_LABELING, &nvdimm->flags) ? "label " : "",
 			test_bit(NDD_LOCKED, &nvdimm->flags) ? "lock " : "");
 }
 static DEVICE_ATTR_RO(flags);
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index b2db15250e0d..8cf1c8932a3b 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2519,7 +2519,7 @@ static int init_active_labels(struct nd_region *nd_region)
 		if (!ndd) {
 			if (test_bit(NDD_LOCKED, &nvdimm->flags))
 				/* fail, label data may be unreadable */;
-			else if (test_bit(NDD_ALIASING, &nvdimm->flags))
+			else if (test_bit(NDD_LABELING, &nvdimm->flags))
 				/* fail, labels needed to disambiguate dpa */;
 			else
 				return 0;
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ee5c04070ef9..4a946c019e0f 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -244,7 +244,7 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 		void *buf, size_t len);
 long nvdimm_clear_poison(struct device *dev, phys_addr_t phys,
 		unsigned int len);
-void nvdimm_set_aliasing(struct device *dev);
+void nvdimm_set_labeling(struct device *dev);
 void nvdimm_set_locked(struct device *dev);
 void nvdimm_clear_locked(struct device *dev);
 int nvdimm_security_setup_events(struct device *dev);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef423ba1a711..b1b13debffbc 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -225,16 +225,16 @@ EXPORT_SYMBOL_GPL(nd_blk_region_set_provider_data);
 int nd_region_to_nstype(struct nd_region *nd_region)
 {
 	if (is_memory(&nd_region->dev)) {
-		u16 i, alias;
+		u16 i, label;
 
-		for (i = 0, alias = 0; i < nd_region->ndr_mappings; i++) {
+		for (i = 0, label = 0; i < nd_region->ndr_mappings; i++) {
 			struct nd_mapping *nd_mapping = &nd_region->mapping[i];
 			struct nvdimm *nvdimm = nd_mapping->nvdimm;
 
-			if (test_bit(NDD_ALIASING, &nvdimm->flags))
-				alias++;
+			if (test_bit(NDD_LABELING, &nvdimm->flags))
+				label++;
 		}
-		if (alias)
+		if (label)
 			return ND_DEVICE_NAMESPACE_PMEM;
 		else
 			return ND_DEVICE_NAMESPACE_IO;
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index b6eddf912568..aa4b79d68d79 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -37,6 +37,8 @@ enum {
 	NDD_WORK_PENDING = 4,
 	/* ignore / filter NSLABEL_FLAG_LOCAL for this DIMM, i.e. no aliasing */
 	NDD_NOBLK = 5,
+	/* dimm supports namespace labels */
+	NDD_LABELING = 6,
 
 	/* need to set a limit somewhere, but yes, this is likely overkill */
 	ND_IOCTL_MAX_BUFLEN = SZ_4M,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

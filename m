Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E419DC7B
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 19:15:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B234100EAAED;
	Fri,  3 Apr 2020 10:16:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95DCB100EAAEC
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 10:16:44 -0700 (PDT)
IronPort-SDR: tpJ2E5vQSCQOHo9rVAvMbXPRCRXU8IuKEkojnk4G5iC+GKJhzYTIKOUbOu6+FYrMP3JZmXDgky
 XDUvM65dwOaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 10:15:53 -0700
IronPort-SDR: 2ibBz1wZw+veTyE7+9tzY1s8bhlqE0fF/VEqkPu1ozgix2VgaXG+8chkDkRCMeGAlcCIfEuouu
 s78qyZmgF1MQ==
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200";
   d="scan'208";a="250225746"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 10:15:52 -0700
Subject: [PATCH] libnvdimm: Validate command family indices
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Fri, 03 Apr 2020 09:59:45 -0700
Message-ID: <158593318491.130477.12103487421973195234.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: UNWFASPZRU6G3GIUJ3XWQFUV5QTSI742
X-Message-ID-Hash: UNWFASPZRU6G3GIUJ3XWQFUV5QTSI742
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: vaibhav@linux.ibm.com, aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UNWFASPZRU6G3GIUJ3XWQFUV5QTSI742/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ND_CMD_CALL format allows for a general passthrough of whitelisted
commands targeting a given command set. However there is no validation
of the family index relative to what the bus supports.

- Update the NFIT bus implementation (the only one that supports
  ND_CMD_CALL passthrough) to also whitelist the valid set of command
  family indices.

- Update the generic __nd_ioctl() path to validate that field on behalf
  of all implementations.

Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command marshaling mechanism")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c   |   11 +++++++++--
 drivers/acpi/nfit/nfit.h   |    1 -
 drivers/nvdimm/bus.c       |   16 ++++++++++++++++
 include/linux/libnvdimm.h  |    2 ++
 include/uapi/linux/ndctl.h |    4 ++++
 5 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index d0090f71585c..bcf5af803941 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1823,6 +1823,7 @@ static void populate_shutdown_status(struct nfit_mem *nfit_mem)
 static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 		struct nfit_mem *nfit_mem, u32 device_handle)
 {
+	struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
 	struct acpi_device *adev, *adev_dimm;
 	struct device *dev = acpi_desc->dev;
 	unsigned long dsm_mask, label_mask;
@@ -1834,6 +1835,7 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 	/* nfit test assumes 1:1 relationship between commands and dsms */
 	nfit_mem->dsm_mask = acpi_desc->dimm_cmd_force_en;
 	nfit_mem->family = NVDIMM_FAMILY_INTEL;
+	set_bit(NVDIMM_FAMILY_INTEL, &nd_desc->dimm_family_mask);
 
 	if (dcr->valid_fields & ACPI_NFIT_CONTROL_MFG_INFO_VALID)
 		sprintf(nfit_mem->id, "%04x-%02x-%04x-%08x",
@@ -1886,10 +1888,13 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 	 * Note, that checking for function0 (bit0) tells us if any commands
 	 * are reachable through this GUID.
 	 */
+	clear_bit(NVDIMM_FAMILY_INTEL, &nd_desc->dimm_family_mask);
 	for (i = 0; i <= NVDIMM_FAMILY_MAX; i++)
-		if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 1))
+		if (acpi_check_dsm(adev_dimm->handle, to_nfit_uuid(i), 1, 1)) {
+			set_bit(i, &nd_desc->dimm_family_mask);
 			if (family < 0 || i == default_dsm_family)
 				family = i;
+		}
 
 	/* limit the supported commands to those that are publicly documented */
 	nfit_mem->family = family;
@@ -2151,6 +2156,9 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
 
 	nd_desc->cmd_mask = acpi_desc->bus_cmd_force_en;
 	nd_desc->bus_dsm_mask = acpi_desc->bus_nfit_cmd_force_en;
+	set_bit(ND_CMD_CALL, &nd_desc->cmd_mask);
+	set_bit(NVDIMM_BUS_FAMILY_NFIT, &nd_desc->bus_family_mask);
+
 	adev = to_acpi_dev(acpi_desc);
 	if (!adev)
 		return;
@@ -2158,7 +2166,6 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
 	for (i = ND_CMD_ARS_CAP; i <= ND_CMD_CLEAR_ERROR; i++)
 		if (acpi_check_dsm(adev->handle, guid, 1, 1ULL << i))
 			set_bit(i, &nd_desc->cmd_mask);
-	set_bit(ND_CMD_CALL, &nd_desc->cmd_mask);
 
 	dsm_mask =
 		(1 << ND_CMD_ARS_CAP) |
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index b317f4043705..5f5f8ce030e7 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -33,7 +33,6 @@
 		| ACPI_NFIT_MEM_RESTORE_FAILED | ACPI_NFIT_MEM_FLUSH_FAILED \
 		| ACPI_NFIT_MEM_NOT_ARMED | ACPI_NFIT_MEM_MAP_FAILED)
 
-#define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_HYPERV
 #define NVDIMM_CMD_MAX 31
 
 #define NVDIMM_STANDARD_CMDMASK \
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 09087c38fabd..955265656b96 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -1037,9 +1037,25 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		dimm_name = "bus";
 	}
 
+	/* Validate command family support against bus declared support */
 	if (cmd == ND_CMD_CALL) {
+		unsigned long *mask;
+
 		if (copy_from_user(&pkg, p, sizeof(pkg)))
 			return -EFAULT;
+
+		if (nvdimm) {
+			if (pkg.nd_family > NVDIMM_FAMILY_MAX)
+				return -EINVAL;
+			mask = &nd_desc->dimm_family_mask;
+		} else {
+			if (pkg.nd_family > NVDIMM_BUS_FAMILY_MAX)
+				return -EINVAL;
+			mask = &nd_desc->bus_family_mask;
+		}
+
+		if (!test_bit(pkg.nd_family, mask))
+			return -EINVAL;
 	}
 
 	if (!desc ||
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 9df091bd30ba..b41857f43883 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -76,6 +76,8 @@ struct nvdimm_bus_descriptor {
 	const struct attribute_group **attr_groups;
 	unsigned long bus_dsm_mask;
 	unsigned long cmd_mask;
+	unsigned long dimm_family_mask;
+	unsigned long bus_family_mask;
 	struct module *module;
 	char *provider_name;
 	struct device_node *of_node;
diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index de5d90212409..e28763c234e2 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -244,6 +244,10 @@ struct nd_cmd_pkg {
 #define NVDIMM_FAMILY_HPE2 2
 #define NVDIMM_FAMILY_MSFT 3
 #define NVDIMM_FAMILY_HYPERV 4
+#define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_HYPERV
+
+#define NVDIMM_BUS_FAMILY_NFIT 0
+#define NVDIMM_BUS_FAMILY_MAX NVDIMM_BUS_FAMILY_NFIT
 
 #define ND_IOCTL_CALL			_IOWR(ND_IOCTL, ND_CMD_CALL,\
 					struct nd_cmd_pkg)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

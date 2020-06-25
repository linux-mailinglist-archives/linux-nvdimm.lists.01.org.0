Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C65C20A9A7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 02:07:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 402B811022320;
	Thu, 25 Jun 2020 17:07:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9BACD11022293
	for <linux-nvdimm@lists.01.org>; Thu, 25 Jun 2020 17:07:39 -0700 (PDT)
IronPort-SDR: LusstvUAnqaePZNNP/c4cIBAP1CP8ND6s9a31gKpSanK+cQUonCPSlL1qDbtLvUe/p7WRLj649
 POyQTqbYKbJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="146633819"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800";
   d="scan'208";a="146633819"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:39 -0700
IronPort-SDR: 37AFNh7w2FLq7Xlz2iv5YnX04JnUsNMsmWsQtxtBDjquqbf7gTZMrG6upNdPfLdhvufjz1l5uJ
 f/fjKIy4eZ7w==
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800";
   d="scan'208";a="276198085"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:39 -0700
Subject: [PATCH 12/12] ACPI: NFIT: Add runtime firmware activate support
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 25 Jun 2020 16:51:24 -0700
Message-ID: <159312908490.1850128.13763087150201006817.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: HLE5ZEBEV4IF4W25QEJN6LBPAGPFUVKE
X-Message-ID-Hash: HLE5ZEBEV4IF4W25QEJN6LBPAGPFUVKE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HLE5ZEBEV4IF4W25QEJN6LBPAGPFUVKE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Plumb the platform specific backend for the generic libnvdimm firmware
activate interface. Register dimm level operations to arm/disarm
activation, and register bus level operations to report the dynamic
platform-quiesce time relative to the number of dimms armed for firmware
activation.

A new nfit-specific bus attribute "firmware_activate_noidle" is added to
allow the activation to switch between platform enforced, and OS
opportunistic device quiesce. Another nfit-specific bus attribute
"firmware_activate_nosuspend" is added to allow activation to be
initiated at runtime rather than a suspend-callback.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-nfit |   35 ++
 drivers/acpi/nfit/core.c                 |   45 +++
 drivers/acpi/nfit/intel.c                |  426 ++++++++++++++++++++++++++++++
 drivers/acpi/nfit/intel.h                |    3 
 drivers/acpi/nfit/nfit.h                 |   11 +
 drivers/nvdimm/core.c                    |    8 +
 drivers/nvdimm/dimm_devs.c               |    4 
 include/linux/libnvdimm.h                |    6 
 8 files changed, 531 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-nfit b/Documentation/ABI/testing/sysfs-bus-nfit
index a1cb44dcb908..c25d6d19f6e0 100644
--- a/Documentation/ABI/testing/sysfs-bus-nfit
+++ b/Documentation/ABI/testing/sysfs-bus-nfit
@@ -202,6 +202,41 @@ Description:
 		functions. See the section named 'NVDIMM Root Device _DSMs' in
 		the ACPI specification.
 
+What:		/sys/bus/nd/devices/ndbusX/nfit/firmware_activate_noidle
+Date:		Apr, 2020
+KernelVersion:	v5.8
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RW) The Intel platform implementation of firmware activate
+		support exposes an option let the platform force idle devices in
+		the system over the activation event, or trust that the OS will
+		do it. The safe default is to let the platform force idle
+		devices since the kernel is already in a suspend state, and on
+		the chance that a driver does not properly quiesce bus-mastering
+		after a suspend callback the platform will handle it.  However,
+		the activation might abort if, for example, platform firmware
+		determines that the activation time exceeds the max PCI-E
+		completion timeout. Since the platform does not know whether the
+		OS is running the activation from a suspend context it aborts,
+		but if the system owner trusts driver suspend callback to be
+		sufficient then 'firmware_activation_noidle' can be
+		enabled to bypass the activation abort.
+
+What:		/sys/bus/nd/devices/ndbusX/nfit/firmware_activate_nosuspend
+Date:		Apr, 2020
+KernelVersion:	v5.8
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RW) The Intel platform implementation of firmware activate
+		enforces a memory-controller quiesce event while DMA might be
+		in-flight. That in-flight DMA may timeout awaiting the
+		activation to complete and cause undefined system behavior.
+		For this reason firmware activate is, by default, limited to
+		be carried out after all system device drivers have executed
+		their power-management-suspend callbacks. Otherwise, setting
+		this override allows firmware activate to be triggered outside
+		of the the suspend context by writing "activate" to
+		/sys/bus/nd/devices/ndbusX/firmware_activate.
 
 What:		/sys/bus/nd/devices/regionX/nfit/range_index
 Date:		Jun, 2015
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 78cc9e2d2aa3..e3e716f46e96 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1392,8 +1392,15 @@ static umode_t nfit_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 
-	if (a == &dev_attr_scrub.attr && !ars_supported(nvdimm_bus))
-		return 0;
+	if (a == &dev_attr_scrub.attr)
+		return ars_supported(nvdimm_bus) ? a->mode : 0;
+
+	if (a == &dev_attr_firmware_activate_noidle.attr)
+		return intel_fwa_supported(nvdimm_bus) ? a->mode : 0;
+
+	if (a == &dev_attr_firmware_activate_nosuspend.attr)
+		return intel_fwa_supported(nvdimm_bus) ? a->mode : 0;
+
 	return a->mode;
 }
 
@@ -1402,6 +1409,8 @@ static struct attribute *acpi_nfit_attributes[] = {
 	&dev_attr_scrub.attr,
 	&dev_attr_hw_error_scrub.attr,
 	&dev_attr_bus_dsm_mask.attr,
+	&dev_attr_firmware_activate_noidle.attr,
+	&dev_attr_firmware_activate_nosuspend.attr,
 	NULL,
 };
 
@@ -2019,6 +2028,26 @@ static const struct nvdimm_security_ops *acpi_nfit_get_security_ops(int family)
 	}
 }
 
+static const struct nvdimm_fw_ops *acpi_nfit_get_fw_ops(
+		struct nfit_mem *nfit_mem)
+{
+	unsigned long mask;
+	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
+	struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
+
+	if (!nd_desc->fw_ops)
+		return NULL;
+
+	if (nfit_mem->family != NVDIMM_FAMILY_INTEL)
+		return NULL;
+
+	mask = nfit_mem->dsm_mask & NVDIMM_INTEL_FW_ACTIVATE_CMDMASK;
+	if (mask != NVDIMM_INTEL_FW_ACTIVATE_CMDMASK)
+		return NULL;
+
+	return intel_fw_ops;
+}
+
 static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 {
 	struct nfit_mem *nfit_mem;
@@ -2095,7 +2124,8 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 				acpi_nfit_dimm_attribute_groups,
 				flags, cmd_mask, flush ? flush->hint_count : 0,
 				nfit_mem->flush_wpq, &nfit_mem->id[0],
-				acpi_nfit_get_security_ops(nfit_mem->family));
+				acpi_nfit_get_security_ops(nfit_mem->family),
+				acpi_nfit_get_fw_ops(nfit_mem));
 		if (!nvdimm)
 			return -ENOMEM;
 
@@ -2170,8 +2200,10 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
 	if (acpi_desc->bus_cmd_force_en) {
 		nd_desc->cmd_mask = acpi_desc->bus_cmd_force_en;
 		mask = &nd_desc->bus_family_mask;
-		if (acpi_desc->family_dsm_mask[NVDIMM_BUS_FAMILY_INTEL])
+		if (acpi_desc->family_dsm_mask[NVDIMM_BUS_FAMILY_INTEL]) {
 			set_bit(NVDIMM_BUS_FAMILY_INTEL, mask);
+			nd_desc->fw_ops = intel_bus_fw_ops;
+		}
 	}
 
 	adev = to_acpi_dev(acpi_desc);
@@ -2202,6 +2234,11 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
 	for_each_set_bit(i, &dsm_mask, BITS_PER_LONG)
 		if (acpi_check_dsm(adev->handle, guid, 1, 1ULL << i))
 			set_bit(i, mask);
+
+	if (*mask == dsm_mask) {
+		set_bit(NVDIMM_BUS_FAMILY_INTEL, &nd_desc->bus_family_mask);
+		nd_desc->fw_ops = intel_bus_fw_ops;
+	}
 }
 
 static ssize_t range_index_show(struct device *dev,
diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 1113b679cd7b..437ebab08d9f 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -7,6 +7,86 @@
 #include "intel.h"
 #include "nfit.h"
 
+static ssize_t firmware_activate_noidle_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
+
+	return sprintf(buf, "%s\n", acpi_desc->fwa_noidle ? "Y" : "N");
+}
+
+static ssize_t firmware_activate_noidle_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
+	ssize_t rc;
+	bool val;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+	if (val != acpi_desc->fwa_noidle)
+		acpi_desc->fwa_cap = NVDIMM_FWA_CAP_INVALID;
+	acpi_desc->fwa_noidle = val;
+	return size;
+}
+DEVICE_ATTR_RW(firmware_activate_noidle);
+
+static ssize_t firmware_activate_nosuspend_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
+
+	return sprintf(buf, "%s\n", acpi_desc->fwa_nosuspend ? "Y" : "N");
+}
+
+static ssize_t firmware_activate_nosuspend_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
+	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
+	ssize_t rc;
+	bool val;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+	if (val != acpi_desc->fwa_nosuspend) {
+		/*
+		 * Invalidate cached capability state and update sysfs
+		 * permissions.
+		 */
+		acpi_desc->fwa_cap = NVDIMM_FWA_CAP_INVALID;
+		acpi_desc->fwa_nosuspend = val;
+		rc = nvdimm_bus_update_sysfs(nvdimm_bus);
+	}
+
+	if (rc == 0)
+		rc = size;
+	return rc;
+}
+DEVICE_ATTR_RW(firmware_activate_nosuspend);
+
+bool intel_fwa_supported(struct nvdimm_bus *nvdimm_bus)
+{
+	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
+	unsigned long *mask;
+
+	if (!test_bit(NVDIMM_BUS_FAMILY_INTEL, &nd_desc->bus_family_mask))
+		return false;
+
+	mask = &acpi_desc->family_dsm_mask[NVDIMM_BUS_FAMILY_INTEL];
+	return *mask == NVDIMM_BUS_INTEL_FW_ACTIVATE_CMDMASK;
+}
+
 static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 		enum nvdimm_passphrase_type ptype)
 {
@@ -389,3 +469,349 @@ static const struct nvdimm_security_ops __intel_security_ops = {
 };
 
 const struct nvdimm_security_ops *intel_security_ops = &__intel_security_ops;
+
+static int intel_bus_fwa_businfo(struct nvdimm_bus_descriptor *nd_desc,
+		struct nd_intel_bus_fw_activate_businfo *info)
+{
+	struct {
+		struct nd_cmd_pkg pkg;
+		struct nd_intel_bus_fw_activate_businfo cmd;
+	} nd_cmd = {
+		.pkg = {
+			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO,
+			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
+			.nd_size_out =
+				sizeof(struct nd_intel_bus_fw_activate_businfo),
+			.nd_fw_size =
+				sizeof(struct nd_intel_bus_fw_activate_businfo),
+		},
+	};
+	int rc;
+
+	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd),
+			NULL);
+	*info = nd_cmd.cmd;
+	return rc;
+}
+
+/* The fw_ops expect to be called with the nvdimm_bus_lock() held */
+static enum nvdimm_fwa_state intel_bus_fwa_state(
+		struct nvdimm_bus_descriptor *nd_desc)
+{
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
+	struct nd_intel_bus_fw_activate_businfo info;
+	struct device *dev = acpi_desc->dev;
+	enum nvdimm_fwa_state state;
+	int rc;
+
+	/*
+	 * It should not be possible for platform firmware to return
+	 * busy because activate is a synchronous operation. Treat it
+	 * similar to invalid, i.e. always refresh / poll the status.
+	 */
+	switch (acpi_desc->fwa_state) {
+	case NVDIMM_FWA_INVALID:
+	case NVDIMM_FWA_BUSY:
+		break;
+	default:
+		/* check if capability needs to be refreshed */
+		if (acpi_desc->fwa_cap == NVDIMM_FWA_CAP_INVALID)
+			break;
+		return acpi_desc->fwa_state;
+	}
+
+	/* Refresh with platform firmware */
+	rc = intel_bus_fwa_businfo(nd_desc, &info);
+	if (rc)
+		return NVDIMM_FWA_INVALID;
+
+	switch (info.state) {
+	case ND_INTEL_FWA_IDLE:
+		state = NVDIMM_FWA_IDLE;
+		break;
+	case ND_INTEL_FWA_BUSY:
+		state = NVDIMM_FWA_BUSY;
+		break;
+	case ND_INTEL_FWA_ARMED:
+		if (info.activate_tmo > info.max_quiesce_tmo)
+			state = NVDIMM_FWA_ARM_OVERFLOW;
+		else
+			state = NVDIMM_FWA_ARMED;
+		break;
+	default:
+		dev_err_once(dev, "invalid firmware activate state %d\n",
+				info.state);
+		return NVDIMM_FWA_INVALID;
+	}
+
+	/*
+	 * Capability data is available in the same payload as state.
+	 * While it can be assumed that it does not change it may need
+	 * to be re-evaluated relative to the ->fwa_noidle and
+	 * ->fwa_nosuspend settings.
+	 */
+	if (acpi_desc->fwa_cap == NVDIMM_FWA_CAP_INVALID) {
+		if (info.capability & (ND_INTEL_BUS_FWA_CAP_FWQUIESCE))
+			acpi_desc->fwa_cap = NVDIMM_FWA_CAP_QUIESCE;
+		else if (acpi_desc->fwa_noidle && (info.capability
+					& ND_INTEL_BUS_FWA_CAP_OSQUIESCE))
+			acpi_desc->fwa_cap = NVDIMM_FWA_CAP_QUIESCE;
+		else
+			acpi_desc->fwa_cap = NVDIMM_FWA_CAP_NONE;
+	}
+
+	if (acpi_desc->fwa_cap == NVDIMM_FWA_CAP_QUIESCE
+			&& acpi_desc->fwa_nosuspend)
+		acpi_desc->fwa_cap = NVDIMM_FWA_CAP_LIVE;
+
+	acpi_desc->fwa_state = state;
+
+	return state;
+}
+
+static enum nvdimm_fwa_capability intel_bus_fwa_capability(
+		struct nvdimm_bus_descriptor *nd_desc)
+{
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
+
+	if (acpi_desc->fwa_cap > NVDIMM_FWA_CAP_INVALID)
+		return acpi_desc->fwa_cap;
+
+	if (intel_bus_fwa_state(nd_desc) > NVDIMM_FWA_INVALID)
+		return acpi_desc->fwa_cap;
+
+	return NVDIMM_FWA_CAP_INVALID;
+}
+
+static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
+{
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
+	struct {
+		struct nd_cmd_pkg pkg;
+		struct nd_intel_bus_fw_activate cmd;
+	} nd_cmd = {
+		.pkg = {
+			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
+			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
+			.nd_size_in = sizeof(nd_cmd.cmd.iodev_state),
+			.nd_size_out =
+				sizeof(struct nd_intel_bus_fw_activate),
+			.nd_fw_size =
+				sizeof(struct nd_intel_bus_fw_activate),
+		},
+		/*
+		 * Even though activate is run from a suspended context,
+		 * for safety, still ask platform firmware to force
+		 * quiesce devices by default. Let a module
+		 * parameter override that policy.
+		 */
+		.cmd = {
+			.iodev_state = acpi_desc->fwa_noidle
+				? ND_INTEL_BUS_FWA_IODEV_OS_IDLE
+				: ND_INTEL_BUS_FWA_IODEV_FORCE_IDLE,
+		},
+	};
+	int rc;
+
+	switch (intel_bus_fwa_state(nd_desc)) {
+	case NVDIMM_FWA_ARMED:
+	case NVDIMM_FWA_ARM_OVERFLOW:
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd),
+			NULL);
+
+	/*
+	 * Whether the command succeeded, or failed, the agent checking
+	 * for the result needs to query the DIMMs individually.
+	 * Increment the activation count to invalidate all the DIMM
+	 * states at once (it's otherwise not possible to take
+	 * acpi_desc->init_mutex in this context)
+	 */
+	acpi_desc->fwa_state = NVDIMM_FWA_INVALID;
+	acpi_desc->fwa_count++;
+
+	dev_dbg(acpi_desc->dev, "result: %d\n", rc);
+
+	return rc;
+}
+
+static const struct nvdimm_bus_fw_ops __intel_bus_fw_ops = {
+	.activate_state = intel_bus_fwa_state,
+	.capability = intel_bus_fwa_capability,
+	.activate = intel_bus_fwa_activate,
+};
+
+const struct nvdimm_bus_fw_ops *intel_bus_fw_ops = &__intel_bus_fw_ops;
+
+static int intel_fwa_dimminfo(struct nvdimm *nvdimm,
+		struct nd_intel_fw_activate_dimminfo *info)
+{
+	struct {
+		struct nd_cmd_pkg pkg;
+		struct nd_intel_fw_activate_dimminfo cmd;
+	} nd_cmd = {
+		.pkg = {
+			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO,
+			.nd_family = NVDIMM_FAMILY_INTEL,
+			.nd_size_out =
+				sizeof(struct nd_intel_fw_activate_dimminfo),
+			.nd_fw_size =
+				sizeof(struct nd_intel_fw_activate_dimminfo),
+		},
+	};
+	int rc;
+
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
+	*info = nd_cmd.cmd;
+	return rc;
+}
+
+static enum nvdimm_fwa_state intel_fwa_state(struct nvdimm *nvdimm)
+{
+	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
+	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
+	struct nd_intel_fw_activate_dimminfo info;
+	int rc;
+
+	/*
+	 * Similar to the bus state, since activate is synchronous the
+	 * busy state should resolve within the context of 'activate'.
+	 */
+	switch (nfit_mem->fwa_state) {
+	case NVDIMM_FWA_INVALID:
+	case NVDIMM_FWA_BUSY:
+		break;
+	default:
+		/* If no activations occurred the old state is still valid */
+		if (nfit_mem->fwa_count == acpi_desc->fwa_count)
+			return nfit_mem->fwa_state;
+	}
+
+	rc = intel_fwa_dimminfo(nvdimm, &info);
+	if (rc)
+		return NVDIMM_FWA_INVALID;
+
+	switch (info.state) {
+	case ND_INTEL_FWA_IDLE:
+		nfit_mem->fwa_state = NVDIMM_FWA_IDLE;
+		break;
+	case ND_INTEL_FWA_BUSY:
+		nfit_mem->fwa_state = NVDIMM_FWA_BUSY;
+		break;
+	case ND_INTEL_FWA_ARMED:
+		nfit_mem->fwa_state = NVDIMM_FWA_ARMED;
+		break;
+	default:
+		nfit_mem->fwa_state = NVDIMM_FWA_INVALID;
+		break;
+	}
+
+	switch (info.result) {
+	case ND_INTEL_DIMM_FWA_NONE:
+		nfit_mem->fwa_result = NVDIMM_FWA_RESULT_NONE;
+		break;
+	case ND_INTEL_DIMM_FWA_SUCCESS:
+		nfit_mem->fwa_result = NVDIMM_FWA_RESULT_SUCCESS;
+		break;
+	case ND_INTEL_DIMM_FWA_NOTSTAGED:
+		nfit_mem->fwa_result = NVDIMM_FWA_RESULT_NOTSTAGED;
+		break;
+	case ND_INTEL_DIMM_FWA_NEEDRESET:
+		nfit_mem->fwa_result = NVDIMM_FWA_RESULT_NEEDRESET;
+		break;
+	case ND_INTEL_DIMM_FWA_MEDIAFAILED:
+	case ND_INTEL_DIMM_FWA_ABORT:
+	case ND_INTEL_DIMM_FWA_NOTSUPP:
+	case ND_INTEL_DIMM_FWA_ERROR:
+	default:
+		nfit_mem->fwa_result = NVDIMM_FWA_RESULT_FAIL;
+		break;
+	}
+
+	nfit_mem->fwa_count = acpi_desc->fwa_count;
+
+	return nfit_mem->fwa_state;
+}
+
+static enum nvdimm_fwa_result intel_fwa_result(struct nvdimm *nvdimm)
+{
+	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
+	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
+
+	if (nfit_mem->fwa_count == acpi_desc->fwa_count
+			&& nfit_mem->fwa_result > NVDIMM_FWA_RESULT_INVALID)
+		return nfit_mem->fwa_result;
+
+	if (intel_fwa_state(nvdimm) > NVDIMM_FWA_INVALID)
+		return nfit_mem->fwa_result;
+
+	return NVDIMM_FWA_RESULT_INVALID;
+}
+
+static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
+{
+	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
+	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
+	struct {
+		struct nd_cmd_pkg pkg;
+		struct nd_intel_fw_activate_arm cmd;
+	} nd_cmd = {
+		.pkg = {
+			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
+			.nd_family = NVDIMM_FAMILY_INTEL,
+			.nd_size_in = sizeof(nd_cmd.cmd.activate_arm),
+			.nd_size_out =
+				sizeof(struct nd_intel_fw_activate_arm),
+			.nd_fw_size =
+				sizeof(struct nd_intel_fw_activate_arm),
+		},
+		.cmd = {
+			.activate_arm = arm == NVDIMM_FWA_ARM
+				? ND_INTEL_DIMM_FWA_ARM
+				: ND_INTEL_DIMM_FWA_DISARM,
+		},
+	};
+	int rc;
+
+	switch (intel_fwa_state(nvdimm)) {
+	case NVDIMM_FWA_INVALID:
+		return -ENXIO;
+	case NVDIMM_FWA_BUSY:
+		return -EBUSY;
+	case NVDIMM_FWA_IDLE:
+		if (arm == NVDIMM_FWA_DISARM)
+			return 0;
+		break;
+	case NVDIMM_FWA_ARMED:
+		if (arm == NVDIMM_FWA_ARM)
+			return 0;
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	/*
+	 * Invalidate the bus-level state, now that we're committed to
+	 * changing the 'arm' state.
+	 */
+	acpi_desc->fwa_state = NVDIMM_FWA_INVALID;
+	nfit_mem->fwa_state = NVDIMM_FWA_INVALID;
+
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
+
+	dev_dbg(acpi_desc->dev, "%s result: %d\n", arm == NVDIMM_FWA_ARM
+			? "arm" : "disarm", rc);
+	return rc;
+}
+
+static const struct nvdimm_fw_ops __intel_fw_ops = {
+	.activate_state = intel_fwa_state,
+	.activate_result = intel_fwa_result,
+	.arm = intel_fwa_arm,
+};
+
+const struct nvdimm_fw_ops *intel_fw_ops = &__intel_fw_ops;
diff --git a/drivers/acpi/nfit/intel.h b/drivers/acpi/nfit/intel.h
index 49a598623024..b768234ccebc 100644
--- a/drivers/acpi/nfit/intel.h
+++ b/drivers/acpi/nfit/intel.h
@@ -169,4 +169,7 @@ struct nd_intel_bus_fw_activate {
 	u8 iodev_state;
 	u32 status;
 } __packed;
+
+extern const struct nvdimm_fw_ops *intel_fw_ops;
+extern const struct nvdimm_bus_fw_ops *intel_bus_fw_ops;
 #endif
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 97c122628975..b0c2e83d0fea 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -220,6 +220,9 @@ struct nfit_mem {
 	struct list_head list;
 	struct acpi_device *adev;
 	struct acpi_nfit_desc *acpi_desc;
+	enum nvdimm_fwa_state fwa_state;
+	enum nvdimm_fwa_result fwa_result;
+	int fwa_count;
 	char id[NFIT_DIMM_ID_LEN+1];
 	struct resource *flush_wpq;
 	unsigned long dsm_mask;
@@ -265,6 +268,11 @@ struct acpi_nfit_desc {
 	unsigned int scrub_tmo;
 	int (*blk_do_io)(struct nd_blk_region *ndbr, resource_size_t dpa,
 			void *iobuf, u64 len, int rw);
+	enum nvdimm_fwa_state fwa_state;
+	enum nvdimm_fwa_capability fwa_cap;
+	int fwa_count;
+	bool fwa_noidle;
+	bool fwa_nosuspend;
 };
 
 enum scrub_mode {
@@ -367,4 +375,7 @@ void __acpi_nvdimm_notify(struct device *dev, u32 event);
 int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc);
 void acpi_nfit_desc_init(struct acpi_nfit_desc *acpi_desc, struct device *dev);
+bool intel_fwa_supported(struct nvdimm_bus *nvdimm_bus);
+extern struct device_attribute dev_attr_firmware_activate_noidle;
+extern struct device_attribute dev_attr_firmware_activate_nosuspend;
 #endif /* __NFIT_H__ */
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 0cbb5620cd45..56fca9f059fd 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -484,6 +484,14 @@ static const struct attribute_group nvdimm_bus_attribute_group = {
 	.is_visible = nvdimm_bus_visible,
 };
 
+int nvdimm_bus_update_sysfs(struct nvdimm_bus *nvdimm_bus)
+{
+	struct device *dev = &nvdimm_bus->dev;
+
+	return sysfs_update_group(&dev->kobj, &nvdimm_bus_attribute_group);
+}
+EXPORT_SYMBOL_GPL(nvdimm_bus_update_sysfs);
+
 const struct attribute_group *nvdimm_bus_attribute_groups[] = {
 	&nvdimm_bus_attribute_group,
 	NULL,
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 85835f9add7a..b6d9fa8f72df 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -562,7 +562,8 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 		void *provider_data, const struct attribute_group **groups,
 		unsigned long flags, unsigned long cmd_mask, int num_flush,
 		struct resource *flush_wpq, const char *dimm_id,
-		const struct nvdimm_security_ops *sec_ops)
+		const struct nvdimm_security_ops *sec_ops,
+		const struct nvdimm_fw_ops *fw_ops)
 {
 	struct nvdimm *nvdimm = kzalloc(sizeof(*nvdimm), GFP_KERNEL);
 	struct device *dev;
@@ -592,6 +593,7 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 	dev->devt = MKDEV(nvdimm_major, nvdimm->id);
 	dev->groups = groups;
 	nvdimm->sec.ops = sec_ops;
+	nvdimm->fw_ops = fw_ops;
 	nvdimm->sec.overwrite_tmo = 0;
 	INIT_DELAYED_WORK(&nvdimm->dwork, nvdimm_security_overwrite_query);
 	/*
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 15dbcb718316..815f57f23b7a 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -244,6 +244,7 @@ struct nvdimm_fw_ops {
 	int (*arm)(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arg);
 };
 
+int nvdimm_bus_update_sysfs(struct nvdimm_bus *bus);
 void badrange_init(struct badrange *badrange);
 int badrange_add(struct badrange *badrange, u64 addr, u64 length);
 void badrange_forget(struct badrange *badrange, phys_addr_t start,
@@ -269,14 +270,15 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 		void *provider_data, const struct attribute_group **groups,
 		unsigned long flags, unsigned long cmd_mask, int num_flush,
 		struct resource *flush_wpq, const char *dimm_id,
-		const struct nvdimm_security_ops *sec_ops);
+		const struct nvdimm_security_ops *sec_ops,
+		const struct nvdimm_fw_ops *fw_ops);
 static inline struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 		void *provider_data, const struct attribute_group **groups,
 		unsigned long flags, unsigned long cmd_mask, int num_flush,
 		struct resource *flush_wpq)
 {
 	return __nvdimm_create(nvdimm_bus, provider_data, groups, flags,
-			cmd_mask, num_flush, flush_wpq, NULL, NULL);
+			cmd_mask, num_flush, flush_wpq, NULL, NULL, NULL);
 }
 
 const struct nd_cmd_desc *nd_cmd_dimm_desc(int cmd);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

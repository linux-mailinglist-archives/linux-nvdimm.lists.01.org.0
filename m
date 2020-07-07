Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE10C2163B7
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:15:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 960AF1108DEA8;
	Mon,  6 Jul 2020 19:15:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42D311108C539
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:15:27 -0700 (PDT)
IronPort-SDR: xGWYQLzmqrO3KDstpHPHFE9jg6w84n7rlF5qtE5iakWG7YI6Bpd2f0lKfbv2eAweeCSCsBNlfS
 +D6LOYU4/AOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="145028459"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="145028459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:27 -0700
IronPort-SDR: sY5CCAcl7SGiNPI6WYe5EeibOYfh1RH2TRHpZ4z2FmjZBwqv4457xzszF91NbKbG3WgTjHGQyX
 f4ny7Llsln0g==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="323390455"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:26 -0700
Subject: [PATCH v2 07/12] tools/testing/nvdimm: Emulate firmware activation
 commands
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 06 Jul 2020 18:59:11 -0700
Message-ID: <159408715138.2385045.4589408981694581923.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: P4YR7QPRDDGDPVAIUTO3JEV75DQETPLC
X-Message-ID-Hash: P4YR7QPRDDGDPVAIUTO3JEV75DQETPLC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P4YR7QPRDDGDPVAIUTO3JEV75DQETPLC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Augment the existing firmware update emulation to track activations and
validate proper update vs activate sequencing.

The DIMM firmware activate capability has a concept of a maximum amount
of time platform firmware will quiesce the system relative to how many
DIMMs are being activated in parallel. Simulate that DIMM activation
happens serially, 1 second per-DIMM, and limit the max at 3 seconds. The
nfit_test0 bus emulates 5 DIMMs so it will take 2 activations to update
all DIMMs.

Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/intel.h        |    5 +
 tools/testing/nvdimm/test/nfit.c |  209 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 210 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/intel.h b/drivers/acpi/nfit/intel.h
index 868d073731cc..49a598623024 100644
--- a/drivers/acpi/nfit/intel.h
+++ b/drivers/acpi/nfit/intel.h
@@ -132,6 +132,9 @@ struct nd_intel_fw_activate_dimminfo {
 	u8 reserved[7];
 } __packed;
 
+#define ND_INTEL_DIMM_FWA_ARM 1
+#define ND_INTEL_DIMM_FWA_DISARM 0
+
 struct nd_intel_fw_activate_arm {
 	u8 activate_arm;
 	u32 status;
@@ -160,6 +163,8 @@ struct nd_intel_bus_fw_activate_businfo {
 #define ND_INTEL_BUS_FWA_STATUS_NOIDLE (6 | 5 << 16)
 #define ND_INTEL_BUS_FWA_STATUS_ABORT  (6 | 6 << 16)
 
+#define ND_INTEL_BUS_FWA_IODEV_FORCE_IDLE (0)
+#define ND_INTEL_BUS_FWA_IODEV_OS_IDLE (1)
 struct nd_intel_bus_fw_activate {
 	u8 iodev_state;
 	u32 status;
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 2b0bfbfc0abb..a1a5dc645b40 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -173,6 +173,9 @@ struct nfit_test_fw {
 	u64 version;
 	u32 size_received;
 	u64 end_time;
+	bool armed;
+	bool missed_activate;
+	unsigned long last_activate;
 };
 
 struct nfit_test {
@@ -345,7 +348,7 @@ static int nd_intel_test_finish_fw(struct nfit_test *t,
 			__func__, t, nd_cmd, buf_len, idx);
 
 	if (fw->state == FW_STATE_UPDATED) {
-		/* update already done, need cold boot */
+		/* update already done, need activation */
 		nd_cmd->status = 0x20007;
 		return 0;
 	}
@@ -430,6 +433,7 @@ static int nd_intel_test_finish_query(struct nfit_test *t,
 		}
 		dev_dbg(dev, "%s: transition out verify\n", __func__);
 		fw->state = FW_STATE_UPDATED;
+		fw->missed_activate = false;
 		/* fall through */
 	case FW_STATE_UPDATED:
 		nd_cmd->status = 0;
@@ -1178,6 +1182,134 @@ static int nd_intel_test_cmd_master_secure_erase(struct nfit_test *t,
 	return 0;
 }
 
+static unsigned long last_activate;
+
+static int nvdimm_bus_intel_fw_activate_businfo(struct nfit_test *t,
+		struct nd_intel_bus_fw_activate_businfo *nd_cmd,
+		unsigned int buf_len)
+{
+	int i, armed = 0;
+	int state;
+	u64 tmo;
+
+	for (i = 0; i < NUM_DCR; i++) {
+		struct nfit_test_fw *fw = &t->fw[i];
+
+		if (fw->armed)
+			armed++;
+	}
+
+	/*
+	 * Emulate 3 second activation max, and 1 second incremental
+	 * quiesce time per dimm requiring multiple activates to get all
+	 * DIMMs updated.
+	 */
+	if (armed)
+		state = ND_INTEL_FWA_ARMED;
+	else if (!last_activate || time_after(jiffies, last_activate + 3 * HZ))
+		state = ND_INTEL_FWA_IDLE;
+	else
+		state = ND_INTEL_FWA_BUSY;
+
+	tmo = armed * USEC_PER_SEC;
+	*nd_cmd = (struct nd_intel_bus_fw_activate_businfo) {
+		.capability = ND_INTEL_BUS_FWA_CAP_FWQUIESCE
+			| ND_INTEL_BUS_FWA_CAP_OSQUIESCE
+			| ND_INTEL_BUS_FWA_CAP_RESET,
+		.state = state,
+		.activate_tmo = tmo,
+		.cpu_quiesce_tmo = tmo,
+		.io_quiesce_tmo = tmo,
+		.max_quiesce_tmo = 3 * USEC_PER_SEC,
+	};
+
+	return 0;
+}
+
+static int nvdimm_bus_intel_fw_activate(struct nfit_test *t,
+		struct nd_intel_bus_fw_activate *nd_cmd,
+		unsigned int buf_len)
+{
+	struct nd_intel_bus_fw_activate_businfo info;
+	u32 status = 0;
+	int i;
+
+	nvdimm_bus_intel_fw_activate_businfo(t, &info, sizeof(info));
+	if (info.state == ND_INTEL_FWA_BUSY)
+		status = ND_INTEL_BUS_FWA_STATUS_BUSY;
+	else if (info.activate_tmo > info.max_quiesce_tmo)
+		status = ND_INTEL_BUS_FWA_STATUS_TMO;
+	else if (info.state == ND_INTEL_FWA_IDLE)
+		status = ND_INTEL_BUS_FWA_STATUS_NOARM;
+
+	dev_dbg(&t->pdev.dev, "status: %d\n", status);
+	nd_cmd->status = status;
+	if (status && status != ND_INTEL_BUS_FWA_STATUS_TMO)
+		return 0;
+
+	last_activate = jiffies;
+	for (i = 0; i < NUM_DCR; i++) {
+		struct nfit_test_fw *fw = &t->fw[i];
+
+		if (!fw->armed)
+			continue;
+		if (fw->state != FW_STATE_UPDATED)
+			fw->missed_activate = true;
+		else
+			fw->state = FW_STATE_NEW;
+		fw->armed = false;
+		fw->last_activate = last_activate;
+	}
+
+	return 0;
+}
+
+static int nd_intel_test_cmd_fw_activate_dimminfo(struct nfit_test *t,
+		struct nd_intel_fw_activate_dimminfo *nd_cmd,
+		unsigned int buf_len, int dimm)
+{
+	struct nd_intel_bus_fw_activate_businfo info;
+	struct nfit_test_fw *fw = &t->fw[dimm];
+	u32 result, state;
+
+	nvdimm_bus_intel_fw_activate_businfo(t, &info, sizeof(info));
+
+	if (info.state == ND_INTEL_FWA_BUSY)
+		state = ND_INTEL_FWA_BUSY;
+	else if (info.state == ND_INTEL_FWA_IDLE)
+		state = ND_INTEL_FWA_IDLE;
+	else if (fw->armed)
+		state = ND_INTEL_FWA_ARMED;
+	else
+		state = ND_INTEL_FWA_IDLE;
+
+	result = ND_INTEL_DIMM_FWA_NONE;
+	if (last_activate && fw->last_activate == last_activate &&
+			state == ND_INTEL_FWA_IDLE) {
+		if (fw->missed_activate)
+			result = ND_INTEL_DIMM_FWA_NOTSTAGED;
+		else
+			result = ND_INTEL_DIMM_FWA_SUCCESS;
+	}
+
+	*nd_cmd = (struct nd_intel_fw_activate_dimminfo) {
+		.result = result,
+		.state = state,
+	};
+
+	return 0;
+}
+
+static int nd_intel_test_cmd_fw_activate_arm(struct nfit_test *t,
+		struct nd_intel_fw_activate_arm *nd_cmd,
+		unsigned int buf_len, int dimm)
+{
+	struct nfit_test_fw *fw = &t->fw[dimm];
+
+	fw->armed = nd_cmd->activate_arm == ND_INTEL_DIMM_FWA_ARM;
+	nd_cmd->status = 0;
+	return 0;
+}
 
 static int get_dimm(struct nfit_mem *nfit_mem, unsigned int func)
 {
@@ -1296,6 +1428,14 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 				rc = nd_intel_test_cmd_master_secure_erase(t,
 						buf, buf_len, i);
 				break;
+			case NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO:
+				rc = nd_intel_test_cmd_fw_activate_dimminfo(
+					t, buf, buf_len, i);
+				break;
+			case NVDIMM_INTEL_FW_ACTIVATE_ARM:
+				rc = nd_intel_test_cmd_fw_activate_arm(
+					t, buf, buf_len, i);
+				break;
 			case ND_INTEL_ENABLE_LSS_STATUS:
 				rc = nd_intel_test_cmd_set_lss_status(t,
 						buf, buf_len);
@@ -1380,9 +1520,9 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		if (!nd_desc)
 			return -ENOTTY;
 
-		if (cmd == ND_CMD_CALL) {
+		if (cmd == ND_CMD_CALL && call_pkg->nd_family
+				== NVDIMM_BUS_FAMILY_NFIT) {
 			func = call_pkg->nd_command;
-
 			buf_len = call_pkg->nd_size_in + call_pkg->nd_size_out;
 			buf = (void *) call_pkg->nd_payload;
 
@@ -1406,7 +1546,26 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 			default:
 				return -ENOTTY;
 			}
-		}
+		} else if (cmd == ND_CMD_CALL && call_pkg->nd_family
+				== NVDIMM_BUS_FAMILY_INTEL) {
+			func = call_pkg->nd_command;
+			buf_len = call_pkg->nd_size_in + call_pkg->nd_size_out;
+			buf = (void *) call_pkg->nd_payload;
+
+			switch (func) {
+			case NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO:
+				rc = nvdimm_bus_intel_fw_activate_businfo(t,
+						buf, buf_len);
+				return rc;
+			case NVDIMM_BUS_INTEL_FW_ACTIVATE:
+				rc = nvdimm_bus_intel_fw_activate(t, buf,
+						buf_len);
+				return rc;
+			default:
+				return -ENOTTY;
+			}
+		} else if (cmd == ND_CMD_CALL)
+			return -ENOTTY;
 
 		if (!nd_desc || !test_bit(cmd, &nd_desc->cmd_mask))
 			return -ENOTTY;
@@ -1832,6 +1991,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	struct acpi_nfit_flush_address *flush;
 	struct acpi_nfit_capabilities *pcap;
 	unsigned int offset = 0, i;
+	unsigned long *acpi_mask;
 
 	/*
 	 * spa0 (interleave first half of dimm0 and dimm1, note storage
@@ -2558,6 +2718,12 @@ static void nfit_test0_setup(struct nfit_test *t)
 			&acpi_desc->dimm_cmd_force_en);
 	set_bit(NVDIMM_INTEL_MASTER_SECURE_ERASE,
 			&acpi_desc->dimm_cmd_force_en);
+	set_bit(NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO, &acpi_desc->dimm_cmd_force_en);
+	set_bit(NVDIMM_INTEL_FW_ACTIVATE_ARM, &acpi_desc->dimm_cmd_force_en);
+
+	acpi_mask = &acpi_desc->family_dsm_mask[NVDIMM_BUS_FAMILY_INTEL];
+	set_bit(NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO, acpi_mask);
+	set_bit(NVDIMM_BUS_INTEL_FW_ACTIVATE, acpi_mask);
 }
 
 static void nfit_test1_setup(struct nfit_test *t)
@@ -2733,6 +2899,7 @@ static int nfit_ctl_test(struct device *dev)
 			struct nd_cmd_clear_error clear_err;
 			struct nd_cmd_ars_status ars_stat;
 			struct nd_cmd_ars_cap ars_cap;
+			struct nd_intel_bus_fw_activate_businfo fwa_info;
 			char buf[sizeof(struct nd_cmd_ars_status)
 				+ sizeof(struct nd_ars_record)];
 		};
@@ -2761,11 +2928,15 @@ static int nfit_ctl_test(struct device *dev)
 			.module = THIS_MODULE,
 			.provider_name = "ACPI.NFIT",
 			.ndctl = acpi_nfit_ctl,
+			.bus_family_mask = 1UL << NVDIMM_BUS_FAMILY_NFIT
+				| 1UL << NVDIMM_BUS_FAMILY_INTEL,
 		},
 		.bus_dsm_mask = 1UL << NFIT_CMD_TRANSLATE_SPA
 			| 1UL << NFIT_CMD_ARS_INJECT_SET
 			| 1UL << NFIT_CMD_ARS_INJECT_CLEAR
 			| 1UL << NFIT_CMD_ARS_INJECT_GET,
+		.family_dsm_mask[NVDIMM_BUS_FAMILY_INTEL] =
+			NVDIMM_BUS_INTEL_FW_ACTIVATE_CMDMASK,
 		.dev = &adev->dev,
 	};
 
@@ -2932,6 +3103,36 @@ static int nfit_ctl_test(struct device *dev)
 		return -EIO;
 	}
 
+	/* test firmware activate bus info */
+	cmd_size = sizeof(cmd.fwa_info);
+	cmd = (struct nfit_ctl_test_cmd) {
+		.pkg = {
+			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO,
+			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
+			.nd_size_out = cmd_size,
+			.nd_fw_size = cmd_size,
+		},
+		.fwa_info = {
+			.state = ND_INTEL_FWA_IDLE,
+			.capability = ND_INTEL_BUS_FWA_CAP_FWQUIESCE
+				| ND_INTEL_BUS_FWA_CAP_OSQUIESCE,
+			.activate_tmo = 1,
+			.cpu_quiesce_tmo = 1,
+			.io_quiesce_tmo = 1,
+			.max_quiesce_tmo = 1,
+		},
+	};
+	rc = setup_result(cmd.buf, cmd_size);
+	if (rc)
+		return rc;
+	rc = acpi_nfit_ctl(&acpi_desc->nd_desc, NULL, ND_CMD_CALL,
+			&cmd, sizeof(cmd.pkg) + cmd_size, &cmd_rc);
+	if (rc < 0 || cmd_rc) {
+		dev_dbg(dev, "%s: failed at: %d rc: %d cmd_rc: %d\n",
+				__func__, __LINE__, rc, cmd_rc);
+		return -EIO;
+	}
+
 	return 0;
 }
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

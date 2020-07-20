Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A4B227239
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 00:24:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 287C2124059AF;
	Mon, 20 Jul 2020 15:24:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AD4A2124059A7
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 15:24:14 -0700 (PDT)
IronPort-SDR: kC52mebUZ0L8n1OvSZEISopx8zFXCHufcOmCZfbi3mlJL2PSA6dzXTt4Cv1gV2p3KccX28WYX0
 unP0TTCNxpJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="168162212"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="168162212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:14 -0700
IronPort-SDR: Y4ofc0FJTz0oosuhfroqelil7bCmTH2XHqM3L3c+FEkacDuV0va2PSklhyMltWdoL8ccDP2tv7
 NxTBnC7xf8fQ==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="318148930"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:13 -0700
Subject: [PATCH v3 06/11] tools/testing/nvdimm: Prepare nfit_ctl_test() for
 ND_CMD_CALL emulation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 20 Jul 2020 15:07:57 -0700
Message-ID: <159528287703.993790.423533202598012793.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: KBCD6YMLUDF3K5CHLOYWSCNN2PESIMYO
X-Message-ID-Hash: KBCD6YMLUDF3K5CHLOYWSCNN2PESIMYO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KBCD6YMLUDF3K5CHLOYWSCNN2PESIMYO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for adding a mocked implementation of the
firmware-activate bus-info command, rework nfit_ctl_test() to operate on
a local command payload wrapped in a 'struct nd_cmd_pkg'.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   83 ++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 9c6f475befe4..2b0bfbfc0abb 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -2726,14 +2726,17 @@ static int nfit_ctl_test(struct device *dev)
 	struct acpi_nfit_desc *acpi_desc;
 	const u64 test_val = 0x0123456789abcdefULL;
 	unsigned long mask, cmd_size, offset;
-	union {
-		struct nd_cmd_get_config_size cfg_size;
-		struct nd_cmd_clear_error clear_err;
-		struct nd_cmd_ars_status ars_stat;
-		struct nd_cmd_ars_cap ars_cap;
-		char buf[sizeof(struct nd_cmd_ars_status)
-			+ sizeof(struct nd_ars_record)];
-	} cmds;
+	struct nfit_ctl_test_cmd {
+		struct nd_cmd_pkg pkg;
+		union {
+			struct nd_cmd_get_config_size cfg_size;
+			struct nd_cmd_clear_error clear_err;
+			struct nd_cmd_ars_status ars_stat;
+			struct nd_cmd_ars_cap ars_cap;
+			char buf[sizeof(struct nd_cmd_ars_status)
+				+ sizeof(struct nd_ars_record)];
+		};
+	} cmd;
 
 	adev = devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
 	if (!adev)
@@ -2793,21 +2796,21 @@ static int nfit_ctl_test(struct device *dev)
 
 
 	/* basic checkout of a typical 'get config size' command */
-	cmd_size = sizeof(cmds.cfg_size);
-	cmds.cfg_size = (struct nd_cmd_get_config_size) {
+	cmd_size = sizeof(cmd.cfg_size);
+	cmd.cfg_size = (struct nd_cmd_get_config_size) {
 		.status = 0,
 		.config_size = SZ_128K,
 		.max_xfer = SZ_4K,
 	};
-	rc = setup_result(cmds.buf, cmd_size);
+	rc = setup_result(cmd.buf, cmd_size);
 	if (rc)
 		return rc;
 	rc = acpi_nfit_ctl(&acpi_desc->nd_desc, nvdimm, ND_CMD_GET_CONFIG_SIZE,
-			cmds.buf, cmd_size, &cmd_rc);
+			cmd.buf, cmd_size, &cmd_rc);
 
-	if (rc < 0 || cmd_rc || cmds.cfg_size.status != 0
-			|| cmds.cfg_size.config_size != SZ_128K
-			|| cmds.cfg_size.max_xfer != SZ_4K) {
+	if (rc < 0 || cmd_rc || cmd.cfg_size.status != 0
+			|| cmd.cfg_size.config_size != SZ_128K
+			|| cmd.cfg_size.max_xfer != SZ_4K) {
 		dev_dbg(dev, "%s: failed at: %d rc: %d cmd_rc: %d\n",
 				__func__, __LINE__, rc, cmd_rc);
 		return -EIO;
@@ -2816,14 +2819,14 @@ static int nfit_ctl_test(struct device *dev)
 
 	/* test ars_status with zero output */
 	cmd_size = offsetof(struct nd_cmd_ars_status, address);
-	cmds.ars_stat = (struct nd_cmd_ars_status) {
+	cmd.ars_stat = (struct nd_cmd_ars_status) {
 		.out_length = 0,
 	};
-	rc = setup_result(cmds.buf, cmd_size);
+	rc = setup_result(cmd.buf, cmd_size);
 	if (rc)
 		return rc;
 	rc = acpi_nfit_ctl(&acpi_desc->nd_desc, NULL, ND_CMD_ARS_STATUS,
-			cmds.buf, cmd_size, &cmd_rc);
+			cmd.buf, cmd_size, &cmd_rc);
 
 	if (rc < 0 || cmd_rc) {
 		dev_dbg(dev, "%s: failed at: %d rc: %d cmd_rc: %d\n",
@@ -2833,16 +2836,16 @@ static int nfit_ctl_test(struct device *dev)
 
 
 	/* test ars_cap with benign extended status */
-	cmd_size = sizeof(cmds.ars_cap);
-	cmds.ars_cap = (struct nd_cmd_ars_cap) {
+	cmd_size = sizeof(cmd.ars_cap);
+	cmd.ars_cap = (struct nd_cmd_ars_cap) {
 		.status = ND_ARS_PERSISTENT << 16,
 	};
 	offset = offsetof(struct nd_cmd_ars_cap, status);
-	rc = setup_result(cmds.buf + offset, cmd_size - offset);
+	rc = setup_result(cmd.buf + offset, cmd_size - offset);
 	if (rc)
 		return rc;
 	rc = acpi_nfit_ctl(&acpi_desc->nd_desc, NULL, ND_CMD_ARS_CAP,
-			cmds.buf, cmd_size, &cmd_rc);
+			cmd.buf, cmd_size, &cmd_rc);
 
 	if (rc < 0 || cmd_rc) {
 		dev_dbg(dev, "%s: failed at: %d rc: %d cmd_rc: %d\n",
@@ -2852,19 +2855,19 @@ static int nfit_ctl_test(struct device *dev)
 
 
 	/* test ars_status with 'status' trimmed from 'out_length' */
-	cmd_size = sizeof(cmds.ars_stat) + sizeof(struct nd_ars_record);
-	cmds.ars_stat = (struct nd_cmd_ars_status) {
+	cmd_size = sizeof(cmd.ars_stat) + sizeof(struct nd_ars_record);
+	cmd.ars_stat = (struct nd_cmd_ars_status) {
 		.out_length = cmd_size - 4,
 	};
-	record = &cmds.ars_stat.records[0];
+	record = &cmd.ars_stat.records[0];
 	*record = (struct nd_ars_record) {
 		.length = test_val,
 	};
-	rc = setup_result(cmds.buf, cmd_size);
+	rc = setup_result(cmd.buf, cmd_size);
 	if (rc)
 		return rc;
 	rc = acpi_nfit_ctl(&acpi_desc->nd_desc, NULL, ND_CMD_ARS_STATUS,
-			cmds.buf, cmd_size, &cmd_rc);
+			cmd.buf, cmd_size, &cmd_rc);
 
 	if (rc < 0 || cmd_rc || record->length != test_val) {
 		dev_dbg(dev, "%s: failed at: %d rc: %d cmd_rc: %d\n",
@@ -2874,19 +2877,19 @@ static int nfit_ctl_test(struct device *dev)
 
 
 	/* test ars_status with 'Output (Size)' including 'status' */
-	cmd_size = sizeof(cmds.ars_stat) + sizeof(struct nd_ars_record);
-	cmds.ars_stat = (struct nd_cmd_ars_status) {
+	cmd_size = sizeof(cmd.ars_stat) + sizeof(struct nd_ars_record);
+	cmd.ars_stat = (struct nd_cmd_ars_status) {
 		.out_length = cmd_size,
 	};
-	record = &cmds.ars_stat.records[0];
+	record = &cmd.ars_stat.records[0];
 	*record = (struct nd_ars_record) {
 		.length = test_val,
 	};
-	rc = setup_result(cmds.buf, cmd_size);
+	rc = setup_result(cmd.buf, cmd_size);
 	if (rc)
 		return rc;
 	rc = acpi_nfit_ctl(&acpi_desc->nd_desc, NULL, ND_CMD_ARS_STATUS,
-			cmds.buf, cmd_size, &cmd_rc);
+			cmd.buf, cmd_size, &cmd_rc);
 
 	if (rc < 0 || cmd_rc || record->length != test_val) {
 		dev_dbg(dev, "%s: failed at: %d rc: %d cmd_rc: %d\n",
@@ -2896,15 +2899,15 @@ static int nfit_ctl_test(struct device *dev)
 
 
 	/* test extended status for get_config_size results in failure */
-	cmd_size = sizeof(cmds.cfg_size);
-	cmds.cfg_size = (struct nd_cmd_get_config_size) {
+	cmd_size = sizeof(cmd.cfg_size);
+	cmd.cfg_size = (struct nd_cmd_get_config_size) {
 		.status = 1 << 16,
 	};
-	rc = setup_result(cmds.buf, cmd_size);
+	rc = setup_result(cmd.buf, cmd_size);
 	if (rc)
 		return rc;
 	rc = acpi_nfit_ctl(&acpi_desc->nd_desc, nvdimm, ND_CMD_GET_CONFIG_SIZE,
-			cmds.buf, cmd_size, &cmd_rc);
+			cmd.buf, cmd_size, &cmd_rc);
 
 	if (rc < 0 || cmd_rc >= 0) {
 		dev_dbg(dev, "%s: failed at: %d rc: %d cmd_rc: %d\n",
@@ -2913,16 +2916,16 @@ static int nfit_ctl_test(struct device *dev)
 	}
 
 	/* test clear error */
-	cmd_size = sizeof(cmds.clear_err);
-	cmds.clear_err = (struct nd_cmd_clear_error) {
+	cmd_size = sizeof(cmd.clear_err);
+	cmd.clear_err = (struct nd_cmd_clear_error) {
 		.length = 512,
 		.cleared = 512,
 	};
-	rc = setup_result(cmds.buf, cmd_size);
+	rc = setup_result(cmd.buf, cmd_size);
 	if (rc)
 		return rc;
 	rc = acpi_nfit_ctl(&acpi_desc->nd_desc, NULL, ND_CMD_CLEAR_ERROR,
-			cmds.buf, cmd_size, &cmd_rc);
+			cmd.buf, cmd_size, &cmd_rc);
 	if (rc < 0 || cmd_rc) {
 		dev_dbg(dev, "%s: failed at: %d rc: %d cmd_rc: %d\n",
 				__func__, __LINE__, rc, cmd_rc);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

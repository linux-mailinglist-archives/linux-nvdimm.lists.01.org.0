Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CA2216435
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:57:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EE5D31108DEAC;
	Mon,  6 Jul 2020 19:57:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0621D1106818F
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:57:01 -0700 (PDT)
IronPort-SDR: Y1qvjMbNxB4ALmRpF7bi0m4iT3uMepcD6owJEAJA4oRaFnugtgPJvGssEUJ7qt5gIgaSN4W6w1
 7RwkjFqXx75g==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="209052898"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="209052898"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:00 -0700
IronPort-SDR: LdvotwAnNNcNLcK61yx9DGwbeefYgPneEPCZhmDAcpws+c3jJftou+cM8whO/GhxA8W3qzK5ZK
 nvyOze1w7GAg==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="266701220"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:00 -0700
Subject: [ndctl PATCH 05/16] ndctl/dimm: Improve firmware-update failure
 message
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Dave Jiang <dave.jiang@intel.com>, vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:40:44 -0700
Message-ID: <159408964481.2386154.1228959454121163340.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: VTRYRRWYBI57RQH5I6HUNIQNAYME7CXH
X-Message-ID-Hash: VTRYRRWYBI57RQH5I6HUNIQNAYME7CXH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VTRYRRWYBI57RQH5I6HUNIQNAYME7CXH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If ARS is active while firmware update is attempted the DIMM may fail the
update. In ndctl reports:

   FINISH FIRMWARE UPDATE on DIMM nmem0 failed: 0x5

...which is not very helpful. Improve this and other error messages to
indicate the likely error where possible and make sure error messages are
consistently emitting the affected dimm.

Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/dimm.c |  108 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 55 insertions(+), 53 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index f67f78e6c420..5ecee033cd63 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -460,6 +460,7 @@ static int verify_fw_size(struct update_context *uctx)
 static int submit_get_firmware_info(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
+	const char *devname = ndctl_dimm_get_devname(dimm);
 	struct update_context *uctx = &actx->update;
 	struct fw_info *fw = &uctx->dimm_fw;
 	struct ndctl_cmd *cmd;
@@ -477,8 +478,7 @@ static int submit_get_firmware_info(struct ndctl_dimm *dimm,
 	rc = -ENXIO;
 	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
 	if (status != FW_SUCCESS) {
-		fprintf(stderr, "GET FIRMWARE INFO on DIMM %s failed: %#x\n",
-				ndctl_dimm_get_devname(dimm), status);
+		err("%s: failed to retrieve firmware info", devname);
 		goto out;
 	}
 
@@ -512,6 +512,7 @@ out:
 static int submit_start_firmware_upload(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
+	const char *devname = ndctl_dimm_get_devname(dimm);
 	struct update_context *uctx = &actx->update;
 	struct fw_info *fw = &uctx->dimm_fw;
 	struct ndctl_cmd *cmd;
@@ -527,21 +528,18 @@ static int submit_start_firmware_upload(struct ndctl_dimm *dimm,
 		return rc;
 
 	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
+	if (status == FW_EBUSY) {
+		err("%s: busy with another firmware update", devname);
+		return -EBUSY;
+	}
 	if (status != FW_SUCCESS) {
-		fprintf(stderr,
-			"START FIRMWARE UPDATE on DIMM %s failed: %#x\n",
-			ndctl_dimm_get_devname(dimm), status);
-		if (status == FW_EBUSY)
-			fprintf(stderr, "Another firmware upload in progress"
-					" or firmware already updated.\n");
+		err("%s: failed to create start context", devname);
 		return -ENXIO;
 	}
 
 	fw->context = ndctl_cmd_fw_start_get_context(cmd);
 	if (fw->context == UINT_MAX) {
-		fprintf(stderr,
-			"Retrieved firmware context invalid on DIMM %s\n",
-			ndctl_dimm_get_devname(dimm));
+		err("%s: failed to retrieve start context", devname);
 		return -ENXIO;
 	}
 
@@ -567,16 +565,16 @@ static int get_fw_data_from_file(FILE *file, void *buf, uint32_t len)
 	return len;
 }
 
-static int send_firmware(struct ndctl_dimm *dimm,
-		struct action_context *actx)
+static int send_firmware(struct ndctl_dimm *dimm, struct action_context *actx)
 {
+	const char *devname = ndctl_dimm_get_devname(dimm);
 	struct update_context *uctx = &actx->update;
 	struct fw_info *fw = &uctx->dimm_fw;
+	uint32_t copied = 0, len, remain;
 	struct ndctl_cmd *cmd = NULL;
-	ssize_t read;
-	int rc = -ENXIO;
 	enum ND_FW_STATUS status;
-	uint32_t copied = 0, len, remain;
+	int rc = -ENXIO;
+	ssize_t read;
 	void *buf;
 
 	buf = malloc(fw->update_size);
@@ -596,18 +594,22 @@ static int send_firmware(struct ndctl_dimm *dimm,
 		cmd = ndctl_dimm_cmd_new_fw_send(uctx->start, copied, read,
 				buf);
 		if (!cmd) {
-			rc = -ENXIO;
+			rc = -ENOMEM;
 			goto cleanup;
 		}
 
 		rc = ndctl_cmd_submit(cmd);
-		if (rc < 0)
+		if (rc < 0) {
+			err("%s: failed to issue firmware transmit: %d",
+					devname, rc);
 			goto cleanup;
+		}
 
 		status = ndctl_cmd_fw_xlat_firmware_status(cmd);
 		if (status != FW_SUCCESS) {
-			error("SEND FIRMWARE failed: %#x\n", status);
-			rc = -ENXIO;
+			err("%s: failed to transmit firmware: %d",
+					devname, status);
+			rc = -EIO;
 			goto cleanup;
 		}
 
@@ -627,10 +629,11 @@ cleanup:
 static int submit_finish_firmware(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
+	const char *devname = ndctl_dimm_get_devname(dimm);
 	struct update_context *uctx = &actx->update;
-	struct ndctl_cmd *cmd;
-	int rc;
 	enum ND_FW_STATUS status;
+	struct ndctl_cmd *cmd;
+	int rc = -ENXIO;
 
 	cmd = ndctl_dimm_cmd_new_fw_finish(uctx->start);
 	if (!cmd)
@@ -641,12 +644,19 @@ static int submit_finish_firmware(struct ndctl_dimm *dimm,
 		goto out;
 
 	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
-	if (status != FW_SUCCESS) {
-		fprintf(stderr,
-			"FINISH FIRMWARE UPDATE on DIMM %s failed: %#x\n",
-			ndctl_dimm_get_devname(dimm), status);
-		rc = -ENXIO;
-		goto out;
+	switch (status) {
+	case FW_SUCCESS:
+		rc = 0;
+		break;
+	case FW_ERETRY:
+		err("%s: device busy with other operation (ARS?)", devname);
+		break;
+	case FW_EBADFW:
+		err("%s: firmware image rejected", devname);
+		break;
+	default:
+		err("%s: update failed: error code: %d", devname, status);
+		break;
 	}
 
 out:
@@ -687,13 +697,14 @@ out:
 static int query_fw_finish_status(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
+	const char *devname = ndctl_dimm_get_devname(dimm);
 	struct update_context *uctx = &actx->update;
 	struct fw_info *fw = &uctx->dimm_fw;
-	struct ndctl_cmd *cmd;
-	int rc;
-	enum ND_FW_STATUS status;
 	struct timespec now, before, after;
+	enum ND_FW_STATUS status;
+	struct ndctl_cmd *cmd;
 	uint64_t ver;
+	int rc;
 
 	cmd = ndctl_dimm_cmd_new_fw_finish_query(uctx->start);
 	if (!cmd)
@@ -747,8 +758,8 @@ again:
 	case FW_SUCCESS:
 		ver = ndctl_cmd_fw_fquery_get_fw_rev(cmd);
 		if (ver == 0) {
-			fprintf(stderr, "No firmware updated.\n");
-			rc = -ENXIO;
+			err("%s: new firmware not found after update", devname);
+			rc = -EIO;
 			goto unref;
 		}
 
@@ -759,25 +770,16 @@ again:
 		rc = 0;
 		break;
 	case FW_EBADFW:
-		fprintf(stderr,
-			"Firmware failed to verify by DIMM %s.\n",
-			ndctl_dimm_get_devname(dimm));
-		/* FALLTHROUGH */
-	case FW_EINVAL_CTX:
-	case FW_ESEQUENCE:
-		rc = -ENXIO;
+		err("%s: firmware verification failure", devname);
+		rc = -EINVAL;
 		break;
 	case FW_ENORES:
-		fprintf(stderr,
-			"Firmware update sequence timed out: %s\n",
-			ndctl_dimm_get_devname(dimm));
+		err("%s: timeout awaiting update", devname);
 		rc = -ETIMEDOUT;
 		break;
 	default:
-		fprintf(stderr,
-			"Unknown update status: %#x on DIMM %s\n",
-			status, ndctl_dimm_get_devname(dimm));
-		rc = -EINVAL;
+		err("%s: unhandled error %d", devname, status);
+		rc = -EIO;
 		break;
 	}
 
@@ -789,6 +791,7 @@ unref:
 static int update_firmware(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
+	const char *devname = ndctl_dimm_get_devname(dimm);
 	int rc;
 
 	rc = submit_get_firmware_info(dimm, actx);
@@ -800,15 +803,14 @@ static int update_firmware(struct ndctl_dimm *dimm,
 		return rc;
 
 	if (param.verbose)
-		fprintf(stderr, "Uploading firmware to DIMM %s.\n",
-				ndctl_dimm_get_devname(dimm));
+		fprintf(stderr, "%s: uploading firmware\n", devname);
 
 	rc = send_firmware(dimm, actx);
 	if (rc < 0) {
-		error("Firmware send failed. Aborting!\n");
+		err("%s: firmware send failed", devname);
 		rc = submit_abort_firmware(dimm, actx);
 		if (rc < 0)
-			error("Aborting update sequence failed.\n");
+			err("%s: abort failed", devname);
 		return rc;
 	}
 
@@ -820,10 +822,10 @@ static int update_firmware(struct ndctl_dimm *dimm,
 
 	rc = submit_finish_firmware(dimm, actx);
 	if (rc < 0) {
-		fprintf(stderr, "Unable to end update sequence.\n");
+		err("%s: failed to finish update sequence", devname);
 		rc = submit_abort_firmware(dimm, actx);
 		if (rc < 0)
-			fprintf(stderr, "Aborting update sequence failed.\n");
+			err("%s: failed to abort update", devname);
 		return rc;
 	}
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

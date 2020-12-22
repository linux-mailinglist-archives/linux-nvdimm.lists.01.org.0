Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2662E03AC
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Dec 2020 02:12:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 19F3C100EBBCB;
	Mon, 21 Dec 2020 17:11:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8C216100EBBC7
	for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 17:11:55 -0800 (PST)
IronPort-SDR: PkLd4PkDBRc3+2/yHNEb3xhv6AyliKHF3n42y1nQ14QO18DFe6ApUhOr3X6Hth3CvirNx1gLEF
 sKgFh+2jrTUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="172294824"
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400";
   d="scan'208";a="172294824"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 17:11:54 -0800
IronPort-SDR: /MrlZxna5gNHtNK5j3wb3+ekK0phHebZOjoFgVgtseMnE/N0BG3evDBSZMKw2CNTBt6U4ZgxIl
 eZuJOmSRcE0w==
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400";
   d="scan'208";a="372981768"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 17:11:54 -0800
Subject: [ndctl PATCH] ndctl/dimm: Attempt an abort upon
 firmware-update-busy status
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Mon, 21 Dec 2020 17:11:54 -0800
Message-ID: <160859948599.1811202.6750689494442813307.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: SAAG7FWFUOUVPTJZE2LLKPAI2GM2BRZP
X-Message-ID-Hash: SAAG7FWFUOUVPTJZE2LLKPAI2GM2BRZP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mark Baker <mark.a.baker@oracle.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SAAG7FWFUOUVPTJZE2LLKPAI2GM2BRZP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Mark reports that if a previous firmware update is blocked due to a
background ARS then ndctl fails to start another firmware-udpate
request until the platform is rebooted.

Teach 'ndctl update-firmware' to abort previous firmware-update sessions
when '--force' is specified.

Link: https://github.com/pmem/ndctl/issues/155
Link: http://lore.kernel.org/r/20201222005704.2355076-1-jane.chu@oracle.com
Reported-by: Mark Baker <mark.a.baker@oracle.com>
Tested-by: Mark Baker <mark.a.baker@oracle.com>
Tested-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

Needs the fix from Jane mentioned in the link above, but with that
included Jane and Mark report this works.

 ndctl/dimm.c |  109 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 8e85d692afd3..167c3f1bc7c7 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -504,6 +504,36 @@ out:
 	return rc;
 }
 
+static int submit_abort_firmware(struct ndctl_dimm *dimm,
+		struct action_context *actx)
+{
+	struct update_context *uctx = &actx->update;
+	struct ndctl_cmd *cmd;
+	int rc;
+	enum ND_FW_STATUS status;
+
+	cmd = ndctl_dimm_cmd_new_fw_abort(uctx->start);
+	if (!cmd)
+		return -ENXIO;
+
+	rc = ndctl_cmd_submit(cmd);
+	if (rc < 0)
+		goto out;
+
+	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
+	if (!(status & ND_CMD_STATUS_FIN_ABORTED)) {
+		fprintf(stderr,
+			"Firmware update abort on DIMM %s failed: %#x\n",
+			ndctl_dimm_get_devname(dimm), status);
+		rc = -ENXIO;
+		goto out;
+	}
+
+out:
+	ndctl_cmd_unref(cmd);
+	return rc;
+}
+
 static int submit_start_firmware_upload(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
@@ -511,8 +541,8 @@ static int submit_start_firmware_upload(struct ndctl_dimm *dimm,
 	struct update_context *uctx = &actx->update;
 	struct fw_info *fw = &uctx->dimm_fw;
 	struct ndctl_cmd *cmd;
-	int rc;
 	enum ND_FW_STATUS status;
+	int rc;
 
 	cmd = ndctl_dimm_cmd_new_fw_start_update(dimm);
 	if (!cmd)
@@ -520,27 +550,46 @@ static int submit_start_firmware_upload(struct ndctl_dimm *dimm,
 
 	rc = ndctl_cmd_submit(cmd);
 	if (rc < 0)
-		return rc;
+		goto err;
 
+	uctx->start = cmd;
 	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
 	if (status == FW_EBUSY) {
-		err("%s: busy with another firmware update", devname);
-		return -EBUSY;
+		if (param.force) {
+			rc = submit_abort_firmware(dimm, actx);
+			if (rc < 0) {
+				err("%s: busy with another firmware update, "
+				    "abort failed", devname);
+				rc = -EBUSY;
+				goto err;
+			}
+			rc = -EAGAIN;
+			goto err;
+		} else {
+			err("%s: busy with another firmware update", devname);
+			rc = -EBUSY;
+			goto err;
+		}
 	}
 	if (status != FW_SUCCESS) {
 		err("%s: failed to create start context", devname);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto err;
 	}
 
 	fw->context = ndctl_cmd_fw_start_get_context(cmd);
 	if (fw->context == UINT_MAX) {
 		err("%s: failed to retrieve start context", devname);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto err;
 	}
 
-	uctx->start = cmd;
-
 	return 0;
+
+err:
+	uctx->start = NULL;
+	ndctl_cmd_unref(cmd);
+	return rc;
 }
 
 static int get_fw_data_from_file(FILE *file, void *buf, uint32_t len)
@@ -659,36 +708,6 @@ out:
 	return rc;
 }
 
-static int submit_abort_firmware(struct ndctl_dimm *dimm,
-		struct action_context *actx)
-{
-	struct update_context *uctx = &actx->update;
-	struct ndctl_cmd *cmd;
-	int rc;
-	enum ND_FW_STATUS status;
-
-	cmd = ndctl_dimm_cmd_new_fw_abort(uctx->start);
-	if (!cmd)
-		return -ENXIO;
-
-	rc = ndctl_cmd_submit(cmd);
-	if (rc < 0)
-		goto out;
-
-	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
-	if (!(status & ND_CMD_STATUS_FIN_ABORTED)) {
-		fprintf(stderr,
-			"Firmware update abort on DIMM %s failed: %#x\n",
-			ndctl_dimm_get_devname(dimm), status);
-		rc = -ENXIO;
-		goto out;
-	}
-
-out:
-	ndctl_cmd_unref(cmd);
-	return rc;
-}
-
 static enum ndctl_fwa_state fw_update_arm(struct ndctl_dimm *dimm)
 {
 	struct ndctl_bus *bus = ndctl_dimm_get_bus(dimm);
@@ -856,15 +875,21 @@ static int update_firmware(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
 	const char *devname = ndctl_dimm_get_devname(dimm);
-	int rc;
+	int rc, i;
 
 	rc = submit_get_firmware_info(dimm, actx);
 	if (rc < 0)
 		return rc;
 
-	rc = submit_start_firmware_upload(dimm, actx);
-	if (rc < 0)
-		return rc;
+	/* try a few times in the --force and state busy case */
+	for (i = 0; i < 3; i++) {
+		rc = submit_start_firmware_upload(dimm, actx);
+		if (rc == -EAGAIN)
+			continue;
+		if (rc < 0)
+			return rc;
+		break;
+	}
 
 	if (param.verbose)
 		fprintf(stderr, "%s: uploading firmware\n", devname);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

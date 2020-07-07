Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA18216437
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:57:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A88F1108DED0;
	Mon,  6 Jul 2020 19:57:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6D8A91108DEB3
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:57:11 -0700 (PDT)
IronPort-SDR: GWnzDKVOP5ZJUiGJYQigVRhUlCuf5I8TTK1FIk3TXcunm9/jMOXnHxlLjX1aYCroIeI/Oflfhw
 dh2LMz8kxkzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="135776513"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="135776513"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:11 -0700
IronPort-SDR: zOkuDcPP9XbSBZI8CKFaiZOYkPQATc8WG0ohoEWLSSgcxGZxUBH631ZgaXtcxgtthQ/WpCSAx2
 QZk5pCLfCQuA==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="314142774"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:11 -0700
Subject: [ndctl PATCH 07/16] ndctl/dimm: Emit dimm firmware details after
 update
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:40:55 -0700
Message-ID: <159408965572.2386154.3054569261046251497.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 2I57ZGCPTV7PJ4JCM66DOA7AD7ELL6EW
X-Message-ID-Hash: 2I57ZGCPTV7PJ4JCM66DOA7AD7ELL6EW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2I57ZGCPTV7PJ4JCM66DOA7AD7ELL6EW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replace the status messages at the end of 'ndctl update-firmware' with a
json representation of the dimm-firmware state.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/dimm.c            |   23 ++++++++++++++++-------
 ndctl/firmware-update.h |    1 +
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 5ecee033cd63..e02f5dfdb889 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -701,8 +701,10 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 	struct update_context *uctx = &actx->update;
 	struct fw_info *fw = &uctx->dimm_fw;
 	struct timespec now, before, after;
+	struct json_object *jobj;
 	enum ND_FW_STATUS status;
 	struct ndctl_cmd *cmd;
+	unsigned long flags;
 	uint64_t ver;
 	int rc;
 
@@ -763,10 +765,12 @@ again:
 			goto unref;
 		}
 
-		fprintf(stderr, "Image updated successfully to DIMM %s.\n",
-			ndctl_dimm_get_devname(dimm));
-		fprintf(stderr, "Firmware version %#lx.\n", ver);
-		fprintf(stderr, "Cold reboot to activate.\n");
+		flags = UTIL_JSON_FIRMWARE;
+		if (isatty(1))
+			flags |= UTIL_JSON_HUMAN;
+		jobj = util_dimm_to_json(dimm, flags);
+		if (jobj)
+			json_object_array_add(actx->jdimms, jobj);
 		rc = 0;
 		break;
 	case FW_EBADFW:
@@ -1202,7 +1206,7 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 		return -EINVAL;
 	}
 
-	json = param.json || param.human;
+	json = param.json || param.human || action == action_update;
 	if (action == action_read && json && (param.len || param.offset)) {
 		fprintf(stderr, "--size and --offset are incompatible with --json\n");
 		usage_with_options(u, options);
@@ -1308,8 +1312,13 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 			rc = action(single, &actx);
 	}
 
-	if (actx.jdimms)
-		util_display_json_array(actx.f_out, actx.jdimms, 0);
+	if (actx.jdimms && json_object_array_length(actx.jdimms) > 0) {
+		unsigned long flags = 0;
+
+		if (actx.f_out == stdout && isatty(1))
+			flags |= UTIL_JSON_HUMAN;
+		util_display_json_array(actx.f_out, actx.jdimms, flags);
+	}
 
 	if (actx.f_out != stdout)
 		fclose(actx.f_out);
diff --git a/ndctl/firmware-update.h b/ndctl/firmware-update.h
index a7576889f739..a4386d6089d2 100644
--- a/ndctl/firmware-update.h
+++ b/ndctl/firmware-update.h
@@ -40,6 +40,7 @@ struct update_context {
 	size_t fw_size;
 	struct fw_info dimm_fw;
 	struct ndctl_cmd *start;
+	struct json_object *jdimms;
 };
 
 #endif
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

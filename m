Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE66E7B55
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Oct 2019 22:27:30 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B173E100EA63B;
	Mon, 28 Oct 2019 14:28:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4952100EA63A
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 14:28:13 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 14:27:24 -0700
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400";
   d="scan'208";a="193392583"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 14:27:24 -0700
From: ira.weiny@intel.com
To: "Verma, Vishal L" <vishal.l.verma@intel.com>,
	Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH] ndctl: Clean up loop logic in query_fw_finish_status
Date: Mon, 28 Oct 2019 14:27:22 -0700
Message-Id: <20191028212722.10388-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Message-ID-Hash: PDFPRRHLPSCBLROQQYLIIYAJMOQ36UNT
X-Message-ID-Hash: PDFPRRHLPSCBLROQQYLIIYAJMOQ36UNT
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PDFPRRHLPSCBLROQQYLIIYAJMOQ36UNT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

This gets rid of a redundant variable as originally pointed out by Jeff
Moyer[1]

Also, while we are here change the printf's to fprintf(stderr, ...)

[1] https://patchwork.kernel.org/patch/11199557/

To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Suggested-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 ndctl/dimm.c | 138 ++++++++++++++++++++++++++-------------------------
 1 file changed, 70 insertions(+), 68 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index b1b84c253cdc..14cafc0c4b8f 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -691,85 +691,87 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
 
 	rc = clock_gettime(CLOCK_MONOTONIC, &before);
 	if (rc < 0)
-		goto out;
+		goto unref;
 
 	now.tv_nsec = fw->query_interval / 1000;
 	now.tv_sec = 0;
 
-	do {
-		rc = ndctl_cmd_submit(cmd);
-		if (rc < 0)
-			break;
+again:
+	rc = ndctl_cmd_submit(cmd);
+	if (rc < 0)
+		goto unref;
 
-		status = ndctl_cmd_fw_xlat_firmware_status(cmd);
-		switch (status) {
-		case FW_SUCCESS:
-			ver = ndctl_cmd_fw_fquery_get_fw_rev(cmd);
-			if (ver == 0) {
-				fprintf(stderr, "No firmware updated.\n");
-				rc = -ENXIO;
-				goto out;
-			}
+	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
+	if (status == FW_EBUSY) {
+		/* Still on going, continue */
+		rc = clock_gettime(CLOCK_MONOTONIC, &after);
+		if (rc < 0) {
+			rc = -errno;
+			goto unref;
+		}
 
-			printf("Image updated successfully to DIMM %s.\n",
-					ndctl_dimm_get_devname(dimm));
-			printf("Firmware version %#lx.\n", ver);
-			printf("Cold reboot to activate.\n");
-			rc = 0;
-			goto out;
-			break;
-		case FW_EBUSY:
-			/* Still on going, continue */
-			rc = clock_gettime(CLOCK_MONOTONIC, &after);
-			if (rc < 0) {
-				rc = -errno;
-				goto out;
-			}
+		/*
+		 * If we expire max query time,
+		 * we timed out
+		 */
+		if (after.tv_sec - before.tv_sec >
+				fw->max_query / 1000000) {
+			rc = -ETIMEDOUT;
+			goto unref;
+		}
 
-			/*
-			 * If we expire max query time,
-			 * we timed out
-			 */
-			if (after.tv_sec - before.tv_sec >
-					fw->max_query / 1000000) {
-				rc = -ETIMEDOUT;
-				goto out;
-			}
+		/*
+		 * Sleep the interval dictated by firmware
+		 * before query again.
+		 */
+		rc = nanosleep(&now, NULL);
+		if (rc < 0) {
+			rc = -errno;
+			goto unref;
+		}
+		goto again;
+	}
 
-			/*
-			 * Sleep the interval dictated by firmware
-			 * before query again.
-			 */
-			rc = nanosleep(&now, NULL);
-			if (rc < 0) {
-				rc = -errno;
-				goto out;
-			}
-			break;
-		case FW_EBADFW:
-			fprintf(stderr,
-				"Firmware failed to verify by DIMM %s.\n",
-				ndctl_dimm_get_devname(dimm));
-		case FW_EINVAL_CTX:
-		case FW_ESEQUENCE:
+	/* We are done determine error code */
+	switch (status) {
+	case FW_SUCCESS:
+		ver = ndctl_cmd_fw_fquery_get_fw_rev(cmd);
+		if (ver == 0) {
+			fprintf(stderr, "No firmware updated.\n");
 			rc = -ENXIO;
-			goto out;
-		case FW_ENORES:
-			fprintf(stderr,
-				"Firmware update sequence timed out: %s\n",
-				ndctl_dimm_get_devname(dimm));
-			rc = -ETIMEDOUT;
-			goto out;
-		default:
-			fprintf(stderr,
-				"Unknown update status: %#x on DIMM %s\n",
-				status, ndctl_dimm_get_devname(dimm));
-			rc = -EINVAL;
-			goto out;
+			goto unref;
 		}
-	} while (true);
 
-out:
+		fprintf(stderr, "Image updated successfully to DIMM %s.\n",
+			ndctl_dimm_get_devname(dimm));
+		fprintf(stderr, "Firmware version %#lx.\n", ver);
+		fprintf(stderr, "Cold reboot to activate.\n");
+		rc = 0;
+		break;
+	case FW_EBADFW:
+		fprintf(stderr,
+			"Firmware failed to verify by DIMM %s.\n",
+			ndctl_dimm_get_devname(dimm));
+		/* FALLTHROUGH */
+	case FW_EINVAL_CTX:
+	case FW_ESEQUENCE:
+		rc = -ENXIO;
+		break;
+	case FW_ENORES:
+		fprintf(stderr,
+			"Firmware update sequence timed out: %s\n",
+			ndctl_dimm_get_devname(dimm));
+		rc = -ETIMEDOUT;
+		break;
+	default:
+		fprintf(stderr,
+			"Unknown update status: %#x on DIMM %s\n",
+			status, ndctl_dimm_get_devname(dimm));
+		rc = -EINVAL;
+		break;
+	}
+
+unref:
 	ndctl_cmd_unref(cmd);
 	return rc;
 }
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

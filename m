Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB61C216432
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:56:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9DC211108DEAA;
	Mon,  6 Jul 2020 19:56:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 43EB31108DEA8
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:56:45 -0700 (PDT)
IronPort-SDR: vPqo+wNaoUzjCitqpjYhGDJ2/rjMgO3CEc6Uml9F5LC4izuspGWpjNklM8bj6R9PDbVWoNBVVE
 XZk9G4qQQ0gA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="127124218"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="127124218"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:56:44 -0700
IronPort-SDR: fPF0uSo4aYUqhs8BhPLhC4SsLFcE1tiYkunOk1PafzeRm2TSCxZgnoFUP2gqpkoyZffUMzXCGq
 kiI25drPRnGg==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="322539194"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:56:44 -0700
Subject: [ndctl PATCH 02/16] ndctl/dimm: Fix chatty status messages
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Dave Jiang <dave.jiang@intel.com>, vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:40:29 -0700
Message-ID: <159408962923.2386154.3504999903908710322.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: UJGVW7KKCALKBUGFQFBAH5S2D3WELAVO
X-Message-ID-Hash: UJGVW7KKCALKBUGFQFBAH5S2D3WELAVO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UJGVW7KKCALKBUGFQFBAH5S2D3WELAVO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Firmware update and overwrite violate the general design principle of ndctl
that all stdout messages are json formatted. Move the raw status messages
to stderr. Some of the messages are obviously debug and should be moved
under a verbose option, while others confuse use of error() vs
fprintf(stderr, ...). The error() helper is preferred for messages
indicating command failures vs notices.

Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/dimm.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 3db01431d618..8523ead36eb5 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -795,15 +795,16 @@ static int update_firmware(struct ndctl_dimm *dimm,
 	if (rc < 0)
 		return rc;
 
-	printf("Uploading firmware to DIMM %s.\n",
-			ndctl_dimm_get_devname(dimm));
+	if (param.verbose)
+		fprintf(stderr, "Uploading firmware to DIMM %s.\n",
+				ndctl_dimm_get_devname(dimm));
 
 	rc = send_firmware(dimm, actx);
 	if (rc < 0) {
-		fprintf(stderr, "Firmware send failed. Aborting!\n");
+		error("Firmware send failed. Aborting!\n");
 		rc = submit_abort_firmware(dimm, actx);
 		if (rc < 0)
-			fprintf(stderr, "Aborting update sequence failed.\n");
+			error("Aborting update sequence failed.\n");
 		return rc;
 	}
 
@@ -945,7 +946,8 @@ static int action_sanitize_dimm(struct ndctl_dimm *dimm,
 	 */
 	if (!param.crypto_erase && !param.overwrite) {
 		param.crypto_erase = true;
-		printf("No santize method passed in, default to crypto-erase\n");
+		if (param.verbose)
+			fprintf(stderr, "No santize method passed in, default to crypto-erase\n");
 	}
 
 	if (param.crypto_erase) {
@@ -982,8 +984,8 @@ static int action_wait_overwrite(struct ndctl_dimm *dimm,
 	}
 
 	rc = ndctl_dimm_wait_overwrite(dimm);
-	if (rc == 1)
-		printf("%s: overwrite completed.\n",
+	if (rc == 1 && param.verbose)
+		fprintf(stderr, "%s: overwrite completed.\n",
 				ndctl_dimm_get_devname(dimm));
 	return rc;
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

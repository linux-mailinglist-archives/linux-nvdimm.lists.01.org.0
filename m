Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F3216434
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:56:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C775A1108DEB3;
	Mon,  6 Jul 2020 19:56:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 433F31108DEB2
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:56:55 -0700 (PDT)
IronPort-SDR: R7C579U338K8Tz5KYVa64snlq+1mPq+Ux8cylp+IIr2E2yeQhGKIp+7fcuQuo/HcGV4IcNqsLn
 6Yf/gyozDKzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="209052893"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="209052893"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:56:55 -0700
IronPort-SDR: RdtfrpFjTQStjWDE5FyS3dlgY/o5G+0dbLIDUx10Z4t+tFqSyArodr5x8hZfzc9OEtSo1RQOQA
 t+bC3AsFA+TQ==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="297204613"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:56:55 -0700
Subject: [ndctl PATCH 04/16] ndctl/dimm: Detect firmware-update vs ARS
 conflict
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:40:39 -0700
Message-ID: <159408963971.2386154.15820231395815870066.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: LVYRV22BEJ6LYUZH6ISUODPLIFQFIS3B
X-Message-ID-Hash: LVYRV22BEJ6LYUZH6ISUODPLIFQFIS3B
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LVYRV22BEJ6LYUZH6ISUODPLIFQFIS3B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Prevent firmware-update while ARS is active unless --force is supplied.
Translate the FW_ERETRY return code as a conflict with a background DIMM
process.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-update-firmware.txt |    5 ++++
 ndctl/dimm.c                                  |   32 ++++++++++++++++++-------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/ndctl/ndctl-update-firmware.txt b/Documentation/ndctl/ndctl-update-firmware.txt
index f93da6bf15e7..bcf61abaa989 100644
--- a/Documentation/ndctl/ndctl-update-firmware.txt
+++ b/Documentation/ndctl/ndctl-update-firmware.txt
@@ -47,6 +47,11 @@ include::xable-bus-options.txt[]
 --firmware::
 	firmware file used to perform the update
 
+-i::
+--force::
+	Ignore in-progress Address Range Scrub and try to submit the
+	firmware update.
+
 -v::
 --verbose::
         Emit debug messages for the namespace check process.
diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 8523ead36eb5..f67f78e6c420 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -18,7 +18,6 @@
 #include <unistd.h>
 #include <limits.h>
 #include <syslog.h>
-#include <util/log.h>
 #include <util/size.h>
 #include <uuid/uuid.h>
 #include <util/json.h>
@@ -33,6 +32,11 @@
 #include <ndctl/firmware-update.h>
 #include <util/keys.h>
 
+static const char *cmd_name = "dimm";
+static int err_count;
+#define err(fmt, ...) \
+	({ err_count++; error("%s: " fmt, cmd_name, ##__VA_ARGS__); })
+
 struct action_context {
 	struct json_object *jdimms;
 	enum ndctl_namespace_version labelversion;
@@ -832,24 +836,30 @@ static int update_firmware(struct ndctl_dimm *dimm,
 
 static int action_update(struct ndctl_dimm *dimm, struct action_context *actx)
 {
+	struct ndctl_bus *bus = ndctl_dimm_get_bus(dimm);
+	const char *devname = ndctl_dimm_get_devname(dimm);
 	int rc;
 
 	rc = ndctl_dimm_fw_update_supported(dimm);
 	switch (rc) {
 	case -ENOTTY:
-		error("%s: firmware update not supported by ndctl.",
-			ndctl_dimm_get_devname(dimm));
+		err("%s: firmware update not supported by ndctl.", devname);
 		return rc;
 	case -EOPNOTSUPP:
-		error("%s: firmware update not supported by the kernel",
-			ndctl_dimm_get_devname(dimm));
+		err("%s: firmware update not supported by the kernel", devname);
 		return rc;
 	case -EIO:
-		error("%s: firmware update not supported by either platform firmware or the kernel.",
-			ndctl_dimm_get_devname(dimm));
+		err("%s: firmware update not supported by either platform firmware or the kernel.",
+				devname);
 		return rc;
 	}
 
+	if (ndctl_bus_get_scrub_state(bus) > 0 && !param.force) {
+		err("%s: scrub active, retry after 'ndctl wait-scrub'",
+				devname);
+		return -EBUSY;
+	}
+
 	rc = update_verify_input(actx);
 	if (rc < 0)
 		return rc;
@@ -1073,7 +1083,8 @@ OPT_STRING('i', "input", &param.infile, "input-file", \
 
 #define UPDATE_OPTIONS() \
 OPT_STRING('f', "firmware", &param.infile, "firmware-file", \
-	"firmware filename for update")
+	"firmware filename for update"), \
+OPT_BOOLEAN('i', "force", &param.force, "ignore ARS status, try to force update")
 
 #define INIT_OPTIONS() \
 OPT_BOOLEAN('f', "force", &param.force, \
@@ -1386,7 +1397,10 @@ int cmd_enable_dimm(int argc, const char **argv, struct ndctl_ctx *ctx)
 
 int cmd_update_firmware(int argc, const char **argv, struct ndctl_ctx *ctx)
 {
-	int count = dimm_action(argc, argv, ctx, action_update, update_options,
+	int count;
+
+	cmd_name = "update firmware";
+	count = dimm_action(argc, argv, ctx, action_update, update_options,
 			"ndctl update-firmware <nmem0> [<nmem1>..<nmemN>] [<options>]");
 
 	fprintf(stderr, "updated %d nmem%s.\n", count >= 0 ? count : 0,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

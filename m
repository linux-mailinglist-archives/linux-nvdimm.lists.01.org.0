Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6CD174956
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:38:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DEBBE10FC3760;
	Sat, 29 Feb 2020 12:39:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 48AEC10FC3520
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:39:31 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:38 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="351177081"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:39 -0800
Subject: [ndctl PATCH 28/36] ndctl/namespace: Fix namespace-action vs
 namespace-mode confusion
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:22:34 -0800
Message-ID: <158300775410.2141307.2974585372072324266.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: ZAPW5ACPRLKKXLYGNB7Y5T4E6JNFTFIU
X-Message-ID-Hash: ZAPW5ACPRLKKXLYGNB7Y5T4E6JNFTFIU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZAPW5ACPRLKKXLYGNB7Y5T4E6JNFTFIU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Rename the 'enum device_action' parameter to set_defaults() to 'action'
to remove confusion with the namespace mode parameter.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 397bd4acd1d1..cfa0563f59a1 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -196,7 +196,7 @@ static const struct option read_infoblock_options[] = {
 	OPT_END(),
 };
 
-static int set_defaults(enum device_action mode)
+static int set_defaults(enum device_action action)
 {
 	int rc = 0;
 
@@ -210,7 +210,7 @@ static int set_defaults(enum device_action mode)
 				param.type);
 			rc = -EINVAL;
 		}
-	} else if (!param.reconfig && mode == ACTION_CREATE)
+	} else if (!param.reconfig && action == ACTION_CREATE)
 		param.type = "pmem";
 
 	if (param.mode) {
@@ -293,7 +293,7 @@ static int set_defaults(enum device_action mode)
  * looking at actual namespace devices and available resources.
  */
 static const char *parse_namespace_options(int argc, const char **argv,
-		enum device_action mode, const struct option *options,
+		enum device_action action, const struct option *options,
 		char *xable_usage)
 {
 	const char * const u[] = {
@@ -305,12 +305,12 @@ static const char *parse_namespace_options(int argc, const char **argv,
 	param.do_scan = argc == 1;
         argc = parse_options(argc, argv, options, u, 0);
 
-	rc = set_defaults(mode);
+	rc = set_defaults(action);
 
-	if (argc == 0 && mode != ACTION_CREATE) {
+	if (argc == 0 && action != ACTION_CREATE) {
 		char *action_string;
 
-		switch (mode) {
+		switch (action) {
 			case ACTION_ENABLE:
 				action_string = "enable";
 				break;
@@ -334,18 +334,18 @@ static const char *parse_namespace_options(int argc, const char **argv,
 				break;
 		}
 
-		if ((mode == ACTION_READ_INFOBLOCK && !param.infile)
-				|| mode != ACTION_READ_INFOBLOCK) {
+		if ((action == ACTION_READ_INFOBLOCK && !param.infile)
+				|| action != ACTION_READ_INFOBLOCK) {
 			error("specify a namespace to %s, or \"all\"\n", action_string);
 			rc = -EINVAL;
 		}
 	}
-	for (i = mode == ACTION_CREATE ? 0 : 1; i < argc; i++) {
+	for (i = action == ACTION_CREATE ? 0 : 1; i < argc; i++) {
 		error("unknown extra parameter \"%s\"\n", argv[i]);
 		rc = -EINVAL;
 	}
 
-	if (mode == ACTION_READ_INFOBLOCK && param.infile && argc) {
+	if (action == ACTION_READ_INFOBLOCK && param.infile && argc) {
 		error("specify a namespace, or --input, not both\n");
 		rc = -EINVAL;
 	}
@@ -355,7 +355,7 @@ static const char *parse_namespace_options(int argc, const char **argv,
 		return NULL; /* we won't return from usage_with_options() */
 	}
 
-	return mode == ACTION_CREATE ? param.reconfig : argv[0];
+	return action == ACTION_CREATE ? param.reconfig : argv[0];
 }
 
 #define try(prefix, op, dev, p) \
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

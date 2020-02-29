Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F031917495A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:39:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C21F10FC3765;
	Sat, 29 Feb 2020 12:39:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C3FD10FC36EE
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:39:52 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:39:00 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="385829780"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:39:00 -0800
Subject: [ndctl PATCH 32/36] ndctl/namespace: Parse infoblocks from stdin
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:22:54 -0800
Message-ID: <158300777490.2141307.3531523891640736244.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: R3ILRPWQ2JXKO2VJNWVJGTGWZC3YGKXU
X-Message-ID-Hash: R3ILRPWQ2JXKO2VJNWVJGTGWZC3YGKXU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R3ILRPWQ2JXKO2VJNWVJGTGWZC3YGKXU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for validating a new write-infoblock command, teach
read-infoblock to parse stdin by default.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index ef82254a7b18..7bfc7d1ab61d 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -334,8 +334,7 @@ static const char *parse_namespace_options(int argc, const char **argv,
 				break;
 		}
 
-		if ((action == ACTION_READ_INFOBLOCK && !param.infile)
-				|| action != ACTION_READ_INFOBLOCK) {
+		if (action != ACTION_READ_INFOBLOCK) {
 			error("specify a namespace to %s, or \"all\"\n", action_string);
 			rc = -EINVAL;
 		}
@@ -355,6 +354,8 @@ static const char *parse_namespace_options(int argc, const char **argv,
 		return NULL; /* we won't return from usage_with_options() */
 	}
 
+	if (action == ACTION_READ_INFOBLOCK && !param.infile && !argc)
+		return NULL;
 	return action == ACTION_CREATE ? param.reconfig : argv[0];
 }
 
@@ -1688,7 +1689,12 @@ static int file_read_infoblock(const char *path, struct ndctl_namespace *ndns,
 	if (!buf)
 		return -ENOMEM;
 
-	fd = open(path, O_RDONLY|O_EXCL);
+	if (!path) {
+		fd = STDIN_FILENO;
+		path = "<stdin>";
+	} else
+		fd = open(path, O_RDONLY|O_EXCL);
+
 	if (fd < 0) {
 		pr_verbose("%s: %s failed to open %s: %s\n",
 				cmd, devname, path, strerror(errno));
@@ -1697,17 +1703,20 @@ static int file_read_infoblock(const char *path, struct ndctl_namespace *ndns,
 	}
 
 	rc = read(fd, buf, INFOBLOCK_SZ);
-	if (rc < 0) {
+	if (rc < INFOBLOCK_SZ) {
 		pr_verbose("%s: %s failed to read %s: %s\n",
 				cmd, devname, path, strerror(errno));
-		rc = -errno;
+		if (rc < 0)
+			rc = -errno;
+		else
+			rc = -EIO;
 		goto out;
 	}
 
 	rc = parse_namespace_infoblock(buf, ndns, path, ri_ctx);
 out:
 	free(buf);
-	if (fd >= 0)
+	if (fd >= 0 && fd != STDIN_FILENO)
 		close(fd);
 	return rc;
 }
@@ -1766,10 +1775,12 @@ static int do_xaction_namespace(const char *namespace,
 			}
 		}
 
-		if (param.infile) {
+		if (param.infile || !namespace) {
 			rc = file_read_infoblock(param.infile, NULL, &ri_ctx);
 			if (ri_ctx.jblocks)
 				util_display_json_array(ri_ctx.f_out, ri_ctx.jblocks, 0);
+			if (rc >= 0)
+				(*processed)++;
 			return rc;
 		}
 	}
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

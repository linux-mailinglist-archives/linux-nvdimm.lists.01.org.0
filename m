Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5571174959
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:38:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3381F10FC36EA;
	Sat, 29 Feb 2020 12:39:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 86AEB10FC36F9
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:39:46 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:54 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="411766949"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:54 -0800
Subject: [ndctl PATCH 31/36] ndctl/namespace: Fix read-info-block vs
 read-infoblock
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:22:49 -0800
Message-ID: <158300776980.2141307.13151671384582818216.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: C7TOZ2HUTNZO5YN6R5VR7YZH6KE3EXNN
X-Message-ID-Hash: C7TOZ2HUTNZO5YN6R5VR7YZH6KE3EXNN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C7TOZ2HUTNZO5YN6R5VR7YZH6KE3EXNN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Correct occurrences that hyphenate infoblock, and fixup use of
"namespace" that should be "infoblock".

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index e38151430436..ef82254a7b18 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -152,11 +152,11 @@ OPT_BOOLEAN('s', "scrub", &scrub, "run a scrub to find latent errors")
 
 #define READ_INFOBLOCK_OPTIONS() \
 OPT_FILENAME('o', "output", &param.outfile, "output-file", \
-	"filename to write info-block contents"), \
+	"filename to write infoblock contents"), \
 OPT_FILENAME('i', "input", &param.infile, "input-file", \
-	"filename to read info-block instead of a namespace"), \
+	"filename to read infoblock instead of a namespace"), \
 OPT_BOOLEAN('V', "verify", &param.verify, \
-	"validate parent uuid, and info-block checksum"), \
+	"validate parent uuid, and infoblock checksum"), \
 OPT_BOOLEAN('j', "json", &param.json, "parse label data into json"), \
 OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats (implies --json)")
 
@@ -1455,7 +1455,7 @@ static json_object *btt_parse(struct btt_sb *btt_sb, struct ndctl_namespace *ndn
 	uuid_t uuid;
 	char str[40];
 	struct json_object *jblock, *jobj;
-	const char *cmd = "read-info-block";
+	const char *cmd = "read-infoblock";
 	const bool verify = param.verify;
 
 	if (verify && !verify_infoblock_checksum((union info_block *) btt_sb)) {
@@ -1543,7 +1543,7 @@ static json_object *pfn_parse(struct pfn_sb *pfn_sb, struct ndctl_namespace *ndn
 	uuid_t uuid;
 	char str[40];
 	struct json_object *jblock, *jobj;
-	const char *cmd = "read-info-block";
+	const char *cmd = "read-infoblock";
 	const bool verify = param.verify;
 
 	if (verify && !verify_infoblock_checksum((union info_block *) pfn_sb)) {
@@ -1680,7 +1680,7 @@ static int file_read_infoblock(const char *path, struct ndctl_namespace *ndns,
 		struct read_infoblock_ctx *ri_ctx)
 {
 	const char *devname = ndns ? ndctl_namespace_get_devname(ndns) : "";
-	const char *cmd = "read-info-block";
+	const char *cmd = "read-infoblock";
 	void *buf = NULL;
 	int fd = -1, rc;
 
@@ -1717,7 +1717,7 @@ static int namespace_read_infoblock(struct ndctl_namespace *ndns,
 {
 	int rc;
 	char path[50];
-	const char *cmd = "read-info-block";
+	const char *cmd = "read-infoblock";
 	const char *devname = ndctl_namespace_get_devname(ndns);
 
 	if (ndctl_namespace_is_active(ndns)) {
@@ -2033,7 +2033,7 @@ int cmd_clear_errors(int argc , const char **argv, struct ndctl_ctx *ctx)
 
 int cmd_read_infoblock(int argc, const char **argv, struct ndctl_ctx *ctx)
 {
-	char *xable_usage = "ndctl read-info-block <namespace> [<options>]";
+	char *xable_usage = "ndctl read-infoblock <namespace> [<options>]";
 	const char *namespace = parse_namespace_options(argc, argv,
 			ACTION_READ_INFOBLOCK, read_infoblock_options,
 			xable_usage);
@@ -2041,8 +2041,8 @@ int cmd_read_infoblock(int argc, const char **argv, struct ndctl_ctx *ctx)
 
 	rc = do_xaction_namespace(namespace, ACTION_READ_INFOBLOCK, ctx, &read);
 	if (rc < 0)
-		fprintf(stderr, "error checking namespaces: %s\n",
+		fprintf(stderr, "error reading infoblock data: %s\n",
 				strerror(-rc));
-	fprintf(stderr, "read %d namespace%s\n", read, read == 1 ? "" : "s");
+	fprintf(stderr, "read %d infoblock%s\n", read, read == 1 ? "" : "s");
 	return rc;
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

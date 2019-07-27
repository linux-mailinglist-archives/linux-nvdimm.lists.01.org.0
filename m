Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CB277C1E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:53:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1BE7D212AAB8E;
	Sat, 27 Jul 2019 14:56:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1458E212E1591
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:56:16 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:53:48 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="175977492"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:53:48 -0700
Subject: [ndctl PATCH v2 02/26] ndctl/dimm: Add --human support to read-labels
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:39:31 -0700
Message-ID: <156426357173.531577.2988157861473659679.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Allow for easier comparisons between 'read-labels' output and list.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-read-labels.txt |    7 +++++++
 ndctl/dimm.c                              |   20 ++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/ndctl/ndctl-read-labels.txt b/Documentation/ndctl/ndctl-read-labels.txt
index 0127e15f0721..756713ee12d7 100644
--- a/Documentation/ndctl/ndctl-read-labels.txt
+++ b/Documentation/ndctl/ndctl-read-labels.txt
@@ -27,6 +27,13 @@ include::labels-options.txt[]
 	parse the label data into json assuming the 'NVDIMM Namespace
 	Specification' format.
 
+-u::
+--human::
+	enable json output and convert number formats to human readable
+	strings, for example show the size in terms of "KB", "MB", "GB", etc
+	instead of a signed 64-bit numbers per the JSON interchange
+	format (implies --json).
+
 include::../copyright.txt[]
 
 SEE ALSO
diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 8946dc74fe41..5f05a75f00eb 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -51,6 +51,7 @@ static struct parameters {
 	bool overwrite;
 	bool zero_key;
 	bool master_pass;
+	bool human;
 	bool force;
 	bool json;
 	bool verbose;
@@ -80,7 +81,7 @@ static int action_zero(struct ndctl_dimm *dimm, struct action_context *actx)
 }
 
 static struct json_object *dump_label_json(struct ndctl_dimm *dimm,
-		struct ndctl_cmd *cmd_read, ssize_t size)
+		struct ndctl_cmd *cmd_read, ssize_t size, unsigned long flags)
 {
 	struct json_object *jarray = json_object_new_array();
 	struct json_object *jlabel = NULL;
@@ -141,12 +142,13 @@ static struct json_object *dump_label_json(struct ndctl_dimm *dimm,
 			break;
 		json_object_object_add(jlabel, "nlabel", jobj);
 
-		jobj = json_object_new_int64(le64_to_cpu(nslabel.flags));
+		jobj = util_json_object_hex(le32_to_cpu(nslabel.flags), flags);
 		if (!jobj)
 			break;
 		json_object_object_add(jlabel, "flags", jobj);
 
-		jobj = json_object_new_int64(le64_to_cpu(nslabel.isetcookie));
+		jobj = util_json_object_hex(le64_to_cpu(nslabel.isetcookie),
+				flags);
 		if (!jobj)
 			break;
 		json_object_object_add(jlabel, "isetcookie", jobj);
@@ -156,12 +158,12 @@ static struct json_object *dump_label_json(struct ndctl_dimm *dimm,
 			break;
 		json_object_object_add(jlabel, "lbasize", jobj);
 
-		jobj = json_object_new_int64(le64_to_cpu(nslabel.dpa));
+		jobj = util_json_object_hex(le64_to_cpu(nslabel.dpa), flags);
 		if (!jobj)
 			break;
 		json_object_object_add(jlabel, "dpa", jobj);
 
-		jobj = json_object_new_int64(le64_to_cpu(nslabel.rawsize));
+		jobj = util_json_object_size(le64_to_cpu(nslabel.rawsize), flags);
 		if (!jobj)
 			break;
 		json_object_object_add(jlabel, "rawsize", jobj);
@@ -266,6 +268,7 @@ static struct json_object *dump_index_json(struct ndctl_cmd *cmd_read, ssize_t s
 static struct json_object *dump_json(struct ndctl_dimm *dimm,
 		struct ndctl_cmd *cmd_read, ssize_t size)
 {
+	unsigned long flags = param.human ? UTIL_JSON_HUMAN : 0;
 	struct json_object *jdimm = json_object_new_object();
 	struct json_object *jlabel, *jobj, *jindex;
 
@@ -274,7 +277,7 @@ static struct json_object *dump_json(struct ndctl_dimm *dimm,
 	jindex = dump_index_json(cmd_read, size);
 	if (!jindex)
 		goto err_jindex;
-	jlabel = dump_label_json(dimm, cmd_read, size);
+	jlabel = dump_label_json(dimm, cmd_read, size, flags);
 	if (!jlabel)
 		goto err_jlabel;
 
@@ -1046,7 +1049,8 @@ OPT_BOOLEAN('v',"verbose", &param.verbose, "turn on debug")
 #define READ_OPTIONS() \
 OPT_STRING('o', "output", &param.outfile, "output-file", \
 	"filename to write label area contents"), \
-OPT_BOOLEAN('j', "json", &param.json, "parse label data into json")
+OPT_BOOLEAN('j', "json", &param.json, "parse label data into json"), \
+OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats (implies --json)")
 
 #define WRITE_OPTIONS() \
 OPT_STRING('i', "input", &param.infile, "input-file", \
@@ -1156,7 +1160,7 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 		return -EINVAL;
 	}
 
-	if (param.json) {
+	if (param.json || param.human) {
 		actx.jdimms = json_object_new_array();
 		if (!actx.jdimms)
 			return -ENOMEM;

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

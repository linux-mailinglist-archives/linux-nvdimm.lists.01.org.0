Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51B8828A6
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 02:23:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E30312132996F;
	Mon,  5 Aug 2019 17:26:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CA290213281FD
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 17:26:12 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 17:23:42 -0700
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; d="scan'208";a="257873457"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 17:23:41 -0700
Subject: [ndctl PATCH v5 4/7] ndctl/dimm: Limit read-labels with --index option
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 05 Aug 2019 17:09:24 -0700
Message-ID: <156505016472.848599.421144991652487735.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156505014382.848599.16271067825582995055.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156505014382.848599.16271067825582995055.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Provide a capability to limit the read-labels payload to just the
index-block data space.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-read-labels.txt |    7 +++++
 ndctl/dimm.c                              |   43 ++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/Documentation/ndctl/ndctl-read-labels.txt b/Documentation/ndctl/ndctl-read-labels.txt
index 756713ee12d7..b5ddae9c269e 100644
--- a/Documentation/ndctl/ndctl-read-labels.txt
+++ b/Documentation/ndctl/ndctl-read-labels.txt
@@ -19,6 +19,13 @@ file.  In the multi-dimm case the data is concatenated.
 OPTIONS
 -------
 include::labels-options.txt[]
+-I::
+--index::
+	Limit the span of the label operation to just the index-block
+	area. This is useful to determine if the dimm label area is
+	initialized. Note that this option and --size/--offset are
+	mutually exclusive.
+
 -o::
 --output::
 	output file
diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 70128dd2df27..5e6fa19bab15 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -55,6 +55,7 @@ static struct parameters {
 	bool master_pass;
 	bool human;
 	bool force;
+	bool index;
 	bool json;
 	bool verbose;
 } param = {
@@ -276,27 +277,26 @@ static struct json_object *dump_json(struct ndctl_dimm *dimm,
 
 	if (!jdimm)
 		return NULL;
-	jindex = dump_index_json(cmd_read, size);
-	if (!jindex)
-		goto err_jindex;
-	jlabel = dump_label_json(dimm, cmd_read, size, flags);
-	if (!jlabel)
-		goto err_jlabel;
 
 	jobj = json_object_new_string(ndctl_dimm_get_devname(dimm));
 	if (!jobj)
-		goto err_jobj;
-
+		goto err;
 	json_object_object_add(jdimm, "dev", jobj);
+
+	jindex = dump_index_json(cmd_read, size);
+	if (!jindex)
+		goto err;
 	json_object_object_add(jdimm, "index", jindex);
+	if (param.index)
+		return jdimm;
+
+	jlabel = dump_label_json(dimm, cmd_read, size, flags);
+	if (!jlabel)
+		goto err;
 	json_object_object_add(jdimm, "label", jlabel);
-	return jdimm;
 
- err_jobj:
-	json_object_put(jlabel);
- err_jlabel:
-	json_object_put(jindex);
- err_jindex:
+	return jdimm;
+err:
 	json_object_put(jdimm);
 	return NULL;
 }
@@ -385,7 +385,11 @@ static int action_read(struct ndctl_dimm *dimm, struct action_context *actx)
 	ssize_t size;
 	int rc = 0;
 
-	cmd_read = ndctl_dimm_read_label_extent(dimm, param.len, param.offset);
+	if (param.index)
+		cmd_read = ndctl_dimm_read_label_index(dimm);
+	else
+		cmd_read = ndctl_dimm_read_label_extent(dimm, param.len,
+				param.offset);
 	if (!cmd_read)
 		return -EINVAL;
 
@@ -1054,7 +1058,8 @@ OPT_BOOLEAN('v',"verbose", &param.verbose, "turn on debug")
 OPT_STRING('o', "output", &param.outfile, "output-file", \
 	"filename to write label area contents"), \
 OPT_BOOLEAN('j', "json", &param.json, "parse label data into json"), \
-OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats (implies --json)")
+OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats (implies --json)"), \
+OPT_BOOLEAN('I', "index", &param.index, "limit read to the index block area")
 
 #define WRITE_OPTIONS() \
 OPT_STRING('i', "input", &param.infile, "input-file", \
@@ -1185,6 +1190,12 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 		return -EINVAL;
 	}
 
+	if (param.index && param.len) {
+		fprintf(stderr, "pick either --size, or --index, not both\n");
+		usage_with_options(u, options);
+		return -EINVAL;
+	}
+
 	if (json) {
 		actx.jdimms = json_object_new_array();
 		if (!actx.jdimms)

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

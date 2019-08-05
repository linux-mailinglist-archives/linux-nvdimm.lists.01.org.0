Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8E782844
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 01:51:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB59F213281F6;
	Mon,  5 Aug 2019 16:53:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A2745213030A2
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 16:45:47 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 16:43:16 -0700
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; d="scan'208";a="192529749"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 16:43:16 -0700
Subject: [ndctl PATCH v4 3/7] ndctl/dimm: Add offset and size options to
 {read, write, zero}-labels
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 05 Aug 2019 16:28:59 -0700
Message-ID: <156504773928.847544.12057430970380515817.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156504772175.847544.11368833704527657055.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156504772175.847544.11368833704527657055.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Allow for more precision in label utilities, i.e. stop operating over
the entire label area.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/labels-options.txt |    9 ++++++
 ndctl/dimm.c                           |   49 ++++++++++++++++++++++++--------
 ndctl/lib/dimm.c                       |   36 ++++++++++++++++++++----
 ndctl/lib/libndctl.c                   |    1 +
 ndctl/lib/libndctl.sym                 |    2 +
 ndctl/lib/private.h                    |    3 --
 ndctl/libndctl.h                       |    4 +++
 util/util.h                            |    4 +++
 8 files changed, 87 insertions(+), 21 deletions(-)

diff --git a/Documentation/ndctl/labels-options.txt b/Documentation/ndctl/labels-options.txt
index 539ace079557..4aee37969fd5 100644
--- a/Documentation/ndctl/labels-options.txt
+++ b/Documentation/ndctl/labels-options.txt
@@ -5,6 +5,15 @@
 	operate on every dimm in the system, optionally filtered by bus id (see
         --bus= option).
 
+-s::
+--size=::
+	Limit the operation to the given number of bytes. A size of 0
+	indicates to operate over the entire label capacity.
+
+-O::
+--offset=::
+	Begin the operation at the given offset into the label area.
+
 -b::
 --bus=::
 	Limit operation to memory devices (dimms) that are on the given bus.
diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index d78e0dbc3ec6..70128dd2df27 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -47,6 +47,8 @@ static struct parameters {
 	const char *infile;
 	const char *labelversion;
 	const char *kek;
+	unsigned len;
+	unsigned offset;
 	bool crypto_erase;
 	bool overwrite;
 	bool zero_key;
@@ -77,7 +79,7 @@ static int action_enable(struct ndctl_dimm *dimm, struct action_context *actx)
 
 static int action_zero(struct ndctl_dimm *dimm, struct action_context *actx)
 {
-	return ndctl_dimm_zero_labels(dimm);
+	return ndctl_dimm_zero_label_extent(dimm, param.len, param.offset);
 }
 
 static struct json_object *dump_label_json(struct ndctl_dimm *dimm,
@@ -299,15 +301,17 @@ static struct json_object *dump_json(struct ndctl_dimm *dimm,
 	return NULL;
 }
 
-static int rw_bin(FILE *f, struct ndctl_cmd *cmd, ssize_t size, int rw)
+static int rw_bin(FILE *f, struct ndctl_cmd *cmd, ssize_t size,
+		unsigned int start_offset, int rw)
 {
 	char buf[4096];
 	ssize_t offset, write = 0;
 
-	for (offset = 0; offset < size; offset += sizeof(buf)) {
+	for (offset = start_offset; offset < start_offset + size;
+			offset += sizeof(buf)) {
 		ssize_t len = min_t(ssize_t, sizeof(buf), size - offset), rc;
 
-		if (rw) {
+		if (rw == WRITE) {
 			len = fread(buf, 1, len, f);
 			if (len == 0)
 				break;
@@ -343,9 +347,9 @@ static int action_write(struct ndctl_dimm *dimm, struct action_context *actx)
 		return -EBUSY;
 	}
 
-	cmd_read = ndctl_dimm_read_labels(dimm);
+	cmd_read = ndctl_dimm_read_label_extent(dimm, param.len, param.offset);
 	if (!cmd_read)
-		return -ENXIO;
+		return -EINVAL;
 
 	cmd_write = ndctl_dimm_cmd_new_cfg_write(cmd_read);
 	if (!cmd_write) {
@@ -354,7 +358,7 @@ static int action_write(struct ndctl_dimm *dimm, struct action_context *actx)
 	}
 
 	size = ndctl_cmd_cfg_read_get_size(cmd_read);
-	rc = rw_bin(actx->f_in, cmd_write, size, 1);
+	rc = rw_bin(actx->f_in, cmd_write, size, param.offset, WRITE);
 
 	/*
 	 * If the dimm is already disabled the kernel is not holding a cached
@@ -381,9 +385,9 @@ static int action_read(struct ndctl_dimm *dimm, struct action_context *actx)
 	ssize_t size;
 	int rc = 0;
 
-	cmd_read = ndctl_dimm_read_labels(dimm);
+	cmd_read = ndctl_dimm_read_label_extent(dimm, param.len, param.offset);
 	if (!cmd_read)
-		return -ENXIO;
+		return -EINVAL;
 
 	size = ndctl_cmd_cfg_read_get_size(cmd_read);
 	if (actx->jdimms) {
@@ -394,7 +398,7 @@ static int action_read(struct ndctl_dimm *dimm, struct action_context *actx)
 		else
 			rc = -ENOMEM;
 	} else
-		rc = rw_bin(actx->f_out, cmd_read, size, 0);
+		rc = rw_bin(actx->f_out, cmd_read, size, param.offset, READ);
 
 	ndctl_cmd_unref(cmd_read);
 
@@ -1082,18 +1086,31 @@ OPT_BOOLEAN('z', "zero-key", &param.zero_key, \
 OPT_BOOLEAN('m', "master-passphrase", &param.master_pass, \
 		"use master passphrase")
 
+#define LABEL_OPTIONS() \
+OPT_UINTEGER('s', "size", &param.len, "number of label bytes to operate"), \
+OPT_UINTEGER('O', "offset", &param.offset, \
+	"offset into the label area to start operation")
+
 static const struct option read_options[] = {
 	BASE_OPTIONS(),
+	LABEL_OPTIONS(),
 	READ_OPTIONS(),
 	OPT_END(),
 };
 
 static const struct option write_options[] = {
 	BASE_OPTIONS(),
+	LABEL_OPTIONS(),
 	WRITE_OPTIONS(),
 	OPT_END(),
 };
 
+static const struct option zero_options[] = {
+	BASE_OPTIONS(),
+	LABEL_OPTIONS(),
+	OPT_END(),
+};
+
 static const struct option update_options[] = {
 	BASE_OPTIONS(),
 	UPDATE_OPTIONS(),
@@ -1136,6 +1153,7 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 		NULL
 	};
 	unsigned long id;
+	bool json = false;
 
         argc = parse_options(argc, argv, options, u, 0);
 
@@ -1160,7 +1178,14 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 		return -EINVAL;
 	}
 
-	if (param.json || param.human) {
+	json = param.json || param.human;
+	if (action == action_read && json && (param.len || param.offset)) {
+		fprintf(stderr, "--size and --offset are incompatible with --json\n");
+		usage_with_options(u, options);
+		return -EINVAL;
+	}
+
+	if (json) {
 		actx.jdimms = json_object_new_array();
 		if (!actx.jdimms)
 			return -ENOMEM;
@@ -1294,7 +1319,7 @@ int cmd_read_labels(int argc, const char **argv, struct ndctl_ctx *ctx)
 
 int cmd_zero_labels(int argc, const char **argv, struct ndctl_ctx *ctx)
 {
-	int count = dimm_action(argc, argv, ctx, action_zero, base_options,
+	int count = dimm_action(argc, argv, ctx, action_zero, zero_options,
 			"ndctl zero-labels <nmem0> [<nmem1>..<nmemN>] [<options>]");
 
 	fprintf(stderr, "zeroed %d nmem%s\n", count >= 0 ? count : 0,
diff --git a/ndctl/lib/dimm.c b/ndctl/lib/dimm.c
index 2b5b964fe03d..3728ec66b7a7 100644
--- a/ndctl/lib/dimm.c
+++ b/ndctl/lib/dimm.c
@@ -537,7 +537,8 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_read_label_index(struct ndctl_dimm *di
         return NULL;
 }
 
-NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_read_labels(struct ndctl_dimm *dimm)
+NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_read_label_extent(
+		struct ndctl_dimm *dimm, unsigned int len, unsigned int offset)
 {
         struct ndctl_bus *bus = ndctl_dimm_get_bus(dimm);
         struct ndctl_cmd *cmd_size, *cmd_read;
@@ -557,13 +558,25 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_read_labels(struct ndctl_dimm *dimm)
         cmd_read = ndctl_dimm_cmd_new_cfg_read(cmd_size);
         if (!cmd_read)
                 goto out_size;
+
+	/*
+	 * For ndctl_read_labels() compat, enable subsequent calls that
+	 * will manipulate labels
+	 */
+	if (len == 0 && offset == 0)
+		init_ndd(&dimm->ndd, cmd_read, cmd_size);
+
+	if (len == 0)
+		len = cmd_size->get_size->config_size;
+	rc = ndctl_cmd_cfg_read_set_extent(cmd_read, len, offset);
+	if (rc < 0)
+		goto out_size;
+
         rc = ndctl_cmd_submit_xlat(cmd_read);
         if (rc < 0)
                 goto out_read;
 	ndctl_cmd_unref(cmd_size);
 
-	init_ndd(&dimm->ndd, cmd_read, cmd_size);
-
 	return cmd_read;
 
  out_read:
@@ -573,15 +586,21 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_read_labels(struct ndctl_dimm *dimm)
         return NULL;
 }
 
-NDCTL_EXPORT int ndctl_dimm_zero_labels(struct ndctl_dimm *dimm)
+NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_read_labels(struct ndctl_dimm *dimm)
+{
+	return ndctl_dimm_read_label_extent(dimm, 0, 0);
+}
+
+NDCTL_EXPORT int ndctl_dimm_zero_label_extent(struct ndctl_dimm *dimm,
+		unsigned int len, unsigned int offset)
 {
 	struct ndctl_ctx *ctx = ndctl_dimm_get_ctx(dimm);
 	struct ndctl_cmd *cmd_read, *cmd_write;
 	int rc;
 
-	cmd_read = ndctl_dimm_read_labels(dimm);
+	cmd_read = ndctl_dimm_read_label_extent(dimm, len, offset);
 	if (!cmd_read)
-		return -ENXIO;
+		return -EINVAL;
 
 	if (ndctl_dimm_is_active(dimm)) {
 		dbg(ctx, "%s: regions active, abort label write\n",
@@ -623,6 +642,11 @@ NDCTL_EXPORT int ndctl_dimm_zero_labels(struct ndctl_dimm *dimm)
 	return rc;
 }
 
+NDCTL_EXPORT int ndctl_dimm_zero_labels(struct ndctl_dimm *dimm)
+{
+	return ndctl_dimm_zero_label_extent(dimm, 0, 0);
+}
+
 NDCTL_EXPORT unsigned long ndctl_dimm_get_available_labels(
 		struct ndctl_dimm *dimm)
 {
diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index c1ecdd8c9c61..4d9cc7e29c6b 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -31,6 +31,7 @@
 #include <ccan/build_assert/build_assert.h>
 
 #include <ndctl.h>
+#include <util/util.h>
 #include <util/size.h>
 #include <util/sysfs.h>
 #include <ndctl/libndctl.h>
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index 648f83bced1b..fef2907aa47d 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -416,4 +416,6 @@ LIBNDCTL_21 {
 	ndctl_cmd_cfg_read_set_extent;
 	ndctl_cmd_cfg_write_set_extent;
 	ndctl_dimm_read_label_index;
+	ndctl_dimm_read_label_extent;
+	ndctl_dimm_zero_label_extent;
 } LIBNDCTL_20;
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 3fc0290ff6a7..1f6a01c55377 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -242,9 +242,6 @@ struct ndctl_namespace {
  *
  * A command may only specify one of @source, or @iter.total_buf, not both.
  */
-enum {
-	READ, WRITE,
-};
 struct ndctl_cmd {
 	struct ndctl_dimm *dimm;
 	struct ndctl_bus *bus;
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 8aa4b8bbe6c2..c9d0dc120d3b 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -307,8 +307,12 @@ struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_size(struct ndctl_dimm *dimm);
 struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_read(struct ndctl_cmd *cfg_size);
 struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_write(struct ndctl_cmd *cfg_read);
 int ndctl_dimm_zero_labels(struct ndctl_dimm *dimm);
+int ndctl_dimm_zero_label_extent(struct ndctl_dimm *dimm,
+		unsigned int len, unsigned int offset);
 struct ndctl_cmd *ndctl_dimm_read_labels(struct ndctl_dimm *dimm);
 struct ndctl_cmd *ndctl_dimm_read_label_index(struct ndctl_dimm *dimm);
+struct ndctl_cmd *ndctl_dimm_read_label_extent(struct ndctl_dimm *dimm,
+		unsigned int len, unsigned int offset);
 int ndctl_dimm_validate_labels(struct ndctl_dimm *dimm);
 enum ndctl_namespace_version {
 	NDCTL_NS_VERSION_1_1,
diff --git a/util/util.h b/util/util.h
index 001707e8b159..54c6ef18b6d7 100644
--- a/util/util.h
+++ b/util/util.h
@@ -73,6 +73,10 @@
 #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
 
+enum {
+	READ, WRITE,
+};
+
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
         size_t len = strlen(prefix);

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

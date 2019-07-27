Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1878677C23
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:54:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88ADA212E258A;
	Sat, 27 Jul 2019 14:56:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0F903212E15B5
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:56:26 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:53:59 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="322416297"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:53:59 -0700
Subject: [ndctl PATCH v2 04/26] ndctl/namespace: Add read-infoblock command
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:39:42 -0700
Message-ID: <156426358204.531577.5297230715816068527.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Namespaces may contain an info-block that correlates with the possible
modes of a namespace: 'sector', 'fsdax', or 'devdax'. Provide a command
that can temporarily convert the namespace into 'raw' mode to read the
info-block.

Also, similar to 'read-labels' provide a facility to decode the
info-block into json.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/Makefile.am              |    3 
 Documentation/ndctl/ndctl-read-infoblock.txt |   94 ++++++
 ndctl/action.h                               |    1 
 ndctl/builtin.h                              |    1 
 ndctl/check.c                                |   20 -
 ndctl/namespace.c                            |  401 ++++++++++++++++++++++++++
 ndctl/namespace.h                            |   51 +++
 ndctl/ndctl.c                                |    1 
 util/fletcher.h                              |    1 
 util/size.h                                  |    1 
 10 files changed, 552 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/ndctl/ndctl-read-infoblock.txt

diff --git a/Documentation/ndctl/Makefile.am b/Documentation/ndctl/Makefile.am
index fb46d7c87938..ef22f6de390e 100644
--- a/Documentation/ndctl/Makefile.am
+++ b/Documentation/ndctl/Makefile.am
@@ -55,7 +55,8 @@ man1_MANS = \
 	ndctl-freeze-security.1 \
 	ndctl-sanitize-dimm.1 \
 	ndctl-load-keys.1 \
-	ndctl-wait-overwrite.1
+	ndctl-wait-overwrite.1 \
+	ndctl-read-infoblock.1
 
 CLEANFILES = $(man1_MANS)
 
diff --git a/Documentation/ndctl/ndctl-read-infoblock.txt b/Documentation/ndctl/ndctl-read-infoblock.txt
new file mode 100644
index 000000000000..92ae95befd38
--- /dev/null
+++ b/Documentation/ndctl/ndctl-read-infoblock.txt
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+ndctl-read-infoblock(1)
+=======================
+
+NAME
+----
+ndctl-read-infoblock - read and optionally parse the info-block a namespace
+
+SYNOPSIS
+--------
+[verse]
+'ndctl read-infoblock' <namespace0.0> [<namespace1.0>..<namespaceN.Y>] [<options>]
+
+DESCRIPTION
+-----------
+As described in the theory of operation section of
+linkndctl:ndctl-create-namespace[1], the raw capacity of a namespace may
+encapsulate a personality, or mode of operation. Specifically, the mode
+may be set to one of "sector", "fsdax", and "devdax". Each of those
+modes is defined by an info-block format that uniquely identifies the
+mode of operation. The read-infoblock command knows the location
+(relative to the start of the namespace) and field definition of those
+data structures.
+
+Note that unlike a partition table info-block is not exposed by default,
+so the namespace needs to be disabled before the info-block can be
+accessed.
+
+EXAMPLE
+-------
+
+[verse]
+# ndctl disable-namespace namespace0.0
+disabled 1 namespace
+# ndctl read-infoblock -j namespace0.0
+[
+  {
+    "dev":"namespace0.0",
+    "signature":"NVDIMM_PFN_INFO",
+    "uuid":"56b11990-66b1-4d91-9cac-ca084c051259",
+    "parent_uuid":"00000000-0000-0000-0000-000000000000",
+    "flags":0,
+    "version":"1.3",
+    "dataoff":69206016,
+    "npfns":1031680,
+    "mode":2,
+    "start_pad":0,
+    "end_trunc":0,
+    "align":2097152
+  }
+]
+
+
+OPTIONS
+-------
+<namespace(s)>::
+	One or more 'namespaceX.Y' device names. The keyword 'all' can be specified to
+	operate on every namespace in the system, optionally filtered by bus id (see
+        --bus= option), or region id (see --region= option).
+
+-V::
+--verify::
+	Attempt to validate that the info-block is self consistent by
+	validating the embedded checksum, and that info-block formats
+	that contain a 'parent-uuid' attribute also match the base-uuid
+	of the namespace.
+
+-o::
+--output::
+	Output file
+
+-j::
+--json::
+	Parse the info-block data into json.
+-u::
+--human::
+	Enable json output and convert number formats to human readable
+	strings, for example show the size in terms of "KB", "MB", "GB", etc
+	instead of a signed 64-bit numbers per the JSON interchange
+	format (implies --json).
+
+-r::
+--region=::
+include::xable-region-options.txt[]
+
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkndctl:ndctl-create-namespace[1],
+http://www.uefi.org/sites/default/files/resources/UEFI_Spec_2_7.pdf[UEFI NVDIMM Label Protocol]
+
diff --git a/ndctl/action.h b/ndctl/action.h
index 50da010ae826..636524c01f20 100644
--- a/ndctl/action.h
+++ b/ndctl/action.h
@@ -14,5 +14,6 @@ enum device_action {
 	ACTION_WAIT,
 	ACTION_START,
 	ACTION_CLEAR,
+	ACTION_READ_INFOBLOCK,
 };
 #endif /* __NDCTL_ACTION_H__ */
diff --git a/ndctl/builtin.h b/ndctl/builtin.h
index 94ab3177e9b6..aa41ad01a84c 100644
--- a/ndctl/builtin.h
+++ b/ndctl/builtin.h
@@ -8,6 +8,7 @@ int cmd_create_nfit(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_enable_namespace(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_create_namespace(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_destroy_namespace(int argc, const char **argv, struct ndctl_ctx *ctx);
+int cmd_read_infoblock(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_disable_namespace(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_check_namespace(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_clear_errors(int argc, const char **argv, struct ndctl_ctx *ctx);
diff --git a/ndctl/check.c b/ndctl/check.c
index 8a7125053865..3b384c091af5 100644
--- a/ndctl/check.c
+++ b/ndctl/check.c
@@ -297,24 +297,6 @@ static int btt_log_read(struct arena_info *a, u32 lane, struct log_entry *ent)
 	return 0;
 }
 
-static int btt_checksum_verify(struct btt_sb *btt_sb)
-{
-	uint64_t sum;
-	le64 sum_save;
-
-	BUILD_BUG_ON(sizeof(struct btt_sb) != SZ_4K);
-
-	sum_save = btt_sb->checksum;
-	btt_sb->checksum = 0;
-	sum = fletcher64(btt_sb, sizeof(*btt_sb), 1);
-	if (sum != sum_save)
-		return 1;
-	/* restore the checksum in the buffer */
-	btt_sb->checksum = sum_save;
-
-	return 0;
-}
-
 /*
  * Never pass a mmapped buffer to this as it will attempt to write to
  * the buffer, and we want writes to only happened in a controlled fashion.
@@ -330,7 +312,7 @@ static int btt_info_verify(struct btt_chk *bttc, struct btt_sb *btt_sb)
 		if (uuid_compare(bttc->parent_uuid, btt_sb->parent_uuid) != 0)
 			return -ENXIO;
 
-	if (btt_checksum_verify(btt_sb))
+	if (!verify_infoblock_checksum((union info_block *) btt_sb))
 		return -ENXIO;
 
 	return 0;
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 58a9e3c53474..9eec313c2d5b 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -21,6 +21,7 @@
 
 #include <ndctl.h>
 #include "action.h"
+#include "namespace.h"
 #include <sys/stat.h>
 #include <uuid/uuid.h>
 #include <sys/types.h>
@@ -41,6 +42,9 @@ static struct parameters {
 	bool do_scan;
 	bool mode_default;
 	bool autolabel;
+	bool verify;
+	bool human;
+	bool json;
 	const char *bus;
 	const char *map;
 	const char *type;
@@ -52,6 +56,8 @@ static struct parameters {
 	const char *reconfig;
 	const char *sector_size;
 	const char *align;
+	const char *outfile;
+	const char *infile;
 } param = {
 	.autolabel = true,
 };
@@ -80,6 +86,13 @@ struct parsed_parameters {
 	bool autolabel;
 };
 
+#define pr_verbose(fmt, ...) \
+	({if (verbose) { \
+		fprintf(stderr, fmt, ##__VA_ARGS__); \
+	} else { \
+		do { } while (0); \
+	}})
+
 #define debug(fmt, ...) \
 	({if (verbose) { \
 		fprintf(stderr, "%s:%d: " fmt, __func__, __LINE__, ##__VA_ARGS__); \
@@ -124,6 +137,16 @@ OPT_BOOLEAN('f', "force", &force, "check namespace even if currently active")
 #define CLEAR_OPTIONS() \
 OPT_BOOLEAN('s', "scrub", &scrub, "run a scrub to find latent errors")
 
+#define READ_INFOBLOCK_OPTIONS() \
+OPT_FILENAME('o', "output", &param.outfile, "output-file", \
+	"filename to write info-block contents"), \
+OPT_FILENAME('i', "input", &param.infile, "input-file", \
+	"filename to read info-block instead of a namespace"), \
+OPT_BOOLEAN('V', "verify", &param.verify, \
+	"validate parent uuid, and info-block checksum" ), \
+OPT_BOOLEAN('j', "json", &param.json, "parse label data into json"), \
+OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats (implies --json)")
+
 static const struct option base_options[] = {
 	BASE_OPTIONS(),
 	OPT_END(),
@@ -154,6 +177,12 @@ static const struct option clear_options[] = {
 	OPT_END(),
 };
 
+static const struct option read_infoblock_options[] = {
+	BASE_OPTIONS(),
+	READ_INFOBLOCK_OPTIONS(),
+	OPT_END(),
+};
+
 static int set_defaults(enum device_action mode)
 {
 	int rc = 0;
@@ -298,18 +327,30 @@ static const char *parse_namespace_options(int argc, const char **argv,
 			case ACTION_CLEAR:
 				action_string = "clear errors for";
 				break;
+			case ACTION_READ_INFOBLOCK:
+				action_string = "read-infoblock";
+				break;
 			default:
 				action_string = "<>";
 				break;
 		}
-		error("specify a namespace to %s, or \"all\"\n", action_string);
-		rc = -EINVAL;
+
+		if ((mode == ACTION_READ_INFOBLOCK && !param.infile)
+				|| mode != ACTION_READ_INFOBLOCK) {
+			error("specify a namespace to %s, or \"all\"\n", action_string);
+			rc = -EINVAL;
+		}
 	}
 	for (i = mode == ACTION_CREATE ? 0 : 1; i < argc; i++) {
 		error("unknown extra parameter \"%s\"\n", argv[i]);
 		rc = -EINVAL;
 	}
 
+	if (mode == ACTION_READ_INFOBLOCK && param.infile && argc) {
+		error("specify a namespace, or --file, not both\n");
+		rc = -EINVAL;
+	}
+
 	if (rc) {
 		usage_with_options(u, options);
 		return NULL; /* we won't return from usage_with_options() */
@@ -1313,10 +1354,319 @@ static int namespace_clear_bb(struct ndctl_namespace *ndns)
 	return 0;
 }
 
+struct read_infoblock_ctx {
+	struct json_object *jblocks;
+	FILE *f_out;
+};
+
+#define parse_field(sb, field)						\
+	jobj = json_object_new_int(le32_to_cpu((sb)->field));		\
+	if (!jobj)							\
+		goto err;						\
+	json_object_object_add(jblock, #field, jobj);
+
+#define parse_hex(sb, field, sz)						\
+	jobj = util_json_object_hex(le##sz##_to_cpu((sb)->field), flags);	\
+	if (!jobj)								\
+		goto err;							\
+	json_object_object_add(jblock, #field, jobj);
+
+
+static json_object *btt_parse(struct btt_sb *btt_sb, struct ndctl_namespace *ndns,
+		const char *path, unsigned long flags)
+{
+	uuid_t uuid;
+	char str[40];
+	struct json_object *jblock, *jobj;
+	const char *cmd = "read-info-block";
+	const bool verify = param.verify;
+
+	if (verify && !verify_infoblock_checksum((union info_block *) btt_sb)) {
+		pr_verbose("%s: %s checksum verification failed\n", cmd, __func__);
+		return NULL;
+	}
+
+	if (ndns) {
+		ndctl_namespace_get_uuid(ndns, uuid);
+		if (verify && !uuid_is_null(uuid) && memcmp(uuid, btt_sb->parent_uuid,
+					sizeof(uuid) != 0)) {
+			pr_verbose("%s: %s uuid verification failed\n", cmd, __func__);
+			return NULL;
+		}
+	}
+
+	jblock = json_object_new_object();
+	if (!jblock)
+		return NULL;
+
+	if (ndns) {
+		jobj = json_object_new_string(ndctl_namespace_get_devname(ndns));
+		if (!jobj)
+			goto err;
+		json_object_object_add(jblock, "dev", jobj);
+	} else {
+		jobj = json_object_new_string(path);
+		if (!jobj)
+			goto err;
+		json_object_object_add(jblock, "file", jobj);
+	}
+
+	jobj = json_object_new_string((char *) btt_sb->signature);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jblock, "signature", jobj);
+
+	uuid_unparse((void *) btt_sb->uuid, str);
+	jobj = json_object_new_string(str);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jblock, "uuid", jobj);
+
+	uuid_unparse((void *) btt_sb->parent_uuid, str);
+	jobj = json_object_new_string(str);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jblock, "parent_uuid", jobj);
+
+	jobj = util_json_object_hex(le32_to_cpu(btt_sb->flags), flags);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jblock, "flags", jobj);
+
+	if (snprintf(str, 4, "%d.%d", btt_sb->version_major,
+				btt_sb->version_minor) >= 4)
+		goto err;
+	jobj = json_object_new_string(str);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jblock, "version", jobj);
+
+	parse_field(btt_sb, external_lbasize);
+	parse_field(btt_sb, external_nlba);
+	parse_field(btt_sb, internal_lbasize);
+	parse_field(btt_sb, internal_nlba);
+	parse_field(btt_sb, nfree);
+	parse_field(btt_sb, infosize);
+	parse_hex(btt_sb, nextoff, 64);
+	parse_hex(btt_sb, dataoff, 64);
+	parse_hex(btt_sb, mapoff, 64);
+	parse_hex(btt_sb, logoff, 64);
+	parse_hex(btt_sb, info2off, 64);
+
+	return jblock;
+err:
+	pr_verbose("%s: failed to create json representation\n", cmd);
+	json_object_put(jblock);
+	return NULL;
+}
+
+static json_object *pfn_parse(struct pfn_sb *pfn_sb, struct ndctl_namespace *ndns,
+		const char *path, unsigned long flags)
+{
+	uuid_t uuid;
+	char str[40];
+	struct json_object *jblock, *jobj;
+	const char *cmd = "read-info-block";
+	const bool verify = param.verify;
+
+	if (verify && !verify_infoblock_checksum((union info_block *) pfn_sb)) {
+		pr_verbose("%s: %s checksum verification failed\n", cmd, __func__);
+		return NULL;
+	}
+
+	if (ndns) {
+		ndctl_namespace_get_uuid(ndns, uuid);
+		if (verify && !uuid_is_null(uuid) && memcmp(uuid, pfn_sb->parent_uuid,
+					sizeof(uuid) != 0)) {
+			pr_verbose("%s: %s uuid verification failed\n", cmd, __func__);
+			return NULL;
+		}
+	}
+
+	jblock = json_object_new_object();
+	if (!jblock)
+		return NULL;
+
+	if (ndns) {
+		jobj = json_object_new_string(ndctl_namespace_get_devname(ndns));
+		if (!jobj)
+			goto err;
+		json_object_object_add(jblock, "dev", jobj);
+	} else {
+		jobj = json_object_new_string(path);
+		if (!jobj)
+			goto err;
+		json_object_object_add(jblock, "file", jobj);
+	}
+
+	jobj = json_object_new_string((char *) pfn_sb->signature);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jblock, "signature", jobj);
+
+	uuid_unparse((void *) pfn_sb->uuid, str);
+	jobj = json_object_new_string(str);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jblock, "uuid", jobj);
+
+	uuid_unparse((void *) pfn_sb->parent_uuid, str);
+	jobj = json_object_new_string(str);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jblock, "parent_uuid", jobj);
+
+	jobj = util_json_object_hex(le32_to_cpu(pfn_sb->flags), flags);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jblock, "flags", jobj);
+
+	if (snprintf(str, 4, "%d.%d", pfn_sb->version_major,
+				pfn_sb->version_minor) >= 4)
+		goto err;
+	jobj = json_object_new_string(str);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jblock, "version", jobj);
+
+	parse_hex(pfn_sb, dataoff, 64);
+	parse_hex(pfn_sb, npfns, 64);
+	parse_field(pfn_sb, mode);
+	parse_hex(pfn_sb, start_pad, 32);
+	parse_hex(pfn_sb, end_trunc, 32);
+	parse_hex(pfn_sb, align, 32);
+
+	return jblock;
+err:
+	pr_verbose("%s: failed to create json representation\n", cmd);
+	json_object_put(jblock);
+	return NULL;
+}
+
+#define INFOBLOCK_SZ SZ_8K
+
+static int parse_namespace_infoblock(char *_buf, struct ndctl_namespace *ndns,
+		const char *path, struct read_infoblock_ctx *ri_ctx)
+{
+	int rc;
+	void *buf = _buf;
+	unsigned long flags = param.human ? UTIL_JSON_HUMAN : 0;
+	struct btt_sb *btt1_sb = buf + SZ_4K, *btt2_sb = buf;
+	struct json_object *jblock = NULL, *jblocks = ri_ctx->jblocks;
+	struct pfn_sb *pfn_sb = buf + SZ_4K, *dax_sb = buf + SZ_4K;
+
+	if (!param.json && !param.human) {
+		rc = fwrite(buf, 1, INFOBLOCK_SZ, ri_ctx->f_out);
+		if (rc != INFOBLOCK_SZ)
+			return -EIO;
+		fflush(ri_ctx->f_out);
+		return 0;
+	}
+
+	if (!jblocks) {
+		jblocks = json_object_new_array();
+		if (!jblocks)
+			return -ENOMEM;
+		ri_ctx->jblocks = jblocks;
+	}
+
+	if (memcmp(btt1_sb->signature, BTT_SIG, BTT_SIG_LEN) == 0) {
+		jblock = btt_parse(btt1_sb, ndns, path, flags);
+		if (jblock)
+			json_object_array_add(jblocks, jblock);
+	}
+
+	if (memcmp(btt2_sb->signature, BTT_SIG, BTT_SIG_LEN) == 0) {
+		jblock = btt_parse(btt2_sb, ndns, path, flags);
+		if (jblock)
+			json_object_array_add(jblocks, jblock);
+	}
+
+	if (memcmp(pfn_sb->signature, PFN_SIG, PFN_SIG_LEN) == 0) {
+		jblock = pfn_parse(pfn_sb, ndns, path, flags);
+		if (jblock)
+			json_object_array_add(jblocks, jblock);
+	}
+
+	if (memcmp(dax_sb->signature, DAX_SIG, PFN_SIG_LEN) == 0) {
+		jblock = pfn_parse(dax_sb, ndns, path, flags);
+		if (jblock)
+			json_object_array_add(jblocks, jblock);
+	}
+
+	return 0;
+}
+
+static int file_read_infoblock(const char *path, struct ndctl_namespace *ndns,
+		struct read_infoblock_ctx *ri_ctx)
+{
+	const char *devname = ndns ? ndctl_namespace_get_devname(ndns) : "";
+	const char *cmd = "read-info-block";
+	void *buf = NULL;
+	int fd = -1, rc;
+
+	buf = calloc(1, INFOBLOCK_SZ);
+	if (!buf)
+		return -ENOMEM;
+
+	fd = open(path, O_RDONLY|O_EXCL);
+	if (fd < 0) {
+		pr_verbose("%s: %s failed to open %s: %s\n",
+				cmd, devname, path, strerror(errno));
+		rc = -errno;
+		goto out;
+	}
+
+	rc = read(fd, buf, INFOBLOCK_SZ);
+	if (rc < 0) {
+		pr_verbose("%s: %s failed to read %s: %s\n",
+				cmd, devname, path, strerror(errno));
+		rc = -errno;
+		goto out;
+	}
+
+	rc = parse_namespace_infoblock(buf, ndns, path, ri_ctx);
+out:
+	free(buf);
+	if (fd >= 0)
+		close(fd);
+	return rc;
+}
+
+static int namespace_read_infoblock(struct ndctl_namespace *ndns,
+		struct read_infoblock_ctx *ri_ctx)
+{
+	int rc;
+	char path[50];
+	const char *cmd = "read-info-block";
+	const char *devname = ndctl_namespace_get_devname(ndns);
+
+	if (ndctl_namespace_is_active(ndns)) {
+		pr_verbose("%s: %s enabled, must be disabled\n", cmd, devname);
+		return -EBUSY;
+	}
+
+	ndctl_namespace_set_raw_mode(ndns, 1);
+	rc = ndctl_namespace_enable(ndns);
+	if (rc < 0) {
+		pr_verbose("%s: %s failed to enable\n", cmd, devname);
+		goto out;
+	}
+
+	sprintf(path, "/dev/%s", ndctl_namespace_get_block_device(ndns));
+	rc = file_read_infoblock(path, ndns, ri_ctx);
+
+out:
+	ndctl_namespace_set_raw_mode(ndns, 0);
+	ndctl_namespace_disable_invalidate(ndns);
+	return rc;
+}
+
 static int do_xaction_namespace(const char *namespace,
 		enum device_action action, struct ndctl_ctx *ctx,
 		int *processed)
 {
+	struct read_infoblock_ctx ri_ctx = { 0 };
 	struct ndctl_namespace *ndns, *_n;
 	struct ndctl_region *region;
 	const char *ndns_name;
@@ -1325,6 +1675,26 @@ static int do_xaction_namespace(const char *namespace,
 
 	*processed = 0;
 
+	if (action == ACTION_READ_INFOBLOCK) {
+		if (!param.outfile)
+			ri_ctx.f_out = stdout;
+		else {
+			ri_ctx.f_out = fopen(param.outfile, "w+");
+			if (!ri_ctx.f_out) {
+				fprintf(stderr, "failed to open: %s: (%s)\n",
+						param.outfile, strerror(errno));
+				return -errno;
+			}
+		}
+
+		if (param.infile) {
+			rc = file_read_infoblock(param.infile, NULL, &ri_ctx);
+			if (ri_ctx.jblocks)
+				util_display_json_array(ri_ctx.f_out, ri_ctx.jblocks, 0);
+			return rc;
+		}
+	}
+
 	if (!namespace && action != ACTION_CREATE)
 		return rc;
 
@@ -1403,6 +1773,11 @@ static int do_xaction_namespace(const char *namespace,
 					if (rc == 0)
 						*processed = 1;
 					return rc;
+				case ACTION_READ_INFOBLOCK:
+					rc = namespace_read_infoblock(ndns, &ri_ctx);
+					if (rc == 0)
+						(*processed)++;
+					break;
 				default:
 					rc = -EINVAL;
 					break;
@@ -1411,6 +1786,12 @@ static int do_xaction_namespace(const char *namespace,
 		}
 	}
 
+	if (ri_ctx.jblocks)
+		util_display_json_array(ri_ctx.f_out, ri_ctx.jblocks, 0);
+
+	if (ri_ctx.f_out && ri_ctx.f_out != stdout)
+		fclose(ri_ctx.f_out);
+
 	return rc;
 }
 
@@ -1523,3 +1904,19 @@ int cmd_clear_errors(int argc , const char **argv, struct ndctl_ctx *ctx)
 			cleared == 1 ? "" : "s");
 	return rc;
 }
+
+int cmd_read_infoblock(int argc , const char **argv, struct ndctl_ctx *ctx)
+{
+	char *xable_usage = "ndctl read-info-block <namespace> [<options>]";
+	const char *namespace = parse_namespace_options(argc, argv,
+			ACTION_READ_INFOBLOCK, read_infoblock_options,
+			xable_usage);
+	int read, rc;
+
+	rc = do_xaction_namespace(namespace, ACTION_READ_INFOBLOCK, ctx, &read);
+	if (rc < 0)
+		fprintf(stderr, "error checking namespaces: %s\n",
+				strerror(-rc));
+	fprintf(stderr, "read %d namespace%s\n", read, read == 1 ? "" : "s");
+	return rc;
+}
diff --git a/ndctl/namespace.h b/ndctl/namespace.h
index bc210857642f..861dfbfa5127 100644
--- a/ndctl/namespace.h
+++ b/ndctl/namespace.h
@@ -13,7 +13,9 @@
 #ifndef __NDCTL_NAMESPACE_H__
 #define __NDCTL_NAMESPACE_H__
 #include <sys/types.h>
+#include <util/util.h>
 #include <util/size.h>
+#include <util/fletcher.h>
 #include <ccan/endian/endian.h>
 #include <ccan/short_types/short_types.h>
 
@@ -202,4 +204,53 @@ struct arena_map {
 	struct btt_sb *info2;
 	size_t info2_len;
 };
+
+#define PFN_SIG_LEN 16
+#define PFN_SIG "NVDIMM_PFN_INFO\0"
+#define DAX_SIG "NVDIMM_DAX_INFO\0"
+
+struct pfn_sb {
+	u8 signature[PFN_SIG_LEN];
+	u8 uuid[16];
+	u8 parent_uuid[16];
+	le32 flags;
+	le16 version_major;
+	le16 version_minor;
+	le64 dataoff; /* relative to namespace_base + start_pad */
+	le64 npfns;
+	le32 mode;
+	/* minor-version-1 additions for section alignment */
+	le32 start_pad;
+	le32 end_trunc;
+	/* minor-version-2 record the base alignment of the mapping */
+	le32 align;
+	u8 padding[4000];
+	le64 checksum;
+};
+
+union info_block {
+	struct pfn_sb pfn_sb;
+	struct btt_sb btt_sb;
+};
+
+static inline bool verify_infoblock_checksum(union info_block *sb)
+{
+	uint64_t sum;
+	le64 sum_save;
+
+	BUILD_BUG_ON(sizeof(union info_block) != SZ_4K);
+
+	/* all infoblocks share the btt_sb layout for checksum */
+	sum_save = sb->btt_sb.checksum;
+	sb->btt_sb.checksum = 0;
+	sum = fletcher64(&sb->btt_sb, sizeof(*sb), 1);
+	if (sum != sum_save)
+		return false;
+	/* restore the checksum in the buffer */
+	sb->btt_sb.checksum = sum_save;
+
+	return true;
+}
+
+
 #endif /* __NDCTL_NAMESPACE_H__ */
diff --git a/ndctl/ndctl.c b/ndctl/ndctl.c
index 6c4975c9f841..5c9c424dcae6 100644
--- a/ndctl/ndctl.c
+++ b/ndctl/ndctl.c
@@ -73,6 +73,7 @@ static struct cmd_struct commands[] = {
 	{ "disable-namespace", { cmd_disable_namespace } },
 	{ "create-namespace", { cmd_create_namespace } },
 	{ "destroy-namespace", { cmd_destroy_namespace } },
+	{ "read-infoblock",  { cmd_read_infoblock } },
 	{ "check-namespace", { cmd_check_namespace } },
 	{ "clear-errors", { cmd_clear_errors } },
 	{ "enable-region", { cmd_enable_region } },
diff --git a/util/fletcher.h b/util/fletcher.h
index 54e2ecf5d6ed..8fccac4ec758 100644
--- a/util/fletcher.h
+++ b/util/fletcher.h
@@ -1,6 +1,7 @@
 #ifndef _NDCTL_FLETCHER_H_
 #define _NDCTL_FLETCHER_H_
 
+#include <stdbool.h>
 #include <ccan/endian/endian.h>
 #include <ccan/short_types/short_types.h>
 
diff --git a/util/size.h b/util/size.h
index 34fac58d6945..2426fef74b3c 100644
--- a/util/size.h
+++ b/util/size.h
@@ -16,6 +16,7 @@
 
 #define SZ_1K     0x00000400
 #define SZ_4K     0x00001000
+#define SZ_8K     0x00002000
 #define SZ_1M     0x00100000
 #define SZ_2M     0x00200000
 #define SZ_4M     0x00400000

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

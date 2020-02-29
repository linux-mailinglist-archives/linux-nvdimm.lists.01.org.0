Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2492317495B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:39:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 769D510FC36FD;
	Sat, 29 Feb 2020 12:39:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0316710FC36EE
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:39:56 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:39:05 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="239110278"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:39:05 -0800
Subject: [ndctl PATCH 33/36] ndctl/namespace: Add write-infoblock command
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:23:00 -0800
Message-ID: <158300778023.2141307.16415851051494438969.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: OG5KHENJNMA5VPF637AURYVIMA6DDGEA
X-Message-ID-Hash: OG5KHENJNMA5VPF637AURYVIMA6DDGEA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OG5KHENJNMA5VPF637AURYVIMA6DDGEA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a tool that can generate infoblock images for fsdax and devdax mode
namespaces. The motivation for this tool is to be able to test namespace
alignment corner cases, or enable persistent memory namespace images to be
provisioned outside of the driver for a deployment, for example, inside a
virtual-machine guest.

The tool can optionally write to an existing namespace, a regular file,
or stdout.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/Makefile.am               |    3 
 Documentation/ndctl/ndctl-write-infoblock.txt |  132 ++++++++++
 ndctl/action.h                                |    1 
 ndctl/builtin.h                               |    1 
 ndctl/namespace.c                             |  327 ++++++++++++++++++++++++-
 ndctl/ndctl.c                                 |    1 
 6 files changed, 451 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ndctl/ndctl-write-infoblock.txt

diff --git a/Documentation/ndctl/Makefile.am b/Documentation/ndctl/Makefile.am
index a5b20715fa9b..b8e239107ff9 100644
--- a/Documentation/ndctl/Makefile.am
+++ b/Documentation/ndctl/Makefile.am
@@ -56,7 +56,8 @@ man1_MANS = \
 	ndctl-sanitize-dimm.1 \
 	ndctl-load-keys.1 \
 	ndctl-wait-overwrite.1 \
-	ndctl-read-infoblock.1
+	ndctl-read-infoblock.1 \
+	ndctl-write-infoblock.1
 
 EXTRA_DIST = $(man1_MANS)
 
diff --git a/Documentation/ndctl/ndctl-write-infoblock.txt b/Documentation/ndctl/ndctl-write-infoblock.txt
new file mode 100644
index 000000000000..8197559f1c49
--- /dev/null
+++ b/Documentation/ndctl/ndctl-write-infoblock.txt
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+
+ndctl-write-infoblock(1)
+========================
+
+NAME
+----
+ndctl-write-infoblock - generate and write an infoblock
+
+SYNOPSIS
+--------
+[verse]
+'ndctl write-infoblock' [<namespaceX.Y> | -o <file> | --stdout] [<options>]
+
+DESCRIPTION
+-----------
+As described in the theory of operation section of
+linkndctl:ndctl-create-namespace[1], the raw capacity of a namespace may
+encapsulate a personality, or mode of operation. Specifically, the mode
+may be set to one of "sector", "fsdax", and "devdax". Each of those
+modes is defined by an info-block format that uniquely identifies the
+mode of operation. The write-infoblock command knows how to generate an
+"fsdax" or "devdax" info-block relative to the specified image size.
+
+The generated block can be written to an existing namespace (provided
+that namespace is not presently active), written to a file, or piped to
+standard-out.
+
+WARNING: This command is a debug facility that can generate image files
+with valid infoblocks, but also invalid infoblocks for testing the
+kernel. Use the --offset and --align options with care. Namely --offset
+must match the actual physical address offset of the namespace it is
+applied to, and --align must be one of the architectures supported page
+sizes.
+
+EXAMPLE
+-------
+
+[verse]
+ndctl write-infoblock -s 1T -c | ndctl read-infoblock -j
+wrote 1 infoblock
+[
+  {
+    "file":"<stdin>",
+    "signature":"NVDIMM_PFN_INFO",
+    "uuid":"42e1d574-76ac-402c-9132-5436e31528c0",
+    "parent_uuid":"ef83e49c-4c4a-4fae-b908-72e94675b1b7",
+    "flags":0,
+    "version":"1.4",
+    "dataoff":17196646400,
+    "npfns":264237056,
+    "mode":2,
+    "start_pad":0,
+    "end_trunc":0,
+    "align":16777216,
+    "page_size":4096,
+    "page_struct_size":64
+  }
+]
+read 1 infoblock
+
+OPTIONS
+-------
+<namespace(s)>::
+	One or more 'namespaceX.Y' device names. The keyword 'all' can be specified to
+	operate on every namespace in the system, optionally filtered by bus id (see
+        --bus= option), or region id (see --region= option).
+
+-c::
+--stdout::
+	Write the infoblock to stdout
+
+-o::
+--output=::
+	Write the infoblock to the given file (mutually
+	exclusive with --stdout).
+
+-m::
+--mode=::
+	Select the infoblock mode between 'fsdax' and 'devdax'. See
+	linkndctl:ndctl-create-namespace[1] for details on --mode.
+
+-s::
+--size=::
+	Override the default size determined from the size of the file
+	specified to --output. In the --stdout case, this option is
+	required.
+
+-a::
+--align=::
+	Specify the "align" value in the infoblock. In the --mode=devdax
+	case "align" designates a page mapping size. There is no
+	validation of this value relative to the page mapping
+	capabilities of the platform.
+
+-u::
+--uuid=::
+	Override the default autogenerated UUID with the given
+	value.
+
+-M::
+--map=::
+	Select whether the page map array is allocated from the
+	device or from "System RAM". Defaults to the device. See
+	linkndctl:ndctl-create-namespace[1] for more details.
+
+-p::
+--parent-uuid=::
+	When the infoblock is stored on a labelled namespace the UUID of
+	the namespace must match the "parent uuid" attribute in the
+	infoblock. This option defaults to the UUID of the namespace
+	when --output and --stdout are not used, otherwise it defaults
+	to a NULL UUID (all zeroes).
+
+-O::
+--offset=::
+	By default the assumption is that the infoblock is being written
+	to a namespace or namespace-image that is aligned to its size.
+	Specify this EXPERT/DEBUG option to experiment / test the
+	kernel's handling of namespaces that violate that assumption.
+
+-r::
+--region=::
+include::xable-region-options.txt[]
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkndctl:ndctl-create-namespace[1],
+http://www.uefi.org/sites/default/files/resources/UEFI_Spec_2_7.pdf[UEFI NVDIMM Label Protocol]
+
diff --git a/ndctl/action.h b/ndctl/action.h
index 636524c01f20..bcf6bf3196c6 100644
--- a/ndctl/action.h
+++ b/ndctl/action.h
@@ -15,5 +15,6 @@ enum device_action {
 	ACTION_START,
 	ACTION_CLEAR,
 	ACTION_READ_INFOBLOCK,
+	ACTION_WRITE_INFOBLOCK,
 };
 #endif /* __NDCTL_ACTION_H__ */
diff --git a/ndctl/builtin.h b/ndctl/builtin.h
index aa41ad01a84c..8aeada86c1a7 100644
--- a/ndctl/builtin.h
+++ b/ndctl/builtin.h
@@ -9,6 +9,7 @@ int cmd_enable_namespace(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_create_namespace(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_destroy_namespace(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_read_infoblock(int argc, const char **argv, struct ndctl_ctx *ctx);
+int cmd_write_infoblock(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_disable_namespace(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_check_namespace(int argc, const char **argv, struct ndctl_ctx *ctx);
 int cmd_clear_errors(int argc, const char **argv, struct ndctl_ctx *ctx);
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 7bfc7d1ab61d..21252b6afe50 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -23,7 +23,9 @@
 #include "action.h"
 #include "namespace.h"
 #include <sys/stat.h>
+#include <linux/fs.h>
 #include <uuid/uuid.h>
+#include <sys/ioctl.h>
 #include <sys/types.h>
 #include <util/size.h>
 #include <util/json.h>
@@ -47,6 +49,7 @@ static struct parameters {
 	bool autorecover;
 	bool human;
 	bool json;
+	bool std_out;
 	const char *bus;
 	const char *map;
 	const char *type;
@@ -58,8 +61,10 @@ static struct parameters {
 	const char *reconfig;
 	const char *sector_size;
 	const char *align;
+	const char *offset;
 	const char *outfile;
 	const char *infile;
+	const char *parent_uuid;
 } param = {
 	.autolabel = true,
 	.autorecover = true,
@@ -160,6 +165,26 @@ OPT_BOOLEAN('V', "verify", &param.verify, \
 OPT_BOOLEAN('j', "json", &param.json, "parse label data into json"), \
 OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats (implies --json)")
 
+#define WRITE_INFOBLOCK_OPTIONS() \
+OPT_FILENAME('o', "output", &param.outfile, "output-file", \
+	"filename to write infoblock contents"), \
+OPT_BOOLEAN('c', "stdout", &param.std_out, \
+	"write the infoblock data to stdout"), \
+OPT_STRING('m', "mode", &param.mode, "operation-mode", \
+	"specify the infoblock mode, 'fsdax' or 'devdax' (default 'fsdax')"), \
+OPT_STRING('s', "size", &param.size, "size", \
+	"override the image size to instantiate the infoblock"), \
+OPT_STRING('a', "align", &param.align, "align", \
+	"specify the expected physical alignment (default: 2M)"), \
+OPT_STRING('u', "uuid", &param.uuid, "uuid", \
+	"specify the uuid for the infoblock (default: autogenerate)"), \
+OPT_STRING('M', "map", &param.map, "memmap-location", \
+	"specify 'mem' or 'dev' for the location of the memmap"), \
+OPT_STRING('p', "parent-uuid", &param.parent_uuid, "parent-uuid", \
+	"specify the parent namespace uuid for the infoblock (default: 0)"), \
+OPT_STRING('O', "offset", &param.offset, "offset", \
+	"EXPERT/DEBUG only: enable namespace inner alignment padding")
+
 static const struct option base_options[] = {
 	BASE_OPTIONS(),
 	OPT_END(),
@@ -196,8 +221,15 @@ static const struct option read_infoblock_options[] = {
 	OPT_END(),
 };
 
+static const struct option write_infoblock_options[] = {
+	BASE_OPTIONS(),
+	WRITE_INFOBLOCK_OPTIONS(),
+	OPT_END(),
+};
+
 static int set_defaults(enum device_action action)
 {
+	uuid_t uuid;
 	int rc = 0;
 
 	if (param.type) {
@@ -214,10 +246,25 @@ static int set_defaults(enum device_action action)
 		param.type = "pmem";
 
 	if (param.mode) {
-		if (util_nsmode(param.mode) == NDCTL_NS_MODE_UNKNOWN) {
+		enum ndctl_namespace_mode mode = util_nsmode(param.mode);
+
+		switch (mode) {
+		case NDCTL_NS_MODE_UNKNOWN:
 			error("invalid mode '%s'\n", param.mode);
 			rc = -EINVAL;
+			break;
+		case NDCTL_NS_MODE_FSDAX:
+		case NDCTL_NS_MODE_DEVDAX:
+			break;
+		default:
+			if (action == ACTION_WRITE_INFOBLOCK) {
+				error("unsupported mode '%s'\n", param.mode);
+				rc = -EINVAL;
+			}
+			break;
 		}
+	} else if (action == ACTION_WRITE_INFOBLOCK) {
+		param.mode = "fsdax";
 	} else if (!param.reconfig && param.type) {
 		if (strcmp(param.type, "pmem") == 0)
 			param.mode = "fsdax";
@@ -259,21 +306,59 @@ static int set_defaults(enum device_action action)
 		rc = -EINVAL;
 	}
 
-	if (param.align && parse_size64(param.align) == ULLONG_MAX) {
-		error("failed to parse namespace alignment '%s'\n",
-				param.align);
+	if (param.offset && parse_size64(param.offset) == ULLONG_MAX) {
+		error("failed to parse physical offset'%s'\n",
+				param.offset);
 		rc = -EINVAL;
 	}
 
-	if (param.uuid) {
-		uuid_t uuid;
+	if (param.align) {
+		unsigned long long align = parse_size64(param.align);
+
+		if (align == ULLONG_MAX) {
+			error("failed to parse namespace alignment '%s'\n",
+					param.align);
+			rc = -EINVAL;
+		} else if (!is_power_of_2(align)
+			|| align < (unsigned long long) sysconf(_SC_PAGE_SIZE)) {
+			error("align must be a power-of-2 greater than %ld\n",
+					sysconf(_SC_PAGE_SIZE));
+			rc = -EINVAL;
+		}
+	} else if (action == ACTION_WRITE_INFOBLOCK)
+		param.align = "2M";
+
+	if (param.size) {
+		unsigned long long size = parse_size64(param.size);
+		unsigned long long align = parse_size64(param.align);
+
+		if (size == ULLONG_MAX) {
+			error("failed to parse namespace size '%s'\n",
+					param.size);
+			rc = -EINVAL;
+		} else if (action == ACTION_WRITE_INFOBLOCK
+				&& align < ULLONG_MAX
+				&& !IS_ALIGNED(size, align)) {
+			error("--size=%s not aligned to %s\n", param.size,
+					param.align);
+			rc = -EINVAL;
+		}
+	}
 
+	if (param.uuid) {
 		if (uuid_parse(param.uuid, uuid)) {
 			error("failed to parse uuid: '%s'\n", param.uuid);
 			rc = -EINVAL;
 		}
 	}
 
+	if (param.parent_uuid) {
+		if (uuid_parse(param.parent_uuid, uuid)) {
+			error("failed to parse uuid: '%s'\n", param.parent_uuid);
+			rc = -EINVAL;
+		}
+	}
+
 	if (param.sector_size) {
 		if (parse_size64(param.sector_size) == ULLONG_MAX) {
 			error("invalid sector size: %s\n", param.sector_size);
@@ -329,12 +414,18 @@ static const char *parse_namespace_options(int argc, const char **argv,
 			case ACTION_READ_INFOBLOCK:
 				action_string = "read-infoblock";
 				break;
+			case ACTION_WRITE_INFOBLOCK:
+				action_string = "write-infoblock";
+				break;
 			default:
 				action_string = "<>";
 				break;
 		}
 
-		if (action != ACTION_READ_INFOBLOCK) {
+		if ((action != ACTION_READ_INFOBLOCK
+					&& action != ACTION_WRITE_INFOBLOCK)
+				|| (action == ACTION_WRITE_INFOBLOCK
+					&& !param.outfile && !param.std_out)) {
 			error("specify a namespace to %s, or \"all\"\n", action_string);
 			rc = -EINVAL;
 		}
@@ -349,6 +440,17 @@ static const char *parse_namespace_options(int argc, const char **argv,
 		rc = -EINVAL;
 	}
 
+	if (action == ACTION_WRITE_INFOBLOCK && (param.outfile || param.std_out)
+			&& argc) {
+		error("specify only one of a namespace filter, --output, or --stdout\n");
+		rc = -EINVAL;
+	}
+
+	if (action == ACTION_WRITE_INFOBLOCK && param.std_out && !param.size) {
+		error("--size required with --stdout\n");
+		rc = -EINVAL;
+	}
+
 	if (rc) {
 		usage_with_options(u, options);
 		return NULL; /* we won't return from usage_with_options() */
@@ -1721,12 +1823,172 @@ out:
 	return rc;
 }
 
-static int namespace_read_infoblock(struct ndctl_namespace *ndns,
-		struct read_infoblock_ctx *ri_ctx)
+static unsigned long PHYS_PFN(unsigned long long phys)
+{
+	return phys / sysconf(_SC_PAGE_SIZE);
+}
+
+#define SUBSECTION_SHIFT 21
+#define SUBSECTION_SIZE (1UL << SUBSECTION_SHIFT)
+#define MAX_STRUCT_PAGE_SIZE 64
+
+/* Derived from nd_pfn_init() in kernel version v5.5 */
+static int write_pfn_sb(int fd, unsigned long long size, const char *sig,
+		void *buf)
+{
+	unsigned long npfns, align, pfn_align;
+	struct pfn_sb *pfn_sb = buf + SZ_4K;
+	unsigned long long start, offset;
+	uuid_t uuid, parent_uuid;
+	u32 end_trunc, start_pad;
+	enum pfn_mode mode;
+	u64 checksum;
+	int rc;
+
+	start = parse_size64(param.offset);
+	npfns = PHYS_PFN(size - SZ_8K);
+	pfn_align = parse_size64(param.align);
+	align = max(pfn_align, SUBSECTION_SIZE);
+	if (param.uuid)
+		uuid_parse(param.uuid, uuid);
+	else
+		uuid_generate(uuid);
+
+	if (param.parent_uuid)
+		uuid_parse(param.parent_uuid, parent_uuid);
+	else
+		memset(parent_uuid, 0, sizeof(uuid_t));
+
+	if (strcmp(param.map, "dev") == 0)
+		mode = PFN_MODE_PMEM;
+	else
+		mode = PFN_MODE_RAM;
+
+	/*
+	 * Unlike the kernel implementation always set start_pad and
+	 * end_trunc relative to the specified --offset= option to allow
+	 * testing legacy / "buggy" configurations.
+	 */
+	start_pad = ALIGN(start, align) - start;
+	end_trunc = start + size - ALIGN_DOWN(start + size, align);
+	if (mode == PFN_MODE_PMEM) {
+		/*
+		 * The altmap should be padded out to the block size used
+		 * when populating the vmemmap. This *should* be equal to
+		 * PMD_SIZE for most architectures.
+		 *
+		 * Also make sure size of struct page is less than 64. We
+		 * want to make sure we use large enough size here so that
+		 * we don't have a dynamic reserve space depending on
+		 * struct page size. But we also want to make sure we notice
+		 * when we end up adding new elements to struct page.
+		 */
+		offset = ALIGN(start + SZ_8K + MAX_STRUCT_PAGE_SIZE * npfns, align)
+			- start;
+	} else
+		offset = ALIGN(start + SZ_8K, align) - start;
+
+	if (offset >= size) {
+		error("unable to satisfy requested alignment\n");
+		return -ENXIO;
+	}
+
+	npfns = PHYS_PFN(size - offset - end_trunc - start_pad);
+	pfn_sb->mode = cpu_to_le32(mode);
+	pfn_sb->dataoff = cpu_to_le64(offset);
+	pfn_sb->npfns = cpu_to_le64(npfns);
+	memcpy(pfn_sb->signature, sig, PFN_SIG_LEN);
+	memcpy(pfn_sb->uuid, uuid, 16);
+	memcpy(pfn_sb->parent_uuid, parent_uuid, 16);
+	pfn_sb->version_major = cpu_to_le16(1);
+	pfn_sb->version_minor = cpu_to_le16(4);
+	pfn_sb->start_pad = cpu_to_le32(start_pad);
+	pfn_sb->end_trunc = cpu_to_le32(end_trunc);
+	pfn_sb->align = cpu_to_le32(pfn_align);
+	pfn_sb->page_struct_size = cpu_to_le16(MAX_STRUCT_PAGE_SIZE);
+	pfn_sb->page_size = cpu_to_le32(sysconf(_SC_PAGE_SIZE));
+	checksum = fletcher64(pfn_sb, sizeof(*pfn_sb), 0);
+	pfn_sb->checksum = cpu_to_le64(checksum);
+
+	rc = write(fd, buf, INFOBLOCK_SZ);
+	if (rc < INFOBLOCK_SZ)
+		return -EIO;
+	return 0;
+}
+
+static int file_write_infoblock(const char *path)
+{
+	unsigned long long size = parse_size64(param.size);
+	int fd = -1, rc;
+	void *buf;
+
+	if (param.std_out)
+		fd = STDOUT_FILENO;
+	else {
+		fd = open(path, O_CREAT|O_RDWR, 0644);
+		if (fd < 0) {
+			error("failed to open: %s\n", path);
+			return -errno;
+		}
+
+		if (!size) {
+			struct stat st;
+
+			rc = fstat(fd, &st);
+			if (rc < 0) {
+				error("failed to stat: %s\n", path);
+				rc = -errno;
+				goto out;
+			}
+			if (S_ISREG(st.st_mode))
+				size = st.st_size;
+			else if (S_ISBLK(st.st_mode)) {
+				rc = ioctl(fd, BLKGETSIZE64, &size);
+				if (rc < 0) {
+					error("failed to retrieve size: %s\n", path);
+					rc = -errno;
+					goto out;
+				}
+			} else {
+				error("unsupported file type: %s\n", path);
+				rc = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+	buf = calloc(INFOBLOCK_SZ, 1);
+	if (!buf)
+		return -ENOMEM;
+
+	switch (util_nsmode(param.mode)) {
+	case NDCTL_NS_MODE_FSDAX:
+		rc = write_pfn_sb(fd, size, PFN_SIG, buf);
+		break;
+	case NDCTL_NS_MODE_DEVDAX:
+		rc = write_pfn_sb(fd, size, DAX_SIG, buf);
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	free(buf);
+out:
+	if (fd > 0 && fd != STDOUT_FILENO)
+		close(fd);
+	return rc;
+}
+
+static int namespace_rw_infoblock(struct ndctl_namespace *ndns,
+		struct read_infoblock_ctx *ri_ctx, int write)
 {
 	int rc;
+	uuid_t uuid;
+	char str[40];
 	char path[50];
-	const char *cmd = "read-infoblock";
+	const char *save;
+	const char *cmd = write ? "write-infoblock" : "read-infoblock";
 	const char *devname = ndctl_namespace_get_devname(ndns);
 
 	if (ndctl_namespace_is_active(ndns)) {
@@ -1741,9 +2003,19 @@ static int namespace_read_infoblock(struct ndctl_namespace *ndns,
 		goto out;
 	}
 
-	sprintf(path, "/dev/%s", ndctl_namespace_get_block_device(ndns));
-	rc = file_read_infoblock(path, ndns, ri_ctx);
+	save = param.parent_uuid;
+	if (!param.parent_uuid) {
+		ndctl_namespace_get_uuid(ndns, uuid);
+		uuid_unparse(uuid, str);
+		param.parent_uuid = str;
+	}
 
+	sprintf(path, "/dev/%s", ndctl_namespace_get_block_device(ndns));
+	if (write)
+		rc = file_write_infoblock(path);
+	else
+		rc = file_read_infoblock(path, ndns, ri_ctx);
+	param.parent_uuid = save;
 out:
 	ndctl_namespace_set_raw_mode(ndns, 0);
 	ndctl_namespace_disable_invalidate(ndns);
@@ -1785,6 +2057,13 @@ static int do_xaction_namespace(const char *namespace,
 		}
 	}
 
+	if (action == ACTION_WRITE_INFOBLOCK && !namespace) {
+		rc = file_write_infoblock(param.outfile);
+		if (rc >= 0)
+			(*processed)++;
+		return rc;
+	}
+
 	if (!namespace && action != ACTION_CREATE)
 		return rc;
 
@@ -1891,7 +2170,12 @@ static int do_xaction_namespace(const char *namespace,
 						*processed = 1;
 					return rc;
 				case ACTION_READ_INFOBLOCK:
-					rc = namespace_read_infoblock(ndns, &ri_ctx);
+					rc = namespace_rw_infoblock(ndns, &ri_ctx, READ);
+					if (rc == 0)
+						(*processed)++;
+					break;
+				case ACTION_WRITE_INFOBLOCK:
+					rc = namespace_rw_infoblock(ndns, NULL, WRITE);
 					if (rc == 0)
 						(*processed)++;
 					break;
@@ -2057,3 +2341,20 @@ int cmd_read_infoblock(int argc, const char **argv, struct ndctl_ctx *ctx)
 	fprintf(stderr, "read %d infoblock%s\n", read, read == 1 ? "" : "s");
 	return rc;
 }
+
+int cmd_write_infoblock(int argc, const char **argv, struct ndctl_ctx *ctx)
+{
+	char *xable_usage = "ndctl write-infoblock <namespace> [<options>]";
+	const char *namespace = parse_namespace_options(argc, argv,
+			ACTION_WRITE_INFOBLOCK, write_infoblock_options,
+			xable_usage);
+	int write, rc;
+
+	rc = do_xaction_namespace(namespace, ACTION_WRITE_INFOBLOCK, ctx,
+			&write);
+	if (rc < 0)
+		fprintf(stderr, "error checking infoblocks: %s\n",
+				strerror(-rc));
+	fprintf(stderr, "wrote %d infoblock%s\n", write, write == 1 ? "" : "s");
+	return rc;
+}
diff --git a/ndctl/ndctl.c b/ndctl/ndctl.c
index 5c9c424dcae6..58cc9c7bb07e 100644
--- a/ndctl/ndctl.c
+++ b/ndctl/ndctl.c
@@ -74,6 +74,7 @@ static struct cmd_struct commands[] = {
 	{ "create-namespace", { cmd_create_namespace } },
 	{ "destroy-namespace", { cmd_destroy_namespace } },
 	{ "read-infoblock",  { cmd_read_infoblock } },
+	{ "write-infoblock",  { cmd_write_infoblock } },
 	{ "check-namespace", { cmd_check_namespace } },
 	{ "clear-errors", { cmd_clear_errors } },
 	{ "enable-region", { cmd_enable_region } },
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

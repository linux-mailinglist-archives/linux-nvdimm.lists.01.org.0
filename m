Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E89731F3BF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:03:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 928C6100F225C;
	Thu, 18 Feb 2021 18:03:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2B171100EBBD7
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:50 -0800 (PST)
IronPort-SDR: AwF7kQw+2zFqyTBPEaK4Mb60RTQBdSUZs0qGMRyzB/YkhCHOpGXHSx0RGvD55h381NOs6+Gf6z
 b9hIO7pnqIJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151483"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151483"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:49 -0800
IronPort-SDR: eu5RmNLDvgMhcQQSF+BZj+Kkb2T+KsPt6mm/X5jtl6BQmT6jlDG981RenDeBgJcnFEVT1t4fa+
 XuWFxY0/4gXw==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509625"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:49 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 02/13] cxl: add a local copy of the cxl_mem UAPI header
Date: Thu, 18 Feb 2021 19:03:20 -0700
Message-Id: <20210219020331.725687-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: FWDXFIPNREQYY65FRB7RTFDZ5FTZZWU7
X-Message-ID-Hash: FWDXFIPNREQYY65FRB7RTFDZ5FTZZWU7
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FWDXFIPNREQYY65FRB7RTFDZ5FTZZWU7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

While CXL functionality is under development, it is useful to have a
local copy of the UAPI header for cxl_mem definitions. This allows
building cxl and libcxl on systems where the appropriate kernel headers
are not installed in the usual locations.

Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Makefile.am         |   3 +-
 Makefile.am.in      |   1 +
 cxl/cxl_mem.h       | 181 ++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/Makefile.am |   2 +-
 4 files changed, 185 insertions(+), 2 deletions(-)
 create mode 100644 cxl/cxl_mem.h

diff --git a/Makefile.am b/Makefile.am
index 428fd40..4904ee7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -89,4 +89,5 @@ libutil_a_SOURCES = \
 
 nobase_include_HEADERS = \
 	daxctl/libdaxctl.h \
-	cxl/libcxl.h
+	cxl/libcxl.h \
+	cxl/cxl_mem.h
diff --git a/Makefile.am.in b/Makefile.am.in
index aaeee53..a748128 100644
--- a/Makefile.am.in
+++ b/Makefile.am.in
@@ -11,6 +11,7 @@ AM_CPPFLAGS = \
 	-DNDCTL_MAN_PATH=\""$(mandir)"\" \
 	-I${top_srcdir}/ndctl/lib \
 	-I${top_srcdir}/ndctl \
+	-I${top_srcdir}/cxl \
 	-I${top_srcdir}/ \
 	$(KMOD_CFLAGS) \
 	$(UDEV_CFLAGS) \
diff --git a/cxl/cxl_mem.h b/cxl/cxl_mem.h
new file mode 100644
index 0000000..be9c7ad
--- /dev/null
+++ b/cxl/cxl_mem.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+/* Copyright (C) 2020-2021, Intel Corporation. All rights reserved. */
+/*
+ * CXL IOCTLs for Memory Devices
+ */
+
+#ifndef _UAPI_CXL_MEM_H_
+#define _UAPI_CXL_MEM_H_
+
+#include <linux/types.h>
+#include <sys/user.h>
+#include <unistd.h>
+
+#define __user
+
+/**
+ * DOC: UAPI
+ *
+ * CXL memory devices expose UAPI to have a standard user interface.
+ * Userspace can refer to these structure definitions and UAPI formats
+ * to communicate to driver. The commands themselves are somewhat obfuscated
+ * with macro magic. They have the form CXL_MEM_COMMAND_ID_<name>.
+ *
+ * For example "CXL_MEM_COMMAND_ID_INVALID"
+ *
+ * Not all of all commands that the driver supports are always available for use
+ * by userspace. Userspace must check the results from the QUERY command in
+ * order to determine the live set of commands.
+ */
+
+#define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
+#define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
+
+#define CXL_CMDS                                                          \
+	___C(INVALID, "Invalid Command"),                                 \
+	___C(IDENTIFY, "Identify Command"),                               \
+	___C(RAW, "Raw device command"),                                  \
+	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
+	___C(GET_FW_INFO, "Get FW Info"),                                 \
+	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
+	___C(GET_LSA, "Get Label Storage Area"),                          \
+	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
+	___C(GET_LOG, "Get Log"),                                         \
+	___C(MAX, "Last command")
+
+#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
+enum { CXL_CMDS };
+
+#undef ___C
+#define ___C(a, b) { b }
+static const struct {
+	const char *name;
+} cxl_command_names[] = { CXL_CMDS };
+#undef ___C
+
+/**
+ * struct cxl_command_info - Command information returned from a query.
+ * @id: ID number for the command.
+ * @flags: Flags that specify command behavior.
+ *
+ *  * %CXL_MEM_COMMAND_FLAG_KERNEL: This command is reserved for exclusive
+ *    kernel use.
+ *  * %CXL_MEM_COMMAND_FLAG_MUTEX: This command may require coordination with
+ *    the kernel in order to complete successfully.
+ *
+ * @size_in: Expected input size, or -1 if variable length.
+ * @size_out: Expected output size, or -1 if variable length.
+ *
+ * Represents a single command that is supported by both the driver and the
+ * hardware. This is returned as part of an array from the query ioctl. The
+ * following would be a command named "foobar" that takes a variable length
+ * input and returns 0 bytes of output.
+ *
+ *  - @id = 10
+ *  - @flags = CXL_MEM_COMMAND_FLAG_MUTEX
+ *  - @size_in = -1
+ *  - @size_out = 0
+ *
+ * See struct cxl_mem_query_commands.
+ */
+struct cxl_command_info {
+	__u32 id;
+
+	__u32 flags;
+#define CXL_MEM_COMMAND_FLAG_NONE 0
+#define CXL_MEM_COMMAND_FLAG_KERNEL BIT(0)
+#define CXL_MEM_COMMAND_FLAG_MUTEX BIT(1)
+#define CXL_MEM_COMMAND_FLAG_MASK GENMASK(1, 0)
+
+	__s32 size_in;
+	__s32 size_out;
+};
+
+/**
+ * struct cxl_mem_query_commands - Query supported commands.
+ * @n_commands: In/out parameter. When @n_commands is > 0, the driver will
+ *		return min(num_support_commands, n_commands). When @n_commands
+ *		is 0, driver will return the number of total supported commands.
+ * @rsvd: Reserved for future use.
+ * @commands: Output array of supported commands. This array must be allocated
+ *            by userspace to be at least min(num_support_commands, @n_commands)
+ *
+ * Allow userspace to query the available commands supported by both the driver,
+ * and the hardware. Commands that aren't supported by either the driver, or the
+ * hardware are not returned in the query.
+ *
+ * Examples:
+ *
+ *  - { .n_commands = 0 } // Get number of supported commands
+ *  - { .n_commands = 15, .commands = buf } // Return first 15 (or less)
+ *    supported commands
+ *
+ *  See struct cxl_command_info.
+ */
+struct cxl_mem_query_commands {
+	/*
+	 * Input: Number of commands to return (space allocated by user)
+	 * Output: Number of commands supported by the driver/hardware
+	 *
+	 * If n_commands is 0, kernel will only return number of commands and
+	 * not try to populate commands[], thus allowing userspace to know how
+	 * much space to allocate
+	 */
+	__u32 n_commands;
+	__u32 rsvd;
+
+	struct cxl_command_info __user commands[]; /* out: supported commands */
+};
+
+/**
+ * struct cxl_send_command - Send a command to a memory device.
+ * @id: The command to send to the memory device. This must be one of the
+ *	commands returned by the query command.
+ * @flags: Flags for the command (input).
+ * @raw: Special fields for raw commands
+ * @raw.opcode: Opcode passed to hardware when using the RAW command.
+ * @raw.rsvd: Must be zero.
+ * @rsvd: Must be zero.
+ * @retval: Return value from the memory device (output).
+ * @in.size: Size of the payload to provide to the device (input).
+ * @in.rsvd: Must be zero.
+ * @in.payload: Pointer to memory for payload input (little endian order).
+ * @out.size: Size of the payload received from the device (input/output). This
+ *	      field is filled in by userspace to let the driver know how much
+ *	      space was allocated for output. It is populated by the driver to
+ *	      let userspace know how large the output payload actually was.
+ * @out.rsvd: Must be zero.
+ * @out.payload: Pointer to memory for payload output (little endian order).
+ *
+ * Mechanism for userspace to send a command to the hardware for processing. The
+ * driver will do basic validation on the command sizes. In some cases even the
+ * payload may be introspected. Userspace is required to allocate large
+ * enough buffers for size_out which can be variable length in certain
+ * situations.
+ */
+struct cxl_send_command {
+	__u32 id;
+	__u32 flags;
+	union {
+		struct {
+			__u16 opcode;
+			__u16 rsvd;
+		} raw;
+		__u32 rsvd;
+	};
+	__u32 retval;
+
+	struct {
+		__s32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} in;
+
+	struct {
+		__s32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} out;
+};
+
+#endif
diff --git a/cxl/lib/Makefile.am b/cxl/lib/Makefile.am
index 277f0cd..72c9ccd 100644
--- a/cxl/lib/Makefile.am
+++ b/cxl/lib/Makefile.am
@@ -3,7 +3,7 @@ include $(top_srcdir)/Makefile.am.in
 %.pc: %.pc.in Makefile
 	$(SED_PROCESS)
 
-pkginclude_HEADERS = ../libcxl.h
+pkginclude_HEADERS = ../libcxl.h ../cxl_mem.h
 lib_LTLIBRARIES = libcxl.la
 
 libcxl_la_SOURCES =\
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

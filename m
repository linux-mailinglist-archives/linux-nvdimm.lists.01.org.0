Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E2D31F3C7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:04:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D95A0100EAB01;
	Thu, 18 Feb 2021 18:04:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5FA25100F2276
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:55 -0800 (PST)
IronPort-SDR: f7bOw3tfQjYwThbGLNAx32haHj9Set7kAnPXXFa6JCxl3troDNZlFZMwlS59McLyG3Hb1ywMbc
 x/XhMMBnofQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151518"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151518"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:55 -0800
IronPort-SDR: CACyJKUsYqJyJa2GbfO5zIR0aDiQrkQa+UTEsxeZqjhTAQGTpZ0Ynp7ck3T22GoFFIZRlDktUP
 NQ545vFokTHw==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509678"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:54 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 10/13] util/hexdump: Add a util helper to print a buffer in hex
Date: Thu, 18 Feb 2021 19:03:28 -0700
Message-Id: <20210219020331.725687-11-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: OD67HTFDXQFVJBCOECW3BOE46RFOTHEV
X-Message-ID-Hash: OD67HTFDXQFVJBCOECW3BOE46RFOTHEV
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OD67HTFDXQFVJBCOECW3BOE46RFOTHEV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for tests that may need to set, retrieve, and display
opaque data, add a hexdump function in util.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 util/hexdump.h |  8 ++++++++
 util/hexdump.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 util/hexdump.h
 create mode 100644 util/hexdump.c

diff --git a/util/hexdump.h b/util/hexdump.h
new file mode 100644
index 0000000..d322b6a
--- /dev/null
+++ b/util/hexdump.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Intel Corporation. All rights reserved. */
+#ifndef _UTIL_HEXDUMP_H_
+#define _UTIL_HEXDUMP_H_
+
+void hex_dump_buf(unsigned char *buf, int size);
+
+#endif /* _UTIL_HEXDUMP_H_*/
diff --git a/util/hexdump.c b/util/hexdump.c
new file mode 100644
index 0000000..1ab0118
--- /dev/null
+++ b/util/hexdump.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2015-2021 Intel Corporation. All rights reserved. */
+#include <stdio.h>
+#include <util/hexdump.h>
+
+static void print_separator(int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		fprintf(stderr, "-");
+	fprintf(stderr, "\n");
+}
+
+void hex_dump_buf(unsigned char *buf, int size)
+{
+	int i;
+	const int grp = 4;  /* Number of bytes in a group */
+	const int wid = 16; /* Bytes per line. Should be a multiple of grp */
+	char ascii[wid + 1];
+
+	/* Generate header */
+	print_separator((wid * 4) + (wid / grp) + 12);
+
+	fprintf(stderr, "Offset    ");
+	for (i = 0; i < wid; i++) {
+		if (i % grp == 0) fprintf(stderr, " ");
+		fprintf(stderr, "%02x ", i);
+	}
+	fprintf(stderr, "  Ascii\n");
+
+	print_separator((wid * 4) + (wid / grp) + 12);
+
+	/* Generate hex dump */
+	for (i = 0; i < size; i++) {
+		if (i % wid == 0) fprintf(stderr, "%08x  ", i);
+		ascii[i % wid] =
+		    ((buf[i] >= ' ') && (buf[i] <= '~')) ? buf[i] : '.';
+		if (i % grp == 0) fprintf(stderr, " ");
+		fprintf(stderr, "%02x ", buf[i]);
+		if ((i == size - 1) && (size % wid != 0)) {
+			int j;
+			int done = size % wid;
+			int grps_done = (done / grp) + ((done % grp) ? 1 : 0);
+			int spaces = wid / grp - grps_done + ((wid - done) * 3);
+
+			for (j = 0; j < spaces; j++) fprintf(stderr, " ");
+		}
+		if ((i % wid == wid - 1) || (i == size - 1))
+			fprintf(stderr, "  %.*s\n", (i % wid) + 1, ascii);
+	}
+	print_separator((wid * 4) + (wid / grp) + 12);
+}
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B862941C0
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Oct 2020 19:53:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 85B1B159AD623;
	Tue, 20 Oct 2020 10:53:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C7729159A7518
	for <linux-nvdimm@lists.01.org>; Tue, 20 Oct 2020 10:53:25 -0700 (PDT)
IronPort-SDR: +I75C5bTMzSk8gt+ewgGz4fkRfSWw0OQ/QNJ9W+sPo2jxi71WwE1JgC5ARCjmaYGy3CMTUG1QC
 MRfIOT/9AWqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="167343661"
X-IronPort-AV: E=Sophos;i="5.77,398,1596524400";
   d="scan'208";a="167343661"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 10:53:21 -0700
IronPort-SDR: frQheF0fnsAC/QpER2D0QeZkDUkzZuSxKFhXc4XnEOHxLU+93drDClGDJLkG/KxraE2xhtjkYL
 ho9SnMG0KhaA==
X-IronPort-AV: E=Sophos;i="5.77,398,1596524400";
   d="scan'208";a="523596421"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 10:53:20 -0700
Subject: [ndctl PATCH] Rework license identification
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Tue, 20 Oct 2020 10:53:20 -0700
Message-ID: <160321640031.3386448.4879860972349220888.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: BA3KU5UI6YBE3JLF6DOB73GXZQ35NQB3
X-Message-ID-Hash: BA3KU5UI6YBE3JLF6DOB73GXZQ35NQB3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BA3KU5UI6YBE3JLF6DOB73GXZQ35NQB3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert to the LICENSES/ directory format for COPYING from the Linux
kernel, and switch all remaining files over to SPDX annotations.

Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 COPYING                          |   31 +++
 Documentation/daxctl/Makefile.am |   12 -
 Documentation/ndctl/Makefile.am  |   12 -
 LICENSES/other/CC0-1.0           |    0 
 LICENSES/other/MIT               |    0 
 LICENSES/preferred/GPL-2.0       |    0 
 LICENSES/preferred/LGPL-2.1      |    0 
 acpi.h                           |   16 --
 ccan/array_size/LICENSE          |    1 
 ccan/array_size/array_size.h     |    2 
 ccan/build_assert/LICENSE        |    1 
 ccan/build_assert/build_assert.h |    2 
 ccan/check_type/LICENSE          |    1 
 ccan/check_type/check_type.h     |    2 
 ccan/container_of/LICENSE        |    1 
 ccan/container_of/container_of.h |    2 
 ccan/endian/LICENSE              |    1 
 ccan/endian/endian.h             |    2 
 ccan/list/LICENSE                |    1 
 ccan/list/list.c                 |    2 
 ccan/list/list.h                 |    2 
 ccan/minmax/LICENSE              |    1 
 ccan/minmax/minmax.h             |    2 
 ccan/short_types/LICENSE         |    1 
 ccan/short_types/short_types.h   |    2 
 ccan/str/LICENSE                 |    1 
 ccan/str/debug.c                 |    2 
 ccan/str/str.c                   |    2 
 ccan/str/str.h                   |    2 
 ccan/str/str_debug.h             |    2 
 daxctl/builtin.h                 |    2 
 daxctl/daxctl.c                  |   16 --
 daxctl/lib/libdaxctl-private.h   |   14 --
 daxctl/lib/libdaxctl.c           |   14 --
 daxctl/libdaxctl.h               |   14 --
 daxctl/list.c                    |   14 --
 daxctl/migrate.c                 |    2 
 ndctl/action.h                   |    7 -
 ndctl/bat.c                      |   14 --
 ndctl/builtin.h                  |    2 
 ndctl/bus.c                      |    2 
 ndctl/check.c                    |   14 --
 ndctl/create-nfit.c              |   14 --
 ndctl/dimm.c                     |   14 --
 ndctl/firmware-update.h          |    2 
 ndctl/inject-error.c             |   14 --
 ndctl/inject-smart.c             |    2 
 ndctl/lib/ars.c                  |   14 --
 ndctl/lib/dimm.c                 |   14 --
 ndctl/lib/firmware.c             |    2 
 ndctl/lib/hpe1.c                 |   16 --
 ndctl/lib/hpe1.h                 |   15 --
 ndctl/lib/inject.c               |   14 --
 ndctl/lib/intel.c                |   14 --
 ndctl/lib/intel.h                |    2 
 ndctl/lib/libndctl.c             |   14 --
 ndctl/lib/msft.c                 |   18 --
 ndctl/lib/msft.h                 |   18 --
 ndctl/lib/nfit.c                 |   14 --
 ndctl/lib/papr.h                 |    2 
 ndctl/lib/papr_pdsm.h            |    2 
 ndctl/lib/private.h              |   14 --
 ndctl/lib/smart.c                |   14 --
 ndctl/libndctl-nfit.h            |   18 --
 ndctl/libndctl.h                 |   14 --
 ndctl/list.c                     |   14 --
 ndctl/monitor.c                  |    4 
 ndctl/namespace.c                |   14 --
 ndctl/namespace.h                |   14 --
 ndctl/ndctl.c                    |   15 --
 ndctl/ndctl.h                    |   14 --
 ndctl/region.c                   |   14 --
 ndctl/test.c                     |   14 --
 ndctl/util/json-smart.c          |   14 --
 test.h                           |   14 --
 test/ack-shutdown-count-set.c    |    4 
 test/blk-exhaust.sh              |   12 -
 test/blk_namespaces.c            |   16 --
 test/btt-check.sh                |   12 -
 test/btt-errors.sh               |   12 -
 test/btt-pad-compat.sh           |   12 -
 test/clear.sh                    |   12 -
 test/core.c                      |   14 --
 test/create.sh                   |   12 -
 test/dax-dev.c                   |   14 --
 test/dax-errors.c                |   14 --
 test/dax-pmd.c                   |   14 --
 test/dax-poison.c                |    4 
 test/dax.sh                      |   12 -
 test/daxdev-errors.c             |   14 --
 test/daxdev-errors.sh            |   12 -
 test/device-dax-fio.sh           |   12 -
 test/device-dax.c                |   14 --
 test/dpa-alloc.c                 |   14 --
 test/dsm-fail.c                  |   14 --
 test/inject-error.sh             |   12 -
 test/label-compat.sh             |   12 -
 test/libndctl.c                  |   14 --
 test/list-smart-dimm.c           |    5 -
 test/mmap.c                      |   14 --
 test/mmap.sh                     |   12 -
 test/multi-dax.sh                |   12 -
 test/multi-pmem.c                |   14 --
 test/parent-uuid.c               |   16 --
 test/pmem_namespaces.c           |   16 --
 test/sector-mode.sh              |   12 -
 test/smart-listen.c              |    4 
 test/smart-notify.c              |    4 
 util/COPYING                     |  340 --------------------------------------
 util/abspath.c                   |    3 
 util/bitmap.c                    |   16 --
 util/bitmap.h                    |   14 --
 util/filter.c                    |   14 --
 util/filter.h                    |   14 --
 util/help.c                      |   18 --
 util/iomem.c                     |    5 -
 util/iomem.h                     |    4 
 util/json.c                      |   14 --
 util/json.h                      |   14 --
 util/list.h                      |   14 --
 util/log.c                       |   14 --
 util/log.h                       |   14 --
 util/main.c                      |   16 --
 util/main.h                      |   16 --
 util/parse-options.c             |   14 --
 util/parse-options.h             |   14 --
 util/size.c                      |   14 --
 util/size.h                      |   14 --
 util/strbuf.c                    |   14 --
 util/strbuf.h                    |   14 --
 util/sysfs.c                     |   14 --
 util/sysfs.h                     |   14 --
 util/usage.c                     |   14 --
 util/util.h                      |   16 --
 util/wrapper.c                   |   16 --
 135 files changed, 256 insertions(+), 1440 deletions(-)
 rename licenses/CC0 => LICENSES/other/CC0-1.0 (100%)
 rename licenses/BSD-MIT => LICENSES/other/MIT (100%)
 rename COPYING.tools => LICENSES/preferred/GPL-2.0 (100%)
 rename COPYING.libraries => LICENSES/preferred/LGPL-2.1 (100%)
 delete mode 120000 ccan/array_size/LICENSE
 delete mode 120000 ccan/build_assert/LICENSE
 delete mode 120000 ccan/check_type/LICENSE
 delete mode 120000 ccan/container_of/LICENSE
 delete mode 120000 ccan/endian/LICENSE
 delete mode 120000 ccan/list/LICENSE
 delete mode 120000 ccan/minmax/LICENSE
 delete mode 120000 ccan/short_types/LICENSE
 delete mode 120000 ccan/str/LICENSE
 delete mode 100644 util/COPYING

diff --git a/COPYING b/COPYING
index 7e705e83d220..0ec3b27e48cc 100644
--- a/COPYING
+++ b/COPYING
@@ -1,6 +1,25 @@
-This project has 2 classes of binaries, "tools" like ndctl and daxctl,
-and "libraries" like libndctl and libdaxctl. The libraries are licensed
-LGPLv2.1 for third-party application linking. See COPYING.libraries for
-the full license. The "tools" are licensed GPLv2 to provide a command
-line interface to the C libraries. See COPYING.tools for the full
-license.
+The ndctl project provides tools under:
+
+	SPDX-License-Identifier: GPL-2.0
+
+Being under the terms of the GNU General Public License version 2 only,
+according with:
+
+	LICENSES/preferred/GPL-2.0
+
+The ndctl project provides libraries under:
+
+	SPDX-License-Identifier: LGPL-2.1
+
+Being under the terms of the GNU Lesser General Public License version
+2.1 only, according with:
+
+	LICENSES/preferred/LGPL-2.1
+
+The project incorporates helper routines from the CCAN project under
+CC0-1.0 and MIT licenses according with:
+
+	LICENSES/other/CC0-1.0
+	LICENSES/other/MIT
+
+All contributions to the ndctl project are subject to this COPYING file.
diff --git a/Documentation/daxctl/Makefile.am b/Documentation/daxctl/Makefile.am
index 7696e23cc9c0..fa2ce1556cd6 100644
--- a/Documentation/daxctl/Makefile.am
+++ b/Documentation/daxctl/Makefile.am
@@ -1,13 +1,5 @@
-# Copyright(c) 2015-2017 Intel Corporation.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 if USE_ASCIIDOCTOR
 
diff --git a/Documentation/ndctl/Makefile.am b/Documentation/ndctl/Makefile.am
index 0278c783ea66..192be74c0c55 100644
--- a/Documentation/ndctl/Makefile.am
+++ b/Documentation/ndctl/Makefile.am
@@ -1,13 +1,5 @@
-# Copyright(c) 2015-2017 Intel Corporation.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 if USE_ASCIIDOCTOR
 
diff --git a/licenses/CC0 b/LICENSES/other/CC0-1.0
similarity index 100%
rename from licenses/CC0
rename to LICENSES/other/CC0-1.0
diff --git a/licenses/BSD-MIT b/LICENSES/other/MIT
similarity index 100%
rename from licenses/BSD-MIT
rename to LICENSES/other/MIT
diff --git a/COPYING.tools b/LICENSES/preferred/GPL-2.0
similarity index 100%
rename from COPYING.tools
rename to LICENSES/preferred/GPL-2.0
diff --git a/COPYING.libraries b/LICENSES/preferred/LGPL-2.1
similarity index 100%
rename from COPYING.libraries
rename to LICENSES/preferred/LGPL-2.1
diff --git a/acpi.h b/acpi.h
index e714e28e2354..a2bd9c716281 100644
--- a/acpi.h
+++ b/acpi.h
@@ -1,17 +1,5 @@
-/*
- * ACPI Table Definitions
- *
- * Copyright(c) 2013-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2013-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #ifndef __ACPI_H__
 #define __ACPI_H__
 #include <stdint.h>
diff --git a/ccan/array_size/LICENSE b/ccan/array_size/LICENSE
deleted file mode 120000
index b7951dabdc82..000000000000
--- a/ccan/array_size/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-../../licenses/CC0
\ No newline at end of file
diff --git a/ccan/array_size/array_size.h b/ccan/array_size/array_size.h
index 0ca422a29168..5a164765e9c0 100644
--- a/ccan/array_size/array_size.h
+++ b/ccan/array_size/array_size.h
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #ifndef CCAN_ARRAY_SIZE_H
 #define CCAN_ARRAY_SIZE_H
 #include "config.h"
diff --git a/ccan/build_assert/LICENSE b/ccan/build_assert/LICENSE
deleted file mode 120000
index b7951dabdc82..000000000000
--- a/ccan/build_assert/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-../../licenses/CC0
\ No newline at end of file
diff --git a/ccan/build_assert/build_assert.h b/ccan/build_assert/build_assert.h
index b9ecd84028e3..9ca947a1473d 100644
--- a/ccan/build_assert/build_assert.h
+++ b/ccan/build_assert/build_assert.h
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #ifndef CCAN_BUILD_ASSERT_H
 #define CCAN_BUILD_ASSERT_H
 
diff --git a/ccan/check_type/LICENSE b/ccan/check_type/LICENSE
deleted file mode 120000
index b7951dabdc82..000000000000
--- a/ccan/check_type/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-../../licenses/CC0
\ No newline at end of file
diff --git a/ccan/check_type/check_type.h b/ccan/check_type/check_type.h
index 77501a95597c..e92a87ec5507 100644
--- a/ccan/check_type/check_type.h
+++ b/ccan/check_type/check_type.h
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #ifndef CCAN_CHECK_TYPE_H
 #define CCAN_CHECK_TYPE_H
 #include "config.h"
diff --git a/ccan/container_of/LICENSE b/ccan/container_of/LICENSE
deleted file mode 120000
index b7951dabdc82..000000000000
--- a/ccan/container_of/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-../../licenses/CC0
\ No newline at end of file
diff --git a/ccan/container_of/container_of.h b/ccan/container_of/container_of.h
index 0449935056f5..ab8137a8598c 100644
--- a/ccan/container_of/container_of.h
+++ b/ccan/container_of/container_of.h
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #ifndef CCAN_CONTAINER_OF_H
 #define CCAN_CONTAINER_OF_H
 #include <stddef.h>
diff --git a/ccan/endian/LICENSE b/ccan/endian/LICENSE
deleted file mode 120000
index b7951dabdc82..000000000000
--- a/ccan/endian/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-../../licenses/CC0
\ No newline at end of file
diff --git a/ccan/endian/endian.h b/ccan/endian/endian.h
index dc9f62e646df..965a262fe6a6 100644
--- a/ccan/endian/endian.h
+++ b/ccan/endian/endian.h
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #ifndef CCAN_ENDIAN_H
 #define CCAN_ENDIAN_H
 #include <stdint.h>
diff --git a/ccan/list/LICENSE b/ccan/list/LICENSE
deleted file mode 120000
index 2354d12945d3..000000000000
--- a/ccan/list/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-../../licenses/BSD-MIT
\ No newline at end of file
diff --git a/ccan/list/list.c b/ccan/list/list.c
index 2717fa3f17e5..38b25a9ebf7b 100644
--- a/ccan/list/list.c
+++ b/ccan/list/list.c
@@ -1,4 +1,4 @@
-/* Licensed under BSD-MIT - see LICENSE file for details */
+// SPDX-License-Identifier: MIT
 #include <stdio.h>
 #include <stdlib.h>
 #include "list.h"
diff --git a/ccan/list/list.h b/ccan/list/list.h
index 4d1d34e32709..74c473701e7b 100644
--- a/ccan/list/list.h
+++ b/ccan/list/list.h
@@ -1,4 +1,4 @@
-/* Licensed under BSD-MIT - see LICENSE file for details */
+// SPDX-License-Identifier: MIT
 #ifndef CCAN_LIST_H
 #define CCAN_LIST_H
 //#define CCAN_LIST_DEBUG 1
diff --git a/ccan/minmax/LICENSE b/ccan/minmax/LICENSE
deleted file mode 120000
index b7951dabdc82..000000000000
--- a/ccan/minmax/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-../../licenses/CC0
\ No newline at end of file
diff --git a/ccan/minmax/minmax.h b/ccan/minmax/minmax.h
index 54f246cc112d..5416af04b032 100644
--- a/ccan/minmax/minmax.h
+++ b/ccan/minmax/minmax.h
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #ifndef CCAN_MINMAX_H
 #define CCAN_MINMAX_H
 
diff --git a/ccan/short_types/LICENSE b/ccan/short_types/LICENSE
deleted file mode 120000
index b7951dabdc82..000000000000
--- a/ccan/short_types/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-../../licenses/CC0
\ No newline at end of file
diff --git a/ccan/short_types/short_types.h b/ccan/short_types/short_types.h
index 175377e9bab9..dabdfe594b9d 100644
--- a/ccan/short_types/short_types.h
+++ b/ccan/short_types/short_types.h
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #ifndef CCAN_SHORT_TYPES_H
 #define CCAN_SHORT_TYPES_H
 #include <stdint.h>
diff --git a/ccan/str/LICENSE b/ccan/str/LICENSE
deleted file mode 120000
index b7951dabdc82..000000000000
--- a/ccan/str/LICENSE
+++ /dev/null
@@ -1 +0,0 @@
-../../licenses/CC0
\ No newline at end of file
diff --git a/ccan/str/debug.c b/ccan/str/debug.c
index 8c519442d792..9dd0e28f0385 100644
--- a/ccan/str/debug.c
+++ b/ccan/str/debug.c
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #include "config.h"
 #include <ccan/str/str_debug.h>
 #include <assert.h>
diff --git a/ccan/str/str.c b/ccan/str/str.c
index a9245c1742ec..66ca7e2039b0 100644
--- a/ccan/str/str.c
+++ b/ccan/str/str.c
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #include <ccan/str/str.h>
 
 size_t strcount(const char *haystack, const char *needle)
diff --git a/ccan/str/str.h b/ccan/str/str.h
index 85491bc7e33e..3c08c669b109 100644
--- a/ccan/str/str.h
+++ b/ccan/str/str.h
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #ifndef CCAN_STR_H
 #define CCAN_STR_H
 #include "config.h"
diff --git a/ccan/str/str_debug.h b/ccan/str/str_debug.h
index 92c10c41cc61..ee35e28ca40b 100644
--- a/ccan/str/str_debug.h
+++ b/ccan/str/str_debug.h
@@ -1,4 +1,4 @@
-/* CC0 (Public domain) - see LICENSE file for details */
+// SPDX-License-Identifier: CC0-1.0
 #ifndef CCAN_STR_DEBUG_H
 #define CCAN_STR_DEBUG_H
 
diff --git a/daxctl/builtin.h b/daxctl/builtin.h
index bdd71c1f45c8..eaa301269fb4 100644
--- a/daxctl/builtin.h
+++ b/daxctl/builtin.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2015-2018 Intel Corporation. All rights reserved. */
 #ifndef _DAXCTL_BUILTIN_H_
 #define _DAXCTL_BUILTIN_H_
diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
index f533f810eb42..506b9ff9e31e 100644
--- a/daxctl/daxctl.c
+++ b/daxctl/daxctl.c
@@ -1,16 +1,6 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- * Copyright(c) 2005 Andreas Ericsson. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// Copyright(c) 2005 Andreas Ericsson. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index 9f9c70d6024f..7a85b16943d7 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef _LIBDAXCTL_PRIVATE_H_
 #define _LIBDAXCTL_PRIVATE_H_
 
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 9b43b68facfe..fbc2f4e56ae7 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2016-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdio.h>
 #include <errno.h>
 #include <limits.h>
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 2b14faad1895..e334c68894b5 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2016-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef _LIBDAXCTL_H_
 #define _LIBDAXCTL_H_
 
diff --git a/daxctl/list.c b/daxctl/list.c
index 6c6251b4de37..763481c0d5fb 100644
--- a/daxctl/list.c
+++ b/daxctl/list.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/daxctl/migrate.c b/daxctl/migrate.c
index d859b0856338..27d379806b15 100644
--- a/daxctl/migrate.c
+++ b/daxctl/migrate.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2019 Intel Corporation. All rights reserved. */
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/ndctl/action.h b/ndctl/action.h
index 51f8ee6f4bce..4c4ad9ce7c91 100644
--- a/ndctl/action.h
+++ b/ndctl/action.h
@@ -1,8 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * SPDX-License-Identifier: GPL-2.0
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #ifndef __NDCTL_ACTION_H__
 #define __NDCTL_ACTION_H__
 enum device_action {
diff --git a/ndctl/bat.c b/ndctl/bat.c
index c4496f0aeaa0..7529a02198f6 100644
--- a/ndctl/bat.c
+++ b/ndctl/bat.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2014 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2014-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <syslog.h>
 #include <test.h>
diff --git a/ndctl/builtin.h b/ndctl/builtin.h
index 5de7379ce1b4..ec1a750225e4 100644
--- a/ndctl/builtin.h
+++ b/ndctl/builtin.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2015-2018 Intel Corporation. All rights reserved. */
 #ifndef _NDCTL_BUILTIN_H_
 #define _NDCTL_BUILTIN_H_
diff --git a/ndctl/bus.c b/ndctl/bus.c
index 47053c8af389..4db1ab50d7c9 100644
--- a/ndctl/bus.c
+++ b/ndctl/bus.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2015-2018 Intel Corporation. All rights reserved. */
 #include <stdio.h>
 #include <errno.h>
diff --git a/ndctl/check.c b/ndctl/check.c
index cdb3d0bb5ae7..77cf7edb2e98 100644
--- a/ndctl/check.c
+++ b/ndctl/check.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2016 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <fcntl.h>
 #include <errno.h>
diff --git a/ndctl/create-nfit.c b/ndctl/create-nfit.c
index 8f05eab81494..96c09627f588 100644
--- a/ndctl/create-nfit.c
+++ b/ndctl/create-nfit.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2014 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2014-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 90eb0b8013ae..02026ffc2afd 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2016-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/ndctl/firmware-update.h b/ndctl/firmware-update.h
index a4386d6089d2..6f02340676b3 100644
--- a/ndctl/firmware-update.h
+++ b/ndctl/firmware-update.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2018 Intel Corporation. All rights reserved. */
 
 #ifndef _FIRMWARE_UPDATE_H_
diff --git a/ndctl/inject-error.c b/ndctl/inject-error.c
index f6be6a536b49..887ee78297d3 100644
--- a/ndctl/inject-error.c
+++ b/ndctl/inject-error.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <fcntl.h>
 #include <errno.h>
diff --git a/ndctl/inject-smart.c b/ndctl/inject-smart.c
index 00c81b87ed54..e5eec8b87f13 100644
--- a/ndctl/inject-smart.c
+++ b/ndctl/inject-smart.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2018 Intel Corporation. All rights reserved. */
 #include <math.h>
 #include <stdio.h>
diff --git a/ndctl/lib/ars.c b/ndctl/lib/ars.c
index 44871b2afde2..81f781e23d57 100644
--- a/ndctl/lib/ars.c
+++ b/ndctl/lib/ars.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdlib.h>
 #include <util/size.h>
 #include <ndctl/libndctl.h>
diff --git a/ndctl/lib/dimm.c b/ndctl/lib/dimm.c
index 17344f0b168b..ed51ffaa4950 100644
--- a/ndctl/lib/dimm.c
+++ b/ndctl/lib/dimm.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2017, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <ndctl/namespace.h>
 #include <ndctl/libndctl.h>
 #include <util/fletcher.h>
diff --git a/ndctl/lib/firmware.c b/ndctl/lib/firmware.c
index a5dd00640698..e3a6924db8bc 100644
--- a/ndctl/lib/firmware.c
+++ b/ndctl/lib/firmware.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2018 Intel Corporation. All rights reserved. */
 #include <stdlib.h>
 #include <limits.h>
diff --git a/ndctl/lib/hpe1.c b/ndctl/lib/hpe1.c
index b5ee02608d31..31bd215ca9ad 100644
--- a/ndctl/lib/hpe1.c
+++ b/ndctl/lib/hpe1.c
@@ -1,16 +1,6 @@
-/*
- * Copyright (C) 2016 Hewlett Packard Enterprise Development LP
- * Copyright (c) 2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (C) 2016 Hewlett Packard Enterprise Development LP
+// Copyright (c) 2016, Intel Corporation.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdlib.h>
 #include <limits.h>
 #include <util/log.h>
diff --git a/ndctl/lib/hpe1.h b/ndctl/lib/hpe1.h
index 1afa54f127a6..acf82af7bb87 100644
--- a/ndctl/lib/hpe1.h
+++ b/ndctl/lib/hpe1.h
@@ -1,16 +1,5 @@
-/*
- * Copyright (C) 2016 Hewlett Packard Enterprise Development LP
- * Copyright (c) 2014-2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (C) 2016 Hewlett Packard Enterprise Development LP
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef __NDCTL_HPE1_H__
 #define __NDCTL_HPE1_H__
 
diff --git a/ndctl/lib/inject.c b/ndctl/lib/inject.c
index 815f254308c6..00ef0a4d1d28 100644
--- a/ndctl/lib/inject.c
+++ b/ndctl/lib/inject.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2017, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2017, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdlib.h>
 #include <limits.h>
 #include <util/list.h>
diff --git a/ndctl/lib/intel.c b/ndctl/lib/intel.c
index ebcefd8b5ad2..0d3da2bec017 100644
--- a/ndctl/lib/intel.c
+++ b/ndctl/lib/intel.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2016-2017, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2016-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdlib.h>
 #include <limits.h>
 #include <util/log.h>
diff --git a/ndctl/lib/intel.h b/ndctl/lib/intel.h
index 530c996a6930..bade1cba02b0 100644
--- a/ndctl/lib/intel.h
+++ b/ndctl/lib/intel.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: LGPL-2.1 */
+// SPDX-License-Identifier: LGPL-2.1
 /* Copyright (c) 2017, Intel Corporation. All rights reserved. */
 
 #ifndef __INTEL_H__
diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 554696386f48..cd039d9bd5d8 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <poll.h>
 #include <stdio.h>
 #include <signal.h>
diff --git a/ndctl/lib/msft.c b/ndctl/lib/msft.c
index c060b1f2609e..9eb9eb18fa8f 100644
--- a/ndctl/lib/msft.c
+++ b/ndctl/lib/msft.c
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2016-2017 Dell, Inc.
- * Copyright (C) 2016 Hewlett Packard Enterprise Development LP
- * Copyright (c) 2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2016-2017 Dell, Inc.
+// Copyright (c) 2016 Hewlett Packard Enterprise Development LP
+// Copyright (c) 2016, Intel Corporation.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdlib.h>
 #include <limits.h>
 #include <util/log.h>
diff --git a/ndctl/lib/msft.h b/ndctl/lib/msft.h
index c45981edd8d7..86f68770636d 100644
--- a/ndctl/lib/msft.h
+++ b/ndctl/lib/msft.h
@@ -1,17 +1,7 @@
-/*
- * Copyright (C) 2016-2017 Dell, Inc.
- * Copyright (C) 2016 Hewlett Packard Enterprise Development LP
- * Copyright (c) 2014-2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2016-2017 Dell, Inc.
+// Copyright (c) 2016 Hewlett Packard Enterprise Development LP
+// Copyright (c) 2014-2015, Intel Corporation.
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef __NDCTL_MSFT_H__
 #define __NDCTL_MSFT_H__
 
diff --git a/ndctl/lib/nfit.c b/ndctl/lib/nfit.c
index f9fbe73f7446..6b52917c44e0 100644
--- a/ndctl/lib/nfit.c
+++ b/ndctl/lib/nfit.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2017, FUJITSU LIMITED. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2017, FUJITSU LIMITED. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdlib.h>
 #include <ndctl/libndctl.h>
 #include "private.h"
diff --git a/ndctl/lib/papr.h b/ndctl/lib/papr.h
index 77579396a7bd..3979e492e9cb 100644
--- a/ndctl/lib/papr.h
+++ b/ndctl/lib/papr.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: LGPL-2.1 */
+// SPDX-License-Identifier: LGPL-2.1
 /* (C) Copyright IBM 2020 */
 
 #ifndef __PAPR_H__
diff --git a/ndctl/lib/papr_pdsm.h b/ndctl/lib/papr_pdsm.h
index 1bac8a7fc933..4f14b26edb50 100644
--- a/ndctl/lib/papr_pdsm.h
+++ b/ndctl/lib/papr_pdsm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 /*
  * PAPR nvDimm Specific Methods (PDSM) and structs for libndctl
  *
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index bab4298b01e3..1ed1a7c5843d 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef _LIBNDCTL_PRIVATE_H_
 #define _LIBNDCTL_PRIVATE_H_
 
diff --git a/ndctl/lib/smart.c b/ndctl/lib/smart.c
index 0e180cff5a3e..265651388f8e 100644
--- a/ndctl/lib/smart.c
+++ b/ndctl/lib/smart.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2016-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdlib.h>
 #include <limits.h>
 #include <util/log.h>
diff --git a/ndctl/libndctl-nfit.h b/ndctl/libndctl-nfit.h
index 8c4f72dfa7ec..b22dbd129a79 100644
--- a/ndctl/libndctl-nfit.h
+++ b/ndctl/libndctl-nfit.h
@@ -1,18 +1,6 @@
-/*
- *
- * Copyright (c) 2017 Hewlett Packard Enterprise Development LP
- * Copyright (c) 2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
-
+// Copyright (c) 2017 Hewlett Packard Enterprise Development LP
+// Copyright (c) 2017 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef __LIBNDCTL_NFIT_H__
 #define __LIBNDCTL_NFIT_H__
 
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 231dbb560996..b11651b35865 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef _LIBNDCTL_H_
 #define _LIBNDCTL_H_
 
diff --git a/ndctl/list.c b/ndctl/list.c
index f98148aea479..1aa97fff1efa 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index 4e9b2236ff3c..7270009083e6 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2018, FUJITSU LIMITED. All rights reserved. */
+// Copyright(c) 2018, FUJITSU LIMITED. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 #include <stdio.h>
 #include <json-c/json.h>
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index e946bb6c9bfa..18417d9e380e 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <fcntl.h>
 #include <errno.h>
diff --git a/ndctl/namespace.h b/ndctl/namespace.h
index 0f17df20ca3a..5f5970cea325 100644
--- a/ndctl/namespace.h
+++ b/ndctl/namespace.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2017, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef __NDCTL_NAMESPACE_H__
 #define __NDCTL_NAMESPACE_H__
 #include <sys/types.h>
diff --git a/ndctl/ndctl.c b/ndctl/ndctl.c
index eb5d8392d8e4..f6596090b064 100644
--- a/ndctl/ndctl.c
+++ b/ndctl/ndctl.c
@@ -1,16 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- * Copyright(c) 2005 Andreas Ericsson. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/ndctl/ndctl.h b/ndctl/ndctl.h
index a47b658f4a57..337202ee29bd 100644
--- a/ndctl/ndctl.h
+++ b/ndctl/ndctl.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef __NDCTL_H__
 #define __NDCTL_H__
 
diff --git a/ndctl/region.c b/ndctl/region.c
index 7945007905fd..93e354541221 100644
--- a/ndctl/region.c
+++ b/ndctl/region.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/ndctl/test.c b/ndctl/test.c
index b78776311125..aaeda6826f87 100644
--- a/ndctl/test.c
+++ b/ndctl/test.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <limits.h>
 #include <syslog.h>
diff --git a/ndctl/util/json-smart.c b/ndctl/util/json-smart.c
index a9bd17b37b4e..d111f1e82f50 100644
--- a/ndctl/util/json-smart.c
+++ b/ndctl/util/json-smart.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <limits.h>
 #include <util/json.h>
 #include <uuid/uuid.h>
diff --git a/test.h b/test.h
index 3f6212e067fc..579eeac3b48c 100644
--- a/test.h
+++ b/test.h
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #ifndef __TEST_H__
 #define __TEST_H__
 #include <stdbool.h>
diff --git a/test/ack-shutdown-count-set.c b/test/ack-shutdown-count-set.c
index 742e976bfa90..4ecbc7fa3000 100644
--- a/test/ack-shutdown-count-set.c
+++ b/test/ack-shutdown-count-set.c
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2018 Intel Corporation. All rights reserved. */
+// Copyright(c) 2018-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 #include <stdio.h>
 #include <stddef.h>
diff --git a/test/blk-exhaust.sh b/test/blk-exhaust.sh
index db7dc25aecbd..9bc6cb0d7522 100755
--- a/test/blk-exhaust.sh
+++ b/test/blk-exhaust.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -x
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-# 
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-# 
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 set -e
 
diff --git a/test/blk_namespaces.c b/test/blk_namespaces.c
index 437fcad0a8f5..8f337a96a64a 100644
--- a/test/blk_namespaces.c
+++ b/test/blk_namespaces.c
@@ -1,17 +1,5 @@
-/*
- * blk_namespaces: tests functionality of multiple block namespaces
- *
- * Copyright (c) 2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2015-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/fs.h>
diff --git a/test/btt-check.sh b/test/btt-check.sh
index bd782f477728..76a73dfc842d 100755
--- a/test/btt-check.sh
+++ b/test/btt-check.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -E
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-# 
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-# 
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 dev=""
 mode=""
diff --git a/test/btt-errors.sh b/test/btt-errors.sh
index a56069789d4b..437f9d21ad6c 100755
--- a/test/btt-errors.sh
+++ b/test/btt-errors.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -x
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 MNT=test_btt_mnt
 FILE=image
diff --git a/test/btt-pad-compat.sh b/test/btt-pad-compat.sh
index b1a46edeaf9d..40cfb01b70d8 100755
--- a/test/btt-pad-compat.sh
+++ b/test/btt-pad-compat.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -Ex
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 dev=""
 size=""
diff --git a/test/clear.sh b/test/clear.sh
index 1fffd166504a..43dd58210375 100755
--- a/test/clear.sh
+++ b/test/clear.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -x
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-# 
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-# 
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 set -e
 
diff --git a/test/core.c b/test/core.c
index 5118d86483d4..47eb4ae3b3b2 100644
--- a/test/core.c
+++ b/test/core.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/version.h>
 #include <sys/utsname.h>
 #include <libkmod.h>
diff --git a/test/create.sh b/test/create.sh
index 520f3a9c1dc1..bc563d0cb333 100755
--- a/test/create.sh
+++ b/test/create.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -x
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-# 
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-# 
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 set -e
 
diff --git a/test/dax-dev.c b/test/dax-dev.c
index ab6b35a67183..c62f607248fd 100644
--- a/test/dax-dev.c
+++ b/test/dax-dev.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdio.h>
 #include <stddef.h>
 #include <stdlib.h>
diff --git a/test/dax-errors.c b/test/dax-errors.c
index fde3ba03546f..a35ecfaa687d 100644
--- a/test/dax-errors.c
+++ b/test/dax-errors.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/mman.h>
diff --git a/test/dax-pmd.c b/test/dax-pmd.c
index df3219639a6d..ecaa871b4971 100644
--- a/test/dax-pmd.c
+++ b/test/dax-pmd.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <unistd.h>
 #include <setjmp.h>
diff --git a/test/dax-poison.c b/test/dax-poison.c
index 69bb161db6d8..320668b4cae8 100644
--- a/test/dax-poison.c
+++ b/test/dax-poison.c
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2018 Intel Corporation. All rights reserved. */
+// Copyright(c) 2018-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <unistd.h>
 #include <signal.h>
diff --git a/test/dax.sh b/test/dax.sh
index 5383c433283f..19dc5a2a5c35 100755
--- a/test/dax.sh
+++ b/test/dax.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -x
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-# 
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-# 
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 . $(dirname $0)/common
 
diff --git a/test/daxdev-errors.c b/test/daxdev-errors.c
index 29de16b0a53d..36a04a5512f5 100644
--- a/test/daxdev-errors.c
+++ b/test/daxdev-errors.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdint.h>
 #include <stdbool.h>
diff --git a/test/daxdev-errors.sh b/test/daxdev-errors.sh
index 15d3e67d1166..9f5616dc9fcb 100755
--- a/test/daxdev-errors.sh
+++ b/test/daxdev-errors.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -x
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-# 
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-# 
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 set -e
 
diff --git a/test/device-dax-fio.sh b/test/device-dax-fio.sh
index d4ca7ab238e4..1ac258396ef0 100755
--- a/test/device-dax-fio.sh
+++ b/test/device-dax-fio.sh
@@ -1,15 +1,7 @@
 #!/bin/bash
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-# 
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-# 
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 . $(dirname $0)/common
 
diff --git a/test/device-dax.c b/test/device-dax.c
index 9de10682e34d..a3ae70985630 100644
--- a/test/device-dax.c
+++ b/test/device-dax.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <fcntl.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index b757b9ad9c2c..7010f66e09a2 100644
--- a/test/dpa-alloc.c
+++ b/test/dpa-alloc.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdio.h>
 #include <stddef.h>
 #include <stdlib.h>
diff --git a/test/dsm-fail.c b/test/dsm-fail.c
index b2c51db4aa3a..bcabae86c2bc 100644
--- a/test/dsm-fail.c
+++ b/test/dsm-fail.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdio.h>
 #include <stddef.h>
 #include <stdlib.h>
diff --git a/test/inject-error.sh b/test/inject-error.sh
index 5667b5131c7a..92e5fefa4a80 100755
--- a/test/inject-error.sh
+++ b/test/inject-error.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -Ex
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 dev=""
 size=""
diff --git a/test/label-compat.sh b/test/label-compat.sh
index a29dd1367233..3f17f75f454d 100755
--- a/test/label-compat.sh
+++ b/test/label-compat.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -x
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-# 
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-# 
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 set -e
 
diff --git a/test/libndctl.c b/test/libndctl.c
index 994e0fadf4f7..a75a965b93f1 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdio.h>
 #include <stddef.h>
 #include <stdlib.h>
diff --git a/test/list-smart-dimm.c b/test/list-smart-dimm.c
index c9982d50f1ad..669318d3be7c 100644
--- a/test/list-smart-dimm.c
+++ b/test/list-smart-dimm.c
@@ -1,6 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2018, FUJITSU LIMITED. All rights reserved. */
-
+// Copyright(c) 2018, FUJITSU LIMITED. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <errno.h>
 #include <util/json.h>
diff --git a/test/mmap.c b/test/mmap.c
index b087ba872ba9..23ef669abbce 100644
--- a/test/mmap.c
+++ b/test/mmap.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015 Toshi Kani, Hewlett Packard Enterprise. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015 Toshi Kani, Hewlett Packard Enterprise. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
diff --git a/test/mmap.sh b/test/mmap.sh
index 0bcc35f619f5..ef11696cf1d4 100755
--- a/test/mmap.sh
+++ b/test/mmap.sh
@@ -1,15 +1,7 @@
 #!/bin/bash
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-# 
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-# 
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 . $(dirname $0)/common
 
diff --git a/test/multi-dax.sh b/test/multi-dax.sh
index 110ba3d80339..39e9e4e111d7 100755
--- a/test/multi-dax.sh
+++ b/test/multi-dax.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -x
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 set -e
 
diff --git a/test/multi-pmem.c b/test/multi-pmem.c
index cb7cd4033f37..c31780f26b3e 100644
--- a/test/multi-pmem.c
+++ b/test/multi-pmem.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/test/parent-uuid.c b/test/parent-uuid.c
index f41ca2c7bd75..33568afc0b62 100644
--- a/test/parent-uuid.c
+++ b/test/parent-uuid.c
@@ -1,17 +1,5 @@
-/*
- * blk_namespaces: tests functionality of multiple block namespaces
- *
- * Copyright (c) 2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2015-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdio.h>
 #include <stddef.h>
 #include <stdlib.h>
diff --git a/test/pmem_namespaces.c b/test/pmem_namespaces.c
index eac56ce25d58..34dcf386acbb 100644
--- a/test/pmem_namespaces.c
+++ b/test/pmem_namespaces.c
@@ -1,17 +1,5 @@
-/*
- * pmem_namespaces: test functionality of PMEM namespaces
- *
- * Copyright (c) 2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2015-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/fs.h>
diff --git a/test/sector-mode.sh b/test/sector-mode.sh
index eef8dc6d6a3e..6374e18597a2 100755
--- a/test/sector-mode.sh
+++ b/test/sector-mode.sh
@@ -1,15 +1,7 @@
 #!/bin/bash -x
 
-# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
+# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0
 
 rc=77
 
diff --git a/test/smart-listen.c b/test/smart-listen.c
index e365ce54c7bd..a42428ab6e58 100644
--- a/test/smart-listen.c
+++ b/test/smart-listen.c
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2017 Intel Corporation. All rights reserved. */
+// Copyright(c) 2017-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <poll.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/test/smart-notify.c b/test/smart-notify.c
index e28e0f414efd..8312706ef2d5 100644
--- a/test/smart-notify.c
+++ b/test/smart-notify.c
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2017 Intel Corporation. All rights reserved. */
+// Copyright(c) 2017-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
diff --git a/util/COPYING b/util/COPYING
deleted file mode 100644
index 3912109b5cd6..000000000000
--- a/util/COPYING
+++ /dev/null
@@ -1,340 +0,0 @@
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
-
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- Everyone is permitted to copy and distribute verbatim copies
- of this license document, but changing it is not allowed.
-
-			    Preamble
-
-  The licenses for most software are designed to take away your
-freedom to share and change it.  By contrast, the GNU General Public
-License is intended to guarantee your freedom to share and change free
-software--to make sure the software is free for all its users.  This
-General Public License applies to most of the Free Software
-Foundation's software and to any other program whose authors commit to
-using it.  (Some other Free Software Foundation software is covered by
-the GNU Library General Public License instead.)  You can apply it to
-your programs, too.
-
-  When we speak of free software, we are referring to freedom, not
-price.  Our General Public Licenses are designed to make sure that you
-have the freedom to distribute copies of free software (and charge for
-this service if you wish), that you receive source code or can get it
-if you want it, that you can change the software or use pieces of it
-in new free programs; and that you know you can do these things.
-
-  To protect your rights, we need to make restrictions that forbid
-anyone to deny you these rights or to ask you to surrender the rights.
-These restrictions translate to certain responsibilities for you if you
-distribute copies of the software, or if you modify it.
-
-  For example, if you distribute copies of such a program, whether
-gratis or for a fee, you must give the recipients all the rights that
-you have.  You must make sure that they, too, receive or can get the
-source code.  And you must show them these terms so they know their
-rights.
-
-  We protect your rights with two steps: (1) copyright the software, and
-(2) offer you this license which gives you legal permission to copy,
-distribute and/or modify the software.
-
-  Also, for each author's protection and ours, we want to make certain
-that everyone understands that there is no warranty for this free
-software.  If the software is modified by someone else and passed on, we
-want its recipients to know that what they have is not the original, so
-that any problems introduced by others will not reflect on the original
-authors' reputations.
-
-  Finally, any free program is threatened constantly by software
-patents.  We wish to avoid the danger that redistributors of a free
-program will individually obtain patent licenses, in effect making the
-program proprietary.  To prevent this, we have made it clear that any
-patent must be licensed for everyone's free use or not licensed at all.
-
-  The precise terms and conditions for copying, distribution and
-modification follow.
-
-		    GNU GENERAL PUBLIC LICENSE
-   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
-
-  0. This License applies to any program or other work which contains
-a notice placed by the copyright holder saying it may be distributed
-under the terms of this General Public License.  The "Program", below,
-refers to any such program or work, and a "work based on the Program"
-means either the Program or any derivative work under copyright law:
-that is to say, a work containing the Program or a portion of it,
-either verbatim or with modifications and/or translated into another
-language.  (Hereinafter, translation is included without limitation in
-the term "modification".)  Each licensee is addressed as "you".
-
-Activities other than copying, distribution and modification are not
-covered by this License; they are outside its scope.  The act of
-running the Program is not restricted, and the output from the Program
-is covered only if its contents constitute a work based on the
-Program (independent of having been made by running the Program).
-Whether that is true depends on what the Program does.
-
-  1. You may copy and distribute verbatim copies of the Program's
-source code as you receive it, in any medium, provided that you
-conspicuously and appropriately publish on each copy an appropriate
-copyright notice and disclaimer of warranty; keep intact all the
-notices that refer to this License and to the absence of any warranty;
-and give any other recipients of the Program a copy of this License
-along with the Program.
-
-You may charge a fee for the physical act of transferring a copy, and
-you may at your option offer warranty protection in exchange for a fee.
-
-  2. You may modify your copy or copies of the Program or any portion
-of it, thus forming a work based on the Program, and copy and
-distribute such modifications or work under the terms of Section 1
-above, provided that you also meet all of these conditions:
-
-    a) You must cause the modified files to carry prominent notices
-    stating that you changed the files and the date of any change.
-
-    b) You must cause any work that you distribute or publish, that in
-    whole or in part contains or is derived from the Program or any
-    part thereof, to be licensed as a whole at no charge to all third
-    parties under the terms of this License.
-
-    c) If the modified program normally reads commands interactively
-    when run, you must cause it, when started running for such
-    interactive use in the most ordinary way, to print or display an
-    announcement including an appropriate copyright notice and a
-    notice that there is no warranty (or else, saying that you provide
-    a warranty) and that users may redistribute the program under
-    these conditions, and telling the user how to view a copy of this
-    License.  (Exception: if the Program itself is interactive but
-    does not normally print such an announcement, your work based on
-    the Program is not required to print an announcement.)
-
-These requirements apply to the modified work as a whole.  If
-identifiable sections of that work are not derived from the Program,
-and can be reasonably considered independent and separate works in
-themselves, then this License, and its terms, do not apply to those
-sections when you distribute them as separate works.  But when you
-distribute the same sections as part of a whole which is a work based
-on the Program, the distribution of the whole must be on the terms of
-this License, whose permissions for other licensees extend to the
-entire whole, and thus to each and every part regardless of who wrote it.
-
-Thus, it is not the intent of this section to claim rights or contest
-your rights to work written entirely by you; rather, the intent is to
-exercise the right to control the distribution of derivative or
-collective works based on the Program.
-
-In addition, mere aggregation of another work not based on the Program
-with the Program (or with a work based on the Program) on a volume of
-a storage or distribution medium does not bring the other work under
-the scope of this License.
-
-  3. You may copy and distribute the Program (or a work based on it,
-under Section 2) in object code or executable form under the terms of
-Sections 1 and 2 above provided that you also do one of the following:
-
-    a) Accompany it with the complete corresponding machine-readable
-    source code, which must be distributed under the terms of Sections
-    1 and 2 above on a medium customarily used for software interchange; or,
-
-    b) Accompany it with a written offer, valid for at least three
-    years, to give any third party, for a charge no more than your
-    cost of physically performing source distribution, a complete
-    machine-readable copy of the corresponding source code, to be
-    distributed under the terms of Sections 1 and 2 above on a medium
-    customarily used for software interchange; or,
-
-    c) Accompany it with the information you received as to the offer
-    to distribute corresponding source code.  (This alternative is
-    allowed only for noncommercial distribution and only if you
-    received the program in object code or executable form with such
-    an offer, in accord with Subsection b above.)
-
-The source code for a work means the preferred form of the work for
-making modifications to it.  For an executable work, complete source
-code means all the source code for all modules it contains, plus any
-associated interface definition files, plus the scripts used to
-control compilation and installation of the executable.  However, as a
-special exception, the source code distributed need not include
-anything that is normally distributed (in either source or binary
-form) with the major components (compiler, kernel, and so on) of the
-operating system on which the executable runs, unless that component
-itself accompanies the executable.
-
-If distribution of executable or object code is made by offering
-access to copy from a designated place, then offering equivalent
-access to copy the source code from the same place counts as
-distribution of the source code, even though third parties are not
-compelled to copy the source along with the object code.
-
-  4. You may not copy, modify, sublicense, or distribute the Program
-except as expressly provided under this License.  Any attempt
-otherwise to copy, modify, sublicense or distribute the Program is
-void, and will automatically terminate your rights under this License.
-However, parties who have received copies, or rights, from you under
-this License will not have their licenses terminated so long as such
-parties remain in full compliance.
-
-  5. You are not required to accept this License, since you have not
-signed it.  However, nothing else grants you permission to modify or
-distribute the Program or its derivative works.  These actions are
-prohibited by law if you do not accept this License.  Therefore, by
-modifying or distributing the Program (or any work based on the
-Program), you indicate your acceptance of this License to do so, and
-all its terms and conditions for copying, distributing or modifying
-the Program or works based on it.
-
-  6. Each time you redistribute the Program (or any work based on the
-Program), the recipient automatically receives a license from the
-original licensor to copy, distribute or modify the Program subject to
-these terms and conditions.  You may not impose any further
-restrictions on the recipients' exercise of the rights granted herein.
-You are not responsible for enforcing compliance by third parties to
-this License.
-
-  7. If, as a consequence of a court judgment or allegation of patent
-infringement or for any other reason (not limited to patent issues),
-conditions are imposed on you (whether by court order, agreement or
-otherwise) that contradict the conditions of this License, they do not
-excuse you from the conditions of this License.  If you cannot
-distribute so as to satisfy simultaneously your obligations under this
-License and any other pertinent obligations, then as a consequence you
-may not distribute the Program at all.  For example, if a patent
-license would not permit royalty-free redistribution of the Program by
-all those who receive copies directly or indirectly through you, then
-the only way you could satisfy both it and this License would be to
-refrain entirely from distribution of the Program.
-
-If any portion of this section is held invalid or unenforceable under
-any particular circumstance, the balance of the section is intended to
-apply and the section as a whole is intended to apply in other
-circumstances.
-
-It is not the purpose of this section to induce you to infringe any
-patents or other property right claims or to contest validity of any
-such claims; this section has the sole purpose of protecting the
-integrity of the free software distribution system, which is
-implemented by public license practices.  Many people have made
-generous contributions to the wide range of software distributed
-through that system in reliance on consistent application of that
-system; it is up to the author/donor to decide if he or she is willing
-to distribute software through any other system and a licensee cannot
-impose that choice.
-
-This section is intended to make thoroughly clear what is believed to
-be a consequence of the rest of this License.
-
-  8. If the distribution and/or use of the Program is restricted in
-certain countries either by patents or by copyrighted interfaces, the
-original copyright holder who places the Program under this License
-may add an explicit geographical distribution limitation excluding
-those countries, so that distribution is permitted only in or among
-countries not thus excluded.  In such case, this License incorporates
-the limitation as if written in the body of this License.
-
-  9. The Free Software Foundation may publish revised and/or new versions
-of the General Public License from time to time.  Such new versions will
-be similar in spirit to the present version, but may differ in detail to
-address new problems or concerns.
-
-Each version is given a distinguishing version number.  If the Program
-specifies a version number of this License which applies to it and "any
-later version", you have the option of following the terms and conditions
-either of that version or of any later version published by the Free
-Software Foundation.  If the Program does not specify a version number of
-this License, you may choose any version ever published by the Free Software
-Foundation.
-
-  10. If you wish to incorporate parts of the Program into other free
-programs whose distribution conditions are different, write to the author
-to ask for permission.  For software which is copyrighted by the Free
-Software Foundation, write to the Free Software Foundation; we sometimes
-make exceptions for this.  Our decision will be guided by the two goals
-of preserving the free status of all derivatives of our free software and
-of promoting the sharing and reuse of software generally.
-
-			    NO WARRANTY
-
-  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
-FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
-OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
-PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
-OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
-MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
-TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
-PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
-REPAIR OR CORRECTION.
-
-  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
-WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
-REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
-INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
-OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
-TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
-YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
-PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
-POSSIBILITY OF SUCH DAMAGES.
-
-		     END OF TERMS AND CONDITIONS
-
-	    How to Apply These Terms to Your New Programs
-
-  If you develop a new program, and you want it to be of the greatest
-possible use to the public, the best way to achieve this is to make it
-free software which everyone can redistribute and change under these terms.
-
-  To do so, attach the following notices to the program.  It is safest
-to attach them to the start of each source file to most effectively
-convey the exclusion of warranty; and each file should have at least
-the "copyright" line and a pointer to where the full notice is found.
-
-    <one line to give the program's name and a brief idea of what it does.>
-    Copyright (C) <year>  <name of author>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-
-
-Also add information on how to contact you by electronic and paper mail.
-
-If the program is interactive, make it output a short notice like this
-when it starts in an interactive mode:
-
-    Gnomovision version 69, Copyright (C) year name of author
-    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
-    This is free software, and you are welcome to redistribute it
-    under certain conditions; type `show c' for details.
-
-The hypothetical commands `show w' and `show c' should show the appropriate
-parts of the General Public License.  Of course, the commands you use may
-be called something other than `show w' and `show c'; they could even be
-mouse-clicks or menu items--whatever suits your program.
-
-You should also get your employer (if you work as a programmer) or your
-school, if any, to sign a "copyright disclaimer" for the program, if
-necessary.  Here is a sample; alter the names:
-
-  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
-  `Gnomovision' (which makes passes at compilers) written by James Hacker.
-
-  <signature of Ty Coon>, 1 April 1989
-  Ty Coon, President of Vice
-
-This General Public License does not permit incorporating your program into
-proprietary programs.  If your program is a subroutine library, you may
-consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Library General
-Public License instead of this License.
diff --git a/util/abspath.c b/util/abspath.c
index e44236fa0da5..d59cc5d7bbf7 100644
--- a/util/abspath.c
+++ b/util/abspath.c
@@ -1,4 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
+
 /* originally copied from git/abspath.c */
 
 #include <util/util.h>
diff --git a/util/bitmap.c b/util/bitmap.c
index 8df8a3253f10..86b5d02f8411 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -1,16 +1,6 @@
-/*
- * Copyright(c) 2017 Intel Corporation. All rights reserved.
- * Copyright(c) 2009 Akinobu Mita. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2017 Intel Corporation. All rights reserved.
+// Copyright(c) 2009 Akinobu Mita. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from the Linux kernel bitmap implementation */
 
diff --git a/util/bitmap.h b/util/bitmap.h
index 11ef22cc657b..4783245adadb 100644
--- a/util/bitmap.h
+++ b/util/bitmap.h
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #ifndef _NDCTL_BITMAP_H_
 #define _NDCTL_BITMAP_H_
 
diff --git a/util/filter.c b/util/filter.c
index 7c8debb3d42e..aa602f473b92 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/util/filter.h b/util/filter.h
index ad3441cc3a16..939a39c52af3 100644
--- a/util/filter.h
+++ b/util/filter.h
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #ifndef _UTIL_FILTER_H_
 #define _UTIL_FILTER_H_
 #include <stdbool.h>
diff --git a/util/help.c b/util/help.c
index 2d57fa17791c..11b413eb2b1c 100644
--- a/util/help.c
+++ b/util/help.c
@@ -1,17 +1,7 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- * Copyright(c) 2008 Miklos Vajna. All rights reserved.
- * Copyright(c) 2006 Linus Torvalds. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// Copyright(c) 2008 Miklos Vajna. All rights reserved.
+// Copyright(c) 2006 Linus Torvalds. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/util/iomem.c b/util/iomem.c
index a3c23f5a9d1d..a5cd77bc670e 100644
--- a/util/iomem.c
+++ b/util/iomem.c
@@ -1,6 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
-
+// Copyright(c) 2019-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
diff --git a/util/iomem.h b/util/iomem.h
index aaaf6a7026a5..70cef7816d12 100644
--- a/util/iomem.h
+++ b/util/iomem.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
+// Copyright(c) 2019-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #ifndef _NDCTL_IOMEM_H_
 #define _NDCTL_IOMEM_H_
 
diff --git a/util/json.c b/util/json.c
index 77bd4781551d..c928bf35a956 100644
--- a/util/json.c
+++ b/util/json.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <limits.h>
 #include <string.h>
 #include <util/json.h>
diff --git a/util/json.h b/util/json.h
index 39a33789bac9..30e229c62538 100644
--- a/util/json.h
+++ b/util/json.h
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #ifndef __NDCTL_JSON_H__
 #define __NDCTL_JSON_H__
 #include <stdio.h>
diff --git a/util/list.h b/util/list.h
index 6439aeff171e..17c78f44cbe0 100644
--- a/util/list.h
+++ b/util/list.h
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #ifndef _NDCTL_LIST_H_
 #define _NDCTL_LIST_H_
 
diff --git a/util/log.c b/util/log.c
index c60ca3318e5b..a666861ef44e 100644
--- a/util/log.c
+++ b/util/log.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2016-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <syslog.h>
 #include <stdlib.h>
 #include <ctype.h>
diff --git a/util/log.h b/util/log.h
index 495e0d33c7f5..bf45771bb6de 100644
--- a/util/log.h
+++ b/util/log.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2016-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef __UTIL_LOG_H__
 #define __UTIL_LOG_H__
 #include <stdio.h>
diff --git a/util/main.c b/util/main.c
index 4f925f84966a..7e4012e23084 100644
--- a/util/main.c
+++ b/util/main.c
@@ -1,16 +1,6 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- * Copyright(c) 2006 Linus Torvalds. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// Copyright(c) 2006 Linus Torvalds. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/util/main.h b/util/main.h
index 35fb33e63049..8d5381b821e3 100644
--- a/util/main.h
+++ b/util/main.h
@@ -1,16 +1,6 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- * Copyright(c) 2006 Linus Torvalds. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// Copyright(c) 2006 Linus Torvalds. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/util/parse-options.c b/util/parse-options.c
index c78117426807..6ea581aa3b3c 100644
--- a/util/parse-options.c
+++ b/util/parse-options.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2007 Pierre Habouzit. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2007 Pierre Habouzit. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/util/parse-options.h b/util/parse-options.h
index fc5015a9c9c2..401de2962dda 100644
--- a/util/parse-options.h
+++ b/util/parse-options.h
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2007 Pierre Habouzit. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2007 Pierre Habouzit. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/util/size.c b/util/size.c
index 6efa91f6eef9..29aa2be8185b 100644
--- a/util/size.c
+++ b/util/size.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 #include <limits.h>
 #include <util/size.h>
diff --git a/util/size.h b/util/size.h
index 2138989b42ac..9274c567164d 100644
--- a/util/size.h
+++ b/util/size.h
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 #ifndef _NDCTL_SIZE_H_
 #define _NDCTL_SIZE_H_
diff --git a/util/strbuf.c b/util/strbuf.c
index eaa5bedf7e60..219c4756bd28 100644
--- a/util/strbuf.c
+++ b/util/strbuf.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2005 Junio C Hamano. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2005 Junio C Hamano. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/util/strbuf.h b/util/strbuf.h
index 4cf8348dfd55..0fc4813f4699 100644
--- a/util/strbuf.h
+++ b/util/strbuf.h
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2005 Junio C Hamano. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2005 Junio C Hamano. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/util/sysfs.c b/util/sysfs.c
index 9f7bc1f4930f..51ff36aeeafa 100644
--- a/util/sysfs.c
+++ b/util/sysfs.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #include <stdio.h>
 #include <stdlib.h>
 #include <stddef.h>
diff --git a/util/sysfs.h b/util/sysfs.h
index fb169c6da80a..5561f74d0109 100644
--- a/util/sysfs.h
+++ b/util/sysfs.h
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT ANY
- * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
- * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
- * more details.
- */
+// Copyright (c) 2014-2020, Intel Corporation. All rights reserved.
+// SPDX-License-Identifier: LGPL-2.1
 #ifndef __UTIL_SYSFS_H__
 #define __UTIL_SYSFS_H__
 
diff --git a/util/usage.c b/util/usage.c
index 0896955c7f52..827a5abbe0b0 100644
--- a/util/usage.c
+++ b/util/usage.c
@@ -1,15 +1,5 @@
-/*
- * Copyright(c) 2005 Linus Torvalds. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2005 Linus Torvalds. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/util/util.h b/util/util.h
index 54c6ef18b6d7..8519ec80906f 100644
--- a/util/util.h
+++ b/util/util.h
@@ -1,16 +1,6 @@
-/*
- * Copyright(c) 2005 Junio C Hamano. All rights reserved.
- * Copyright(c) 2005 Linus Torvalds. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2005 Junio C Hamano. All rights reserved.
+// Copyright(c) 2005 Linus Torvalds. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
diff --git a/util/wrapper.c b/util/wrapper.c
index b0de7bc92bb1..2ff9eb9b231f 100644
--- a/util/wrapper.c
+++ b/util/wrapper.c
@@ -1,16 +1,6 @@
-/*
- * Copyright(c) 2005 Junio C Hamano. All rights reserved.
- * Copyright(c) 2005 Linus Torvalds. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// Copyright(c) 2005 Junio C Hamano. All rights reserved.
+// Copyright(c) 2005 Linus Torvalds. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
 
 /* originally copied from perf and git */
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

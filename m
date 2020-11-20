Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 966672BB232
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 19:14:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 987E3100ED483;
	Fri, 20 Nov 2020 10:14:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7237100ED480
	for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 10:14:13 -0800 (PST)
IronPort-SDR: dF5wITwraVKTwgOW3BrPFgYt7ga9vJrNDsMaFk1AawVtxxxuwKtNIVIJwaLUcT77fizp5I2z2+
 YvF7FE5yo/gA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168947428"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400";
   d="scan'208";a="168947428"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 10:14:12 -0800
IronPort-SDR: mu2CCLC/wWESsi7Vb+SnzOfGx0n3lCxfMGRjoDxWNZSJZXtfEjcCcvZ+gwyFD8lIk0adLJQp4Q
 12uyXnxmPj3Q==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400";
   d="scan'208";a="545534589"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 10:14:11 -0800
Date: Fri, 20 Nov 2020 10:14:11 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v2] Rework license identification
Message-ID: <20201120181411.GD1161629@iweiny-DESK2.sc.intel.com>
References: <160583961173.3214145.10949977506713013931.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <160583961173.3214145.10949977506713013931.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: NUKRDDSLN4WVHSVVYDC6GOHTM7SU5NCF
X-Message-ID-Hash: NUKRDDSLN4WVHSVVYDC6GOHTM7SU5NCF
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Christoph Hellwig <hch@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NUKRDDSLN4WVHSVVYDC6GOHTM7SU5NCF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 19, 2020 at 06:34:01PM -0800, Dan Williams wrote:
> Convert to the LICENSES/ directory format for COPYING from the Linux
> kernel, and switch all remaining files over to SPDX annotations.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>

LGTM

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Reported-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v1 [1]:
> - (Ira) some date updates to 2020 were missed
> - (Ira) fix a dropped copyright
> - Switch SPDX comment style to // in C files and /* */ in headers like
>   the kernel.
> - Make sure SPDX identifier is the first line in the file, or second for
>   scripts
> 
> [1]: http://lore.kernel.org/r/160321640031.3386448.4879860972349220888.stgit@dwillia2-desk3.amr.corp.intel.com
> 
>  COPYING                          |   31 +++
>  Documentation/copyright.txt      |    2 
>  Documentation/daxctl/Makefile.am |   12 -
>  Documentation/ndctl/Makefile.am  |   12 -
>  LICENSES/other/CC0-1.0           |    0 
>  LICENSES/other/MIT               |    0 
>  LICENSES/preferred/GPL-2.0       |    0 
>  LICENSES/preferred/LGPL-2.1      |    0 
>  acpi.h                           |   16 --
>  ccan/array_size/LICENSE          |    1 
>  ccan/array_size/array_size.h     |    2 
>  ccan/build_assert/LICENSE        |    1 
>  ccan/build_assert/build_assert.h |    2 
>  ccan/check_type/LICENSE          |    1 
>  ccan/check_type/check_type.h     |    2 
>  ccan/container_of/LICENSE        |    1 
>  ccan/container_of/container_of.h |    2 
>  ccan/endian/LICENSE              |    1 
>  ccan/endian/endian.h             |    2 
>  ccan/list/LICENSE                |    1 
>  ccan/list/list.c                 |    2 
>  ccan/list/list.h                 |    2 
>  ccan/minmax/LICENSE              |    1 
>  ccan/minmax/minmax.h             |    2 
>  ccan/short_types/LICENSE         |    1 
>  ccan/short_types/short_types.h   |    2 
>  ccan/str/LICENSE                 |    1 
>  ccan/str/debug.c                 |    2 
>  ccan/str/str.c                   |    2 
>  ccan/str/str.h                   |    2 
>  ccan/str/str_debug.h             |    2 
>  contrib/daxctl-qemu-hmat-setup   |    3 
>  daxctl/acpi.c                    |    2 
>  daxctl/builtin.h                 |    2 
>  daxctl/daxctl.c                  |   16 --
>  daxctl/device.c                  |    2 
>  daxctl/lib/libdaxctl-private.h   |   14 --
>  daxctl/lib/libdaxctl.c           |   14 --
>  daxctl/libdaxctl.h               |   14 --
>  daxctl/list.c                    |   14 --
>  daxctl/migrate.c                 |    4 
>  ndctl/action.h                   |    7 -
>  ndctl/bat.c                      |   14 --
>  ndctl/builtin.h                  |    2 
>  ndctl/bus.c                      |    4 
>  ndctl/check.c                    |   14 --
>  ndctl/create-nfit.c              |   14 --
>  ndctl/dimm.c                     |   14 --
>  ndctl/firmware-update.h          |    2 
>  ndctl/inject-error.c             |   14 --
>  ndctl/inject-smart.c             |    4 
>  ndctl/lib/ars.c                  |   14 --
>  ndctl/lib/dimm.c                 |   14 --
>  ndctl/lib/firmware.c             |    4 
>  ndctl/lib/hpe1.c                 |   16 --
>  ndctl/lib/hpe1.h                 |   16 --
>  ndctl/lib/hyperv.c               |    2 
>  ndctl/lib/hyperv.h               |    4 
>  ndctl/lib/inject.c               |   14 --
>  ndctl/lib/intel.c                |   14 --
>  ndctl/lib/intel.h                |    2 
>  ndctl/lib/libndctl.c             |   14 --
>  ndctl/lib/msft.c                 |   18 --
>  ndctl/lib/msft.h                 |   18 --
>  ndctl/lib/nfit.c                 |   14 --
>  ndctl/lib/private.h              |   14 --
>  ndctl/lib/smart.c                |   14 --
>  ndctl/libndctl-nfit.h            |   18 --
>  ndctl/libndctl.h                 |   14 --
>  ndctl/list.c                     |   14 --
>  ndctl/load-keys.c                |    2 
>  ndctl/monitor.c                  |    4 
>  ndctl/namespace.c                |   14 --
>  ndctl/namespace.h                |   14 --
>  ndctl/ndctl.c                    |   15 --
>  ndctl/ndctl.h                    |   14 --
>  ndctl/region.c                   |   14 --
>  ndctl/test.c                     |   14 --
>  ndctl/util/json-smart.c          |   14 --
>  ndctl/util/keys.c                |    2 
>  ndctl/util/keys.h                |    4 
>  sles/header                      |    4 
>  test.h                           |   14 --
>  test/ack-shutdown-count-set.c    |    4 
>  test/align.sh                    |    2 
>  test/blk-exhaust.sh              |   13 -
>  test/blk_namespaces.c            |   16 --
>  test/btt-check.sh                |   13 -
>  test/btt-errors.sh               |   13 -
>  test/btt-pad-compat.sh           |   13 -
>  test/clear.sh                    |   13 -
>  test/common                      |    3 
>  test/core.c                      |   14 --
>  test/create.sh                   |   13 -
>  test/dax-dev.c                   |   14 --
>  test/dax-errors.c                |   14 --
>  test/dax-pmd.c                   |   14 --
>  test/dax-poison.c                |    4 
>  test/dax.sh                      |   13 -
>  test/daxctl-create.sh            |    2 
>  test/daxctl-devices.sh           |    2 
>  test/daxdev-errors.c             |   14 --
>  test/daxdev-errors.sh            |   13 -
>  test/device-dax-fio.sh           |   13 -
>  test/device-dax.c                |   14 --
>  test/dm.sh                       |    2 
>  test/dpa-alloc.c                 |   14 --
>  test/dsm-fail.c                  |   14 --
>  test/firmware-update.sh          |    2 
>  test/inject-error.sh             |   13 -
>  test/inject-smart.sh             |    2 
>  test/label-compat.sh             |   13 -
>  test/libndctl.c                  |   14 --
>  test/list-smart-dimm.c           |    5 -
>  test/max_available_extent_ns.sh  |    3 
>  test/mmap.c                      |   14 --
>  test/mmap.sh                     |   13 -
>  test/monitor.sh                  |    3 
>  test/multi-dax.sh                |   13 -
>  test/multi-pmem.c                |   14 --
>  test/parent-uuid.c               |   16 --
>  test/pfn-meta-errors.sh          |    3 
>  test/pmem-errors.sh              |    2 
>  test/pmem_namespaces.c           |   16 --
>  test/rescan-partitions.sh        |    2 
>  test/revoke-devmem.c             |    2 
>  test/sector-mode.sh              |   13 -
>  test/security.sh                 |    2 
>  test/smart-listen.c              |    4 
>  test/smart-notify.c              |    4 
>  test/sub-section.sh              |    2 
>  test/track-uuid.sh               |    2 
>  util/COPYING                     |  340 --------------------------------------
>  util/abspath.c                   |    3 
>  util/bitmap.c                    |   16 --
>  util/bitmap.h                    |   14 --
>  util/filter.c                    |   14 --
>  util/filter.h                    |   14 --
>  util/help.c                      |   18 --
>  util/iomem.c                     |    5 -
>  util/iomem.h                     |    2 
>  util/json.c                      |   14 --
>  util/json.h                      |   14 --
>  util/list.h                      |   14 --
>  util/log.c                       |   14 --
>  util/log.h                       |   14 --
>  util/main.c                      |   16 --
>  util/main.h                      |   16 --
>  util/parse-options.c             |   14 --
>  util/parse-options.h             |   14 --
>  util/size.c                      |   14 --
>  util/size.h                      |   14 --
>  util/strbuf.c                    |   14 --
>  util/strbuf.h                    |   14 --
>  util/sysfs.c                     |   14 --
>  util/sysfs.h                     |   14 --
>  util/usage.c                     |   14 --
>  util/util.h                      |   16 --
>  util/wrapper.c                   |   16 --
>  159 files changed, 287 insertions(+), 1489 deletions(-)
>  rename licenses/CC0 => LICENSES/other/CC0-1.0 (100%)
>  rename licenses/BSD-MIT => LICENSES/other/MIT (100%)
>  rename COPYING.tools => LICENSES/preferred/GPL-2.0 (100%)
>  rename COPYING.libraries => LICENSES/preferred/LGPL-2.1 (100%)
>  delete mode 120000 ccan/array_size/LICENSE
>  delete mode 120000 ccan/build_assert/LICENSE
>  delete mode 120000 ccan/check_type/LICENSE
>  delete mode 120000 ccan/container_of/LICENSE
>  delete mode 120000 ccan/endian/LICENSE
>  delete mode 120000 ccan/list/LICENSE
>  delete mode 120000 ccan/minmax/LICENSE
>  delete mode 120000 ccan/short_types/LICENSE
>  delete mode 120000 ccan/str/LICENSE
>  delete mode 100644 util/COPYING
> 
> diff --git a/COPYING b/COPYING
> index 7e705e83d220..0ec3b27e48cc 100644
> --- a/COPYING
> +++ b/COPYING
> @@ -1,6 +1,25 @@
> -This project has 2 classes of binaries, "tools" like ndctl and daxctl,
> -and "libraries" like libndctl and libdaxctl. The libraries are licensed
> -LGPLv2.1 for third-party application linking. See COPYING.libraries for
> -the full license. The "tools" are licensed GPLv2 to provide a command
> -line interface to the C libraries. See COPYING.tools for the full
> -license.
> +The ndctl project provides tools under:
> +
> +	SPDX-License-Identifier: GPL-2.0
> +
> +Being under the terms of the GNU General Public License version 2 only,
> +according with:
> +
> +	LICENSES/preferred/GPL-2.0
> +
> +The ndctl project provides libraries under:
> +
> +	SPDX-License-Identifier: LGPL-2.1
> +
> +Being under the terms of the GNU Lesser General Public License version
> +2.1 only, according with:
> +
> +	LICENSES/preferred/LGPL-2.1
> +
> +The project incorporates helper routines from the CCAN project under
> +CC0-1.0 and MIT licenses according with:
> +
> +	LICENSES/other/CC0-1.0
> +	LICENSES/other/MIT
> +
> +All contributions to the ndctl project are subject to this COPYING file.
> diff --git a/Documentation/copyright.txt b/Documentation/copyright.txt
> index 760a5be9779e..a9380e199750 100644
> --- a/Documentation/copyright.txt
> +++ b/Documentation/copyright.txt
> @@ -2,7 +2,7 @@
>  
>  COPYRIGHT
>  ---------
> -Copyright (c) 2016 - 2020, Intel Corporation. License GPLv2: GNU GPL
> +Copyright (C) 2016 - 2020, Intel Corporation. License GPLv2: GNU GPL
>  version 2 <http://gnu.org/licenses/gpl.html>.  This is free software:
>  you are free to change and redistribute it.  There is NO WARRANTY, to
>  the extent permitted by law.
> diff --git a/Documentation/daxctl/Makefile.am b/Documentation/daxctl/Makefile.am
> index 7696e23cc9c0..3265e71b914c 100644
> --- a/Documentation/daxctl/Makefile.am
> +++ b/Documentation/daxctl/Makefile.am
> @@ -1,13 +1,5 @@
> -# Copyright(c) 2015-2017 Intel Corporation.
> -#
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  if USE_ASCIIDOCTOR
>  
> diff --git a/Documentation/ndctl/Makefile.am b/Documentation/ndctl/Makefile.am
> index 0278c783ea66..f0d5b213057c 100644
> --- a/Documentation/ndctl/Makefile.am
> +++ b/Documentation/ndctl/Makefile.am
> @@ -1,13 +1,5 @@
> -# Copyright(c) 2015-2017 Intel Corporation.
> -#
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  if USE_ASCIIDOCTOR
>  
> diff --git a/licenses/CC0 b/LICENSES/other/CC0-1.0
> similarity index 100%
> rename from licenses/CC0
> rename to LICENSES/other/CC0-1.0
> diff --git a/licenses/BSD-MIT b/LICENSES/other/MIT
> similarity index 100%
> rename from licenses/BSD-MIT
> rename to LICENSES/other/MIT
> diff --git a/COPYING.tools b/LICENSES/preferred/GPL-2.0
> similarity index 100%
> rename from COPYING.tools
> rename to LICENSES/preferred/GPL-2.0
> diff --git a/COPYING.libraries b/LICENSES/preferred/LGPL-2.1
> similarity index 100%
> rename from COPYING.libraries
> rename to LICENSES/preferred/LGPL-2.1
> diff --git a/acpi.h b/acpi.h
> index e714e28e2354..4eddee09e312 100644
> --- a/acpi.h
> +++ b/acpi.h
> @@ -1,17 +1,5 @@
> -/*
> - * ACPI Table Definitions
> - *
> - * Copyright(c) 2013-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2013-2020 Intel Corporation. All rights reserved. */
>  #ifndef __ACPI_H__
>  #define __ACPI_H__
>  #include <stdint.h>
> diff --git a/ccan/array_size/LICENSE b/ccan/array_size/LICENSE
> deleted file mode 120000
> index b7951dabdc82..000000000000
> --- a/ccan/array_size/LICENSE
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../licenses/CC0
> \ No newline at end of file
> diff --git a/ccan/array_size/array_size.h b/ccan/array_size/array_size.h
> index 0ca422a29168..c9cd94fb356d 100644
> --- a/ccan/array_size/array_size.h
> +++ b/ccan/array_size/array_size.h
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +/* SPDX-License-Identifier: CC0-1.0 */
>  #ifndef CCAN_ARRAY_SIZE_H
>  #define CCAN_ARRAY_SIZE_H
>  #include "config.h"
> diff --git a/ccan/build_assert/LICENSE b/ccan/build_assert/LICENSE
> deleted file mode 120000
> index b7951dabdc82..000000000000
> --- a/ccan/build_assert/LICENSE
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../licenses/CC0
> \ No newline at end of file
> diff --git a/ccan/build_assert/build_assert.h b/ccan/build_assert/build_assert.h
> index b9ecd84028e3..ab79a7f19898 100644
> --- a/ccan/build_assert/build_assert.h
> +++ b/ccan/build_assert/build_assert.h
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +/* SPDX-License-Identifier: CC0-1.0 */
>  #ifndef CCAN_BUILD_ASSERT_H
>  #define CCAN_BUILD_ASSERT_H
>  
> diff --git a/ccan/check_type/LICENSE b/ccan/check_type/LICENSE
> deleted file mode 120000
> index b7951dabdc82..000000000000
> --- a/ccan/check_type/LICENSE
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../licenses/CC0
> \ No newline at end of file
> diff --git a/ccan/check_type/check_type.h b/ccan/check_type/check_type.h
> index 77501a95597c..1ef5782e4dee 100644
> --- a/ccan/check_type/check_type.h
> +++ b/ccan/check_type/check_type.h
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +/* SPDX-License-Identifier: CC0-1.0 */
>  #ifndef CCAN_CHECK_TYPE_H
>  #define CCAN_CHECK_TYPE_H
>  #include "config.h"
> diff --git a/ccan/container_of/LICENSE b/ccan/container_of/LICENSE
> deleted file mode 120000
> index b7951dabdc82..000000000000
> --- a/ccan/container_of/LICENSE
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../licenses/CC0
> \ No newline at end of file
> diff --git a/ccan/container_of/container_of.h b/ccan/container_of/container_of.h
> index 0449935056f5..3219acf1f192 100644
> --- a/ccan/container_of/container_of.h
> +++ b/ccan/container_of/container_of.h
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +/* SPDX-License-Identifier: CC0-1.0 */
>  #ifndef CCAN_CONTAINER_OF_H
>  #define CCAN_CONTAINER_OF_H
>  #include <stddef.h>
> diff --git a/ccan/endian/LICENSE b/ccan/endian/LICENSE
> deleted file mode 120000
> index b7951dabdc82..000000000000
> --- a/ccan/endian/LICENSE
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../licenses/CC0
> \ No newline at end of file
> diff --git a/ccan/endian/endian.h b/ccan/endian/endian.h
> index dc9f62e646df..2756e7796d75 100644
> --- a/ccan/endian/endian.h
> +++ b/ccan/endian/endian.h
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +/* SPDX-License-Identifier: CC0-1.0 */
>  #ifndef CCAN_ENDIAN_H
>  #define CCAN_ENDIAN_H
>  #include <stdint.h>
> diff --git a/ccan/list/LICENSE b/ccan/list/LICENSE
> deleted file mode 120000
> index 2354d12945d3..000000000000
> --- a/ccan/list/LICENSE
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../licenses/BSD-MIT
> \ No newline at end of file
> diff --git a/ccan/list/list.c b/ccan/list/list.c
> index 2717fa3f17e5..38b25a9ebf7b 100644
> --- a/ccan/list/list.c
> +++ b/ccan/list/list.c
> @@ -1,4 +1,4 @@
> -/* Licensed under BSD-MIT - see LICENSE file for details */
> +// SPDX-License-Identifier: MIT
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include "list.h"
> diff --git a/ccan/list/list.h b/ccan/list/list.h
> index 4d1d34e32709..3ebd1b23dc0f 100644
> --- a/ccan/list/list.h
> +++ b/ccan/list/list.h
> @@ -1,4 +1,4 @@
> -/* Licensed under BSD-MIT - see LICENSE file for details */
> +/* SPDX-License-Identifier: MIT */
>  #ifndef CCAN_LIST_H
>  #define CCAN_LIST_H
>  //#define CCAN_LIST_DEBUG 1
> diff --git a/ccan/minmax/LICENSE b/ccan/minmax/LICENSE
> deleted file mode 120000
> index b7951dabdc82..000000000000
> --- a/ccan/minmax/LICENSE
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../licenses/CC0
> \ No newline at end of file
> diff --git a/ccan/minmax/minmax.h b/ccan/minmax/minmax.h
> index 54f246cc112d..83ad7c15be35 100644
> --- a/ccan/minmax/minmax.h
> +++ b/ccan/minmax/minmax.h
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +/* SPDX-License-Identifier: CC0-1.0 */
>  #ifndef CCAN_MINMAX_H
>  #define CCAN_MINMAX_H
>  
> diff --git a/ccan/short_types/LICENSE b/ccan/short_types/LICENSE
> deleted file mode 120000
> index b7951dabdc82..000000000000
> --- a/ccan/short_types/LICENSE
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../licenses/CC0
> \ No newline at end of file
> diff --git a/ccan/short_types/short_types.h b/ccan/short_types/short_types.h
> index 175377e9bab9..2a7dd8b671bb 100644
> --- a/ccan/short_types/short_types.h
> +++ b/ccan/short_types/short_types.h
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +/* SPDX-License-Identifier: CC0-1.0 */
>  #ifndef CCAN_SHORT_TYPES_H
>  #define CCAN_SHORT_TYPES_H
>  #include <stdint.h>
> diff --git a/ccan/str/LICENSE b/ccan/str/LICENSE
> deleted file mode 120000
> index b7951dabdc82..000000000000
> --- a/ccan/str/LICENSE
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../licenses/CC0
> \ No newline at end of file
> diff --git a/ccan/str/debug.c b/ccan/str/debug.c
> index 8c519442d792..9dd0e28f0385 100644
> --- a/ccan/str/debug.c
> +++ b/ccan/str/debug.c
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +// SPDX-License-Identifier: CC0-1.0
>  #include "config.h"
>  #include <ccan/str/str_debug.h>
>  #include <assert.h>
> diff --git a/ccan/str/str.c b/ccan/str/str.c
> index a9245c1742ec..66ca7e2039b0 100644
> --- a/ccan/str/str.c
> +++ b/ccan/str/str.c
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +// SPDX-License-Identifier: CC0-1.0
>  #include <ccan/str/str.h>
>  
>  size_t strcount(const char *haystack, const char *needle)
> diff --git a/ccan/str/str.h b/ccan/str/str.h
> index 85491bc7e33e..fc324bc3adde 100644
> --- a/ccan/str/str.h
> +++ b/ccan/str/str.h
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +/* SPDX-License-Identifier: CC0-1.0 */
>  #ifndef CCAN_STR_H
>  #define CCAN_STR_H
>  #include "config.h"
> diff --git a/ccan/str/str_debug.h b/ccan/str/str_debug.h
> index 92c10c41cc61..66fa010227ec 100644
> --- a/ccan/str/str_debug.h
> +++ b/ccan/str/str_debug.h
> @@ -1,4 +1,4 @@
> -/* CC0 (Public domain) - see LICENSE file for details */
> +/* SPDX-License-Identifier: CC0-1.0 */
>  #ifndef CCAN_STR_DEBUG_H
>  #define CCAN_STR_DEBUG_H
>  
> diff --git a/contrib/daxctl-qemu-hmat-setup b/contrib/daxctl-qemu-hmat-setup
> index 0670e992453d..353cdeb4f7ed 100755
> --- a/contrib/daxctl-qemu-hmat-setup
> +++ b/contrib/daxctl-qemu-hmat-setup
> @@ -1,7 +1,6 @@
>  #!/bin/bash -e
> -
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2019 Intel Corporation. All rights reserved.
> +# Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
>  
>  KERNEL=${KERNEL:-$(uname -r)}
>  ROOT_IMAGE=${ROOT_IMAGE:-root.img}
> diff --git a/daxctl/acpi.c b/daxctl/acpi.c
> index ad1354bdb68c..8e804ce82ca5 100644
> --- a/daxctl/acpi.c
> +++ b/daxctl/acpi.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* Copyright(c) 2017-2020 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2017-2020 Intel Corporation. All rights reserved. */
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> diff --git a/daxctl/builtin.h b/daxctl/builtin.h
> index bdd71c1f45c8..a8779443cab0 100644
> --- a/daxctl/builtin.h
> +++ b/daxctl/builtin.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2015-2018 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
>  #ifndef _DAXCTL_BUILTIN_H_
>  #define _DAXCTL_BUILTIN_H_
>  
> diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
> index f533f810eb42..928814c8b35f 100644
> --- a/daxctl/daxctl.c
> +++ b/daxctl/daxctl.c
> @@ -1,16 +1,6 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - * Copyright(c) 2005 Andreas Ericsson. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
> +// Copyright (C) 2005 Andreas Ericsson. All rights reserved.
>  
>  /* originally copied from perf and git */
>  
> diff --git a/daxctl/device.c b/daxctl/device.c
> index 05293d6c38ee..fb631e9c1a1c 100644
> --- a/daxctl/device.c
> +++ b/daxctl/device.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2019-2020 Intel Corporation. All rights reserved. */
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
> index 9f9c70d6024f..b511807e1620 100644
> --- a/daxctl/lib/libdaxctl-private.h
> +++ b/daxctl/lib/libdaxctl-private.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2014-2020, Intel Corporation. All rights reserved. */
>  #ifndef _LIBDAXCTL_PRIVATE_H_
>  #define _LIBDAXCTL_PRIVATE_H_
>  
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index 9b43b68facfe..abef1c4b18e5 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2016-2020, Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <errno.h>
>  #include <limits.h>
> diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
> index 2b14faad1895..3a08222aab97 100644
> --- a/daxctl/libdaxctl.h
> +++ b/daxctl/libdaxctl.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2016-2020, Intel Corporation. All rights reserved. */
>  #ifndef _LIBDAXCTL_H_
>  #define _LIBDAXCTL_H_
>  
> diff --git a/daxctl/list.c b/daxctl/list.c
> index 6c6251b4de37..18dc2a350112 100644
> --- a/daxctl/list.c
> +++ b/daxctl/list.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> diff --git a/daxctl/migrate.c b/daxctl/migrate.c
> index d859b0856338..5fbe970fdaff 100644
> --- a/daxctl/migrate.c
> +++ b/daxctl/migrate.c
> @@ -1,5 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2019-2020 Intel Corporation. All rights reserved. */
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <stdio.h>
> diff --git a/ndctl/action.h b/ndctl/action.h
> index 51f8ee6f4bce..26bc8b89bb69 100644
> --- a/ndctl/action.h
> +++ b/ndctl/action.h
> @@ -1,8 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * SPDX-License-Identifier: GPL-2.0
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
>  #ifndef __NDCTL_ACTION_H__
>  #define __NDCTL_ACTION_H__
>  enum device_action {
> diff --git a/ndctl/bat.c b/ndctl/bat.c
> index c4496f0aeaa0..ef00a3ba3d0b 100644
> --- a/ndctl/bat.c
> +++ b/ndctl/bat.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2014 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2014-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <syslog.h>
>  #include <test.h>
> diff --git a/ndctl/builtin.h b/ndctl/builtin.h
> index 5de7379ce1b4..d3dbbb1afbdd 100644
> --- a/ndctl/builtin.h
> +++ b/ndctl/builtin.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2015-2018 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
>  #ifndef _NDCTL_BUILTIN_H_
>  #define _NDCTL_BUILTIN_H_
>  
> diff --git a/ndctl/bus.c b/ndctl/bus.c
> index 47053c8af389..9bc1797e50eb 100644
> --- a/ndctl/bus.c
> +++ b/ndctl/bus.c
> @@ -1,5 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2015-2018 Intel Corporation. All rights reserved. */
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> diff --git a/ndctl/check.c b/ndctl/check.c
> index cdb3d0bb5ae7..b4e20657e1dd 100644
> --- a/ndctl/check.c
> +++ b/ndctl/check.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2016 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <fcntl.h>
>  #include <errno.h>
> diff --git a/ndctl/create-nfit.c b/ndctl/create-nfit.c
> index 8f05eab81494..f4e5ddaaee07 100644
> --- a/ndctl/create-nfit.c
> +++ b/ndctl/create-nfit.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2014 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright(C) 2014-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> diff --git a/ndctl/dimm.c b/ndctl/dimm.c
> index 90eb0b8013ae..8e85d692afd3 100644
> --- a/ndctl/dimm.c
> +++ b/ndctl/dimm.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2016-2020, Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> diff --git a/ndctl/firmware-update.h b/ndctl/firmware-update.h
> index a4386d6089d2..10766529477a 100644
> --- a/ndctl/firmware-update.h
> +++ b/ndctl/firmware-update.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2018 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2018-2020 Intel Corporation. All rights reserved. */
>  
>  #ifndef _FIRMWARE_UPDATE_H_
>  #define _FIRMWARE_UPDATE_H_
> diff --git a/ndctl/inject-error.c b/ndctl/inject-error.c
> index f6be6a536b49..05c1a22fc36c 100644
> --- a/ndctl/inject-error.c
> +++ b/ndctl/inject-error.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <fcntl.h>
>  #include <errno.h>
> diff --git a/ndctl/inject-smart.c b/ndctl/inject-smart.c
> index 00c81b87ed54..9077bca256e4 100644
> --- a/ndctl/inject-smart.c
> +++ b/ndctl/inject-smart.c
> @@ -1,5 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2018 Intel Corporation. All rights reserved. */
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018-2020 Intel Corporation. All rights reserved. */
>  #include <math.h>
>  #include <stdio.h>
>  #include <fcntl.h>
> diff --git a/ndctl/lib/ars.c b/ndctl/lib/ars.c
> index 44871b2afde2..d50c283d5d03 100644
> --- a/ndctl/lib/ars.c
> +++ b/ndctl/lib/ars.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2014-2020, Intel Corporation. All rights reserved.
>  #include <stdlib.h>
>  #include <util/size.h>
>  #include <ndctl/libndctl.h>
> diff --git a/ndctl/lib/dimm.c b/ndctl/lib/dimm.c
> index 17344f0b168b..c045cbe87e5b 100644
> --- a/ndctl/lib/dimm.c
> +++ b/ndctl/lib/dimm.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2017, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2014-2020, Intel Corporation. All rights reserved.
>  #include <ndctl/namespace.h>
>  #include <ndctl/libndctl.h>
>  #include <util/fletcher.h>
> diff --git a/ndctl/lib/firmware.c b/ndctl/lib/firmware.c
> index a5dd00640698..0290b32b44f3 100644
> --- a/ndctl/lib/firmware.c
> +++ b/ndctl/lib/firmware.c
> @@ -1,5 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2018 Intel Corporation. All rights reserved. */
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018-2020 Intel Corporation. All rights reserved. */
>  #include <stdlib.h>
>  #include <limits.h>
>  #include <util/log.h>
> diff --git a/ndctl/lib/hpe1.c b/ndctl/lib/hpe1.c
> index b5ee02608d31..9755e9bdbd06 100644
> --- a/ndctl/lib/hpe1.c
> +++ b/ndctl/lib/hpe1.c
> @@ -1,16 +1,6 @@
> -/*
> - * Copyright (C) 2016 Hewlett Packard Enterprise Development LP
> - * Copyright (c) 2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2016 Hewlett Packard Enterprise Development LP
> +// Copyright (C) 2016-2020, Intel Corporation.
>  #include <stdlib.h>
>  #include <limits.h>
>  #include <util/log.h>
> diff --git a/ndctl/lib/hpe1.h b/ndctl/lib/hpe1.h
> index 1afa54f127a6..bc19f72ca8d0 100644
> --- a/ndctl/lib/hpe1.h
> +++ b/ndctl/lib/hpe1.h
> @@ -1,16 +1,6 @@
> -/*
> - * Copyright (C) 2016 Hewlett Packard Enterprise Development LP
> - * Copyright (c) 2014-2015, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2016 Hewlett Packard Enterprise Development LP */
> +/* Copyright (C) 2014-2020, Intel Corporation */
>  #ifndef __NDCTL_HPE1_H__
>  #define __NDCTL_HPE1_H__
>  
> diff --git a/ndctl/lib/hyperv.c b/ndctl/lib/hyperv.c
> index ba1b12111804..df2e7c2a86c0 100644
> --- a/ndctl/lib/hyperv.c
> +++ b/ndctl/lib/hyperv.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* Copyright(c) 2019, Microsoft Corporation. All rights reserved. */
> +/* Copyright (C) 2019, Microsoft Corporation. All rights reserved. */
>  
>  #include <stdlib.h>
>  #include <limits.h>
> diff --git a/ndctl/lib/hyperv.h b/ndctl/lib/hyperv.h
> index 0c1677f28041..45741c7cdd17 100644
> --- a/ndctl/lib/hyperv.h
> +++ b/ndctl/lib/hyperv.h
> @@ -1,5 +1,5 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* Copyright(c) 2019, Microsoft Corporation. All rights reserved. */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019, Microsoft Corporation. All rights reserved. */
>  
>  #ifndef __NDCTL_HYPERV_H__
>  #define __NDCTL_HYPERV_H__
> diff --git a/ndctl/lib/inject.c b/ndctl/lib/inject.c
> index 815f254308c6..b9cb92f6b2f9 100644
> --- a/ndctl/lib/inject.c
> +++ b/ndctl/lib/inject.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2017, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2014-2020, Intel Corporation. All rights reserved.
>  #include <stdlib.h>
>  #include <limits.h>
>  #include <util/list.h>
> diff --git a/ndctl/lib/intel.c b/ndctl/lib/intel.c
> index ebcefd8b5ad2..a3df26e6bc58 100644
> --- a/ndctl/lib/intel.c
> +++ b/ndctl/lib/intel.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2016-2017, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2016-2020, Intel Corporation. All rights reserved.
>  #include <stdlib.h>
>  #include <limits.h>
>  #include <util/log.h>
> diff --git a/ndctl/lib/intel.h b/ndctl/lib/intel.h
> index 530c996a6930..5aee98062a84 100644
> --- a/ndctl/lib/intel.h
> +++ b/ndctl/lib/intel.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: LGPL-2.1 */
> -/* Copyright (c) 2017, Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2017-2020, Intel Corporation. All rights reserved. */
>  
>  #ifndef __INTEL_H__
>  #define __INTEL_H__
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index 554696386f48..70ecbdbc93b5 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2014-2020, Intel Corporation. All rights reserved.
>  #include <poll.h>
>  #include <stdio.h>
>  #include <signal.h>
> diff --git a/ndctl/lib/msft.c b/ndctl/lib/msft.c
> index c060b1f2609e..145872c68cfa 100644
> --- a/ndctl/lib/msft.c
> +++ b/ndctl/lib/msft.c
> @@ -1,17 +1,7 @@
> -/*
> - * Copyright (C) 2016-2017 Dell, Inc.
> - * Copyright (C) 2016 Hewlett Packard Enterprise Development LP
> - * Copyright (c) 2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2016-2017 Dell, Inc.
> +// Copyright (C) 2016 Hewlett Packard Enterprise Development LP
> +// Copyright (C) 2016-2020, Intel Corporation.
>  #include <stdlib.h>
>  #include <limits.h>
>  #include <util/log.h>
> diff --git a/ndctl/lib/msft.h b/ndctl/lib/msft.h
> index c45981edd8d7..7cfd26fea64d 100644
> --- a/ndctl/lib/msft.h
> +++ b/ndctl/lib/msft.h
> @@ -1,17 +1,7 @@
> -/*
> - * Copyright (C) 2016-2017 Dell, Inc.
> - * Copyright (C) 2016 Hewlett Packard Enterprise Development LP
> - * Copyright (c) 2014-2015, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2016-2017 Dell, Inc. */
> +/* Copyright (C) 2016 Hewlett Packard Enterprise Development LP */
> +/* Copyright (C) 2014-2020, Intel Corporation. */
>  #ifndef __NDCTL_MSFT_H__
>  #define __NDCTL_MSFT_H__
>  
> diff --git a/ndctl/lib/nfit.c b/ndctl/lib/nfit.c
> index f9fbe73f7446..6f68fcf6523c 100644
> --- a/ndctl/lib/nfit.c
> +++ b/ndctl/lib/nfit.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2017, FUJITSU LIMITED. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (c) 2017, FUJITSU LIMITED. All rights reserved.
>  #include <stdlib.h>
>  #include <ndctl/libndctl.h>
>  #include "private.h"
> diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
> index bab4298b01e3..ede13009a089 100644
> --- a/ndctl/lib/private.h
> +++ b/ndctl/lib/private.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2014-2020, Intel Corporation. All rights reserved. */
>  #ifndef _LIBNDCTL_PRIVATE_H_
>  #define _LIBNDCTL_PRIVATE_H_
>  
> diff --git a/ndctl/lib/smart.c b/ndctl/lib/smart.c
> index 0e180cff5a3e..9e1f81ac4eaa 100644
> --- a/ndctl/lib/smart.c
> +++ b/ndctl/lib/smart.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2016-2020, Intel Corporation. All rights reserved.
>  #include <stdlib.h>
>  #include <limits.h>
>  #include <util/log.h>
> diff --git a/ndctl/libndctl-nfit.h b/ndctl/libndctl-nfit.h
> index 8c4f72dfa7ec..9ec0db55776d 100644
> --- a/ndctl/libndctl-nfit.h
> +++ b/ndctl/libndctl-nfit.h
> @@ -1,18 +1,6 @@
> -/*
> - *
> - * Copyright (c) 2017 Hewlett Packard Enterprise Development LP
> - * Copyright (c) 2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> -
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2017 Hewlett Packard Enterprise Development LP */
> +/* Copyright (C) 2017-2020 Intel Corporation. All rights reserved. */
>  #ifndef __LIBNDCTL_NFIT_H__
>  #define __LIBNDCTL_NFIT_H__
>  
> diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
> index 231dbb560996..60e12889942e 100644
> --- a/ndctl/libndctl.h
> +++ b/ndctl/libndctl.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2014-2020, Intel Corporation. All rights reserved. */
>  #ifndef _LIBNDCTL_H_
>  #define _LIBNDCTL_H_
>  
> diff --git a/ndctl/list.c b/ndctl/list.c
> index f98148aea479..0017f159c708 100644
> --- a/ndctl/list.c
> +++ b/ndctl/list.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> diff --git a/ndctl/load-keys.c b/ndctl/load-keys.c
> index f0b7a5ae69a4..26648fe90fe6 100644
> --- a/ndctl/load-keys.c
> +++ b/ndctl/load-keys.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2019-2020 Intel Corporation. All rights reserved. */
>  
>  #include <stdio.h>
>  #include <errno.h>
> diff --git a/ndctl/monitor.c b/ndctl/monitor.c
> index 4e9b2236ff3c..ca36179e1870 100644
> --- a/ndctl/monitor.c
> +++ b/ndctl/monitor.c
> @@ -1,5 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2018, FUJITSU LIMITED. All rights reserved. */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018, FUJITSU LIMITED. All rights reserved.
>  
>  #include <stdio.h>
>  #include <json-c/json.h>
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index e946bb6c9bfa..f61e0fcda015 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <fcntl.h>
>  #include <errno.h>
> diff --git a/ndctl/namespace.h b/ndctl/namespace.h
> index 0f17df20ca3a..57735ebe3d76 100644
> --- a/ndctl/namespace.h
> +++ b/ndctl/namespace.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2017, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2014-2020, Intel Corporation. All rights reserved. */
>  #ifndef __NDCTL_NAMESPACE_H__
>  #define __NDCTL_NAMESPACE_H__
>  #include <sys/types.h>
> diff --git a/ndctl/ndctl.c b/ndctl/ndctl.c
> index eb5d8392d8e4..31d2c5e35939 100644
> --- a/ndctl/ndctl.c
> +++ b/ndctl/ndctl.c
> @@ -1,16 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - * Copyright(c) 2005 Andreas Ericsson. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  /* originally copied from perf and git */
>  
> diff --git a/ndctl/ndctl.h b/ndctl/ndctl.h
> index a47b658f4a57..df3f39c04b60 100644
> --- a/ndctl/ndctl.h
> +++ b/ndctl/ndctl.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2014-2020, Intel Corporation. All rights reserved. */
>  #ifndef __NDCTL_H__
>  #define __NDCTL_H__
>  
> diff --git a/ndctl/region.c b/ndctl/region.c
> index 7945007905fd..3edb9b331804 100644
> --- a/ndctl/region.c
> +++ b/ndctl/region.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> diff --git a/ndctl/test.c b/ndctl/test.c
> index b78776311125..6a05d8d62e46 100644
> --- a/ndctl/test.c
> +++ b/ndctl/test.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <limits.h>
>  #include <syslog.h>
> diff --git a/ndctl/util/json-smart.c b/ndctl/util/json-smart.c
> index a9bd17b37b4e..e598e04420cd 100644
> --- a/ndctl/util/json-smart.c
> +++ b/ndctl/util/json-smart.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <limits.h>
>  #include <util/json.h>
>  #include <uuid/uuid.h>
> diff --git a/ndctl/util/keys.c b/ndctl/util/keys.c
> index a621a5f5cdbe..30cb4c884b98 100644
> --- a/ndctl/util/keys.c
> +++ b/ndctl/util/keys.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* Copyright(c) 2018 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2018-2020 Intel Corporation. All rights reserved. */
>  
>  #include <stdio.h>
>  #include <errno.h>
> diff --git a/ndctl/util/keys.h b/ndctl/util/keys.h
> index 9bc995acf3b1..03cb509e6404 100644
> --- a/ndctl/util/keys.h
> +++ b/ndctl/util/keys.h
> @@ -1,5 +1,5 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2019-2020 Intel Corporation. All rights reserved. */
>  
>  #ifndef _NDCTL_UTIL_KEYS_H_
>  #define _NDCTL_UTIL_KEYS_H_
> diff --git a/sles/header b/sles/header
> index 18efb453f705..9798caf67e59 100644
> --- a/sles/header
> +++ b/sles/header
> @@ -1,8 +1,8 @@
>  #
>  # spec file for package ndctl
>  #
> -# Copyright (c) 2015 SUSE LINUX GmbH, Nuernberg, Germany.
> -# Copyright (c) 2015 Intel Corporation
> +# Copyright (C) 2015 SUSE LINUX GmbH, Nuernberg, Germany.
> +# Copyright (C) 2015-2020 Intel Corporation
>  #
>  # All modifications and additions to the file contributed by third parties
>  # remain the property of their copyright owners, unless otherwise agreed
> diff --git a/test.h b/test.h
> index 3f6212e067fc..cba8d41a84b5 100644
> --- a/test.h
> +++ b/test.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
>  #ifndef __TEST_H__
>  #define __TEST_H__
>  #include <stdbool.h>
> diff --git a/test/ack-shutdown-count-set.c b/test/ack-shutdown-count-set.c
> index 742e976bfa90..fb1d82b49450 100644
> --- a/test/ack-shutdown-count-set.c
> +++ b/test/ack-shutdown-count-set.c
> @@ -1,5 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2018 Intel Corporation. All rights reserved. */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
>  
>  #include <stdio.h>
>  #include <stddef.h>
> diff --git a/test/align.sh b/test/align.sh
> index 37b2a1dac7a6..f41fb7de73ce 100755
> --- a/test/align.sh
> +++ b/test/align.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -x
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2015-2020 Intel Corporation. All rights reserved.
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  . $(dirname $0)/common
>  
> diff --git a/test/blk-exhaust.sh b/test/blk-exhaust.sh
> index db7dc25aecbd..09c4aae146a6 100755
> --- a/test/blk-exhaust.sh
> +++ b/test/blk-exhaust.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -x
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -# 
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -# 
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  set -e
>  
> diff --git a/test/blk_namespaces.c b/test/blk_namespaces.c
> index 437fcad0a8f5..d7f00cb02156 100644
> --- a/test/blk_namespaces.c
> +++ b/test/blk_namespaces.c
> @@ -1,17 +1,5 @@
> -/*
> - * blk_namespaces: tests functionality of multiple block namespaces
> - *
> - * Copyright (c) 2015, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2015-2020, Intel Corporation. All rights reserved.
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/fs.h>
> diff --git a/test/btt-check.sh b/test/btt-check.sh
> index bd782f477728..8e0b489a8eca 100755
> --- a/test/btt-check.sh
> +++ b/test/btt-check.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -E
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -# 
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -# 
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  dev=""
>  mode=""
> diff --git a/test/btt-errors.sh b/test/btt-errors.sh
> index a56069789d4b..4e59f57aea7c 100755
> --- a/test/btt-errors.sh
> +++ b/test/btt-errors.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -x
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -#
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  MNT=test_btt_mnt
>  FILE=image
> diff --git a/test/btt-pad-compat.sh b/test/btt-pad-compat.sh
> index b1a46edeaf9d..bf1ea54af9d2 100755
> --- a/test/btt-pad-compat.sh
> +++ b/test/btt-pad-compat.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -Ex
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -#
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  dev=""
>  size=""
> diff --git a/test/clear.sh b/test/clear.sh
> index 1fffd166504a..fb9d52c837d4 100755
> --- a/test/clear.sh
> +++ b/test/clear.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -x
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -# 
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -# 
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  set -e
>  
> diff --git a/test/common b/test/common
> index 1814a0c3de71..6bcefcad9bf9 100644
> --- a/test/common
> +++ b/test/common
> @@ -1,6 +1,5 @@
> -
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2018, FUJITSU LIMITED. All rights reserved.
> +# Copyright (C) 2018, FUJITSU LIMITED. All rights reserved.
>  
>  # Global variables
>  
> diff --git a/test/core.c b/test/core.c
> index 5118d86483d4..cc7d8d94dc2c 100644
> --- a/test/core.c
> +++ b/test/core.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <linux/version.h>
>  #include <sys/utsname.h>
>  #include <libkmod.h>
> diff --git a/test/create.sh b/test/create.sh
> index 520f3a9c1dc1..b0fd99f1e7b1 100755
> --- a/test/create.sh
> +++ b/test/create.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -x
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -# 
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -# 
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  set -e
>  
> diff --git a/test/dax-dev.c b/test/dax-dev.c
> index ab6b35a67183..6a1b76d6f5c3 100644
> --- a/test/dax-dev.c
> +++ b/test/dax-dev.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2014-2020, Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <stddef.h>
>  #include <stdlib.h>
> diff --git a/test/dax-errors.c b/test/dax-errors.c
> index fde3ba03546f..e068966e045b 100644
> --- a/test/dax-errors.c
> +++ b/test/dax-errors.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
> diff --git a/test/dax-pmd.c b/test/dax-pmd.c
> index df3219639a6d..401826d02d69 100644
> --- a/test/dax-pmd.c
> +++ b/test/dax-pmd.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <setjmp.h>
> diff --git a/test/dax-poison.c b/test/dax-poison.c
> index 69bb161db6d8..a4ef12eca1be 100644
> --- a/test/dax-poison.c
> +++ b/test/dax-poison.c
> @@ -1,5 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2018 Intel Corporation. All rights reserved. */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <signal.h>
> diff --git a/test/dax.sh b/test/dax.sh
> index 5383c433283f..bcdd4e9bda27 100755
> --- a/test/dax.sh
> +++ b/test/dax.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -x
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -# 
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -# 
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  . $(dirname $0)/common
>  
> diff --git a/test/daxctl-create.sh b/test/daxctl-create.sh
> index f46b9273ef20..b166c70bb7f7 100755
> --- a/test/daxctl-create.sh
> +++ b/test/daxctl-create.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -Ex
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2020, Oracle and/or its affiliates.
> +# Copyright (C) 2020, Oracle and/or its affiliates.
>  
>  rc=77
>  . $(dirname $0)/common
> diff --git a/test/daxctl-devices.sh b/test/daxctl-devices.sh
> index ff2bcd212294..496e4f2226e4 100755
> --- a/test/daxctl-devices.sh
> +++ b/test/daxctl-devices.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -Ex
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2019 Intel Corporation. All rights reserved.
> +# Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
>  
>  rc=77
>  . $(dirname $0)/common
> diff --git a/test/daxdev-errors.c b/test/daxdev-errors.c
> index 29de16b0a53d..fbbea21448d8 100644
> --- a/test/daxdev-errors.c
> +++ b/test/daxdev-errors.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <stdint.h>
>  #include <stdbool.h>
> diff --git a/test/daxdev-errors.sh b/test/daxdev-errors.sh
> index 15d3e67d1166..6281f32d1ee0 100755
> --- a/test/daxdev-errors.sh
> +++ b/test/daxdev-errors.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -x
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -# 
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -# 
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  set -e
>  
> diff --git a/test/device-dax-fio.sh b/test/device-dax-fio.sh
> index d4ca7ab238e4..f57a9d266afc 100755
> --- a/test/device-dax-fio.sh
> +++ b/test/device-dax-fio.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -# 
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -# 
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  . $(dirname $0)/common
>  
> diff --git a/test/device-dax.c b/test/device-dax.c
> index 9de10682e34d..5f0da297f28e 100644
> --- a/test/device-dax.c
> +++ b/test/device-dax.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <errno.h>
> diff --git a/test/dm.sh b/test/dm.sh
> index fb498c95a29b..4656e5bfbebe 100755
> --- a/test/dm.sh
> +++ b/test/dm.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -x
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2015-2019 Intel Corporation. All rights reserved.
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  set -e
>  
> diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
> index b757b9ad9c2c..e92200984e15 100644
> --- a/test/dpa-alloc.c
> +++ b/test/dpa-alloc.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2014-2020, Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <stddef.h>
>  #include <stdlib.h>
> diff --git a/test/dsm-fail.c b/test/dsm-fail.c
> index b2c51db4aa3a..9dfd8b0377ed 100644
> --- a/test/dsm-fail.c
> +++ b/test/dsm-fail.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2014-2020, Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <stddef.h>
>  #include <stdlib.h>
> diff --git a/test/firmware-update.sh b/test/firmware-update.sh
> index 284b8268dbdd..8cc9c41b57ca 100755
> --- a/test/firmware-update.sh
> +++ b/test/firmware-update.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -Ex
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2018 Intel Corporation. All rights reserved.
> +# Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
>  
>  rc=77
>  dev=""
> diff --git a/test/inject-error.sh b/test/inject-error.sh
> index 5667b5131c7a..c636033fb4cf 100755
> --- a/test/inject-error.sh
> +++ b/test/inject-error.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -Ex
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -#
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  dev=""
>  size=""
> diff --git a/test/inject-smart.sh b/test/inject-smart.sh
> index 5e563df546b8..94705dfa4474 100755
> --- a/test/inject-smart.sh
> +++ b/test/inject-smart.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -Ex
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2018 Intel Corporation. All rights reserved.
> +# Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
>  
>  rc=77
>  . $(dirname $0)/common
> diff --git a/test/label-compat.sh b/test/label-compat.sh
> index a29dd1367233..340b93d3eb01 100755
> --- a/test/label-compat.sh
> +++ b/test/label-compat.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -x
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -# 
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -# 
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  set -e
>  
> diff --git a/test/libndctl.c b/test/libndctl.c
> index 994e0fadf4f7..92ee2532abbe 100644
> --- a/test/libndctl.c
> +++ b/test/libndctl.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2014-2020, Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <stddef.h>
>  #include <stdlib.h>
> diff --git a/test/list-smart-dimm.c b/test/list-smart-dimm.c
> index c9982d50f1ad..00c24e11bf24 100644
> --- a/test/list-smart-dimm.c
> +++ b/test/list-smart-dimm.c
> @@ -1,6 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2018, FUJITSU LIMITED. All rights reserved. */
> -
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018, FUJITSU LIMITED. All rights reserved.
>  #include <stdio.h>
>  #include <errno.h>
>  #include <util/json.h>
> diff --git a/test/max_available_extent_ns.sh b/test/max_available_extent_ns.sh
> index c6acdabf7fd7..14d741d2b3ad 100755
> --- a/test/max_available_extent_ns.sh
> +++ b/test/max_available_extent_ns.sh
> @@ -1,7 +1,6 @@
>  #!/bin/bash -Ex
> -
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2018, FUJITSU LIMITED. All rights reserved.
> +# Copyright (C) 2018, FUJITSU LIMITED. All rights reserved.
>  
>  rc=77
>  
> diff --git a/test/mmap.c b/test/mmap.c
> index b087ba872ba9..0a66967a25f6 100644
> --- a/test/mmap.c
> +++ b/test/mmap.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015 Toshi Kani, Hewlett Packard Enterprise. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015 Toshi Kani, Hewlett Packard Enterprise. All rights reserved.
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/mman.h>
> diff --git a/test/mmap.sh b/test/mmap.sh
> index 0bcc35f619f5..50a1d34d0b75 100755
> --- a/test/mmap.sh
> +++ b/test/mmap.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -# 
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -# 
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  . $(dirname $0)/common
>  
> diff --git a/test/monitor.sh b/test/monitor.sh
> index 261fbfa3d461..cdab5e1478fa 100755
> --- a/test/monitor.sh
> +++ b/test/monitor.sh
> @@ -1,7 +1,6 @@
>  #!/bin/bash -Ex
> -
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2018, FUJITSU LIMITED. All rights reserved.
> +# Copyright (C) 2018, FUJITSU LIMITED. All rights reserved.
>  
>  rc=77
>  monitor_pid=65536
> diff --git a/test/multi-dax.sh b/test/multi-dax.sh
> index 110ba3d80339..e93256913a47 100755
> --- a/test/multi-dax.sh
> +++ b/test/multi-dax.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -x
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -#
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  set -e
>  
> diff --git a/test/multi-pmem.c b/test/multi-pmem.c
> index cb7cd4033f37..3d109521c538 100644
> --- a/test/multi-pmem.c
> +++ b/test/multi-pmem.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <errno.h>
>  #include <unistd.h>
> diff --git a/test/parent-uuid.c b/test/parent-uuid.c
> index f41ca2c7bd75..531024722026 100644
> --- a/test/parent-uuid.c
> +++ b/test/parent-uuid.c
> @@ -1,17 +1,5 @@
> -/*
> - * blk_namespaces: tests functionality of multiple block namespaces
> - *
> - * Copyright (c) 2015, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2015-2020, Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <stddef.h>
>  #include <stdlib.h>
> diff --git a/test/pfn-meta-errors.sh b/test/pfn-meta-errors.sh
> index 4ac33d86b8d3..0ade2e52a8ad 100755
> --- a/test/pfn-meta-errors.sh
> +++ b/test/pfn-meta-errors.sh
> @@ -1,7 +1,6 @@
>  #!/bin/bash -Ex
> -
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2018 Intel Corporation. All rights reserved.
> +# Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
>  
>  blockdev=""
>  rc=77
> diff --git a/test/pmem-errors.sh b/test/pmem-errors.sh
> index f9c8eb213df0..4225c3bce0c7 100755
> --- a/test/pmem-errors.sh
> +++ b/test/pmem-errors.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -x
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  MNT=test_dax_mnt
>  FILE=image
> diff --git a/test/pmem_namespaces.c b/test/pmem_namespaces.c
> index eac56ce25d58..f0f2edde30a1 100644
> --- a/test/pmem_namespaces.c
> +++ b/test/pmem_namespaces.c
> @@ -1,17 +1,5 @@
> -/*
> - * pmem_namespaces: test functionality of PMEM namespaces
> - *
> - * Copyright (c) 2015, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2015-2020, Intel Corporation. All rights reserved.
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/fs.h>
> diff --git a/test/rescan-partitions.sh b/test/rescan-partitions.sh
> index b3f2b167053f..1686de3552f1 100755
> --- a/test/rescan-partitions.sh
> +++ b/test/rescan-partitions.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -Ex
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2018 Intel Corporation. All rights reserved.
> +# Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
>  
>  dev=""
>  size=""
> diff --git a/test/revoke-devmem.c b/test/revoke-devmem.c
> index ffa509e2d7d1..bb8979e9a3d4 100644
> --- a/test/revoke-devmem.c
> +++ b/test/revoke-devmem.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2020 Intel Corporation. All rights reserved. */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <errno.h>
> diff --git a/test/sector-mode.sh b/test/sector-mode.sh
> index eef8dc6d6a3e..dd7013e78e3b 100755
> --- a/test/sector-mode.sh
> +++ b/test/sector-mode.sh
> @@ -1,15 +1,6 @@
>  #!/bin/bash -x
> -
> -# Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> -#
> -# This program is free software; you can redistribute it and/or modify it
> -# under the terms of version 2 of the GNU General Public License as
> -# published by the Free Software Foundation.
> -#
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  rc=77
>  
> diff --git a/test/security.sh b/test/security.sh
> index 8e2d870c0d43..34c4977bb4f0 100755
> --- a/test/security.sh
> +++ b/test/security.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -Ex
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2018 Intel Corporation. All rights reserved.
> +# Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
>  
>  rc=77
>  dev=""
> diff --git a/test/smart-listen.c b/test/smart-listen.c
> index e365ce54c7bd..7b81f8eb4433 100644
> --- a/test/smart-listen.c
> +++ b/test/smart-listen.c
> @@ -1,5 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2017 Intel Corporation. All rights reserved. */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2017-2020 Intel Corporation. All rights reserved.
>  #include <poll.h>
>  #include <stdio.h>
>  #include <string.h>
> diff --git a/test/smart-notify.c b/test/smart-notify.c
> index e28e0f414efd..9aff84bbe3b8 100644
> --- a/test/smart-notify.c
> +++ b/test/smart-notify.c
> @@ -1,5 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2017 Intel Corporation. All rights reserved. */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2017-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <string.h>
>  #include <unistd.h>
> diff --git a/test/sub-section.sh b/test/sub-section.sh
> index 91aa5c8e4834..92ae816c448c 100755
> --- a/test/sub-section.sh
> +++ b/test/sub-section.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -x
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2015-2019 Intel Corporation. All rights reserved.
> +# Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  
>  set -e
>  
> diff --git a/test/track-uuid.sh b/test/track-uuid.sh
> index ab77e52708b6..be3cf9c07a0a 100755
> --- a/test/track-uuid.sh
> +++ b/test/track-uuid.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash -Ex
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright(c) 2018 Intel Corporation. All rights reserved.
> +# Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
>  
>  blockdev=""
>  rc=77
> diff --git a/util/COPYING b/util/COPYING
> deleted file mode 100644
> index 3912109b5cd6..000000000000
> --- a/util/COPYING
> +++ /dev/null
> @@ -1,340 +0,0 @@
> -		    GNU GENERAL PUBLIC LICENSE
> -		       Version 2, June 1991
> -
> - Copyright (C) 1989, 1991 Free Software Foundation, Inc.
> -                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> - Everyone is permitted to copy and distribute verbatim copies
> - of this license document, but changing it is not allowed.
> -
> -			    Preamble
> -
> -  The licenses for most software are designed to take away your
> -freedom to share and change it.  By contrast, the GNU General Public
> -License is intended to guarantee your freedom to share and change free
> -software--to make sure the software is free for all its users.  This
> -General Public License applies to most of the Free Software
> -Foundation's software and to any other program whose authors commit to
> -using it.  (Some other Free Software Foundation software is covered by
> -the GNU Library General Public License instead.)  You can apply it to
> -your programs, too.
> -
> -  When we speak of free software, we are referring to freedom, not
> -price.  Our General Public Licenses are designed to make sure that you
> -have the freedom to distribute copies of free software (and charge for
> -this service if you wish), that you receive source code or can get it
> -if you want it, that you can change the software or use pieces of it
> -in new free programs; and that you know you can do these things.
> -
> -  To protect your rights, we need to make restrictions that forbid
> -anyone to deny you these rights or to ask you to surrender the rights.
> -These restrictions translate to certain responsibilities for you if you
> -distribute copies of the software, or if you modify it.
> -
> -  For example, if you distribute copies of such a program, whether
> -gratis or for a fee, you must give the recipients all the rights that
> -you have.  You must make sure that they, too, receive or can get the
> -source code.  And you must show them these terms so they know their
> -rights.
> -
> -  We protect your rights with two steps: (1) copyright the software, and
> -(2) offer you this license which gives you legal permission to copy,
> -distribute and/or modify the software.
> -
> -  Also, for each author's protection and ours, we want to make certain
> -that everyone understands that there is no warranty for this free
> -software.  If the software is modified by someone else and passed on, we
> -want its recipients to know that what they have is not the original, so
> -that any problems introduced by others will not reflect on the original
> -authors' reputations.
> -
> -  Finally, any free program is threatened constantly by software
> -patents.  We wish to avoid the danger that redistributors of a free
> -program will individually obtain patent licenses, in effect making the
> -program proprietary.  To prevent this, we have made it clear that any
> -patent must be licensed for everyone's free use or not licensed at all.
> -
> -  The precise terms and conditions for copying, distribution and
> -modification follow.
> -
> -		    GNU GENERAL PUBLIC LICENSE
> -   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
> -
> -  0. This License applies to any program or other work which contains
> -a notice placed by the copyright holder saying it may be distributed
> -under the terms of this General Public License.  The "Program", below,
> -refers to any such program or work, and a "work based on the Program"
> -means either the Program or any derivative work under copyright law:
> -that is to say, a work containing the Program or a portion of it,
> -either verbatim or with modifications and/or translated into another
> -language.  (Hereinafter, translation is included without limitation in
> -the term "modification".)  Each licensee is addressed as "you".
> -
> -Activities other than copying, distribution and modification are not
> -covered by this License; they are outside its scope.  The act of
> -running the Program is not restricted, and the output from the Program
> -is covered only if its contents constitute a work based on the
> -Program (independent of having been made by running the Program).
> -Whether that is true depends on what the Program does.
> -
> -  1. You may copy and distribute verbatim copies of the Program's
> -source code as you receive it, in any medium, provided that you
> -conspicuously and appropriately publish on each copy an appropriate
> -copyright notice and disclaimer of warranty; keep intact all the
> -notices that refer to this License and to the absence of any warranty;
> -and give any other recipients of the Program a copy of this License
> -along with the Program.
> -
> -You may charge a fee for the physical act of transferring a copy, and
> -you may at your option offer warranty protection in exchange for a fee.
> -
> -  2. You may modify your copy or copies of the Program or any portion
> -of it, thus forming a work based on the Program, and copy and
> -distribute such modifications or work under the terms of Section 1
> -above, provided that you also meet all of these conditions:
> -
> -    a) You must cause the modified files to carry prominent notices
> -    stating that you changed the files and the date of any change.
> -
> -    b) You must cause any work that you distribute or publish, that in
> -    whole or in part contains or is derived from the Program or any
> -    part thereof, to be licensed as a whole at no charge to all third
> -    parties under the terms of this License.
> -
> -    c) If the modified program normally reads commands interactively
> -    when run, you must cause it, when started running for such
> -    interactive use in the most ordinary way, to print or display an
> -    announcement including an appropriate copyright notice and a
> -    notice that there is no warranty (or else, saying that you provide
> -    a warranty) and that users may redistribute the program under
> -    these conditions, and telling the user how to view a copy of this
> -    License.  (Exception: if the Program itself is interactive but
> -    does not normally print such an announcement, your work based on
> -    the Program is not required to print an announcement.)
> -
> -These requirements apply to the modified work as a whole.  If
> -identifiable sections of that work are not derived from the Program,
> -and can be reasonably considered independent and separate works in
> -themselves, then this License, and its terms, do not apply to those
> -sections when you distribute them as separate works.  But when you
> -distribute the same sections as part of a whole which is a work based
> -on the Program, the distribution of the whole must be on the terms of
> -this License, whose permissions for other licensees extend to the
> -entire whole, and thus to each and every part regardless of who wrote it.
> -
> -Thus, it is not the intent of this section to claim rights or contest
> -your rights to work written entirely by you; rather, the intent is to
> -exercise the right to control the distribution of derivative or
> -collective works based on the Program.
> -
> -In addition, mere aggregation of another work not based on the Program
> -with the Program (or with a work based on the Program) on a volume of
> -a storage or distribution medium does not bring the other work under
> -the scope of this License.
> -
> -  3. You may copy and distribute the Program (or a work based on it,
> -under Section 2) in object code or executable form under the terms of
> -Sections 1 and 2 above provided that you also do one of the following:
> -
> -    a) Accompany it with the complete corresponding machine-readable
> -    source code, which must be distributed under the terms of Sections
> -    1 and 2 above on a medium customarily used for software interchange; or,
> -
> -    b) Accompany it with a written offer, valid for at least three
> -    years, to give any third party, for a charge no more than your
> -    cost of physically performing source distribution, a complete
> -    machine-readable copy of the corresponding source code, to be
> -    distributed under the terms of Sections 1 and 2 above on a medium
> -    customarily used for software interchange; or,
> -
> -    c) Accompany it with the information you received as to the offer
> -    to distribute corresponding source code.  (This alternative is
> -    allowed only for noncommercial distribution and only if you
> -    received the program in object code or executable form with such
> -    an offer, in accord with Subsection b above.)
> -
> -The source code for a work means the preferred form of the work for
> -making modifications to it.  For an executable work, complete source
> -code means all the source code for all modules it contains, plus any
> -associated interface definition files, plus the scripts used to
> -control compilation and installation of the executable.  However, as a
> -special exception, the source code distributed need not include
> -anything that is normally distributed (in either source or binary
> -form) with the major components (compiler, kernel, and so on) of the
> -operating system on which the executable runs, unless that component
> -itself accompanies the executable.
> -
> -If distribution of executable or object code is made by offering
> -access to copy from a designated place, then offering equivalent
> -access to copy the source code from the same place counts as
> -distribution of the source code, even though third parties are not
> -compelled to copy the source along with the object code.
> -
> -  4. You may not copy, modify, sublicense, or distribute the Program
> -except as expressly provided under this License.  Any attempt
> -otherwise to copy, modify, sublicense or distribute the Program is
> -void, and will automatically terminate your rights under this License.
> -However, parties who have received copies, or rights, from you under
> -this License will not have their licenses terminated so long as such
> -parties remain in full compliance.
> -
> -  5. You are not required to accept this License, since you have not
> -signed it.  However, nothing else grants you permission to modify or
> -distribute the Program or its derivative works.  These actions are
> -prohibited by law if you do not accept this License.  Therefore, by
> -modifying or distributing the Program (or any work based on the
> -Program), you indicate your acceptance of this License to do so, and
> -all its terms and conditions for copying, distributing or modifying
> -the Program or works based on it.
> -
> -  6. Each time you redistribute the Program (or any work based on the
> -Program), the recipient automatically receives a license from the
> -original licensor to copy, distribute or modify the Program subject to
> -these terms and conditions.  You may not impose any further
> -restrictions on the recipients' exercise of the rights granted herein.
> -You are not responsible for enforcing compliance by third parties to
> -this License.
> -
> -  7. If, as a consequence of a court judgment or allegation of patent
> -infringement or for any other reason (not limited to patent issues),
> -conditions are imposed on you (whether by court order, agreement or
> -otherwise) that contradict the conditions of this License, they do not
> -excuse you from the conditions of this License.  If you cannot
> -distribute so as to satisfy simultaneously your obligations under this
> -License and any other pertinent obligations, then as a consequence you
> -may not distribute the Program at all.  For example, if a patent
> -license would not permit royalty-free redistribution of the Program by
> -all those who receive copies directly or indirectly through you, then
> -the only way you could satisfy both it and this License would be to
> -refrain entirely from distribution of the Program.
> -
> -If any portion of this section is held invalid or unenforceable under
> -any particular circumstance, the balance of the section is intended to
> -apply and the section as a whole is intended to apply in other
> -circumstances.
> -
> -It is not the purpose of this section to induce you to infringe any
> -patents or other property right claims or to contest validity of any
> -such claims; this section has the sole purpose of protecting the
> -integrity of the free software distribution system, which is
> -implemented by public license practices.  Many people have made
> -generous contributions to the wide range of software distributed
> -through that system in reliance on consistent application of that
> -system; it is up to the author/donor to decide if he or she is willing
> -to distribute software through any other system and a licensee cannot
> -impose that choice.
> -
> -This section is intended to make thoroughly clear what is believed to
> -be a consequence of the rest of this License.
> -
> -  8. If the distribution and/or use of the Program is restricted in
> -certain countries either by patents or by copyrighted interfaces, the
> -original copyright holder who places the Program under this License
> -may add an explicit geographical distribution limitation excluding
> -those countries, so that distribution is permitted only in or among
> -countries not thus excluded.  In such case, this License incorporates
> -the limitation as if written in the body of this License.
> -
> -  9. The Free Software Foundation may publish revised and/or new versions
> -of the General Public License from time to time.  Such new versions will
> -be similar in spirit to the present version, but may differ in detail to
> -address new problems or concerns.
> -
> -Each version is given a distinguishing version number.  If the Program
> -specifies a version number of this License which applies to it and "any
> -later version", you have the option of following the terms and conditions
> -either of that version or of any later version published by the Free
> -Software Foundation.  If the Program does not specify a version number of
> -this License, you may choose any version ever published by the Free Software
> -Foundation.
> -
> -  10. If you wish to incorporate parts of the Program into other free
> -programs whose distribution conditions are different, write to the author
> -to ask for permission.  For software which is copyrighted by the Free
> -Software Foundation, write to the Free Software Foundation; we sometimes
> -make exceptions for this.  Our decision will be guided by the two goals
> -of preserving the free status of all derivatives of our free software and
> -of promoting the sharing and reuse of software generally.
> -
> -			    NO WARRANTY
> -
> -  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
> -FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
> -OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
> -PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
> -OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> -MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
> -TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
> -PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
> -REPAIR OR CORRECTION.
> -
> -  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
> -WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
> -REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
> -INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
> -OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
> -TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
> -YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
> -PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
> -POSSIBILITY OF SUCH DAMAGES.
> -
> -		     END OF TERMS AND CONDITIONS
> -
> -	    How to Apply These Terms to Your New Programs
> -
> -  If you develop a new program, and you want it to be of the greatest
> -possible use to the public, the best way to achieve this is to make it
> -free software which everyone can redistribute and change under these terms.
> -
> -  To do so, attach the following notices to the program.  It is safest
> -to attach them to the start of each source file to most effectively
> -convey the exclusion of warranty; and each file should have at least
> -the "copyright" line and a pointer to where the full notice is found.
> -
> -    <one line to give the program's name and a brief idea of what it does.>
> -    Copyright (C) <year>  <name of author>
> -
> -    This program is free software; you can redistribute it and/or modify
> -    it under the terms of the GNU General Public License as published by
> -    the Free Software Foundation; either version 2 of the License, or
> -    (at your option) any later version.
> -
> -    This program is distributed in the hope that it will be useful,
> -    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -    GNU General Public License for more details.
> -
> -    You should have received a copy of the GNU General Public License
> -    along with this program; if not, write to the Free Software
> -    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> -
> -
> -Also add information on how to contact you by electronic and paper mail.
> -
> -If the program is interactive, make it output a short notice like this
> -when it starts in an interactive mode:
> -
> -    Gnomovision version 69, Copyright (C) year name of author
> -    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
> -    This is free software, and you are welcome to redistribute it
> -    under certain conditions; type `show c' for details.
> -
> -The hypothetical commands `show w' and `show c' should show the appropriate
> -parts of the General Public License.  Of course, the commands you use may
> -be called something other than `show w' and `show c'; they could even be
> -mouse-clicks or menu items--whatever suits your program.
> -
> -You should also get your employer (if you work as a programmer) or your
> -school, if any, to sign a "copyright disclaimer" for the program, if
> -necessary.  Here is a sample; alter the names:
> -
> -  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
> -  `Gnomovision' (which makes passes at compilers) written by James Hacker.
> -
> -  <signature of Ty Coon>, 1 April 1989
> -  Ty Coon, President of Vice
> -
> -This General Public License does not permit incorporating your program into
> -proprietary programs.  If your program is a subroutine library, you may
> -consider it more useful to permit linking proprietary applications with the
> -library.  If this is what you want to do, use the GNU Library General
> -Public License instead of this License.
> diff --git a/util/abspath.c b/util/abspath.c
> index e44236fa0da5..d59cc5d7bbf7 100644
> --- a/util/abspath.c
> +++ b/util/abspath.c
> @@ -1,4 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0
> +
>  /* originally copied from git/abspath.c */
>  
>  #include <util/util.h>
> diff --git a/util/bitmap.c b/util/bitmap.c
> index 8df8a3253f10..f256614025f7 100644
> --- a/util/bitmap.c
> +++ b/util/bitmap.c
> @@ -1,16 +1,6 @@
> -/*
> - * Copyright(c) 2017 Intel Corporation. All rights reserved.
> - * Copyright(c) 2009 Akinobu Mita. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2017-2020 Intel Corporation. All rights reserved.
> +// Copyright (C) 2009 Akinobu Mita. All rights reserved.
>  
>  /* originally copied from the Linux kernel bitmap implementation */
>  
> diff --git a/util/bitmap.h b/util/bitmap.h
> index 11ef22cc657b..490f3f0bbed8 100644
> --- a/util/bitmap.h
> +++ b/util/bitmap.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
>  #ifndef _NDCTL_BITMAP_H_
>  #define _NDCTL_BITMAP_H_
>  
> diff --git a/util/filter.c b/util/filter.c
> index 7c8debb3d42e..6fdb5fd845e1 100644
> --- a/util/filter.c
> +++ b/util/filter.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
> diff --git a/util/filter.h b/util/filter.h
> index ad3441cc3a16..1e1a41cdfe1a 100644
> --- a/util/filter.h
> +++ b/util/filter.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
>  #ifndef _UTIL_FILTER_H_
>  #define _UTIL_FILTER_H_
>  #include <stdbool.h>
> diff --git a/util/help.c b/util/help.c
> index 2d57fa17791c..c1069dbcc884 100644
> --- a/util/help.c
> +++ b/util/help.c
> @@ -1,17 +1,7 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - * Copyright(c) 2008 Miklos Vajna. All rights reserved.
> - * Copyright(c) 2006 Linus Torvalds. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
> +// Copyright (C) 2008 Miklos Vajna. All rights reserved.
> +// Copyright (C) 2006 Linus Torvalds. All rights reserved.
>  
>  /* originally copied from perf and git */
>  
> diff --git a/util/iomem.c b/util/iomem.c
> index a3c23f5a9d1d..46614a08b5d4 100644
> --- a/util/iomem.c
> +++ b/util/iomem.c
> @@ -1,6 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
> -
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019-2020 Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <errno.h>
>  #include <string.h>
> diff --git a/util/iomem.h b/util/iomem.h
> index aaaf6a7026a5..39c93f067912 100644
> --- a/util/iomem.h
> +++ b/util/iomem.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2019-2020 Intel Corporation. All rights reserved. */
>  #ifndef _NDCTL_IOMEM_H_
>  #define _NDCTL_IOMEM_H_
>  
> diff --git a/util/json.c b/util/json.c
> index 77bd4781551d..35000493607b 100644
> --- a/util/json.c
> +++ b/util/json.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <limits.h>
>  #include <string.h>
>  #include <util/json.h>
> diff --git a/util/json.h b/util/json.h
> index 39a33789bac9..6e82198ed46c 100644
> --- a/util/json.h
> +++ b/util/json.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
>  #ifndef __NDCTL_JSON_H__
>  #define __NDCTL_JSON_H__
>  #include <stdio.h>
> diff --git a/util/list.h b/util/list.h
> index 6439aeff171e..1ea9c59b9f0c 100644
> --- a/util/list.h
> +++ b/util/list.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
>  #ifndef _NDCTL_LIST_H_
>  #define _NDCTL_LIST_H_
>  
> diff --git a/util/log.c b/util/log.c
> index c60ca3318e5b..61ac509f4ac5 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2016-2020, Intel Corporation. All rights reserved.
>  #include <syslog.h>
>  #include <stdlib.h>
>  #include <ctype.h>
> diff --git a/util/log.h b/util/log.h
> index 495e0d33c7f5..28f1c7bfcea4 100644
> --- a/util/log.h
> +++ b/util/log.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2016-2020, Intel Corporation. All rights reserved. */
>  #ifndef __UTIL_LOG_H__
>  #define __UTIL_LOG_H__
>  #include <stdio.h>
> diff --git a/util/main.c b/util/main.c
> index 4f925f84966a..988b9dce1f8c 100644
> --- a/util/main.c
> +++ b/util/main.c
> @@ -1,16 +1,6 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - * Copyright(c) 2006 Linus Torvalds. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
> +// Copyright (C) 2006 Linus Torvalds. All rights reserved.
>  
>  /* originally copied from perf and git */
>  
> diff --git a/util/main.h b/util/main.h
> index 35fb33e63049..c89a84359238 100644
> --- a/util/main.h
> +++ b/util/main.h
> @@ -1,16 +1,6 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - * Copyright(c) 2006 Linus Torvalds. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2006 Linus Torvalds. All rights reserved. */
>  
>  /* originally copied from perf and git */
>  
> diff --git a/util/parse-options.c b/util/parse-options.c
> index c78117426807..c7ad6c4a6ba3 100644
> --- a/util/parse-options.c
> +++ b/util/parse-options.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2007 Pierre Habouzit. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2007 Pierre Habouzit. All rights reserved.
>  
>  /* originally copied from perf and git */
>  
> diff --git a/util/parse-options.h b/util/parse-options.h
> index fc5015a9c9c2..9318fe724c5f 100644
> --- a/util/parse-options.h
> +++ b/util/parse-options.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2007 Pierre Habouzit. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2007 Pierre Habouzit. All rights reserved. */
>  
>  /* originally copied from perf and git */
>  
> diff --git a/util/size.c b/util/size.c
> index 6efa91f6eef9..af2daa958a06 100644
> --- a/util/size.c
> +++ b/util/size.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
>  #include <stdlib.h>
>  #include <limits.h>
>  #include <util/size.h>
> diff --git a/util/size.h b/util/size.h
> index 2138989b42ac..646edae0cefb 100644
> --- a/util/size.h
> +++ b/util/size.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2015-2017 Intel Corporation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
>  
>  #ifndef _NDCTL_SIZE_H_
>  #define _NDCTL_SIZE_H_
> diff --git a/util/strbuf.c b/util/strbuf.c
> index eaa5bedf7e60..6c8752562720 100644
> --- a/util/strbuf.c
> +++ b/util/strbuf.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2005 Junio C Hamano. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2005 Junio C Hamano. All rights reserved.
>  
>  /* originally copied from perf and git */
>  
> diff --git a/util/strbuf.h b/util/strbuf.h
> index 4cf8348dfd55..c9b7d2ef5cf8 100644
> --- a/util/strbuf.h
> +++ b/util/strbuf.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2005 Junio C Hamano. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2005 Junio C Hamano. All rights reserved. */
>  
>  /* originally copied from perf and git */
>  
> diff --git a/util/sysfs.c b/util/sysfs.c
> index 9f7bc1f4930f..cfbab7da74e9 100644
> --- a/util/sysfs.c
> +++ b/util/sysfs.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2014-2020, Intel Corporation. All rights reserved.
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stddef.h>
> diff --git a/util/sysfs.h b/util/sysfs.h
> index fb169c6da80a..6485a73d8ed7 100644
> --- a/util/sysfs.h
> +++ b/util/sysfs.h
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright (c) 2014-2016, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU Lesser General Public License,
> - * version 2.1, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> - * more details.
> - */
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2014-2020, Intel Corporation. All rights reserved. */
>  #ifndef __UTIL_SYSFS_H__
>  #define __UTIL_SYSFS_H__
>  
> diff --git a/util/usage.c b/util/usage.c
> index 0896955c7f52..0ed10cd910c3 100644
> --- a/util/usage.c
> +++ b/util/usage.c
> @@ -1,15 +1,5 @@
> -/*
> - * Copyright(c) 2005 Linus Torvalds. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2005 Linus Torvalds. All rights reserved.
>  
>  /* originally copied from perf and git */
>  
> diff --git a/util/util.h b/util/util.h
> index 54c6ef18b6d7..ae0e4e1fc340 100644
> --- a/util/util.h
> +++ b/util/util.h
> @@ -1,16 +1,6 @@
> -/*
> - * Copyright(c) 2005 Junio C Hamano. All rights reserved.
> - * Copyright(c) 2005 Linus Torvalds. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2005 Junio C Hamano. All rights reserved. */
> +/* Copyright (C) 2005 Linus Torvalds. All rights reserved. */
>  
>  /* originally copied from perf and git */
>  
> diff --git a/util/wrapper.c b/util/wrapper.c
> index b0de7bc92bb1..026a54f97058 100644
> --- a/util/wrapper.c
> +++ b/util/wrapper.c
> @@ -1,16 +1,6 @@
> -/*
> - * Copyright(c) 2005 Junio C Hamano. All rights reserved.
> - * Copyright(c) 2005 Linus Torvalds. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2005 Junio C Hamano. All rights reserved.
> +// Copyright (C) 2005 Linus Torvalds. All rights reserved.
>  
>  /* originally copied from perf and git */
>  
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

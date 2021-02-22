Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35770322184
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 22:36:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E5DA100EB85C;
	Mon, 22 Feb 2021 13:36:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF176100EB856
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 13:36:21 -0800 (PST)
IronPort-SDR: 8+E/rS2k+cnu/HaplAfY8yUgQ+GfanJMARNcdLFUQISRfB+MK4YaWkaGiEhAHJYxJdp4iakNdW
 MnT5xwgTXIXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="184658836"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400";
   d="scan'208";a="184658836"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 13:36:20 -0800
IronPort-SDR: IZc4oklVJIoNrg0O0PeUQlQnF7SurTTYQcWJFPjfKrnbVQpzWJIdlN4KGZZBdXyh3CK9w//IwG
 mj5SiZfo5NMg==
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400";
   d="scan'208";a="402800597"
Received: from hlgebhar-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 13:36:19 -0800
Date: Mon, 22 Feb 2021 13:36:15 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH v2 01/13] cxl: add a cxl utility and libcxl library
Message-ID: <20210222213615.lwjansmxclewb3xo@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
 <20210219020331.725687-2-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210219020331.725687-2-vishal.l.verma@intel.com>
Message-ID-Hash: MGUOQENPUGJPU2F4EJ2D74CWWWBLXZL2
X-Message-ID-Hash: MGUOQENPUGJPU2F4EJ2D74CWWWBLXZL2
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MGUOQENPUGJPU2F4EJ2D74CWWWBLXZL2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-18 19:03:19, Vishal Verma wrote:
> CXL - or Compute eXpress Link - is a new interconnect that extends PCIe
> to support a wide range of devices, including cache coherent memory
> expanders. As such, these devices can be new sources of 'persistent
> memory', and the 'ndctl' umbrella of tools and libraries needs to be able
> to interact with them.
> 
> Add a new utility and library for managing these CXL memory devices. This
> is an initial bring-up for interacting with CXL devices, and only includes
> adding the utility and library infrastructure, parsing device information
> from sysfs for CXL devices, and providing a 'cxl-list' command to
> display this information in JSON formatted output.
> 
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

A couple of really minor things below

> ---
>  Documentation/cxl/cxl-list.txt       |  65 +++++
>  Documentation/cxl/cxl.txt            |  34 +++
>  Documentation/cxl/human-option.txt   |   8 +
>  Documentation/cxl/verbose-option.txt |   5 +
>  configure.ac                         |   3 +
>  Makefile.am                          |   8 +-
>  Makefile.am.in                       |   4 +
>  cxl/lib/private.h                    |  29 +++
>  cxl/lib/libcxl.c                     | 345 +++++++++++++++++++++++++++
>  cxl/builtin.h                        |   8 +
>  cxl/libcxl.h                         |  55 +++++
>  util/filter.h                        |   2 +
>  util/json.h                          |   3 +
>  util/main.h                          |   3 +
>  cxl/cxl.c                            |  95 ++++++++
>  cxl/list.c                           | 113 +++++++++
>  util/filter.c                        |  20 ++
>  util/json.c                          |  26 ++
>  .gitignore                           |   2 +
>  Documentation/cxl/Makefile.am        |  58 +++++
>  cxl/Makefile.am                      |  21 ++
>  cxl/lib/Makefile.am                  |  32 +++
>  cxl/lib/libcxl.pc.in                 |  11 +
>  cxl/lib/libcxl.sym                   |  29 +++
>  24 files changed, 976 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/cxl/cxl-list.txt
>  create mode 100644 Documentation/cxl/cxl.txt
>  create mode 100644 Documentation/cxl/human-option.txt
>  create mode 100644 Documentation/cxl/verbose-option.txt
>  create mode 100644 cxl/lib/private.h
>  create mode 100644 cxl/lib/libcxl.c
>  create mode 100644 cxl/builtin.h
>  create mode 100644 cxl/libcxl.h
>  create mode 100644 cxl/cxl.c
>  create mode 100644 cxl/list.c
>  create mode 100644 Documentation/cxl/Makefile.am
>  create mode 100644 cxl/Makefile.am
>  create mode 100644 cxl/lib/Makefile.am
>  create mode 100644 cxl/lib/libcxl.pc.in
>  create mode 100644 cxl/lib/libcxl.sym
> 
> diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
> new file mode 100644
> index 0000000..107b388
> --- /dev/null
> +++ b/Documentation/cxl/cxl-list.txt
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +cxl-list(1)
> +===========
> +
> +NAME
> +----
> +cxl-list - CXL capable host bridges, switches, devices, and their attributes
> +in json.
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'cxl list' [<options>]
> +
> +Walk the CXL capable device hierarchy in the system and list all device
> +instances along with some of their major attributes.

This doesn't seem to match the above. Here it's just devices and above you talk
about bridges and switches as well.

> +
> +Options can be specified to limit the output to specific devices.
> +By default, 'cxl list' with no options is equivalent to:
> +[verse]
> +cxl list --devices
> +
> +EXAMPLE
> +-------
> +----
> +# cxl list --devices
> +{
> +  "memdev":"mem0",
> +  "pmem_size":268435456,
> +  "ram_size":0,
> +}
> +----
> +
> +OPTIONS
> +-------
> +-d::
> +--dev=::
> +	Specify a cxl device name to filter the listing. For example:
> +----
> +# cxl list --dev=mem0
> +{
> +  "memdev":"mem0",
> +  "pmem_size":268435456,
> +  "ram_size":0,
> +}
> +----
> +
> +-D::
> +--devices::
> +	Include all CXL devices in the listing
> +
> +-i::
> +--idle::
> +	Include idle (not enabled / zero-sized) devices in the listing
> +
> +include::human-option.txt[]
> +
> +include::verbose-option.txt[]
> +
> +include::../copyright.txt[]
> +
> +SEE ALSO
> +--------
> +linkcxl:ndctl-list[1]
> diff --git a/Documentation/cxl/cxl.txt b/Documentation/cxl/cxl.txt
> new file mode 100644
> index 0000000..e99e61b
> --- /dev/null
> +++ b/Documentation/cxl/cxl.txt
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +cxl(1)
> +======
> +
> +NAME
> +----
> +cxl - Provides enumeration and provisioning commands for CXL devices
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'cxl' [--version] [--help] COMMAND [ARGS]
> +
> +OPTIONS
> +-------
> +-v::
> +--version::
> +  Display the version of the 'cxl' utility.
> +
> +-h::
> +--help::
> +  Run the 'cxl help' command.
> +
> +DESCRIPTION
> +-----------
> +The cxl utility provides enumeration and provisioning commands for
> +the CXL devices managed by the Linux kernel.
> +
> +include::../copyright.txt[]
> +
> +SEE ALSO
> +--------
> +linkcxl:ndctl[1]
> diff --git a/Documentation/cxl/human-option.txt b/Documentation/cxl/human-option.txt
> new file mode 100644
> index 0000000..2f4de7a
> --- /dev/null
> +++ b/Documentation/cxl/human-option.txt
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +-u::
> +--human::
> +	By default the command will output machine-friendly raw-integer
> +	data. Instead, with this flag, numbers representing storage size
> +	will be formatted as human readable strings with units, other
> +	fields are converted to hexadecimal strings.
> diff --git a/Documentation/cxl/verbose-option.txt b/Documentation/cxl/verbose-option.txt
> new file mode 100644
> index 0000000..cb62c8e
> --- /dev/null
> +++ b/Documentation/cxl/verbose-option.txt
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +-v::
> +--verbose::
> +	Emit more debug messages
> diff --git a/configure.ac b/configure.ac
> index 5ec8d2f..7f5e6f0 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -222,12 +222,15 @@ AC_CONFIG_HEADERS(config.h)
>  AC_CONFIG_FILES([
>          Makefile
>          daxctl/lib/Makefile
> +        cxl/lib/Makefile
>          ndctl/lib/Makefile
>          ndctl/Makefile
>          daxctl/Makefile
> +        cxl/Makefile
>          test/Makefile
>          Documentation/ndctl/Makefile
>          Documentation/daxctl/Makefile
> +        Documentation/cxl/Makefile
>  ])
>  
>  AC_OUTPUT
> diff --git a/Makefile.am b/Makefile.am
> index 60a1998..428fd40 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -1,9 +1,9 @@
>  include Makefile.am.in
>  
>  ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
> -SUBDIRS = . daxctl/lib ndctl/lib ndctl daxctl
> +SUBDIRS = . cxl/lib daxctl/lib ndctl/lib cxl ndctl daxctl
>  if ENABLE_DOCS
> -SUBDIRS += Documentation/ndctl Documentation/daxctl
> +SUBDIRS += Documentation/ndctl Documentation/daxctl Documentation/cxl
>  endif
>  SUBDIRS += test
>  
> @@ -87,4 +87,6 @@ libutil_a_SOURCES = \
>  	util/filter.h \
>  	util/bitmap.h
>  
> -nobase_include_HEADERS = daxctl/libdaxctl.h
> +nobase_include_HEADERS = \
> +	daxctl/libdaxctl.h \
> +	cxl/libcxl.h
> diff --git a/Makefile.am.in b/Makefile.am.in
> index bdceda9..aaeee53 100644
> --- a/Makefile.am.in
> +++ b/Makefile.am.in
> @@ -42,3 +42,7 @@ LIBNDCTL_AGE=19
>  LIBDAXCTL_CURRENT=6
>  LIBDAXCTL_REVISION=0
>  LIBDAXCTL_AGE=5
> +
> +LIBCXL_CURRENT=1
> +LIBCXL_REVISION=0
> +LIBCXL_AGE=0
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> new file mode 100644
> index 0000000..fc88fa1
> --- /dev/null
> +++ b/cxl/lib/private.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2020-2021, Intel Corporation. All rights reserved. */
> +#ifndef _LIBCXL_PRIVATE_H_
> +#define _LIBCXL_PRIVATE_H_
> +
> +#include <libkmod.h>
> +
> +#define CXL_EXPORT __attribute__ ((visibility("default")))
> +
> +struct cxl_memdev {
> +	int id, major, minor;
> +	void *dev_buf;
> +	size_t buf_len;
> +	char *dev_path;
> +	char *firmware_version;
> +	struct cxl_ctx *ctx;
> +	struct list_node list;
> +	unsigned long long pmem_size;
> +	unsigned long long ram_size;
> +	int payload_max;
> +	struct kmod_module *module;
> +};
> +
> +static inline int check_kmod(struct kmod_ctx *kmod_ctx)
> +{
> +	return kmod_ctx ? 0 : -ENXIO;
> +}
> +
> +#endif /* _LIBCXL_PRIVATE_H_ */
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> new file mode 100644
> index 0000000..d34e7d0
> --- /dev/null
> +++ b/cxl/lib/libcxl.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: LGPL-2.1
> +// Copyright (C) 2020-2021, Intel Corporation. All rights reserved.
> +#include <stdio.h>
> +#include <errno.h>
> +#include <limits.h>
> +#include <libgen.h>
> +#include <stdlib.h>
> +#include <dirent.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/sysmacros.h>
> +#include <uuid/uuid.h>
> +#include <ccan/list/list.h>
> +#include <ccan/array_size/array_size.h>
> +
> +#include <util/log.h>
> +#include <util/sysfs.h>
> +#include <util/bitmap.h>
> +#include <cxl/libcxl.h>
> +#include "private.h"
> +
> +/**
> + * struct cxl_ctx - library user context to find "nd" instances
> + *
> + * Instantiate with cxl_new(), which takes an initial reference.  Free
> + * the context by dropping the reference count to zero with
> + * cxl_unref(), or take additional references with cxl_ref()
> + * @timeout: default library timeout in milliseconds
> + */
> +struct cxl_ctx {
> +	/* log_ctx must be first member for cxl_set_log_fn compat */
> +	struct log_ctx ctx;
> +	int refcount;
> +	void *userdata;
> +	int memdevs_init;
> +	struct list_head memdevs;
> +	struct kmod_ctx *kmod_ctx;
> +	void *private_data;
> +};
> +
> +static void free_memdev(struct cxl_memdev *memdev, struct list_head *head)
> +{
> +	if (head)
> +		list_del_from(head, &memdev->list);
> +	kmod_module_unref(memdev->module);
> +	free(memdev->firmware_version);
> +	free(memdev->dev_buf);
> +	free(memdev->dev_path);
> +	free(memdev);
> +}
> +
> +/**
> + * cxl_get_userdata - retrieve stored data pointer from library context
> + * @ctx: cxl library context
> + *
> + * This might be useful to access from callbacks like a custom logging
> + * function.
> + */
> +CXL_EXPORT void *cxl_get_userdata(struct cxl_ctx *ctx)
> +{
> +	if (ctx == NULL)
> +		return NULL;
> +	return ctx->userdata;
> +}
> +
> +/**
> + * cxl_set_userdata - store custom @userdata in the library context
> + * @ctx: cxl library context
> + * @userdata: data pointer
> + */
> +CXL_EXPORT void cxl_set_userdata(struct cxl_ctx *ctx, void *userdata)
> +{
> +	if (ctx == NULL)
> +		return;
> +	ctx->userdata = userdata;
> +}
> +
> +CXL_EXPORT void cxl_set_private_data(struct cxl_ctx *ctx, void *data)
> +{
> +	ctx->private_data = data;
> +}
> +
> +CXL_EXPORT void *cxl_get_private_data(struct cxl_ctx *ctx)
> +{
> +	return ctx->private_data;
> +}
> +
> +/**
> + * cxl_new - instantiate a new library context
> + * @ctx: context to establish
> + *
> + * Returns zero on success and stores an opaque pointer in ctx.  The
> + * context is freed by cxl_unref(), i.e. cxl_new() implies an
> + * internal cxl_ref().
> + */
> +CXL_EXPORT int cxl_new(struct cxl_ctx **ctx)
> +{
> +	struct kmod_ctx *kmod_ctx;
> +	struct cxl_ctx *c;
> +	int rc = 0;
> +
> +	c = calloc(1, sizeof(struct cxl_ctx));
> +	if (!c)
> +		return -ENOMEM;
> +
> +	kmod_ctx = kmod_new(NULL, NULL);
> +	if (check_kmod(kmod_ctx) != 0) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	c->refcount = 1;
> +	log_init(&c->ctx, "libcxl", "CXL_LOG");
> +	info(c, "ctx %p created\n", c);
> +	dbg(c, "log_priority=%d\n", c->ctx.log_priority);
> +	*ctx = c;
> +	list_head_init(&c->memdevs);
> +	c->kmod_ctx = kmod_ctx;
> +
> +	return 0;
> +out:
> +	free(c);
> +	return rc;
> +}
> +
> +/**
> + * cxl_ref - take an additional reference on the context
> + * @ctx: context established by cxl_new()
> + */
> +CXL_EXPORT struct cxl_ctx *cxl_ref(struct cxl_ctx *ctx)
> +{
> +	if (ctx == NULL)
> +		return NULL;
> +	ctx->refcount++;
> +	return ctx;
> +}
> +
> +/**
> + * cxl_unref - drop a context reference count
> + * @ctx: context established by cxl_new()
> + *
> + * Drop a reference and if the resulting reference count is 0 destroy
> + * the context.
> + */
> +CXL_EXPORT void cxl_unref(struct cxl_ctx *ctx)
> +{
> +	struct cxl_memdev *memdev, *_d;
> +
> +	if (ctx == NULL)
> +		return;
> +	ctx->refcount--;
> +	if (ctx->refcount > 0)
> +		return;
> +
> +	list_for_each_safe(&ctx->memdevs, memdev, _d, list)
> +		free_memdev(memdev, &ctx->memdevs);
> +
> +	kmod_unref(ctx->kmod_ctx);
> +	info(ctx, "context %p released\n", ctx);
> +	free(ctx);
> +}
> +
> +/**
> + * cxl_set_log_fn - override default log routine
> + * @ctx: cxl library context
> + * @log_fn: function to be called for logging messages
> + *
> + * The built-in logging writes to stderr. It can be overridden by a
> + * custom function, to plug log messages into the user's logging
> + * functionality.
> + */
> +CXL_EXPORT void cxl_set_log_fn(struct cxl_ctx *ctx,
> +		void (*cxl_log_fn)(struct cxl_ctx *ctx, int priority,
> +			const char *file, int line, const char *fn,
> +			const char *format, va_list args))
> +{
> +	ctx->ctx.log_fn = (log_fn) cxl_log_fn;
> +	info(ctx, "custom logging function %p registered\n", cxl_log_fn);
> +}
> +
> +/**
> + * cxl_get_log_priority - retrieve current library loglevel (syslog)
> + * @ctx: cxl library context
> + */
> +CXL_EXPORT int cxl_get_log_priority(struct cxl_ctx *ctx)
> +{
> +	return ctx->ctx.log_priority;
> +}
> +
> +/**
> + * cxl_set_log_priority - set log verbosity
> + * @priority: from syslog.h, LOG_ERR, LOG_INFO, LOG_DEBUG
> + *
> + * Note: LOG_DEBUG requires library be built with "configure --enable-debug"
> + */
> +CXL_EXPORT void cxl_set_log_priority(struct cxl_ctx *ctx, int priority)
> +{
> +	ctx->ctx.log_priority = priority;
> +}
> +
> +static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
> +{
> +	const char *devname = devpath_to_devname(cxlmem_base);
> +	char *path = calloc(1, strlen(cxlmem_base) + 100);
> +	struct cxl_ctx *ctx = parent;
> +	struct cxl_memdev *memdev, *memdev_dup;
> +	char buf[SYSFS_ATTR_SIZE];
> +	struct stat st;
> +
> +	if (!path)
> +		return NULL;
> +	dbg(ctx, "%s: base: \'%s\'\n", __func__, cxlmem_base);
> +
> +	memdev = calloc(1, sizeof(*memdev));
> +	if (!memdev)
> +		goto err_dev;
> +	memdev->id = id;
> +	memdev->ctx = ctx;
> +
> +	sprintf(path, "/dev/cxl/%s", devname);
> +	if (stat(path, &st) < 0)
> +		goto err_read;
> +	memdev->major = major(st.st_rdev);
> +	memdev->minor = minor(st.st_rdev);
> +
> +	sprintf(path, "%s/pmem/size", cxlmem_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		goto err_read;
> +	memdev->pmem_size = strtoull(buf, NULL, 0);

For strtoull usage and below - it certainly doesn't matter much but maybe using
10 for base would better since sysfs is ABI and therefore anything other than
base 10 is incorrect.

> +
> +	sprintf(path, "%s/ram/size", cxlmem_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		goto err_read;
> +	memdev->ram_size = strtoull(buf, NULL, 0);
> +
> +	sprintf(path, "%s/payload_max", cxlmem_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		goto err_read;
> +	memdev->payload_max = strtoull(buf, NULL, 0);
> +	if (memdev->payload_max < 0)
> +		goto err_read;
> +
> +	memdev->dev_path = strdup(cxlmem_base);
> +	if (!memdev->dev_path)
> +		goto err_read;
> +
> +	sprintf(path, "%s/firmware_version", cxlmem_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		goto err_read;
> +
> +	memdev->firmware_version = strdup(buf);
> +	if (!memdev->firmware_version)
> +		goto err_read;
> +
> +	memdev->dev_buf = calloc(1, strlen(cxlmem_base) + 50);
> +	if (!memdev->dev_buf)
> +		goto err_read;
> +	memdev->buf_len = strlen(cxlmem_base) + 50;
> +
> +	cxl_memdev_foreach(ctx, memdev_dup)
> +		if (memdev_dup->id == memdev->id) {
> +			free_memdev(memdev, NULL);
> +			free(path);
> +			return memdev_dup;
> +		}
> +
> +	list_add(&ctx->memdevs, &memdev->list);
> +	free(path);
> +	return memdev;
> +
> + err_read:
> +	free(memdev->firmware_version);
> +	free(memdev->dev_buf);
> +	free(memdev->dev_path);
> +	free(memdev);
> + err_dev:
> +	free(path);
> +	return NULL;
> +}
> +
> +static void cxl_memdevs_init(struct cxl_ctx *ctx)
> +{
> +	if (ctx->memdevs_init)
> +		return;
> +
> +	ctx->memdevs_init = 1;
> +
> +	sysfs_device_parse(ctx, "/sys/bus/cxl/devices", "mem", ctx,
> +			   add_cxl_memdev);
> +}
> +
> +CXL_EXPORT struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev)
> +{
> +	return memdev->ctx;
> +}
> +
> +CXL_EXPORT struct cxl_memdev *cxl_memdev_get_first(struct cxl_ctx *ctx)
> +{
> +	cxl_memdevs_init(ctx);
> +
> +	return list_top(&ctx->memdevs, struct cxl_memdev, list);
> +}
> +
> +CXL_EXPORT struct cxl_memdev *cxl_memdev_get_next(struct cxl_memdev *memdev)
> +{
> +	struct cxl_ctx *ctx = memdev->ctx;
> +
> +	return list_next(&ctx->memdevs, memdev, list);
> +}
> +
> +CXL_EXPORT int cxl_memdev_get_id(struct cxl_memdev *memdev)
> +{
> +	return memdev->id;
> +}
> +
> +CXL_EXPORT const char *cxl_memdev_get_devname(struct cxl_memdev *memdev)
> +{
> +	return devpath_to_devname(memdev->dev_path);
> +}
> +
> +CXL_EXPORT int cxl_memdev_get_major(struct cxl_memdev *memdev)
> +{
> +	return memdev->major;
> +}
> +
> +CXL_EXPORT int cxl_memdev_get_minor(struct cxl_memdev *memdev)
> +{
> +	return memdev->minor;
> +}
> +
> +CXL_EXPORT unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev)
> +{
> +	return memdev->pmem_size;
> +}
> +
> +CXL_EXPORT unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev)
> +{
> +	return memdev->ram_size;
> +}
> +
> +CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev)
> +{
> +	return memdev->firmware_version;
> +}
> diff --git a/cxl/builtin.h b/cxl/builtin.h
> new file mode 100644
> index 0000000..3797f98
> --- /dev/null
> +++ b/cxl/builtin.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2020-2021 Intel Corporation. All rights reserved. */
> +#ifndef _CXL_BUILTIN_H_
> +#define _CXL_BUILTIN_H_
> +
> +struct cxl_ctx;
> +int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx);
> +#endif /* _CXL_BUILTIN_H_ */
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> new file mode 100644
> index 0000000..fd06790
> --- /dev/null
> +++ b/cxl/libcxl.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: LGPL-2.1 */
> +/* Copyright (C) 2020-2021, Intel Corporation. All rights reserved. */
> +#ifndef _LIBCXL_H_
> +#define _LIBCXL_H_
> +
> +#include <stdarg.h>
> +#include <unistd.h>
> +
> +#ifdef HAVE_UUID
> +#include <uuid/uuid.h>
> +#else
> +typedef unsigned char uuid_t[16];
> +#endif
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +struct cxl_ctx;
> +struct cxl_ctx *cxl_ref(struct cxl_ctx *ctx);
> +void cxl_unref(struct cxl_ctx *ctx);
> +int cxl_new(struct cxl_ctx **ctx);
> +void cxl_set_log_fn(struct cxl_ctx *ctx,
> +		void (*log_fn)(struct cxl_ctx *ctx, int priority,
> +			const char *file, int line, const char *fn,
> +			const char *format, va_list args));
> +int cxl_get_log_priority(struct cxl_ctx *ctx);
> +void cxl_set_log_priority(struct cxl_ctx *ctx, int priority);
> +void cxl_set_userdata(struct cxl_ctx *ctx, void *userdata);
> +void *cxl_get_userdata(struct cxl_ctx *ctx);
> +void cxl_set_private_data(struct cxl_ctx *ctx, void *data);
> +void *cxl_get_private_data(struct cxl_ctx *ctx);
> +
> +struct cxl_memdev;
> +struct cxl_memdev *cxl_memdev_get_first(struct cxl_ctx *ctx);
> +struct cxl_memdev *cxl_memdev_get_next(struct cxl_memdev *memdev);
> +int cxl_memdev_get_id(struct cxl_memdev *memdev);
> +const char *cxl_memdev_get_devname(struct cxl_memdev *memdev);
> +int cxl_memdev_get_major(struct cxl_memdev *memdev);
> +int cxl_memdev_get_minor(struct cxl_memdev *memdev);
> +struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
> +unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
> +unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
> +const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
> +
> +#define cxl_memdev_foreach(ctx, memdev) \
> +        for (memdev = cxl_memdev_get_first(ctx); \
> +             memdev != NULL; \
> +             memdev = cxl_memdev_get_next(memdev))
> +
> +#ifdef __cplusplus
> +} /* extern "C" */
> +#endif
> +
> +#endif
> diff --git a/util/filter.h b/util/filter.h
> index 1e1a41c..9a80d65 100644
> --- a/util/filter.h
> +++ b/util/filter.h
> @@ -29,6 +29,8 @@ struct daxctl_dev *util_daxctl_dev_filter(struct daxctl_dev *dev,
>  		const char *ident);
>  struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
>  		const char *ident);
> +struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
> +		const char *ident);
>  
>  enum ndctl_namespace_mode util_nsmode(const char *mode);
>  const char *util_nsmode_name(enum ndctl_namespace_mode mode);
> diff --git a/util/json.h b/util/json.h
> index 0f09e36..91918c8 100644
> --- a/util/json.h
> +++ b/util/json.h
> @@ -55,4 +55,7 @@ struct json_object *util_dimm_health_to_json(struct ndctl_dimm *dimm);
>  struct json_object *util_dimm_firmware_to_json(struct ndctl_dimm *dimm,
>  		unsigned long flags);
>  struct json_object *util_region_capabilities_to_json(struct ndctl_region *region);
> +struct cxl_memdev;
> +struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
> +		unsigned long flags);
>  #endif /* __NDCTL_JSON_H__ */
> diff --git a/util/main.h b/util/main.h
> index c89a843..80b55c4 100644
> --- a/util/main.h
> +++ b/util/main.h
> @@ -10,16 +10,19 @@
>  enum program {
>  	PROG_NDCTL,
>  	PROG_DAXCTL,
> +	PROG_CXL,
>  };
>  
>  struct ndctl_ctx;
>  struct daxctl_ctx;
> +struct cxl_ctx;
>  
>  struct cmd_struct {
>  	const char *cmd;
>  	union {
>  		int (*n_fn)(int, const char **, struct ndctl_ctx *ctx);
>  		int (*d_fn)(int, const char **, struct daxctl_ctx *ctx);
> +		int (*c_fn)(int, const char **, struct cxl_ctx *ctx);
>  	};
>  };
>  
> diff --git a/cxl/cxl.c b/cxl/cxl.c
> new file mode 100644
> index 0000000..ed062ef
> --- /dev/null
> +++ b/cxl/cxl.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2020-2021 Intel Corporation. All rights reserved. */
> +/* Copyright (C) 2005 Andreas Ericsson. All rights reserved. */
> +
> +/* originally copied from perf and git */
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <cxl/libcxl.h>
> +#include <util/parse-options.h>
> +#include <ccan/array_size/array_size.h>
> +
> +#include <util/strbuf.h>
> +#include <util/util.h>
> +#include <util/main.h>
> +#include <cxl/builtin.h>
> +
> +const char cxl_usage_string[] = "cxl [--version] [--help] COMMAND [ARGS]";
> +const char cxl_more_info_string[] =
> +	"See 'cxl help COMMAND' for more information on a specific command.\n"
> +	" cxl --list-cmds to see all available commands";
> +
> +static int cmd_version(int argc, const char **argv, struct cxl_ctx *ctx)
> +{
> +	printf("%s\n", VERSION);
> +	return 0;
> +}
> +
> +static int cmd_help(int argc, const char **argv, struct cxl_ctx *ctx)
> +{
> +	const char * const builtin_help_subcommands[] = {
> +		"list", NULL,
> +	};

Move NULL to newline.

> +	struct option builtin_help_options[] = {
> +		OPT_END(),
> +	};
> +	const char *builtin_help_usage[] = {
> +		"cxl help [command]",
> +		NULL
> +	};
> +
> +	argc = parse_options_subcommand(argc, argv, builtin_help_options,
> +			builtin_help_subcommands, builtin_help_usage, 0);
> +
> +	if (!argv[0]) {
> +		printf("\n usage: %s\n\n", cxl_usage_string);
> +		printf("\n %s\n\n", cxl_more_info_string);
> +		return 0;
> +	}
> +
> +	return help_show_man_page(argv[0], "cxl", "CXL_MAN_VIEWER");
> +}
> +
> +static struct cmd_struct commands[] = {
> +	{ "version", .c_fn = cmd_version },
> +	{ "list", .c_fn = cmd_list },
> +	{ "help", .c_fn = cmd_help },
> +};
> +
> +int main(int argc, const char **argv)
> +{
> +	struct cxl_ctx *ctx;
> +	int rc;
> +
> +	/* Look for flags.. */
> +	argv++;
> +	argc--;
> +	main_handle_options(&argv, &argc, cxl_usage_string, commands,
> +			ARRAY_SIZE(commands));
> +
> +	if (argc > 0) {
> +		if (!prefixcmp(argv[0], "--"))
> +			argv[0] += 2;
> +	} else {
> +		/* The user didn't specify a command; give them help */
> +		printf("\n usage: %s\n\n", cxl_usage_string);
> +		printf("\n %s\n\n", cxl_more_info_string);
> +		goto out;
> +	}
> +
> +	rc = cxl_new(&ctx);
> +	if (rc)
> +		goto out;
> +	main_handle_internal_command(argc, argv, ctx, commands,
> +			ARRAY_SIZE(commands), PROG_CXL);
> +	cxl_unref(ctx);
> +	fprintf(stderr, "Unknown command: '%s'\n", argv[0]);
> +out:
> +	return 1;
> +}
> diff --git a/cxl/list.c b/cxl/list.c
> new file mode 100644
> index 0000000..7a4f34b
> --- /dev/null
> +++ b/cxl/list.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2020-2021 Intel Corporation. All rights reserved. */
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <limits.h>
> +#include <util/json.h>
> +#include <util/filter.h>
> +#include <json-c/json.h>
> +#include <cxl/libcxl.h>
> +#include <util/parse-options.h>
> +#include <ccan/array_size/array_size.h>
> +
> +static struct {
> +	bool memdevs;
> +	bool idle;
> +	bool human;
> +} list;
> +
> +static unsigned long listopts_to_flags(void)
> +{
> +	unsigned long flags = 0;
> +
> +	if (list.idle)
> +		flags |= UTIL_JSON_IDLE;
> +	if (list.human)
> +		flags |= UTIL_JSON_HUMAN;
> +	return flags;
> +}
> +
> +static struct {
> +	const char *memdev;
> +} param;
> +
> +static int did_fail;
> +
> +#define fail(fmt, ...) \
> +do { \
> +	did_fail = 1; \
> +	fprintf(stderr, "cxl-%s:%s:%d: " fmt, \
> +			VERSION, __func__, __LINE__, ##__VA_ARGS__); \
> +} while (0)
> +
> +static int num_list_flags(void)
> +{
> +	return list.memdevs;
> +}
> +
> +int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
> +{
> +	const struct option options[] = {
> +		OPT_STRING('d', "memdev", &param.memdev, "memory device name",
> +			   "filter by CXL memory device name"),
> +		OPT_BOOLEAN('D', "memdevs", &list.memdevs,
> +			    "include CXL memory device info"),
> +		OPT_BOOLEAN('i', "idle", &list.idle, "include idle devices"),
> +		OPT_BOOLEAN('u', "human", &list.human,
> +				"use human friendly number formats "),
> +		OPT_END(),
> +	};
> +	const char * const u[] = {
> +		"cxl list [<options>]",
> +		NULL
> +	};
> +	struct json_object *jdevs = NULL;
> +	unsigned long list_flags;
> +	struct cxl_memdev *memdev;
> +	int i;
> +
> +        argc = parse_options(argc, argv, options, u, 0);

Tab.

/me looks for .clang-format

> +	for (i = 0; i < argc; i++)
> +		error("unknown parameter \"%s\"\n", argv[i]);
> +
> +	if (argc)
> +		usage_with_options(u, options);
> +
> +	if (num_list_flags() == 0)
> +		list.memdevs = true;
> +
> +	list_flags = listopts_to_flags();
> +
> +	cxl_memdev_foreach(ctx, memdev) {
> +		struct json_object *jdev = NULL;
> +
> +		if (!util_cxl_memdev_filter(memdev, param.memdev))
> +			continue;
> +
> +		if (list.memdevs) {
> +			if (!jdevs) {
> +				jdevs = json_object_new_array();
> +				if (!jdevs) {
> +					fail("\n");
> +					continue;
> +				}
> +			}
> +
> +			jdev = util_cxl_memdev_to_json(memdev, list_flags);
> +			if (!jdev) {
> +				fail("\n");
> +				continue;
> +			}
> +			json_object_array_add(jdevs, jdev);
> +		}
> +	}
> +
> +	if (jdevs)
> +		util_display_json_array(stdout, jdevs, list_flags);
> +
> +	if (did_fail)
> +		return -ENOMEM;
> +	return 0;
> +}
> diff --git a/util/filter.c b/util/filter.c
> index 8b4aad3..d81dade 100644
> --- a/util/filter.c
> +++ b/util/filter.c
> @@ -12,6 +12,7 @@
>  #include <util/filter.h>
>  #include <ndctl/libndctl.h>
>  #include <daxctl/libdaxctl.h>
> +#include <cxl/libcxl.h>
>  
>  struct ndctl_bus *util_bus_filter(struct ndctl_bus *bus, const char *__ident)
>  {
> @@ -339,6 +340,25 @@ struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
>  	return NULL;
>  }
>  
> +struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
> +					  const char *ident)
> +{
> +	int memdev_id;
> +
> +	if (!ident || strcmp(ident, "all") == 0)
> +		return memdev;
> +
> +	if (strcmp(ident, cxl_memdev_get_devname(memdev)) == 0)
> +		return memdev;
> +
> +	if ((sscanf(ident, "%d", &memdev_id) == 1
> +			|| sscanf(ident, "mem%d", &memdev_id) == 1)
> +			&& cxl_memdev_get_id(memdev) == memdev_id)
> +		return memdev;
> +
> +	return NULL;
> +}
> +
>  enum ndctl_namespace_mode util_nsmode(const char *mode)
>  {
>  	if (!mode)
> diff --git a/util/json.c b/util/json.c
> index ca0167b..a855571 100644
> --- a/util/json.c
> +++ b/util/json.c
> @@ -9,6 +9,7 @@
>  #include <json-c/printbuf.h>
>  #include <ndctl/libndctl.h>
>  #include <daxctl/libdaxctl.h>
> +#include <cxl/libcxl.h>
>  #include <ccan/array_size/array_size.h>
>  #include <ccan/short_types/short_types.h>
>  #include <ndctl.h>
> @@ -1429,3 +1430,28 @@ struct json_object *util_badblock_rec_to_json(u64 block, u64 count,
>  	json_object_put(jerr);
>  	return NULL;
>  }
> +
> +struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
> +		unsigned long flags)
> +{
> +	const char *devname = cxl_memdev_get_devname(memdev);
> +	struct json_object *jdev, *jobj;
> +
> +	jdev = json_object_new_object();
> +	if (!devname || !jdev)
> +		return NULL;
> +
> +	jobj = json_object_new_string(devname);
> +	if (jobj)
> +		json_object_object_add(jdev, "memdev", jobj);
> +
> +	jobj = util_json_object_size(cxl_memdev_get_pmem_size(memdev), flags);
> +	if (jobj)
> +		json_object_object_add(jdev, "pmem_size", jobj);
> +
> +	jobj = util_json_object_size(cxl_memdev_get_ram_size(memdev), flags);
> +	if (jobj)
> +		json_object_object_add(jdev, "ram_size", jobj);
> +
> +	return jdev;
> +}
> diff --git a/.gitignore b/.gitignore
> index 3ef9ff7..de43823 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -15,8 +15,10 @@ Makefile.in
>  *.1
>  Documentation/daxctl/asciidoc.conf
>  Documentation/ndctl/asciidoc.conf
> +Documentation/cxl/asciidoc.conf
>  Documentation/daxctl/asciidoctor-extensions.rb
>  Documentation/ndctl/asciidoctor-extensions.rb
> +Documentation/cxl/asciidoctor-extensions.rb
>  .dirstamp
>  daxctl/config.h
>  daxctl/daxctl
> diff --git a/Documentation/cxl/Makefile.am b/Documentation/cxl/Makefile.am
> new file mode 100644
> index 0000000..db98dd7
> --- /dev/null
> +++ b/Documentation/cxl/Makefile.am
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020-2021 Intel Corporation. All rights reserved.
> +
> +if USE_ASCIIDOCTOR
> +
> +do_subst = sed -e 's,@Utility@,Cxl,g' -e's,@utility@,cxl,g'
> +CONFFILE = asciidoctor-extensions.rb
> +asciidoctor-extensions.rb: ../asciidoctor-extensions.rb.in
> +	$(AM_V_GEN) $(do_subst) < $< > $@
> +
> +else
> +
> +do_subst = sed -e 's,UTILITY,cxl,g'
> +CONFFILE = asciidoc.conf
> +asciidoc.conf: ../asciidoc.conf.in
> +	$(AM_V_GEN) $(do_subst) < $< > $@
> +
> +endif
> +
> +man1_MANS = \
> +	cxl.1 \
> +	cxl-list.1
> +
> +EXTRA_DIST = $(man1_MANS)
> +
> +CLEANFILES = $(man1_MANS)
> +
> +XML_DEPS = \
> +	../../version.m4 \
> +	../copyright.txt \
> +	Makefile \
> +	$(CONFFILE)
> +
> +RM ?= rm -f
> +
> +if USE_ASCIIDOCTOR
> +
> +%.1: %.txt $(XML_DEPS)
> +	$(AM_V_GEN)$(RM) $@+ $@ && \
> +		$(ASCIIDOC) -b manpage -d manpage -acompat-mode \
> +		-I. -rasciidoctor-extensions \
> +		-amansource=cxl -amanmanual="cxl Manual" \
> +		-andctl_version=$(VERSION) -o $@+ $< && \
> +		mv $@+ $@
> +
> +else
> +
> +%.xml: %.txt $(XML_DEPS)
> +	$(AM_V_GEN)$(RM) $@+ $@ && \
> +		$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
> +		--unsafe -acxl_version=$(VERSION) -o $@+ $< && \
> +		mv $@+ $@
> +
> +%.1: %.xml $(XML_DEPS)
> +	$(AM_V_GEN)$(RM) $@ && \
> +		$(XMLTO) -o . -m ../manpage-normal.xsl man $<
> +
> +endif
> diff --git a/cxl/Makefile.am b/cxl/Makefile.am
> new file mode 100644
> index 0000000..98606b9
> --- /dev/null
> +++ b/cxl/Makefile.am
> @@ -0,0 +1,21 @@
> +include $(top_srcdir)/Makefile.am.in
> +
> +bin_PROGRAMS = cxl
> +
> +DISTCLEANFILES = config.h
> +BUILT_SOURCES = config.h
> +config.h: $(srcdir)/Makefile.am
> +	$(AM_V_GEN) echo "/* Autogenerated by cxl/Makefile.am */" >$@
> +
> +cxl_SOURCES =\
> +		cxl.c \
> +		list.c \
> +		../util/json.c \
> +		builtin.h
> +
> +cxl_LDADD =\
> +	lib/libcxl.la \
> +	../libutil.a \
> +	$(UUID_LIBS) \
> +	$(KMOD_LIBS) \
> +	$(JSON_LIBS)
> diff --git a/cxl/lib/Makefile.am b/cxl/lib/Makefile.am
> new file mode 100644
> index 0000000..277f0cd
> --- /dev/null
> +++ b/cxl/lib/Makefile.am
> @@ -0,0 +1,32 @@
> +include $(top_srcdir)/Makefile.am.in
> +
> +%.pc: %.pc.in Makefile
> +	$(SED_PROCESS)
> +
> +pkginclude_HEADERS = ../libcxl.h
> +lib_LTLIBRARIES = libcxl.la
> +
> +libcxl_la_SOURCES =\
> +	../libcxl.h \
> +	private.h \
> +	../../util/sysfs.c \
> +	../../util/sysfs.h \
> +	../../util/log.c \
> +	../../util/log.h \
> +	libcxl.c
> +
> +libcxl_la_LIBADD =\
> +	$(UUID_LIBS) \
> +	$(KMOD_LIBS)
> +
> +EXTRA_DIST += libcxl.sym
> +
> +libcxl_la_LDFLAGS = $(AM_LDFLAGS) \
> +	-version-info $(LIBCXL_CURRENT):$(LIBCXL_REVISION):$(LIBCXL_AGE) \
> +	-Wl,--version-script=$(top_srcdir)/cxl/lib/libcxl.sym
> +libcxl_la_DEPENDENCIES = libcxl.sym
> +
> +pkgconfigdir = $(libdir)/pkgconfig
> +pkgconfig_DATA = libcxl.pc
> +EXTRA_DIST += libcxl.pc.in
> +CLEANFILES += libcxl.pc
> diff --git a/cxl/lib/libcxl.pc.in b/cxl/lib/libcxl.pc.in
> new file mode 100644
> index 0000000..949fcdc
> --- /dev/null
> +++ b/cxl/lib/libcxl.pc.in
> @@ -0,0 +1,11 @@
> +prefix=@prefix@
> +exec_prefix=@exec_prefix@
> +libdir=@libdir@
> +includedir=@includedir@
> +
> +Name: libcxl
> +Description: Manage CXL devices
> +Version: @VERSION@
> +Libs: -L${libdir} -lcxl
> +Libs.private:
> +Cflags: -I${includedir}
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> new file mode 100644
> index 0000000..0f6ecad
> --- /dev/null
> +++ b/cxl/lib/libcxl.sym
> @@ -0,0 +1,29 @@
> +LIBCXL_1 {
> +global:
> +	cxl_get_userdata;
> +	cxl_set_userdata;
> +	cxl_get_private_data;
> +	cxl_set_private_data;
> +	cxl_ref;
> +	cxl_get_log_priority;
> +	cxl_set_log_fn;
> +	cxl_unref;
> +	cxl_set_log_priority;
> +	cxl_new;
> +local:
> +        *;
> +};
> +
> +LIBCXL_2 {
> +global:
> +	cxl_memdev_get_first;
> +	cxl_memdev_get_next;
> +	cxl_memdev_get_id;
> +	cxl_memdev_get_devname;
> +	cxl_memdev_get_major;
> +	cxl_memdev_get_minor;
> +	cxl_memdev_get_ctx;
> +	cxl_memdev_get_pmem_size;
> +	cxl_memdev_get_ram_size;
> +	cxl_memdev_get_firmware_verison;
> +} LIBCXL_1;
> -- 
> 2.29.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

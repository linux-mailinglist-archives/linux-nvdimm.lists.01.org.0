Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC6C741B2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Jul 2019 00:49:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A07F3212DC5CB;
	Wed, 24 Jul 2019 15:51:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E79DC212DA5FA
 for <linux-nvdimm@lists.01.org>; Wed, 24 Jul 2019 15:51:31 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id j19so11152052otq.2
 for <linux-nvdimm@lists.01.org>; Wed, 24 Jul 2019 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LALu7+iALFcarSBCCnq5UOgqdK4iuw87GFpTFDGNOMQ=;
 b=nF/pSIxzwzEIoRCJYZiuiDEaoevfn+obuRl/j5fS15w5ojbnHfdSbul803qxKx5oey
 6t3UUNaVc8CEvHIyEem03ZnAJu7fNMcp0QUFDKnkmVvkDm6kFnA7O/i70g53p9y+OtjV
 N79C++Bd1GC7XUWY8M3GXun8P6+KWxCa6RcGSk7P6Tw+vtJzfmf6m40rTxJ0d8uh8cyw
 QZkISf5KdkBijYLieO5LHl7rD/Kt8ACGTStzIaA8hIrycSGAs4ez8qfO8n6UnMYb73+p
 1ZnvhVl4IoZUOfcKT3hOh0bR8zxvMN9XS1FfiJ12efXAaQBbK3S2GFmh6LnNC/F74YxF
 SN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LALu7+iALFcarSBCCnq5UOgqdK4iuw87GFpTFDGNOMQ=;
 b=pOvGgo8Y2t+Rn/GPem7uTh7IfocLMzAqCJ57XPilq8iZ+E2zzTDN2hCAIWqIXhxrJn
 hKLRjbNmsr931qlvs+3wMXao8oMGvtURaSK3h/dYepx/es3r4TXARzMpxS9h9M2fB2T/
 F31KN8n9y9HWIXuRdN2stqv2CPq+f/yruXSoN8CMCoi0Bro/4P36uyGJeMtZO3pWsD3i
 grvgnekJYyNVs/NiYS/oJykY//eD/Mrzk2btj5KwJI5LRpfyWVZJeldBJ1A8a2I0iVNX
 tV0mQgMDLM8oS+R0jYRpixRXwMAoZocVr9dk65jPPKrclaDMMNW7WghnMA5D+s8gUAVJ
 0XLQ==
X-Gm-Message-State: APjAAAXYmR7woh773nBn+RdgY9eHQHGCSUJTBLmorzyISZnh33wP8P54
 wXGEoP/ADcNU0xsm9aRSwdB+V7flkBxetjZdTouwCA==
X-Google-Smtp-Source: APXvYqwsKuHD//N7oUHsMRaVWtjgOxg0vsGA92WmBhe2qpOLsAgiZsLchAVeOr+oQknV3VuH/dFpbnhGozMiwCFAArQ=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr57149284otn.71.1564008544171; 
 Wed, 24 Jul 2019 15:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
 <20190717225400.9494-8-vishal.l.verma@intel.com>
In-Reply-To: <20190717225400.9494-8-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 24 Jul 2019 15:48:52 -0700
Message-ID: <CAPcyv4jcOZUyQQUZWuNp5+K+ciifg4hHSRhRk4PP1-MtKMebhQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v6 07/13] daxctl: add a new reconfigure-device
 command
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 17, 2019 at 3:54 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add a new command 'daxctl-reconfigure-device'. This is used to switch
> the mode of a dax device between regular 'device_dax' and
> 'system-memory'. The command also uses the memory hotplug sysfs
> interfaces to online the newly available memory when converting to
> 'system-ram', and to attempt to offline the memory when converting back
> to a DAX device.
>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/Makefile.am |   2 +
>  daxctl/builtin.h   |   1 +
>  daxctl/daxctl.c    |   1 +
>  daxctl/device.c    | 348 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 352 insertions(+)
>  create mode 100644 daxctl/device.c
>
> diff --git a/daxctl/Makefile.am b/daxctl/Makefile.am
> index 94f73f9..66dcc7f 100644
> --- a/daxctl/Makefile.am
> +++ b/daxctl/Makefile.am
> @@ -15,10 +15,12 @@ daxctl_SOURCES =\
>                 daxctl.c \
>                 list.c \
>                 migrate.c \
> +               device.c \
>                 ../util/json.c
>
>  daxctl_LDADD =\
>         lib/libdaxctl.la \
>         ../libutil.a \
>         $(UUID_LIBS) \
> +       $(KMOD_LIBS) \
>         $(JSON_LIBS)
> diff --git a/daxctl/builtin.h b/daxctl/builtin.h
> index 00ef5e9..756ba2a 100644
> --- a/daxctl/builtin.h
> +++ b/daxctl/builtin.h
> @@ -6,4 +6,5 @@
>  struct daxctl_ctx;
>  int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx);
>  int cmd_migrate(int argc, const char **argv, struct daxctl_ctx *ctx);
> +int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx);
>  #endif /* _DAXCTL_BUILTIN_H_ */
> diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
> index 2e41747..e1ba7b8 100644
> --- a/daxctl/daxctl.c
> +++ b/daxctl/daxctl.c
> @@ -71,6 +71,7 @@ static struct cmd_struct commands[] = {
>         { "list", .d_fn = cmd_list },
>         { "help", .d_fn = cmd_help },
>         { "migrate-device-model", .d_fn = cmd_migrate },
> +       { "reconfigure-device", .d_fn = cmd_reconfig_device },
>  };
>
>  int main(int argc, const char **argv)
> diff --git a/daxctl/device.c b/daxctl/device.c
> new file mode 100644
> index 0000000..a1fb698
> --- /dev/null
> +++ b/daxctl/device.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2019 Intel Corporation. All rights reserved. */
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <syslog.h>
> +#include <unistd.h>
> +#include <limits.h>
> +#include <util/json.h>
> +#include <util/filter.h>
> +#include <json-c/json.h>
> +#include <daxctl/libdaxctl.h>
> +#include <util/parse-options.h>
> +#include <ccan/array_size/array_size.h>
> +
> +static struct {
> +       const char *dev;
> +       const char *mode;
> +       int region_id;
> +       bool no_online;
> +       bool do_offline;
> +       bool human;
> +       bool verbose;
> +} param = {
> +       .region_id = -1,
> +};
> +
> +static enum daxctl_dev_mode reconfig_mode = DAXCTL_DEV_MODE_UNKNOWN;
> +static unsigned long flags;
> +
> +enum device_action {
> +       ACTION_RECONFIG,
> +};
> +
> +#define BASE_OPTIONS() \
> +OPT_INTEGER('r', "region", &param.region_id, "restrict to the given region"), \
> +OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats"), \
> +OPT_BOOLEAN('v', "verbose", &param.verbose, "emit more debug messages")
> +
> +#define RECONFIG_OPTIONS() \
> +OPT_STRING('m', "mode", &param.mode, "mode", "mode to switch the device to"), \
> +OPT_BOOLEAN('N', "no-online", &param.no_online, \
> +       "don't auto-online memory sections"), \
> +OPT_BOOLEAN('O', "attempt-offline", &param.do_offline, \
> +               "attempt to offline memory sections")
> +
> +static const struct option reconfig_options[] = {
> +       BASE_OPTIONS(),
> +       RECONFIG_OPTIONS(),
> +       OPT_END(),
> +};
> +
> +static const char *parse_device_options(int argc, const char **argv,
> +               enum device_action action, const struct option *options,
> +               const char *usage, struct daxctl_ctx *ctx)
> +{
> +       const char * const u[] = {
> +               usage,
> +               NULL
> +       };
> +       int i, rc = 0;
> +
> +       argc = parse_options(argc, argv, options, u, 0);
> +
> +       /* Handle action-agnostic non-option arguments */
> +       if (argc == 0) {
> +               char *action_string;
> +
> +               switch (action) {
> +               case ACTION_RECONFIG:
> +                       action_string = "reconfigure";
> +                       break;
> +               default:
> +                       action_string = "<>";
> +                       break;
> +               }
> +               fprintf(stderr, "specify a device to %s, or \"all\"\n",
> +                       action_string);
> +               rc = -EINVAL;
> +       }
> +       for (i = 1; i < argc; i++) {
> +               fprintf(stderr, "unknown extra parameter \"%s\"\n", argv[i]);
> +               rc = -EINVAL;
> +       }
> +
> +       if (rc) {
> +               usage_with_options(u, options);
> +               return NULL;
> +       }
> +
> +       /* Handle action-agnostic options */
> +       if (param.verbose)
> +               daxctl_set_log_priority(ctx, LOG_DEBUG);
> +       if (param.human)
> +               flags |= UTIL_JSON_HUMAN;
> +
> +       /* Handle action-specific options */
> +       switch (action) {
> +       case ACTION_RECONFIG:
> +               if (!param.mode) {
> +                       fprintf(stderr, "error: a 'mode' option is required\n");
> +                       usage_with_options(u, reconfig_options);
> +                       rc = -EINVAL;
> +               }
> +               if (strcmp(param.mode, "system-ram") == 0) {
> +                       reconfig_mode = DAXCTL_DEV_MODE_RAM;
> +                       if (param.do_offline) {
> +                               fprintf(stderr,
> +                                       "can't --attempt-offline for system-ram mode\n");

I'm not sure I grok the --attempt-offline option. That seems like it
belongs to its own command, and is required to succeed before daxctl
disable-device. Or is this like a "--force" to disable and cleanup
system-ram mode before moving to devdax mode. If it's the latter I'd
prefer that was a --force option. Otherwise, the error message "can't
--attempt-offline for system-ram mode\n" is confusing because
offlining only makes sense for system-ram mode.

> +                               rc = -EINVAL;
> +                       }
> +               } else if (strcmp(param.mode, "devdax") == 0) {
> +                       reconfig_mode = DAXCTL_DEV_MODE_DEVDAX;
> +                       if (param.no_online) {
> +                               fprintf(stderr,
> +                                       "can't --no-online for devdax mode\n");

How about "--no-online option incompatible with --mode=devdax"?

> +                               rc =  -EINVAL;
> +                       }
> +               }
> +               break;
> +       }
> +       if (rc) {
> +               usage_with_options(u, options);
> +               return NULL;
> +       }
> +
> +       return argv[0];
> +}
> +
> +static int disable_devdax_device(struct daxctl_dev *dev)
> +{
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       enum daxctl_dev_mode mode;
> +       int rc;
> +
> +       mode = daxctl_dev_get_mode(dev);
> +       if (mode < 0) {
> +               fprintf(stderr, "%s: unable to determine current mode: %s\n",
> +                       devname, strerror(-mode));
> +               return mode;
> +       }
> +       if (mode == DAXCTL_DEV_MODE_RAM) {
> +               fprintf(stderr, "%s is in system-ram mode, nothing to do\n",
> +                       devname);

"Nothing to do" implies "it is already disabled", this is just "not
supported" until integrating with v5.3, right?

> +               return 1;
> +       }
> +       rc = daxctl_dev_disable(dev);
> +       if (rc) {
> +               fprintf(stderr, "%s: disable failed: %s\n",
> +                       daxctl_dev_get_devname(dev), strerror(-rc));
> +               return rc;
> +       }
> +       return 0;
> +}
> +
> +static int reconfig_mode_system_ram(struct daxctl_dev *dev)
> +{
> +       struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       int rc, skip_enable = 0;
> +
> +       if (daxctl_dev_is_enabled(dev)) {
> +               rc = disable_devdax_device(dev);
> +               if (rc < 0)
> +                       return rc;
> +               if (rc > 0)
> +                       skip_enable = 1;
> +       }
> +
> +       if (!skip_enable) {
> +               rc = daxctl_dev_enable_ram(dev);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       if (param.no_online)
> +               return 0;
> +
> +       rc = daxctl_memory_set_online(mem);
> +       if (rc < 0) {
> +               fprintf(stderr, "%s: unable to online memory: %s\n",

s/unable/failed/

I didn't comment earlier, but if it's not too late I think
'daxctl_memory_{on,off}line()' is sufficient, no need for 'set_'.

> +                       devname, strerror(-rc));
> +               return rc;
> +       }
> +       if (param.verbose)
> +               fprintf(stderr, "%s: onlined %d memory sections\n",
> +                       devname, rc);
> +
> +       return 0;
> +}
> +
> +static int disable_system_ram_device(struct daxctl_dev *dev)
> +{
> +       struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       enum daxctl_dev_mode mode;
> +       int rc;
> +
> +       mode = daxctl_dev_get_mode(dev);
> +       if (mode < 0) {
> +               fprintf(stderr, "%s: unable to determine current mode: %s\n",
> +                       devname, strerror(-mode));

When would this happen in practice? I can only think it would happen
when using the old device model in which case we could fall through to
the "already in devdax mode" case.

> +               return mode;
> +       }
> +       if (mode == DAXCTL_DEV_MODE_DEVDAX) {
> +               fprintf(stderr, "%s: already in devdax mode, nothing to do\n",
> +                       devname);
> +               return 1;
> +       }
> +
> +       if (param.do_offline) {
> +               rc = daxctl_memory_set_offline(mem);
> +               if (rc < 0) {
> +                       fprintf(stderr, "%s: unable to offline memory: %s\n",

s/unable/failed/

...and same comment about dropping '_set'. Is there an api to retrieve
the number of memory blocks / sections behind daxctl_memory instance?
Then you could also check for the number of sections offlined < total
sections case. The most likely case is that a single section is
holding up the offline process and someone might want to interrogate
which one that is relative to the device instance.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

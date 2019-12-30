Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1A212CD27
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Dec 2019 07:03:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C2E4410097F37;
	Sun, 29 Dec 2019 22:07:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C6CFF1011367C
	for <linux-nvdimm@lists.01.org>; Sun, 29 Dec 2019 22:06:59 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id w21so37218711otj.7
        for <linux-nvdimm@lists.01.org>; Sun, 29 Dec 2019 22:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxfcCf4y4b6yU7YSRRvn0XL3Q5Hgt+8ueeZ6moAH764=;
        b=QjucmdM+xlWZMOjLcX+VlJMsAgPSTddJeq8dBmBFYqQt8PY7XIHSPirfhx7TEPY9AJ
         r5x3GHkvDktXa314E9P9Q5Wj5X1UZjHfKhZoNtX4ICn+6J4IbJzB5+WyJhj7A12K4sBX
         /biN6O0aL7umfBGmbvIUUHFrPfZeZfkxV0ql5StDICLuwJy/tEfeBg6HY3fXZzadBV7w
         UzsC7/uAHi8T2ZvelvGNsIRFd6PuF/RnFRuyfpkPdzMM3epS8T86DYMWJu7WIBd3nUsl
         HAzSz9SLnCS6lV1+PronP168VYzg1/L/UZBsto1OPPLF2t7lVNPK40/kkUaxEFg9B9bl
         u0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxfcCf4y4b6yU7YSRRvn0XL3Q5Hgt+8ueeZ6moAH764=;
        b=O5DJdFwsqsVQfLkJqupB+EE73sjO8c82MkpGEz6q2iJcMwr2PmAn5fLeRbErwzjAxB
         D7HTyMhNt7yGhnM80lpogxME6Nen6E0kVtPK6mK3nsgLRTbbompzJgoZRapHBrU2A6XC
         19weSNeC8O7yPkDSUoTg8c3v0Wpy2l8MOzcLWhn6wqWp+PNsk6Jx2jquusniv1Kru4hT
         XCKNcFwfvXnjrdjy6gcTP5hYQts2atbU3Ek3+mUAf6raG8hF5xhlGufiewftUtPIE2KI
         ftzCNsBQt8Xz8LkTo0/A2oXyAk2L8IxqKuTfwdc/4dHbQLQQP8R3ei9W7wg12uzpjQcz
         60xg==
X-Gm-Message-State: APjAAAUNNZTxGEgb/tjCSgcU75OSkPhRTgzn3+mzFqsox8ACQtqozYHz
	stao4erfuqQwCh2l5tCWVYdkYgaG/MwvjxPpRxn/xw==
X-Google-Smtp-Source: APXvYqzo7FKsIEdQLekukCaXebrzR+3ZukGEGIYSBzdrh1fShvunrJl7nE0ygYg8hgh+FBgJ+idfMkb3eEOq0GN9wB4=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr17969653oto.71.1577685819234;
 Sun, 29 Dec 2019 22:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20191229075013.22620-1-redhairer.li@intel.com>
In-Reply-To: <20191229075013.22620-1-redhairer.li@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Dec 2019 22:03:28 -0800
Message-ID: <CAPcyv4hc5nV6EPQXD=UzgRGxHq8-U+BXdw5EXfQz8bg_NSDPpg@mail.gmail.com>
Subject: Re: [PATCH 1/1] daxctl: Change region input type from INTEGER to STRING.
To: redhairer <redhairer.li@intel.com>
Message-ID-Hash: L4CJ5TEY4B4M3ZM56IEUNJFZCGJL3MJL
X-Message-ID-Hash: L4CJ5TEY4B4M3ZM56IEUNJFZCGJL3MJL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L4CJ5TEY4B4M3ZM56IEUNJFZCGJL3MJL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Dec 28, 2019 at 11:50 PM redhairer <redhairer.li@intel.com> wrote:
>
> Allow daxctl to accept both <region-id>, and region name as region parameter.
> For example:
>
>     daxctl list -r region5
>     daxctl list -r 5
>
> Link: https://github.com/pmem/ndctl/issues/109
> Signed-off-by: Redhairer Li <redhairer.li@intel.com>

Looks good, applied.

>  daxctl/device.c | 11 ++++-------
>  daxctl/list.c   | 14 ++++++--------
>  util/filter.c   | 16 ++++++++++++++++
>  util/filter.h   |  2 ++
>  4 files changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/daxctl/device.c b/daxctl/device.c
> index 72e506e..705f1f8 100644
> --- a/daxctl/device.c
> +++ b/daxctl/device.c
> @@ -19,15 +19,13 @@
>  static struct {
>         const char *dev;
>         const char *mode;
> -       int region_id;
> +       const char *region;
>         bool no_online;
>         bool no_movable;
>         bool force;
>         bool human;
>         bool verbose;
> -} param = {
> -       .region_id = -1,
> -};
> +} param;
>
>  enum dev_mode {
>         DAXCTL_DEV_MODE_UNKNOWN,
> @@ -51,7 +49,7 @@ enum device_action {
>  };
>
>  #define BASE_OPTIONS() \
> -OPT_INTEGER('r', "region", &param.region_id, "restrict to the given region"), \
> +OPT_STRING('r', "region", &param.region, "region-id", "filter by region"), \
>  OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats"), \
>  OPT_BOOLEAN('v', "verbose", &param.verbose, "emit more debug messages")
>
> @@ -484,8 +482,7 @@ static int do_xaction_device(const char *device, enum device_action action,
>         *processed = 0;
>
>         daxctl_region_foreach(ctx, region) {
> -               if (param.region_id >= 0 && param.region_id
> -                               != daxctl_region_get_id(region))
> +               if (!util_daxctl_region_filter(region, param.region))
>                         continue;
>
>                 daxctl_dev_foreach(region, dev) {
> diff --git a/daxctl/list.c b/daxctl/list.c
> index e56300d..6c6251b 100644
> --- a/daxctl/list.c
> +++ b/daxctl/list.c
> @@ -44,10 +44,8 @@ static unsigned long listopts_to_flags(void)
>
>  static struct {
>         const char *dev;
> -       int region_id;
> -} param = {
> -       .region_id = -1,
> -};
> +       const char *region;
> +} param;
>
>  static int did_fail;
>
> @@ -66,7 +64,8 @@ static int num_list_flags(void)
>  int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx)
>  {
>         const struct option options[] = {
> -               OPT_INTEGER('r', "region", &param.region_id, "filter by region"),
> +               OPT_STRING('r', "region", &param.region, "region-id",
> +                               "filter by region"),
>                 OPT_STRING('d', "dev", &param.dev, "dev-id",
>                                 "filter by dax device instance name"),
>                 OPT_BOOLEAN('D', "devices", &list.devs, "include dax device info"),
> @@ -94,7 +93,7 @@ int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx)
>                 usage_with_options(u, options);
>
>         if (num_list_flags() == 0) {
> -               list.regions = param.region_id >= 0;
> +               list.regions = !!param.region;
>                 list.devs = !!param.dev;
>         }
>
> @@ -106,8 +105,7 @@ int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx)
>         daxctl_region_foreach(ctx, region) {
>                 struct json_object *jregion = NULL;
>
> -               if (param.region_id >= 0 && param.region_id
> -                               != daxctl_region_get_id(region))
> +               if (!util_daxctl_region_filter(region, param.region))
>                         continue;
>
>                 if (list.regions) {
> diff --git a/util/filter.c b/util/filter.c
> index 1734bce..877d6c7 100644
> --- a/util/filter.c
> +++ b/util/filter.c
> @@ -335,6 +335,22 @@ struct daxctl_dev *util_daxctl_dev_filter(struct daxctl_dev *dev,
>         return NULL;
>  }
>
> +struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
> +               const char *ident)
> +{
> +       int region_id;
> +
> +       if (!ident || strcmp(ident, "all") == 0)
> +               return region;
> +
> +       if ((sscanf(ident, "%d", &region_id) == 1
> +       || sscanf(ident, "region%d", &region_id) == 1)
> +                       && daxctl_region_get_id(region) == region_id)
> +               return region;
> +
> +       return NULL;
> +}
> +
>  static enum ndctl_namespace_mode mode_to_type(const char *mode)
>  {
>         if (!mode)
> diff --git a/util/filter.h b/util/filter.h
> index c2cdddf..0c12b94 100644
> --- a/util/filter.h
> +++ b/util/filter.h
> @@ -37,6 +37,8 @@ struct ndctl_region *util_region_filter_by_namespace(struct ndctl_region *region
>                 const char *ident);
>  struct daxctl_dev *util_daxctl_dev_filter(struct daxctl_dev *dev,
>                 const char *ident);
> +struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
> +               const char *ident);
>
>  struct json_object;
>
> --
> 2.20.1.windows.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

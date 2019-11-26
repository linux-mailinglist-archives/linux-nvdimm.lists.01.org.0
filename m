Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645B710A469
	for <lists+linux-nvdimm@lfdr.de>; Tue, 26 Nov 2019 20:21:34 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67C0F1011330F;
	Tue, 26 Nov 2019 11:24:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 474B110113301
	for <linux-nvdimm@lists.01.org>; Tue, 26 Nov 2019 11:24:53 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id a14so17729763oid.5
        for <linux-nvdimm@lists.01.org>; Tue, 26 Nov 2019 11:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ar9quJ1XFVehdYmDc78e8n1YJ0rc11Rbvty0jNHXp7Y=;
        b=PFSp+wRxo+gZ8OeXprjZQoBOshlsPmd4ogOr3D+byRs4jvEMVPetTX6bo3JQdPkkuz
         hcuPo8PEb+M2+UcWpYalZ+QLS00ItEf0U4z4odML9A2zOOvVq3i4CRsiwexgzlLFjElY
         1WRHjaSNwl+jObuTbqBAzT2BgzrDuEmn6qKHeJCd+WLKF66+lCMNKTX84DyW1l7lOrjL
         c3LojdaQft1DPwyvIC7I07u0ETJ8RL2rorTjKuhT6UFBkaj6WBBnX/uQhqI3PYFexNfK
         mqAqQjw9iKsPiZVXknDHLYelfLL73CzP2IW3+0MHa5BF24/fCjRIhUF9EMRpOIt/aqOH
         WrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ar9quJ1XFVehdYmDc78e8n1YJ0rc11Rbvty0jNHXp7Y=;
        b=e0sglfj0aTONQyVsZRbzJEnmVBEgGuwEUZRRBRyca0W5KBrlqTKvuyfBUcECAkKHGB
         gAv5EQGZx5RWBrNrZUS8/4tryoFEuiwTwtlQ2LDP8uCW07fND/2/ZotRL6Y7DQ3AvGw7
         9WKTY9mLtT1AWPYjB4j+IDYRo9vnqTV1NkNhN/3LIc1uNhIv03E7TBDe03Op2xqE7PAA
         PX+CtdqxFSaX7UR1Cc3Z45Bn25LXe9eI16qWjDkiw0YzJ8RvO5lWCEiEV1hdJyOWp7IA
         q5Wymp+/Y2gC9WvBzub47VzGNU6+8pqd/urimzZNKODGBSsRWmMi05qU7oMcX22f5eTU
         Plrw==
X-Gm-Message-State: APjAAAUA6WxChA6aUX4m+JEZWx0k3pS6xWBZXKiq3c3/C0AbLLAK0Zsn
	Ack/o78kBweDDqm+clWEAXvuHuodyGYHmvlF8gLRRw==
X-Google-Smtp-Source: APXvYqwifL8CCrzvcQn2Ldw23d/pjpBzHbMSD6fgLCSCA1rMkv3pUfA4Xe8EPKG11SMpwG5xSynV6lrrXVf940ST3OQ=
X-Received: by 2002:aca:3c1:: with SMTP id 184mr522832oid.70.1574796089358;
 Tue, 26 Nov 2019 11:21:29 -0800 (PST)
MIME-Version: 1.0
References: <2369E669066F8E42A79A3DF0E43B9E643AC95A81@pgsmsx114.gar.corp.intel.com>
In-Reply-To: <2369E669066F8E42A79A3DF0E43B9E643AC95A81@pgsmsx114.gar.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 26 Nov 2019 11:21:18 -0800
Message-ID: <CAPcyv4gvih=YwGcuDs8M168kAq3Skp8khq6QDRq8ju-S_sL_Nw@mail.gmail.com>
Subject: Re: daxctl: Change region input type from INTEGER to STRING.
To: "Li, Redhairer" <redhairer.li@intel.com>
Message-ID-Hash: X67ZWA55WNV46EDQR6WYS2KCFUA7K4JQ
X-Message-ID-Hash: X67ZWA55WNV46EDQR6WYS2KCFUA7K4JQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X67ZWA55WNV46EDQR6WYS2KCFUA7K4JQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Redhairer,

Thanks for submitting this first patch! Some feedback for submitting
patches by email. The first is to make sure you are sending the patch
in plain text, this one was in html format. The patch also needs to be
included in the mail directly so the review can be done inline. This
is what tools like "git send-email" or "stg mail" will do for you.
Some more comments below where I pasted the patch manually:

On Thu, Nov 21, 2019 at 1:18 AM Li, Redhairer <redhairer.li@intel.com> wrote:
>
>
>
> SHA-1: 66f34cdc26c58143fb8f11813dae98257b19ddc5
>
>
>
> * daxctl: Change region input type from INTEGER to STRING.
>
>
>
> daxctl use STRING to be region input type. It makes daxctl can accept both <region-id> and region name as region parameter
>
> eg.
>
> daxctl list -r region5
>
> daxctl list -r 5
>
>
>
> Link: https://github.com/pmem/ndctl/issues/109
>
> Signed-off-by: Redhairer Li <redhairer.li@intel.com>
>
>

My mail reader has line wrapped this quotation below, "git send-email"
and "stg mail" will help with that problem:

From 66f34cdc26c58143fb8f11813dae98257b19ddc5 Mon Sep 17 00:00:00
> 2001
> From: redhairer <redhairer.li@intel.com>
> Date: Thu, 21 Nov 2019 17:10:21 +0800
> Subject: [PATCH] daxctl: Change region input type from INTEGER to
> STRING.
>
> daxctl use STRING to be region input type. It makes daxctl can accept
> both <region-id> and region name as region parameter

This line went past 80 columns. You can set your text editor to wrap
at 80 lines.

> eg.
> daxctl list -r region5
> daxctl list -r 5
>
> Link: https://github.com/pmem/ndctl/issues/109
> Signed-off-by: Redhairer Li <redhairer.li@intel.com>
> ---
>  daxctl/device.c                | 11 ++++-------
>  daxctl/lib/libdaxctl-private.h |  1 +
>  daxctl/lib/libdaxctl.c         |  6 ++++++
>  daxctl/lib/libdaxctl.sym       |  1 +
>  daxctl/libdaxctl.h             |  1 +
>  daxctl/list.c                  | 14 ++++++--------
>  util/filter.c                  | 20 ++++++++++++++++++++
>  util/filter.h                  |  2 ++
>  util/sysfs.h                   |  6 ++++++
>  9 files changed, 47 insertions(+), 15 deletions(-)
>
> diff --git a/daxctl/device.c b/daxctl/device.c
> index 72e506e..d9db2f9 100644
> --- a/daxctl/device.c
> +++ b/daxctl/device.c
> @@ -19,15 +19,13 @@
>  static struct {
>   const char *dev;
>   const char *mode;
> - int region_id;
> + const char *region;
>   bool no_online;
>   bool no_movable;
>   bool force;
>   bool human;
>   bool verbose;
> -} param = {
> - .region_id = -1,
> -};
> +} param;
>
>  enum dev_mode {
>   DAXCTL_DEV_MODE_UNKNOWN,
> @@ -51,7 +49,7 @@ enum device_action {
>  };
>
>  #define BASE_OPTIONS() \
> -OPT_INTEGER('r', "region", &param.region_id, "restrict to the given
> region"), \
> +OPT_STRING('r', "region", &param.region, "region-id", "filter by
> region"), \
>  OPT_BOOLEAN('u', "human", &param.human, "use human friendly number
> formats"), \
>  OPT_BOOLEAN('v', "verbose", &param.verbose, "emit more debug
> messages")
>
> @@ -484,8 +482,7 @@ static int do_xaction_device(const char *device,
> enum device_action action,
>   *processed = 0;
>
>   daxctl_region_foreach(ctx, region) {
> - if (param.region_id >= 0 && param.region_id
> - != daxctl_region_get_id(region))
> + if (!util_daxctl_region_filter(region, device))
>   continue;
>
>   daxctl_dev_foreach(region, dev) {
> diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-
> private.h
> index 9f9c70d..169a8b8 100644
> --- a/daxctl/lib/libdaxctl-private.h
> +++ b/daxctl/lib/libdaxctl-private.h
> @@ -80,6 +80,7 @@ struct daxctl_region {
>   uuid_t uuid;
>   int refcount;
>   char *devname;
> + char *regionname;

So I don't think that "regionname" should be a property of 'struct
daxctl_region' because there is no kernel device with that name for
daxctl regions. I think this region name should only exist as a
special case for "daxctl list".

>   size_t buf_len;
>   void *region_buf;
>   int devices_init;
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index ee4a069..59697cd 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -287,6 +287,7 @@ static struct daxctl_region *add_dax_region(void
> *parent, int id,
>   region->refcount = 1;
>   list_head_init(&region->devices);
>   region->devname = strdup(devpath_to_devname(base));
> + region->regionname = strdup(devpath_to_regionname(base));
>
>   sprintf(path, "%s/%s/size", base, attrs);
>   if (sysfs_read_attr(ctx, path, buf) == 0)
> @@ -553,6 +554,11 @@ DAXCTL_EXPORT const char
> *daxctl_region_get_devname(struct daxctl_region *region
>   return region->devname;
>  }
>
> +DAXCTL_EXPORT const char *daxctl_region_get_regionname(struct
> daxctl_region *region)
> +{
> + return region->regionname;
> +}
> +
>  DAXCTL_EXPORT const char *daxctl_region_get_path(struct
> daxctl_region *region)
>  {

API users should be aware that the region identifier is just a number,
so I don't think we need these additions.

>   return region->region_path;
> diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
> index 87d0236..13e5aec 100644
> --- a/daxctl/lib/libdaxctl.sym
> +++ b/daxctl/lib/libdaxctl.sym
> @@ -35,6 +35,7 @@ LIBDAXCTL_3 {
>  global:
>   daxctl_region_get_available_size;
>   daxctl_region_get_devname;
> + daxctl_region_get_regionname;
>   daxctl_region_get_dev_seed;
>  } LIBDAXCTL_2;
>
> diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
> index 6c545e1..1592c2f 100644
> --- a/daxctl/libdaxctl.h
> +++ b/daxctl/libdaxctl.h
> @@ -54,6 +54,7 @@ unsigned long long
> daxctl_region_get_available_size(
>  unsigned long long daxctl_region_get_size(struct daxctl_region
> *region);
>  unsigned long daxctl_region_get_align(struct daxctl_region *region);
>  const char *daxctl_region_get_devname(struct daxctl_region *region);
> +const char *daxctl_region_get_regionname(struct daxctl_region
> *region);
>  const char *daxctl_region_get_path(struct daxctl_region *region);
>
>  struct daxctl_dev *daxctl_region_get_dev_seed(struct daxctl_region
> *region);
> diff --git a/daxctl/list.c b/daxctl/list.c
> index e56300d..6c6251b 100644
> --- a/daxctl/list.c
> +++ b/daxctl/list.c
> @@ -44,10 +44,8 @@ static unsigned long listopts_to_flags(void)
>
>  static struct {
>   const char *dev;
> - int region_id;
> -} param = {
> - .region_id = -1,
> -};
> + const char *region;
> +} param;
>
>  static int did_fail;
>
> @@ -66,7 +64,8 @@ static int num_list_flags(void)
>  int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx)
>  {
>   const struct option options[] = {
> - OPT_INTEGER('r', "region", &param.region_id, "filter by
> region"),
> + OPT_STRING('r', "region", &param.region, "region-id",
> + "filter by region"),
>   OPT_STRING('d', "dev", &param.dev, "dev-id",
>   "filter by dax device instance name"),
>   OPT_BOOLEAN('D', "devices", &list.devs, "include dax
> device info"),
> @@ -94,7 +93,7 @@ int cmd_list(int argc, const char **argv, struct
> daxctl_ctx *ctx)
>   usage_with_options(u, options);
>
>   if (num_list_flags() == 0) {
> - list.regions = param.region_id >= 0;
> + list.regions = !!param.region;
>   list.devs = !!param.dev;
>   }
>
> @@ -106,8 +105,7 @@ int cmd_list(int argc, const char **argv, struct
> daxctl_ctx *ctx)
>   daxctl_region_foreach(ctx, region) {
>   struct json_object *jregion = NULL;
>
> - if (param.region_id >= 0 && param.region_id
> - != daxctl_region_get_id(region))
> + if (!util_daxctl_region_filter(region, param.region))
>   continue;
>
>   if (list.regions) {
> diff --git a/util/filter.c b/util/filter.c
> index 1734bce..da647a8 100644
> --- a/util/filter.c
> +++ b/util/filter.c
> @@ -335,6 +335,26 @@ struct daxctl_dev *util_daxctl_dev_filter(struct
> daxctl_dev *dev,
>   return NULL;
>  }
>
> +struct daxctl_region *util_daxctl_region_filter(struct daxctl_region
> *region,
> + const char *ident)
> +{
> + int region_id;
> + const char *region_name;
> +
> + if (!ident || strcmp(ident, "all") == 0)
> + return region;
> +
> + if (sscanf(ident, "%d", &region_id) == 1
> + && daxctl_region_get_id(region) == region_id)
> + return region;

Let's just add a "sscanf(ident, "region%d", &region_id)" in the case
the above ident does not match.

> +
> + region_name = daxctl_region_get_regionname(region);
> + if (strcmp(region_name, ident)==0)
> + return region;

...with the above new sscanf then daxctl_region_get_regionname() is not needed.

> +
> + return NULL;
> +}
> +
>  static enum ndctl_namespace_mode mode_to_type(const char *mode)
>  {
>   if (!mode)
> diff --git a/util/filter.h b/util/filter.h
> index c2cdddf..0c12b94 100644
> --- a/util/filter.h
> +++ b/util/filter.h
> @@ -37,6 +37,8 @@ struct ndctl_region
> *util_region_filter_by_namespace(struct ndctl_region *region
>   const char *ident);
>  struct daxctl_dev *util_daxctl_dev_filter(struct daxctl_dev *dev,
>   const char *ident);
> +struct daxctl_region *util_daxctl_region_filter(struct daxctl_region
> *region,
> + const char *ident);
>
>  struct json_object;
>
> diff --git a/util/sysfs.h b/util/sysfs.h
> index fb169c6..84c0965 100644
> --- a/util/sysfs.h
> +++ b/util/sysfs.h
> @@ -37,4 +37,10 @@ static inline const char *devpath_to_devname(const
> char *devpath)
>  {
>   return strrchr(devpath, '/') + 1;
>  }
> +
> +static inline const char *devpath_to_regionname(const char *devpath)
> +{
> + char* tmp_devpath = strdup(devpath);
> + return strtok(strstr(tmp_devpath, "region"), "/");

Another reason to not create "daxctl_region_get_regionname" is that
not all daxctl devices will have "region" in the devpath.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

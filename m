Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75710F51A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 03:43:38 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 239F910113637;
	Mon,  2 Dec 2019 18:46:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 439BC101134E3
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 18:46:55 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 18:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,271,1571727600";
   d="scan'208,223";a="361031331"
Received: from pgsmsx111.gar.corp.intel.com ([10.108.55.200])
  by orsmga004.jf.intel.com with ESMTP; 02 Dec 2019 18:43:31 -0800
Received: from pgsmsx114.gar.corp.intel.com ([169.254.4.197]) by
 PGSMSX111.gar.corp.intel.com ([10.108.55.200]) with mapi id 14.03.0439.000;
 Tue, 3 Dec 2019 10:38:49 +0800
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: daxctl: Change region input type from INTEGER to STRING.
Thread-Topic: daxctl: Change region input type from INTEGER to STRING.
Thread-Index: AdWgS+HioQKQhQkFRMaZk8EtSuhX4gD/71wAAFsuySAA8o+awA==
Date: Tue, 3 Dec 2019 02:38:49 +0000
Message-ID: <2369E669066F8E42A79A3DF0E43B9E643AC9DC32@pgsmsx114.gar.corp.intel.com>
References: <2369E669066F8E42A79A3DF0E43B9E643AC95A81@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4gvih=YwGcuDs8M168kAq3Skp8khq6QDRq8ju-S_sL_Nw@mail.gmail.com>
 <2369E669066F8E42A79A3DF0E43B9E643AC9B3DA@pgsmsx114.gar.corp.intel.com>
In-Reply-To: <2369E669066F8E42A79A3DF0E43B9E643AC9B3DA@pgsmsx114.gar.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjEyMjhiMzMtNWYyYy00OWY0LWIwZDAtMGQwNjczMWRlYmI4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNmV3Y0lyWFwvbXRkd0NLdEtJVHVTd3N3TFJqZFAwTHdRZ212cmY1QitqTFJFd3RpYmw2bVVIbkh0RjVaVXQxQU4ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
MIME-Version: 1.0
Message-ID-Hash: VSQBNW2KNNGTL363DZP2HGVCWWG7ZS77
X-Message-ID-Hash: VSQBNW2KNNGTL363DZP2HGVCWWG7ZS77
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: "'linux-nvdimm@lists.01.org'" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VSQBNW2KNNGTL363DZP2HGVCWWG7ZS77/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have squashed my previous two change.
Please refer it.

-----Original Message-----
From: Li, Redhairer 
Sent: Thursday, November 28, 2019 2:56 PM
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org
Subject: RE: daxctl: Change region input type from INTEGER to STRING.


Hi Dan,

I have modified it by your feedback.

SHA-1: 00abd19ad64a4ac2f352cbeb1d2fabcb3ffa10ea

* * daxctl: Change region input type from INTEGER to STRING.

daxctl use STRING to be region input type.
It makes daxctl can accept both <region-id> and region name as region parameter eg.
daxctl list -r region5
daxctl list -r 5

Link: https://github.com/pmem/ndctl/issues/109
Signed-off-by: Redhairer Li <redhairer.li@intel.com>

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com>
Sent: Wednesday, November 27, 2019 3:21 AM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm@lists.01.org
Subject: Re: daxctl: Change region input type from INTEGER to STRING.

Hi Redhairer,

Thanks for submitting this first patch! Some feedback for submitting patches by email. The first is to make sure you are sending the patch in plain text, this one was in html format. The patch also needs to be included in the mail directly so the review can be done inline. This is what tools like "git send-email" or "stg mail" will do for you.
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
> daxctl use STRING to be region input type. It makes daxctl can accept 
> both <region-id> and region name as region parameter
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

This line went past 80 columns. You can set your text editor to wrap at 80 lines.

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
> diff --git a/daxctl/device.c b/daxctl/device.c index 72e506e..d9db2f9
> 100644
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
> @@ -51,7 +49,7 @@ enum device_action {  };
>
>  #define BASE_OPTIONS() \
> -OPT_INTEGER('r', "region", &param.region_id, "restrict to the given 
> region"), \
> +OPT_STRING('r', "region", &param.region, "region-id", "filter by
> region"), \
>  OPT_BOOLEAN('u', "human", &param.human, "use human friendly number 
> formats"), \  OPT_BOOLEAN('v', "verbose", &param.verbose, "emit more 
> debug
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
> private.h index 9f9c70d..169a8b8 100644
> --- a/daxctl/lib/libdaxctl-private.h
> +++ b/daxctl/lib/libdaxctl-private.h
> @@ -80,6 +80,7 @@ struct daxctl_region {
>   uuid_t uuid;
>   int refcount;
>   char *devname;
> + char *regionname;

So I don't think that "regionname" should be a property of 'struct daxctl_region' because there is no kernel device with that name for daxctl regions. I think this region name should only exist as a special case for "daxctl list".

>   size_t buf_len;
>   void *region_buf;
>   int devices_init;
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c index 
> ee4a069..59697cd 100644
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
>   if (sysfs_read_attr(ctx, path, buf) == 0) @@ -553,6 +554,11 @@ 
> DAXCTL_EXPORT const char *daxctl_region_get_devname(struct 
> daxctl_region *region
>   return region->devname;
>  }
>
> +DAXCTL_EXPORT const char *daxctl_region_get_regionname(struct
> daxctl_region *region)
> +{
> + return region->regionname;
> +}
> +
>  DAXCTL_EXPORT const char *daxctl_region_get_path(struct daxctl_region
> *region)  {

API users should be aware that the region identifier is just a number, so I don't think we need these additions.

>   return region->region_path;
> diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym index 
> 87d0236..13e5aec 100644
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
> diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h index 
> 6c545e1..1592c2f 100644
> --- a/daxctl/libdaxctl.h
> +++ b/daxctl/libdaxctl.h
> @@ -54,6 +54,7 @@ unsigned long long
> daxctl_region_get_available_size(
>  unsigned long long daxctl_region_get_size(struct daxctl_region 
> *region);  unsigned long daxctl_region_get_align(struct daxctl_region 
> *region);  const char *daxctl_region_get_devname(struct daxctl_region 
> *region);
> +const char *daxctl_region_get_regionname(struct daxctl_region
> *region);
>  const char *daxctl_region_get_path(struct daxctl_region *region);
>
>  struct daxctl_dev *daxctl_region_get_dev_seed(struct daxctl_region 
> *region); diff --git a/daxctl/list.c b/daxctl/list.c index 
> e56300d..6c6251b 100644
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
> @@ -66,7 +64,8 @@ static int num_list_flags(void)  int cmd_list(int 
> argc, const char **argv, struct daxctl_ctx *ctx)  {
>   const struct option options[] = {
> - OPT_INTEGER('r', "region", &param.region_id, "filter by region"),
> + OPT_STRING('r', "region", &param.region, "region-id", "filter by 
> + region"),
>   OPT_STRING('d', "dev", &param.dev, "dev-id",
>   "filter by dax device instance name"),
>   OPT_BOOLEAN('D', "devices", &list.devs, "include dax device info"), 
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
> diff --git a/util/filter.c b/util/filter.c index 1734bce..da647a8
> 100644
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
> + if (!ident || strcmp(ident, "all") == 0) return region;
> +
> + if (sscanf(ident, "%d", &region_id) == 1 &&
> + daxctl_region_get_id(region) == region_id) return region;

Let's just add a "sscanf(ident, "region%d", &region_id)" in the case the above ident does not match.

> +
> + region_name = daxctl_region_get_regionname(region);
> + if (strcmp(region_name, ident)==0)
> + return region;

...with the above new sscanf then daxctl_region_get_regionname() is not needed.

> +
> + return NULL;
> +}
> +
>  static enum ndctl_namespace_mode mode_to_type(const char *mode)  {
>   if (!mode)
> diff --git a/util/filter.h b/util/filter.h index c2cdddf..0c12b94
> 100644
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
> diff --git a/util/sysfs.h b/util/sysfs.h index fb169c6..84c0965 100644
> --- a/util/sysfs.h
> +++ b/util/sysfs.h
> @@ -37,4 +37,10 @@ static inline const char *devpath_to_devname(const 
> char *devpath)  {
>   return strrchr(devpath, '/') + 1;
>  }
> +
> +static inline const char *devpath_to_regionname(const char *devpath) 
> +{
> + char* tmp_devpath = strdup(devpath);  return 
> +strtok(strstr(tmp_devpath, "region"), "/");

Another reason to not create "daxctl_region_get_regionname" is that not all daxctl devices will have "region" in the devpath.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

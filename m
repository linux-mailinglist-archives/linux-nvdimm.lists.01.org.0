Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C02D510A764
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 Nov 2019 01:17:50 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C994310113326;
	Tue, 26 Nov 2019 16:21:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0479310113317
	for <linux-nvdimm@lists.01.org>; Tue, 26 Nov 2019 16:21:08 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id d7so692017otq.3
        for <linux-nvdimm@lists.01.org>; Tue, 26 Nov 2019 16:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyPEFwWMAYpft3Egr4UUmRNSvPbBDJZOH1DCCCWNEmg=;
        b=e2HJZJYWypaQoZ2XxPgIL9jxK2e9+kD95rn6lDAkZcq0hPOVxxmCPmgZ4qyGtOtzzW
         LWMCRHwAqxOYsi4vWTaUtiscab3qog8wea7GBleMJ7+d5vbxr6ZL7bKeJhHETTo8E5nY
         OTIHVqSOAmoGSWaaPd97kWOL7UvXJhAmWXhdt8Dd+IM7ITciT/6uoqWgwkphmdfdtsW/
         SxQRhA6SdMX/HjHJUVQ3+DjRpHmjlaDklkX79KTg+LxzZBzEFtMAcVI+aAItkVU2Bmgo
         UZD98w49D1ZgVdWaDYABv/RniZCxKgHrVaDRG+r36yI30AElagExJ79pA7z0itSCM0xp
         lscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyPEFwWMAYpft3Egr4UUmRNSvPbBDJZOH1DCCCWNEmg=;
        b=EEwm6n5DsAwJ/phJPSgFGmwLPqxCylpz7+KCJ52I+zLrYHb8FyB8tQnGvc+pmJGTwa
         6uf+gnJ/iaO6t4jRulaAYvq5PhBo/oOIL9MR71e8xb4H2+0XS4BFzQQTqW6P7PrBbpgH
         +XnmhgQfw4M5oLx35g9D4+b/P8QnBCtvb4IJlG4oZ04uNqTgIkkR6bNk94zM3yT0FhRL
         3Ltl0vQ+eT07PXAiIC17xqky8amoQxEXldxri7Jv8HXSLZpL/LfByb5EVJ5CZHt+Dq3T
         nDUv8FNqvh7/KFIhEgiNiLy+5laLo/ck4I7vwP9UeeIXZ0flPvoL4kPUyKc+lIgT8NIW
         qaFw==
X-Gm-Message-State: APjAAAXPOtFRfkoMSFPoLeg4xqm1uG4JbUfOpqVpn6KUplB5CuT2xWyY
	Y7T4NSqH3Ql+R8BBQi6ufIFNW4UhMfgR6gdtMG9bfP86
X-Google-Smtp-Source: APXvYqwLPYRaGgmTVwudNncLz5LQxwrsAIAhlDgkTWmklS7mvtfhAnZHBASdMoJZiITgs2jiw4UaetruTSS5APQp3uc=
X-Received: by 2002:a05:6830:1af7:: with SMTP id c23mr1319511otd.247.1574813864406;
 Tue, 26 Nov 2019 16:17:44 -0800 (PST)
MIME-Version: 1.0
References: <157480898913.2804089.3499900417147974083.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157480898913.2804089.3499900417147974083.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 26 Nov 2019 16:17:33 -0800
Message-ID: <CAPcyv4i-69k1xUSpeW9tsboKz6uJW6cSzN=uw70egP98zERKKg@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl/list: Add 'target_node' to region and
 namespace verbose listings
To: linux-nvdimm <linux-nvdimm@lists.01.org>
Message-ID-Hash: 52M2PSF54UHWCDHHRFN2ALV65TIHGPJX
X-Message-ID-Hash: 52M2PSF54UHWCDHHRFN2ALV65TIHGPJX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/52M2PSF54UHWCDHHRFN2ALV65TIHGPJX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 26, 2019 at 3:10 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Historically the 'numa_node' attribute of a device has been the local,
> or closest cpu numa node that can access the device. With the ACPI HMAT
> and other platform descriptions of performance differentiated memory,
> memory device targets may have their own numa identifier. The
> target_node property indicates that target information and the effective
> online numa node the memory range would receive if it were onlined.
>
> While this property has been available to device-dax instances since
> kernel commit 21c75763a3ae "device-dax: Add a 'target_node' attribute",
> recent kernels have also started exporting for regions and namespaces.
> Add it to the verbose listing.
>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  ndctl/lib/libndctl.c   |   25 ++++++++++++++++++++++++-
>  ndctl/lib/libndctl.sym |    2 ++
>  ndctl/lib/private.h    |    3 ++-
>  ndctl/libndctl.h       |    2 ++
>  ndctl/list.c           |    9 ++++++++-
>  util/json.c            |    9 ++++++++-
>  6 files changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index d6a28002e7d6..469815a8f04b 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -135,6 +135,7 @@ struct ndctl_mapping {
>   * @generation: incremented everytime the region is disabled
>   * @nstype: the resulting type of namespace this region produces
>   * @numa_node: numa node attribute
> + * @target_node: target node were this region to be onlined
>   *
>   * A region may alias between pmem and block-window access methods.  The
>   * region driver is tasked with parsing the label (if their is one) and
> @@ -160,7 +161,7 @@ struct ndctl_region {
>         char *region_buf;
>         int buf_len;
>         int generation;
> -       int numa_node;
> +       int numa_node, target_node;
>         struct list_head btts;
>         struct list_head pfns;
>         struct list_head daxs;
> @@ -2151,6 +2152,12 @@ static void *add_region(void *parent, int id, const char *region_base)
>         else
>                 region->numa_node = -1;
>
> +       sprintf(path, "%s/target_node", region_base);
> +       if (sysfs_read_attr(ctx, path, buf) == 0)
> +               region->target_node = strtol(buf, NULL, 0);
> +       else
> +               region->target_node = -1;
> +
>         if (region_set_type(region, path) < 0)
>                 goto err_read;
>
> @@ -2424,6 +2431,11 @@ NDCTL_EXPORT int ndctl_region_get_numa_node(struct ndctl_region *region)
>         return region->numa_node;
>  }
>
> +NDCTL_EXPORT int ndctl_region_get_target_node(struct ndctl_region *region)
> +{
> +       return region->target_node;
> +}
> +
>  NDCTL_EXPORT struct badblock *ndctl_region_get_next_badblock(struct ndctl_region *region)
>  {
>         return badblocks_iter_next(&region->bb_iter);
> @@ -3477,6 +3489,12 @@ static void *add_namespace(void *parent, int id, const char *ndns_base)
>         else
>                 ndns->numa_node = -1;
>
> +       sprintf(path, "%s/target_node", ndns_base);
> +       if (sysfs_read_attr(ctx, path, buf) == 0)
> +               ndns->target_node = strtol(buf, NULL, 0);
> +       else
> +               ndns->target_node = -1;
> +
>         sprintf(path, "%s/holder_class", ndns_base);
>         if (sysfs_read_attr(ctx, path, buf) == 0)
>                 ndns->enforce_mode = enforce_name_to_id(buf);
> @@ -4393,6 +4411,11 @@ NDCTL_EXPORT int ndctl_namespace_get_numa_node(struct ndctl_namespace *ndns)
>      return ndns->numa_node;
>  }
>
> +NDCTL_EXPORT int ndctl_namespace_get_target_node(struct ndctl_namespace *ndns)
> +{
> +    return ndns->target_node;
> +}
> +
>  static int __ndctl_namespace_set_write_cache(struct ndctl_namespace *ndns,
>                 int state)
>  {
> diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
> index 4e767789dfe1..bf049af1393a 100644
> --- a/ndctl/lib/libndctl.sym
> +++ b/ndctl/lib/libndctl.sym
> @@ -426,4 +426,6 @@ LIBNDCTL_22 {
>
>  LIBNDCTL_23 {
>         ndctl_namespace_is_configuration_idle;
> +       ndctl_namespace_get_target_node;
> +       ndctl_region_get_target_node;
>  } LIBNDCTL_22;
> diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
> index 1f6a01c55377..e4453013d706 100644
> --- a/ndctl/lib/private.h
> +++ b/ndctl/lib/private.h
> @@ -201,6 +201,7 @@ struct badblocks_iter {
>   * @bdev: associated block_device of a namespace
>   * @size: unsigned
>   * @numa_node: numa node attribute
> + * @target_node: target node were this region to be onlined
>   *
>   * A 'namespace' is the resulting device after region-aliasing and
>   * label-parsing is resolved.
> @@ -220,7 +221,7 @@ struct ndctl_namespace {
>         char *alt_name;
>         uuid_t uuid;
>         struct ndctl_lbasize lbasize;
> -       int numa_node;
> +       int numa_node, target_node;
>         struct list_head injected_bb;
>  };
>
> diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
> index 9a53049e7f61..208240b20aee 100644
> --- a/ndctl/libndctl.h
> +++ b/ndctl/libndctl.h
> @@ -383,6 +383,7 @@ struct ndctl_dimm *ndctl_region_get_first_dimm(struct ndctl_region *region);
>  struct ndctl_dimm *ndctl_region_get_next_dimm(struct ndctl_region *region,
>                 struct ndctl_dimm *dimm);
>  int ndctl_region_get_numa_node(struct ndctl_region *region);
> +int ndctl_region_get_target_node(struct ndctl_region *region);
>  struct ndctl_region *ndctl_bus_get_region_by_physical_address(struct ndctl_bus *bus,
>                 unsigned long long address);
>  #define ndctl_dimm_foreach_in_region(region, dimm) \
> @@ -511,6 +512,7 @@ int ndctl_namespace_set_sector_size(struct ndctl_namespace *ndns,
>  int ndctl_namespace_get_raw_mode(struct ndctl_namespace *ndns);
>  int ndctl_namespace_set_raw_mode(struct ndctl_namespace *ndns, int raw_mode);
>  int ndctl_namespace_get_numa_node(struct ndctl_namespace *ndns);
> +int ndctl_namespace_get_target_node(struct ndctl_namespace *ndns);
>  int ndctl_namespace_inject_error(struct ndctl_namespace *ndns,
>                 unsigned long long block, unsigned long long count,
>                 bool notify);
> diff --git a/ndctl/list.c b/ndctl/list.c
> index 1c3e34d58ddb..607996a85784 100644
> --- a/ndctl/list.c
> +++ b/ndctl/list.c
> @@ -80,7 +80,7 @@ static struct json_object *region_to_json(struct ndctl_region *region,
>         unsigned int bb_count = 0;
>         unsigned long long extent;
>         enum ndctl_persistence_domain pd;
> -       int numa;
> +       int numa, target;
>
>         if (!jregion)
>                 return NULL;
> @@ -130,6 +130,13 @@ static struct json_object *region_to_json(struct ndctl_region *region,
>                         json_object_object_add(jregion, "numa_node", jobj);
>         }
>
> +       target = ndctl_region_get_target_node(region);
> +       if (target >= 0 && flags & UTIL_JSON_VERBOSE) {
> +               jobj = json_object_new_int(target);
> +               if (jobj)
> +                       json_object_object_add(jregion, "target_node", jobj);
> +       }
> +
>         iset = ndctl_region_get_interleave_set(region);
>         if (iset) {
>                 jobj = util_json_object_hex(
> diff --git a/util/json.c b/util/json.c
> index 497c52ba1a00..1369a068398c 100644
> --- a/util/json.c
> +++ b/util/json.c
> @@ -912,7 +912,7 @@ struct json_object *util_namespace_to_json(struct ndctl_namespace *ndns,
>         unsigned long align = 0;
>         char buf[40];
>         uuid_t uuid;
> -       int numa;
> +       int numa, target;
>
>         if (!jndns)
>                 return NULL;
> @@ -1092,6 +1092,13 @@ struct json_object *util_namespace_to_json(struct ndctl_namespace *ndns,
>                         json_object_object_add(jndns, "numa_node", jobj);
>         }
>
> +       target= ndctl_namespace_get_target_node(ndns);
> +       if (target>= 0 && flags & UTIL_JSON_VERBOSE) {

Ugh, not sure how the whitespace after 'target' got dropped. v2 inbound.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

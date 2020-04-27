Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1C71BAF81
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Apr 2020 22:31:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 226D8100986F3;
	Mon, 27 Apr 2020 13:30:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6D59410098A4B
	for <linux-nvdimm@lists.01.org>; Mon, 27 Apr 2020 13:30:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id pg17so15325025ejb.9
        for <linux-nvdimm@lists.01.org>; Mon, 27 Apr 2020 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLbBtWFLYbFaQI/byT069w9dl98KqDThHokIOOMUQVw=;
        b=1HQK3GldCwaWq908cTlKArnoAAW9FUCn8WoLr1W3dATkxJCMuh7zHOMvJdDutWtrdW
         GdpiGAZWbVbaDVRsX6MGXiH5gQvwAlRoNxn7K1BQs6TQUyaMiFqSfVJT5D70r3mm2RNA
         Mk3+HG6p0iVjIeOugBMP9g3O0yrmlVd7lFsE/qiJABRMigvKsjm/iWfSvQk3a6X0z8VW
         nOQ8YEKY+kGwSj4qJhDvov/TcZmzIto0X1okkOl9e7WG2j920W0S7/fuDuNJu6wZFNrY
         Ie1fmHivGf/JD9+eoEvjpmVjMTat6des9VUxRx0kNPkhTHEEGMwg6WDgbtto9mfWMvIx
         GfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLbBtWFLYbFaQI/byT069w9dl98KqDThHokIOOMUQVw=;
        b=djUwBhZDGJb/FSuovM9nCx2rpjH6rgIslhPLcE9QaRgqLMrZ0wze8/zGLVOnUb6pfo
         gcZKJ9Ni9ac/a8HAeqY1WD3VUM8K4xz8I/8pKxhcp0QQpShWjA++rwYzLHyIOK/2Vrau
         OCfXUPMaTkArfkVf19MC6CXu/EXma6Wgc84CJQeBsiIVZyp+ThzWUcFDutYuEXJDB4rJ
         yeEmyTq2T73JWwXBx8/gjiqvFX3lbAvsvcVYfmXjUmWWWMJWTjCAPg487NbxOh2SaY8T
         1ehiIM/+0ITW4aVDYvM5Xyer7eROL2scw+bpIe6GwbGhP3f9UXoJBIkhk6FK96EweWDy
         twUw==
X-Gm-Message-State: AGi0PuYhv+Aya0be+cw56IuNy6YJiFqHc2HxPHcbayOzisSQIDBSR9A8
	BoR3Z5HyMWF5Kl1TeWVz00yIGnxdpDeDfWxuyJlnsg==
X-Google-Smtp-Source: APiQypLxGnMmzELyuecDIyHtgCX2oDLS2win/E+mL6YZkNe8naYkaOGe9NmfnocfuoqVZnHIlC0PYGIj7zfcVchqax4=
X-Received: by 2002:a17:906:eb90:: with SMTP id mh16mr21693457ejb.201.1588019488268;
 Mon, 27 Apr 2020 13:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200426095232.27524-1-redhairer.li@intel.com>
In-Reply-To: <20200426095232.27524-1-redhairer.li@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 27 Apr 2020 13:31:17 -0700
Message-ID: <CAPcyv4gLKSMa4bN446MnRtjdfGaM-Hjy+dcYm316=4EP43G1wg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
To: Redhairer Li <redhairer.li@intel.com>
Message-ID-Hash: LECIOWDKIE5DZLK5RPIOWG67VJ4XSKO4
X-Message-ID-Hash: LECIOWDKIE5DZLK5RPIOWG67VJ4XSKO4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LECIOWDKIE5DZLK5RPIOWG67VJ4XSKO4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Apr 26, 2020 at 2:53 AM Redhairer Li <redhairer.li@intel.com> wrote:
>
> Seed namespaces are included in "ndctl disable-namespace all". However
> since the user never "creates" them it is surprising to see
> "disable-namespace" report 1 more namespace relative to the number that
> have been created. Catch attempts to disable a zero-sized namespace:
>
> Before:
> {
>   "dev":"namespace1.0",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1"
> }
> {
>   "dev":"namespace1.1",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1.1"
> }
> {
>   "dev":"namespace1.2",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1.2"
> }
> disabled 4 namespaces
>
> After:
> {
>   "dev":"namespace1.0",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1"
> }
> {
>   "dev":"namespace1.3",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1.3"
> }
> {
>   "dev":"namespace1.1",
>   "size":"492.00 MiB (515.90 MB)",
>   "blockdev":"pmem1.1"
> }
> disabled 3 namespaces
>
> Signed-off-by: Redhairer Li <redhairer.li@intel.com>
> ---
>  ndctl/lib/libndctl.c | 11 ++++++++---
>  ndctl/region.c       |  4 +++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index ee737cb..49f362b 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -4231,6 +4231,7 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
>         const char *bdev = NULL;
>         char path[50];
>         int fd;
> +       unsigned long long size = ndctl_namespace_get_size(ndns);
>
>         if (pfn && ndctl_pfn_is_enabled(pfn))
>                 bdev = ndctl_pfn_get_block_device(pfn);
> @@ -4260,9 +4261,13 @@ NDCTL_EXPORT int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns)
>                                         devname, bdev, strerror(errno));
>                         return -errno;
>                 }
> -       } else
> -               ndctl_namespace_disable_invalidate(ndns);
> -
> +       } else {
> +               if (size == 0)
> +                       /* Don't try to disable idle namespace (no capacity allocated) */
> +                       return -ENXIO;
> +               else
> +                       ndctl_namespace_disable_invalidate(ndns);
> +       }

Maybe make this return 0 in the case when size is zero since by
definition the namespace must already be disabled if it has zero size.

} else if (size)
    ndctl_namespace_disable_invalidate(ndns);

return 0;

>
> diff --git a/ndctl/region.c b/ndctl/region.c
> index 7945007..0014bb9 100644
> --- a/ndctl/region.c
> +++ b/ndctl/region.c
> @@ -72,6 +72,7 @@ static int region_action(struct ndctl_region *region, enum device_action mode)
>  {
>         struct ndctl_namespace *ndns;
>         int rc = 0;
> +       unsigned long long size;
>
>         switch (mode) {
>         case ACTION_ENABLE:
> @@ -80,7 +81,8 @@ static int region_action(struct ndctl_region *region, enum device_action mode)
>         case ACTION_DISABLE:
>                 ndctl_namespace_foreach(region, ndns) {
>                         rc = ndctl_namespace_disable_safe(ndns);
> -                       if (rc)
> +                       size = ndctl_namespace_get_size(ndns);
> +                       if (rc && size != 0)
>                                 return rc;

...then you wouldn't need to have this special case here since
ndctl_namespace_disable_safe() will not fail.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

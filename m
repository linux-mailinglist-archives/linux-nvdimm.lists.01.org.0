Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D961A87EB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Apr 2020 19:48:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83F3610FC377C;
	Tue, 14 Apr 2020 10:49:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BABE510FC377C
	for <linux-nvdimm@lists.01.org>; Tue, 14 Apr 2020 10:49:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w2so749326edx.4
        for <linux-nvdimm@lists.01.org>; Tue, 14 Apr 2020 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+6aWiKD878nDKZ7SMEASxTASmxVWjuFgzL7SVEcRrA=;
        b=HYyubKM2wuSIfdY7tdDf1xzt5zrBgqQ1Crp+89PNUWKBt9YZqDNc1oK7Ztknb36szQ
         MyP9/mESaJfkDOD2NAQSRKG6NiKfM8HHEcycmAjPKfW20xaKV74eX5cxH2GJovnMMxb3
         PdSaBmoTAULd34f+fw0pAEddfUxx9nhJQ9KO1LtZ9G4RcIDIsyFjS8qgV0B/Ph1NgFww
         OuNxjRMgCrVwCJaCvzlk/ESIMv5shEdKqRBoxTCRfQyDd0DXluLDnS1eP3VSF6Dq1Ru5
         k2xw/7uNLW6sVmDnz92T1vhAMfWjFPYB7z7RPyro6kvHiGVDWbHxKdrhWznUpwJxpqbV
         a3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+6aWiKD878nDKZ7SMEASxTASmxVWjuFgzL7SVEcRrA=;
        b=Aw1gIWnHK//4VKusTRm6iSpT4uXw7K0/uJh5V7hQka6kbbhMuIREKOYQSQgZ4dM3nU
         jhPBprLzO5wM7SWgT6vGpf3LMKlns8uNO2B66FtCKwFj0HTNJaSpJtsZ1TdjTZHBBL0w
         SOTqWFZ2dZ/3eedF5+FJObv20AOO3mrmqBVOrhSlbdT5i7RndE7zjf8jwlGLXUVG4WZ3
         kuviLeWxWG+utR5r1uvlyQl+8Zz4TD3Q2lTjJfhYRYgMsQXJdT+4HbKjt7IQza32L5h8
         4Q8nHp1gFHxLdHVSU+qpKnnXYvWOZ21+VyGfdDzAW9eyMh+TBub0EYI86ydv0tlUEsM/
         yo8w==
X-Gm-Message-State: AGi0PuYM4b1r5wRHtDsg1xjxKfwsS7vKNf/lqMsirmPaEbNrY6Q6UF0c
	rarbGcJBJ5AFLS6GlNXv4ceu11u8JM9XCSR3GYnmcw==
X-Google-Smtp-Source: APiQypLsUpSP2e6N2xlRnWc3X1feVbzfKgKq1YY9diERW2eiVImnhVL5wKrmFejUd9517ZOr1yFRSInPRFKCYDQ1ZSo=
X-Received: by 2002:a05:6402:3136:: with SMTP id dd22mr4395654edb.165.1586886514935;
 Tue, 14 Apr 2020 10:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200414113747.1680093-1-santosh@fossix.org>
In-Reply-To: <20200414113747.1680093-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 14 Apr 2020 10:48:23 -0700
Message-ID: <CAPcyv4jq_xEJzfnUkObRCv7Q+s-meebd=mKasBtdTRrt8oScWA@mail.gmail.com>
Subject: Re: [ndctl PATCH] Skip region filtering if numa_node attribute is not present
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: W6KNAZDSEAMI47O57UUNJ4K5RWM3MBK3
X-Message-ID-Hash: W6KNAZDSEAMI47O57UUNJ4K5RWM3MBK3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, harish@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W6KNAZDSEAMI47O57UUNJ4K5RWM3MBK3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 14, 2020 at 4:39 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> For kernel versions older than 5.4, the numa_node attribute is not
> present for regions; due to which `ndctl list -U 1` fails to list
> namespaces.
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  ndctl/lib/libndctl.c   | 11 +++++++++++
>  ndctl/lib/libndctl.sym |  1 +
>  ndctl/libndctl.h       |  1 +
>  util/filter.c          | 12 +++++++++++-
>  4 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index ee737cb..fc82084 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -2471,6 +2471,17 @@ NDCTL_EXPORT struct ndctl_dimm *ndctl_region_get_next_dimm(struct ndctl_region *
>         return NULL;
>  }
>
> +NDCTL_EXPORT int ndctl_region_has_numa_attr(struct ndctl_region *region)

I'd shorten this to just ndctl_region_has_numa().

> +{
> +       char *path = region->region_buf;
> +
> +       sprintf(path, "%s/numa_node", region->region_path);
> +       if (access(path, F_OK) != -1)
> +               return 1;

You should be able to cache this result at the beginning of time at
add_region() time to check for the ENOENT error return here:

        sprintf(path, "%s/numa_node", region_base);
        if (sysfs_read_attr(ctx, path, buf) == 0)
                region->numa_node = strtol(buf, NULL, 0);
        else
                region->numa_node = -1;

> +
> +       return 0;
> +}
> +
>  NDCTL_EXPORT int ndctl_region_get_numa_node(struct ndctl_region *region)
>  {
>         return region->numa_node;
> diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
> index ac575a2..b7c72a2 100644
> --- a/ndctl/lib/libndctl.sym
> +++ b/ndctl/lib/libndctl.sym
> @@ -430,4 +430,5 @@ LIBNDCTL_23 {
>         ndctl_region_get_target_node;
>         ndctl_region_get_align;
>         ndctl_region_set_align;
> +       ndctl_region_has_numa_attr;
>  } LIBNDCTL_22;
> diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
> index 2580f43..4e233d8 100644
> --- a/ndctl/libndctl.h
> +++ b/ndctl/libndctl.h
> @@ -385,6 +385,7 @@ struct ndctl_dimm *ndctl_region_get_first_dimm(struct ndctl_region *region);
>  struct ndctl_dimm *ndctl_region_get_next_dimm(struct ndctl_region *region,
>                 struct ndctl_dimm *dimm);
>  int ndctl_region_get_numa_node(struct ndctl_region *region);
> +int ndctl_region_has_numa_attr(struct ndctl_region *region);
>  int ndctl_region_get_target_node(struct ndctl_region *region);
>  struct ndctl_region *ndctl_bus_get_region_by_physical_address(struct ndctl_bus *bus,
>                 unsigned long long address);
> diff --git a/util/filter.c b/util/filter.c
> index af72793..8e60cfa 100644
> --- a/util/filter.c
> +++ b/util/filter.c
> @@ -467,7 +467,13 @@ int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
>                                                 param->namespace))
>                                 continue;
>
> -                       if (numa_node != NUMA_NO_NODE &&
> +                       /*
> +                        * if numa_node attribute is not available for regions
> +                        * (which is true for pre 5.4 kernels), don't skip the
> +                        * region, let namespace filter handle the filtering.
> +                        */
> +                       if (ndctl_region_has_numa_attr(region) &&
> +                           numa_node != NUMA_NO_NODE &&

This should also check that namespaces are being requested otherwise
failing here is the right thing to do. An error message stating that
the kernel lacks region-numa support when no namespaces are present
would also be useful.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

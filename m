Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BACC306A4E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 02:24:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9CEB8100EB353;
	Wed, 27 Jan 2021 17:24:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 923C1100EB351
	for <linux-nvdimm@lists.01.org>; Wed, 27 Jan 2021 17:24:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n6so4718986edt.10
        for <linux-nvdimm@lists.01.org>; Wed, 27 Jan 2021 17:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=om3qbY9w1F7jTEVJFiVY00oA9QG9fqgTsLAHYTklO+A=;
        b=mk6LPN2yhkakqjefmev63Z7iZT4WdxRz463hVi572EJNbYBnUYkuHMSlg+FYORBlpW
         9ao8OswrSNEv6TQW0/zrY2TLNm8qC0GzYCiVZadQu5oLhYbR2C5POSCX6OQJozuVZwzx
         B4X5UA/Z85dbfLbpkjO2C2hmVArbBIPLgF4UsWctUX4MLaYU1x3XTQjzBrweE3Xspvn4
         RHyC/8BFTCJ9mTHDS+1ydg6b236S3Yie4zDseON1VOOYgJzVfRXlhqHZqXEJJ6ueu4tq
         9R/4QZMGtOEvmD4xEWx0IHKsfswn8Lv9YACv+RaFD7HjuwkFYKzfo86d05Kvy4Jo7DZV
         55ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=om3qbY9w1F7jTEVJFiVY00oA9QG9fqgTsLAHYTklO+A=;
        b=NzkgN8TqoOFrheiyTsRyWA8cGc9vTWO9I4ip/olGjfP1FZt66krNXfSQ7rmp0seP97
         ipL/zl9EHEjL/+esseNfDjG3E5LWuoKyv7wXv90vDfrvpU5gAAxkv8Nldm0Lw2p8D0+K
         YcbOvTWdoq0vIjBhoSsDrzVZKEH5F9wPPjVpQGVlBW11D2XNP4ItgWhFGaYfQwQvI9u/
         715Kfmb7eYsnRXGaM9666qKS3OQZ+8+jQc6Cf6NmEi2dktNOdptRd99WaHETJN6CxThr
         Aaq6P1un1QzkW5Cid+Ikwt3l4Ec7WYXP5dKfDu7gy/wpO9oeNAxopNMgoJjW0C4T2smH
         rj+w==
X-Gm-Message-State: AOAM531saFfXmKWgbnInGcIImGLR8WsNAYWV4OxH5H/5T5ZfF+dkGSYG
	Lii//kYSnxPhBJvyzGKBH3w+ZguONLaAOlB0OjRWzg==
X-Google-Smtp-Source: ABdhPJxRFmRhqsZHWZoSR1DYOymoAHqLfbLNMsCl5RLAuIyczuIDQ+Q3BqfX600oAReEpKoZhHgutzXPg1ayds5g2g0=
X-Received: by 2002:aa7:d610:: with SMTP id c16mr11822496edr.354.1611797073879;
 Wed, 27 Jan 2021 17:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20201222042240.2983755-1-santosh@fossix.org> <20201222042516.2984348-1-santosh@fossix.org>
 <20201222042516.2984348-5-santosh@fossix.org>
In-Reply-To: <20201222042516.2984348-5-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Jan 2021 17:24:32 -0800
Message-ID: <CAPcyv4inaEKt4s5vNGsbfidCz+biWJk6QTLyOMWB05iFreOMfA@mail.gmail.com>
Subject: Re: [ndctl 5/5] Use page size as alignment value
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: LKFNDXESI6VVD64TYJDWNSO5BJJOWE2K
X-Message-ID-Hash: LKFNDXESI6VVD64TYJDWNSO5BJJOWE2K
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LKFNDXESI6VVD64TYJDWNSO5BJJOWE2K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 21, 2020 at 8:26 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> The alignment sizes passed to ndctl in the tests are all hardcoded to 4k,
> the default page size on x86. Change those to the default page size on that
> architecture (sysconf/getconf). No functional changes otherwise.
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  test/dpa-alloc.c    | 23 ++++++++++++++---------
>  test/multi-dax.sh   |  6 ++++--
>  test/sector-mode.sh |  4 +++-
>  3 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
> index 10af189..ff6143e 100644
> --- a/test/dpa-alloc.c
> +++ b/test/dpa-alloc.c
> @@ -48,12 +48,13 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>         struct ndctl_region *region, *blk_region = NULL;
>         struct ndctl_namespace *ndns;
>         struct ndctl_dimm *dimm;
> -       unsigned long size;
> +       unsigned long size, page_size;
>         struct ndctl_bus *bus;
>         char uuid_str[40];
>         int round;
>         int rc;
>
> +       page_size = sysconf(_SC_PAGESIZE);
>         /* disable nfit_test.1, not used in this test */
>         bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER1);
>         if (!bus)
> @@ -134,11 +135,11 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>                         return rc;
>                 }
>                 ndctl_namespace_disable_invalidate(ndns);
> -               rc = ndctl_namespace_set_size(ndns, SZ_4K);
> +               rc = ndctl_namespace_set_size(ndns, page_size);
>                 if (rc) {
> -                       fprintf(stderr, "failed to init %s to size: %d\n",
> +                       fprintf(stderr, "failed to init %s to size: %lu\n",
>                                         ndctl_namespace_get_devname(ndns),
> -                                       SZ_4K);
> +                                       page_size);
>                         return rc;
>                 }
>                 namespaces[i].ndns = ndns;
> @@ -160,7 +161,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>                 ndns = namespaces[i % ARRAY_SIZE(namespaces)].ndns;
>                 if (i % ARRAY_SIZE(namespaces) == 0)
>                         round++;
> -               size = SZ_4K * round;
> +               size = page_size * round;
>                 rc = ndctl_namespace_set_size(ndns, size);
>                 if (rc) {
>                         fprintf(stderr, "%s: set_size: %lx failed: %d\n",
> @@ -176,7 +177,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>         i--;
>         round++;
>         ndns = namespaces[i % ARRAY_SIZE(namespaces)].ndns;
> -       size = SZ_4K * round;
> +       size = page_size * round;
>         rc = ndctl_namespace_set_size(ndns, size);
>         if (rc) {
>                 fprintf(stderr, "%s failed to update while labels full\n",
> @@ -185,7 +186,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>         }
>
>         round--;
> -       size = SZ_4K * round;
> +       size = page_size * round;
>         rc = ndctl_namespace_set_size(ndns, size);
>         if (rc) {
>                 fprintf(stderr, "%s failed to reduce size while labels full\n",
> @@ -279,8 +280,12 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>
>         available_slots = ndctl_dimm_get_available_labels(dimm);
>         if (available_slots != default_available_slots - 1) {
> -               fprintf(stderr, "mishandled slot count\n");
> -               return -ENXIO;
> +               fprintf(stderr, "mishandled slot count (%u, %u)\n",
> +                       available_slots, default_available_slots - 1);
> +
> +               /* TODO: fix it on non-acpi platforms */
> +               if (ndctl_bus_has_nfit(bus))
> +                       return -ENXIO;

This change seems unrelated to page size fixups. Care to break it out?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

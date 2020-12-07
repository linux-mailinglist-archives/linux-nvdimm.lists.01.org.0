Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C22D1E41
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 00:24:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F59C100EBB9F;
	Mon,  7 Dec 2020 15:24:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4BF0100EBB9D
	for <linux-nvdimm@lists.01.org>; Mon,  7 Dec 2020 15:24:35 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id k4so15680320edl.0
        for <linux-nvdimm@lists.01.org>; Mon, 07 Dec 2020 15:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFF4UyHPQF1Vur8bUKQO1arPhEsSSFvEOk0MTlcEDOA=;
        b=dXiktNkZL/KFba+txfBKpBEfqh3RDtNfMVJnEBHl0g2BtdsLLn0dv5lG1PeNuaDh4r
         YzXoHr/n6DXLNSQYKuGsL5Pk2+eWVuQvocFLk2BrHd10BvzSskdjmF4zJDCuUTsGriNu
         2cKcnk/7bBnLQTQ3fXKxdeH+gN4h6rNtcnRVZ+/S5tUMdgI0GegY85bskXYtYfZN0ZLL
         LRyDykZfksYCOeLKDc1mX5DJduhw2kPiHGuEg48+od+YOfs2/tzFRepfDQ2zFqw5yQbK
         CA9tGbdvH6VNX5iiKQkQ5jhWiwwckdyF8UIGxyRPuJsmyIanWPsrzX/KZOTGZLolAryq
         y4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFF4UyHPQF1Vur8bUKQO1arPhEsSSFvEOk0MTlcEDOA=;
        b=DB9KsQXi8hN7TOFGemNHBqf6wvf8APuQTtKKowQ7tXkaMHGzM5WqbGAqT2WJfTA16Y
         yXwkg2F6kvKSBYy+062mCgbokcZN6ws8+CEhLUValTNnPb1gVDuiOVPfeBXwBR4uKj+K
         y8w3OkdfP9Psa1qnjI0NSUxzaEzf44Q7GXjsjGNjBjfOP4mcd/SDrxA7jhfuzZRybAq5
         omY0hR8B63qpV/SraMqzZFw3zVWGeXji9Iig7B6bKI5v2kRnNjcA+wpPvF68BrKu8etw
         DZlDHUIMh3oOCi402E6y//2d+T4lOCwBQctXVWyE2ubvxF2cYFJD3jP0T0e6LU9hgZYN
         Q0gg==
X-Gm-Message-State: AOAM530TzWo29EKQAszNmZDQ0SR3jVlSN3Xj5WGpoFMAp41B1q5eHFro
	GZDhgwNg5l70YWu1wYJnt0ZQiW6G3YiCeJaG8TFS5w==
X-Google-Smtp-Source: ABdhPJwYr7BIl+ZcUaNPt99ASehiQbcVMgUjMgjZ5SHTDv2uMnRrYPfzOBusxsynU8K47PGrrhY6GSuFjmOC8IPFanE=
X-Received: by 2002:a05:6402:1684:: with SMTP id a4mr17328531edv.348.1607383474007;
 Mon, 07 Dec 2020 15:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20201108121723.2089939-1-santosh@fossix.org> <20201108122016.2090891-1-santosh@fossix.org>
 <20201108122016.2090891-2-santosh@fossix.org>
In-Reply-To: <20201108122016.2090891-2-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 Dec 2020 15:24:32 -0800
Message-ID: <CAPcyv4iObPLT8PWSe0xn2YRMrrTFoe3Qx1VCuNmLkU9J+yjOeQ@mail.gmail.com>
Subject: Re: [ndctl RFC v4 2/3] Skip smart tests when non nfit devices present
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: 4HM2PDI3PPYVADQZK5PWSNEPA3KTUYWT
X-Message-ID-Hash: 4HM2PDI3PPYVADQZK5PWSNEPA3KTUYWT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4HM2PDI3PPYVADQZK5PWSNEPA3KTUYWT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 8, 2020 at 4:20 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>

-ENOCOMMITMESSAGE

Also this patch is doing more than just skipping SMART tests, which
would have been noticed by writing a commit message, and which
probably would have prompted those changes to move to their own
patch... with their own commit message of course.

> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  ndctl/lib/libndctl.c | 34 ++++++++++++++++++++++++++--------
>  test/libndctl.c      |  3 ++-
>  2 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index d1f8e4e..26fc14c 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -815,8 +815,11 @@ static void parse_papr_flags(struct ndctl_dimm *dimm, char *flags)
>                         dimm->flags.f_restore = 1;
>                 else if (strcmp(start, "smart_notify") == 0)
>                         dimm->flags.f_smart = 1;
> +               else if (strcmp(start, "save_fail") == 0)
> +                       dimm->flags.f_save = 1;
>                 start = end + 1;
>         }
> +
>         if (end != start)
>                 dbg(ctx, "%s: Flags:%s\n", ndctl_dimm_get_devname(dimm), flags);
>  }
> @@ -1044,7 +1047,8 @@ NDCTL_EXPORT int ndctl_bus_is_papr_scm(struct ndctl_bus *bus)
>         if (sysfs_read_attr(bus->ctx, bus->bus_buf, buf) < 0)
>                 return 0;
>
> -       return (strcmp(buf, "ibm,pmemory") == 0);
> +       return (strcmp(buf, "ibm,pmemory") == 0 ||
> +               strcmp(buf, "nvdimm_test") == 0);
>  }
>
>  /**
> @@ -1661,6 +1665,7 @@ static void populate_dimm_attributes(struct ndctl_dimm *dimm,
>         char buf[SYSFS_ATTR_SIZE];
>         struct ndctl_ctx *ctx = dimm->bus->ctx;
>         char *path = calloc(1, strlen(dimm_base) + 100);
> +       int i;
>
>         sprintf(path, "%s/phys_id", dimm_base);
>         if (sysfs_read_attr(ctx, path, buf) < 0)
> @@ -1690,6 +1695,16 @@ static void populate_dimm_attributes(struct ndctl_dimm *dimm,
>                         dimm->manufacturing_location = b[2];
>                 }
>         }
> +
> +       sprintf(path, "%s/format", dimm_base);
> +       if (sysfs_read_attr(ctx, path, buf) == 0)
> +               dimm->format[0] = strtoul(buf, NULL, 0);
> +       for (i = 1; i < dimm->formats; i++) {
> +               sprintf(path, "%s/format%d", dimm_base, i);
> +               if (sysfs_read_attr(ctx, path, buf) == 0)
> +                       dimm->format[i] = strtoul(buf, NULL, 0);
> +       }

The "format" attribute is this strange artifact of the ACPI NFIT
definition. You've already done the work to emulate it, but I wish I
could have saved you from that diversion because I don't see the point
for papr, especially just to make a unit test happy.

The "format" was related to a JEDEC designation IIRC, but it has no
practical implication on the kernel or ndctl. It was only 3rd party
management software that thought they needed this, but even then I
think the justification was dubious.

> +
>         sprintf(path, "%s/subsystem_vendor", dimm_base);
>         if (sysfs_read_attr(ctx, path, buf) == 0)
>                 dimm->subsystem_vendor_id = strtoul(buf, NULL, 0);
> @@ -1853,7 +1868,8 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
>         if (!path)
>                 return NULL;
>
> -       sprintf(path, "%s/nfit/formats", dimm_base);
> +       sprintf(path, "%s%s/formats", dimm_base,
> +               ndctl_bus_has_nfit(bus) ? "/nfit" : "");
>         if (sysfs_read_attr(ctx, path, buf) < 0)
>                 formats = 1;
>         else
> @@ -1927,9 +1943,9 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
>         else
>                 dimm->fwa_result = fwa_result_to_result(buf);
>
> +       dimm->formats = formats;
>         /* Check if the given dimm supports nfit */
>         if (ndctl_bus_has_nfit(bus)) {
> -               dimm->formats = formats;
>                 rc = add_nfit_dimm(dimm, dimm_base);
>         } else if (ndctl_bus_has_of_node(bus)) {
>                 rc = add_papr_dimm(dimm, dimm_base);
> @@ -2592,13 +2608,15 @@ static void *add_region(void *parent, int id, const char *region_base)
>                 goto err_read;
>         region->num_mappings = strtoul(buf, NULL, 0);
>
> -       sprintf(path, "%s/nfit/range_index", region_base);
> -       if (ndctl_bus_has_nfit(bus)) {
> -               if (sysfs_read_attr(ctx, path, buf) < 0)
> +       sprintf(path, "%s%s/range_index", region_base,
> +               ndctl_bus_has_nfit(bus) ? "/nfit" : "");
> +       if (sysfs_read_attr(ctx, path, buf) < 0) {
> +               if (ndctl_bus_has_nfit(bus))
>                         goto err_read;
> -               region->range_index = strtoul(buf, NULL, 0);
> +               else
> +                       region->range_index = -1;
>         } else
> -               region->range_index = -1;
> +               region->range_index = strtoul(buf, NULL, 0);
>
>         sprintf(path, "%s/read_only", region_base);
>         if (sysfs_read_attr(ctx, path, buf) < 0)
> diff --git a/test/libndctl.c b/test/libndctl.c
> index 994e0fa..b7e7b68 100644
> --- a/test/libndctl.c
> +++ b/test/libndctl.c
> @@ -2427,7 +2427,8 @@ static int check_commands(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
>          * The kernel did not start emulating v1.2 namespace spec smart data
>          * until 4.9.
>          */
> -       if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0)))
> +       if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0))
> +           || !ndctl_bus_has_nfit(bus))
>                 dimm_commands &= ~((1 << ND_CMD_SMART)
>                                 | (1 << ND_CMD_SMART_THRESHOLD));


I was going to say split test/libndctl.c into a generic test and and
nfit-specific test/libndctl-nfit.c, but if the vast majority of the
tests runs with just small tweaks like this I think I can do that
refactoring later.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

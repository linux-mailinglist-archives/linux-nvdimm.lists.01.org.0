Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F972D1E10
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 00:08:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 32A66100EBB99;
	Mon,  7 Dec 2020 15:07:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 06D22100EBB98
	for <linux-nvdimm@lists.01.org>; Mon,  7 Dec 2020 15:07:56 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id dk8so12716314edb.1
        for <linux-nvdimm@lists.01.org>; Mon, 07 Dec 2020 15:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XpOyrgkjFecxCBR3Qc/96PnNAMDtdlW+lxA7sEE+O8=;
        b=B/syqmRkAPrx0KVHvJxywlf9BD2HEKl5DWmcb/VkAIHZ2i/IilrfHW5EJrhnuWy/dC
         bLIzd3cnDqxnLklgWVwOa8sKRfOOzII4Xx4uoc9v3l++FRdixRGYTFXQlUwjF93KFFW3
         2HZ3R+sh5MRDZtaEoes08R3ZMXsQlOKxfmH4z/MubprnsScF1Z1LHlZFjof8kuWmnl5N
         5rThN/xQD+1AXZYGJSz1a4Xzf/78QRLAZrwqrX2Qy8AqQuQ8gRxqR2FXlY0tx7o033sX
         VhQ7OZRKlLs4cj3VSajp6UnTrxW/31BVyBGJOvVQ5mzlxlK50S3CRMHYYBUL7PD1sh8b
         BWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XpOyrgkjFecxCBR3Qc/96PnNAMDtdlW+lxA7sEE+O8=;
        b=UbtWTjVrI42Ae73R2hXhHdR0PN2VNcdLLcp1Kun+eWU8nUFUGkgqbi7Jx73tN48eEH
         X6kZAJV8VnDlCHSze0aWLUzUbsDwc9JL15YB2tLgXnYSWxSKIPEh5UQBpDjHvs6ieUcq
         kqIAZAOEggyAQMN9ID3idCkGeqm0ZPb553F7RvWDrynAdbMkAdJk6sy8H7zg+/mKe+AF
         GTYAE5eFjgkScK2ChPzEGmi0JQ8fkgDoSaAyQi5pVS1S3GFJjC/MUvUAVcBsWxX/sn6E
         e6Nk30dkIxhyDqffn9dSli9tPOIE+ulZ359NycoS+MYJdUrUJ/v1YWR4tyYw5/M6nCcA
         agug==
X-Gm-Message-State: AOAM530whYcPOwFT7pltGjKvmibbNm6oqsI3NCF0s/JbbiEgq5yKIWWt
	mONg8gBFdteDN8KexeqLXFZ8tpOgKN2Wjb/GGQnuKJ5EBUTKog==
X-Google-Smtp-Source: ABdhPJxHvg5FGJQcje6a3vvUmX/QiUYLl872c7zlj5JPdSeA/YyrfdBce+wGklSGqtNu1wDZYMRqwXny1pRcLaFcbtM=
X-Received: by 2002:a50:8a44:: with SMTP id i62mr19242835edi.97.1607382474482;
 Mon, 07 Dec 2020 15:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20201108121723.2089939-1-santosh@fossix.org> <20201108122016.2090891-1-santosh@fossix.org>
In-Reply-To: <20201108122016.2090891-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 Dec 2020 15:07:52 -0800
Message-ID: <CAPcyv4gP-jg1ckg-34fAHmSqhPkr1Q2QOyr9vxe2abJpVrcdkQ@mail.gmail.com>
Subject: Re: [ndctl RFC v4 1/3] libndctl: test enablement for non-nfit devices
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: UXT5FEOU7FNX3IDZO7MZYHURDA7OQJAO
X-Message-ID-Hash: UXT5FEOU7FNX3IDZO7MZYHURDA7OQJAO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UXT5FEOU7FNX3IDZO7MZYHURDA7OQJAO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 8, 2020 at 4:21 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> Don't fail is nfit module is missing, this will happen in
> platforms that don't have ACPI support. Add attributes to
> PAPR dimm family that are independent of platforms like the
> test dimms.
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  ndctl/lib/libndctl.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>  test/core.c          |  6 +++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index ad521d3..d1f8e4e 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -1655,6 +1655,54 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
>  static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
>  static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
>
> +static void populate_dimm_attributes(struct ndctl_dimm *dimm,
> +                                    const char *dimm_base)
> +{
> +       char buf[SYSFS_ATTR_SIZE];
> +       struct ndctl_ctx *ctx = dimm->bus->ctx;
> +       char *path = calloc(1, strlen(dimm_base) + 100);
> +
> +       sprintf(path, "%s/phys_id", dimm_base);
> +       if (sysfs_read_attr(ctx, path, buf) < 0)
> +               goto err_read;
> +       dimm->phys_id = strtoul(buf, NULL, 0);
> +
> +       sprintf(path, "%s/handle", dimm_base);
> +       if (sysfs_read_attr(ctx, path, buf) < 0)
> +               goto err_read;
> +       dimm->handle = strtoul(buf, NULL, 0);
> +
> +       sprintf(path, "%s/vendor", dimm_base);
> +       if (sysfs_read_attr(ctx, path, buf) == 0)
> +               dimm->vendor_id = strtoul(buf, NULL, 0);
> +
> +       sprintf(path, "%s/id", dimm_base);
> +       if (sysfs_read_attr(ctx, path, buf) == 0) {
> +               unsigned int b[9];
> +
> +               dimm->unique_id = strdup(buf);
> +               if (!dimm->unique_id)
> +                       goto err_read;
> +               if (sscanf(dimm->unique_id, "%02x%02x-%02x-%02x%02x-%02x%02x%02x%02x",
> +                                       &b[0], &b[1], &b[2], &b[3], &b[4],
> +                                       &b[5], &b[6], &b[7], &b[8]) == 9) {
> +                       dimm->manufacturing_date = b[3] << 8 | b[4];
> +                       dimm->manufacturing_location = b[2];
> +               }
> +       }
> +       sprintf(path, "%s/subsystem_vendor", dimm_base);
> +       if (sysfs_read_attr(ctx, path, buf) == 0)
> +               dimm->subsystem_vendor_id = strtoul(buf, NULL, 0);
> +
> +
> +       sprintf(path, "%s/dirty_shutdown", dimm_base);
> +       if (sysfs_read_attr(ctx, path, buf) == 0)
> +               dimm->dirty_shutdown = strtoll(buf, NULL, 0);

These are fairly similar to the nfit ones... how about refactoring
this into a routine that takes a bus prefix and shares it between
"nfit" and "papr"...

We might also consider unifying them into a standard set of attributes
that both the nfit-bus-provider and the papr-bus-provider export. I.e.
that nfit was wrong to place them under nfit/ and they should have
went somewhere generic from the beginning. The nfit compatibility can
be done with symlinks to the new common location.

> +
> +err_read:
> +       free(path);
> +}
> +
>  static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
>  {
>         int rc = -ENODEV;
> @@ -1685,6 +1733,10 @@ static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
>                 rc = 0;
>         }
>
> +       /* add the available dimm attributes, the platform can override or add
> +        * additional attributes later */
> +       populate_dimm_attributes(dimm, dimm_base);
> +
>         free(path);
>         return rc;
>  }
> diff --git a/test/core.c b/test/core.c
> index 5118d86..0fd1011 100644
> --- a/test/core.c
> +++ b/test/core.c
> @@ -195,6 +195,12 @@ retry:
>
>                 path = kmod_module_get_path(*mod);
>                 if (!path) {
> +                       /* For non-nfit platforms it's ok if nfit module is
> +                        * missing */
> +                       if (strcmp(name, "nfit") == 0 ||
> +                           strcmp(name, "nd_e820") == 0)
> +                               continue;

This breaks the safety it afforded on nfit platforms. Instead I think
this needs a couple changes:

- rename nfit_test_init to ndctl_test_init
- add a parameter for whether the test is initializing for
nfit_test.ko or ndtest.ko.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

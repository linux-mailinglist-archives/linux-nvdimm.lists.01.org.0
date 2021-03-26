Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FC734B1C7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 23:04:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A58D7100EBBAF;
	Fri, 26 Mar 2021 15:04:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=pasha.tatashin@soleen.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D3B02100EC1D5
	for <linux-nvdimm@lists.01.org>; Fri, 26 Mar 2021 15:04:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z1so7937700edb.8
        for <linux-nvdimm@lists.01.org>; Fri, 26 Mar 2021 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NhMbn4GcAMbl9agNWrxMfpoDWOn9OHOKSjI2XlOKPcA=;
        b=JsRhNPVll2FnHcGnjMcKrlYEx0lYJGoaiEVYaYgYs0q/tSIU1iebSMJV2C4qXRNVHC
         j/xpHuTprrCE4mV4OBoEqPoLmBa4SbSIGF9YUwooquw7ZoXBZBPV3cFbJjfeOF+B233g
         pjXd5mtup9UXuW2zyO/jkUTpyMnUc3JSedUah8trDhNHU/4hDKbDRufTfhI8csZDzfCz
         UjWdiOEshHoumIBLy5vl9wrVfaQBk4bSwT9RzLGbv8TR0ondD0H1q7HjwDIUcATSTqd2
         QYWEhwxdF/H5kTqSSiJFq2epyi3OIXJnchlgid7OKnKfV9iULl572sNFNI6Lm1oFH4fY
         35JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhMbn4GcAMbl9agNWrxMfpoDWOn9OHOKSjI2XlOKPcA=;
        b=HZZvqJGnib8rhGX+7w4YJGk6h+eDnGJ9WCfJM8D+6ECTsvyWsSptYfSEziMIEnQcl9
         JUBgWrfrZtx+A4nZXZWLhnV/NZ9uXLWpjzj4XwSYCy+J/Nr/fUDQoceCzNwwhmBSyeM+
         iKCDsUPbxeFkT/zn1EZXYu0VwnOfrXwgWy4tLnsxDN13vmxVXSpbS3QoxKCH6P8hs13F
         Dc1oKQmmVQsMB3bw3chtAU/xoF0B2JkIDo8MOmZACvhW+Yz4zh9+TFULHPNitmsBFO11
         wNwDcmUN9lZIFQamiTSIqekVJWXv2aDlPQKDgIsfA71tJnln9j+5KNbeTRNPzawQPzvM
         XneQ==
X-Gm-Message-State: AOAM531PvGQAliCBXoVz4jmcSM9Fru6Qs/VDTxwxrOiRUYLyC1YlAF+m
	XBHwYgugUUbgCFmU22MOM+kKa0RJkOUqVK46Im2NnA==
X-Google-Smtp-Source: ABdhPJxQD721Oskyn5CTedmmIY6VdwsAeChWfKtYyILt4a/FIBJNX//QnvQnTOKlKoSRC/oYPGEBtznjlD1/YyRBNuk=
X-Received: by 2002:a05:6402:c88:: with SMTP id cm8mr17363764edb.62.1616796243247;
 Fri, 26 Mar 2021 15:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210326152645.85225-1-tyhicks@linux.microsoft.com>
In-Reply-To: <20210326152645.85225-1-tyhicks@linux.microsoft.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 26 Mar 2021 18:03:27 -0400
Message-ID: <CA+CK2bB_ZeThG=i-RgrZo6By-c1sSvSdgP0+Wk95qVp_LX0xYw@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/region: Allow setting align attribute on
 regions without mappings
To: Tyler Hicks <tyhicks@linux.microsoft.com>
Message-ID-Hash: 32QSGHRDMJPIXDZFWXNELHLOOHRAQEJL
X-Message-ID-Hash: 32QSGHRDMJPIXDZFWXNELHLOOHRAQEJL
X-MailFrom: pasha.tatashin@soleen.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, LKML <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/32QSGHRDMJPIXDZFWXNELHLOOHRAQEJL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 26, 2021 at 11:27 AM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> The alignment constraint for namespace creation in a region was
> increased, from 2M to 16M, for non-PowerPC architectures in v5.7 with
> commit 2522afb86a8c ("libnvdimm/region: Introduce an 'align'
> attribute"). The thought behind the change was that region alignment
> should be uniform across all architectures and, since PowerPC had the
> largest alignment constraint of 16M, all architectures should conform to
> that alignment.
>
> The change regressed namespace creation in pre-defined regions that
> relied on 2M alignment but a workaround was provided in the form of a
> sysfs attribute, named 'align', that could be adjusted to a non-default
> alignment value.
>
> However, the sysfs attribute's store function returned an error (-ENXIO)
> when userspace attempted to change the alignment of a region that had no
> mappings. This affected 2M aligned regions of volatile memory that were
> defined in a device tree using "pmem-region" and created by the
> of_pmem_region_driver, since those regions do not contain mappings
> (ndr_mappings is 0).
>
> Allow userspace to set the align attribute on pre-existing regions that
> do not have mappings so that namespaces can still be within those
> regions, despite not being aligned to 16M.
>
> Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>

This solves the problem that I had in this thread:
https://lore.kernel.org/lkml/CA+CK2bCD13JBLMxn2mAuRyVQGKBS5ic2UqYSsxXTccszXCmHkA@mail.gmail.com/

Thank you Tyler for root causing and finding a proper fix.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

> ---
>  drivers/nvdimm/region_devs.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ef23119db574..09cff8aa6b40 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -545,29 +545,32 @@ static ssize_t align_store(struct device *dev,
>                 struct device_attribute *attr, const char *buf, size_t len)
>  {
>         struct nd_region *nd_region = to_nd_region(dev);
> -       unsigned long val, dpa;
> -       u32 remainder;
> +       unsigned long val;
>         int rc;
>
>         rc = kstrtoul(buf, 0, &val);
>         if (rc)
>                 return rc;
>
> -       if (!nd_region->ndr_mappings)
> -               return -ENXIO;
> -
> -       /*
> -        * Ensure space-align is evenly divisible by the region
> -        * interleave-width because the kernel typically has no facility
> -        * to determine which DIMM(s), dimm-physical-addresses, would
> -        * contribute to the tail capacity in system-physical-address
> -        * space for the namespace.
> -        */
> -       dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
> -       if (!is_power_of_2(dpa) || dpa < PAGE_SIZE
> -                       || val > region_size(nd_region) || remainder)
> +       if (val > region_size(nd_region))
>                 return -EINVAL;
>
> +       if (nd_region->ndr_mappings) {
> +               unsigned long dpa;
> +               u32 remainder;
> +
> +               /*
> +                * Ensure space-align is evenly divisible by the region
> +                * interleave-width because the kernel typically has no facility
> +                * to determine which DIMM(s), dimm-physical-addresses, would
> +                * contribute to the tail capacity in system-physical-address
> +                * space for the namespace.
> +                */
> +               dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
> +               if (!is_power_of_2(dpa) || dpa < PAGE_SIZE || remainder)
> +                       return -EINVAL;
> +       }
> +
>         /*
>          * Given that space allocation consults this value multiple
>          * times ensure it does not change for the duration of the
> --
> 2.25.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

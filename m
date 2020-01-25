Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFC81492D4
	for <lists+linux-nvdimm@lfdr.de>; Sat, 25 Jan 2020 02:56:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CBADB1007B8FF;
	Fri, 24 Jan 2020 17:59:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E2F8710097E13
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jan 2020 17:59:21 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id z64so1448451oia.4
        for <linux-nvdimm@lists.01.org>; Fri, 24 Jan 2020 17:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f28Qb/AW6fDNnihykQT6srC3U5IJ2vDxBI74KoKLOSE=;
        b=LjdOuqy0zHhLb70m07GdRqEaFYb99kMdAyzONkbUej+Dm6ZjtLhrcnz9n4rg0BK8I4
         sxcRSwun3A9RGZ0rGxr1BWLonCUjQ/R+ehhcEjugXXUeTPJ7rRC/Lv5iJIfsl8Ql/CCX
         nfGmUMGMfI9nTRaxrgntwtEq4Ry2ABnX2GN6mtViVTAcl7mHFfhoHbes95pjuk14vjy7
         Yi1wvDI1CXMWlUgy9YP1MFRk2DHg7bjVGgTJF9KM71ymsuh98MM4fT3ZT8UHWwTx1PIp
         XE7WJWvicAHXWGkYFti/SAwLAeHfbk4FMpmOYjTsgDu2v7BJ9CBqj1Vv5fhvDnGtVx1A
         fbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f28Qb/AW6fDNnihykQT6srC3U5IJ2vDxBI74KoKLOSE=;
        b=lHQu9qBs/GzeukSHk1/wAGZpc6egMlIvQ1tbbqPuzBhqHrhhawWdNyIEcZNax7qbO4
         +yEe0Mt12Q/nUzCYnUKz5Q0fn9RBuAtb4GVpImj2BFnmbPgfHCs4x+bN1N021J3Gv1w0
         DzVjrpkXnNDGl2UWy0A+e/V2JqC4ZZSTOmu2Dn7cdyyRbMewquQ0VhhPcZC9/iCc4+H+
         wS8knrH2nYFNRGLElXrL9o1wFjGUZFPM6PkGzWn8YDzgIozL0R8EF6/KOoWAuZnuClqP
         Y0bcWE8z7j4Pi87boiAoPokHWBVSkrQIGPWPHlS+6OM1+u5jNeXrZ1h3EuzGWNasOLBn
         5DHQ==
X-Gm-Message-State: APjAAAVnPszkjjG0P5gvtF6ozK4gDbryDeYOaL7t1CBIsaouqI3nsOo+
	nm+IJ66pj2pZ/qPWHjwDkx1lPwHYCepF4Jif3wkxHQ==
X-Google-Smtp-Source: APXvYqxKxuxBhNryf5ZiV4JThiAqT7F5o6fu9+H7y9EzqKBYlO2EOa1EqAzYgPjvkk1+QtGNW0ha6ky4u8x7fnCWE0Y=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr1249989oie.105.1579917362701;
 Fri, 24 Jan 2020 17:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com> <20200120140749.69549-3-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200120140749.69549-3-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 24 Jan 2020 17:55:51 -0800
Message-ID: <CAPcyv4g01znkP4JTP8Y707D3kODRY9LwctaPJ2PyyjauKSfnPA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] libnvdimm/namespace: Validate namespace start addr
 and size
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: SNQ3NZWW4LRYAH2B6BMMPWHCCOUHEOT3
X-Message-ID-Hash: SNQ3NZWW4LRYAH2B6BMMPWHCCOUHEOT3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SNQ3NZWW4LRYAH2B6BMMPWHCCOUHEOT3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 20, 2020 at 6:08 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Make sure namespace start addr and size are properly aligned as per architecture
> restrictions. If the namespace is not aligned kernel mark the namespace 'disabled'
>
> Architectures like ppc64 use different page size than PAGE_SIZE to map
> direct-map address range. The kernel needs to make sure the namespace size is aligned
> correctly for the direct-map page size.
>
> kernel log will contain information as below.
>
> [    5.810939] nd_pmem namespace0.1: invalid size/SPA
> [    5.810969] nd_pmem: probe of namespace0.1 failed with error -95
>
> and the namespace will be marked 'disabled'
>
>   {
>     "dev":"namespace0.1",
>     "mode":"fsdax",
>     "map":"mem",
>     "size":1071644672,
>     "uuid":"25577a00-c012-421d-89ca-3ee189e08848",
>     "sector_size":512,
>     "state":"disabled"
>   },
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/namespace_devs.c | 50 +++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index 032dc61725ff..0e2c90730ce3 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1113,6 +1113,51 @@ resource_size_t nvdimm_namespace_capacity(struct nd_namespace_common *ndns)
>  }
>  EXPORT_SYMBOL(nvdimm_namespace_capacity);
>
> +static bool nvdimm_valid_namespace(struct device *dev,
> +               struct nd_namespace_common *ndns, resource_size_t size)
> +{
> +       struct device *ndns_dev = &ndns->dev;
> +       struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
> +       unsigned long map_size = arch_namespace_map_size();
> +       struct resource *res;
> +       u32 remainder;
> +
> +       /*
> +        * Don't validate the start and size for blk namespace type
> +        */

If you're going to comment I'd prefer a comment that explains why, not
what. E.g. "blk namespaces are ioremap()'d with small page aligned
apertures"

> +       if (is_namespace_blk(ndns_dev))
> +               return true;
> +
> +       /*
> +        * For btt and raw namespace kernel use ioremap. Assume both can work
> +        * with PAGE_SIZE alignment.
> +        */
> +       if (is_nd_btt(dev) || is_namespace_io(ndns_dev))
> +               map_size = PAGE_SIZE;
> +
> +       div_u64_rem(size, map_size * nd_region->ndr_mappings, &remainder);

Not all regions have mappings see e820_register_one(), so this is a
divide by zero.

I think this is mixing 2 different constraints. There's the soft
constraint of wanting aliased pmem capacity to remain aligned relative
to blk capacity, and then there's the hard constraint where the kernel
just can't use devm_memremap_pages() for the given capacity alignment.

I think this routine should be called:

    nvdimm_validate_geometry()

...and only check for:

    if (pmem_should_map_pages() || is_nd_pfn() || is_nd_dax())

...i.e namespaces are mapped by memremap_pages() and compare that
against memremap_compat_align().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

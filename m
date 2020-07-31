Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5FC234802
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jul 2020 16:52:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 35CD61291290E;
	Fri, 31 Jul 2020 07:52:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1140E1291290A
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 07:52:49 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v22so11766679edy.0
        for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xbkWYnKB5bD8Dx+A3hqQvuyFQl9+LQz6yTL7Vvq6w0=;
        b=s7e5W0fXDILLB6ZWbNuQf571n49wktNjevDIf5ymOQ4TmVGXG/ZXEhdZ5d2V2CSlGz
         SQFONr4GotVUcj7ixDNsa/uashyzLwpPDHZD254BElUXOnbseZXkDpKdmlzJHzGcW5lN
         HvkEPK1kV8BwVkzcYf2T62N3V+yUFc1TSsAWKyqD7cET6pOYxMk/unAf2w3OhIWXlwJC
         iQPf5U3ideRZ3LCcsaE5QbRva7XwFMZadtyqvvng1ODDFENc/f5u3wI+RXzsiF+dYn32
         5YUMF86zfXDGdwXniwrzfwZf3DBgyBPfFya+TKVIhW0JLlMZ2fz/t76egk/7KVNrEX59
         7bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xbkWYnKB5bD8Dx+A3hqQvuyFQl9+LQz6yTL7Vvq6w0=;
        b=lN/oZYTnV6MFnOx54ru13ZE/9EtotPgLRvR/YkfllxvY1Kt9GD1UGweffxJKTHhgFZ
         iGzfJt5EfP3OIheWP+KrETR3QXQT93eDd1u2C1OBgOA7Z4RjTS0caSTcVUzXAdwbhM4O
         tjCEI2OYAhFFKNc+N0uBZ5bN/rQZxdWvmr7Ra7FeKsCmKSJYwMg5nCLqG/pR2E1OAQ54
         4IkdODmVYLfXpt4JaMKPnyGAR0Ks9Z0XLbh19cAPwnE0YFT8XFFLVun4MCdbNn1oB4a5
         PyW9ExMNFW5E9Pni4dESiLH9jlNxnxBNUjkFXNh8M6ZlUv4NYonuWZc1tkf746eRsmUe
         HpUg==
X-Gm-Message-State: AOAM530rRC9pin4b6FA1VtJtvrQud/wbboQbMynxpJ7uZ6iAQFayzAl8
	W+xHFXKG0RgVY1V9wdKvXyjdFs18//U7ZuWgYBr17A==
X-Google-Smtp-Source: ABdhPJzWcMODSLzAdKZ6q1frH2GXeDvyC+w2kZfqO8Lo3sAsT7hyYeTYxvBgCwoinitzwZZZSd9uSFR6RseVBdrmti8=
X-Received: by 2002:a50:fb06:: with SMTP id d6mr4114200edq.165.1596207167258;
 Fri, 31 Jul 2020 07:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200716172913.19658-1-joao.m.martins@oracle.com> <20200716172913.19658-3-joao.m.martins@oracle.com>
In-Reply-To: <20200716172913.19658-3-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 31 Jul 2020 07:52:36 -0700
Message-ID: <CAPcyv4iueciTchM+tkhHZd6PhmbgKhQuBWaxm2Ff2bvvZWBBOw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] device-dax: Add an 'align' attribute
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: VZC2UHNQV622JJORU6NIVANGEQNVKP5H
X-Message-ID-Hash: VZC2UHNQV622JJORU6NIVANGEQNVKP5H
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VZC2UHNQV622JJORU6NIVANGEQNVKP5H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 16, 2020 at 10:31 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Introduce a device align attribute. While doing so,
> rename the region align attribute to be more explicitly
> named as so, but keep it named as @align to retain the API
> for tools like daxctl.
>
> Changes on align may not always be valid, when say certain
> mappings were created with 2M and then we switch to 1G. So, we
> validate all ranges against the new value being attempted,
> post resizing.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/dax/bus.c | 101 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 92 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 2578651c596e..eb384dd6a376 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -230,14 +230,15 @@ static ssize_t region_size_show(struct device *dev,
>  static struct device_attribute dev_attr_region_size = __ATTR(size, 0444,
>                 region_size_show, NULL);
>
> -static ssize_t align_show(struct device *dev,
> +static ssize_t region_align_show(struct device *dev,
>                 struct device_attribute *attr, char *buf)
>  {
>         struct dax_region *dax_region = dev_get_drvdata(dev);
>
>         return sprintf(buf, "%u\n", dax_region->align);
>  }
> -static DEVICE_ATTR_RO(align);
> +static struct device_attribute dev_attr_region_align =
> +               __ATTR(align, 0400, region_align_show, NULL);
>
>  #define for_each_dax_region_resource(dax_region, res) \
>         for (res = (dax_region)->res.child; res; res = res->sibling)
> @@ -488,7 +489,7 @@ static umode_t dax_region_visible(struct kobject *kobj, struct attribute *a,
>  static struct attribute *dax_region_attributes[] = {
>         &dev_attr_available_size.attr,
>         &dev_attr_region_size.attr,
> -       &dev_attr_align.attr,
> +       &dev_attr_region_align.attr,
>         &dev_attr_create.attr,
>         &dev_attr_seed.attr,
>         &dev_attr_delete.attr,
> @@ -855,14 +856,13 @@ static ssize_t size_show(struct device *dev,
>         return sprintf(buf, "%llu\n", size);
>  }
>
> -static bool alloc_is_aligned(struct dax_region *dax_region,
> -               resource_size_t size)
> +static bool alloc_is_aligned(resource_size_t size, unsigned long align)

For type safety, let's make this take @dev_dax as a parameter. For the
dev_dax_set_align() case I think it is ok to provisionally adjust
dev_dax->align under the lock before entry and revert to the old
alignment on failure.

I can fix that up locally on applying.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

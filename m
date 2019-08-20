Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 597FC95360
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 03:28:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6C23121962301;
	Mon, 19 Aug 2019 18:30:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 988DB2020D333
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 18:30:05 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g17so3536811otl.2
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 18:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bpCrccGQA8l7BTcc8eWw96H6pS6MQIOOzUEqeqPrzKU=;
 b=lZbsZt+/6d5yJAVD8m/RWxrbst/pw6mXm9sXy042kGJEQR9cu7lYZjLiBf6dwe8kdd
 x073MY1NIze1gOonl8UPKw/Tk5EF1OpFoPQGBl5XHSPHM3FU1oVNtDcJqg89FstWApDZ
 fcibc6V2UzCg8TM7EzkiczR5EkpxjjjuQLLKPRPQJq02SSicgxK0jB80zPnLkyusZNYE
 Slg72DBH/UYm3UkD6+qsNs8SVJRkNhZMpJr+9jeb1ioXRRn/PjlKF0yV+Nm9dfMO3FUR
 eIYBUiC3kTdhj84CPutziyMUYtE+g4LnP3j8x3sgoJ+m+Ui16TzkRosrQJJTFUJX8F4e
 dqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bpCrccGQA8l7BTcc8eWw96H6pS6MQIOOzUEqeqPrzKU=;
 b=r6CPwO3Z/Xdnd8tJB8z2PKlKXKtoYpPhUdKFREqpm9LBEjYkMZI83XusnjipvY02TU
 UWoP0s0/2VrF96uWODpcUNKRUFe89oST7fgInDmPpKwh7VCtq+1HBRpPTsPAYXAQxtpK
 56r4wuPPI205v0dO1zf1jaHzKQh7HKbHWCptNRqWbbgYVR4v7TaBM1Qclb2TE0x0f+eo
 hAaj3CI8WXZkWX76Jp5xt+vl3G6+BW2TVZqVLp9Gvt22t1AHvSPOcRJKztpFoLattCvS
 ptRoluCL7rzaw6i4M+GF8uY+iL409cky+Q+E7P7bKTrXaDVIOgckTKh8b05GLBxi1LWg
 btaQ==
X-Gm-Message-State: APjAAAWphH8igMy56fX8aSSSU7fDqYZ6iszd5sEsdoEVat0ttnyGtQbk
 C2RHJd5ESMhYSMb3L2tLARlwJUFql252mrbtXAc37w==
X-Google-Smtp-Source: APXvYqzHphAQuA/iOiJkSZOef8tOpXSCYjbbUJRyOK3xnSM7rIdYobKMnaOjdx9wCeE+nGliVWangEXZTLwnNbJUfas=
X-Received: by 2002:a05:6830:458:: with SMTP id
 d24mr19871635otc.126.1566264521208; 
 Mon, 19 Aug 2019 18:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de>
 <20190818090557.17853-2-hch@lst.de>
In-Reply-To: <20190818090557.17853-2-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Aug 2019 18:28:30 -0700
Message-ID: <CAPcyv4iaNtmvU5e8_8SV9XsmVCfnv8e7_YfMi46LfOF4W155zg@mail.gmail.com>
Subject: Re: [PATCH 1/4] resource: add a not device managed
 request_free_mem_region variant
To: Christoph Hellwig <hch@lst.de>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bharata B Rao <bharata@linux.ibm.com>, Linux MM <linux-mm@kvack.org>,
 Jason Gunthorpe <jgg@mellanox.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun, Aug 18, 2019 at 2:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Factor out the guts of devm_request_free_mem_region so that we can
> implement both a device managed and a manually release version as
> tiny wrappers around it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/linux/ioport.h |  2 ++
>  kernel/resource.c      | 45 +++++++++++++++++++++++++++++-------------
>  2 files changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 5b6a7121c9f0..7bddddfc76d6 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -297,6 +297,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
>
>  struct resource *devm_request_free_mem_region(struct device *dev,
>                 struct resource *base, unsigned long size);
> +struct resource *request_free_mem_region(struct resource *base,
> +               unsigned long size, const char *name);
>
>  #endif /* __ASSEMBLY__ */
>  #endif /* _LINUX_IOPORT_H */
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 7ea4306503c5..74877e9d90ca 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1644,19 +1644,8 @@ void resource_list_free(struct list_head *head)
>  EXPORT_SYMBOL(resource_list_free);
>
>  #ifdef CONFIG_DEVICE_PRIVATE
> -/**
> - * devm_request_free_mem_region - find free region for device private memory
> - *
> - * @dev: device struct to bind the resource to
> - * @size: size in bytes of the device memory to add
> - * @base: resource tree to look in
> - *
> - * This function tries to find an empty range of physical address big enough to
> - * contain the new resource, so that it can later be hotplugged as ZONE_DEVICE
> - * memory, which in turn allocates struct pages.
> - */
> -struct resource *devm_request_free_mem_region(struct device *dev,
> -               struct resource *base, unsigned long size)
> +static struct resource *__request_free_mem_region(struct device *dev,
> +               struct resource *base, unsigned long size, const char *name)
>  {
>         resource_size_t end, addr;
>         struct resource *res;
> @@ -1670,7 +1659,10 @@ struct resource *devm_request_free_mem_region(struct device *dev,
>                                 REGION_DISJOINT)
>                         continue;
>
> -               res = devm_request_mem_region(dev, addr, size, dev_name(dev));
> +               if (dev)
> +                       res = devm_request_mem_region(dev, addr, size, name);
> +               else
> +                       res = request_mem_region(addr, size, name);
>                 if (!res)
>                         return ERR_PTR(-ENOMEM);
>                 res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
> @@ -1679,7 +1671,32 @@ struct resource *devm_request_free_mem_region(struct device *dev,
>
>         return ERR_PTR(-ERANGE);
>  }
> +
> +/**
> + * devm_request_free_mem_region - find free region for device private memory
> + *
> + * @dev: device struct to bind the resource to
> + * @size: size in bytes of the device memory to add
> + * @base: resource tree to look in
> + *
> + * This function tries to find an empty range of physical address big enough to
> + * contain the new resource, so that it can later be hotplugged as ZONE_DEVICE
> + * memory, which in turn allocates struct pages.
> + */
> +struct resource *devm_request_free_mem_region(struct device *dev,
> +               struct resource *base, unsigned long size)
> +{

Previously we would loudly crash if someone passed NULL to
devm_request_free_mem_region(), but now it will silently work and the
result will leak. Perhaps this wants a:

if (!dev)
    return NULL;

...to head off those mistakes?

No major heartburn if you keep it as is, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9BD27F082
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 19:28:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1B4A154A7BF5;
	Wed, 30 Sep 2020 10:28:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A515E1519864B
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 10:28:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p15so3991726ejm.7
        for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7sPk6Sik27AWrREdtUYnYe92i3vslb/zKKVkOgBVaQ=;
        b=zmyxtM718bJxbCH+GLRAIs/H47BTp2R1awvT53QplORdnHGWVeJTQdK9fdRVtvBv5W
         ZZFMGzmU2zd4bdTHGfpR4tVDd1Y0Otit4r7u3R2D/10aTTTl9ESuMHc7s8OzpDsc1AmQ
         7KFl9Ey9DKu3G0yrF0FT/zZ+60uBSEAJcZeq0yQ67A6v6Hw9k7bWJHF1ay4LU+UHikkk
         +6hYpTQSopFGY9z8J2KLxvVqdRC9FZS2YYvVRND4NXtYyWogwO3aEEB9ydcWm6G7YAY+
         anaXgr8WTNEHkZfbgg/UocgrBOEELE7O0mBzxih/A2gUQEIuX1xMkxLYYueDwJzCOT7Y
         fYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7sPk6Sik27AWrREdtUYnYe92i3vslb/zKKVkOgBVaQ=;
        b=IBlszKI1JO5lDY95hIWLFV9LqfzBM1aK//hJzHxIrjiJgCd7aBG/l4SHNYXAnZMRsD
         S3Jm/cO4wTmgKW1AaPM4HfgXDDRwj/nRNrY/Zcj5y9Z3JgaAMnz/e41NEybXZI38B03x
         qDbgY2KM+5bZqB9xguyqpQmPbGVRE8ZAl9q82u6aQt/IdUt0fRQIqEXMCLEDnW7XjHV/
         PoswXIOI+IzCIraGEDmgyocMivJ4lrJkFGpLT5mRGhC7IROhKfl8yhVx+uE7Vf7S7u0h
         NoDelSv/cs26pKdIPp20KHf7pX2OUe9Fb1DGHCF9oUVcHa8cEoQDLxtqiNFgf90XGeEz
         ZwSQ==
X-Gm-Message-State: AOAM531oNALetqW9T+ULecC2ep742HNeddpvaZzsD+xXK3Wv0r/VwXCR
	pGo1MNHZg3k/Cf/bO6ficVopwdM/UlgAZQkP9Ur6DA==
X-Google-Smtp-Source: ABdhPJwHTh9jNRUe26y/9bRenkD0CrDNpv/b4M+zhuDvrSCF8so++nqTlmejCH4CxF24yboF7SB9F7SGef38jSfloJI=
X-Received: by 2002:a17:906:2354:: with SMTP id m20mr3803912eja.341.1601486917942;
 Wed, 30 Sep 2020 10:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160106112239.30709.15909567572288425294.stgit@dwillia2-desk3.amr.corp.intel.com>
 <86f450e7-d1a7-3d82-b486-afd6682c5942@redhat.com>
In-Reply-To: <86f450e7-d1a7-3d82-b486-afd6682c5942@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 30 Sep 2020 10:28:26 -0700
Message-ID: <CAPcyv4iZUFR5v-tr8zgxHuy2dotNSRGr1jdNpBFAsDYk8oUTFw@mail.gmail.com>
Subject: Re: [PATCH v5 04/17] device-dax/kmem: replace release_resource() with release_mem_region()
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: ZOPKSMRTRFXKNNK4COHH2EQCTE734BOR
X-Message-ID-Hash: ZOPKSMRTRFXKNNK4COHH2EQCTE734BOR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Brice Goglin <Brice.Goglin@inria.fr>, Jia He <justin.he@arm.com>, Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZOPKSMRTRFXKNNK4COHH2EQCTE734BOR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 30, 2020 at 9:23 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 25.09.20 21:12, Dan Williams wrote:
> > Towards removing the mode specific @dax_kmem_res attribute from the
> > generic 'struct dev_dax', and preparing for multi-range support, change
> > the kmem driver to use the idiomatic release_mem_region() to pair with
> > the initial request_mem_region(). This also eliminates the need to open
> > code the release of the resource allocated by request_mem_region().
> >
> > As there are no more dax_kmem_res users, delete this struct member.
> >
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: Brice Goglin <Brice.Goglin@inria.fr>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Jia He <justin.he@arm.com>
> > Cc: Joao Martins <joao.m.martins@oracle.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dax/dax-private.h |    3 ---
> >  drivers/dax/kmem.c        |   20 +++++++-------------
> >  2 files changed, 7 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> > index 6779f683671d..12a2dbc43b40 100644
> > --- a/drivers/dax/dax-private.h
> > +++ b/drivers/dax/dax-private.h
> > @@ -42,8 +42,6 @@ struct dax_region {
> >   * @dev - device core
> >   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
> >   * @range: resource range for the instance
> > - * @dax_mem_res: physical address range of hotadded DAX memory
> > - * @dax_mem_name: name for hotadded DAX memory via add_memory_driver_managed()
> >   */
> >  struct dev_dax {
> >       struct dax_region *region;
> > @@ -52,7 +50,6 @@ struct dev_dax {
> >       struct device dev;
> >       struct dev_pagemap *pgmap;
> >       struct range range;
> > -     struct resource *dax_kmem_res;
> >  };
> >
> >  static inline u64 range_len(struct range *range)
> > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> > index 6fe2cb1c5f7c..e56fc688bdc5 100644
> > --- a/drivers/dax/kmem.c
> > +++ b/drivers/dax/kmem.c
> > @@ -33,7 +33,7 @@ int dev_dax_kmem_probe(struct device *dev)
> >  {
> >       struct dev_dax *dev_dax = to_dev_dax(dev);
> >       struct range range = dax_kmem_range(dev_dax);
> > -     struct resource *new_res;
> > +     struct resource *res;
> >       char *res_name;
> >       int numa_node;
> >       int rc;
> > @@ -56,8 +56,8 @@ int dev_dax_kmem_probe(struct device *dev)
> >               return -ENOMEM;
> >
> >       /* Region is permanently reserved if hotremove fails. */
> > -     new_res = request_mem_region(range.start, range_len(&range), res_name);
> > -     if (!new_res) {
> > +     res = request_mem_region(range.start, range_len(&range), res_name);
> > +     if (!res) {
> >               dev_warn(dev, "could not reserve region [%#llx-%#llx]\n", range.start, range.end);
> >               kfree(res_name);
> >               return -EBUSY;
> > @@ -69,23 +69,20 @@ int dev_dax_kmem_probe(struct device *dev)
> >        * inherit flags from the parent since it may set new flags
> >        * unknown to us that will break add_memory() below.
> >        */
> > -     new_res->flags = IORESOURCE_SYSTEM_RAM;
> > +     res->flags = IORESOURCE_SYSTEM_RAM;
> >
> >       /*
> >        * Ensure that future kexec'd kernels will not treat this as RAM
> >        * automatically.
> >        */
> > -     rc = add_memory_driver_managed(numa_node, new_res->start,
> > -                                    resource_size(new_res), kmem_name);
> > +     rc = add_memory_driver_managed(numa_node, range.start, range_len(&range), kmem_name);
> >       if (rc) {
> > -             release_resource(new_res);
> > -             kfree(new_res);
> > +             release_mem_region(range.start, range_len(&range));
> >               kfree(res_name);
> >               return rc;
> >       }
> >
> >       dev_set_drvdata(dev, res_name);
> > -     dev_dax->dax_kmem_res = new_res;
> >
> >       return 0;
> >  }
> > @@ -95,7 +92,6 @@ static int dev_dax_kmem_remove(struct device *dev)
> >  {
> >       struct dev_dax *dev_dax = to_dev_dax(dev);
> >       struct range range = dax_kmem_range(dev_dax);
> > -     struct resource *res = dev_dax->dax_kmem_res;
> >       const char *res_name = dev_get_drvdata(dev);
> >       int rc;
> >
> > @@ -114,10 +110,8 @@ static int dev_dax_kmem_remove(struct device *dev)
> >       }
> >
> >       /* Release and free dax resources */
> > -     release_resource(res);
> > -     kfree(res);
> > +     release_mem_region(range.start, range_len(&range));
>
> Does that work? AFAIKs,
>
> __release_region(&iomem_resource, (start), (n)) -> __release_region()
>
> will only remove stuff that is IORESOURCE_BUSY.

Oh, crud, indeed. More fallout from futzing with the flags.

> Maybe storing it in drvdata is indeed the easiest way to remove it from
> struct dax_region.

My first choice is still to get the driver out of the layering
violation of touching resource flags, but we don't seem to be
converging on a way forward there. So, stuffing more tracking into
drvdata (especially for the multi-range case) is the next best option.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

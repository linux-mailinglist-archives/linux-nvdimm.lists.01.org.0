Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1738A2227F4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 18:01:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B9BF11C340FA;
	Thu, 16 Jul 2020 09:01:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C782011C32CCB
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 09:01:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n26so7144392ejx.0
        for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yV3LwwP/SEpzaIEmeMBzbOghkFrbv+sk/VN9onw9N4c=;
        b=PmM7BFqw2PSR4FOOXVxXhA2f6W9m437kj4FNos9CDP3AJplZthVDkyvWlsqXdsVzAW
         IM0jY8Aj2cjRUyQ5//pe2xP0Djmun92aIvQU+RkGKuprB7WpZ6t9y8XW97H8aPkZsSws
         LauGKXBWtxn+z294PiF58zpqTAMdaJnRkNRZDJaoBHdyv0iIexU9jpq+lDfX70zSDlM/
         uuwpQMBzj+gyc/2Gi9ptBI+nur9z9JdfUf8q8QbPcre4pqAcb3Yf2Q8Tt35VJ37cGQ76
         IoN3YCs7xA0vUYw1/o3x6BLHfCW/Hf3I81JzZNOwPjM+60sb/ZQZu+tFvmc25pLG3/oe
         slkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yV3LwwP/SEpzaIEmeMBzbOghkFrbv+sk/VN9onw9N4c=;
        b=OoJc18GlIqHt7IsUX3bRI4sGpiEo9y4bYEt08yC4ZUga3tQ/MZ1iPR60XSNrC5Mad+
         4f/IFitzGdHXxS5QZN7WhxOVSB64ZOwvCwkKSSjx9bIiJTwKFSizcOwiOgnwkcjAAobJ
         jALRmP+AoYraJSeSvAiRcU/xzfyVgqQ6yT/ivJK3njOPtw6KdVQH+wgw6ZPXMo6pGPYM
         PoKPyw6pGEUzSib6gVf5s7zKCv+8WUe3H/Wt+ThpEZ9/DiQhMsSiGYAXq5zcNnIyfApR
         Qrjq43rWjq7p7zG0WJ5hGXKOMrNmMNQBUV982f6QAnCgtUcNL8VfcX/Dt1oAVJz3h8k1
         SzlA==
X-Gm-Message-State: AOAM532tNAlDNKkwDu/bv8BVtKBkj6zyXqh2Vt6doFRYeHjezNNsN9WM
	8gjiY5VTocyUzn3UoyaT+tOmSVpSWUvZRwU3sJS++w==
X-Google-Smtp-Source: ABdhPJw6daMW61UwPNGt9t0xFJ7BOFzJkc2Eqyf8Rfj0dreUEGgSjFtNL4bh/7oZZRDtti8BDS586JUwVYpyjV4FRCo=
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr4585391ejt.440.1594915258725;
 Thu, 16 Jul 2020 09:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457128462.754248.10443613927921016089.stgit@dwillia2-desk3.amr.corp.intel.com>
 <7ecd1b82-06ab-be49-4b92-ac42caab146c@oracle.com>
In-Reply-To: <7ecd1b82-06ab-be49-4b92-ac42caab146c@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 16 Jul 2020 09:00:47 -0700
Message-ID: <CAPcyv4hFS7JS9s7cUY=2Ru2kUTRsesxwX1PGnnc_tudJjoDUGw@mail.gmail.com>
Subject: Re: [PATCH v2 22/22] device-dax: Introduce 'mapping' devices
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: LLAPE3JDDX6HAV464INEMLBJHPLJKUVI
X-Message-ID-Hash: LLAPE3JDDX6HAV464INEMLBJHPLJKUVI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LLAPE3JDDX6HAV464INEMLBJHPLJKUVI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 16, 2020 at 6:19 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 7/12/20 5:28 PM, Dan Williams wrote:
> > In support of interrogating the physical address layout of a device with
> > dis-contiguous ranges, introduce a sysfs directory with 'start', 'end',
> > and 'page_offset' attributes. The alternative is trying to parse
> > /proc/iomem, and that file will not reflect the extent layout until the
> > device is enabled.
> >
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dax/bus.c         |  191 +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/dax/dax-private.h |   14 +++
> >  2 files changed, 203 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index f342e36c69a1..8b6c4ddc5f42 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -579,6 +579,167 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
> >  }
> >  EXPORT_SYMBOL_GPL(alloc_dax_region);
> >
> > +static void dax_mapping_release(struct device *dev)
> > +{
> > +     struct dax_mapping *mapping = to_dax_mapping(dev);
> > +     struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> > +
> > +     ida_free(&dev_dax->ida, mapping->id);
> > +     kfree(mapping);
> > +}
> > +
> > +static void unregister_dax_mapping(void *data)
> > +{
> > +     struct device *dev = data;
> > +     struct dax_mapping *mapping = to_dax_mapping(dev);
> > +     struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> > +     struct dax_region *dax_region = dev_dax->region;
> > +
> > +     dev_dbg(dev, "%s\n", __func__);
> > +
> > +     device_lock_assert(dax_region->dev);
> > +
> > +     dev_dax->ranges[mapping->range_id].mapping = NULL;
> > +     mapping->range_id = -1;
> > +
> > +     device_del(dev);
> > +     put_device(dev);
> > +}
> > +
> > +static struct dev_dax_range *get_dax_range(struct device *dev)
> > +{
> > +     struct dax_mapping *mapping = to_dax_mapping(dev);
> > +     struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> > +     struct dax_region *dax_region = dev_dax->region;
> > +
> > +     device_lock(dax_region->dev);
> > +     if (mapping->range_id < 1) {
>             ^^^^^^^^^^^^^^^^^^^^^ it's 'mapping->range_id < 0'
>
> Otherwise 'mapping0' sysfs entries won't work.
> Disabled ranges use id -1.

Whoops, yes. Needs a unit test.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

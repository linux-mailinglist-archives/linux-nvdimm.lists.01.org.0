Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6716B191DC4
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Mar 2020 00:51:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DECC810FC38BB;
	Tue, 24 Mar 2020 16:52:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0821510FC363B
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 16:52:31 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id p125so405306oif.10
        for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsuHRbkrRa7b9vqtRFx6ZxGV0C6hEgdYMQeOpNoVJ0E=;
        b=jgx9CVgZcBzRzaEGKFLv/1JOTUMrhNkGkLTdNTBN5CFC7PlSIeE0hcCdBrTvaw578G
         8YxLzN0nM6iNf3wKE7zw8apBgYHyE5jU7LNswbWwXwWHfUTQJO9vm1PFErePmhUQPlBP
         Vt6nqyYE7EcDffVVOCJ4DFUufko+Zog9ruk7Gg0dJk5SQBgWGC7BBV5pr1mRIq5755yO
         YVHd++wVXkAmTw/lET38pgHh8M72HZAwVGgO4Du+2ufb81Jltpo4VrKzt0/QsPNJMRgr
         2Tq6BGao3x7tbcGZIExPuDBLWO3boKoqOsO8A/UijwTYnjICttMS266PGrxtNmAjMR3G
         rsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsuHRbkrRa7b9vqtRFx6ZxGV0C6hEgdYMQeOpNoVJ0E=;
        b=i5KRbbyXM4b8fWvjw0H24horvCcV5os2M7/Jquy8HHP93/imSkLJqU7dMY/JzujVLF
         3L2oiudVUl4fUpbDHBCsaENb4efk5Nx155avYckqDW1jt2poIkfjMm+dcKfiuWn24ycc
         2IT0OHlD5u4IXkwCj8IxKmHenAyy/uQUkQxiQoi98s94jWvI3gjfWBayPEwNOdmu1lQY
         cwuIvVoW0lc2LP+sG6x1tpVXOgs/LdiAXW7qmb/paXGn68q2UPdt5DeeItEdzSNLxDBH
         y+PHADD3UXFZuVsfqnuxHuE1Ouk4V3ymiiWYGHa1UZsR1JRhm5j7fiVKa8MPle+ZJh4P
         qvxQ==
X-Gm-Message-State: ANhLgQ2sFXQkXu5jOgEO4ZUAZA9EGqkWudfYLeOQyaamwdKa9Rj0jMX/
	k9ndWByhzUpaSMojB8yuKkVIjt32I9X/EIa3aue3YkXh
X-Google-Smtp-Source: ADFU+vvEot3loXp3xfdzaa8/BtiMFgInDf2505MhIro1JIu7WSMtVgkejuDT5W3XzYDu/BNtqWzlHCFs5LvpT08hY6c=
X-Received: by 2002:aca:ef82:: with SMTP id n124mr562802oih.73.1585093900545;
 Tue, 24 Mar 2020 16:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500774067.2088294.1260962550701501447.stgit@dwillia2-desk3.amr.corp.intel.com>
 <27ba42ac-ec08-fd9c-dee2-53414eb0bc58@oracle.com>
In-Reply-To: <27ba42ac-ec08-fd9c-dee2-53414eb0bc58@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 24 Mar 2020 16:51:29 -0700
Message-ID: <CAPcyv4isr2cRXQ2nJtOBaru7ir-GnCdqz=wXH4bytrZpDUpe0Q@mail.gmail.com>
Subject: Re: [PATCH 12/12] device-dax: Introduce 'mapping' devices
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: KXN27KKHUIRQ6OZAOWO3UEOL4H52BDM5
X-Message-ID-Hash: KXN27KKHUIRQ6OZAOWO3UEOL4H52BDM5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@linux.intel.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KXN27KKHUIRQ6OZAOWO3UEOL4H52BDM5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 24, 2020 at 9:28 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/23/20 11:55 PM, Dan Williams wrote:
> > In support of interrogating the physical address layout of a device with
> > dis-contiguous ranges, introduce a sysfs directory with 'start', 'end',
> > and 'page_offset' attributes. The alternative is trying to parse
> > /proc/iomem, and that file will not reflect the extent layout until the
> > device is enabled.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dax/bus.c         |  190 +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/dax/dax-private.h |   14 +++
> >  2 files changed, 202 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 07aeb8fa9ee8..645449a079bd 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -558,6 +558,167 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
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
>             ^^^^^^^^^^^^^^^^^^^^^ perhaps "mapping->range_id < 0" ?
>
> AFAICT, invalid/disabled ranges have id to -1.
>
> Otherwise we can't use mapping0 entry fields.
>

Yes, a gaping hole in the unit test.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

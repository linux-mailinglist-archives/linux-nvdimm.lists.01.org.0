Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0374A21C12C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Jul 2020 02:45:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 370501116894C;
	Fri, 10 Jul 2020 17:45:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E19B61116894B
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 17:45:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so5916857edz.12
        for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 17:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIfMfLrIcR4z15WKttA1evNrYOPo0JXT17THF0rBRHI=;
        b=LoQsRabZHG5ATQdm3coYlG1Zrqchdk/PP7xuyYfANxu+sMXaqUJ70hLILaaT+rFK1I
         YrRpC2IsCfR0psHUbklaxhyUrqA4T/aMv8efT1HSW24iFfeqvPtREByCPauaC4eQJBsp
         CSzC3S+gn9B+HJAjZamlWbVPgAE2OcD+aDlGKFEj5GU/93PRADu4wM/PP3bgi2bH7Z88
         bxe9A8orYs1/RI/p2OWaR4ASDRKh0/cnU2Lz9bv7TM+m2aZE0jzbCRX2lbAK8MtiUWn2
         UdfZcoI64G3Bip7FJcjfi/35SSQ/TUiCY4LaWcMr6a8hZ5UY7sZEL/qYXYNl4Dxn3Xeg
         0WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIfMfLrIcR4z15WKttA1evNrYOPo0JXT17THF0rBRHI=;
        b=eeZdAwwPosYSCIpvvZkyDGCzHp6O54gw+r0Cxuvm0sw3OwOP7ZBpM2kAP8Fh64IqhK
         NvecD+QY4pdRFaoCmZPMuUb2qzSNUXj9pDVtFx/tER10+I9ZMkAOEnDuRira/N/hso/4
         acAAPmxJdTSowj0gxEmi6b0vbT9rWMBMPh6FsR1Zdq5V9J5oOq92eYIGOTUOgpSGYDwb
         E+BGo2yZSius/TX3Zwho5EPlV01lAL7tcIdCYFJFfF0i3aKvgIE+HvHVOmEveqZnjBVI
         +6CWUF8XaW+sLktb2xoLl0nKnXLeXr+sTdIZL5MZh8zRUcPyInTqHU7aWPPO0e5qreST
         u1sw==
X-Gm-Message-State: AOAM531Higtgpb5nBxxTnnSNQ1kwJw+PfT/h8oOrsttg1PsvqPaIdeDd
	WrwPle8N5EB0uVjonczNIr/m+0wpZ9xm3ObwYWOQ7g==
X-Google-Smtp-Source: ABdhPJwpGJfvAKHE4idln3hDFMDRVKJAY4yZCP6ZY9+qFOXeHXc4+TgRZRKzVAwvSYFZvXtpNAWmNrHSO7iiYsqdtlI=
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr79476078edb.296.1594428299892;
 Fri, 10 Jul 2020 17:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <9a6ff83f-095c-0689-d6d1-693a6e9c07e6@oracle.com>
In-Reply-To: <9a6ff83f-095c-0689-d6d1-693a6e9c07e6@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 Jul 2020 17:44:48 -0700
Message-ID: <CAPcyv4ijYVx0C3ocEaT+LB=qxAyy7t0g+yfkhXab5TXQ+s_owA@mail.gmail.com>
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: 5UFE45EE6T5TWCRMTKTOOYPO3ZNGXVU7
X-Message-ID-Hash: 5UFE45EE6T5TWCRMTKTOOYPO3ZNGXVU7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@linux.intel.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5UFE45EE6T5TWCRMTKTOOYPO3ZNGXVU7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 24, 2020 at 9:12 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/23/20 11:55 PM, Dan Williams wrote:
> >  static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >               struct dev_dax *dev_dax, resource_size_t size)
> >  {
> >       resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> > -     resource_size_t dev_size = range_len(&dev_dax->range);
> > +     resource_size_t dev_size = dev_dax_size(dev_dax);
> >       struct resource *region_res = &dax_region->res;
> >       struct device *dev = &dev_dax->dev;
> > -     const char *name = dev_name(dev);
> >       struct resource *res, *first;
> > +     resource_size_t alloc = 0;
> > +     int rc;
> >
> >       if (dev->driver)
> >               return -EBUSY;
> > @@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >        * allocating a new resource.
> >        */
> >       first = region_res->child;
> > -     if (!first)
> > -             return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
> > -                             to_alloc);
>
> You probably want to retain the condition above?
>
> Otherwise it removes the ability to create new devices or resizing it , once we
> have zero-ed the last one.
>
> > -     for (res = first; to_alloc && res; res = res->sibling) {
> > +retry:
> > +     rc = -ENOSPC;
> > +     for (res = first; res; res = res->sibling) {
> >               struct resource *next = res->sibling;
> > -             resource_size_t free;
> >
> >               /* space at the beginning of the region */
> > -             free = 0;
> > -             if (res == first && res->start > dax_region->res.start)
> > -                     free = res->start - dax_region->res.start;
> > -             if (free >= to_alloc && dev_size == 0)
> > -                     return __alloc_dev_dax_range(dev_dax,
> > -                                     dax_region->res.start, to_alloc);
> > -
> > -             free = 0;
> > +             if (res == first && res->start > dax_region->res.start) {
> > +                     alloc = min(res->start - dax_region->res.start,
> > +                                     to_alloc);
> > +                     rc = __alloc_dev_dax_range(dev_dax,
> > +                                     dax_region->res.start, alloc);
> > +                     break;
> > +             }
> > +
> > +             alloc = 0;
> >               /* space between allocations */
> >               if (next && next->start > res->end + 1)
> > -                     free = next->start - res->end + 1;
> > +                     alloc = min(next->start - (res->end + 1), to_alloc);
> >
> >               /* space at the end of the region */
> > -             if (free < to_alloc && !next && res->end < region_res->end)
> > -                     free = region_res->end - res->end;
> > -
> > -             if (free >= to_alloc && strcmp(name, res->name) == 0)
> > -                     return __adjust_dev_dax_range(dev_dax, res,
> > -                                     resource_size(res) + to_alloc);
> > -             else if (free >= to_alloc && dev_size == 0)
> > -                     return __alloc_dev_dax_range(dev_dax, res->end + 1,
> > -                                     to_alloc);
> > +             if (!alloc && !next && res->end < region_res->end)
> > +                     alloc = min(region_res->end - res->end, to_alloc);
> > +
> > +             if (!alloc)
> > +                     continue;
> > +
> > +             if (adjust_ok(dev_dax, res)) {
> > +                     rc = __adjust_dev_dax_range(dev_dax, res,
> > +                                     resource_size(res) + alloc);
> > +                     break;
> > +             }
> > +             rc = __alloc_dev_dax_range(dev_dax, res->end + 1,
> > +                             alloc);
>
> I am wondering if we should switch to:
>
>         if (adjust_ok(...))
>                 rc = __adjust_dev_dax_range(...);
>         else
>                 rc = __alloc_dev_dax_range(...);
>
> And then a debug print at the end depicting whether and how did we grabbed
> space? Something like:
>
>         dev_dbg(&dev_dax->dev, "%s(%d) %d", action, location, rc);
>
> Assuming we set @location to its values when we allocate space at the end,
> beginning or middle; and @action to whether we adjusted up/down or allocated new
> range.
>
> Essentially, something similar to namespaces scan_allocate() just to help
> troubleshoot?

I went ahead and just added "alloc", "extend", "shrink", and "delete
debug prints in the right places.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

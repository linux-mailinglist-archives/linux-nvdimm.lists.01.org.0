Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D8D21C12D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Jul 2020 02:47:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 799AC1116895D;
	Fri, 10 Jul 2020 17:47:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8CEA61116895B
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 17:47:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dr13so7878192ejc.3
        for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 17:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=st0YQO+9N+wj1Bpy5FgTMDvwfrDYYhxnz84DaeIYHvE=;
        b=kf/GijOp8+5lWxfksRaWtI/aKDLLu2C+Ep5A8Zd+Wwap17OxVtPlB7kKxMuBYdHZ56
         1vq9LulHSmENIqlaXFPDdeH3UxCrk9JfnP1zJseaq4tgF0iV2i6jHck+Oee77DpfLhhz
         uZ0ZXokKtNSLsjNyx7s6Ry4SbImB82FRvLQyPfU19WFTXKXoLn7Eie/0jEOrSJDsTrFt
         JnXSoWvT2Kr6IRlk63GWt7W3tLbbsto2BkLE/yDmuKjWIPgJ70M6DQWmLafIsc26e/1c
         VcSMX3uadaPJpPekovYYiousunCLedzS6bZB65zkyg2Sc6aaWdrgHMiIlLhv81TdM7bL
         oW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=st0YQO+9N+wj1Bpy5FgTMDvwfrDYYhxnz84DaeIYHvE=;
        b=Y/77gDSmMJHU2Aen9xHOy4HFvagrP17qnzaN6TyxU/cmw1Szt5emoAdiTrv70qM34c
         z6KRwzNp+1OCa28A5MA1bzD3T0FYGzeUXqeo6kwb92bG8FkrTns785Y+rn+gHAsdTNJe
         LBCxR+OujX3nMunHElY7HfxKUsoUCQbVPCrQR16sG4Y31fyVokZauXKv0/tSZO9/qHik
         2sKvQl3a0PgMq6LGN83gh2fZtwpq0hGCJrWUQKQnMtlUqBu5B0iSdU0c7tX0IX18rRNt
         pouUwl64BuoCrCT1HKCz6l1vu6evC+aQMPkGBErooZrWoky+5kChjxjXqw5pSreig2T/
         t0zA==
X-Gm-Message-State: AOAM530dYchveWEQUM6OBNZagxZzJ+hJBhKCHI9jnca+5mHD25ZuMnEB
	YGkEtfzMuH0v4jaqiAulXm72AM+dvFJrDvsu2WyhLw==
X-Google-Smtp-Source: ABdhPJxKT8AjTlortJSpv1MwycxURB5wVgMFtwFPFUW2XppCLIraO4Bs/8ibaYUjNpKiTvsmpR6qSMA5TwM2NTNsvFQ=
X-Received: by 2002:a17:907:20af:: with SMTP id pw15mr66148379ejb.204.1594428447936;
 Fri, 10 Jul 2020 17:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <23742bb8-831f-29ff-1463-75427eec57c7@oracle.com> <CAPcyv4jvsBSD3SELYn=oj_nvLZ_VgM2YbyswbSEeq5DmkcbXcw@mail.gmail.com>
In-Reply-To: <CAPcyv4jvsBSD3SELYn=oj_nvLZ_VgM2YbyswbSEeq5DmkcbXcw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 Jul 2020 17:47:17 -0700
Message-ID: <CAPcyv4joMJDjaTLSw=HiU_sesWrHoVt07fOuWM44726TpjWCCA@mail.gmail.com>
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: IGHQ7BB577JOES2B4V5MAK5AUXH3YEIS
X-Message-ID-Hash: IGHQ7BB577JOES2B4V5MAK5AUXH3YEIS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@linux.intel.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IGHQ7BB577JOES2B4V5MAK5AUXH3YEIS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 6, 2020 at 1:22 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Apr 6, 2020 at 3:46 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >
> > On 3/23/20 11:55 PM, Dan Williams wrote:
> >
> > [...]
> >
> > >  static ssize_t dev_dax_resize(struct dax_region *dax_region,
> > >               struct dev_dax *dev_dax, resource_size_t size)
> > >  {
> > >       resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> > > -     resource_size_t dev_size = range_len(&dev_dax->range);
> > > +     resource_size_t dev_size = dev_dax_size(dev_dax);
> > >       struct resource *region_res = &dax_region->res;
> > >       struct device *dev = &dev_dax->dev;
> > > -     const char *name = dev_name(dev);
> > >       struct resource *res, *first;
> > > +     resource_size_t alloc = 0;
> > > +     int rc;
> > >
> > >       if (dev->driver)
> > >               return -EBUSY;
> > > @@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
> > >        * allocating a new resource.
> > >        */
> > >       first = region_res->child;
> > > -     if (!first)
> > > -             return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
> > > -                             to_alloc);
> > > -     for (res = first; to_alloc && res; res = res->sibling) {
> > > +retry:
> > > +     rc = -ENOSPC;
> > > +     for (res = first; res; res = res->sibling) {
> > >               struct resource *next = res->sibling;
> > > -             resource_size_t free;
> > >
> > >               /* space at the beginning of the region */
> > > -             free = 0;
> > > -             if (res == first && res->start > dax_region->res.start)
> > > -                     free = res->start - dax_region->res.start;
> > > -             if (free >= to_alloc && dev_size == 0)
> > > -                     return __alloc_dev_dax_range(dev_dax,
> > > -                                     dax_region->res.start, to_alloc);
> > > -
> > > -             free = 0;
> > > +             if (res == first && res->start > dax_region->res.start) {
> > > +                     alloc = min(res->start - dax_region->res.start,
> > > +                                     to_alloc);
> > > +                     rc = __alloc_dev_dax_range(dev_dax,
> > > +                                     dax_region->res.start, alloc);
> >
> > You might be missing:
> >
> >         first = region_res->child;
> >
> > (...) right after returning from __alloc_dev_dax_range(). Alternatively, perhaps
> > even moving the 'retry' label to right before the @first initialization.
> >
> > In the case that you pick space from the beginning, the child resource of the
> > dax region will point to first occupied region, and that changes after you pick
> > this space. So, IIUC, you want to adjust where you start searching free space
> > otherwise you end up wrongly picking that same space twice.
> >
> > If it helps, the bug can be reproduced in this unit test below, see
> > daxctl_test3() test:
>
> It definitely will, thanks. I'll be circling back to this now that
> I've settled my tree for the v5.7 window.

s/v5.7/v5.9/ whats a couple of kernel release cycles between friends?
I went ahead and moved the retry loop above the assignment of first as
you suggested.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

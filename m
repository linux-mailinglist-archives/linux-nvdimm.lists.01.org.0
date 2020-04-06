Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF0E19FEFC
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 Apr 2020 22:23:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8333010FC3C1A;
	Mon,  6 Apr 2020 13:24:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DD95F100B39FA
	for <linux-nvdimm@lists.01.org>; Mon,  6 Apr 2020 13:23:57 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cw6so1120405edb.9
        for <linux-nvdimm@lists.01.org>; Mon, 06 Apr 2020 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39PH+pwpIycTi0BsfN3QezNcOPRNhfwqmeD1bO42FHI=;
        b=re0wkM9Y8K0FkjQlOYTtllVGDKo96zzEV9ijGYRTSuOy69i+w+YnLmP5o40GJpt35d
         id1hpQ7x/EK/kFALbsL9tNzD+6SkS/Vk7I8UkLLjA6NHyxmzdfU0k6F9dHb3Eiyy+jok
         E18GAbSDHu0DAsBxHQd0paCz6sqrKShssxJf9In36mDsiTd1aw+w+YOkQcTzQqwKkpSd
         og/4qTJ341EkMIRECzta+agUB7EVJK0c/mFmjYoRMgxHoP+ySEESE37xSNcO1R2BgqbL
         Fbf4XVj2ywZ2YkHUG6xzQnnc3PHFsmGWn2zp1TMpAQpcERcFithJvKtO7PePdYzBw4ab
         d7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39PH+pwpIycTi0BsfN3QezNcOPRNhfwqmeD1bO42FHI=;
        b=f7WYUGdkwpU79zUewLtprcm26ODKrUmier19LxplhGTO5bIjL8W1Wbx4pv9LTxQAls
         /f/2gDlbtJD/TOihoF9AMxa/5VGkhVmC0QZ6clUcpxI7p1P08FlCQ1jtGWoXGuZEWYgX
         7oCSJ8IRGVGRuwzSkaoU/R+dBig520Do3E4itvdXjxVXgDLx8prr4h5Sos83F+TTNmGs
         EXEVIocJ9zKT4IO5oGR+X4e7PE0IMV7+MH0tXK5XBCjsBpX1QBB6LbjDHfOaq5y4ZBdh
         Ik5qego/Fob51yW7Vow1y0hSSumWFZ0VDrvoSzeDqHoOgCUqnc9lDhqgGlsICixSegRW
         gbyg==
X-Gm-Message-State: AGi0PuZNGJCOeJjYsSRdQHuYXZW6rPtWy9zfCrqJHeiIOFKTunxcK9CE
	rXohcr7lyGSSnicpxAUWUnRjlO1z63whM3dAcDPbEw==
X-Google-Smtp-Source: APiQypLKe5k4sPIdyDlAdrXh1qMjrKzUsMm7i1sTvxIVG8cUt7zm4WnRhiU6r3Bysf7eOs3J7AGGIYYvkaNPjCfcQMI=
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr1160830ejt.123.1586204586068;
 Mon, 06 Apr 2020 13:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <23742bb8-831f-29ff-1463-75427eec57c7@oracle.com>
In-Reply-To: <23742bb8-831f-29ff-1463-75427eec57c7@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 6 Apr 2020 13:22:54 -0700
Message-ID: <CAPcyv4jvsBSD3SELYn=oj_nvLZ_VgM2YbyswbSEeq5DmkcbXcw@mail.gmail.com>
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: OIHNWOJSAH7RS3DLC7CGHTZRH6SNRMD2
X-Message-ID-Hash: OIHNWOJSAH7RS3DLC7CGHTZRH6SNRMD2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@linux.intel.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OIHNWOJSAH7RS3DLC7CGHTZRH6SNRMD2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 6, 2020 at 3:46 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/23/20 11:55 PM, Dan Williams wrote:
>
> [...]
>
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
>
> You might be missing:
>
>         first = region_res->child;
>
> (...) right after returning from __alloc_dev_dax_range(). Alternatively, perhaps
> even moving the 'retry' label to right before the @first initialization.
>
> In the case that you pick space from the beginning, the child resource of the
> dax region will point to first occupied region, and that changes after you pick
> this space. So, IIUC, you want to adjust where you start searching free space
> otherwise you end up wrongly picking that same space twice.
>
> If it helps, the bug can be reproduced in this unit test below, see
> daxctl_test3() test:

It definitely will, thanks. I'll be circling back to this now that
I've settled my tree for the v5.7 window.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

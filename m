Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E91192FC0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Mar 2020 18:49:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1991C10FC36ED;
	Wed, 25 Mar 2020 10:50:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 947FA10FC3635
	for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 10:50:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b18so3645371edu.3
        for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQLg73f4A6IdCvlkz6AAgidHZXBVbjJUTIhnj9QMJq0=;
        b=CArd9H+nUYQo86GgTO34kcf8M/qaGTtxoUap7Zv3rckjuMdaZYN1F6JjgfnWPrmmQD
         STLiZXfm9tTL4tzLvCBpRJ7We2yFE5YuaVYOVylxRmNv+lJGiiAUSyUkCZ2JU2MdAdtK
         /mehUtAxrA6Npr8A1L1muHfUvFvs2COnFJy1ZnrkPpjoNS8yFICdQt3s0xwQfjnwCpbU
         iX04wAD3h9RPqTOKiG6KbgGQ4OF9ezvrMsfHGyNb7m92ahBGPMbYr0/XbX7m2hj1Pebn
         xuQdsVlIEt+LULaBWLDhOZkiim1Sh7F259hWZF0OdyJeF8VkU9WQLChRU/rMYvagJ8Gg
         Gcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQLg73f4A6IdCvlkz6AAgidHZXBVbjJUTIhnj9QMJq0=;
        b=aFmTQ6IeXl9aDy+1KDCO3izQoNymYLM3lJQyhxWyQJDJDO9Cj4AQdxfR2kEFGqWhq0
         7KTdRUfZo5NK/ofgCF8PkFk2u/4zsYfQQ5ITksKu2/PlGQsvkDIfFtq6RxAmc3AvRV03
         TVjBaQKldJA0k3KRYYF1gROCdjJoxsxKjd6KiZes70H0mgAGgDKAVA7Xyesso5D+kSpl
         j/IyIScch99FZnU0uKOk5eSvLIKXuXhRtX20NWy8t6LywyhMkNrzzcrhvMYAC9zrHRxI
         bHOdXDZ9dIdM7yTJRWRMuM4hKiyJeopMWolCBd0FkLv5WjRcdcZCXR9QaxX651NG9mf+
         epMg==
X-Gm-Message-State: ANhLgQ1lzf51uFFRe6KLGGu6sf+UjW6n7uWqLFBSbG+KxpBlP1MJJgEx
	2WmaU7C4E9sn5MLGBZPgoBvGwrk2mbGnPYAbHNYKlg==
X-Google-Smtp-Source: ADFU+vvboEnhuKsKIQb1Icp0tf2ZKIBZhzX0zsyDsXuxXz0SOdiPzd+VaI3b61+gj6WVPFLBvXBLoqtuW6eHq2rVeAE=
X-Received: by 2002:aa7:c609:: with SMTP id h9mr4043188edq.93.1585158550697;
 Wed, 25 Mar 2020 10:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <9a6ff83f-095c-0689-d6d1-693a6e9c07e6@oracle.com> <c673cba2-8749-d63e-f0b2-592ed753481d@oracle.com>
In-Reply-To: <c673cba2-8749-d63e-f0b2-592ed753481d@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 25 Mar 2020 10:48:58 -0700
Message-ID: <CAPcyv4gBQOh9sba+Zbpo6yw3sh9JCKC7Cd10qdNc7d1TvTFfYQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: XX53I46VVYHURQYCIA5G5ERPZX4XAJID
X-Message-ID-Hash: XX53I46VVYHURQYCIA5G5ERPZX4XAJID
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@linux.intel.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XX53I46VVYHURQYCIA5G5ERPZX4XAJID/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 25, 2020 at 3:35 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/24/20 4:12 PM, Joao Martins wrote:
> > On 3/23/20 11:55 PM, Dan Williams wrote:
> >>  static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >>              struct dev_dax *dev_dax, resource_size_t size)
> >>  {
> >>      resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> >> -    resource_size_t dev_size = range_len(&dev_dax->range);
> >> +    resource_size_t dev_size = dev_dax_size(dev_dax);
> >>      struct resource *region_res = &dax_region->res;
> >>      struct device *dev = &dev_dax->dev;
> >> -    const char *name = dev_name(dev);
> >>      struct resource *res, *first;
> >> +    resource_size_t alloc = 0;
> >> +    int rc;
> >>
> >>      if (dev->driver)
> >>              return -EBUSY;
> >> @@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >>       * allocating a new resource.
> >>       */
> >>      first = region_res->child;
> >> -    if (!first)
> >> -            return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
> >> -                            to_alloc);
> >
> > You probably want to retain the condition above?
> >
> > Otherwise it removes the ability to create new devices or resizing it , once we
> > have zero-ed the last one.
> >
>
> A quick unit test that I had stashed here to help explain what I mean:
>
>         cd /sys/bus/dax/devices
>         # dax0.0 is the only dax device in the corresponding dax_region
>         echo dax0.0 > dax0.0/driver/unbind
>         echo 0 > dax0.0/size
>         # Shouldn't fail but returns -ENOSPC despite having
>         # the full region available
>         cat $(readlink -f dax0.0/../dax_region/available_size) > dax0.0/size

Thanks! Will incorporate that test before resending the series.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

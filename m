Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282262DF119
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 19:51:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F1B59100ED4AB;
	Sat, 19 Dec 2020 10:51:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 55B25100ED4A9
	for <linux-nvdimm@lists.01.org>; Sat, 19 Dec 2020 10:51:46 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w1so7948404ejf.11
        for <linux-nvdimm@lists.01.org>; Sat, 19 Dec 2020 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuVtne6NRlRRiqgkJFG1qI8yzmJK7lesysymWow9tUE=;
        b=ZIHZIizsWl7FWuk08wzYrWqKL/gYMOpSQwl/x8+Ax3oAncOGoSb0+gGDkaUa8Yvp5a
         vL5rqi032JLDE2X8luW21yGXkQgAN4IaHj337mHfiTKD19Fxdn0gUBsFXn5PmFEz3Ht9
         zsxrPh5nopKNbwZJylzV/gdsb8J2ubf4iQjDTwTMKeE7q0qtpSU4iCoVKxEVv/jlckf0
         TH37OhLcBRKMfviDNCJuuBKow3fz9uDaYmgUEaDLatO8hxMnIL7DFecQPiLNYVAoDDWX
         Ut0N5qudTrVFc5Fyzqz/3U9U8z7W37VXLbaT2OQwELR8Tu2ium7xfissjw1D0CdeXjps
         E5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuVtne6NRlRRiqgkJFG1qI8yzmJK7lesysymWow9tUE=;
        b=N9MtHCGf+LTd9z/79FnPt//avVzoHPxdUuyZMyWVmN94eKapYSGBJ064FvbvkIZ6jE
         U9oLLccbE/jvsYwsaXrkjiIdgK9lB/TMPE3op8o4A0DrvxpGYOzXlTFkhszACc0wxxG3
         SGiXyVOks1LZ/zCJHJTGyaQtC1QmB0znD8klKDryL9RcybNditBLofp/UR6BvUAyVsP+
         ETPjZktfi8gFlf5f825aK8LQDF/7upbGw9pnZ5cEbTaAGYos0Uw8JnNl638TZC1u4uld
         iDGnnPUcij9n1Mq3Y56osZeaG82YAsoIqm4aSKZHu750/gB6TYtsGdWop9j/kYnOWQ8J
         3m6Q==
X-Gm-Message-State: AOAM531Yu1lKO/CadT6YlXCcWoCoP4ghzepIEYzAqU5CsIPqxJ6/Tegc
	7sfpw9QdzmJVj2aV4/C7mOZ7ZV9PoUsPXSewI2xGTA==
X-Google-Smtp-Source: ABdhPJyklYvoyp5qYAskHotyTgQPw1Kw3ogQgcAvsnO/OPzqFxttZ/Ugp+RxJpMODkeylM7ffPKH6i8tNj9MHPX57F0=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr8981648ejb.264.1608403905093;
 Sat, 19 Dec 2020 10:51:45 -0800 (PST)
MIME-Version: 1.0
References: <160834570161.1791850.14911670304441510419.stgit@dwillia2-desk3.amr.corp.intel.com>
 <a51de4b3-521a-1455-1236-02d813842c8c@huawei.com>
In-Reply-To: <a51de4b3-521a-1455-1236-02d813842c8c@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 19 Dec 2020 10:51:34 -0800
Message-ID: <CAPcyv4htMXC6CP2riTu-mnK2M71B+NPN6K3VeHX-VvA=9da9MQ@mail.gmail.com>
Subject: Re: [PATCH] device-dax: Fix range release
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID-Hash: T4STQCOX6TGAKSHUCEB3GZJSWPWAKRBP
X-Message-ID-Hash: T4STQCOX6TGAKSHUCEB3GZJSWPWAKRBP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T4STQCOX6TGAKSHUCEB3GZJSWPWAKRBP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 18, 2020 at 11:46 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/12/19 10:41, Dan Williams wrote:
> > There are multiple locations that open-code the release of the last
> > range in a device-dax instance. Consolidate this into a new
> > dev_dax_trim_range() helper.
> >
> > This also addresses a kmemleak report:
> >
> > # cat /sys/kernel/debug/kmemleak
> > [..]
> > unreferenced object 0xffff976bd46f6240 (size 64):
> >    comm "ndctl", pid 23556, jiffies 4299514316 (age 5406.733s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 00 00 00 00 00 00 20 c3 37 00 00 00  .......... .7...
> >      ff ff ff 7f 38 00 00 00 00 00 00 00 00 00 00 00  ....8...........
> >    backtrace:
> >      [<00000000064003cf>] __kmalloc_track_caller+0x136/0x379
> >      [<00000000d85e3c52>] krealloc+0x67/0x92
> >      [<00000000d7d3ba8a>] __alloc_dev_dax_range+0x73/0x25c
> >      [<0000000027d58626>] devm_create_dev_dax+0x27d/0x416
> >      [<00000000434abd43>] __dax_pmem_probe+0x1c9/0x1000 [dax_pmem_core]
> >      [<0000000083726c1c>] dax_pmem_probe+0x10/0x1f [dax_pmem]
> >      [<00000000b5f2319c>] nvdimm_bus_probe+0x9d/0x340 [libnvdimm]
> >      [<00000000c055e544>] really_probe+0x230/0x48d
> >      [<000000006cabd38e>] driver_probe_device+0x122/0x13b
> >      [<0000000029c7b95a>] device_driver_attach+0x5b/0x60
> >      [<0000000053e5659b>] bind_store+0xb7/0xc3
> >      [<00000000d3bdaadc>] drv_attr_store+0x27/0x31
> >      [<00000000949069c5>] sysfs_kf_write+0x4a/0x57
> >      [<000000004a8b5adf>] kernfs_fop_write+0x150/0x1e5
> >      [<00000000bded60f0>] __vfs_write+0x1b/0x34
> >      [<00000000b92900f0>] vfs_write+0xd8/0x1d1
> >
> > Reported-by: Jane Chu <jane.chu@oracle.com>
> > Cc: Zhen Lei <thunder.leizhen@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dax/bus.c |   44 +++++++++++++++++++++-----------------------
> >  1 file changed, 21 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 9761cb40d4bb..720cd140209f 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -367,19 +367,28 @@ void kill_dev_dax(struct dev_dax *dev_dax)
> >  }
> >  EXPORT_SYMBOL_GPL(kill_dev_dax);
> >
> > -static void free_dev_dax_ranges(struct dev_dax *dev_dax)
> > +static void trim_dev_dax_range(struct dev_dax *dev_dax)
> >  {
> > +     int i = dev_dax->nr_range - 1;
> > +     struct range *range = &dev_dax->ranges[i].range;
> >       struct dax_region *dax_region = dev_dax->region;
> > -     int i;
> >
> >       device_lock_assert(dax_region->dev);
> > -     for (i = 0; i < dev_dax->nr_range; i++) {
> > -             struct range *range = &dev_dax->ranges[i].range;
> > -
> > -             __release_region(&dax_region->res, range->start,
> > -                             range_len(range));
> > +     dev_dbg(&dev_dax->dev, "delete range[%d]: %#llx:%#llx\n", i,
> > +             (unsigned long long)range->start,
> > +             (unsigned long long)range->end);
> > +
> > +     __release_region(&dax_region->res, range->start, range_len(range));
> > +     if (--dev_dax->nr_range == 0) {
> > +             kfree(dev_dax->ranges);
> > +             dev_dax->ranges = NULL;
> >       }
> > -     dev_dax->nr_range = 0;
> > +}
> > +
> > +static void free_dev_dax_ranges(struct dev_dax *dev_dax)
> > +{
> > +     while (dev_dax->nr_range)
> It's better to use READ_ONCE to get the value of dev_dax->nr_range,
> to prevent compiler optimization.

...only in the case where the compiler might try to turn this into an
infinite loop, but I don't think that can happen here outside of a
compiler bug. Usually READ_ONCE() is contending with SMP effects that
the compiler can't see.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

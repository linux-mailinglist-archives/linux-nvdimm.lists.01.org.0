Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 702901933CA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Mar 2020 23:33:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 26B2110FC3629;
	Wed, 25 Mar 2020 15:33:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2C6DC10FC3607
	for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 15:33:52 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w26so4668523edu.7
        for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVCDmOk9HhsK80T8G7kVWe7YwLFbt+hHKP5is8X15Cc=;
        b=Uz8DEE88kRzzlSo4K0/OS7d3QvShBzx8HCRAWRfFe86MgzpfXcGq4vfKh+thh+jIPi
         K4h9SugnX3zdr7Ii7b7l/KQGZtYNZOw6oWMeH6ZeSBcOMk4d4OygCHTfs1O+k2n02G/8
         joLcuTcHQPoPmJAJx5kEpjdQx5HKQAYiCfWBAbwKccHw84BEeoGTocnCXCrAhvD8yB/z
         Bk5rdPvWZEs5LN4XInM9Ymu02ybdM5uJo95e1CWnrA2wmEw9oTJuIpYp9Z11P2wM1gWv
         ko1EP+wlPrH+M277pSdHqW9rXfxdPgt6KD1xRlrkK+l5fvbEKpnm9HjwFk+o/f4yXTdZ
         4zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVCDmOk9HhsK80T8G7kVWe7YwLFbt+hHKP5is8X15Cc=;
        b=BGbIAvc6X0EcmXK92dIF3OVja4sMHnwJ/51L1XHNrFOqJsc7/5kWvnMFuHPZhBuytw
         b+0oNa3BAmQ8lrYW0T2xx29OBPR/BYF6vYU0u4PXzS0hIDAIXLbHGlWlrDXGGdje96Vs
         zbPIHBXD7tPB90f5ZnP5ZxPf7+RQenFomjW+uBb9ZWbSNloSFtqonYGV9YlFri4+9YsI
         egVrGMhfyOQCweq6h1Vub0SnoIXtEkcCZ1jLadwsaElDzvc2l6gNm6oQLG9zghrpKW3S
         4kWv9fDWV6RIiZbnXC2gKxIcHUVzv9UH22XwQGB0yPuPvTG42Ifk5xzTOuRQLT96Qa9l
         3QfQ==
X-Gm-Message-State: ANhLgQ3CzQMKdl3nOxkuZzYB8lOrAkMAuCdB6h3WqYeS3dkDVzHrMIOp
	3gxm09r6T9t7EkqH0tYVnykfzsNNiFxmxenBH+//5A==
X-Google-Smtp-Source: ADFU+vsCqAXZsXgnDkYvOWG3bR2wDWzsJ5qsWPjBfCL32pSGSnNmuWvylskZFSFSIbomy5pt3613yJZfFce1FytIomA=
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr5155925ejt.123.1585175579794;
 Wed, 25 Mar 2020 15:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158489356692.1457606.1858427908360761594.stgit@dwillia2-desk3.amr.corp.intel.com>
 <f964eb62-5bc9-7e85-5c44-9027a6c08d4c@oracle.com> <CAPcyv4hgExDoKZg7QQ9JRkPEY2N56EjLgLQ2Q19tu3vnUdPqgA@mail.gmail.com>
In-Reply-To: <CAPcyv4hgExDoKZg7QQ9JRkPEY2N56EjLgLQ2Q19tu3vnUdPqgA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 25 Mar 2020 15:32:48 -0700
Message-ID: <CAPcyv4gjTmZuvqkV_r3_FuGrjK=a-CVGOnLEDZ0Fpiyg2h_Lag@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ACPI: HMAT: Refactor hmat_register_target_device
 to hmem_register_device
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: ZXM6FQEZTHZCMCJTVVSMQIUOBFQ5Q5XK
X-Message-ID-Hash: ZXM6FQEZTHZCMCJTVVSMQIUOBFQ5Q5XK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZXM6FQEZTHZCMCJTVVSMQIUOBFQ5Q5XK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 24, 2020 at 2:04 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Mar 24, 2020 at 12:41 PM Joao Martins <joao.m.martins@oracle.com> wrote:
> >
> >
> > On 3/22/20 4:12 PM, Dan Williams wrote:
> > > In preparation for exposing "Soft Reserved" memory ranges without an
> > > HMAT, move the hmem device registration to its own compilation unit and
> > > make the implementation generic.
> > >
> > > The generic implementation drops usage acpi_map_pxm_to_online_node()
> > > that was translating ACPI proximity domain values and instead relies on
> > > numa_map_to_online_node() to determine the numa node for the device.
> > >
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Link: https://lore.kernel.org/r/158318761484.2216124.2049322072599482736.stgit@dwillia2-desk3.amr.corp.intel.com
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/acpi/numa/hmat.c  |   68 ++++-----------------------------------------
> > >  drivers/dax/Kconfig       |    4 +++
> > >  drivers/dax/Makefile      |    3 +-
> > >  drivers/dax/hmem.c        |   56 -------------------------------------
> > >  drivers/dax/hmem/Makefile |    5 +++
> > >  drivers/dax/hmem/device.c |   64 ++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/dax/hmem/hmem.c   |   56 +++++++++++++++++++++++++++++++++++++
> > >  include/linux/dax.h       |    8 +++++
> > >  8 files changed, 144 insertions(+), 120 deletions(-)
> > >  delete mode 100644 drivers/dax/hmem.c
> > >  create mode 100644 drivers/dax/hmem/Makefile
> > >  create mode 100644 drivers/dax/hmem/device.c
> > >  create mode 100644 drivers/dax/hmem/hmem.c
> > >
> > > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > > index a12e36a12618..134bcb40b2af 100644
> > > --- a/drivers/acpi/numa/hmat.c
> > > +++ b/drivers/acpi/numa/hmat.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/node.h>
> > >  #include <linux/sysfs.h>
> > > +#include <linux/dax.h>
> > >
> > >  static u8 hmat_revision;
> > >  static int hmat_disable __initdata;
> > > @@ -640,66 +641,6 @@ static void hmat_register_target_perf(struct memory_target *target)
> > >       node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
> > >  }
> > >
> > > -static void hmat_register_target_device(struct memory_target *target,
> >           ^^^^ int ?
> >
> > > -             struct resource *r)
> > > -{
> > > -     /* define a clean / non-busy resource for the platform device */
> > > -     struct resource res = {
> > > -             .start = r->start,
> > > -             .end = r->end,
> > > -             .flags = IORESOURCE_MEM,
> > > -     };
> > > -     struct platform_device *pdev;
> > > -     struct memregion_info info;
> > > -     int rc, id;
> > > -
> > > -     rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
> > > -                     IORES_DESC_SOFT_RESERVED);
> > > -     if (rc != REGION_INTERSECTS)
> > > -             return;
> >                 ^ return -ENXIO;
> >
> > > -
> > > -     id = memregion_alloc(GFP_KERNEL);
> > > -     if (id < 0) {
> > > -             pr_err("memregion allocation failure for %pr\n", &res);
> > > -             return;
> >                 ^ return -ENOMEM;
> >
> > > -     }
> > > -
> > > -     pdev = platform_device_alloc("hmem", id);
> > > -     if (!pdev) {
> >
> >                 rc = -ENOMEM;
> >
> > > -             pr_err("hmem device allocation failure for %pr\n", &res);
> > > -             goto out_pdev;
> > > -     }
> > > -
> > > -     pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
> > > -     info = (struct memregion_info) {
> > > -             .target_node = acpi_map_pxm_to_node(target->memory_pxm),
> > > -     };
> > > -     rc = platform_device_add_data(pdev, &info, sizeof(info));
> > > -     if (rc < 0) {
> > > -             pr_err("hmem memregion_info allocation failure for %pr\n", &res);
> > > -             goto out_pdev;
> > > -     }
> > > -
> > > -     rc = platform_device_add_resources(pdev, &res, 1);
> > > -     if (rc < 0) {
> > > -             pr_err("hmem resource allocation failure for %pr\n", &res);
> > > -             goto out_resource;
> > > -     }
> > > -
> > > -     rc = platform_device_add(pdev);
> > > -     if (rc < 0) {
> > > -             dev_err(&pdev->dev, "device add failed for %pr\n", &res);
> > > -             goto out_resource;
> > > -     }
> > > -
> > > -     return;
> >         ^^^^^^ return 0;
> > > -
> > > -out_resource:
> > > -     put_device(&pdev->dev);
> > > -out_pdev:
> > > -     memregion_free(id);
> >
> >         return rc;
> >
> > > -}
> > > -
> > >  static void hmat_register_target_devices(struct memory_target *target)
> > >  {
> > >       struct resource *res;
> > > @@ -711,8 +652,11 @@ static void hmat_register_target_devices(struct memory_target *target)
> > >       if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
> > >               return;
> > >
> > > -     for (res = target->memregions.child; res; res = res->sibling)
> > > -             hmat_register_target_device(target, res);
> > > +     for (res = target->memregions.child; res; res = res->sibling) {
> > > +             int target_nid = acpi_map_pxm_to_node(target->memory_pxm);
> > > +
> > > +             hmem_register_device(target_nid, res);
> > > +     }
> > >  }
> > >
> >
> > If it makes sense to propagate error to hmem_register_device (as noted above),
> > then here perhaps a pr_err() if hmem registration fails mainly for reporting
> > purposes?
>
> Yeah, I guess it makes sense to at least log that something went wrong
> if someone wonders where their memory device went. I'll add that
> rework as a follow-on.

Now that I look again hmat_register_target_device() already has
multiple pr_err() indicating that something went wrong. The error code
would not go anywhere useful.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

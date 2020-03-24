Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E03191BAD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 22:07:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0F2610FC3192;
	Tue, 24 Mar 2020 14:07:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 98F541007B8F8
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 14:07:54 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k18so58121oib.3
        for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upl2vPR8qJWq0P3veNASLF2x9fKiteylDIqdLD2DSM4=;
        b=ptpy7rs5mB6uI4afsGX5d/xHC6v7jmwoP62AcU7hxqL8oy2KD1VBx8vnzGN1Z/YTu9
         eQ2RSUwJ8nwlwFEdQaeBQML+Iairvcj1+qqNWJRo8jkY6k8tyFkYrc6Y/cP8aez8cl6K
         hwoPHaoibOwKdsohj+wZ+OwahZk2LbNJbzWMs9Ydj33jMr+HkVS/L5JZWugDUnywZrBP
         KTt9kpWf6BW8M03A4JP8SwzRz5ntebA8IUbxg+tqsU6koNGEeAi3UMY/3t7BT2/9+2EC
         MxHJuiEganu/DEyTeou3e77JmKbYjRNYEMiesXx+7UTQk6Li+EpZgi/Qw+zSXEQRCbVl
         hoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upl2vPR8qJWq0P3veNASLF2x9fKiteylDIqdLD2DSM4=;
        b=rURvFCnTPJQLCBrUXUTt4ZhaVtT0YA23rq3MRtMgKfU0kUFHCzCp1d8xu7OWTydALU
         QaujmwkFi1V7xpP7b1tVQ0hghJwhvYqjLhRwDV4SfIv33Ik/sWOzkrbCRkpPW3a2jL9n
         0qWW3y3YU/sj71IpRkpyw2AAXKspLY/fu2zotKHTefUH3PrS7Tke6ma3eLx287lX/cNk
         9iYwx/w8blRxVukiRIp5WE35Um0RxbCwXwrzCmaBvDFos6jAvKv5gTLHmzk2ADNqgy+c
         0ap2wQ/MqWBL29X/Jb7KlsaoF9VrhVvduQat+Cg5BzJaG9L5+fL4ybiBtZiithlf7Q/B
         4cSQ==
X-Gm-Message-State: ANhLgQ1vP+/t6FOlWLnO1OtKGCGH3yAezhfTk64QX1jg0PbHZ4fvbBUI
	F2VSsHqcGTLDQa3XlndKNoOU9FXZHukp+I08H3NKpw==
X-Google-Smtp-Source: ADFU+vuuDTsX06lZ5QDww1C30E0693xGC6g3aELOAtPsdQe2suA+4qwGyRU1gvFT4j93s/mxQFsdDqEm0rp7qk9yuRQ=
X-Received: by 2002:a05:6808:b0f:: with SMTP id s15mr151586oij.105.1585084023289;
 Tue, 24 Mar 2020 14:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158489357825.1457606.17352509511987748598.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e9d36833-6606-da13-9dda-47abc1928273@oracle.com>
In-Reply-To: <e9d36833-6606-da13-9dda-47abc1928273@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 24 Mar 2020 14:06:52 -0700
Message-ID: <CAPcyv4iyfP88KXaK4VbaUgFWRjsRutdFF8OH7nwT-zUiv3fV7Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ACPI: HMAT: Attach a device for each soft-reserved range
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: S6PEIP7DC7XZXNL5ZIUZCEGSIR72QEIO
X-Message-ID-Hash: S6PEIP7DC7XZXNL5ZIUZCEGSIR72QEIO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Brice Goglin <Brice.Goglin@inria.fr>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S6PEIP7DC7XZXNL5ZIUZCEGSIR72QEIO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 24, 2020 at 12:41 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/22/20 4:12 PM, Dan Williams wrote:
> > The hmem enabling in commit 'cf8741ac57ed ("ACPI: NUMA: HMAT: Register
> > "soft reserved" memory as an "hmem" device")' only registered ranges to
> > the hmem driver for each soft-reservation that also appeared in the
> > HMAT. While this is meant to encourage platform firmware to "do the
> > right thing" and publish an HMAT, the corollary is that platforms that
> > fail to publish an accurate HMAT will strand memory from Linux usage.
> > Additionally, the "efi_fake_mem" kernel command line option enabling
> > will strand memory by default without an HMAT.
> >
> > Arrange for "soft reserved" memory that goes unclaimed by HMAT entries
> > to be published as raw resource ranges for the hmem driver to consume.
> >
> > Include a module parameter to disable either this fallback behavior, or
> > the hmat enabling from creating hmem devices. The module parameter
> > requires the hmem device enabling to have unique name in the module
> > namespace: "device_hmem".
> >
> > Rather than mark this x86-only, include an interim phys_to_target_node()
> > implementation for arm64.
> >
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Brice Goglin <Brice.Goglin@inria.fr>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Jeff Moyer <jmoyer@redhat.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/arm64/mm/numa.c      |   13 +++++++++++++
> >  drivers/dax/Kconfig       |    1 +
> >  drivers/dax/hmem/Makefile |    3 ++-
> >  drivers/dax/hmem/device.c |   33 +++++++++++++++++++++++++++++++++
> >  4 files changed, 49 insertions(+), 1 deletion(-)
> >
>
> [...]
>
> > diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> > index 99bc15a8b031..f9c5fa8b1880 100644
> > --- a/drivers/dax/hmem/device.c
> > +++ b/drivers/dax/hmem/device.c
> > @@ -4,6 +4,9 @@
> >  #include <linux/module.h>
> >  #include <linux/mm.h>
> >
> > +static bool nohmem;
> > +module_param_named(disable, nohmem, bool, 0444);
> > +
> >  void hmem_register_device(int target_nid, struct resource *r)
> >  {
> >       /* define a clean / non-busy resource for the platform device */
> > @@ -16,6 +19,9 @@ void hmem_register_device(int target_nid, struct resource *r)
> >       struct memregion_info info;
> >       int rc, id;
> >
> > +     if (nohmem)
> > +             return;
> > +
> >       rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
> >                       IORES_DESC_SOFT_RESERVED);
> >       if (rc != REGION_INTERSECTS)
> > @@ -62,3 +68,30 @@ void hmem_register_device(int target_nid, struct resource *r)
> >  out_pdev:
> >       memregion_free(id);
> >  }
> > +
> > +static __init int hmem_register_one(struct resource *res, void *data)
> > +{
> > +     /*
> > +      * If the resource is not a top-level resource it was already
> > +      * assigned to a device by the HMAT parsing.
> > +      */
> > +     if (res->parent != &iomem_resource)
> > +             return 0;
> > +
> > +     hmem_register_device(phys_to_target_node(res->start), res);
> > +
> > +     return 0;
>
> Should we add an error returning value to hmem_register_device() perhaps this
> ought to be reflected in hmem_register_one().
>
> > +}
> > +
> > +static __init int hmem_init(void)
> > +{
> > +     walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> > +                     IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
> > +     return 0;
> > +}
> > +
>
> (...) and then perhaps here returning in the initcall if any of the resources
> failed hmem registration?

Except that hmem_register_one() is a stop-gap to collect soft-reserved
ranges that were not already registered, and it's not an error to find
already registered devices. However, I do think it's a good idea to
log registrations that failed for other reasons.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

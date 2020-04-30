Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB21BF253
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 10:12:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 736F2111B0D35;
	Thu, 30 Apr 2020 01:10:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D6AE811152E32
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 01:10:57 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nv1so3958268ejb.0
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPyH7cBulXkr69UeTYsLw8J8jsMaQ8KU1AV45QxO0GM=;
        b=aRdqN+obvpVV2A+fgMLJy4RekybxRVDiG7lp8OF4bnZx2Ywvd3iCU/W+kNS4ZeZMFO
         s2KHcqmsaIITIji0juOY7H6rW7Fc6dWrzMOI3EIosswh9jq3YYccKaX2xhcXTvz1nd5V
         aBV+pihhUiUdyrUO5BWYQElkaX6/osTUoFcDUd3gIMpaDgbgaWZ7XiKQfHXqUsjsTevr
         xcbBoOAzO8ZeJrHgjs2FlN5xkisQM2/NaUdROIGlFFS2pMP9xFv8klIZrmKxkYMDnngC
         ZkScurbP2qpL3FH2QS0j799ldY6mMF4VeS1bCDMrE9KedwDuMF2flKOw3iR6FucwjAe8
         uO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPyH7cBulXkr69UeTYsLw8J8jsMaQ8KU1AV45QxO0GM=;
        b=bgDKS667biCCXQcUQgUzl7sRq1sQ3sTd2+CWehdYDiBr8OMF7nCm23GYBahFdW4pJm
         5ZXE+6tyDZGeh/9kHWleTHBVC32tXmktrz27NROtwAylBmyXKyRZV9TmtxqMvV+TYFZx
         hA0+SKCjZKNLu9cf0w2GzhjCS0LIfC9KHjicuHI9varONKIQwpCt4Vx9wevM8s5rR7U6
         wCSXTytstR7syECdTzQ0BK88AxmxfYQux5nW3R+FOykMsE3ZlTDcxAqlre8VyOER16G1
         EabgxbVh2Gha5aR3NqfY4uqUW0k+0rP2Lz0G0P6ipO8PdVtyeYMSWwcNqOgReRybbntm
         c6lg==
X-Gm-Message-State: AGi0PuZwZt7mTYnszES0aKSOUwZEXPjGRnftL2M0xCTAxSN8Xn7tNSSQ
	42GqWeCX/a1uEP5XGMAYjdGsImEixFNT/0LGeWYjOg==
X-Google-Smtp-Source: APiQypKwCBG4S6M4oBR8TWLxl5ZHi3zkP+L9vXXaCbuE040rlsosdGPooBbFU8EQOuJGeo1PTMYPgjG4Ewt4MDGe5kI=
X-Received: by 2002:a17:906:7750:: with SMTP id o16mr1646531ejn.12.1588234325407;
 Thu, 30 Apr 2020 01:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200429160803.109056-1-david@redhat.com> <20200429160803.109056-3-david@redhat.com>
 <a7305cd8-8b2f-1d8f-7654-ecf777c46df6@redhat.com>
In-Reply-To: <a7305cd8-8b2f-1d8f-7654-ecf777c46df6@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Apr 2020 01:11:54 -0700
Message-ID: <CAPcyv4i04+QLxiOyz04_eef2DFetEFKBUmi2A4xxw9abQD8hNQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: Introduce MHP_DRIVER_MANAGED
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: I2AZAG3AADWN765KZROYN4MB7Z45KF2Q
X-Message-ID-Hash: I2AZAG3AADWN765KZROYN4MB7Z45KF2Q
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-hyperv@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I2AZAG3AADWN765KZROYN4MB7Z45KF2Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 12:20 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 29.04.20 18:08, David Hildenbrand wrote:
> > Some paravirtualized devices that add memory via add_memory() and
> > friends (esp. virtio-mem) don't want to create entries in
> > /sys/firmware/memmap/ - primarily to hinder kexec from adding this
> > memory to the boot memmap of the kexec kernel.
> >
> > In fact, such memory is never exposed via the firmware (e.g., e820), but
> > only via the device, so exposing this memory via /sys/firmware/memmap/ is
> > wrong:
> >  "kexec needs the raw firmware-provided memory map to setup the
> >   parameter segment of the kernel that should be booted with
> >   kexec. Also, the raw memory map is useful for debugging. For
> >   that reason, /sys/firmware/memmap is an interface that provides
> >   the raw memory map to userspace." [1]
> >
> > We want to let user space know that memory which is always detected,
> > added, and managed via a (device) driver - like memory managed by
> > virtio-mem - is special. It cannot be used for placing kexec segments
> > and the (device) driver is responsible for re-adding memory that
> > (eventually shrunk/grown/defragmented) memory after a reboot/kexec. It
> > should e.g., not be added to a fixed up firmware memmap. However, it should
> > be dumped by kdump.
> >
> > Also, such memory could behave differently than an ordinary DIMM - e.g.,
> > memory managed by virtio-mem can have holes inside added memory resource,
> > which should not be touched, especially for writing.
> >
> > Let's expose that memory as "System RAM (driver managed)" e.g., via
> > /pro/iomem.
> >
> > We don't have to worry about firmware_map_remove() on the removal path.
> > If there is no entry, it will simply return with -EINVAL.
> >
> > [1] https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmware-memmap
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > Cc: Wei Yang <richard.weiyang@gmail.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  include/linux/memory_hotplug.h |  8 ++++++++
> >  mm/memory_hotplug.c            | 20 ++++++++++++++++----
> >  2 files changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index bf0e3edb8688..cc538584b39e 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -68,6 +68,14 @@ struct mhp_params {
> >       pgprot_t pgprot;
> >  };
> >
> > +/* Flags used for add_memory() and friends. */
> > +
> > +/*
> > + * Don't create entries in /sys/firmware/memmap/ and expose memory as
> > + * "System RAM (driver managed)" in e.g., /proc/iomem
> > + */
> > +#define MHP_DRIVER_MANAGED           1
> > +
> >  /*
> >   * Zone resizing functions
> >   *
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index ebdf6541d074..cfa0721280aa 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -98,11 +98,11 @@ void mem_hotplug_done(void)
> >  u64 max_mem_size = U64_MAX;
> >
> >  /* add this memory to iomem resource */
> > -static struct resource *register_memory_resource(u64 start, u64 size)
> > +static struct resource *register_memory_resource(u64 start, u64 size,
> > +                                              const char *resource_name)
> >  {
> >       struct resource *res;
> >       unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > -     char *resource_name = "System RAM";
> >
> >       /*
> >        * Make sure value parsed from 'mem=' only restricts memory adding
> > @@ -1058,7 +1058,8 @@ int __ref add_memory_resource(int nid, struct resource *res,
> >       BUG_ON(ret);
> >
> >       /* create new memmap entry */
> > -     firmware_map_add_hotplug(start, start + size, "System RAM");
> > +     if (!(flags & MHP_DRIVER_MANAGED))
> > +             firmware_map_add_hotplug(start, start + size, "System RAM");
> >
> >       /* device_online() will take the lock when calling online_pages() */
> >       mem_hotplug_done();
> > @@ -1081,10 +1082,21 @@ int __ref add_memory_resource(int nid, struct resource *res,
> >  /* requires device_hotplug_lock, see add_memory_resource() */
> >  int __ref __add_memory(int nid, u64 start, u64 size, unsigned long flags)
> >  {
> > +     const char *resource_name = "System RAM";
> >       struct resource *res;
> >       int ret;
> >
> > -     res = register_memory_resource(start, size);
> > +     /*
> > +      * Indicate that memory managed by a driver is special. It's always
> > +      * detected and added via a driver, should not be given to the kexec
> > +      * kernel for booting when manually crafting the firmware memmap, and
> > +      * no kexec segments should be placed on it. However, kdump should
> > +      * dump this memory.
> > +      */
> > +     if (flags & MHP_DRIVER_MANAGED)
> > +             resource_name = "System RAM (driver managed)";
> > +
> > +     res = register_memory_resource(start, size, resource_name);
> >       if (IS_ERR(res))
> >               return PTR_ERR(res);
> >
> >
>
> BTW, I was wondering if this is actually also something that
> drivers/dax/kmem.c wants to use for adding memory.
>
> Just because we decided to use some DAX memory in the current kernel as
> system ram, doesn't mean we should make that decision for the kexec
> kernel (e.g., using it as initial memory, placing kexec binaries onto
> it, etc.). This is also not what we would observe during a real reboot.

Agree.

> I can see that the "System RAM" resource will show up as child resource
> under the device e.g., in /proc/iomem.
>
> However, entries in /sys/firmware/memmap/ are created as "System RAM".

True. Do you think this rename should just be limited to what type
/sys/firmware/memmap/ emits? I have the concern, but no proof
currently, that there are /proc/iomem walkers that explicitly look for
"System RAM", but might be thrown off by "System RAM (driver
managed)". I was not aware of /sys/firmware/memmap until about 5
minutes ago.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

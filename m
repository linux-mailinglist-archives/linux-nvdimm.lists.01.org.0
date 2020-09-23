Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 137BE276347
	for <lists+linux-nvdimm@lfdr.de>; Wed, 23 Sep 2020 23:42:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 14090152121DA;
	Wed, 23 Sep 2020 14:42:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 82387152121D6
	for <linux-nvdimm@lists.01.org>; Wed, 23 Sep 2020 14:41:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so1677944eja.2
        for <linux-nvdimm@lists.01.org>; Wed, 23 Sep 2020 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4h/RkUUdwjIPqFz1gTT0y7JkCLow5mQtN0rQpacgcms=;
        b=JCni4lxaiZYVrmErS1js3kV9RMqH+yMaUhmxSb2biXg+NxceGuRWwUcjOUYKvuk4EF
         i7h8djcftPLdWtyW2ZCTbvztQ2QkGV6hyZuyfd+DrsvP0SavOfFcmzLqPgWjao/niJN8
         xTPjeAdMq/cqzGM7k0A1RxUyzDcgH4Dl0C4KVxc3b7dANp170gJ0fxC5DutOMdDoe+nk
         wbKwwsTK5gjqSxLEgy64cPvZzJgRmLx6s6uHvM2IFtebLaRY7B8kgLv0WAqOQj+ADboE
         k/4GYgwXtFFHnQCLp+2XvzJUrtAsOR/+uhlobUfdAfpr9276v1bCYVoP8QbQQyb16alu
         2x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4h/RkUUdwjIPqFz1gTT0y7JkCLow5mQtN0rQpacgcms=;
        b=U27uif9yH7jcqKE+uCXlTN9xB7BDYPqgFV9+hr5Ud746lQJ19HruT2K6tGP/LQ35d6
         +aCBDjZiLWc7v20FNCtlsJQasnY8MjYd0U+rfKX8DcEQGOWR8g1/ZE4hb4TCGHQpQn8M
         ESNb7GF0hWPPOtGPv2W++b7t+XoPhU1Df/3ypUJKyVMZC9orYrD/vjkFEXM/XJ/fWIS9
         jCjKOgsYUkaEKj/etahNvagenwWoq8s+1pew3COJZ9PLRcDnNvj6QZp/u6ZM3UHk1OJi
         Cll2LwpNRADHYjbt9yX3D8MklY/nz8IlwkAzA7Dn6ODqZBVO9atnGW0bYy37BCCF6p/e
         ferw==
X-Gm-Message-State: AOAM531CdrGEP+DwZ5bFIo2OpR/KHsmICcmCWgifEYux3i9o1WMDXp6j
	lmyOE39OImaaFYjPcaA4ek6B+EhlJOUjOjE2lWfgfw==
X-Google-Smtp-Source: ABdhPJwhmaJTy+DwDRpY4gTDZ5tj7/qFfAQYU5pGD1zHam4Ng3Y7EU7X2pGbjv+OHeoNHevly5P95IKLkFku3R9OLDU=
X-Received: by 2002:a17:906:8289:: with SMTP id h9mr1597984ejx.45.1600897317154;
 Wed, 23 Sep 2020 14:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159643100485.4062302.976628339798536960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <a3ad70a2-77a8-d50e-f372-731a8e27c03b@redhat.com> <17686fcc-202e-0982-d0de-54d5349cfb5d@oracle.com>
 <9acc6148-72eb-7016-dba9-46fa87ded5a5@redhat.com>
In-Reply-To: <9acc6148-72eb-7016-dba9-46fa87ded5a5@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 23 Sep 2020 14:41:45 -0700
Message-ID: <CAPcyv4h5GGV3F-0rFY_pyv9Bj8LAkrwXruxGE=K2y9=dA8oDHw@mail.gmail.com>
Subject: Re: [PATCH v4 11/23] device-dax: Kill dax_kmem_res
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: B7DUO2QMXKCG7CELLETYLDSKI5G5Z7F3
X-Message-ID-Hash: B7DUO2QMXKCG7CELLETYLDSKI5G5Z7F3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B7DUO2QMXKCG7CELLETYLDSKI5G5Z7F3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 23, 2020 at 1:04 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.09.20 17:33, Joao Martins wrote:
> > [Sorry for the late response]
> >
> > On 8/21/20 11:06 AM, David Hildenbrand wrote:
> >> On 03.08.20 07:03, Dan Williams wrote:
> >>> @@ -37,109 +45,94 @@ int dev_dax_kmem_probe(struct device *dev)
> >>>      * could be mixed in a node with faster memory, causing
> >>>      * unavoidable performance issues.
> >>>      */
> >>> -   numa_node = dev_dax->target_node;
> >>>     if (numa_node < 0) {
> >>>             dev_warn(dev, "rejecting DAX region with invalid node: %d\n",
> >>>                             numa_node);
> >>>             return -EINVAL;
> >>>     }
> >>>
> >>> -   /* Hotplug starting at the beginning of the next block: */
> >>> -   kmem_start = ALIGN(range->start, memory_block_size_bytes());
> >>> -
> >>> -   kmem_size = range_len(range);
> >>> -   /* Adjust the size down to compensate for moving up kmem_start: */
> >>> -   kmem_size -= kmem_start - range->start;
> >>> -   /* Align the size down to cover only complete blocks: */
> >>> -   kmem_size &= ~(memory_block_size_bytes() - 1);
> >>> -   kmem_end = kmem_start + kmem_size;
> >>> -
> >>> -   new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
> >>> -   if (!new_res_name)
> >>> +   res_name = kstrdup(dev_name(dev), GFP_KERNEL);
> >>> +   if (!res_name)
> >>>             return -ENOMEM;
> >>>
> >>> -   /* Region is permanently reserved if hotremove fails. */
> >>> -   new_res = request_mem_region(kmem_start, kmem_size, new_res_name);
> >>> -   if (!new_res) {
> >>> -           dev_warn(dev, "could not reserve region [%pa-%pa]\n",
> >>> -                    &kmem_start, &kmem_end);
> >>> -           kfree(new_res_name);
> >>> +   res = request_mem_region(range.start, range_len(&range), res_name);
> >>
> >> I think our range could be empty after aligning. I assume
> >> request_mem_region() would check that, but maybe we could report a
> >> better error/warning in that case.
> >>
> > dax_kmem_range() already returns a memory-block-aligned @range but
> > IIUC request_mem_region() isn't checking for that. Having said that
> > the returned @res wouldn't be different from the passed range.start.
> >
> >>>     /*
> >>>      * Ensure that future kexec'd kernels will not treat this as RAM
> >>>      * automatically.
> >>>      */
> >>> -   rc = add_memory_driver_managed(numa_node, new_res->start,
> >>> -                                  resource_size(new_res), kmem_name);
> >>> +   rc = add_memory_driver_managed(numa_node, res->start,
> >>> +                                  resource_size(res), kmem_name);
> >>> +
> >>> +   res->flags |= IORESOURCE_BUSY;
> >>
> >> Hm, I don't think that's correct. Any specific reason why to mark the
> >> not-added, unaligned parts BUSY? E.g., walk_system_ram_range() could
> >> suddenly stumble over it - and e.g., similarly kexec code when trying to
> >> find memory for placing kexec images. I think we should leave this
> >> !BUSY, just as it is right now.
> >>
> > Agreed.
> >
> >>>     if (rc) {
> >>> -           release_resource(new_res);
> >>> -           kfree(new_res);
> >>> -           kfree(new_res_name);
> >>> +           release_mem_region(range.start, range_len(&range));
> >>> +           kfree(res_name);
> >>>             return rc;
> >>>     }
> >>> -   dev_dax->dax_kmem_res = new_res;
> >>> +
> >>> +   dev_set_drvdata(dev, res_name);
> >>>
> >>>     return 0;
> >>>  }
> >>>
> >>>  #ifdef CONFIG_MEMORY_HOTREMOVE
> >>> -static int dev_dax_kmem_remove(struct device *dev)
> >>> +static void dax_kmem_release(struct dev_dax *dev_dax)
> >>>  {
> >>> -   struct dev_dax *dev_dax = to_dev_dax(dev);
> >>> -   struct resource *res = dev_dax->dax_kmem_res;
> >>> -   resource_size_t kmem_start = res->start;
> >>> -   resource_size_t kmem_size = resource_size(res);
> >>> -   const char *res_name = res->name;
> >>>     int rc;
> >>> +   struct device *dev = &dev_dax->dev;
> >>> +   const char *res_name = dev_get_drvdata(dev);
> >>> +   struct range range = dax_kmem_range(dev_dax);
> >>>
> >>>     /*
> >>>      * We have one shot for removing memory, if some memory blocks were not
> >>>      * offline prior to calling this function remove_memory() will fail, and
> >>>      * there is no way to hotremove this memory until reboot because device
> >>> -    * unbind will succeed even if we return failure.
> >>> +    * unbind will proceed regardless of the remove_memory result.
> >>>      */
> >>> -   rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
> >>> -   if (rc) {
> >>> -           any_hotremove_failed = true;
> >>> -           dev_err(dev,
> >>> -                   "DAX region %pR cannot be hotremoved until the next reboot\n",
> >>> -                   res);
> >>> -           return rc;
> >>> +   rc = remove_memory(dev_dax->target_node, range.start, range_len(&range));
> >>> +   if (rc == 0) {
> >>
> >> if (!rc) ?
> >>
> > Better off would be to keep the old order:
> >
> >       if (rc) {
> >               any_hotremove_failed = true;
> >               dev_err(dev, "%#llx-%#llx cannot be hotremoved until the next reboot\n",
> >                               range.start, range.end);
> >               return;
> >       }
> >
> >       release_mem_region(range.start, range_len(&range));
> >       dev_set_drvdata(dev, NULL);
> >       kfree(res_name);
> >       return;
> >
> >
> >>> +           release_mem_region(range.start, range_len(&range));
> >>
> >> remove_memory() does a release_mem_region_adjustable(). Don't you
> >> actually want to release the *unaligned* region you requested?
> >>
> > Isn't it what we're doing here?
> > (The release_mem_region_adjustable() is using the same
> > dax_kmem-aligned range and there's no split/adjust)
> >
> > Meaning right now (+ parent marked as !BUSY), and if I am understanding
> > this correctly:
> >
> > request_mem_region(range.start, range_len)
> >    __request_region(iomem_res, range.start, range_len) -> alloc @parent
> > add_memory_driver_managed(parent.start, resource_size(parent))
> >    __request_region(parent.start, resource_size(parent)) -> alloc @child
> >
> > [...]
> >
> > remove_memory(range.start, range_len)
> >  request_mem_region_adjustable(range.start, range_len)
> >   __release_region(range.start, range_len) -> remove @child
> >
> > release_mem_region(range.start, range_len)
> >   __release_region(range.start, range_len) -> doesn't remove @parent because !BUSY?
> >
> > The add/removal of this relies on !BUSY. But now I am wondering if the parent remaining
> > unreleased is deliberate even on CONFIG_MEMORY_HOTREMOVE=y.
> >
> >       Joao
> >
>
> Thinking about it, if we don't set the parent resource BUSY (which is
> what I think is the right way of doing things), and don't want to store
> the parent resource pointer, we could add something like
> lookup_resource() - e.g., lookup_mem_resource() - , however, searching
> properly in the whole hierarchy (instead of only the first level), and
> traversing down to the last hierarchy. Then it would be as simple as
>
> remove_memory(range.start, range_len)
> res = lookup_mem_resource(range.start);
> release_resource(res);

Another thought... I notice that you've taught
register_memory_resource() a IORESOURCE_MEM_DRIVER_MANAGED special
case. Lets just make the assumption of add_memory_driver_managed()
that it is the driver's responsibility to mark the range busy before
calling, and the driver's responsibility to release the region. I.e.
validate (rather than request) that the range is busy in
register_memory_resource(), and teach release_memory_resource() to
skip releasing the region when the memory is marked driver managed.
That would let dax_kmem drop its manipulation of the 'busy' flag which
is a layering violation no matter how many comments we put around it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

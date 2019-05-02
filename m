Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AC11F8E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 17:54:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E601321243BC6;
	Thu,  2 May 2019 08:54:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B678D21243BC2
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 08:54:37 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id r20so2537355otg.4
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XEew1Olq/3yX7Jk5X3KVQichukbbRYn348zBto8NbGk=;
 b=l/qtAsPAilsFN9GFnTDJXUqqxoRw+RgeUo6XZJsy11pBhIPXZGMzGF9+cbUADCM0B4
 8iGGS9XFOfiMSc18kxqUi/FrQbB8BGPoeqIiCS4NxCBkSswNMUAa08zk6l4P2My0dOe0
 04E1cGuNmL/RZr/cQrVby9FjQmJi3SNN4ZD7VrtcPpCjFU0qQFhIMUAeLHgFXIB5XF0A
 3qGq7yAL6+K8T9hFUj5c1u1FxvQCOQOavF3lz8czs9YLvxDB9NJyVd/IBFCfKZyRk6aU
 5iTinm6ydcZDpVFf4A+TbuJ8GCfB0rySLRIrUaqnFCnNAjD46wWnjao2EdlBw4Hpis2C
 t6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XEew1Olq/3yX7Jk5X3KVQichukbbRYn348zBto8NbGk=;
 b=CL0e9vROOF0GoUU2lg9v922sHuRIi6rCEGHOE9MgTZBKwJeA4c8fpTXzZZ96BpslUl
 ELGLnmx7s6MZUkFy/XyEqj+Q4qpPaNKIR7A4DfobafjlpaKpTRMp6VKdDMI/biEkiQFL
 WJvF5k89iHLaqPQIpdEBrAdbS43dLV5/3oNYZs3zau2RZ15ym2CNCNE1HsrUT6I7rZOX
 UBfKP5i7EMn/LRrnno9kiXFxslh3EXhdsPtfky4E/6/8ryhhUJmwDXZ00KH7Paos9V5C
 w65dBdgwWF9n6sVR4gwT+RebQ78ZiMM/UJby5UNoixTt6DYqhVvNdKKGeLOQkPKCYoh2
 eyCA==
X-Gm-Message-State: APjAAAXE3sUWXapBQSlJfTi3f9r9DX/KoijEHBgGt/UfDKBH/DlqEVgy
 amFf3R/8+q2WYqnLBwAykDWp/ucTKfEw5Ej+lhxThQ==
X-Google-Smtp-Source: APXvYqzTa2L8Y3hvzATDf0GPOGP2MovJVdb2TkdVVwyYLpPc2dggi9AbseY9kp1r15MyCVm90wXUgeQ6+oMS2GDxWaE=
X-Received: by 2002:a9d:7ad1:: with SMTP id m17mr2061812otn.367.1556812476635; 
 Thu, 02 May 2019 08:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
 <20190501191846.12634-3-pasha.tatashin@soleen.com>
In-Reply-To: <20190501191846.12634-3-pasha.tatashin@soleen.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 2 May 2019 08:54:25 -0700
Message-ID: <CAPcyv4iPzpP-gzuDtPB2ixd6_uTuO8-YdVSfGw_Dq=igaKuOEg@mail.gmail.com>
Subject: Re: [v4 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To: Pavel Tatashin <pasha.tatashin@soleen.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Takashi Iwai <tiwai@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Huang, Ying" <ying.huang@intel.com>, James Morris <jmorris@namei.org>,
 David Hildenbrand <david@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Borislav Petkov <bp@suse.de>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Ross Zwisler <zwisler@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 1, 2019 at 12:19 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> It is now allowed to use persistent memory like a regular RAM, but
> currently there is no way to remove this memory until machine is
> rebooted.
>
> This work expands the functionality to also allows hotremoving
> previously hotplugged persistent memory, and recover the device for use
> for other purposes.
>
> To hotremove persistent memory, the management software must first
> offline all memory blocks of dax region, and than unbind it from
> device-dax/kmem driver. So, operations should look like this:
>
> echo offline > echo offline > /sys/devices/system/memory/memoryN/state
> ...
> echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
>
> Note: if unbind is done without offlining memory beforehand, it won't be
> possible to do dax0.0 hotremove, and dax's memory is going to be part of
> System RAM until reboot.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/dax/dax-private.h |  2 +
>  drivers/dax/kmem.c        | 99 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 97 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index a45612148ca0..999aaf3a29b3 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -53,6 +53,7 @@ struct dax_region {
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
>   * @ref: pgmap reference count (driver owned)
>   * @cmp: @ref final put completion (driver owned)
> + * @dax_mem_res: physical address range of hotadded DAX memory
>   */
>  struct dev_dax {
>         struct dax_region *region;
> @@ -62,6 +63,7 @@ struct dev_dax {
>         struct dev_pagemap pgmap;
>         struct percpu_ref ref;
>         struct completion cmp;
> +       struct resource *dax_kmem_res;
>  };
>
>  static inline struct dev_dax *to_dev_dax(struct device *dev)
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 4c0131857133..72b868066026 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -71,21 +71,112 @@ int dev_dax_kmem_probe(struct device *dev)
>                 kfree(new_res);
>                 return rc;
>         }
> +       dev_dax->dax_kmem_res = new_res;
>
>         return 0;
>  }
>
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +static int
> +check_devdax_mem_offlined_cb(struct memory_block *mem, void *arg)
> +{
> +       /* Memory block device */
> +       struct device *mem_dev = &mem->dev;
> +       bool is_offline;
> +
> +       device_lock(mem_dev);
> +       is_offline = mem_dev->offline;
> +       device_unlock(mem_dev);
> +
> +       /*
> +        * Check that device-dax's memory_blocks are offline. If a memory_block
> +        * is not offline a warning is printed and an error is returned.
> +        */
> +       if (!is_offline) {
> +               /* Dax device device */
> +               struct device *dev = (struct device *)arg;
> +               struct dev_dax *dev_dax = to_dev_dax(dev);
> +               struct resource *res = &dev_dax->region->res;
> +               unsigned long spfn = section_nr_to_pfn(mem->start_section_nr);
> +               unsigned long epfn = section_nr_to_pfn(mem->end_section_nr) +
> +                                                      PAGES_PER_SECTION - 1;
> +               phys_addr_t spa = spfn << PAGE_SHIFT;
> +               phys_addr_t epa = epfn << PAGE_SHIFT;
> +
> +               dev_err(dev,
> +                       "DAX region %pR cannot be hotremoved until the next reboot. Memory block [%pa-%pa] is not offline.\n",
> +                       res, &spa, &epa);
> +
> +               return -EBUSY;
> +       }
> +
> +       return 0;
> +}
> +
> +static int dev_dax_kmem_remove(struct device *dev)
> +{
> +       struct dev_dax *dev_dax = to_dev_dax(dev);
> +       struct resource *res = dev_dax->dax_kmem_res;
> +       resource_size_t kmem_start;
> +       resource_size_t kmem_size;
> +       unsigned long start_pfn;
> +       unsigned long end_pfn;
> +       int rc;
> +
> +       kmem_start = res->start;
> +       kmem_size = resource_size(res);
> +       start_pfn = kmem_start >> PAGE_SHIFT;
> +       end_pfn = start_pfn + (kmem_size >> PAGE_SHIFT) - 1;
> +
> +       /*
> +        * Keep hotplug lock while checking memory state, and also required
> +        * during __remove_memory() call. Admin can't change memory state via
> +        * sysfs while this lock is kept.
> +        */
> +       lock_device_hotplug();
> +
> +       /*
> +        * Walk and check that every singe memory_block of dax region is
> +        * offline. Hotremove can succeed only when every memory_block is
> +        * offlined beforehand.
> +        */
> +       rc = walk_memory_range(start_pfn, end_pfn, dev,
> +                              check_devdax_mem_offlined_cb);
> +
> +       /*
> +        * If admin has not offlined memory beforehand, we cannot hotremove dax.
> +        * Unfortunately, because unbind will still succeed there is no way for
> +        * user to hotremove dax after this.
> +        */
> +       if (rc) {
> +               unlock_device_hotplug();
> +               return rc;
> +       }
> +
> +       /* Hotremove memory, cannot fail because memory is already offlined */
> +       __remove_memory(dev_dax->target_node, kmem_start, kmem_size);
> +       unlock_device_hotplug();

Currently the kmem driver can be built as a module, and I don't see a
need to drop that flexibility. What about wrapping these core
routines:

    unlock_device_hotplug
    __remove_memory
    walk_memory_range
    lock_device_hotplug

...into a common exported (gpl) helper like:

    int try_remove_memory(int nid, struct resource *res)

Because as far as I can see there's nothing device-dax specific about
this "try remove iff offline" functionality outside of looking up the
related 'struct resource'. The check_devdax_mem_offlined_cb callback
can be made generic if the callback argument is the resource pointer.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

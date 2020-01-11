Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 090DC137B0C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Jan 2020 03:19:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A01110096C95;
	Fri, 10 Jan 2020 18:22:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::142; helo=mail-il1-x142.google.com; envelope-from=iwebpp@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3CF8D10096C95
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 18:22:16 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id t8so3355092iln.4
        for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 18:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9NlPvtxew3eXYqmYXozDfGnUZw4+D1I0/9faRSj2vSA=;
        b=uQNU+0cTogdHISLbQNw6Udwx4uhNVqeYclYRstLE8nVBsXlJBkkfJIfZKoOaqjdY/c
         rXjZd3boqi/RkpSNPpZ3eL+JQh6YI3GzBz2WEi4nppmX1Q4M0nfXqMJuY55wKDBJBK1n
         VmhwKo5d+EWpr4eD8Fd4R6UoyaECxLBDQjqwfuoQPin6QnuVm633WNbY6T7tpLtU1/XX
         LaYPcBxUA18PJJKps93epKdn9AKhEayJahCFg5vPoMezd0kjLHF4CY+3shwfkw8bmw3D
         X+MTSFHjhmd97KrXTv5KEmE+1RyVIGdASP0JUWCaguANoGX95w4IxvOSG1KaWHMkP6Dy
         hNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9NlPvtxew3eXYqmYXozDfGnUZw4+D1I0/9faRSj2vSA=;
        b=JptUvb7JB6/sTEUFh0SnKoOKcn0BRq0bVZ/b35qTARqWU3c2GkfTJpkhISUR4d26q3
         aEUTTWEZ7AJBUUn0Jm0is/0ASRfn4Wm5GCESUp2V002lf4Eia8DvN1DA6wZJUJZeJk9O
         5a3kJFFSwyC7gjxaU/wlNaauZ/qgP2o8f5uRGdInrxeg/HR9guQTUA5LakWhjEGgQv/A
         P7IlIA2snzwvPDi2w88b02nO3yQ4gn8J76rR60/kgXotWocFsOp1qxpKsR7lUOoA3+WQ
         9QwiBe5KnjCRK3Yz3LH7YQ2S30Gra4njP9epJeZ9D1Ng+SAnyVo1v2UgfFj3sf4hnGtG
         QgZw==
X-Gm-Message-State: APjAAAVtaNQFElYZuuRKaDDya56oHpgZuuGXDWlsrcpP2n3ivLyT0V+j
	u+w4rgIHpWJAHANzROp2nvWm3vBD0H0pJvSPPkxEuLxG
X-Google-Smtp-Source: APXvYqzv3f5r3l7gxt1fEpW4qHCG2f14dLjzFvR+fy4ep/e+O0cTB3Eb+Wl9HujIX7ETKMQgrFgRLZuc6pnDohsok5w=
X-Received: by 2002:a92:8f46:: with SMTP id j67mr5278269ild.125.1578709135782;
 Fri, 10 Jan 2020 18:18:55 -0800 (PST)
MIME-Version: 1.0
References: <157868333608.2508.193799246998570592@ml01.vlan13.01.org>
In-Reply-To: <157868333608.2508.193799246998570592@ml01.vlan13.01.org>
From: Tom Zhou <iwebpp@gmail.com>
Date: Fri, 10 Jan 2020 18:18:43 -0800
Message-ID: <CAHoM-UX0kkW4DoOf=PquouppsZ2Bs_MGS9-V4eM7Zf31E6FBtw@mail.gmail.com>
Subject: Re: Linux-nvdimm Digest, Vol 64, Issue 18
To: linux-nvdimm@lists.01.org
Message-ID-Hash: XEWBMVFB7T4AX32U4NVVGTLK3UUW2TFJ
X-Message-ID-Hash: XEWBMVFB7T4AX32U4NVVGTLK3UUW2TFJ
X-MailFrom: iwebpp@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XEWBMVFB7T4AX32U4NVVGTLK3UUW2TFJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

hello

On Fri, Jan 10, 2020 at 11:05 AM <linux-nvdimm-request@lists.01.org> wrote:

> Send Linux-nvdimm mailing list submissions to
>         linux-nvdimm@lists.01.org
>
> To subscribe or unsubscribe via email, send a message with subject or
> body 'help' to
>         linux-nvdimm-request@lists.01.org
>
> You can reach the person managing the list at
>         linux-nvdimm-owner@lists.01.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linux-nvdimm digest..."
>
> Today's Topics:
>
>    1. [PATCH ndctl] ndctl/namespace: Fix enable-namespace error for seed
> namespaces
>       (Santosh Sivaraj)
>    2. Re: dax: Get rid of fs_dax_get_by_host() helper
>       (Christoph Hellwig)
>    3. Re: [PATCH 01/19] dax: remove block device dependencies
>       (Christoph Hellwig)
>    4. Re: [PATCH ndctl] ndctl/namespace: Fix enable-namespace error for
> seed namespaces
>       (Dan Williams)
>    5. [PATCH RFC 06/10] device-dax: Introduce pfn_flags helper
>       (Joao Martins)
>    6. [PATCH RFC 07/10] device-dax: Add support for PFN_SPECIAL flags
>       (Joao Martins)
>
>
> ----------------------------------------------------------------------
>
> Date: Fri, 10 Jan 2020 13:50:17 +0530
> From: Santosh Sivaraj <santosh@fossix.org>
> Subject: [PATCH ndctl] ndctl/namespace: Fix enable-namespace error for
>         seed namespaces
> To: linux-nvdimm@lists.01.org,  Dan Williams
>         <dan.j.williams@intel.com>
> Cc: harish@linux.ibm.com
> Message-ID: <20200110082017.3485529-1-santosh@fossix.org>
>
> 'ndctl enable-namespace all' tries to enable seed namespaces too, which
> results
> in a error like
>
> libndctl: ndctl_namespace_enable: namespace1.0: failed to enable
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  ndctl/lib/libndctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index 6596f94..4839214 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -4010,11 +4010,16 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct
> ndctl_namespace *ndns)
>         const char *devname = ndctl_namespace_get_devname(ndns);
>         struct ndctl_ctx *ctx = ndctl_namespace_get_ctx(ndns);
>         struct ndctl_region *region = ndns->region;
> +       unsigned long long size = ndctl_namespace_get_size(ndns);
>         int rc;
>
>         if (ndctl_namespace_is_enabled(ndns))
>                 return 0;
>
> +       /* Don't try to enable idle namespace (no capacity allocated) */
> +       if (size == 0)
> +               return -1;
> +
>         rc = ndctl_bind(ctx, ndns->module, devname);
>
>         /*
> --
> 2.24.1
>
> ------------------------------
>
> Date: Fri, 10 Jan 2020 04:31:27 -0800
> From: Christoph Hellwig <hch@infradead.org>
> Subject: Re: dax: Get rid of fs_dax_get_by_host() helper
> To: Vivek Goyal <vgoyal@redhat.com>
> Cc: linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
>         linux-kernel@vger.kernel.org
> Message-ID: <20200110123127.GA6558@infradead.org>
> Content-Type: text/plain; charset=us-ascii
>
> On Mon, Jan 06, 2020 at 01:11:17PM -0500, Vivek Goyal wrote:
> > Looks like nobody is using fs_dax_get_by_host() except
> fs_dax_get_by_bdev()
> > and it can easily use dax_get_by_host() instead.
> >
> > IIUC, fs_dax_get_by_host() was only introduced so that one could compile
> > with CONFIG_FS_DAX=n and CONFIG_DAX=m. fs_dax_get_by_bdev() achieves
> > the same purpose and hence it looks like fs_dax_get_by_host() is not
> > needed anymore.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> ------------------------------
>
> Date: Fri, 10 Jan 2020 04:36:31 -0800
> From: Christoph Hellwig <hch@infradead.org>
> Subject: Re: [PATCH 01/19] dax: remove block device dependencies
> To: Dan Williams <dan.j.williams@intel.com>
> Cc: Jan Kara <jack@suse.cz>, "Darrick J. Wong"
>         <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>,
> Dave
>         Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>,
>         linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing
> List
>         <linux-kernel@vger.kernel.org>, "Dr.  David Alan Gilbert"
>         <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi
>         <stefanha@redhat.com>, linux-fsdevel <
> linux-fsdevel@vger.kernel.org>
> Message-ID: <20200110123631.GA16268@infradead.org>
> Content-Type: text/plain; charset=us-ascii
>
> On Thu, Jan 09, 2020 at 12:03:01PM -0800, Dan Williams wrote:
> > > So I'd find two options reasonably consistent:
> > > 1) Keep status quo where partitions are created and support DAX.
> > > 2) Stop partition creation altogether, if anyones wants to split pmem
> > > device further, he can use dm-linear for that (i.e., kpartx).
> > >
> > > But I'm not sure if the ship hasn't already sailed for option 2) to be
> > > feasible without angry users and Linus reverting the change.
> >
> > Christoph? I feel myself leaning more and more to the "keep pmem
> > partitions" camp.
> >
> > I don't see "drop partition support" effort ending well given the long
> > standing "ext4 fails to mount when dax is not available" precedent.
>
> Do we have any evidence of existing setups with DAX and partitions?
> Can we just throw in a patch to reject that case for now before actually
> removing the code and see if anyone screams.  And fix ext4 up while
> we are at it.
>
> > I think the next least bad option is to have a dax_get_by_host()
> > variant that passes an offset and length pair rather than requiring a
> > later bdev_dax_pgoff() to recall the offset. This also prevents
> > needing to add another dax-device object representation.
>
> IFF we have to keep partition support, yes.  But keeping it just seems
> like a really bad idea.
>
> ------------------------------
>
> Date: Fri, 10 Jan 2020 09:56:26 -0800
> From: Dan Williams <dan.j.williams@intel.com>
> Subject: Re: [PATCH ndctl] ndctl/namespace: Fix enable-namespace error
>         for seed namespaces
> To: Santosh Sivaraj <santosh@fossix.org>
> Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, harish@linux.ibm.com
> Message-ID:
>         <
> CAPcyv4h-ke4Jorqx6md+gfgVupNgXn-qm8Yx7vaLNa4O+91jeg@mail.gmail.com>
> Content-Type: text/plain; charset="UTF-8"
>
> On Fri, Jan 10, 2020 at 12:21 AM Santosh Sivaraj <santosh@fossix.org>
> wrote:
> >
> > 'ndctl enable-namespace all' tries to enable seed namespaces too, which
> results
> > in a error like
> >
> > libndctl: ndctl_namespace_enable: namespace1.0: failed to enable
> >
> > Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> > ---
> >  ndctl/lib/libndctl.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> > index 6596f94..4839214 100644
> > --- a/ndctl/lib/libndctl.c
> > +++ b/ndctl/lib/libndctl.c
> > @@ -4010,11 +4010,16 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct
> ndctl_namespace *ndns)
> >         const char *devname = ndctl_namespace_get_devname(ndns);
> >         struct ndctl_ctx *ctx = ndctl_namespace_get_ctx(ndns);
> >         struct ndctl_region *region = ndns->region;
> > +       unsigned long long size = ndctl_namespace_get_size(ndns);
> >         int rc;
> >
> >         if (ndctl_namespace_is_enabled(ndns))
> >                 return 0;
> >
> > +       /* Don't try to enable idle namespace (no capacity allocated) */
> > +       if (size == 0)
> > +               return -1;
>
> Concept looks good to me, just resend with that -1 changed to a named
> error code (-ENXIO).
>
> ------------------------------
>
> Date: Fri, 10 Jan 2020 19:03:09 +0000
> From: Joao Martins <joao.m.martins@oracle.com>
> Subject: [PATCH RFC 06/10] device-dax: Introduce pfn_flags helper
> To: linux-nvdimm@lists.01.org
> Cc: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
>         <cohuck@redhat.com>, kvm@vger.kernel.org, Andrew Morton
>         <akpm@linux-foundation.org>, linux-mm@kvack.org,
>         linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de
> >,
>         Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
> "H .
>         Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Liran Alon
>         <liran.alon@oracle.com>, Nikita Leshenko
>         <nikita.leshchenko@oracle.com>, Barret Rhoden <brho@google.com>,
> Boris
>         Ostrovsky <boris.ostrovsky@oracle.com>, Matthew Wilcox
>         <willy@infradead.org>, Konrad Rzeszutek Wilk <
> konrad.wilk@oracle.com>
> Message-ID: <20200110190313.17144-7-joao.m.martins@oracle.com>
>
> Replace PFN_DEV|PFN_MAP check call sites with two helper functions
> dax_is_pfn_dev() and dax_is_pfn_map().
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/dax/device.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index c6a7f5e12c54..113a554de3ee 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -14,6 +14,17 @@
>  #include "dax-private.h"
>  #include "bus.h"
>
> +static int dax_is_pfn_dev(struct dev_dax *dev_dax)
> +{
> +       return (dev_dax->region->pfn_flags & (PFN_DEV|PFN_MAP)) == PFN_DEV;
> +}
> +
> +static int dax_is_pfn_map(struct dev_dax *dev_dax)
> +{
> +       return (dev_dax->region->pfn_flags &
> +               (PFN_DEV|PFN_MAP)) == (PFN_DEV|PFN_MAP);
> +}
> +
>  static int check_vma_mmap(struct dev_dax *dev_dax, struct vm_area_struct
> *vma,
>                 const char *func)
>  {
> @@ -60,8 +71,7 @@ static int check_vma(struct dev_dax *dev_dax, struct
> vm_area_struct *vma,
>         if (rc < 0)
>                 return rc;
>
> -       if ((dev_dax->region->pfn_flags & (PFN_DEV|PFN_MAP)) == PFN_DEV
> -                       && (vma->vm_flags & VM_DONTCOPY) == 0) {
> +       if (dax_is_pfn_dev(dev_dax) && (vma->vm_flags & VM_DONTCOPY) == 0)
> {
>                 dev_info_ratelimited(&dev_dax->dev,
>                                 "%s: %s: fail, dax range requires
> MADV_DONTFORK\n",
>                                 current->comm, func);
> @@ -140,7 +150,7 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax
> *dev_dax,
>         }
>
>         /* dax pmd mappings require pfn_t_devmap() */
> -       if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) !=
> (PFN_DEV|PFN_MAP)) {
> +       if (!dax_is_pfn_map(dev_dax)) {
>                 dev_dbg(dev, "region lacks devmap flags\n");
>                 return VM_FAULT_SIGBUS;
>         }
> @@ -190,7 +200,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax
> *dev_dax,
>         }
>
>         /* dax pud mappings require pfn_t_devmap() */
> -       if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) !=
> (PFN_DEV|PFN_MAP)) {
> +       if (!dax_is_pfn_map(dev_dax)) {
>                 dev_dbg(dev, "region lacks devmap flags\n");
>                 return VM_FAULT_SIGBUS;
>         }
> --
> 2.17.1
>
> ------------------------------
>
> Date: Fri, 10 Jan 2020 19:03:10 +0000
> From: Joao Martins <joao.m.martins@oracle.com>
> Subject: [PATCH RFC 07/10] device-dax: Add support for PFN_SPECIAL
>         flags
> To: linux-nvdimm@lists.01.org
> Cc: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
>         <cohuck@redhat.com>, kvm@vger.kernel.org, Andrew Morton
>         <akpm@linux-foundation.org>, linux-mm@kvack.org,
>         linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de
> >,
>         Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
> "H .
>         Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Liran Alon
>         <liran.alon@oracle.com>, Nikita Leshenko
>         <nikita.leshchenko@oracle.com>, Barret Rhoden <brho@google.com>,
> Boris
>         Ostrovsky <boris.ostrovsky@oracle.com>, Matthew Wilcox
>         <willy@infradead.org>, Konrad Rzeszutek Wilk <
> konrad.wilk@oracle.com>
> Message-ID: <20200110190313.17144-8-joao.m.martins@oracle.com>
>
> Right now we assume there's gonna be a PFN_DEV|PFN_MAP which
> means it will have a struct page backing the PFN but that is
> not placed in normal system RAM zones.
>
> Add support for PFN_DEV|PFN_SPECIAL only and therefore the
> underlying vma won't have a struct page. For device dax, this
> means not assuming callers will pass a dev_pagemap, and avoid
> returning SIGBUS for the lack of PFN_MAP region pfn flag and
> finally not setting struct page index/mapping on fault.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/dax/bus.c    |  3 ++-
>  drivers/dax/device.c | 40 ++++++++++++++++++++++------------------
>  2 files changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 46e46047a1f7..96ca3ac85278 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -414,7 +414,8 @@ struct dev_dax *__devm_create_dev_dax(struct
> dax_region *dax_region, int id,
>         if (!dev_dax)
>                 return ERR_PTR(-ENOMEM);
>
> -       memcpy(&dev_dax->pgmap, pgmap, sizeof(*pgmap));
> +       if (pgmap)
> +               memcpy(&dev_dax->pgmap, pgmap, sizeof(*pgmap));
>
>         /*
>          * No 'host' or dax_operations since there is no access to this
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 113a554de3ee..aa38f5ff180a 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -14,6 +14,12 @@
>  #include "dax-private.h"
>  #include "bus.h"
>
> +static int dax_is_pfn_special(struct dev_dax *dev_dax)
> +{
> +       return (dev_dax->region->pfn_flags &
> +               (PFN_DEV|PFN_SPECIAL)) == (PFN_DEV|PFN_SPECIAL);
> +}
> +
>  static int dax_is_pfn_dev(struct dev_dax *dev_dax)
>  {
>         return (dev_dax->region->pfn_flags & (PFN_DEV|PFN_MAP)) == PFN_DEV;
> @@ -104,6 +110,7 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax
> *dev_dax,
>         struct dax_region *dax_region;
>         phys_addr_t phys;
>         unsigned int fault_size = PAGE_SIZE;
> +       int rc;
>
>         if (check_vma(dev_dax, vmf->vma, __func__))
>                 return VM_FAULT_SIGBUS;
> @@ -126,7 +133,12 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax
> *dev_dax,
>
>         *pfn = phys_to_pfn_t(phys, dax_region->pfn_flags);
>
> -       return vmf_insert_mixed(vmf->vma, vmf->address, *pfn);
> +       if (dax_is_pfn_special(dev_dax))
> +               rc = vmf_insert_pfn(vmf->vma, vmf->address,
> pfn_t_to_pfn(*pfn));
> +       else
> +               rc = vmf_insert_mixed(vmf->vma, vmf->address, *pfn);
> +
> +       return rc;
>  }
>
>  static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
> @@ -149,12 +161,6 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax
> *dev_dax,
>                 return VM_FAULT_SIGBUS;
>         }
>
> -       /* dax pmd mappings require pfn_t_devmap() */
> -       if (!dax_is_pfn_map(dev_dax)) {
> -               dev_dbg(dev, "region lacks devmap flags\n");
> -               return VM_FAULT_SIGBUS;
> -       }
> -
>         if (fault_size < dax_region->align)
>                 return VM_FAULT_SIGBUS;
>         else if (fault_size > dax_region->align)
> @@ -199,12 +205,6 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax
> *dev_dax,
>                 return VM_FAULT_SIGBUS;
>         }
>
> -       /* dax pud mappings require pfn_t_devmap() */
> -       if (!dax_is_pfn_map(dev_dax)) {
> -               dev_dbg(dev, "region lacks devmap flags\n");
> -               return VM_FAULT_SIGBUS;
> -       }
> -
>         if (fault_size < dax_region->align)
>                 return VM_FAULT_SIGBUS;
>         else if (fault_size > dax_region->align)
> @@ -266,7 +266,7 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault
> *vmf,
>                 rc = VM_FAULT_SIGBUS;
>         }
>
> -       if (rc == VM_FAULT_NOPAGE) {
> +       if (dax_is_pfn_map(dev_dax) && (rc == VM_FAULT_NOPAGE)) {
>                 unsigned long i;
>                 pgoff_t pgoff;
>
> @@ -344,6 +344,8 @@ static int dax_mmap(struct file *filp, struct
> vm_area_struct *vma)
>
>         vma->vm_ops = &dax_vm_ops;
>         vma->vm_flags |= VM_HUGEPAGE;
> +       if (dax_is_pfn_special(dev_dax))
> +               vma->vm_flags |= VM_PFNMAP;
>         return 0;
>  }
>
> @@ -450,10 +452,12 @@ int dev_dax_probe(struct device *dev)
>                 return -EBUSY;
>         }
>
> -       dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
> -       addr = devm_memremap_pages(dev, &dev_dax->pgmap);
> -       if (IS_ERR(addr))
> -               return PTR_ERR(addr);
> +       if (dax_is_pfn_map(dev_dax)) {
> +               dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
> +               addr = devm_memremap_pages(dev, &dev_dax->pgmap);
> +               if (IS_ERR(addr))
> +                       return PTR_ERR(addr);
> +       }
>
>         inode = dax_inode(dax_dev);
>         cdev = inode->i_cdev;
> --
> 2.17.1
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
>
>
> ------------------------------
>
> End of Linux-nvdimm Digest, Vol 64, Issue 18
> ********************************************
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

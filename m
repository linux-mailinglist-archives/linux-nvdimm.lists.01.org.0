Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB9420FCA3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 21:21:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69008111B33DC;
	Tue, 30 Jun 2020 12:21:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BDF76110122B2
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 12:21:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so16061900edy.1
        for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDWjFuo2aOkZOY1ZGe7doLco0wns6mMkfz03xEpmifg=;
        b=xWLO35/yg26+kdxUsrYHTQL6K3zVldhtYUPjSOyszohWugfGdSvylFV0Mr+ezsFUTg
         6/E8ksTtih00DXi2eAJ9yFSaT26tKz13dKfjZ3hbdhvPcmiVkjn0JMxPhlS5QE6Ygqro
         8t289HYwrLWB6woifs927H+xl2SrEO2h0noUuPOAorzlukQbIyNuwQaSwqCyQnU/IKRX
         RfGnJRgoLwfVkkFvmwEnsdd9hagwWr0I0T+/mWziQ7Zh6VzaceaC1xS6+YwYcHcuTA+4
         cDJgmQ+EJ1Nl1YVfFQYg74mVGpuF2Z26sXT0YZwokMYj9HEstPgjg3F+0fcPXC2sZmlT
         4WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDWjFuo2aOkZOY1ZGe7doLco0wns6mMkfz03xEpmifg=;
        b=WtSJgu8uB+6CbZXEwObO06DNh3/xwm/r11d606YRIJz3Ond7sHDMYQKYjb8xc9tYwS
         K4AdCcPQVlp4r26Y0B+KyAZeRPL1SCrASajzGqVuGtv75b+B7wthPMbNai1F15h2SPQ2
         OB6OkXPIZcfJ1TRVST1dF80cbJXcX8HXAyyy0Ld21XM5p/dI7M4kiTu6WuXS+4jciUoT
         7xkBxgyQ+IzP/6fcnh723R1pqMLmPcAENgK3/FEHQ0ZoTLFcZZgzfbLSN6Yo8zSvDrze
         ds7uF27YIkz7tCskdVu95DdIE4h1PXLGVB2+L5Qg6v1izJ5NWN2GwIih4Lb3feWuN/1y
         B88w==
X-Gm-Message-State: AOAM530OWm/wQcx7eVw7zwtiw8H1ziiaQAoE30d2RzCuxY+YlkWfQvNt
	mjcGegfW1u7YaPRYwI0FfB8m3ayihAHX+qpoULXebQ==
X-Google-Smtp-Source: ABdhPJyhSrwK4CR021aEYPPvdNRkgAK4t99TaVUK9PKyiHPUczetV1NQ3PR78r7W0/4Z+4ctV0hlkj6DKH+Et+qIcAQ=
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr25877146edo.123.1593544901310;
 Tue, 30 Jun 2020 12:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200629135722.73558-5-aneesh.kumar@linux.ibm.com>
 <20200629202901.83516-1-aneesh.kumar@linux.ibm.com> <CAPcyv4hgjH4We9Th2oir3NxpJEhFuLnQeCrF8auwNfF+5av8jQ@mail.gmail.com>
 <87imf9gn9w.fsf@linux.ibm.com> <CAPcyv4hbECX+7cvX+eT97jvDFUTjQbUEqExZKpV_moDWMFzJ6A@mail.gmail.com>
 <03cf6d12-544f-154d-18da-a6cd204998ee@linux.ibm.com> <871rlwhg87.fsf@linux.ibm.com>
In-Reply-To: <871rlwhg87.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 30 Jun 2020 12:21:30 -0700
Message-ID: <CAPcyv4i_B==LxcxQE9PuhUEGUQCNkECCtVzHiXvggLEgnMfTBA@mail.gmail.com>
Subject: Re: [PATCH updated] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: NEZNQJRTWWIBZPNFAFOUX2BOR5JKC6NZ
X-Message-ID-Hash: NEZNQJRTWWIBZPNFAFOUX2BOR5JKC6NZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NEZNQJRTWWIBZPNFAFOUX2BOR5JKC6NZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 30, 2020 at 5:48 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
>
> Update patch.
>
> From 1e6aa6c4182e14ec5d6bf878ae44c3f69ebff745 Mon Sep 17 00:00:00 2001
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Date: Tue, 12 May 2020 20:58:33 +0530
> Subject: [PATCH] libnvdimm/nvdimm/flush: Allow architecture to override the
>  flush barrier
>
> Architectures like ppc64 provide persistent memory specific barriers
> that will ensure that all stores for which the modifications are
> written to persistent storage by preceding dcbfps and dcbstps
> instructions have updated persistent storage before any data
> access or data transfer caused by subsequent instructions is initiated.
> This is in addition to the ordering done by wmb()
>
> Update nvdimm core such that architecture can use barriers other than
> wmb to ensure all previous writes are architecturally visible for
> the platform buffer flush.

Looks good, after a few minor fixups below you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I'm expecting that these will be merged through the powerpc tree since
they mostly impact powerpc with only minor touches to libnvdimm.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  Documentation/memory-barriers.txt | 14 ++++++++++++++
>  drivers/md/dm-writecache.c        |  2 +-
>  drivers/nvdimm/region_devs.c      |  8 ++++----
>  include/asm-generic/barrier.h     | 10 ++++++++++
>  4 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index eaabc3134294..340273a6b18e 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1935,6 +1935,20 @@ There are some more advanced barrier functions:
>       relaxed I/O accessors and the Documentation/DMA-API.txt file for more
>       information on consistent memory.
>
> + (*) pmem_wmb();
> +
> +     This is for use with persistent memory to ensure that stores for which
> +     modifications are written to persistent storage have updated the persistent
> +     storage.

I think this should be:

s/updated the persistent storage/reached a platform durability domain/

> +
> +     For example, after a non-temporal write to pmem region, we use pmem_wmb()
> +     to ensures that stores have updated the persistent storage. This ensures

s/ensures/ensure/

...and the same comment about "persistent storage" because pmem_wmb()
as implemented on x86 does not guarantee that the writes have reached
storage it ensures that writes have reached buffers / queues that are
within the ADR (platform persistence / durability) domain.

> +     that stores have updated persistent storage before any data access or
> +     data transfer caused by subsequent instructions is initiated. This is
> +     in addition to the ordering done by wmb().
> +
> +     For load from persistent memory, existing read memory barriers are sufficient
> +     to ensure read ordering.
>
>  ===============================
>  IMPLICIT KERNEL MEMORY BARRIERS
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 74f3c506f084..00534fa4a384 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -536,7 +536,7 @@ static void ssd_commit_superblock(struct dm_writecache *wc)
>  static void writecache_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
>  {
>         if (WC_MODE_PMEM(wc))
> -               wmb();
> +               pmem_wmb();
>         else
>                 ssd_commit_flushed(wc, wait_for_ios);
>  }
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 4502f9c4708d..2333b290bdcf 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1206,13 +1206,13 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
>         idx = this_cpu_add_return(flush_idx, hash_32(current->pid + idx, 8));
>
>         /*
> -        * The first wmb() is needed to 'sfence' all previous writes
> -        * such that they are architecturally visible for the platform
> -        * buffer flush.  Note that we've already arranged for pmem
> +        * The first arch_pmem_flush_barrier() is needed to 'sfence' all

One missed arch_pmem_flush_barrier() rename.

> +        * previous writes such that they are architecturally visible for
> +        * the platform buffer flush. Note that we've already arranged for pmem
>          * writes to avoid the cache via memcpy_flushcache().  The final
>          * wmb() ensures ordering for the NVDIMM flush write.
>          */
> -       wmb();
> +       pmem_wmb();
>         for (i = 0; i < nd_region->ndr_mappings; i++)
>                 if (ndrd_get_flush_wpq(ndrd, i, 0))
>                         writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 2eacaf7d62f6..879d68faec1d 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -257,5 +257,15 @@ do {                                                                       \
>  })
>  #endif
>
> +/*
> + * pmem_barrier() ensures that all stores for which the modification

One missed pmem_barrier() conversion.

> + * are written to persistent storage by preceding instructions have
> + * updated persistent storage before any data  access or data transfer
> + * caused by subsequent instructions is initiated.
> + */
> +#ifndef pmem_wmb
> +#define pmem_wmb()     wmb()
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* __ASM_GENERIC_BARRIER_H */
> --
> 2.26.2
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

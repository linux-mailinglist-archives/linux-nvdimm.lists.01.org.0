Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C35C220EAF2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 03:33:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B3557111FF491;
	Mon, 29 Jun 2020 18:33:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9A22F111F92B6
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 18:33:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so18824141eje.1
        for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 18:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5El26br7U79X9FTsBvWpGS20gRgixD5mBciJjhUv1M=;
        b=bb11NfHSu4FFKy2QuyrYfe05rVODv2164UTTfehHFGa9ozhWvY6AoJIIUQ0G8Qfm5R
         OslJLJOxrHhpW7Ky9gDdpxJ3hyhPydoCsV0DU9igvo/RifOq6QazJvkNxB3ZkQyap1Ea
         p5NMeQ+pZWGXtE1ZxRzksZaXhI9CIgvcjDC9dNTXnSZ7DkkWnPWP2HKF/sSG9WhXL3C4
         GgH/Yp4PXYTLaMEkzlAPolaCNsaO4rpGYRyB+UG1gY2382WA1GECxgCY4IO7Ce3v2mvb
         tGh22IpWS2qZos/9j/mKsMLUUDoVmrdj6eoaJRp73+9AR+xXvDz1tP3YAF5hliOU5YlY
         rgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5El26br7U79X9FTsBvWpGS20gRgixD5mBciJjhUv1M=;
        b=SF73uxiPzRyJR1+fUgaFioC0aJ7A00rm1p4P1wzgwfM3x5C6cLiKPc8hgJAEopXQp0
         fWzN1Mv5Buv5wpVaATFx0X62iAGlv4lzFSO2zWbjXBjkm5pK42/6mtgSD7q3FR/BVUrd
         HEnJGQ3uIECK83zYhg3tUZ741+JWa+cEPbiTXtQWvDykpiPw7dxE/796AFdQwWm7M3ot
         lL2e7CHUtJMtJ75scqR5Up0rNV2zgHdlqIiQUVtxww7x1Rp9f9zJpATOZ4H1tr9eKOv/
         uogPFXswnqWBrO1zXqTMaY//F5C5YwFJbRmwnl2eVIAr7g6Iw9p0gA+ycTZ2OAFG8HVZ
         3W6A==
X-Gm-Message-State: AOAM533ql+tV/vkZKAiF6y3pNP7hlN7jIlai8wpVAfn4mWuSGNqOdjFh
	zVlc4VGOHvtK2juoO7KIC0JNiK+TosytUZqockqn2g==
X-Google-Smtp-Source: ABdhPJyZu3frqYqF5fPDjIaPADdjXLw079TwMS4/EaMavTQjAYWNSCtidPM96iilj2640sUhb5M6x1LUmQaNxosHgw0=
X-Received: by 2002:a17:906:f98e:: with SMTP id li14mr16307856ejb.174.1593480786452;
 Mon, 29 Jun 2020 18:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200629135722.73558-5-aneesh.kumar@linux.ibm.com> <20200629202901.83516-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200629202901.83516-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 29 Jun 2020 18:32:55 -0700
Message-ID: <CAPcyv4hgjH4We9Th2oir3NxpJEhFuLnQeCrF8auwNfF+5av8jQ@mail.gmail.com>
Subject: Re: [PATCH updated] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: RZXV345VOTSZZ5LYOFAMHNJRKBCSVSFB
X-Message-ID-Hash: RZXV345VOTSZZ5LYOFAMHNJRKBCSVSFB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RZXV345VOTSZZ5LYOFAMHNJRKBCSVSFB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 29, 2020 at 1:29 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
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
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/md/dm-writecache.c   | 2 +-
>  drivers/nvdimm/region_devs.c | 8 ++++----
>  include/linux/libnvdimm.h    | 4 ++++
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 74f3c506f084..8c6b6dce64e2 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -536,7 +536,7 @@ static void ssd_commit_superblock(struct dm_writecache *wc)
>  static void writecache_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
>  {
>         if (WC_MODE_PMEM(wc))
> -               wmb();
> +               arch_pmem_flush_barrier();
>         else
>                 ssd_commit_flushed(wc, wait_for_ios);
>  }
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 4502f9c4708d..b308ad09b63d 100644
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
> +        * previous writes such that they are architecturally visible for
> +        * the platform buffer flush. Note that we've already arranged for pmem
>          * writes to avoid the cache via memcpy_flushcache().  The final
>          * wmb() ensures ordering for the NVDIMM flush write.
>          */
> -       wmb();
> +       arch_pmem_flush_barrier();
>         for (i = 0; i < nd_region->ndr_mappings; i++)
>                 if (ndrd_get_flush_wpq(ndrd, i, 0))
>                         writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 18da4059be09..66f6c65bd789 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -286,4 +286,8 @@ static inline void arch_invalidate_pmem(void *addr, size_t size)
>  }
>  #endif
>
> +#ifndef arch_pmem_flush_barrier
> +#define arch_pmem_flush_barrier() wmb()
> +#endif

I think it is out of place to define this in libnvdimm.h and it is odd
to give it such a long name. The other pmem api helpers like
arch_wb_cache_pmem() and arch_invalidate_pmem() are function calls for
libnvdimm driver operations, this barrier is just an instruction and
is closer to wmb() than the pmem api routine.

Since it is a store fence for pmem, so let's just call it pmem_wmb()
and define the generic version in include/linux/compiler.h. It should
probably also be documented alongside dma_wmb() in
Documentation/memory-barriers.txt about why code would use it over
wmb(), and why a symmetric pmem_rmb() is not needed.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

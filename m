Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1061D1AC6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 May 2020 18:14:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2E95611820DE0;
	Wed, 13 May 2020 09:11:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 408FE11A692DD
	for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 09:11:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g9so7822221edr.8
        for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcMsgBgFOR33rFkSLHsQoINTFi9A4r6gtBoxzM7yf+g=;
        b=i4xpCY5DSLfkEnhkBrJWM45ywVBJL4NJOtQux7qlHGMyoowblY76h3qVob1a001eel
         Q1RlgpqnZYfw0vUxGrfqj1fYKb+VNR0YPkAkDn23oiTp3VPCQoTstXPKTcxlvnbuCYvU
         Rd5Uu7wUKbDoA2zGV5xcPyhO8LBU+2Gdwt+BY6hMSk5TZx0zKKq+ZPIaAXfYUXW3oD37
         2LYEevpq6KqCQYYdcjkUwngZL7WjstoB73zpTX4YMCH7jClwh+5kKoDxmBjonmi1iTZE
         EYlk8ve1Yc7tPD/t0iOIwPUAj1ena1t9IZmY1lMWleSYlqchy010j/mXS0Cq9Piw2TfC
         sxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcMsgBgFOR33rFkSLHsQoINTFi9A4r6gtBoxzM7yf+g=;
        b=IuxgS1KngMM7xwDfL3yxLMDZH+EFzOYCngF9oXQiCIqcO0sWT8FG8iVPE1BuncI9cT
         +2bcxuPYgpwyNg9IoorcjXWhr38XkNXCEE9g6f/UuHzNXSx1nXIJUNZWOLqft+PvJJws
         R2wETQT0bCJ4tmdk/mmmX+Cm4ZTsYPUaeQIZ/lABG0sW6E9l7W0HyfNT3AdKp3wntHYx
         Q5sUxAWV0S5JbGk6rIBM8Wl/eitHx3dOlNRdh2tsM2WDTdR2QYNdUM34iOPExwY3TM2a
         uJirBHctyxEknF2KiA27nFMAguhZRLAQCL2nxnK7XLm+r1xPOMtbD13rhUZ5nBRtdkU3
         XZqg==
X-Gm-Message-State: AOAM530BqalVVTf5FA2V4JAVFI9IuvVHG6ZFJ1RxQZ8++Hwt1FRz4VRY
	5TArW2946EwrU53obqgNiWuhvRSoc7E1k+7nPzVwMw==
X-Google-Smtp-Source: ABdhPJx9RnZUcqpbWUC0Rcy7ZBVVzkwrmg9V1QAHY5D9yoPZmXBNmm8PjE9ALhQbCbIJz8bYcgepWe2nAndXgth+Jb8=
X-Received: by 2002:a50:ee86:: with SMTP id f6mr378941edr.123.1589386459763;
 Wed, 13 May 2020 09:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200513034705.172983-1-aneesh.kumar@linux.ibm.com> <20200513034705.172983-3-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200513034705.172983-3-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 May 2020 09:14:08 -0700
Message-ID: <CAPcyv4iAdrdMiSzVr1UL9Naya+Rq70WVuKqCCNFHe1C4n+E6Tw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: XM3EHNUGYULRDCRLDD5FX2D7AQDPXBUH
X-Message-ID-Hash: XM3EHNUGYULRDCRLDD5FX2D7AQDPXBUH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, alistair@popple.id.au
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XM3EHNUGYULRDCRLDD5FX2D7AQDPXBUH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 12, 2020 at 8:47 PM Aneesh Kumar K.V
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

This seems like an exceedingly bad idea, maybe I'm missing something.
This implies that the deployed base of DAX applications using the old
instruction sequence are going to regress on new hardware that
requires the new instructions to be deployed. I'm thinking the kernel
should go as far as to disable DAX operation by default on new
hardware until userspace asserts that it is prepared to switch to the
new implementation. Is there any other way to ensure the forward
compatibility of deployed ppc64 DAX applications?

>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/region_devs.c | 8 ++++----
>  include/linux/libnvdimm.h    | 4 ++++
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ccbb5b43b8b2..88ea34a9c7fd 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1216,13 +1216,13 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
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
> +
>  #endif /* __LIBNVDIMM_H__ */
> --
> 2.26.2
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

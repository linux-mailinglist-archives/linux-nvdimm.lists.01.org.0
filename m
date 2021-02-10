Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB27315ED7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 06:18:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D0D14100F224B;
	Tue,  9 Feb 2021 21:18:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d30; helo=mail-io1-xd30.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A4DB7100F2248
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 21:18:23 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e24so676911ioc.1
        for <linux-nvdimm@lists.01.org>; Tue, 09 Feb 2021 21:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1QyQ76yM+DRGQIWWpBtZtC+km5KE0GD76W/nCu9/S+0=;
        b=rKd/EBgjCCDOJ6y0MmK+J+IIhH+emTDln0WBMqk5Ga+nP9hQuEJXy30zORZMmvO6CC
         slRGUxFBDg6G3ijaR+YblWEtMn4zINr0uRsTQrLjZ6zD+XFog4ktVfaozxrVRgPjzZ6A
         6EscNGkb+hZt9b8pB6T5eowKbVqVThgCTR3Is0XV1Hq/KfIc+AtYbbHszi+5PIHuhzle
         R/ka2jLiwTfrrnldXoi2GGYZn4MKf/C5p0PioeOJl+P6EAekwSWZcXI5xMnrKB4pN4vd
         CDKeSz+4/kLoQfDLJzwtPt2XvaHWJ2uz5eVHzNxE93pPxNYRiRjLBHHjEu2ZiLw3RaIE
         er7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QyQ76yM+DRGQIWWpBtZtC+km5KE0GD76W/nCu9/S+0=;
        b=Cv+7iFV/ZmdmgoI9gx4KzmeXEYCIdaW7cJrQ6G8TZCqwIOzuL0Xq4Hk5JCr14zpTy5
         EGxFeVbwEIwA1EWclGLc3jd9YRiBN6O83lMFHL+BNhRPRzIurrQIJJZWk9SSvmVkk5bh
         VvxwEXbn6X/GxWnzbQ8MQsvSoPxdeNRfJ9QzkyBUw2AscPC9SrouK5sLEY2EGzq5qyi+
         lr5qkdcZ/yDJwNmHgobWA9YOy2eFCRYZpuSpeMCNgxtZa6rJfWDykLcT9tFq+XkxVQbx
         kiZ4DubCBR8LP8iRl1OAdtcAJwJ3gc1SE53J4ZeLvUz3fb88+a/Iz9rvhQ6toDIzskP5
         kJmg==
X-Gm-Message-State: AOAM531/zkauI4nlJCVDvfjU9dULfDhL9lllr+Nqw1CYjmzZbiEXfx9u
	zfghEc53TawCltJV8cx8CoILoElmkjh28lBLafw=
X-Google-Smtp-Source: ABdhPJx0u/s2yMDJCXGg5GpW8Icb6Q+HLJYgJm+ywZibSvppqJS6F1A6PXlRgWFuBlu6qleS949cAy5jAjahVQkOyd4=
X-Received: by 2002:a6b:c8d0:: with SMTP id y199mr1085841iof.162.1612934302741;
 Tue, 09 Feb 2021 21:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20210205023956.417587-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20210205023956.417587-1-aneesh.kumar@linux.ibm.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 10 Feb 2021 06:18:11 +0100
Message-ID: <CAM9Jb+gS22vbRrSLfTG=9VhJfrMOGvm4r8HB1nBMS4RK9W06FQ@mail.gmail.com>
Subject: Re: [PATCH] mm/pmem: Avoid inserting hugepage PTE entry with fsdax if
 hugepage support is disabled
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: ZWEXZEKFOOLGBKDR76JEHVVC5HZM4XST
X-Message-ID-Hash: ZWEXZEKFOOLGBKDR76JEHVVC5HZM4XST
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Jan Kara <jack@suse.cz>, Linux MM <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZWEXZEKFOOLGBKDR76JEHVVC5HZM4XST/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Differentiate between hardware not supporting hugepages and user disabling THP
> via 'echo never > /sys/kernel/mm/transparent_hugepage/enabled'
>
> For the devdax namespace, the kernel handles the above via the
> supported_alignment attribute and failing to initialize the namespace
> if the namespace align value is not supported on the platform.
>
> For the fsdax namespace, the kernel will continue to initialize
> the namespace. This can result in the kernel creating a huge pte
> entry even though the hardware don't support the same.
>
> We do want hugepage support with pmem even if the end-user disabled THP
> via sysfs file (/sys/kernel/mm/transparent_hugepage/enabled). Hence
> differentiate between hardware/firmware lacking support vs user-controlled
> disable of THP and prevent a huge fault if the hardware lacks hugepage
> support.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/huge_mm.h | 15 +++++++++------
>  mm/huge_memory.c        |  6 +++++-
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 6a19f35f836b..ba973efcd369 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -78,6 +78,7 @@ static inline vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn,
>  }
>
>  enum transparent_hugepage_flag {
> +       TRANSPARENT_HUGEPAGE_NEVER_DAX,
>         TRANSPARENT_HUGEPAGE_FLAG,
>         TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>         TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
> @@ -123,6 +124,13 @@ extern unsigned long transparent_hugepage_flags;
>   */
>  static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  {
> +
> +       /*
> +        * If the hardware/firmware marked hugepage support disabled.
> +        */
> +       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> +               return false;
> +
>         if (vma->vm_flags & VM_NOHUGEPAGE)
>                 return false;
>
> @@ -134,12 +142,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>
>         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>                 return true;
> -       /*
> -        * For dax vmas, try to always use hugepage mappings. If the kernel does
> -        * not support hugepages, fsdax mappings will fallback to PAGE_SIZE
> -        * mappings, and device-dax namespaces, that try to guarantee a given
> -        * mapping size, will fail to enable
> -        */
> +
>         if (vma_is_dax(vma))
>                 return true;
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9237976abe72..d698b7e27447 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -386,7 +386,11 @@ static int __init hugepage_init(void)
>         struct kobject *hugepage_kobj;
>
>         if (!has_transparent_hugepage()) {
> -               transparent_hugepage_flags = 0;
> +               /*
> +                * Hardware doesn't support hugepages, hence disable
> +                * DAX PMD support.
> +                */
> +               transparent_hugepage_flags = 1 << TRANSPARENT_HUGEPAGE_NEVER_DAX;
>                 return -EINVAL;
>         }

 Reviewed-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

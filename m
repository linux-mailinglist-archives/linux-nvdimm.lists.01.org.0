Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3182E9EA9
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Jan 2021 21:13:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B8FD8100EC1E1;
	Mon,  4 Jan 2021 12:13:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3FBD6100EC1C4
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 12:13:09 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id 6so38428170ejz.5
        for <linux-nvdimm@lists.01.org>; Mon, 04 Jan 2021 12:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kOBICLhgLGGyrBsGRMV3d/XVZVOrn09qft6qb67hiE=;
        b=b7+VQwx/HUQzT1Lln1PrW9cd3nW1D010dCcBMbiDuL8w8T2cMiST0QajPYCyO9SBTy
         E+7xVOhLrFVJHR+eUx1Ij+VS2X57fazwKoDionRO4qDeMd7X03I234SRmEUAPqe2R5Xa
         ILlc302XjgoH5Sb9Yqfte/wMcpHbdyYWLbrxXh4dys0bF7YG4zkHLzESiH5c7HdCyToB
         1fXlQ/L7kIH37aSQ7TFVTIolgaJRkFT5ppz+EOR/Qk4YOCFsVgzztEwTaOK4xAnSZ/xw
         nNEP6gn0mObJwoCPXe0QJbplu6Itl2Ty79I28i8dSDWE0XtVR5Sxh2PCd/D8T2JoHd3K
         JLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kOBICLhgLGGyrBsGRMV3d/XVZVOrn09qft6qb67hiE=;
        b=ZTcxWKt1LBpoTSyuQf6SXjTh4rBeVBVCLlXGjLCdlEBlf4aZ7Pvj+sdGKzmIJ9Zkr2
         TNel2J9iOMA2D4SQ4FITYkV2njcvXWDrj8yan1HpLjyvEZmaJqv+0sCxSpfL9yIzfUEc
         sjbrwLVZrjLW6iP015hH2wt1eGFIvNrqcc8csUUw8R+lHjJy95EK4LxPWqXkr77Umu+/
         1h8ZoeAloYrKWvG4l8hS1Nzt8lpAntUUME6uPsX1DfCHBHoiPRi2eI7MLvJkmf4GB8EE
         VuP8fzyvIx4yeqkt7etevJ7NHwULVf7K2oUX4ZzyjnSvB9zkGdvodaG7frw/0VsBGyH0
         M9GQ==
X-Gm-Message-State: AOAM533vfuW+KAToBUSBpTrdM+gJnKVSCBd1twjJGtdYvYX8pdsjYa3w
	VJ92SIXijv/pRXz1EzU3a5n54qClkDKTqzoRiG4uhQ==
X-Google-Smtp-Source: ABdhPJy+4iAG8xX6k5boBafJrxqqiEEzN3EesBcv4x2KpEgiPAMRNtZVgnB3PFS5lgHiTfJrc6ChogC2RZDjLmvXQ/E=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr68530499ejc.418.1609791188031;
 Mon, 04 Jan 2021 12:13:08 -0800 (PST)
MIME-Version: 1.0
References: <20210101042914.5313-1-rdunlap@infradead.org>
In-Reply-To: <20210101042914.5313-1-rdunlap@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Jan 2021 12:13:02 -0800
Message-ID: <CAPcyv4jAiqyFg_BUHh_bJRG-BqzvOwthykijRapB_8i6VtwTmQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
To: Randy Dunlap <rdunlap@infradead.org>
Message-ID-Hash: 7EAME2BMBOYPUEKJIQICP7K7KJTEDKO2
X-Message-ID-Hash: 7EAME2BMBOYPUEKJIQICP7K7KJTEDKO2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupts@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7EAME2BMBOYPUEKJIQICP7K7KJTEDKO2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 31, 2020 at 8:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> fs/dax.c uses copy_user_page() but ARC does not provide that interface,
> resulting in a build error.
>
> Provide copy_user_page() in <asm/page.h> (beside copy_page()) and
> add <asm/page.h> to fs/dax.c to fix the build error.
>
> ../fs/dax.c: In function 'copy_cow_page_dax':
> ../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]
>
> Fixes: cccbce671582 ("filesystem-dax: convert to dax_direct_access()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Vineet Gupta <vgupts@synopsys.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> ---
> v2: rebase, add more Cc:
>
>  arch/arc/include/asm/page.h |    1 +
>  fs/dax.c                    |    1 +
>  2 files changed, 2 insertions(+)
>
> --- lnx-511-rc1.orig/fs/dax.c
> +++ lnx-511-rc1/fs/dax.c
> @@ -25,6 +25,7 @@
>  #include <linux/sizes.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/iomap.h>
> +#include <asm/page.h>

I would expect this to come from one of the linux/ includes like
linux/mm.h. asm/ headers are implementation linux/ headers are api.

Once you drop that then the subject of this patch can just be "arc:
add a copy_user_page() implementation", and handled by the arc
maintainer (or I can take it with Vineet's ack).

>  #include <asm/pgalloc.h>

Yes, this one should have a linux/ api header to front it, but that's
a cleanup for another day.

>
>  #define CREATE_TRACE_POINTS
> --- lnx-511-rc1.orig/arch/arc/include/asm/page.h
> +++ lnx-511-rc1/arch/arc/include/asm/page.h
> @@ -10,6 +10,7 @@
>  #ifndef __ASSEMBLY__
>
>  #define clear_page(paddr)              memset((paddr), 0, PAGE_SIZE)
> +#define copy_user_page(to, from, vaddr, pg)    copy_page(to, from)
>  #define copy_page(to, from)            memcpy((to), (from), PAGE_SIZE)
>
>  struct vm_area_struct;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

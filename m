Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F76320276
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 02:24:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 068B7100EBB97;
	Fri, 19 Feb 2021 17:24:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 54A43100EBB8D
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:24:19 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g5so17272339ejt.2
        for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OI5diTT0Rk6aefWjwmf2Q0VLq/9wnZnAvXpY8uK5nUQ=;
        b=zJfceaRPvyJ6XZa2IRAPEjVVrbFYpp8LYpGQ3my7yGihQIEhzjOCVxmTiO2uw4T73u
         2jk3Kb3huR1HG20iemJlm8FOxMT9lJ2P4dszGflF0jW0bKFGsS4TA2Vxw0kW9N2uCoBj
         F6aoBFfaGVoP+nnQ8z6hWWxZgRIDNLm144edAxTalfKaXHfJvOGEHzG5SWx/xU0GA4aM
         TUlLVu1u53Vf65vMDCwbLfLR/XGx/sSDa7ifiTleuevxNChFpoI8RbX76fnrHEvI5QU/
         xR2Qyp51J8IaK4ZyiCfWPQ61mkF00O41wSjPMXtviS5Ak/qyvtQjPYO5gbBEALVImwEF
         to2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OI5diTT0Rk6aefWjwmf2Q0VLq/9wnZnAvXpY8uK5nUQ=;
        b=ZTgrxumVpoYdEBcUc5aXxBeXDNUGkhLdT/YDXGFhN5HoYi5ICUVdxJ8eXaZofSVyKy
         DcQ6diMj+JFlAJ9vhLgLtwlP8Wmh4FffkFz52XMlHeuIR4kI4qRES+yAdAgbND0Bk2UO
         eq2j+wfW0hN8wUDR2if8U/T61Xhd/J6/MSrBojDJXMBmBDJAf83DQltxnNuUWZqXPc9r
         JL30JPH+BBAbI2cVLR4xGyffIZm2mlFhyLk/1KIbINOI4CMGqtIjOfK3DW8GkiZWq2kx
         kh2TXmPd8cCQC9DnEf0wiPqC/Bn73dmBuFQ31bOthAht4IyK0CLbMbz/fyIFh2nh6cF3
         F4Zg==
X-Gm-Message-State: AOAM532OUO2I0hiemSaxAskwGJvpUxhuEYVCv8p9JDw3G+YcGRqvbDha
	m6TWXCgJfFmWlUOKAR1Oh4xkDx6BzlxIw1E++onWGA==
X-Google-Smtp-Source: ABdhPJyjHZZthx7MXPgxEnYR0n72AWETmXUIaUMfKn+DeqJXKwrmkbsGa/sIRoVbcrPAlQ6imr1TpcrwgPxKoAq3ajU=
X-Received: by 2002:a17:906:cc91:: with SMTP id oq17mr10915211ejb.45.1613784257719;
 Fri, 19 Feb 2021 17:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com> <20201208172901.17384-2-joao.m.martins@oracle.com>
In-Reply-To: <20201208172901.17384-2-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Feb 2021 17:24:09 -0800
Message-ID: <CAPcyv4g8AEaxOcPHQNG7pgaYJHOtthcFogroGoPg2f8Fu6SN=g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound pages
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: OCPXUZ3O66CYU5NMH2VXWA562UISG7EW
X-Message-ID-Hash: OCPXUZ3O66CYU5NMH2VXWA562UISG7EW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OCPXUZ3O66CYU5NMH2VXWA562UISG7EW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Add a new flag for struct dev_pagemap which designates that a a pagemap
> is described as a set of compound pages or in other words, that how
> pages are grouped together in the page tables are reflected in how we
> describe struct pages. This means that rather than initializing
> individual struct pages, we also initialize these struct pages, as
> compound pages (on x86: 2M or 1G compound pages)
>
> For certain ZONE_DEVICE users, like device-dax, which have a fixed page
> size, this creates an opportunity to optimize GUP and GUP-fast walkers,
> thus playing the same tricks as hugetlb pages.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/linux/memremap.h | 2 ++
>  mm/memremap.c            | 8 ++++++--
>  mm/page_alloc.c          | 7 +++++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 79c49e7f5c30..f8f26b2cc3da 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -90,6 +90,7 @@ struct dev_pagemap_ops {
>  };
>
>  #define PGMAP_ALTMAP_VALID     (1 << 0)
> +#define PGMAP_COMPOUND         (1 << 1)

Why is a new flag needed versus just the align attribute? In other
words there should be no need to go back to the old/slow days of
'struct page' per pfn after compound support is added.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

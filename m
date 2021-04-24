Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417D0369DAD
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Apr 2021 02:16:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 98C92100EAB03;
	Fri, 23 Apr 2021 17:16:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA52E100EAAFC
	for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 17:16:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j12so34204141edy.3
        for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 17:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/uh3+B4XuoxsCrq3rYabHaGGWXFYs+Y4T04wxnm3Nw=;
        b=vEfpZojtg8fw3cfDceRI4HjqvLyoMCV8Hxpf2pqKYy7CnCYbXxn4v/SRJ+JV+1YNF+
         bkT2tlZs2nX2GIshFrpgzDt0j8VfiXs09v4BPbZHRXGTC11MRqbgF9zkjHHky6PeOnhz
         AlvWZcYv541dGxjX6+d1MBG740xhcSEW0lYz3wCsiyndxz0ZPchHdnsW1n4biz4B+o9N
         ZRu2b/rIs/UEc1YNxxrBGvmJTza3o3RHB4IPDtQXpEXkNwGO+6rIdWpZt03kGqeY4zwZ
         DWQs5a/ovq9nPpG98DYVYvBa05SzVYfaBklE+1eeYICPRk0k4qiVEyM9Nrlf/7Ldhc/7
         Blvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/uh3+B4XuoxsCrq3rYabHaGGWXFYs+Y4T04wxnm3Nw=;
        b=kyWXltUDsY2AsXjtZfIAXkRI/U1/jCN/EZi2DsCgc/qDJ3qZ3m3yQuumAf83CcI4z8
         9lch4grtKiIGZarFbpw4uD0Z8sZVagvMWPXnTLi/LcaLxESrjUdW7rYJ0BD3mRZLyZw0
         sgWMc6zIA24lqbVVwnHbGCdjgNj6I727JeDkguD9kAOiw5to31EvSqVb2Nxe2VrnLKR7
         lUh0aOQ0BWfMOu/9mGbiEUYu9I5gJeWMBIf1rdgfOAx9CUugtrw5wmlLL55xKdmae1q8
         mOB7bkJizHuUe9qsJsuNUPYOvJhY/elDPyzO8yiMs/Mr0v00he6SMHG9VcxyEpse5idz
         nwuQ==
X-Gm-Message-State: AOAM532vc0C/gdleGfkj2WQKCZCGymxPHOZQagB17MjaqXESm1osbEEx
	nu+fQPT5Qx6CX1M8Y4lMO15lDQGbQ1GuinTcxvxygg==
X-Google-Smtp-Source: ABdhPJyr+nWFUeRB/31XPMGbxG182hpB631BFplB/xl3H7HTZZvEhyoCUuto/u3J+7UzagRMIbKR05/dmKhjNRBbxAY=
X-Received: by 2002:a50:e607:: with SMTP id y7mr7558321edm.18.1619223375444;
 Fri, 23 Apr 2021 17:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210325230938.30752-1-joao.m.martins@oracle.com> <20210325230938.30752-3-joao.m.martins@oracle.com>
In-Reply-To: <20210325230938.30752-3-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 23 Apr 2021 17:16:09 -0700
Message-ID: <CAPcyv4jrdrKXhnoWKPRUE+McjP_7BOrG8GYBoeGP1s9-aF5FxQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] mm/page_alloc: split prep_compound_page into
 head and tail subparts
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: 4UWI3LWA2BEOWZQ2OLANQURBID2Q2G3S
X-Message-ID-Hash: 4UWI3LWA2BEOWZQ2OLANQURBID2Q2G3S
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4UWI3LWA2BEOWZQ2OLANQURBID2Q2G3S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Split the utility function prep_compound_page() into head and tail
> counterparts, and use them accordingly.

To make this patch stand alone better lets add another sentence:

"This is in preparation for sharing the storage for / deduplicating
compound page metadata."

Other than that, looks good to me.

>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  mm/page_alloc.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c53fe4fa10bf..43dd98446b0b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -692,24 +692,34 @@ void free_compound_page(struct page *page)
>         __free_pages_ok(page, compound_order(page), FPI_NONE);
>  }
>
> +static void prep_compound_head(struct page *page, unsigned int order)
> +{
> +       set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
> +       set_compound_order(page, order);
> +       atomic_set(compound_mapcount_ptr(page), -1);
> +       if (hpage_pincount_available(page))
> +               atomic_set(compound_pincount_ptr(page), 0);
> +}
> +
> +static void prep_compound_tail(struct page *head, int tail_idx)
> +{
> +       struct page *p = head + tail_idx;
> +
> +       set_page_count(p, 0);
> +       p->mapping = TAIL_MAPPING;
> +       set_compound_head(p, head);
> +}
> +
>  void prep_compound_page(struct page *page, unsigned int order)
>  {
>         int i;
>         int nr_pages = 1 << order;
>
>         __SetPageHead(page);
> -       for (i = 1; i < nr_pages; i++) {
> -               struct page *p = page + i;
> -               set_page_count(p, 0);
> -               p->mapping = TAIL_MAPPING;
> -               set_compound_head(p, page);
> -       }
> +       for (i = 1; i < nr_pages; i++)
> +               prep_compound_tail(page, i);
>
> -       set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
> -       set_compound_order(page, order);
> -       atomic_set(compound_mapcount_ptr(page), -1);
> -       if (hpage_pincount_available(page))
> -               atomic_set(compound_pincount_ptr(page), 0);
> +       prep_compound_head(page, order);
>  }
>
>  #ifdef CONFIG_DEBUG_PAGEALLOC
> --
> 2.17.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

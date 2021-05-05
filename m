Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8C374B78
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 00:43:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7EE5100F2265;
	Wed,  5 May 2021 15:43:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2741D100F225D
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 15:43:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u21so5275665ejo.13
        for <linux-nvdimm@lists.01.org>; Wed, 05 May 2021 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nvaxztmfklo30iHGOAJEqLM9P4mCfCGwm4q3ZK7i77c=;
        b=UJPAEfLhF+rVabmM7VlnWvBKKsPssvNrRVZmUeyt4UpQXUSyrhTqJSQhT5Z1GJidhR
         R4iBStO0YbYvC5BW+EME7tGWmVaCjjHwtjU5WnQtofVUBhmoUI3oLmQC66TXR4k0ayYb
         kwz+S0vPlzYbnIkNc9RZMlpea1Nbmdki0CkHjAAErriVXtoJeyhLiTs7y/iudUm0fjHi
         mXsK47NC8ntnbqQf7pao3EmfbMCx4UFkRmEKwH/l/txaPS40nFB+MSCewZpvd67NxyJc
         JaKO9nRYhfAtIwFq/1erh2L+B5RmKnZsw47cqN1O0zRj/gC8rIqnPPJgkRgCtqVdMUKS
         W5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nvaxztmfklo30iHGOAJEqLM9P4mCfCGwm4q3ZK7i77c=;
        b=ThUgWDVDTxStT68f5Iq3NbyCbIwGIR0mt8YqjSePp9P0kYXyJ6sjYhy62sQrwjPUWB
         zRsHleg323nLvX4qAv5IlJIswIuESWEkjrr5gN3234Ttkl8OdzSD1f6lz+IyT8e5w5nY
         PqDFYehmCe9q2sMLZtixwk536D8e+pr9yWUfHnowOuXB2Oh0cnTrkUOjQQpe9EJEKIn/
         XTGwQj1gl+HMQh+psdexKQOQpU/bl8ldLRTzaW8QK227MNALABu6SUDAhaEw4H55JaIQ
         HkEaYU0tFWHVAoNzRwPa4cJaIzz4a8l8Ugp8NJEhCW1/b/v1oxF3T4ZcMBzqLm0Kltx8
         ah9g==
X-Gm-Message-State: AOAM533NjQoZdeX7jtUe4OkiQTxy+KpCPP2y8SkpIJjgc2pkqo7D8/Ue
	3Utq9BIaakRN9/IrgQLTQcwSTeFqQOzv/hY4iAkODvuoTS6WBw==
X-Google-Smtp-Source: ABdhPJyCbCSofL1hxtVo0x0BHI2PTY2fQtKJRbrlNPbsxe1SXgwZusVYhquFtBwiMOhDNyy7b5YByLTaLT3jXhF4j/o=
X-Received: by 2002:a17:906:3ec1:: with SMTP id d1mr1020808ejj.523.1620254618614;
 Wed, 05 May 2021 15:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210325230938.30752-1-joao.m.martins@oracle.com> <20210325230938.30752-7-joao.m.martins@oracle.com>
In-Reply-To: <20210325230938.30752-7-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 May 2021 15:43:43 -0700
Message-ID: <CAPcyv4gf_gc6pGSZYaDp3A++enFF1aTdDVA2YbxHX_v_TM3rpg@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm/sparse-vmemmap: refactor vmemmap_populate_basepages()
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: OU3KJLE5GTXD3PKHCYKCAM6K2JETCG62
X-Message-ID-Hash: OU3KJLE5GTXD3PKHCYKCAM6K2JETCG62
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OU3KJLE5GTXD3PKHCYKCAM6K2JETCG62/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I suspect it's a good sign I'm only finding cosmetic and changelog
changes in the review... I have some more:

A year for now if I'm tracking down a problem and looking through mm
commits I would appreciate a subject line like the following:
"refactor core of vmemmap_populate_basepages() to helper" that gives
an idea of the impact and side effects of the change.

On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>

I would add a lead in phrase like: "In preparation for describing a
memmap with compound pages, move the actual..."

> Move the actual pte population logic into a separate function
> vmemmap_populate_address() and have vmemmap_populate_basepages()
> walk through all base pages it needs to populate.

Aside from the above, looks good.

>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  mm/sparse-vmemmap.c | 44 ++++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 370728c206ee..8814876edcfa 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -216,33 +216,41 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
>         return pgd;
>  }
>
> -int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
> -                                        int node, struct vmem_altmap *altmap)
> +static int __meminit vmemmap_populate_address(unsigned long addr, int node,
> +                                             struct vmem_altmap *altmap)
>  {
> -       unsigned long addr = start;
>         pgd_t *pgd;
>         p4d_t *p4d;
>         pud_t *pud;
>         pmd_t *pmd;
>         pte_t *pte;
>
> +       pgd = vmemmap_pgd_populate(addr, node);
> +       if (!pgd)
> +               return -ENOMEM;
> +       p4d = vmemmap_p4d_populate(pgd, addr, node);
> +       if (!p4d)
> +               return -ENOMEM;
> +       pud = vmemmap_pud_populate(p4d, addr, node);
> +       if (!pud)
> +               return -ENOMEM;
> +       pmd = vmemmap_pmd_populate(pud, addr, node);
> +       if (!pmd)
> +               return -ENOMEM;
> +       pte = vmemmap_pte_populate(pmd, addr, node, altmap);
> +       if (!pte)
> +               return -ENOMEM;
> +       vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
> +}
> +
> +int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
> +                                        int node, struct vmem_altmap *altmap)
> +{
> +       unsigned long addr = start;
> +
>         for (; addr < end; addr += PAGE_SIZE) {
> -               pgd = vmemmap_pgd_populate(addr, node);
> -               if (!pgd)
> -                       return -ENOMEM;
> -               p4d = vmemmap_p4d_populate(pgd, addr, node);
> -               if (!p4d)
> -                       return -ENOMEM;
> -               pud = vmemmap_pud_populate(p4d, addr, node);
> -               if (!pud)
> -                       return -ENOMEM;
> -               pmd = vmemmap_pmd_populate(pud, addr, node);
> -               if (!pmd)
> -                       return -ENOMEM;
> -               pte = vmemmap_pte_populate(pmd, addr, node, altmap);
> -               if (!pte)
> +               if (vmemmap_populate_address(addr, node, altmap))
>                         return -ENOMEM;
> -               vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
>         }
>
>         return 0;
> --
> 2.17.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA410F43E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 01:51:00 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ACF5E10113637;
	Mon,  2 Dec 2019 16:54:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D4C3210113634
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 16:54:17 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id b8so1652392oiy.5
        for <linux-nvdimm@lists.01.org>; Mon, 02 Dec 2019 16:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KYwlF63SvVl9zvd7kjkiyaaPgfwW7BR11F8RXtCdLo=;
        b=MTvaMflRHI4pLeqCbUeYDfLDz6DWAEDVTfpR79PDYXX7x6WtPjswiiMDHng89WW4bR
         kk6fpeQUA8XDt7465M2Vcba0SHU9DJjO/ttcmBQziw5Ge57Qz3ydsShP7zXLQfVM7pVC
         cFygzBSGRe1oz5txdb/JfSVxt2FzltaHFbNIp3KPKcHBKgEn4/bW8rJOcqpRJW+Id6B+
         5O0hiycA6Ftwi1V7HgVapDFQZpsTjp7/dggJ5TLf9tCFG7TJUJfzOgd13HlMtFbOuxvp
         wvgrhzCnr0I4FjxX/YUIWoZElA1ZVuAojFBzfiryQDvxZbM1PzNUWy0TSfUPYEhqt9pq
         ighw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KYwlF63SvVl9zvd7kjkiyaaPgfwW7BR11F8RXtCdLo=;
        b=EoC0GTByUKozSoyvGEboUUsqIS3mE440GWX2EiRZJfVr1hOsBMupBuUsuKG5LYdFrc
         g5lNWNHu9CP+a5pkQ1kqfn+x73y3NAu1jIBSXem76+oeuXwpz4kG0sF7h5ASN/fdlbpa
         o2N4OPeBangGG3HhbtY46kmz+G6yv7W+fgpguYGPZ9AjVexu5w44eIh8RDFouPfrbc4E
         EuZUnSDQs2TesFksp7zOzZhZJPjMkMT2LO2IOSEjbg4gnkvhNoYP0sAs30EBy0tRE021
         umk9O808mGhaiaNzgP2ddynMp6rqdSZ+foN3VA+qbNzB7CRf6hwklHgNuQ4fNnaMw+SG
         Koww==
X-Gm-Message-State: APjAAAU15Rw8fv4jufJZGR2Gy5cIZAXHY9FiJoTLLaCn8ze3zRhzwOuH
	qPBVvD1sH9dXtwlNiLHUXgooavHy3dCPmMJOtn5KrA==
X-Google-Smtp-Source: APXvYqy+HCMWGNkXsjIVg/HdulhTmdEkI1QVsTFxrTgd36u7R3e/SzRv39SSgSOa9AYRp7RxNhy6wgYdYja/ukTZ/OA=
X-Received: by 2002:a05:6808:1da:: with SMTP id x26mr1635236oic.149.1575334253642;
 Mon, 02 Dec 2019 16:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20190917153129.12905-1-aneesh.kumar@linux.ibm.com>
 <20190919122501.df660f0d23806a3f46d11b61@linux-foundation.org>
 <8736glowyh.fsf@linux.ibm.com> <20191130151317.26c69ef711dba28ff642cca3@linux-foundation.org>
In-Reply-To: <20191130151317.26c69ef711dba28ff642cca3@linux-foundation.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 2 Dec 2019 16:50:42 -0800
Message-ID: <CAPcyv4i_ZsSKpYADbT46_9ab3GuRf=z3DzVCjkSdswF8PgG4dg@mail.gmail.com>
Subject: Re: [PATCH v6] mm/pgmap: Use correct alignment when looking at first
 pfn from a region
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID-Hash: Q4VQBE2ZVOQQVBA46THR3VF2TXT5OFS6
X-Message-ID-Hash: Q4VQBE2ZVOQQVBA46THR3VF2TXT5OFS6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q4VQBE2ZVOQQVBA46THR3VF2TXT5OFS6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Nov 30, 2019 at 3:13 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 25 Sep 2019 09:21:02 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>
> > Andrew Morton <akpm@linux-foundation.org> writes:
> >
> > > On Tue, 17 Sep 2019 21:01:29 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> > >
> > >> vmem_altmap_offset() adjust the section aligned base_pfn offset.
> > >> So we need to make sure we account for the same when computing base_pfn.
> > >>
> > >> ie, for altmap_valid case, our pfn_first should be:
> > >>
> > >> pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);
> > >
> > > What are the user-visible runtime effects of this change?
> >
> > This was found by code inspection. If the pmem region is not correctly
> > section aligned we can skip pfns while iterating device pfn using
> >       for_each_device_pfn(pfn, pgmap)
> >
> >
> > I still would want Dan to ack the change though.
> >
>
> Dan?
>
>
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Subject: mm/pgmap: use correct alignment when looking at first pfn from a region
>
> vmem_altmap_offset() adjusts the section aligned base_pfn offset.  So we
> need to make sure we account for the same when computing base_pfn.
>
> ie, for altmap_valid case, our pfn_first should be:
>
> pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);
>
> This was found by code inspection. If the pmem region is not correctly
> section aligned we can skip pfns while iterating device pfn using
>
>         for_each_device_pfn(pfn, pgmap)
>
> [akpm@linux-foundation.org: coding style fixes]
> Link: http://lkml.kernel.org/r/20190917153129.12905-1-aneesh.kumar@linux.ibm.com
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  mm/memremap.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> --- a/mm/memremap.c~mm-pgmap-use-correct-alignment-when-looking-at-first-pfn-from-a-region
> +++ a/mm/memremap.c
> @@ -55,8 +55,16 @@ static void pgmap_array_delete(struct re
>
>  static unsigned long pfn_first(struct dev_pagemap *pgmap)
>  {
> -       return PHYS_PFN(pgmap->res.start) +
> -               vmem_altmap_offset(pgmap_altmap(pgmap));
> +       const struct resource *res = &pgmap->res;
> +       struct vmem_altmap *altmap = pgmap_altmap(pgmap);
> +       unsigned long pfn;
> +
> +       if (altmap)
> +               pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
> +       else
> +               pfn = PHYS_PFN(res->start);

This would only be a problem if res->start is not subsection aligned.
Is that bug triggering in your case, or is this just inspection. Now
that the subsections can be assumed as the minimum mapping granularity
I'd rather see a cleanup  I'd rather cleanup the implementation to
eliminate altmap->base_pfn or at least assert that
PHYS_PFN(res->start) and altmap->base_pfn are always identical.

Otherwise ->base_pfn is supposed to be just a convenient way to recall
the bounds of the memory hotplug operation deeper in the vmemmap
setup.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

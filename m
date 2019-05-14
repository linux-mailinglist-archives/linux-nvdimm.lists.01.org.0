Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 536151C120
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 05:58:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 700BA212746D0;
	Mon, 13 May 2019 20:58:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6E6172125ADD6
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 20:58:51 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 203so11042099oid.13
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 20:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cdKct2xWm3ro0UBx8IVBS27dWaO8IEoUZaes/VXIAl4=;
 b=A2pj2SEKTSfipz0FKt48998bkaQjibSO0LrmPxJdhCviFLeLqezE2NwsTX4vLH0VNN
 7xPjJIoF74QtRsYvEoXUHinuYdzzF5t1YPQzLcoSf1zZyfajYgYJytcipJK5FUl4Mlny
 oviyWw8fv6yYkIB25nhyDFRvcpnhzsjlwirqdt/oOQWZcHncrbGzYhiTtAjHM/VwdoEx
 Z465FZGgCDqTJ0zF4ouRHd18tdhCEBUne41N5akjLyQ8er4GGX4sekH7adfb/pd/UYoX
 0JlPQOYpuryFUc7/W+CvrWhxds7OkTfp/G5tbIeQgp+qUrgpiMmQ0vY4MNA4R4UcIx9f
 VCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cdKct2xWm3ro0UBx8IVBS27dWaO8IEoUZaes/VXIAl4=;
 b=ZYtK8vDle15hGowizvdD9cydxV7kyxNU2hgxjUXauWNrqeLU6N5pPaUG5L8XzOP621
 F1mcgFNqRY8CzHwbEzSCTwafawFV8aY1GahtpINK/wdYCIABDKJozmnwSRhX5AZqVeJe
 NPpOgelnFiOnCo4CvzBL/Ut9zqbdbKyQl6aNf3H2fLJ62Mv1L0ksPAFCRoiJOVGdagDY
 XH0ZQhBV0ox8bYIIPJLAN2yBQMhgZKO+dPUTSEBevzGyjxlM7Ywoyfm+jwdJ7y6OQNNv
 heCLhuWf/lloJBH2uSbGPem5hVlPM6P6/95moggduNVAJ46I0zEs/e22YEMXmjbor8p3
 7W0A==
X-Gm-Message-State: APjAAAVhTPnjxh5cVt0c2v6TZWVYZGKocvNZ3qpq05QyY+fhixeB9HK0
 EykgBsuHGpkzfnz8HJVfpCGA4h6bmSeKiwUMKz/BJA==
X-Google-Smtp-Source: APXvYqyCSekgO8kXJLyc6cL4sAJ4FYAjlvDT7H8G1xatSOxF0udFUauTtFneyF1PCwUl001x8VvXU+z2TeI3qINqNDY=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr1650949oie.73.1557806330382;
 Mon, 13 May 2019 20:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190514025604.9997-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190514025604.9997-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 13 May 2019 20:58:38 -0700
Message-ID: <CAPcyv4iNgFbSq0Hqb+CStRhGWMHfXx7tL3vrDaQ95DcBBY8QCQ@mail.gmail.com>
Subject: Re: [PATCH] mm/nvdimm: Use correct #defines instead of opencoding
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Linux MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, May 13, 2019 at 7:56 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> The nfpn related change is needed to fix the kernel message
>
> "number of pfns truncated from 2617344 to 163584"
>
> The change makes sure the nfpns stored in the superblock is right value.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/pfn_devs.c    | 6 +++---
>  drivers/nvdimm/region_devs.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 347cab166376..6751ff0296ef 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -777,8 +777,8 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
>                  * when populating the vmemmap. This *should* be equal to
>                  * PMD_SIZE for most architectures.
>                  */
> -               offset = ALIGN(start + reserve + 64 * npfns,
> -                               max(nd_pfn->align, PMD_SIZE)) - start;
> +               offset = ALIGN(start + reserve + sizeof(struct page) * npfns,
> +                              max(nd_pfn->align, PMD_SIZE)) - start;

No, I think we need to record the page-size into the superblock format
otherwise this breaks in debug builds where the struct-page size is
extended.

>         } else if (nd_pfn->mode == PFN_MODE_RAM)
>                 offset = ALIGN(start + reserve, nd_pfn->align) - start;
>         else
> @@ -790,7 +790,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
>                 return -ENXIO;
>         }
>
> -       npfns = (size - offset - start_pad - end_trunc) / SZ_4K;
> +       npfns = (size - offset - start_pad - end_trunc) / PAGE_SIZE;

Similar comment, if the page size is variable then the superblock
needs to explicitly account for it.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

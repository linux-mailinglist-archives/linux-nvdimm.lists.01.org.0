Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62E369DAA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Apr 2021 02:12:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3E6F1100EAAFC;
	Fri, 23 Apr 2021 17:12:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2ACA2100F2274
	for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 17:12:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r20so26468271ejo.11
        for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 17:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHr7tUOXaQai/2OdZAuZvtKoquZIqzNXavanHLPXua4=;
        b=Zx4YtT/ak9bAKuxFjeh83s+2vCvsnhqW3WCOWH4QzP7FZDumo/tG8NEFlLRf/X/sbx
         YFUhP9uRlqwpI3tvdp2tiW7FVEXDjWLkB88vK9RtxYeM+kx5snSvvD+2Ugvc1PRL1saF
         uH/CLk8Mcqrg2WyECWStWddk61woeHpnR4f4uyysEdWMMKR/fzCtR11lVV65qWR6Iq+E
         c1fXjIlaM9+x9Jl1n005XVF0hQnEyoDeQu7d50p+OzI4PLRAJHKlMs5ToOR01asCBMk8
         SG44A7i5NlRMdVttNuSG8NcItte4Gkfk044vNafdlz1AMqgObu+XiIuTsP1TtksYy+N6
         fuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHr7tUOXaQai/2OdZAuZvtKoquZIqzNXavanHLPXua4=;
        b=pmlNI0BDDWpVshFzVJ7mgd+Ks7EAkhJs+iLll2hD1RVqkR5L6f11IK/1/AvE5K+V2/
         xy08dE71Tm3RQt2t2nOJNBGFFDcYOlaTmUGLueEtSFq4CfXrOjV6UbUm4WBO5PVZzvqO
         1J/iz9knMPqtqygU976LO2Xw813BFgn/v5WmLgnFtDziPhnsXd0p+bHNOCYRrgwSIfh3
         k2sVedBxkl8efK1s+JmSZysRLZv51iOk/hr9nmHNKjGZoYFdfdXLnoUDHwiWifHtg/Us
         UCXy2oFV0AfaXNi5saOI1wKLeU9aqjhuL4wD3Mz4mBMtnIDScDOwJV1zlrw7WEwZSJVH
         2Vsw==
X-Gm-Message-State: AOAM533bfqkI9DaNOqe62XrIvMrJkp8z+/HJT1WoAkGuIUAVIjNcs+5D
	p6r+ryOXJLPJRPQorMt3xX7tgjDfUL9/kZlKmE3aQA==
X-Google-Smtp-Source: ABdhPJxw0VS3dz3A1xGOFxbEhcW7vCcLHVEkly52DIWEjT1QLF7rLt2Jx7ufHOUIpby/EW/WDEEg9aMUXcjUacu5Jzk=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr6812547ejc.418.1619223143985;
 Fri, 23 Apr 2021 17:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210325230938.30752-1-joao.m.martins@oracle.com> <20210325230938.30752-2-joao.m.martins@oracle.com>
In-Reply-To: <20210325230938.30752-2-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 23 Apr 2021 17:12:18 -0700
Message-ID: <CAPcyv4hCRZ9Dacmbv8kP-4g4DkD6HvO0OSzzaXWLQhKa-r_fXQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] memory-failure: fetch compound_head after pgmap_pfn_valid()
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: DKU4AO3JGN23TM345SD7W6CZWOVCOERS
X-Message-ID-Hash: DKU4AO3JGN23TM345SD7W6CZWOVCOERS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DKU4AO3JGN23TM345SD7W6CZWOVCOERS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> memory_failure_dev_pagemap() at the moment assumes base pages (e.g.
> dax_lock_page()).  For pagemap with compound pages fetch the
> compound_head in case we are handling a tail page memory failure.
>
> Currently this is a nop, but in the advent of compound pages in
> dev_pagemap it allows memory_failure_dev_pagemap() to keep working.
>
> Reported-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  mm/memory-failure.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 24210c9bd843..94240d772623 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1318,6 +1318,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>                 goto out;
>         }
>
> +       page = compound_head(page);

Unless / until we do compound pages for the filesystem-dax case, I
would add a comment like:

/* pages instantiated by device-dax (not filesystem-dax) may be
compound pages */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C22EC1C161
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 06:29:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1644A212746D6;
	Mon, 13 May 2019 21:29:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 85D1B2121797E
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 21:29:40 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y10so11086339oia.8
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 21:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6vL7R6NOOH4/SZmC8qbbcIighH9Rr6CdIXeg8QuQUhw=;
 b=ca7lJ9q1TJHOspurY5SiG+tHkkdWZroHZnYXr6E1fYxTHIglIKUUCOOdV0IxjunZzr
 +zcp8l1ucKONHdlsOcEiB2Zy9W9Pni/ehn3I2g/oEjDJLcZKRAb2UaLPO8k8MQCtRQX+
 ygYmAqQCzVfQKkhtwKl8RVXgOpV9BbBWb1iCf1p9juBMVTtoRq7zo9b79O9kM9J+q+yt
 9KC4mIC5sgRMvbh0rjBGPLV87kAnDQ7Y0Cf+VI9uvMjJjlqzD51foAlUir32+gYxLWsB
 k7wTsfd4zq5WbTXDUqS9sBC7lUUFQo5ZjJZQcy6DReMx5iYolN0vSuVSggR2SNCwWpDB
 R4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6vL7R6NOOH4/SZmC8qbbcIighH9Rr6CdIXeg8QuQUhw=;
 b=ETfIWD2mF+XwDq5dPhR3w4wN+03LQzF+ZMbSj8w2u3vEEILyDUlXLYWHPSIhmkTOAJ
 3vIudX1AFCC98nz76jZVUg7RQ3Xi+aMMLRelMHa3U7t250zXScg666G3rMYxlKjQU9Ya
 92Ahe3ojpdqTfvqLwIRImcpPKvwsFF+utEdvfDbrmqRjUT7zVrPmRJjFfTN+1/Ueqwym
 d+SqDSb5vUXkBmdMu9pnWQwMFg9iJssVenH0a12kvLMK42pu+oPoxY3kytf3/5ZkDoQ1
 p6g1PIpos+7ADzhiuWiz2IsJNmDUm5CtdFyjuI3hKyKtg3UxQMdIeVVulOWtU2fYoHiK
 LVmw==
X-Gm-Message-State: APjAAAXhc+JkCOevRa21bzR4TI4rCuF4E7j/juNEmxObSam+BykSlRlW
 rSMqYngiZabWHO2pdqrAQdw9pG35ptxu+Iq6jEHq7Q==
X-Google-Smtp-Source: APXvYqzLwmq4m9vHhU9l+xYTiYeGeku1c2XDiTm1WK0D+0mp/qoqdLnVFB1/BBjQKk2+37HqJ9cVipeEEeNJglytCCU=
X-Received: by 2002:aca:4208:: with SMTP id p8mr1834968oia.105.1557808179717; 
 Mon, 13 May 2019 21:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190514025512.9670-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190514025512.9670-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 13 May 2019 21:29:28 -0700
Message-ID: <CAPcyv4hgNUDxjgYNkxOXJ9hfLb6z2+E1yasNoZNDKFUxkCzWLA@mail.gmail.com>
Subject: Re: [PATCH] mm/nvdimm: Use correct alignment when looking at first
 pfn from a region
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

On Mon, May 13, 2019 at 7:55 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> We already add the start_pad to the resource->start but fails to section
> align the start. This make sure with altmap we compute the right first
> pfn when start_pad is zero and we are doing an align down of start address.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  kernel/memremap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index a856cb5ff192..23d77b60e728 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -59,9 +59,9 @@ static unsigned long pfn_first(struct dev_pagemap *pgmap)
>  {
>         const struct resource *res = &pgmap->res;
>         struct vmem_altmap *altmap = &pgmap->altmap;
> -       unsigned long pfn;
> +       unsigned long pfn = PHYS_PFN(res->start);
>
> -       pfn = res->start >> PAGE_SHIFT;
> +       pfn = SECTION_ALIGN_DOWN(pfn);

This does not seem right to me it breaks the assumptions of where the
first expected valid pfn occurs in the passed in range.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

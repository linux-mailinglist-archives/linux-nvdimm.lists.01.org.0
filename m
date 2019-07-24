Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E104B723BE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jul 2019 03:34:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D42A1212D2756;
	Tue, 23 Jul 2019 18:37:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E927C212BF9A7
 for <linux-nvdimm@lists.01.org>; Tue, 23 Jul 2019 18:37:13 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j11so21888409otp.10
 for <linux-nvdimm@lists.01.org>; Tue, 23 Jul 2019 18:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U3S9mbYQLIeM0ynsPRK/801CRvgA1ufAcDvniZwp830=;
 b=NIHnQ29XndgfKPymWUi4yCNTFzpjOZnMhr6bsTZB/j9y6eMoCeLVi6Dm5xvBoVW+jE
 cu9IC2dU8ELh6LxXosO/8+NswDEPLR4BVdkJ/XSRLQTdO6SwWN61AksT6xo9Y0fi7WK4
 RZS4lBpADWJx1DCy0g3mNSKJNCpfvTBFjFJ1vAyDqPuGsjTQArJFxKs3nTsA7SlHVEWm
 w1gtupAQNyKPb3EMka9H+PVSrrilnnJWOJ0et2zG3p2ZdGZBMeZpozbnAe58eR1jtRYv
 6zIzbzA7RZKx5F+EVm58P7n81tvifE9nKmOufZseqqbEjPbnzNhMV4C2NO/gHodcAPow
 5ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U3S9mbYQLIeM0ynsPRK/801CRvgA1ufAcDvniZwp830=;
 b=Sld7HmycmiYv9C416MNsIj6MzVBJlBAvtqZIqQFbrb7Fu7ZgkTwxWFDB5OiYekveC6
 ok9OE+DB8n8XbVxsAvw4IS6p3cYb+USkuhIqGfoQfef796r0Z9A+cvtOmyPfhvwY+cET
 V/vFClLioes+sPhi+0O1KERvWldH99lw14x9bxKq6GVNsqSW/A1O3JQGMaqhOe/kuU+E
 7bG7key86oqFVseqSkZ3Bge/dY4fDLxfl0OVoashb7vNJe9wWC7Xu7JKbIGwz/An1t1d
 YPMxtdlXhp8j9bOpt8BXFEq4n3r7JJP/JzHPxm1oRHE1yMUIUg1xeiBJDnqb8ag8NG2W
 Clvw==
X-Gm-Message-State: APjAAAVKtWHG5LYWpgjHsxTIAhkUxfpYI8BVJ1fM/MOiuIYOrbH7zHxf
 uni36lPHt4Rb0+W3UQDvm03T+/O1NHSF5t0S2wW6iQ==
X-Google-Smtp-Source: APXvYqyI2OHpoRJh8zDWQ9QMZXHOONWV8Hp51Nx/L3PkeNKCrW++Ku0GXVFb7qeDsjzjWfpEJO+K9adsMkakhDQxEd0=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr53216650otn.71.1563932085858; 
 Tue, 23 Jul 2019 18:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <1563925110-19359-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1563925110-19359-1-git-send-email-jane.chu@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Jul 2019 18:34:35 -0700
Message-ID: <CAPcyv4hyvHFnSE4AUbXooxX_Ug-raxAJgzC7jzkHp_mSg_sCmg@mail.gmail.com>
Subject: Re: [PATCH] mm/memory-failure: Poison read receives SIGKILL instead
 of SIGBUS if mmaped more than once
To: Jane Chu <jane.chu@oracle.com>
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
Cc: Linux MM <linux-mm@kvack.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jul 23, 2019 at 4:49 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> Mmap /dev/dax more than once, then read the poison location using address
> from one of the mappings. The other mappings due to not having the page
> mapped in will cause SIGKILLs delivered to the process. SIGKILL succeeds
> over SIGBUS, so user process looses the opportunity to handle the UE.
>
> Although one may add MAP_POPULATE to mmap(2) to work around the issue,
> MAP_POPULATE makes mapping 128GB of pmem several magnitudes slower, so
> isn't always an option.
>
> Details -
>
> ndctl inject-error --block=10 --count=1 namespace6.0
>
> ./read_poison -x dax6.0 -o 5120 -m 2
> mmaped address 0x7f5bb6600000
> mmaped address 0x7f3cf3600000
> doing local read at address 0x7f3cf3601400
> Killed
>
> Console messages in instrumented kernel -
>
> mce: Uncorrected hardware memory error in user-access at edbe201400
> Memory failure: tk->addr = 7f5bb6601000
> Memory failure: address edbe201: call dev_pagemap_mapping_shift
> dev_pagemap_mapping_shift: page edbe201: no PUD
> Memory failure: tk->size_shift == 0
> Memory failure: Unable to find user space address edbe201 in read_poison
> Memory failure: tk->addr = 7f3cf3601000
> Memory failure: address edbe201: call dev_pagemap_mapping_shift
> Memory failure: tk->size_shift = 21
> Memory failure: 0xedbe201: forcibly killing read_poison:22434 because of failure to unmap corrupted page
>   => to deliver SIGKILL
> Memory failure: 0xedbe201: Killing read_poison:22434 due to hardware memory corruption
>   => to deliver SIGBUS
>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d9cc660..7038abd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -315,7 +315,6 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>
>         if (*tkc) {
>                 tk = *tkc;
> -               *tkc = NULL;
>         } else {
>                 tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
>                 if (!tk) {
> @@ -331,16 +330,21 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>                 tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
>
>         /*
> -        * In theory we don't have to kill when the page was
> -        * munmaped. But it could be also a mremap. Since that's
> -        * likely very rare kill anyways just out of paranoia, but use
> -        * a SIGKILL because the error is not contained anymore.
> +        * Indeed a page could be mmapped N times within a process. And it's possible
> +        * that not all of those N VMAs contain valid mapping for the page. In which
> +        * case we don't want to send SIGKILL to the process on behalf of the VMAs
> +        * that don't have the valid mapping, because doing so will eclipse the SIGBUS
> +        * delivered on behalf of the active VMA.
>          */
>         if (tk->addr == -EFAULT || tk->size_shift == 0) {
>                 pr_info("Memory failure: Unable to find user space address %lx in %s\n",
>                         page_to_pfn(p), tsk->comm);
> -               tk->addr_valid = 0;
> +               if (tk != *tkc)
> +                       kfree(tk);
> +               return;
>         }
> +       if (tk == *tkc)
> +               *tkc = NULL;
>         get_task_struct(tsk);
>         tk->tsk = tsk;
>         list_add_tail(&tk->nd, to_kill);

Concept and policy looks good to me, and I never did understand what
the mremap() case was trying to protect against.

The patch is a bit difficult to read (not your fault) because of the
odd way that add_to_kill() expects the first 'tk' to be pre-allocated.
May I ask for a lead-in cleanup that moves all the allocation internal
to add_to_kill() and drops the **tk argument?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A683AC3
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 23:05:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B28821311C1A;
	Tue,  6 Aug 2019 14:08:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3982321306CDA
 for <linux-nvdimm@lists.01.org>; Tue,  6 Aug 2019 14:08:08 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q20so95959249otl.0
 for <linux-nvdimm@lists.01.org>; Tue, 06 Aug 2019 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bL9WIDO7sBDPuzb3CXk+Z4+KurUQJsfGVwyfuIglMnE=;
 b=z2yxKPxyTcUc/O0JPDhYlubCTmWn88V/XHMgPAW10JVY9PDY328HIFjdo5D72jUH9f
 NgLzeLRf01N3eu0r1mdcfI7/BvjmTgkY/TwdpldwvbZ6CYEkwmp0eYXtVjobhRaRQuLv
 UKVBPLyKcHIhmZ3R5exIUzoaoQVCcIZsFwVAzTGEHH8mOBIpEeJV0N4FZvasdWo3/BMo
 KGuoLOtTZHjpAh9PykT0gDKxN/TsFkitTz6RF0I1c9hGrl8ZOrgqZWNkXh78fIJeqajS
 J0PWgZNpFBbIOgjBn3Sa58UezqTODB4r3nJN4DcwPF/L6QTs9YSzBz3/MuR4za3eFBwA
 +vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bL9WIDO7sBDPuzb3CXk+Z4+KurUQJsfGVwyfuIglMnE=;
 b=hZVj8ze/1/ryIm1SiXyjSu/lkTPvHqLY6HjVct6zgJSqjuWL4XSUtzAWZskYlB9QY8
 9XMjjHxThZ7bDwH3US94yvsrmcCYbu87HBXINIQ4pBtrDpQf/nybovKUxo0Wqk3Z4MJQ
 +Cxs7XfUymBW8f1Mok7JjYhiCsYfrDGIV6Z4hTiDa5X1ka+OHtDQg137vQlPZIuV3VmY
 FBxiWJZuR+MgghleAK2/IIBOSHjHdU24Xx8xggLGSfIUBduN+jzOiPjq7X2ri0Sfh51T
 Cp7F7HO9E8CoW9efxzFvWRDl+SCU6FHuVIO82oK7UYMzZBdpWHl7KfOLDS2aM9DOVTrW
 2Hig==
X-Gm-Message-State: APjAAAV+JN4C2bQoDtcrK3E5yzchpXIyyC4rTaSCSwQkK/k3fwxDxk1N
 uJwZGUvPgihKiFyeIzcfgS5AUuMAfBmB1Fm7lWItIQ==
X-Google-Smtp-Source: APXvYqz/Ak9jnetJg9GXee4VtqrfI/7ybe9DtdbHdF+C7k/OSWwPkzRw1cnJyGFIKt8iguhq8EC0LfgFQg7v9HFSu0g=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr4639053otf.126.1565125537390; 
 Tue, 06 Aug 2019 14:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <1565112345-28754-1-git-send-email-jane.chu@oracle.com>
 <1565112345-28754-2-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1565112345-28754-2-git-send-email-jane.chu@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Aug 2019 14:05:25 -0700
Message-ID: <CAPcyv4jv1Dr=mDkYZ62B=nZux=bFWxYFu3u_N+8Pr0i0jyM2Lg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm/memory-failure.c clean up around tk
 pre-allocation
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

Hi Jane, looks good. Checkpatch prompts me to point out a couple more fixups:

This patch is titled:

    "mm/memory-failure.c clean up..."

...to match the second patch it should be:

    "mm/memory-failure: clean up..."

On Tue, Aug 6, 2019 at 10:26 AM Jane Chu <jane.chu@oracle.com> wrote:
>
> add_to_kill() expects the first 'tk' to be pre-allocated, it makes
> subsequent allocations on need basis, this makes the code a bit
> difficult to read. Move all the allocation internal to add_to_kill()
> and drop the **tk argument.
>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 40 +++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d9cc660..51d5b20 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -304,25 +304,19 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>  /*
>   * Schedule a process for later kill.
>   * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
> - * TBD would GFP_NOIO be enough?
>   */
>  static void add_to_kill(struct task_struct *tsk, struct page *p,
>                        struct vm_area_struct *vma,
> -                      struct list_head *to_kill,
> -                      struct to_kill **tkc)
> +                      struct list_head *to_kill)
>  {
>         struct to_kill *tk;
>
> -       if (*tkc) {
> -               tk = *tkc;
> -               *tkc = NULL;
> -       } else {
> -               tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> -               if (!tk) {
> -                       pr_err("Memory failure: Out of memory while machine check handling\n");
> -                       return;
> -               }
> +       tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> +       if (!tk) {
> +               pr_err("Memory failure: Out of memory while machine check handling\n");
> +               return;
>         }

checkpatch points out that this error message can be deleted.
According to the commit that added this check (ebfdc40969f2
"checkpatch: attempt to find unnecessary 'out of memory' messages")
the kernel already prints a message and a backtrace on these events,
so seems like a decent additional cleanup to fold.

With those fixups you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...along with Naoya's ack.

I would Cc: Andrew Morton on the v5 posting of these as he's the
upstream path for changes to this file.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E581C232B03
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jul 2020 06:33:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E543D12704670;
	Wed, 29 Jul 2020 21:33:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::142; helo=mail-il1-x142.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A709D126F7B93
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 21:33:26 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y18so12958907ilp.10
        for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 21:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/8RnS4x4W8m0YHiu5amCYbnx/T7Aru1VqlIWnTME70=;
        b=DWUKRxNk7x7CVf6W7KRRGPgYHyL4Fi+wLI43Pf4GXCsitNmR19V6LCsj3wSEeYmm04
         yOdGgWO7Vs30/d5rL2j/YCHSSGL/bdIuSibmPVrc/JKIj7ACup+d44DgJs8z9Ssp0h8r
         Fa5DpPibIatS4BAqJ20YbIMA15uvOVKJHGxnK/Lcn7ULIv8uAYwbBnY4yKcZ0EDW+oTO
         8+uwYB9KPaki9LAEswob9fGSs1PW5w+lh2VzeiLkJC8+bFNYYgG6i9TM3ii4fzpMC+bt
         3pDKiONEKLv1FlJeVQmER4mWFGLJAH8kjYIxsifedvKQLxtteyHxepu65gfszGJk30Ip
         6TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/8RnS4x4W8m0YHiu5amCYbnx/T7Aru1VqlIWnTME70=;
        b=OP8cuvieaeeCEcZznlBRizjJZVeY3BHUXY6F7AstOqrCJhp/NkP6KiB78+BIy5yybj
         8uIPaTDcDywjDsEx88OQmiXp1PObSmPPNak0YdM3XNPnkDs1Ggh6XWYg8zvFNTwatXd1
         lAWtB+TmQBmwR9GM9ZVJHztLwZwYRTUtjumOJatZbMpArP7mC/j7uVQkdBAzpDQoNj24
         uQ8Onnc8o5in+m+7hXKXEleRfdRO/x/SPn91MkXJLrEMuDA5dtNBDOZVPDhHQ1EifqOu
         dx/KcTRHMJDfKnpa4AO2UkWe4ywUdzGQJ/mOoWxHCcrhueMCP0da+MknHqwwss6eXGpC
         XN0w==
X-Gm-Message-State: AOAM532td+I1DVc2G7FcPlFb/9Y2l0FPqjIVRelGdGZxvlA0xsMrdaj9
	Wxu2vrOGAbAnjBaxtGp+6RIr9jfO+Yd1kiZvJEc=
X-Google-Smtp-Source: ABdhPJy/dmKUsQhl8cVEkWj79cLpTgDY5uGzmUwT/INw4PNci3ryYBF2MmFnSITitD5fVe1LdbZreYB99yu8k0/8bAo=
X-Received: by 2002:a92:4a09:: with SMTP id m9mr38727451ilf.79.1596083605662;
 Wed, 29 Jul 2020 21:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200729034436.24267-1-lihao2018.fnst@cn.fujitsu.com>
In-Reply-To: <20200729034436.24267-1-lihao2018.fnst@cn.fujitsu.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 30 Jul 2020 06:33:14 +0200
Message-ID: <CAM9Jb+hUk_e-Un3+9Jx8eKDtZ2A597bawQTJXQx77T0yG+PdnQ@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix wrong error-number passed into xas_set_err()
To: Hao Li <lihao2018.fnst@cn.fujitsu.com>
Message-ID-Hash: EMD234BR3MAFM7STXYCSXK7YBBXFVMWA
X-Message-ID-Hash: EMD234BR3MAFM7STXYCSXK7YBBXFVMWA
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: viro@zeniv.linux.org.uk, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, LKML <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EMD234BR3MAFM7STXYCSXK7YBBXFVMWA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> The error-number passed into xas_set_err() should be negative. Otherwise,
> the xas_error() will return 0, and grab_mapping_entry() will return the
> found entry instead of a SIGBUS error when the entry is not a value.
> And then, the subsequent code path would be wrong.
>
> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 11b16729b86f..acac675fe7a6 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -488,7 +488,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
>                 if (dax_is_conflict(entry))
>                         goto fallback;
>                 if (!xa_is_value(entry)) {
> -                       xas_set_err(xas, EIO);
> +                       xas_set_err(xas, -EIO);
>                         goto out_unlock;
>                 }
>
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.28.0
>
>
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

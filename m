Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A52231876
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 06:24:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7486812696128;
	Tue, 28 Jul 2020 21:24:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::142; helo=mail-il1-x142.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50AC612696126
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 21:24:03 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b18so13039601ilo.12
        for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 21:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8Lj0n1Zd2rP8KePdAfKhAxfmGD5rDX2BZD1WGF8Fu0=;
        b=W+17L/tn9AcYCDoirwPhQ8eIEtvNThehTozpBQ6dS80cvQzGUBUVrg8QZ+mfdqc/AU
         BpVMkSG+zIX7W8SZdLXbg3uBgkFDVLxLW4OwLvKYWy/286zSbPtFPbrMmbnagFa8uRSd
         xhGhU9LAJhkxE+ep54DWt+fwqQ09gXCN/Xc6C4aP5PpZdrs51DaK4RS+dB5UaFyuy0lI
         JeAzdVCJzPTj3M4oj6fsrbhN0ypbULabB0gZ0XUCdGJ5kPXi8hqjwh6S3D5+25dn80R+
         fVpY0kSR+HDqhu80Z5CDhQARcxUsQB8aFzmj2OSHRisO5awvlmwVkPAFiv7a8yE1ltAO
         er5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8Lj0n1Zd2rP8KePdAfKhAxfmGD5rDX2BZD1WGF8Fu0=;
        b=hLw9EiL0RQRzSNw9KUmyYC3oAPIqeQzOwp3i95VzoMQMK/O4Pqm+aGTO5n0F4i5jZu
         PziQVv+ij+KEQq9hcBI2Fpyp+V6FOAVkfvBYbMgGF4MXujeMDPqrBnj+cKmUTUEjrNxX
         Bc4t7t/OL3U+k7czmVqVbWYmiVMmGvwlrYcrfnfIvjw2Mu5sui0YQR+l4xz0mwlEYwrx
         STu7DeVvde7gPR8Pxi8J3PR8Y5vOepFv8ICWR65CUmzNBZVpP4IUcYlzEvYNVF8cETfV
         N2QehpcIhIrQZMtAypkBG8KNSp5+Lb3eorcG/5USuhCzIlVrsrB/Vko7XH8ruzJs68yM
         cafA==
X-Gm-Message-State: AOAM531rZRSoqJhBSsGHJaosLPB/FU2hI1BO0TWpVgJ5sTCBlw03tGvD
	6Mo9FAPBWcny+b+IKbbIWzmMlPd/iGGjLrI0dKQ=
X-Google-Smtp-Source: ABdhPJxW3H5yclx2oKUIoXO9DSr1UBZ/tAP2vU1PjFq98InH9JEPbNBjJHtVoe0/5nmJbQ3X+YpsJBGSK2uRF7lXTQY=
X-Received: by 2002:a92:4a09:: with SMTP id m9mr33482608ilf.79.1595996642205;
 Tue, 28 Jul 2020 21:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200729034436.24267-1-lihao2018.fnst@cn.fujitsu.com>
In-Reply-To: <20200729034436.24267-1-lihao2018.fnst@cn.fujitsu.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 29 Jul 2020 06:23:51 +0200
Message-ID: <CAM9Jb+gaf+mm2A_=hjYXpxAt1LZ6_nysi0CH0N6XxsbHjicoHA@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix wrong error-number passed into xas_set_err()
To: Hao Li <lihao2018.fnst@cn.fujitsu.com>
Message-ID-Hash: BDPBPJU67T7JHTBWEKQWS4VWOHZ4GW7F
X-Message-ID-Hash: BDPBPJU67T7JHTBWEKQWS4VWOHZ4GW7F
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: viro@zeniv.linux.org.uk, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, LKML <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BDPBPJU67T7JHTBWEKQWS4VWOHZ4GW7F/>
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

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>


> --
> 2.28.0
>
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

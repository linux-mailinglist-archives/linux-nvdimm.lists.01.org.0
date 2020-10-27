Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894AD29AE5A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Oct 2020 14:59:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D1698161DB937;
	Tue, 27 Oct 2020 06:59:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95B9215C743E4
	for <linux-nvdimm@lists.01.org>; Tue, 27 Oct 2020 06:59:29 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b15so1584575iod.13
        for <linux-nvdimm@lists.01.org>; Tue, 27 Oct 2020 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQvdV6dqtQ5KmyvpgQ9zrxsf+gQ42UJEg73X+t/RUns=;
        b=V2nPzQCQtpkA9wOxgf/mwbKpmzwcQgn85DuZQ9ksWuP5pAEB7y5C+cmobCh0JiAzWf
         ubeMixFZLY/L7OZ/oEXZAQ4CQ0Ja0WN/LRcDOap/i4briyPp2X+2jvDHLU0LKclgolkO
         dkGWd7Hh5a8dUOm56Lk1qRWuvivXeQNpzUkEaynNto7LBWtREMu9BmqT1V1RdcmpkSD1
         Jz724SdaGncbonb7V4fpkd9et8n9a8+PhAbo50ZcdaxcZLwnc0zoeUTP3Nzph/ft3ESO
         jUaPz0agSckDO6joUhngkr+WApUOe3s5LdZCSKAApGue19P9uTYaGY1HVHiZY0cid+b9
         pXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQvdV6dqtQ5KmyvpgQ9zrxsf+gQ42UJEg73X+t/RUns=;
        b=EyoSRVh71fTXQcTcvNIsuIWqiYEVZOkbBsBgrblzdpDfNN6iw2S8L5OaLv9Uqb3bWb
         iu0V4O/2ZzDuMfRkYTCr2pDsQAFkFumBOekMRJP2R2JY00zGsArdnoXHHoqynt8g3blD
         jgNz4+GWxnQXSsRq07bbozTsl4KUyZOWh2h4bji8MUOsNkWpaw1Zu6a2HqBOHzX/Q7VL
         eAMPDDJ3mPmbQaHmzJ4FMGY9zZb7IhhXKoeyKOFkXwTKg6r2AiJz0hmp4aUHU7QFMzpC
         ZHwxSRlGGXDfd+Y3LmBvdDkmVbDrCPl5kHp4LzQg7FgNpY5LrMtCaEj4OAZj4KANNGKa
         p2Dw==
X-Gm-Message-State: AOAM532kp1Sk8XFs3dEmc+Ot4bZkvOySy9iz0ksC4tZ/EJv08+YquXBM
	LAMTODyDn1fSNwba4wwKCzgvUvOfoVBgaMZGB7k=
X-Google-Smtp-Source: ABdhPJxXit5ThAbX46aMmTtpkKVQCxA0v43tUImtevHEb32GiSq/9K4/FohM0td4C5lyMX97BjWbsA2p8eg7N6v8eK4=
X-Received: by 2002:a5d:87c7:: with SMTP id q7mr2170461ios.162.1603807168629;
 Tue, 27 Oct 2020 06:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201027134901.65045-1-zhangqilong3@huawei.com>
In-Reply-To: <20201027134901.65045-1-zhangqilong3@huawei.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 27 Oct 2020 14:59:17 +0100
Message-ID: <CAM9Jb+i5ZYCVktvbmdupbM5w8J27oTEFejKL5La1sOV4iWouEA@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: NFIT: Fix judgment of rc is '-ENXIO'
To: Zhang Qilong <zhangqilong3@huawei.com>
Message-ID-Hash: GCRSA5KG2AWVAHRKHT2RIPU7MKTLLQVK
X-Message-ID-Hash: GCRSA5KG2AWVAHRKHT2RIPU7MKTLLQVK
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GCRSA5KG2AWVAHRKHT2RIPU7MKTLLQVK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Initial value of rc is '-ENXIO', and we should
> use the initial value to check it.
>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 756227837b3b..3a3c209ed3d3 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1564,7 +1564,7 @@ static ssize_t format1_show(struct device *dev,
>                                         le16_to_cpu(nfit_dcr->dcr->code));
>                         break;
>                 }
> -               if (rc != ENXIO)
> +               if (rc != -ENXIO)
>                         break;
>         }
>         mutex_unlock(&acpi_desc->init_mutex);

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

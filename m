Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D624A031
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 15:37:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DE9312F414C0;
	Wed, 19 Aug 2020 06:37:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com; envelope-from=oohall@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D4A2412F414BE
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 06:37:22 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so24711104ioe.5
        for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CU9Zr4LI/GfTl7S1ltjLtLw+xp0kyM6bHpT8zYvnkMs=;
        b=Qp4+Gar0fMdYytsOSyLZpqrBgkqBGvWD+9KS4ZseGwKtZ3UNmsfFLNqHnKKNBmCoZV
         VARg7fHPutGJvnweVdaTrqVHR3DUOOkFWStxpx3Y63I+tBqS6YS6Whn5p44SkING9Xey
         jMsdKlHmr+gt1sww85jiljC8v/OQ6dIgR1gB5BtoxUWWqd6D7hYjfSH2OsfemNl330Gh
         FTCdcIJnFsbkaUiBTIYu+tdSoyGJYWao8pll33WUuAV+LiPLKPNim1p4Ogdx0H667C6s
         n+R0e1LADuy/Sbwfo2l5FUqtxfn4As7rZ22hCCEHGhA5yza/Ksn0i4BcGwSq+8rXJZBH
         Q2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CU9Zr4LI/GfTl7S1ltjLtLw+xp0kyM6bHpT8zYvnkMs=;
        b=M9g9HuaSDIYSQKIzR3C3giyyxodejDegBu/AZVv9JggvTINYZvaU65cPF+I8aHiGyv
         Tz67XtQMqu6gg1NoQrF3r1a4lzODC0zJ0doZQpChH6WzV8+2vSd1W5FENM4Edrh+UTFu
         NFNXYfbO49ff3v4hJZzIzILNmE3g07hwwuX9ycih7SidzzDEinhDGkU7nv0Z6mWxk/vX
         UDx4wan99rf02cLSIPybJ7kRhTQL3a5/ug9ADegfETIQ4plvK2ptURkWN3ltzw2zIZJD
         S2ROJzQoLsX5xoe+nszzvArQWII0vuGKL6jWk0MnUq693sO030XYH3xlrPXU8K6sNH28
         fV+Q==
X-Gm-Message-State: AOAM5315F3lNf0l72K4PIymVn9egYuT5THPyPJama4T3+Jgi+eS1UgEg
	t/FbAe43D7SzRdX0LIUvbHc3ub8W1g9bbhRwvjU=
X-Google-Smtp-Source: ABdhPJwRz5ptWi9jU0zOEyttOJM97RGMZUNDEZDD+TTNv3kZGB1W0K4Y0G6nj8hodta9E7UzclSOD+POhpFtBVP+fjc=
X-Received: by 2002:a02:6066:: with SMTP id d38mr24198724jaf.105.1597844241987;
 Wed, 19 Aug 2020 06:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200819020503.3079-1-thunder.leizhen@huawei.com> <20200819020503.3079-2-thunder.leizhen@huawei.com>
In-Reply-To: <20200819020503.3079-2-thunder.leizhen@huawei.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 19 Aug 2020 23:37:11 +1000
Message-ID: <CAOSf1CGvtX6FjYXy-mGxoEx4B6ZQ-LUZDMi-503JtECLu93faw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] libnvdimm: fix memmory leaks in of_pmem.c
To: Zhen Lei <thunder.leizhen@huawei.com>
Message-ID-Hash: JFGS6B5G7NQJUQ4ERKS2BZCPCQTUH43H
X-Message-ID-Hash: JFGS6B5G7NQJUQ4ERKS2BZCPCQTUH43H
X-MailFrom: oohall@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Markus Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JFGS6B5G7NQJUQ4ERKS2BZCPCQTUH43H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 19, 2020 at 12:05 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> The memory priv->bus_desc.provider_name allocated by kstrdup() is not
> freed correctly.
>
> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Yep, that's a bug.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

> ---
>  drivers/nvdimm/of_pmem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 10dbdcdfb9ce913..1292ffca7b2ecc0 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -36,6 +36,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>
>         priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
>         if (!bus) {
> +               kfree(priv->bus_desc.provider_name);
>                 kfree(priv);
>                 return -ENODEV;
>         }
> @@ -83,6 +84,7 @@ static int of_pmem_region_remove(struct platform_device *pdev)
>         struct of_pmem_private *priv = platform_get_drvdata(pdev);
>
>         nvdimm_bus_unregister(priv->bus);
> +       kfree(priv->bus_desc.provider_name);
>         kfree(priv);
>
>         return 0;
> --
> 1.8.3
>
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

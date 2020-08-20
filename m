Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23E124B7D6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 13:05:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D1F9B13510D07;
	Thu, 20 Aug 2020 04:05:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 89FBF13510D05
	for <linux-nvdimm@lists.01.org>; Thu, 20 Aug 2020 04:05:29 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s2so1750481ioo.2
        for <linux-nvdimm@lists.01.org>; Thu, 20 Aug 2020 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ki1WQNTHcThUFIdfEkntkrGULJACUJ9yJz/bmSD9Zk4=;
        b=T4ll16vitP366qklDX50f3YJzjIWVqhIPBxyHOXoytwEHnmw5TXRhyruxNl25YYGv1
         drxoowiA08/SofODXLrxwlo+/T4BP9gCbFFq8vUQWigeMopmJM0JoaIrftZTItta8Lm0
         AHhxpM4P9BvWA9b5Vo7U79Oqj82MezCBEnA7yMW4U728fP5/YxpZrTZAEk0PnEVhROOY
         fAWSUnNgXFNn0mISMiB0CLB8ne+1yvt5Xf479kIDAZg+krVxehKGrtPndcD+hupW7h1W
         kMox2AJibyI0Y6rc0JxsNTaiObDyh1TMZ1X1aAw2e0w4KqHM0bas/mAOXfjcvuVEchVK
         OgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ki1WQNTHcThUFIdfEkntkrGULJACUJ9yJz/bmSD9Zk4=;
        b=JLj1W75zIDNz4EYWMGugyfYj3e4aF4qHsse/h1Z+1W8HdTl7AAJd86FkP6gMi5H+sp
         qqg3d0V4d7CXlTNQVKtOvCEcH48Ugz+tDD7q2bh/VEpELsxPOLTWqUWq6UjPtEEmG8x0
         kZIC9Vzbidz5htMauIhzgrprwI2z4EfcExfaIE2g5+21BvpPkb3iRKZM4tPyFooWicxN
         Co/4xshyDtB+xj4k18m1fxVzOziV6RZE0Lj54o8AuZw0iIL+MDWYnWygnTLa1hk5R8Vn
         VpixSaDuuvoHZa8Kp6zdvYqVeFHMQRJEScvVS1qEiC6P0wR5lJ5jDJT3rs3Z/4EuxCb+
         rwcQ==
X-Gm-Message-State: AOAM531MiRlJjRb7JPN/iVpwTxinWc08gYXytJ5bboYtN9MagST+c8GE
	09J37tdUqlyQ/3ZghI99dQfwO6+9TbbTpW2oDwk=
X-Google-Smtp-Source: ABdhPJy8/B73Rwis0rcIrLcmnezpMOZs5TSkb/gxeBASX1Y68sIG9u8fggt3cVgCb7QgHUrLjqugAPGdHve9mLdVjAk=
X-Received: by 2002:a05:6602:2409:: with SMTP id s9mr1985839ioa.98.1597921528654;
 Thu, 20 Aug 2020 04:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200820021641.3188-1-thunder.leizhen@huawei.com> <20200820021641.3188-7-thunder.leizhen@huawei.com>
In-Reply-To: <20200820021641.3188-7-thunder.leizhen@huawei.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 20 Aug 2020 13:05:17 +0200
Message-ID: <CAM9Jb+jrzR3Q7JcYJKpjHr6_xXCrMUybRc3+hzM1zRd9dETmPA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] libnvdimm: make sure EXPORT_SYMBOL_GPL(nvdimm_flush)
 close to its function
To: Zhen Lei <thunder.leizhen@huawei.com>
Message-ID-Hash: O43S5EYFE6O5NV3HTEOG2UGU5N2OCVRH
X-Message-ID-Hash: O43S5EYFE6O5NV3HTEOG2UGU5N2OCVRH
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Markus Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O43S5EYFE6O5NV3HTEOG2UGU5N2OCVRH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Move EXPORT_SYMBOL_GPL(nvdimm_flush) close to nvdimm_flush(), currently
> it's near to generic_nvdimm_flush().
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/nvdimm/region_devs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 49be115c9189eff..909bf03edb132cf 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1183,6 +1183,8 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
>
>         return rc;
>  }
> +EXPORT_SYMBOL_GPL(nvdimm_flush);
> +
>  /**
>   * nvdimm_flush - flush any posted write queues between the cpu and pmem media
>   * @nd_region: blk or interleaved pmem region
> @@ -1214,7 +1216,6 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(nvdimm_flush);
>
>  /**
>   * nvdimm_has_flush - determine write flushing requirements
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 1.8.3
>
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

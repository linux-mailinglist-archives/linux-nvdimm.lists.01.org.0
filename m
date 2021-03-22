Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1353344B13
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Mar 2021 17:21:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3168E100EBB97;
	Mon, 22 Mar 2021 09:21:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC6B0100EBB96
	for <linux-nvdimm@lists.01.org>; Mon, 22 Mar 2021 09:20:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt15so12773655ejb.12
        for <linux-nvdimm@lists.01.org>; Mon, 22 Mar 2021 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cjec9CU03x97pBWfqnenhXim56P82KU3lpH+bXIIngU=;
        b=uW585N9tLgE5B2WscxSJyqPB8Wa7F1ez7t7R2yQfyouZAKUjKxJbVjmw8lj/nTeR+c
         NZBm90AeugRrYaCpipmWR48L35EETcdgm1bUzoy2waews42AVGmWUI/vJfcWNW7/MZeM
         7m4HZ+O0NhRYrWJuXnOadQUZcep8MAsHc/FHog94Qu1yKgxnSDjwCLzTYA4pref9TGsI
         bxz+kx7W7hGSDIVZnvHxQnZVeMt0ZWgwyeMm7cTimSJIvsEzhtvQbD7DEqRTJvvAPN1J
         Ji1RVVrYhwsgpL4RVt2uyV6IPUaGBcIfKaWgDrjXsusa6Eo4sgph079yunvFyPZ/sgax
         1PEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cjec9CU03x97pBWfqnenhXim56P82KU3lpH+bXIIngU=;
        b=NVKNJNr8oNArL/j2LLNbcinVp5KFhiFl318jL9CtCDgmXSw+8bttJ3soCRLBkCASx+
         Mn7hqm0xVtLz6M4mfV2ikQHT0I81pOjNFaDyHuSSHqjB8+KLY4fLnvIVI/yGio+bp62v
         jEnE7c289wey7yW6l/9duTZ4FTIsU6Fh+5gondlYsle5tsJAyEPsdIlYDF6Q7WEaOAGL
         WiZg2p9+tasjLCIpQrhXlkiC3j83AVACPZY0aIxegvln41v0khMZX7M+NzavW5S8MB2z
         XqJe+E62/NFfJNRnu1dmjOPYddH+ZQWpq0/exCOqQt0YtLzcuQHRjjbcuXYAnLJE/as0
         5oyg==
X-Gm-Message-State: AOAM532kDRBnBAxfwO8cX+Fse7n/DqYMWLXOuW70MTc2VMaauQlK/Fpr
	puzTfNbS6CgyL7/4PrFYgh+sk2hdkUTeRU9A8sPwgw==
X-Google-Smtp-Source: ABdhPJxGRfI9FizVaqpi19V7UON819iIb7eUF5/21wIJRBeAMg48q8Cs8n87NEkDgVkpyN9EJ0yIOVNpO3Unb29+w6w=
X-Received: by 2002:a17:906:8447:: with SMTP id e7mr544109ejy.523.1616430055727;
 Mon, 22 Mar 2021 09:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210322114514.3490752-1-arnd@kernel.org>
In-Reply-To: <20210322114514.3490752-1-arnd@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Mar 2021 09:20:46 -0700
Message-ID: <CAPcyv4h-FS96xxnX0GLOfQ7G0arNL_f4=fpP1ag3GrfLn-Mt-g@mail.gmail.com>
Subject: Re: [PATCH] dax: avoid -Wempty-body warnings
To: Arnd Bergmann <arnd@kernel.org>
Message-ID-Hash: WXO44CBW5KTKVWEKGJTJWGSGKTANLLOR
X-Message-ID-Hash: WXO44CBW5KTKVWEKGJTJWGSGKTANLLOR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Zhen Lei <thunder.leizhen@huawei.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WXO44CBW5KTKVWEKGJTJWGSGKTANLLOR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 22, 2021 at 4:45 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc warns about an empty body in an else statement:
>
> drivers/dax/bus.c: In function 'do_id_store':
> drivers/dax/bus.c:94:48: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
>    94 |                         /* nothing to remove */;
>       |                                                ^
> drivers/dax/bus.c:99:43: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
>    99 |                 /* dax_id already added */;
>       |                                           ^
>
> In both of these cases, the 'else' exists only to have a place to
> add a comment, but that comment doesn't really explain that much
> either, so the easiest way to shut up that warning is to just
> remove the else.

Ok, applied, thanks.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

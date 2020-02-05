Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 798991536F4
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 18:47:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2EA9F10FC3171;
	Wed,  5 Feb 2020 09:50:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4812110FC3170
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 09:50:31 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id j20so2755660otq.3
        for <linux-nvdimm@lists.01.org>; Wed, 05 Feb 2020 09:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGox/vMT1XSyRhKg74TYU3bU1X7R9BLYAmKDXImG7PU=;
        b=tkIo4hG65yKENP7y/yhGxsv66c24qa/Ao+AC5GOPUuKp4eTFYK9Lfuf4ibLU7JKZ3v
         p4wcbC8vJ3qr+EdfuPl/B14d84aJ3+nt3gaXpl/Qsl4qufDox9la6UX/2lmlXbjmgOw1
         tbazfxH+Z/7JDJoJzDySNgrC/F9DXqw7vDdtic3bHRkUFJYs69a26+rdXN6+lLHcjxvV
         +SInZfpIKpbUukedSbaPUMBhLdIJF9ExWb8kOtHBc6Zsy678YH7jCjR2MAavV4xgrmI9
         qVjO0UoqtNWrzcMyiYk7EsFIUKS1tQJp09elGnIfH2Hqw4ofGX/WXlF2nSTWO5TWXdPw
         XKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGox/vMT1XSyRhKg74TYU3bU1X7R9BLYAmKDXImG7PU=;
        b=RAOMnqLyL1mU7dk1dyClibjgjin7Cb+6DSxBJT/gM/3tEYPXDobTugtt7LzyuLU9Mb
         bWuls6odvw4sFn6CbE62BK+ksM54EY3XHwy6VqKG6RAOXPRigADWIl7X3Ovzlk2q/eJA
         PqI+D4Lmoak3ycKsYzNRk8FD6YocPP44tDzCf2MJahJ5PaJFHIZTWx5zIiirm8FyiLdM
         jESWkSXYRcFfIKFNzrsCBXuEcmTobw5H1cRRcNcasTUcX+4iUoz+VGO85ieC8rlZVRhp
         gAOwfyUTCkOEsJMBCnct/ggIYZ5JZfv4YKn066C/etlcnhGn4DCD27dvss6QRyrtZsWm
         02VA==
X-Gm-Message-State: APjAAAUOeZtM5frVbjUkirIdi77bDJuJrZ5kpUdL6+YsE/PlPJ12+7H9
	06iS7Y0FgodlCzpDBaM9x0RwPKDYNdlm2bIGcRWuQ58alxQ=
X-Google-Smtp-Source: APXvYqz5oTq8SypiL24eXIB60Xyvz5e9rkBJP8v61tV9ZFSWa949g0s2JpDXNifOaUix+lcttDXJWf3dQYuG+qND6SU=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr25629971otm.247.1580924832815;
 Wed, 05 Feb 2020 09:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20200205123826.kdvtsm47iy2ihw6r@kili.mountain>
In-Reply-To: <20200205123826.kdvtsm47iy2ihw6r@kili.mountain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 Feb 2020 09:47:01 -0800
Message-ID: <CAPcyv4j12vgjgEgY3xAr9bpV8dd+3E7Q5Q3OFo2AXmwnN45PBA@mail.gmail.com>
Subject: Re: [bug report] libnvdimm, nvdimm: dimm driver and base libnvdimm
 device-driver infrastructure
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID-Hash: ZSM7H2OJIHM7CLB7R6JWMYQUQXR3R5CL
X-Message-ID-Hash: ZSM7H2OJIHM7CLB7R6JWMYQUQXR3R5CL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZSM7H2OJIHM7CLB7R6JWMYQUQXR3R5CL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 5, 2020 at 4:38 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Dan Williams,
>
> The patch 4d88a97aa9e8: "libnvdimm, nvdimm: dimm driver and base
> libnvdimm device-driver infrastructure" from May 31, 2015, leads to
> the following static checker warning:
>
>         drivers/nvdimm/bus.c:511 nd_async_device_register()
>         error: dereferencing freed memory 'dev'
>
> drivers/nvdimm/bus.c
>    502  static void nd_async_device_register(void *d, async_cookie_t cookie)
>    503  {
>    504          struct device *dev = d;
>    505
>    506          if (device_add(dev) != 0) {
>    507                  dev_err(dev, "%s: failed\n", __func__);
>    508                  put_device(dev);
>                         ^^^^^^^^^^^^^^^
>    509          }
>    510          put_device(dev);
>                 ^^^^^^^^^^^^^^
>    511          if (dev->parent)
>    512                  put_device(dev->parent);
>    513  }
>
> We call get_device() from __nd_device_register(), I guess.  It seems
> buggy to call put device twice on error.

The registration path does:

        get_device(dev);

        async_schedule_dev_domain(nd_async_device_register, dev,
                                  &nd_async_domain);

...and device_add() does its own get_device(). I could add a comment
to clarify which put_device() is correlated to which put_device(), but
this seems a false positive to me.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64322DBADE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 06:55:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CE2D1100ED499;
	Tue, 15 Dec 2020 21:55:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C170B100ED498
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 21:55:39 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id 6so16370187ejz.5
        for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 21:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvriMkBWhOKEvUrE6d4wpD4XEOG5d8BY8yYJTTW83co=;
        b=YFqDOoeizE4ka0/inyPhydvoeIdm2kcvhdSMYWMLyLN/HL+W8ejh73eEs5DUnjRWa9
         mOJUT5PrYaEZNk02FNOlMPnVkJ9UKck+XlrY94V2uazXcBuq5dKIN1YHkzkwwITjYCZc
         7Ccu4xlljGwDctxc1oDxIpQhPw7fsVfzxzQennEUjHnvClTepFG7h4t+UtIx1NdN/i0j
         0AGEVDxc6tYvUAsuA5hzoVMLUzobtxSAhgyJy3qenl2zen+qwpOjyjtG5zPAWFXEnLHr
         nlDpEN6zRkvauLZwmmGaUcepLEvxmqcz6g1ja3Zr3S/L906XlUHc28EahviKwnDR6IoL
         Wy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvriMkBWhOKEvUrE6d4wpD4XEOG5d8BY8yYJTTW83co=;
        b=r1jYjhmfXVCPbjUpV7nUilI4wGghkheWMHGiF4U2KRm3WSCL+nucohgEzBlHfdAtpK
         DNHhF1hHIby+aicybr4B1cV0aXEcWJK8YlrSOI9j5SBLLPQojvMZIfa03xbGFUhowXkK
         5iD4omT95P8WlP8eJNhBt9Q2vLuW/CBEOa2fLHW4EDfUT3TLm6dNZDCR0aEnxigeZT3Y
         fA8jWDhQTPafr8hDTPHvKAVOz3lwfHTVY9qSrc7cvMpzTnUSc7ldeLo0tGXsDzjkZiQS
         VnP0CUzAmwd8/HYXDM5WpCwRmNDGEjEiKwhnmzYUDTLS8HE93Zk2tI4MncpfEJxz3E1r
         QeoQ==
X-Gm-Message-State: AOAM530gxg2kWdjntUVYy6CMT7mzKyYzgZgb16IT3clqWh7NLdiLYTse
	E4lixQgBS3GM3iZZxrL7Sge5dPWfTKxT6yOpI9EG3Q==
X-Google-Smtp-Source: ABdhPJwm9n3w0DmtvI66+d0sqqZ1RsMbiSg5GuES0KnQbGpL0v+5fndK8JIsyl9oSjh9RSWlDnB6EGbsFxL5H5D770Q=
X-Received: by 2002:a17:906:4146:: with SMTP id l6mr9969831ejk.341.1608098138158;
 Tue, 15 Dec 2020 21:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20201215163531.21446-1-info@metux.net>
In-Reply-To: <20201215163531.21446-1-info@metux.net>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 Dec 2020 21:55:26 -0800
Message-ID: <CAPcyv4jzpDBOvm8s7XJZgfOHC2OR8OAjehvaKTC9-LQambKywA@mail.gmail.com>
Subject: Re: [PATCH] drivers: nvdimm: cleanup include of badblocks.h
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID-Hash: JUOOZ4K2DQVC4IK6XIHQTYNRNOCRCYKM
X-Message-ID-Hash: JUOOZ4K2DQVC4IK6XIHQTYNRNOCRCYKM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JUOOZ4K2DQVC4IK6XIHQTYNRNOCRCYKM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 15, 2020 at 8:36 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> * drivers/nvdimm/core.c doesn't use anything from badblocks.h on its own,
>   thus including it isn't needed. There's indeed indirect use, via funcs
>   in nd.h, but this one already includes badblocks.h.
>
> * drivers/nvdimm/claim.c calls stuff from badblocks.h and therefore should
>   include it on its own (instead of relying any other header doing that)
>
> * drivers/nvdimm/btt.h doesn't really need anything from badblocks.h and
>   can easily live with a forward declaration of struct badblocks (just having
>   pointers to it, but not dereferencing it anywhere)

Thanks, looks ok to me.

It was commit aa9ad44a42b4 ("libnvdimm: move poison list functions to
a new 'badrange' file") that left the straggling include in core.c.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE1D1EC432
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jun 2020 23:13:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6C78110117607;
	Tue,  2 Jun 2020 14:08:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1D26110117603
	for <linux-nvdimm@lists.01.org>; Tue,  2 Jun 2020 14:08:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k26so4555655wmi.4
        for <linux-nvdimm@lists.01.org>; Tue, 02 Jun 2020 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RijQZzPCkhwUNScdlTK9IICuZe5qxW6gJ9RNI3+a0HU=;
        b=R99hccmFfYGoTdOr6YSXNNbpSo8W75D3IXo4TI7aU/vGGTAkzCVzIa3KqAYBC/SDwr
         cQGcLcBcjTPUfuOJ6kqyysuSkwK0dhUlETVVfLhJLa29vasiQ3p27T3XlEVVWmE9b7b+
         vrq6xDC1wX6Vidm9Df+nsH/6SSqwxxMRxEZvWJz012UsOQlteNqPrFMUztblGEzJ7Nte
         qqiLIScNB3XDtB5XopfaRRwzHuFcMvWdv2n0YrSGrIaxYthaT92Y8UzOwZ37hqE+I3fy
         T2pc98N/XSg5U7lIvbefdMx8WqJnIB+Eq1yVrfeTSwlFjMPseqtqFEW6VRZWxHXHO1tl
         MpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RijQZzPCkhwUNScdlTK9IICuZe5qxW6gJ9RNI3+a0HU=;
        b=PsliuYp9LSa9oG9/WQJCwemPs9j+Pzhda1sAhbjd5JQFs7J3CqYwiWSxp3P70k13J/
         MDv9FhN80LV96wrcs5705lI/G6GXkBHeWNw1w450MAKOoWc6XuDhyJVDey6gSimG4CqN
         7VdqTD6sILL5DP51hG6vawk71s7L4yfsXVS64OMm6qUCaSK2dTJT7N3kjwi+YDvBPyQt
         9b5o7K9LwygR7UgrMRty1lTu+n3V/+Ju5bxBUSB9D5A1qg2CP2xaT07zKI8DCOruHB8E
         yfs+RlkdhIGVENpQEnLHs/gqu78NvsH+RUxhqHoTl7rIJZQJzsTdu/RjV0hEU88YHMup
         Nq1g==
X-Gm-Message-State: AOAM533SBvM26M4A/sOCoNil4KXMZQal8ZjDDK0aHYS9Iw3JiYdVG+sj
	QIzojxWKEMPxQ9dBolvhV4nNaKfWGWNOmtlAclc=
X-Google-Smtp-Source: ABdhPJyEIBXiRtdTLqxBRIYdUSTx6Yw5Mq9YNaXvhve0xnUvf8QCtyXTQnchcZ/90+HrbddFJp/kVuyyP1sgrG/XBXQ=
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr5943633wmd.127.1591132377978;
 Tue, 02 Jun 2020 14:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <1590723777-8718-1-git-send-email-hexiaoshuaishuai@gmail.com>
In-Reply-To: <1590723777-8718-1-git-send-email-hexiaoshuaishuai@gmail.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 2 Jun 2020 23:12:46 +0200
Message-ID: <CAM9Jb+gdgYSe9r_ce9Mhaj+dyKH5kocSjD_GOpoKowtG8Sxn4Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/dax/bus: Use kobj_to_dev() API
To: Shuai He <hexiaoshuaishuai@gmail.com>
Message-ID-Hash: SYXSDT6AB57TKGASRHPRVSV6Y65BDL52
X-Message-ID-Hash: SYXSDT6AB57TKGASRHPRVSV6Y65BDL52
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, LKML <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SYXSDT6AB57TKGASRHPRVSV6Y65BDL52/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Use kobj_to_dev() API instead of container_of().
>
> Signed-off-by: Shuai He <hexiaoshuaishuai@gmail.com>
> ---
>  drivers/dax/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index df238c8..24625d2 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -331,7 +331,7 @@ static DEVICE_ATTR_RO(numa_node);
>
>  static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct dev_dax *dev_dax = to_dev_dax(dev);
>
>         if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

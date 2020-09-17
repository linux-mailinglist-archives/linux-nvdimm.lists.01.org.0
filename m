Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE2726D817
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 11:51:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8E0714812D14;
	Thu, 17 Sep 2020 02:51:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2685214812D0F
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 02:50:56 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c8so1864525edv.5
        for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+Lv0i/9b0BWGlCAu/0pRl50oE99O9jRoA0DO6j8LP0=;
        b=oVK3+OeTwZFnXc977EgK5eeBuGMy/s57thpbSL1VlOaG1Ktnc2PVvpSqgPhMOR87Ip
         WNuS29jxi+kmnVzAuD/4dYgD/iYpFGUN2zOzY3hWyQSoBVHadjnDogUWg9840IXkumy1
         jQrjSAYsbqtgBHyjAvgtlFxRQ4pBdBaOZFjirvKm5lkSkPlow5rxb5oMnzph0o97UIEU
         L+1i9gODb1k2xuGB28mtnsS9gNE0xKka7GYUsHpJMK7TfddBE5msNKy6rc/XzBVZhv23
         nqdhnl6+m48OoGHpKKmi0WVn3jPcaI1UHwa7YT9oy3/+URbUBO/bO1LWKUB7EWLYjG8f
         UfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+Lv0i/9b0BWGlCAu/0pRl50oE99O9jRoA0DO6j8LP0=;
        b=EZ9xININNvXUx3+n6b4PQu7JutqCwN9pgbD1ohiLb9EcSAq9jtZFqq76mm3A+bThya
         adu/VP+cPEs5IRZH/GSkRimgvg3WoemWA4eGhtV82JefHD2LFG+L+pYxFRfYd5veI2O9
         JxPa0zUEb1/V3nCQE1zhj/2mYD3VnTAoZChCnqivS+w+W0YTNb/wxvK8ioTKwt8EcF9M
         cQjdtN9WxlxP/a+pKzSV68jyQhvfV6aiY+o8MxJeK3FqrBReSY5spC7tcqSbwnhtoqrW
         FXfaXr0oppUYvMhB4sDbDRsoAKNrc17mH0j6OnMA1uxJDNaLEquOPCqYkE7/YkfwzXtR
         LuXg==
X-Gm-Message-State: AOAM5329LL1/QQfhrE2mkQtoCcB8x0gODtAILfF1mcGA9nT0OZgV6rpY
	Boi8XLJE8+w0qT5393BAZNqlCko+LgxRzZbCi8Z+Rw==
X-Google-Smtp-Source: ABdhPJzxQ46X904LC7SdX1OxgfYZGh679xt7ljs4C1VrLw2LOs2fKmXXqpQnB5h899W1S5F9/P9QAWj5hClmGrhzDOQ=
X-Received: by 2002:aa7:d8d8:: with SMTP id k24mr31403073eds.97.1600336255481;
 Thu, 17 Sep 2020 02:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200916133923.31-1-adrianhuang0701@gmail.com>
In-Reply-To: <20200916133923.31-1-adrianhuang0701@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 17 Sep 2020 02:50:44 -0700
Message-ID: <CAPcyv4j_85d-GF7fZZFg7KoEmoW2a1i5nXf2TOAqa759wb7u_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dax: Fix stack overflow when mounting fsdax pmem device
To: Adrian Huang <adrianhuang0701@gmail.com>
Message-ID-Hash: Z7LSRYQFQ22D7TY5PCJ63PYPYIX6OS56
X-Message-ID-Hash: Z7LSRYQFQ22D7TY5PCJ63PYPYIX6OS56
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z7LSRYQFQ22D7TY5PCJ63PYPYIX6OS56/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2020 at 6:41 AM Adrian Huang <adrianhuang0701@gmail.com> wrote:
>
> From: Adrian Huang <ahuang12@lenovo.com>
>
> When mounting fsdax pmem device, commit 6180bb446ab6 ("dax: fix
> detection of dax support for non-persistent memory block devices")
> introduces the stack overflow [1][2]. Here is the call path for
> mounting ext4 file system:
>   ext4_fill_super
>     bdev_dax_supported
>       __bdev_dax_supported
>         dax_supported
>           generic_fsdax_supported
>             __generic_fsdax_supported
>               bdev_dax_supported
>
> The call path leads to the infinite calling loop, so we cannot
> call bdev_dax_supported() in __generic_fsdax_supported(). The sanity
> checking of the variable 'dax_dev' is moved prior to the two
> bdev_dax_pgoff() checks [3][4].

Looks good, and passes tests.

> [1] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/BULZHRILK7N2WS2JVISNF2QZNRQK6JU4/
> [2] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/OOZGFY3RNQGTGJJCH52YXCSYIDXMOPXO/
> [3] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMQW2LY3QHPXOAW76RKNSCGG3QJFO7HT/
> [4] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7E2X6UGX5RQ2ISGYNAF66VLY5BKBFI4M/

lists.01.org has already proven to not be reliable for maintaining
permanent list archive links. The most reliable way to reference a
message is via lore.kernel.org.

    http://lore.kernel.org/r/$MSG_ID

For example your first link is here:

   http://lore.kernel.org/r/1420999447.1004543.1600055488770.JavaMail.zimbra@redhat.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

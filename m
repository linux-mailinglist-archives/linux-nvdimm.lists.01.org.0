Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD51C303104
	for <lists+linux-nvdimm@lfdr.de>; Tue, 26 Jan 2021 01:51:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B0B90100EBBBE;
	Mon, 25 Jan 2021 16:51:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=guoqing.jiang@cloud.ionos.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A0B2C100EC1C6
	for <linux-nvdimm@lists.01.org>; Mon, 25 Jan 2021 16:51:08 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p15so673121pjv.3
        for <linux-nvdimm@lists.01.org>; Mon, 25 Jan 2021 16:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uPJlUchjV+OaTIftOWbXEjVwG0d/bApny8LKz3OH9do=;
        b=Fn4EVg48BXJQ0XVCGo4P1/CcZQYyaUjR593N0Mrt0Pa+QokgKItCP+8Jqv/2LG0i6e
         ZOE+o7Kp6TSk5kE5z/p+B9iYW/TEKeeUZ38hHU2REBudTZapniqQIgruui5UYR2CX3jM
         XMAbvuY6JHqMBPOAxvGF/pd+dD2JXyjuQuYgOdpBoKEe5OkwN21A1Oz9evbFfBDmAQvY
         7WFdRbpEZ2liR9Ig+qsbIiWSj+GDDvognZEVlwuSJJV6ndniZaVtaxhiGOys5MNoWytQ
         gQ7Z3yycyJCcMckSCcJGV82qUswKaz/f7sRYaD0P22YuS9ZNrnmyYgBqU8O8EcKu5dJk
         dg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uPJlUchjV+OaTIftOWbXEjVwG0d/bApny8LKz3OH9do=;
        b=aM+Lsvm42bjIAEBJU+0iLD7nPy7CpYP1+2uvjGSGOylPATETUV6YKM/Zb3LSj2mlAU
         rzbC/gtummiA3+2i+Z2vUZK7zodtoSWHR+QYKyL+32rE/AybmnUbuYha7OZGcmiQ1M4h
         GeZonQnINLaIqmeY3UAbj9spRogDbrhZDqPYZw276RJlUOCixQpn6LwqsQfahcnctLhi
         lHUSgbVbAaRbgmGzhkfNt3YBAAWbXomQdIJqRkAVAxAU5T0rihwoHTymX0864YQhDgrp
         i7VdTPiPzTp/aLRdARqQ8f5qnWwKt1F/ZnZkBBy1t0zmwUGmlz4EXWl+s83BMu9qgvVH
         rZTA==
X-Gm-Message-State: AOAM533EOf8GCd9DqqeQ2YflAhK77HFDRmqONkpQm4+zXgWctWXf7FU3
	jUvwSr1XG9py1KIXGg145obw4w==
X-Google-Smtp-Source: ABdhPJzzs4C/lNGU5gJfjXLgueQ6h//2HOCs2JEgJn8fHs+SjPK/bp53wfdpI/yc0gqOKDwXYe/jwg==
X-Received: by 2002:a17:902:c284:b029:df:c0d8:6b7 with SMTP id i4-20020a170902c284b02900dfc0d806b7mr3120918pld.34.1611622266246;
        Mon, 25 Jan 2021 16:51:06 -0800 (PST)
Received: from [10.8.1.5] ([185.125.207.232])
        by smtp.gmail.com with ESMTPSA id r7sm3940119pfc.26.2021.01.25.16.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 16:51:05 -0800 (PST)
Subject: Re: [PATCH v2 08/10] md: Implement ->corrupted_range()
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
References: <20210125225526.1048877-1-ruansy.fnst@cn.fujitsu.com>
 <20210125225526.1048877-9-ruansy.fnst@cn.fujitsu.com>
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <6100b7ca-7968-e1ea-84b8-074dc216a453@cloud.ionos.com>
Date: Tue, 26 Jan 2021 01:50:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125225526.1048877-9-ruansy.fnst@cn.fujitsu.com>
Content-Language: en-US
Message-ID-Hash: 55F7WV6J5PVTRYUCLIGNI7RS5HIECP32
X-Message-ID-Hash: 55F7WV6J5PVTRYUCLIGNI7RS5HIECP32
X-MailFrom: guoqing.jiang@cloud.ionos.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/55F7WV6J5PVTRYUCLIGNI7RS5HIECP32/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On 1/25/21 23:55, Shiyang Ruan wrote:
> With the support of ->rmap(), it is possible to obtain the superblock on
> a mapped device.
> 
> If a pmem device is used as one target of mapped device, we cannot
> obtain its superblock directly.  With the help of SYSFS, the mapped
> device can be found on the target devices.  So, we iterate the
> bdev->bd_holder_disks to obtain its mapped device.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>   drivers/md/dm.c       | 61 +++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvdimm/pmem.c | 11 +++-----
>   fs/block_dev.c        | 42 ++++++++++++++++++++++++++++-
>   include/linux/genhd.h |  2 ++
>   4 files changed, 107 insertions(+), 9 deletions(-)

I can't see md raid is involved here, perhaps dm-devel need to be cced 
instead of raid list. And the subject need to be changed as well.

Thanks,
Guoqing
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

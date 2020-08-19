Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AAF24A019
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 15:35:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB0C812F414B2;
	Wed, 19 Aug 2020 06:35:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com; envelope-from=oohall@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7E82612F414B0
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 06:35:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s1so11585156iot.10
        for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQbF5ToGvxtok3B/02NDGGrHeRjOkJ58wAMUSrl6Pas=;
        b=vKaD8Sx9KmC3IIMDIQCjFPpu/NbsjPZssGuEjvUjMhvGEQBmdkX4cxvmSNSWCrPpfQ
         Jh89OXy5iodfr8DU27Y+zTXRqJ83sAcBQk3xtbDuyxRrQOUhDm+ojd1kKTAxud38+0XZ
         /yqP+p2fnHm0Fa3pFV+d3n3bkYoiP1Uk/amk+zFNQbXA/ugglYnhe4zbkt1IXu2oNIC6
         B0GceuzO7SUNanXjFrOrREzEYkKZo9waYMeq5bYt1ZiYPSFs94UqT9cXmuKs2vpjtyBG
         GjfhWektczaOz8SyqhH87G5aoZfm3UQBYKoVp3Ej8ptmbQbAvGdYXVQAKp78UwVD+mER
         AEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQbF5ToGvxtok3B/02NDGGrHeRjOkJ58wAMUSrl6Pas=;
        b=GUTkmqCaFfMbveAlku4TvmZH9hPPcTeRBuUwjVWgSkdrJ8jeXNhVBBfY+a/TPnum16
         VW7+yz0Gf471GrtLH5vI34lQl8WTEstDI6qtBZyQUi3KUHZNmXBbV1o8W/2TqG7rehWj
         cmB19sEjYRl9sVrY2CcuxzNQpepeuhWQwvlneeji5IEkoEfycl+RkS3ThE8PPAMRIcUB
         paKElg1jvEHyDTvFO1g/6cayypIi2dA7+z1D2vpTLDV8yevbAYMqCxL76lTt1ugt8/Mf
         xo8vP/UXhKsAX5HXzeRKKuzK0NFe0bzAsZXjSHYtyTOSUJnK3d/a6Egnd6J3aipzvugF
         27Wg==
X-Gm-Message-State: AOAM5329G7nXD5kVDoVJpYabHiBlpvpGSZHf3TUfO4ZYG87SUTg9934w
	2FOf0IN+UMxLYRb31GWOY28oaAikBvuwzufynaM=
X-Google-Smtp-Source: ABdhPJy7fpbKA4HrI6eBBnJsIpumTwdYNdK0/ohsv+IJtnagN8iLmxtFuzQvZmKvg9G01hldaFmE53nOjxbyMlk/lvs=
X-Received: by 2002:a5d:80c9:: with SMTP id h9mr18805669ior.73.1597844121380;
 Wed, 19 Aug 2020 06:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-2-thunder.leizhen@huawei.com> <5cc26ce3-963e-3ab6-6f97-706cea00c5f3@web.de>
In-Reply-To: <5cc26ce3-963e-3ab6-6f97-706cea00c5f3@web.de>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 19 Aug 2020 23:35:08 +1000
Message-ID: <CAOSf1CGJ6JNBuN+EpLttpf0HYOtN8dpqoTscGYHEbxqb9ANkVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] libnvdimm: Fix memory leaks in of_pmem.c
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID-Hash: DYI55SDXPDJVQ6LHDALVDUM54OXEOL35
X-Message-ID-Hash: DYI55SDXPDJVQ6LHDALVDUM54OXEOL35
X-MailFrom: oohall@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Zhen Lei <thunder.leizhen@huawei.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DYI55SDXPDJVQ6LHDALVDUM54OXEOL35/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 19, 2020 at 10:28 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > The memory priv->bus_desc.provider_name allocated by kstrdup() is not
> > freed correctly.

Personally I thought his commit message was perfectly fine. A little
unorthodox, but it works.

> How do you think about to choose an imperative wording for
> a corresponding change description?

...but this! This is word salad.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=18445bf405cb331117bc98427b1ba6f12418ad17#n151
>
> Regards,
> Markus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

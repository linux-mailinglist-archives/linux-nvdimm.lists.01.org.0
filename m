Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717EF2128AA
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Jul 2020 17:53:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE588114726CD;
	Thu,  2 Jul 2020 08:53:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com; envelope-from=naresh.kamboju@linaro.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BF26D1142B3BE
	for <linux-nvdimm@lists.01.org>; Thu,  2 Jul 2020 08:52:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so32828296ljv.5
        for <linux-nvdimm@lists.01.org>; Thu, 02 Jul 2020 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1hZZYHT2jx0soQwDY2Nw4ZNux9TK2TS4ou5sFWlySY=;
        b=KwW+/U9fkM+srFlFPvkKz4V3jEnKIKH8ygaroNt4YXgCxeue/VrdTKoJwmcn9oXIVs
         4DY0ZVk34mPlw7u4KLu6rGjhvnrQL6/lofTS76CSIpt1KUwe2M3VISdDz83TvG8iTXSI
         W47Pw8OTk/hC0zb2MZaQ1r596h7N8T5A23JSQkaU9RWiYgGd5Xav7JwLesO4IqMIFUZL
         2VuieIxaw/GaR9iMUF6CkG5lHBbOPJgWIfkSCxXHB48wkXOO7uuaIH8G93d6r33rKKeJ
         p2LG1w2EFwjJvNEP/726kUUAmMNBPXMl5+BvhQTxMO/S6XCBw/1QqIdNdExANIirUL/4
         +A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1hZZYHT2jx0soQwDY2Nw4ZNux9TK2TS4ou5sFWlySY=;
        b=oWUWwds0vNQOLQAKtVbzvzoiKJK2z9ArAk3GMTEPmBYOXl+CSM1Dyb/plLFInA8pF0
         aPlVTGsigy4cOyDOSU3yN6rCcxqtzH1tq5p3vA7tU4txhKNIKLXnb5YoP3iSpF7VK2D4
         Vej1UGV5ZeAeEKU7YvjQEhRnylbrZRsLIGjhMNVKZhI/gRopusIx7GicaRNlC/KHBl2L
         rLjQXVN0iztnWf10+RqDauVNgF9gipAeR8drDnxucaZg8eiwveukhIYJI6CwZfDon5jG
         S0qB6HMADs4PxU76x4ns4B9eef8TW9v11fMU08UKnWGxKu6PA3u6soqdKqpkjVW/wNCY
         +M2w==
X-Gm-Message-State: AOAM531w3VQv+wQKfuLAMOYnfOi2dkOgew6kuP9PEzOLG3lRalOIfLyP
	aKLmpcZaHiMT/EUjni0n4Dcn+pEhR5myqrnNtYPXgA==
X-Google-Smtp-Source: ABdhPJz3ABkPWjkv8L0FIiK+Kjjg6BO4eaaimJnKQo1xzAYZPxzmmzDpXVUF4bLDPypwEcFJ8kmLmaUrHoL1B8Z52PM=
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr16463205ljp.266.1593705177353;
 Thu, 02 Jul 2020 08:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200629193947.2705954-1-hch@lst.de> <20200629193947.2705954-19-hch@lst.de>
 <20200702141001.GA3834@lca.pw> <20200702151453.GA1799@lst.de>
In-Reply-To: <20200702151453.GA1799@lst.de>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 2 Jul 2020 21:22:46 +0530
Message-ID: <CA+G9fYv6DfJB=DeQFVptAuaVv1Ng-BK0fRHgFZ=DNzymu8LVvw@mail.gmail.com>
Subject: Re: [PATCH 18/20] block: refator submit_bio_noacct
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: QZMRK5YUIVOPJWR23HVAKBW2NVPMRCZX
X-Message-ID-Hash: QZMRK5YUIVOPJWR23HVAKBW2NVPMRCZX
X-MailFrom: naresh.kamboju@linaro.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Qian Cai <cai@lca.pw>, Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com, open list <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QZMRK5YUIVOPJWR23HVAKBW2NVPMRCZX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2020 at 20:45, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 02, 2020 at 10:10:10AM -0400, Qian Cai wrote:
> > On Mon, Jun 29, 2020 at 09:39:45PM +0200, Christoph Hellwig wrote:
> > > Split out a __submit_bio_noacct helper for the actual de-recursion
> > > algorithm, and simplify the loop by using a continue when we can't
> > > enter the queue for a bio.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Reverting this commit and its dependencies,
> >
> > 5a6c35f9af41 block: remove direct_make_request
> > ff93ea0ce763 block: shortcut __submit_bio_noacct for blk-mq drivers
> >
> > fixed the stack-out-of-bounds during boot,
> >
> > https://lore.kernel.org/linux-block/000000000000bcdeaa05a97280e4@google.com/
>
> Yikes.  bio_alloc_bioset pokes into bio_list[1] in a totally
> undocumented way.  But even with that the problem should only show
> up with "block: shortcut __submit_bio_noacct for blk-mq drivers".
>
> Can you try this patch?

Applied your patch on top of linux-next 20200702 and tested on
arm64 and x86_64 devices and the reported BUG fixed.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index bf882b8d84450c..9f1bf8658b611a 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1155,11 +1155,10 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>  static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>  {
>         struct gendisk *disk = bio->bi_disk;
> -       struct bio_list bio_list;
> +       struct bio_list bio_list[2] = { };
>         blk_qc_t ret = BLK_QC_T_NONE;
>
> -       bio_list_init(&bio_list);
> -       current->bio_list = &bio_list;
> +       current->bio_list = bio_list;
>
>         do {
>                 WARN_ON_ONCE(bio->bi_disk != disk);
> @@ -1174,7 +1173,7 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>                 }
>
>                 ret = blk_mq_submit_bio(bio);
> -       } while ((bio = bio_list_pop(&bio_list)));
> +       } while ((bio = bio_list_pop(&bio_list[0])));
>
>         current->bio_list = NULL;
>         return ret;

ref:
https://lkft.validation.linaro.org/scheduler/job/1538359#L288
https://lkft.validation.linaro.org/scheduler/job/1538360#L572


- Naresh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

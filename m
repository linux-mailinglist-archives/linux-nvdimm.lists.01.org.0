Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D4F1D1D76
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 May 2020 20:29:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 47C3311AB2CE8;
	Wed, 13 May 2020 11:26:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=song@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E2D3A11AB2CE8
	for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 11:26:51 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 3C1232065C
	for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 18:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589394571;
	bh=QRSsQMrQ74camPjAugEMwP/lQqJBw3KN+yss8wjRYVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=zuYgTbgg+vneAleokfO2ukKNs/dqZRWw5cokGloCn06DRltmLMyAH0XWH7ZXE6kme
	 ad+FAFkx841tWRfGJCwJuCCrF9NfvNSBS/VNkG+/4QSbaYBUc8DgdG1PYWFgMFsatw
	 bhT63We9c1wVG6MA7eSBOs4coDppYUwq6NJFs550=
Received: by mail-lf1-f43.google.com with SMTP id v5so321318lfp.13
        for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 11:29:30 -0700 (PDT)
X-Gm-Message-State: AOAM531TZp6my8+ESoEBoC6EIdwBFs+n/t+zVcwOsfsdqYYKtS3SxnAH
	+0aMZyySItRjZ/iRGtQYaP7OL5D1Q2VDGNTakQI=
X-Google-Smtp-Source: ABdhPJzEel6P56V5AzdhnqpR97v3ZXYr3I1lEd0oqpxPoU0DCjvc+wX2TsHUs+/MUKk1AS+L8zGBfF+JTi024W0oARc=
X-Received: by 2002:ac2:558e:: with SMTP id v14mr539886lfg.138.1589394568604;
 Wed, 13 May 2020 11:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de> <20200508161517.252308-13-hch@lst.de>
In-Reply-To: <20200508161517.252308-13-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Wed, 13 May 2020 11:29:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6_Y53_XLFeVxhTDpTi_PKNLqqnrXLn+M2fJW268eE6_w@mail.gmail.com>
Message-ID: <CAPhsuW6_Y53_XLFeVxhTDpTi_PKNLqqnrXLn+M2fJW268eE6_w@mail.gmail.com>
Subject: Re: [PATCH 12/15] md: stop using ->queuedata
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: LFXIAJPSCBDBOH2MJNY7WHLQH72PAJVX
X-Message-ID-Hash: LFXIAJPSCBDBOH2MJNY7WHLQH72PAJVX
X-MailFrom: song@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>, Joshua Morris <josh.h.morris@us.ibm.com>, Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-m68k@lists.linux-m68k.org, open list <linux-kernel@vger.kernel.org>, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LFXIAJPSCBDBOH2MJNY7WHLQH72PAJVX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 8, 2020 at 9:17 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the cleanup. IIUC, you want this go through md tree?

Otherwise,

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/md.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 271e8a5873549..c079ecf77c564 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -466,7 +466,7 @@ static blk_qc_t md_make_request(struct request_queue *q, struct bio *bio)
>  {
>         const int rw = bio_data_dir(bio);
>         const int sgrp = op_stat_group(bio_op(bio));
> -       struct mddev *mddev = q->queuedata;
> +       struct mddev *mddev = bio->bi_disk->private_data;
>         unsigned int sectors;
>
>         if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
> @@ -5626,7 +5626,6 @@ static int md_alloc(dev_t dev, char *name)
>         mddev->queue = blk_alloc_queue(md_make_request, NUMA_NO_NODE);
>         if (!mddev->queue)
>                 goto abort;
> -       mddev->queue->queuedata = mddev;
>
>         blk_set_stacking_limits(&mddev->queue->limits);
>
> --
> 2.26.2
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

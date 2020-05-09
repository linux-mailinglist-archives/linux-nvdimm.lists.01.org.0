Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388D01CC064
	for <lists+linux-nvdimm@lfdr.de>; Sat,  9 May 2020 12:38:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 454EE1190036E;
	Sat,  9 May 2020 03:36:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.194; helo=mail-oi1-f194.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F19A71183DF2C
	for <linux-nvdimm@lists.01.org>; Sat,  9 May 2020 03:36:05 -0700 (PDT)
Received: by mail-oi1-f194.google.com with SMTP id i13so10818641oie.9
        for <linux-nvdimm@lists.01.org>; Sat, 09 May 2020 03:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBe+65cgrmufPqKgCO/WJS9rGOrSoS9DaeQpyO6VPQY=;
        b=QxcwTtX2B0WUfHtlkrs4oKQabqEVaPAqZRZLGpAjLYSaFA+5bGBL6H4BFF9XnvY3J6
         dRm7h5beH2fNL4txcqCG6gjOGiZmGXakVs1FuGyY1Luyq2vAF5wN0bwbcHmonoi6FdYS
         3tBP82L02qs4awMCy2b6WYuSyKo5YwroV3laPmnw9PNkeideS3wubeoRdhAquWOczmO3
         +C+0+at/SBj1cicIknHxQ+X1o3IEtAE+y5L/SAitelXPuQYfgl4ffAX8vl5EgnCesIgn
         fkJDN1w7lIfVkMTEmzd6Qi8835MrH5gK8R3vVtYpDH6K6rJwKG8pdEYjUpc/9IoGps4s
         G6bg==
X-Gm-Message-State: AGi0PubbttFKR7zuVLVwdl/k3zijtOygqiqLxU7y/OsuxAHxo51MFDbc
	ion4IHloSxpmx4rSumxTfENhyRlBN6oiw/KY8jA=
X-Google-Smtp-Source: APiQypJViR7zf1BxfE4fSiEMumUvdAfdspNngdk/6s5fr4R3Q+whgmTLapvbuOPEuAwW4U0ZD7JgMnKsLrBjVv9lPKw=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr13605566oig.54.1589020691722;
 Sat, 09 May 2020 03:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de> <20200508161517.252308-2-hch@lst.de>
In-Reply-To: <20200508161517.252308-2-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 9 May 2020 12:38:00 +0200
Message-ID: <CAMuHMdUBRsZQ1BOD9jW99NTm_8NZDootGrqzz3nPeeJ+mUAoTw@mail.gmail.com>
Subject: Re: [PATCH 01/15] nfblock: use gendisk private_data
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: NND6TEMQV67VODGP5BIF7OS6X46SBWA3
X-Message-ID-Hash: NND6TEMQV67VODGP5BIF7OS6X46SBWA3
X-MailFrom: geert.uytterhoeven@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>, Joshua Morris <josh.h.morris@us.ibm.com>, Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, Lars Ellenberg <drbd-dev@lists.linbit.com>, linux-block@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NND6TEMQV67VODGP5BIF7OS6X46SBWA3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Christoph,

On Fri, May 8, 2020 at 6:16 PM Christoph Hellwig <hch@lst.de> wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> --- a/arch/m68k/emu/nfblock.c
> +++ b/arch/m68k/emu/nfblock.c
> @@ -61,7 +61,7 @@ struct nfhd_device {
>
>  static blk_qc_t nfhd_make_request(struct request_queue *queue, struct bio *bio)
>  {
> -       struct nfhd_device *dev = queue->queuedata;
> +       struct nfhd_device *dev = bio->bi_disk->private_data;
>         struct bio_vec bvec;
>         struct bvec_iter iter;
>         int dir, len, shift;
> @@ -122,7 +122,6 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
>         if (dev->queue == NULL)
>                 goto free_dev;
>
> -       dev->queue->queuedata = dev;
>         blk_queue_logical_block_size(dev->queue, bsize);
>
>         dev->disk = alloc_disk(16);
> @@ -136,6 +135,7 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
>         sprintf(dev->disk->disk_name, "nfhd%u", dev_id);
>         set_capacity(dev->disk, (sector_t)blocks * (bsize / 512));
>         dev->disk->queue = dev->queue;
> +       dev->disk->private_data = dev;

This is already set above, just before the quoted sprintf() call.

>
>         add_disk(dev->disk);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6620DD32
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 23:47:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2507111FF499;
	Mon, 29 Jun 2020 14:47:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.65; helo=mail-ot1-f65.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 78A0B110122B2
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 14:47:47 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id q21so9299892otc.7
        for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 14:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bg/8+MNYJDDCvPfevV5MmVW6eomjiYjuKJdPS9BuKRc=;
        b=OxWDysyJW7VaVHRxEmwE+nMZKh+BIfHHMir/zEBULaO1odVTDwZQv1YC+0wH7cWkKG
         E4AJEHRQ/io0l4Dn2j+EbOLLrqRUwLnwqmh06HTMKlfF7/sYhwA0ia4CfzvcLIUaZfhc
         +WAAHf13SaVoI6w8YhpPAysIMKDp2JaRiPI3UwtvF/kcgV8QwtuKeGmjE0Y8o6wzUUuG
         SnANlSRPP17hDvZUmz2zB9IGOUuRHNq6yDg42cwNk4zHKA1x3o7nSAnt0LWryC+oCckg
         sAFCylaGKIusRwnd/wSO2TR6mCk06UevEki5MHZQYDCMoprAKl2/0V65tq3nCAYKqPfw
         TsGA==
X-Gm-Message-State: AOAM531I9eHq3E52dVfvASfr3dqHTyCV5RePKPrr8cCxvq8vkYgxI35+
	kfa+M3u+onmRwr7rMYwDleH7TMpliencsOe46So=
X-Google-Smtp-Source: ABdhPJyLaroA0htJgp6XAeP34onG9mo2tlAy+lOvoV/8lvJ36fwjwGDczPcQeW26SHMu76Ngn9P5yzkiLg9cpAETRvQ=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr14223999otb.107.1593467266175;
 Mon, 29 Jun 2020 14:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200629193947.2705954-1-hch@lst.de> <20200629193947.2705954-2-hch@lst.de>
In-Reply-To: <20200629193947.2705954-2-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2020 23:47:35 +0200
Message-ID: <CAMuHMdXXORM_yD4bqk+MQ1yEA1jmOjO9eyfnsjxY1a5E5isEcg@mail.gmail.com>
Subject: Re: [PATCH 01/20] nfblock: stop using ->queuedata
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: 6YK6OVEGPNG3SBNXGTOMJH5FCAEAWP75
X-Message-ID-Hash: 6YK6OVEGPNG3SBNXGTOMJH5FCAEAWP75
X-MailFrom: geert.uytterhoeven@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, Lars Ellenberg <drbd-dev@lists.linbit.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, linux-nvme@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6YK6OVEGPNG3SBNXGTOMJH5FCAEAWP75/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 29, 2020 at 9:40 PM Christoph Hellwig <hch@lst.de> wrote:
> Instead of setting up the queuedata as well just use one private data
> field.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

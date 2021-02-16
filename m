Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF9731CB59
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Feb 2021 14:43:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C824C100EB839;
	Tue, 16 Feb 2021 05:43:45 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=brgl@bgdev.pl; receiver=<UNKNOWN> 
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EB695100EBB6A
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 05:43:42 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id do6so6173131ejc.3
        for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 05:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4aIEOUjOCrSjLDXb3mtmGNuNkXiSZIhPKzU5zM+aPQ=;
        b=buncBvKPoDgi0mDnNxcMtJUW4SBhK1bNmdC5f+v/hQTv8lmNwxCoBI4WE2VR3MNGuA
         N+qnbz2mtngGoLCQiJMUWBKoVLmqQH8Dkw0rER13qkahBHeXieNixC1cS/4+I9PB62RS
         KQV+HChSOcQy0VTzRbiEytQMJiO56rKxjjqJgnauyxWGA4uf+09V+otQ+Ek5foCRuxp1
         WafmVcb7Prh/18Kw+8tv7XOaCHyvz5uKczY+84ard8unxSMnu0RiALTRoaLWs82Mv1Vn
         kqZgu2+9+4vRj5kMyiM7/c/34S0pm3DGa3h6NS7fm2FJhZLCdr4k5UXt68Y3hQrgLQ20
         0YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4aIEOUjOCrSjLDXb3mtmGNuNkXiSZIhPKzU5zM+aPQ=;
        b=LwqIPnIBYKHlq5eQsQVHhemlIoVy5NaoBQAHIeYuRnxxfBwKFiUlrtdIbcWpBd6mXx
         etdnVYWnr8eeowrCvAj1C8svUjyfS7PUQky8K0QKycSGmE4yOFTUKh84jbxloH9vEySP
         mDFE9l06J0jgYcCNxq1cVApfLcKBgGnKdRHetNsKfxHigLWtI2ii+OQMxDkYnn4Eape2
         +NuswJUpmvpl50co6G4Fx/teeafAkzcm45ppX1W45LF1mLRln4XqsHcdVOu+a3lDJuqt
         y4ek/z5IX7/okS7vzfu0oMCO7a80VMK+5NLEzmQYTxBWc7A3lwY4sjH8KrKMXtiOKTVG
         AM6A==
X-Gm-Message-State: AOAM531wwMM5NVMTG9euPw+qUJ3t/CjhN4rWbwJ5YD/AttF8bfo6Ac9R
	d27S3MQalYDtghTIX2sAvNA2RUY9ps4ZNrd0XFI9aw==
X-Google-Smtp-Source: ABdhPJwNiuPUvaLufGG9a0tPuHT7VrdTNyIONpTy7saz/PN9GNeWzcq1nq86MBlPBPSx6AlQhTFZdN7QElpujVjK1Do=
X-Received: by 2002:a17:906:4a8e:: with SMTP id x14mr17745633eju.445.1613483020380;
 Tue, 16 Feb 2021 05:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-7-ben.widawsky@intel.com> <20210211120215.00007d3d@Huawei.com>
In-Reply-To: <20210211120215.00007d3d@Huawei.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Feb 2021 14:43:29 +0100
Message-ID: <CAMRc=MfhKMH+CcGxo_8j58c-NT_gQsZRqSjeH5mV3vCKUTWvhQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] cxl/mem: Enable commands via CEL
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID-Hash: J5VNW3YG36HHLSM3KFWGLCVCCS7KQMZS
X-Message-ID-Hash: J5VNW3YG36HHLSM3KFWGLCVCCS7KQMZS
X-MailFrom: brgl@bgdev.pl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J5VNW3YG36HHLSM3KFWGLCVCCS7KQMZS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 11, 2021 at 1:12 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>

[snip!]

> >
> > @@ -869,6 +891,14 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> >       mutex_init(&cxlm->mbox_mutex);
> >       cxlm->pdev = pdev;
> >       cxlm->regs = regs + offset;
> > +     cxlm->enabled_cmds =
> > +             devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
> > +                                sizeof(unsigned long),
> > +                                GFP_KERNEL | __GFP_ZERO);
>
> Hmm. There doesn't seem to be a devm_bitmap_zalloc
>

FYI I've implemented both devm_bitmap_zalloc() as well as
devm_bitmap_alloc() and made them part of a series I sent out to
linux-gpio two weeks ago (surprisingly - it's nowhere to be found on
lkml or spinics or even patchwork :/). The patches didn't make it for
v5.12 but I'll respin them after the merge window, so we'll have those
devres helpers for v5.13.

Bartosz
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

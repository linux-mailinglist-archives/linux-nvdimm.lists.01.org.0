Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C8644D2F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 22:15:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B6B742129670B;
	Thu, 13 Jun 2019 13:15:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4D2052128D6BA
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 13:15:26 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id m202so308927oig.6
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gYvi3JENt5xjT7/oQoCCDRRyhuGQKrPeHYLl1e4tUxo=;
 b=HiQM8Oj8L+VS1a8Hidw0xr9iYYaQmKDaapqQQLP3xBSAjW2G7zF8GCiMqjGr/ym+Mo
 M+OqlxjvRB4nsYJvbsbx5Z3ifuAo0JozSHiAbNq39t8D2waMsSabG6FDy40WGT4oYy8V
 L96EPmLmkBZ66RnBr04w7xeY6utWIJLm5CrypM9lYrEcqa9F/Z5nPa4IShCeMmTv0t0L
 gS2NRGRi4wYn5eA9ZuBqSXqoz8gXypGTSbll9Wp2Y8UNYHgTyBR1qyLVx2ig9t9lcYmD
 HVaPJZLwJOeNsVJ9c9ozc803Mh/zRF+OxcMsrpFkoEYk0fk+301QRIAXIyrgvI3K0bkW
 VbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gYvi3JENt5xjT7/oQoCCDRRyhuGQKrPeHYLl1e4tUxo=;
 b=Yn/5eYwnso9t6DC1coxfKhH4Ums0ojZW8TPG/mgKwDhrjS2CDun+s07oyKeeiWigpy
 oAiMeiNmJ9fVPJwoMHLAH/16K7kj3xdiRpQAgFyEk1vOGPX4PqttahVP++H9QhrJ9pKt
 yJtAuQv3rUgulMgOkXC3u6+KhJ0qis/GYJJ8i3OEDQ8rPqmnzg9fBtr8GeaKrkn0FwKe
 IGhcehV/xDCSQjOEJ8pmFBmWgp3oF3LNvBamCQPH2bssQQ8wmf1Bndf3803DofKzC4/I
 H3Eb9xJcWbQll8zq//lDCqs6sY8S2vQaWr21gVmpWJtQDxqVrZNzcrPbLtujvcEgK7dl
 Fuvg==
X-Gm-Message-State: APjAAAWTF7IrzsdDsllMdW2huFtdUeM1SQFCsRg4pGDOe05RGpir84rs
 jFhQ3SRjhvdEaOTHPVkLHr+2jg6GlYrSBtFA7i0WzA==
X-Google-Smtp-Source: APXvYqyS333Lp+D4vjCDNGXf2txUSus++eUTfldGM7ZmElD6Qov2BJs1+/5zSo9qFUO6PniS7TXRoikGBTwqET2Ahjo=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr4014371oih.73.1560456925540; 
 Thu, 13 Jun 2019 13:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-9-hch@lst.de>
 <d9e24f8e-986d-e7b8-cf1d-9344ba51719e@deltatee.com>
In-Reply-To: <d9e24f8e-986d-e7b8-cf1d-9344ba51719e@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Jun 2019 13:15:14 -0700
Message-ID: <CAPcyv4gApj=5eYCVSLidDJqF2V1YZiqUht1P26mSzUOjW-ykqA@mail.gmail.com>
Subject: Re: [PATCH 08/22] memremap: pass a struct dev_pagemap to ->kill
To: Logan Gunthorpe <logang@deltatee.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 nouveau@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 1:12 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-06-13 3:43 a.m., Christoph Hellwig wrote:
> > Passing the actual typed structure leads to more understandable code
> > vs the actual references.
>
> Ha, ok, I originally suggested this to Dan when he introduced the
> callback[1].
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reported-by: Logan Gunthorpe <logang@deltatee.com> :)


>
> Logan
>
> [1]
> https://lore.kernel.org/lkml/8f0cae82-130f-8a64-cfbd-fda5fd76bb79@deltatee.com/T/#u
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

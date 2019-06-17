Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D7948A4B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 19:37:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DD7F321297054;
	Mon, 17 Jun 2019 10:37:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DCB8D21296049
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 10:37:25 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d17so10117557oth.5
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gBoBuo4G3FSgEhDC+FoktVJNloMg07m1kebASNjaow0=;
 b=GEy6EGCLZL0UwYQ9PkUNByAPZFrQNOY55J4Isr3tPIqQ98XVq0fsFEiJHE9y337UnR
 z0ckb3F0Q8bUBMwOxk3FMovLMeLeRhGzCH4bMfXl//v4SZneAiWL2E3nXGQ0kfcbkMQ5
 r05Q0aOOGSCIoONjGAUc0NUdIqrqwt9uOKpttnI5/W0wpWZ0UjI/eMzHv96YMzDyw6ea
 Iw2XLIDHbY2xAKMBDynID8VFE/XZYZnxY6Kobfxb5Ee621xVhNNWauS73uuIqKg8WlP8
 DC4G2oI80ceWohUqqQoEpsB1uZSHUXQoqzfwbmLCxnomOs9Nh6gRUrBB4UmmNwcz2q++
 zoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gBoBuo4G3FSgEhDC+FoktVJNloMg07m1kebASNjaow0=;
 b=OYEh/4R8YvlrRS8HfhLK3B9m1+6/gPe7VUMWCv4cPBr/gGu7pHcRwpOWEIyG4yz0tK
 RbPlNT+3N5KDo6Lja3IfbkWoKiHgkcbvLNhNwvtBhVottQal0j3mtl5sQ4k81ZXc9S4l
 nwlcgBns8euJCnI3a1t7WlYlh2di7V9GBjt82/OT0DjxpS7ph52qwnr+7VlNtHuf2W7x
 rMqTXHzkyxJc7kfokyxHVkivuK7AK+nzD/xE6QXa498qSOwD2aZbgjZEdudSogg2CjsD
 oNn+Y8Xmt/hG1ZL+sZ1BQI51f+zBbXIEjG+7iHOzc5zPCK75tWwf5nXPZeXPr8t7FFqn
 5KOw==
X-Gm-Message-State: APjAAAV+ZH0jHN3CWDHmQ3aPOv4pmxf+hkYhrEa+xghUKDE0PGqrUYsd
 1seqzS539HPjz6+JTb2bLekt3T5XGoMv+NaVdh9EXw==
X-Google-Smtp-Source: APXvYqy6UHQ+8+yRan8DQxrtjWFO0AeHWuMCd0MZM6YFNNcDvh4g1h/fJSpQjjAZ+ZTnayEmtlW26P14xfxTxsyl170=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr25335686otf.126.1560793043776; 
 Mon, 17 Jun 2019 10:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de>
 <20190617122733.22432-7-hch@lst.de>
In-Reply-To: <20190617122733.22432-7-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 17 Jun 2019 10:37:12 -0700
Message-ID: <CAPcyv4hoRR6gzTSkWnwMiUtX6jCKz2NMOhCUfXTji8f2H1v+rg@mail.gmail.com>
Subject: Re: [PATCH 06/25] mm: factor out a devm_request_free_mem_region helper
To: Christoph Hellwig <hch@lst.de>
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
Cc: John Hubbard <jhubbard@nvidia.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 17, 2019 at 5:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Keep the physical address allocation that hmm_add_device does with the
> rest of the resource code, and allow future reuse of it without the hmm
> wrapper.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/ioport.h |  2 ++
>  kernel/resource.c      | 39 +++++++++++++++++++++++++++++++++++++++
>  mm/hmm.c               | 33 ++++-----------------------------
>  3 files changed, 45 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..76a33ae3bf6c 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -286,6 +286,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
>         return (r1->start <= r2->end && r1->end >= r2->start);
>  }
>
> +struct resource *devm_request_free_mem_region(struct device *dev,
> +               struct resource *base, unsigned long size);

This appears to need a 'static inline' helper stub in the
CONFIG_DEVICE_PRIVATE=n case, otherwise this compile error triggers:

ld: mm/hmm.o: in function `hmm_devmem_add':
/home/dwillia2/git/linux/mm/hmm.c:1427: undefined reference to
`devm_request_free_mem_region'
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

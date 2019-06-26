Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEC356E3A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 18:01:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8363F212AB010;
	Wed, 26 Jun 2019 09:01:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B26FE2129F029
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 09:00:59 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a127so2345088oii.2
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r/963AMc32TjFW8pz2sb81LGtvemWumKWmOSWi/w+uo=;
 b=FEqk4AyqvI2SzCotbI6w47r7lIg1pbMai4XViymaBkOSAtj0NfKwJKshzu/N8BPJFi
 PPN0xns9/GQ3UjW0F9OUD+lLQxT0bLvpRO6rEeExsKdp48k3oiJcMS1RfpUHWI3YgQSe
 P3swXsvQ9fmeXBT6oobBozcpVgRGWN23FavhhN4cCEGhqIdsUZ+QWbmxpT1xgQhmYaLI
 wRlJBZOCxG1HxsggNiXJVMbdqx15uDTKnIMPx8OZYBLCprh9CGs/eCgDPe7/TAMtVU5d
 oafpIZj3xnh4RTWYjvBCXah4DbVlLssHna403/2Qrtq8aZqQJ+EBDW0IKrQkvHB1zCgf
 +PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r/963AMc32TjFW8pz2sb81LGtvemWumKWmOSWi/w+uo=;
 b=IS/Avv3GcX7VdN+SvNhQxpIh1GpuOjxpMFF3NxoIVs5GOj9ZXtnDS+jOWTMKr7w8wz
 nWIt+qLY2LgDAU4jNSYvM+ToGDj73/FVzzA/9WSogac9ObIg4fCmhoG0h1HtYCAxRmA5
 AUl+9lOjKGPUjtIpXB25iX8MOK+gy31xPPzcraN0QIqM+c9K2ZXaxGgGgn7BKcvwMIk4
 i16Irv9Q+z8JEQUqjqqtGIwpxWhAZLceyvEReJrnC5f1CzfiaKs8sZXt5pSDu2Wk4ecv
 dBslB5tRtfp/jkQmaasVyS0IFJD8quHCTnzn6eck6zeFKqUMK9utuw7rkiN5vmAAwfSI
 OMLQ==
X-Gm-Message-State: APjAAAVNF6Lq11twebAjcQPMc9jDFDTNB9zd60HB2NkkVL3H0N/EGHEQ
 9aflZactGJaRRdU5eFnUKOB0N2YuVNXNgZPSpX6A0w==
X-Google-Smtp-Source: APXvYqw+HKEk3o1E4qvsumKbcYL8DeGoSSUg6kQouoUdfkWJuiZCSiMJzuF3+UevbQqRwbob+TxTsET5oJi5oxrpxxs=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr2276731oii.0.1561564858765;
 Wed, 26 Jun 2019 09:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-5-hch@lst.de>
In-Reply-To: <20190626122724.13313-5-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Jun 2019 09:00:47 -0700
Message-ID: <CAPcyv4gTOf+EWzSGrFrh2GrTZt5HVR=e+xicUKEpiy57px8J+w@mail.gmail.com>
Subject: Re: [PATCH 04/25] mm: remove MEMORY_DEVICE_PUBLIC support
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 nouveau@lists.freedesktop.org,
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

[ add Ira ]

On Wed, Jun 26, 2019 at 5:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The code hasn't been used since it was added to the tree, and doesn't
> appear to actually be usable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
[..]
> diff --git a/mm/swap.c b/mm/swap.c
> index 7ede3eddc12a..83107410d29f 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -740,17 +740,6 @@ void release_pages(struct page **pages, int nr)
>                 if (is_huge_zero_page(page))
>                         continue;
>
> -               /* Device public page can not be huge page */
> -               if (is_device_public_page(page)) {
> -                       if (locked_pgdat) {
> -                               spin_unlock_irqrestore(&locked_pgdat->lru_lock,
> -                                                      flags);
> -                               locked_pgdat = NULL;
> -                       }
> -                       put_devmap_managed_page(page);
> -                       continue;
> -               }
> -

This collides with Ira's bug fix [1]. The MEMORY_DEVICE_FSDAX case
needs this to be converted to be independent of "public" pages.
Perhaps it should be pulled out of -mm and incorporated in this
series.

[1]: https://lore.kernel.org/lkml/20190605214922.17684-1-ira.weiny@intel.com/
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

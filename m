Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B31FCDB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 02:26:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9CFE1212794BE;
	Wed, 15 May 2019 17:26:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D1E3A2126CFA9
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:26:54 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 203so1171930oid.13
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ImJX0tiITgi2zeWUkjyeNnlcEhTnJ18f85h6yaNeNP4=;
 b=fQHacpe2ymfI8sqJ+whv4r+9XvKZbkea86O3xoYBqguZpTOJRspjOhxU64Qq/4vsH5
 oDLmngQ68PW81lPv5coyyGI58fcFPrrixmApE8YoVBMYYWjnerugGd8IPXk8j4syWpug
 Lriz/uX0F2DXGsHCNpWx1HztMF7wV0O+8B+3go5zyF9mxw4pxGvPJgCgdiV7nJCumxmU
 1j5ClsNI05YpSBM/kp8JsA78iJijlHPOVKyo2zxBZynLYyCU8WQje8Zuq0izaBU864LD
 DLY2Xi3L22XXzhTdH69p5ubKJCm6s1XHfBYzcfxNV6FVhGiRxCIVVjZKO1w7D9hPXzoZ
 CKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ImJX0tiITgi2zeWUkjyeNnlcEhTnJ18f85h6yaNeNP4=;
 b=qEQOwrqOBQbStNcmVWiY0sfLrt1qTUiRvDeVZJerqxGGguIibueYb6jlVVu4kTIN2X
 4FolTNHWijP72dUVZh0iP9sqW6m0GcSowFfWAHGRKscNvQOIbjRYypuIRFDJjq8PlNdZ
 UtDZnp3w/Nye1TmJZ/4E9XJwJ3Lf4BzisZMdoBgjlIOcPLVv0hEB3L1IczGFS4zg/rOy
 kD5JCK+cw2VFM+gyEU3eA9cWA0WtphIo7MIGFOF16Q2QQYY5wj0KAxXuRkilqW5XopxR
 s6vp2QF82hSs8RurQkvDy083dAaJMzA1tuhnDcXyzX4TbJPW1ZFl9aJnfpQP1Uefejtf
 u2Fw==
X-Gm-Message-State: APjAAAXWoYAfTVqrJK6FRUJavMCwoTdTI4DMp9kdjhw9PyNUjMVpgJ+i
 cVnY0jByZ37BAJM/B3+4ens+dQkk1JXUuYwtvLzbLA==
X-Google-Smtp-Source: APXvYqz1lPEsteF4K+RpI1xzzM89PLC7bK4Z05lIhq9ljpLi+5CiwTZXSrfgudjrTM34TT+MrQbfj8EWmzgk0MRe5Zw=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr4326676oie.73.1557966413422;
 Wed, 15 May 2019 17:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190514150735.39625-1-cai@lca.pw>
 <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
 <7ba8164b60be4e41707559ed6623f9462c942735.camel@intel.com>
In-Reply-To: <7ba8164b60be4e41707559ed6623f9462c942735.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 15 May 2019 17:26:42 -0700
Message-ID: <CAPcyv4gLr_WrNOg58C5tfpZTp2wso1C=kHGDkMvH4+sGniLQMQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cai@lca.pw" <cai@lca.pw>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 15, 2019 at 5:25 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Wed, 2019-05-15 at 16:25 -0700, Dan Williams wrote:
> >
> > > diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> > > index 4671776f5623..9f02a99cfac0 100644
> > > --- a/drivers/nvdimm/btt.c
> > > +++ b/drivers/nvdimm/btt.c
> > > @@ -1269,11 +1269,9 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
> > >
> > >                 ret = btt_data_read(arena, page, off, postmap, cur_len);
> > >                 if (ret) {
> > > -                       int rc;
> > > -
> > >                         /* Media error - set the e_flag */
> > > -                       rc = btt_map_write(arena, premap, postmap, 0, 1,
> > > -                               NVDIMM_IO_ATOMIC);
> > > +                       btt_map_write(arena, premap, postmap, 0, 1,
> > > +                                     NVDIMM_IO_ATOMIC);
> > >                         goto out_rtt;
> >
> > This doesn't look correct to me, shouldn't we at least be logging that
> > the bad-block failed to be persistently tracked?
>
> Yes logging it sounds good to me. Qian, can you include this in your
> respin or shall I send a fix for it separately (since we were always
> ignoring the failure here regardless of this patch)?

I think a separate fix for this makes more sense. Likely also needs to
be a ratelimited message in case a storm of errors is encountered.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A328D169BEE
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 02:43:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 664F710FC33E6;
	Sun, 23 Feb 2020 17:44:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::a43; helo=mail-vk1-xa43.google.com; envelope-from=adelva@google.com; receiver=<UNKNOWN> 
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 51DF810FC337F
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 17:44:34 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id m195so2097151vkh.10
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 17:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/tDUe/596kLQOTI3w8zi8SEzFY93PKMz1mi66rU0+Hs=;
        b=odvADANgVGTTfCRvnRE2ojhtUfO+STbMJFvaug7W5NcEtwaHV2bzfquurK62hxfoxz
         J1WGUscx/FqcJyd2LKg0uW/ayUJhMz9gW4laps101NC0y7kosjR2vtcLKWV5HCwLaVXZ
         55q8ZXghnSNGEp1J+fcMyICppzh9rikjzkwxhEZjC9Q33G6d4jZafMi9JMz3Tpocwicf
         ZKssWuh3fB05xobe3VJud4FR6mqwnA8UcC5XiVkFAT8aT3bmApl0EtWQGrD/KIvtlBGx
         xQpPlASjuOcmfu9RllWf90OuQBMIYy75dsmFnMc9rbZkj0Ote8ki0v0nu1zQ3Zilf1wF
         pipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tDUe/596kLQOTI3w8zi8SEzFY93PKMz1mi66rU0+Hs=;
        b=ZwgEsqkCqOfsmNVOse5vfUcoJ/H4SvOs911qAYM4Qw8ae4/1joA5Ep76mqTYY3NbBN
         XRu0jhwFS5CKRNDmXP2cix1KFTijva3ZnRL3gLizS92ellk+cQKlT5CsJ8TaSx/qs4Vt
         4KvUNULdPA31jgn+85kFFCCVO7RYEKwqM/GXn/TfhX2occxBQD549mLDkzR3rTIutWoi
         g++vgn6v2yx0mrt07feBuRedKfp07lWl3skli3/Txi42iCH6WZt+hAvkLaOKUqh0rGWe
         GD2Cpa1CsyK+SRuc+1GBCKMjRGRXyYShyT+wCfV57fivicjkW5ay+DW15cXSpubXXBs2
         XY2w==
X-Gm-Message-State: APjAAAVXEAFIiPm/BFgb6mrjMV5D3K3GXwYYbfv5Vbi4xUgJrtaaFOLj
	yHDToVBp51BgciTFgCOLGpvBZ+VPCPBVjxKDIPrJQA==
X-Google-Smtp-Source: APXvYqypuLtLmgW4rAaRuxj1Wpdl9Fq5n92rcRfcLstwQaDQC8z/1gbliCGTeVFx6ViQYEvWrjlLa+VXyYd2Ab1orhM=
X-Received: by 2002:a1f:90d4:: with SMTP id s203mr22035473vkd.65.1582508620766;
 Sun, 23 Feb 2020 17:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20200222183010.197844-1-adelva@google.com> <20200223145635.GB29607@iweiny-DESK2.sc.intel.com>
 <CAOSf1CH-WMA5DDt9LKcPPZwb-ya-y=1WCc8mrUEEDMjg0WeX5g@mail.gmail.com>
In-Reply-To: <CAOSf1CH-WMA5DDt9LKcPPZwb-ya-y=1WCc8mrUEEDMjg0WeX5g@mail.gmail.com>
From: Alistair Delva <adelva@google.com>
Date: Sun, 23 Feb 2020 17:43:29 -0800
Message-ID: <CANDihLF8bjOVAypQF-L-h82wcW5OBj4MQZRNRthAoaXPM51gpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm/of_pmem: handle memory-region in DT
To: "Oliver O'Halloran" <oohall@gmail.com>
Message-ID-Hash: NTJXKSRHYDSVAQNYJ3DYRCBSAGOAVMKB
X-Message-ID-Hash: NTJXKSRHYDSVAQNYJ3DYRCBSAGOAVMKB
X-MailFrom: adelva@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, Device Tree <devicetree@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NTJXKSRHYDSVAQNYJ3DYRCBSAGOAVMKB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Feb 23, 2020 at 5:42 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Mon, Feb 24, 2020 at 1:56 AM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Sat, Feb 22, 2020 at 10:30:09AM -0800, Alistair Delva wrote:
> > > From: Kenny Root <kroot@google.com>
> > >
> > > Add support for parsing the 'memory-region' DT property in addition to
> > > the 'reg' DT property. This enables use cases where the pmem region is
> > > not in I/O address space or dedicated memory (e.g. a bootloader
> > > carveout).
> > >
> > > Signed-off-by: Kenny Root <kroot@google.com>
> > > Signed-off-by: Alistair Delva <adelva@google.com>
> > > Cc: "Oliver O'Halloran" <oohall@gmail.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-nvdimm@lists.01.org
> > > Cc: kernel-team@android.com
> > > ---
> > >  drivers/nvdimm/of_pmem.c | 75 ++++++++++++++++++++++++++--------------
> > >  1 file changed, 50 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> > > index 8224d1431ea9..a68e44fb0041 100644
> > > --- a/drivers/nvdimm/of_pmem.c
> > > +++ b/drivers/nvdimm/of_pmem.c
> > > @@ -14,13 +14,47 @@ struct of_pmem_private {
> > >       struct nvdimm_bus *bus;
> > >  };
> > >
> > > +static void of_pmem_register_region(struct platform_device *pdev,
> > > +                                 struct nvdimm_bus *bus,
> > > +                                 struct device_node *np,
> > > +                                 struct resource *res, bool is_volatile)
> >
> > FWIW it would be easier to review if this was splut into a patch which created
> > the helper of_pmem_register_region() without the new logic.  Then added the new
> > logic here.
>
> Yeah, that wouldn't hurt.
>
> *snip*
>
> > > +     i = 0;
> > > +     while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {
> > > +             ret = of_address_to_resource(mr_np, 0, &res);
> > > +             if (ret)
> > > +                     dev_warn(
> > > +                             &pdev->dev,
> > > +                             "Unable to acquire memory-region from %pOF: %d\n",
> > > +                             mr_np, ret);
> > >               else
> > > -                     dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> > > -                                     ndr_desc.res, np);
> > > +                     of_pmem_register_region(pdev, bus, np, &res,
> > > +                                             is_volatile);
> > > +             of_node_put(mr_np);
> >
> > Why of_node_put()?
>
> "memory-region" is an array of pointers to nodes in /reserved-memory/
> which describe the actual memory region. of_parse_phandle() elevates
> the refcount of the returned node and we need to balance that.

That was my understanding too.

Thanks both for the review and sorry for the last minute untested
variable rename! I'll fix both and split the refactoring out in v2.

> >
> > Ira
> > >       }
> > >
> > >       return 0;
> > > --
> > > 2.25.0.265.gbab2e86ba0-goog
> > >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

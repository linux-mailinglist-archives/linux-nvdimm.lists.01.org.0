Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9214169BEC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 02:42:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29A3B10FC337F;
	Sun, 23 Feb 2020 17:42:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com; envelope-from=oohall@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5330210FC337F
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 17:42:55 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id m25so8584532ioo.8
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 17:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhVgmjRGEwVCyeThkvJVHxfg3EG7YiNfvIKBv+nVMeI=;
        b=LUV/rPwj6sFkk08tsYihfkSiIOu8DvPGR9ALzpZ9KEjJ6cm9TWhEVZs9gZjyFmGljq
         hvNoZ9u8VINM0NVs03UyvMhfM790FRf3XJ9AZydNYvoRqSiwaLNqSenynHYtCoED8LCw
         179biq4AALGeC06TKxnhDnmaLqwcFsmVT6PgPICaHH6IyXnfkpOLiO8VIMGa4vT3so6s
         sG9GWsbxFay4pd/LRS9RapfOb0zBs3zUbaQWcf3L9pLU+tg5xg50TvzBrsMJXzpRb42X
         xOzQlLVWgHVWo6GAxPE+ZZ7vcy20LfDsT+MM6IXZi4WpSxVePSAyytGXAuuWemRY/A91
         ArpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhVgmjRGEwVCyeThkvJVHxfg3EG7YiNfvIKBv+nVMeI=;
        b=GkDVBClXYFPOW3goyAqc0gs8xy69QTs4tDahQEhgSmK8SHq6SDz0U/T5wGtSZ89H6a
         Yi0WeU5QzBl2+djhmzKJkbeBWSJfu1Z0mtVY9LwNzjxd/u+spla72TEB+WOD5rZwxcRX
         ASuqvi26o7cWq2JhOB3BMvI0LYBAVqV2CDOtjqKFHzaxFDNsSJWRSLCBPvNZp/rguVcx
         hWXcidiJ9EVLWRWX6NTICb6mLrK6RzOMBb7rGzpeU4iOG3vo9HW0jecp7WvY82sNu0va
         YxtMRAYGjGlVgMOn1u7M9vYLmgUwPzTBBYx4h4dnI8NS/Nqnu3XiWEeu35+qwA4N+2/z
         RxMw==
X-Gm-Message-State: APjAAAW8+FZUSnvjOxNvOFEqcQHc2br4lCwVvpIISbxkjaKysG25wnmn
	9CuZYXjzSfF1v+rQJLfFKEs9M6NgIktm5wUfzkU=
X-Google-Smtp-Source: APXvYqzy3E4LciHHLkjXPWnbETKxqDYnUpxeTOYY1bhH38hgYV9T9015a+g5H5J9m6THVyk1bJHSl1mQeVBibIecwQA=
X-Received: by 2002:a5d:87ca:: with SMTP id q10mr49147056ios.192.1582508522424;
 Sun, 23 Feb 2020 17:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20200222183010.197844-1-adelva@google.com> <20200223145635.GB29607@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200223145635.GB29607@iweiny-DESK2.sc.intel.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 24 Feb 2020 12:41:51 +1100
Message-ID: <CAOSf1CH-WMA5DDt9LKcPPZwb-ya-y=1WCc8mrUEEDMjg0WeX5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm/of_pmem: handle memory-region in DT
To: Ira Weiny <ira.weiny@intel.com>
Message-ID-Hash: QWLKWY5DUGLWJXR6RPKG2T2ZGKWSH2I2
X-Message-ID-Hash: QWLKWY5DUGLWJXR6RPKG2T2ZGKWSH2I2
X-MailFrom: oohall@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Alistair Delva <adelva@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, Device Tree <devicetree@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QWLKWY5DUGLWJXR6RPKG2T2ZGKWSH2I2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 24, 2020 at 1:56 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Sat, Feb 22, 2020 at 10:30:09AM -0800, Alistair Delva wrote:
> > From: Kenny Root <kroot@google.com>
> >
> > Add support for parsing the 'memory-region' DT property in addition to
> > the 'reg' DT property. This enables use cases where the pmem region is
> > not in I/O address space or dedicated memory (e.g. a bootloader
> > carveout).
> >
> > Signed-off-by: Kenny Root <kroot@google.com>
> > Signed-off-by: Alistair Delva <adelva@google.com>
> > Cc: "Oliver O'Halloran" <oohall@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-nvdimm@lists.01.org
> > Cc: kernel-team@android.com
> > ---
> >  drivers/nvdimm/of_pmem.c | 75 ++++++++++++++++++++++++++--------------
> >  1 file changed, 50 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> > index 8224d1431ea9..a68e44fb0041 100644
> > --- a/drivers/nvdimm/of_pmem.c
> > +++ b/drivers/nvdimm/of_pmem.c
> > @@ -14,13 +14,47 @@ struct of_pmem_private {
> >       struct nvdimm_bus *bus;
> >  };
> >
> > +static void of_pmem_register_region(struct platform_device *pdev,
> > +                                 struct nvdimm_bus *bus,
> > +                                 struct device_node *np,
> > +                                 struct resource *res, bool is_volatile)
>
> FWIW it would be easier to review if this was splut into a patch which created
> the helper of_pmem_register_region() without the new logic.  Then added the new
> logic here.

Yeah, that wouldn't hurt.

*snip*

> > +     i = 0;
> > +     while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {
> > +             ret = of_address_to_resource(mr_np, 0, &res);
> > +             if (ret)
> > +                     dev_warn(
> > +                             &pdev->dev,
> > +                             "Unable to acquire memory-region from %pOF: %d\n",
> > +                             mr_np, ret);
> >               else
> > -                     dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> > -                                     ndr_desc.res, np);
> > +                     of_pmem_register_region(pdev, bus, np, &res,
> > +                                             is_volatile);
> > +             of_node_put(mr_np);
>
> Why of_node_put()?

"memory-region" is an array of pointers to nodes in /reserved-memory/
which describe the actual memory region. of_parse_phandle() elevates
the refcount of the returned node and we need to balance that.

>
> Ira
> >       }
> >
> >       return 0;
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

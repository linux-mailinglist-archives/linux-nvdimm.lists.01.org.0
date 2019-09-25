Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F35BE5C6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 21:36:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D1C6202F8BB1;
	Wed, 25 Sep 2019 12:39:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 82118202BDC98
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 12:38:59 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 83so5995266oii.1
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CcEEswff8ixtyD6OftQjIAyxZUeUVmm/91cx8aX+KYY=;
 b=1bR5diiQFy6YflrAccl4qjRlmKxWN8BoVRq4mSqG8Sh8lJmYkgUFUS8jCazmjnq90M
 jz/Ape7fHeUMM4/+dIM2rECjfk4Q+S+CF9Q/U6TpcpqMPLVgUo8I7awaMljtxEh1U8VJ
 yvUx+h94HkOhxflhBRXAnEagYNYj1jJdclEHu7lA6h81ZHzwOenJKoDQDJ+aMyvnCCm3
 78tR4Kv5bevsj742qx0/BoHNoPN9ybjP/OxoaBEExrWQp+ICPpINwRXwhfl6oVzm41Dv
 Q+dggow0pKxoE2pHQCmcbxj98MnywwuBr7FKb8kHBQe2ToDYzuME0iK5g2jM+H+tzgZ4
 UqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CcEEswff8ixtyD6OftQjIAyxZUeUVmm/91cx8aX+KYY=;
 b=K0ADJer29FaMlCwu6dLT/8tZcXkFWF1tg6WzUzjn2UGvFX1RvFKWT2pG3OszWEJ+Fi
 KPzVeYsF8JMI4eoUj0551crx0ZAvmghEQyoLUtaz0g91cBH4w5aR1/7XiMaYAE2F2L9X
 A1aobFH/uFWwOvfaVIfzfRZ2Mu0PMn7Hw3jXJTbQFKbpm62SqmrSEyiz027arw+KUBXQ
 ll36ACCUH3TaqolPZ4w4yCYFwp1E7A5I1SrDPAMQCCArrD24NlhuVZJReDxowZ3RD3i4
 brkOtwuCAxsuT+KxOqQb0Q5118wrorDhKlP9b9tJ6EFLY72d6xG3hBB6raaop08XORA6
 5ERA==
X-Gm-Message-State: APjAAAVMyNckVnX/8JaYFc3OWmOJZhjm/OZA2m4jaRtB4+FFuM8LEaQl
 Pn1RNgM/OCVmkCQTHFHF3ub8OwY+XMIn1IFR01WSeQ==
X-Google-Smtp-Source: APXvYqw6DYedroBV6yr1qAVhpWfJZbbiaeRctb/ep0Ghj1D2jNemKqK1JSEvmErUxr7RKxUepRLpJYK3C8TEqOOaNkU=
X-Received: by 2002:aca:5dc3:: with SMTP id r186mr5521337oib.73.1569440205801; 
 Wed, 25 Sep 2019 12:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190925184852.11707-1-ira.weiny@intel.com>
In-Reply-To: <20190925184852.11707-1-ira.weiny@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 25 Sep 2019 12:36:35 -0700
Message-ID: <CAPcyv4jtYxggf-+ZvO5PN3KTMjiqqJrpj_V39_9axJZNpG_EQg@mail.gmail.com>
Subject: Re: [PATCH V2] bnvdimm/namsepace: Don't set claim_class on error
To: "Weiny, Ira" <ira.weiny@intel.com>
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
Cc: kernel-janitors@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Sep 25, 2019 at 11:49 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Don't leave claim_class set to an invalid value if an error occurs in
> btt_claim_class().
>
> While we are here change the return type of __holder_class_store() to be
> clear about the values it is returning.
>
> This was found via code inspection.
>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> V1->V2
>         Add space after variable declaration...

Oh, was also hoping this would address s/bnvdimm/libnvdimm/ in the
patch subject.

Note, kernel-janitors is for minor spelling fixes and trivial changes
with no runtime side-effects that might otherwise fall through the
cracks. This has functional implications so is not a janitorial
change.

One more comment below...

>
>  drivers/nvdimm/namespace_devs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index 5b22cecefc99..eef885c59f47 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1510,16 +1510,20 @@ static ssize_t holder_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(holder);
>
> -static ssize_t __holder_class_store(struct device *dev, const char *buf)
> +static int __holder_class_store(struct device *dev, const char *buf)
>  {
>         struct nd_namespace_common *ndns = to_ndns(dev);
>
>         if (dev->driver || ndns->claim)
>                 return -EBUSY;
>
> -       if (sysfs_streq(buf, "btt"))
> -               ndns->claim_class = btt_claim_class(dev);
> -       else if (sysfs_streq(buf, "pfn"))
> +       if (sysfs_streq(buf, "btt")) {
> +               int rc = btt_claim_class(dev);
> +
> +               if (rc < NVDIMM_CCLASS_NONE)
> +                       return rc;
> +               ndns->claim_class = rc;
> +       } else if (sysfs_streq(buf, "pfn"))
>                 ndns->claim_class = NVDIMM_CCLASS_PFN;
>         else if (sysfs_streq(buf, "dax"))
>                 ndns->claim_class = NVDIMM_CCLASS_DAX;
> @@ -1528,10 +1532,6 @@ static ssize_t __holder_class_store(struct device *dev, const char *buf)
>         else
>                 return -EINVAL;
>
> -       /* btt_claim_class() could've returned an error */
> -       if ((int)ndns->claim_class < 0)
> -               return ndns->claim_class;
> -

Since this effectively replaces Dan's patch can you respin without
that baseline, and just give Dan credit with a Reported-by?

>         return 0;
>  }
>
> @@ -1539,7 +1539,7 @@ static ssize_t holder_class_store(struct device *dev,
>                 struct device_attribute *attr, const char *buf, size_t len)
>  {
>         struct nd_region *nd_region = to_nd_region(dev->parent);
> -       ssize_t rc;
> +       int rc;
>
>         nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
> @@ -1547,7 +1547,7 @@ static ssize_t holder_class_store(struct device *dev,
>         rc = __holder_class_store(dev, buf);
>         if (rc >= 0)
>                 rc = nd_namespace_label_update(nd_region, dev);
> -       dev_dbg(dev, "%s(%zd)\n", rc < 0 ? "fail " : "", rc);
> +       dev_dbg(dev, "%s(%d)\n", rc < 0 ? "fail " : "", rc);
>         nvdimm_bus_unlock(dev);
>         nd_device_unlock(dev);
>
> --
> 2.20.1
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

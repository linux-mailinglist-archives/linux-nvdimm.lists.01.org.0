Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD09306A17
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 02:16:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 66530100EB351;
	Wed, 27 Jan 2021 17:16:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC563100EB350
	for <linux-nvdimm@lists.01.org>; Wed, 27 Jan 2021 17:16:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id n6so4704754edt.10
        for <linux-nvdimm@lists.01.org>; Wed, 27 Jan 2021 17:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOLs2yrRfDr5WQ58XZxAH+NHveNneNx5qVNthcbKmwY=;
        b=iFK4+8FAtc2qFewzEAbcOnRWmCzTQAI1yUi5Uvkq1cEc77KLs3+EFXrOkeljvPNO4g
         K2U9ki5yE7R5y5aSxqr0CfxBiUbpAZQA6yGnMYJhUubs/2VxNmt76L/aHwKKVP4f18cM
         9kc+1+tcf3q3XSWsjOw9mSQigQ3Qr92a2Wx5zGJx/8BoSIS0CZLhHPiKsKrlnYVjb/sE
         D1S11pE9avc8XMRl+FSjvTMo5nH4hi36cJ+ZkdJu9lEOCtCbzVSixhE1O6G/5KLpDX6e
         hOGFyi9Z72e3bnRbpnm5skxoZUK20//RyUQvXO/SjBYH7BTBwyHHDIVGhSp6x52N7onU
         oU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOLs2yrRfDr5WQ58XZxAH+NHveNneNx5qVNthcbKmwY=;
        b=sjjgIT4g20+wb5U7wZDhqXPtiv9M6kfvGPlELl1PCDN4AkLnFMaLQbejRpkXKU3UEr
         xvlZursaZnnrkAegMcIHRJHDpDDF7TWYlUi4ekczlNsAIS4fvMF2eELTjSGJHMpq7GsR
         ps8ozznYqCyKbmB+vSzKFt4UoSKxVw/utPNBAvtiDwtwh/KN0uxWjR5o1UnJUQAVU8pg
         v7TbbB/FeJwmsFIPV5TQDBSNueJuZZ5VTLWaIbk0Dohz7sTMRFr8+a0R/THL9elfKWU0
         uiHxWafCJbAWcefwMXqNNe5NIYEWV0q2TWuKNYihtJ+AmbQu3GSDBeZbmvwWqdk2vQu9
         DSZw==
X-Gm-Message-State: AOAM531NBFrJqeSl5YThI+R6Rgt3QAEG7yVaZ3tQ+FBw4RsNI2gLZPrf
	6495SZIY36+7PcgiG46Tk0ctvKIeadSOinQCMwiW1w==
X-Google-Smtp-Source: ABdhPJx9j5lObP2eENnLTb3zMiXT8iz8dx+g2wCBlNZ7JkOIZrhPXIWQt7NDk4UzSw2Rwla6JcNWkiWIPIyZfsahuJ0=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr11143020edc.97.1611796598664;
 Wed, 27 Jan 2021 17:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20201222042240.2983755-1-santosh@fossix.org> <20201222042516.2984348-1-santosh@fossix.org>
 <20201222042516.2984348-3-santosh@fossix.org>
In-Reply-To: <20201222042516.2984348-3-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Jan 2021 17:16:37 -0800
Message-ID: <CAPcyv4jv-+gFP68RKD57+=QhT_SUWqXPJ4qFgmVZfVgNkVESCg@mail.gmail.com>
Subject: Re: [ndctl 3/5] papr: Add support to parse save_fail flag for dimm
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: FKINJEZIM3QWOMUMD6YXKGLGG6B5FDAT
X-Message-ID-Hash: FKINJEZIM3QWOMUMD6YXKGLGG6B5FDAT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FKINJEZIM3QWOMUMD6YXKGLGG6B5FDAT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 21, 2020 at 8:26 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> This will help in getting the dimm fail tests to run on papr family too.
> Also add nvdimm_test compatibility string for recognizing the test module.
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  ndctl/lib/libndctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index 5f09628..3fb3aed 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -815,6 +815,8 @@ static void parse_papr_flags(struct ndctl_dimm *dimm, char *flags)
>                         dimm->flags.f_restore = 1;
>                 else if (strcmp(start, "smart_notify") == 0)
>                         dimm->flags.f_smart = 1;
> +               else if (strcmp(start, "save_fail") == 0)
> +                       dimm->flags.f_save = 1;
>                 start = end + 1;
>         }
>         if (end != start)
> @@ -1044,7 +1046,8 @@ NDCTL_EXPORT int ndctl_bus_is_papr_scm(struct ndctl_bus *bus)
>         if (sysfs_read_attr(bus->ctx, bus->bus_buf, buf) < 0)
>                 return 0;
>
> -       return (strcmp(buf, "ibm,pmemory") == 0);
> +       return (strcmp(buf, "ibm,pmemory") == 0 ||
> +               strcmp(buf, "nvdimm_test") == 0);

A bit unfortunate to leak test details into the production path,
especially when nvdimm_test is meant to be generic. It seems what you
really want is a generic way to determine if dimm supports the common
error state flags, right? I'd add an api for that and say yes for nfit
and papr.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

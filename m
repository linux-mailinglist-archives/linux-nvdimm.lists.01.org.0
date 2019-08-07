Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A56AE84323
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Aug 2019 06:13:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B6B8212FD4F2;
	Tue,  6 Aug 2019 21:15:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 46F3B212FD404
 for <linux-nvdimm@lists.01.org>; Tue,  6 Aug 2019 21:15:48 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j11so41687154otp.10
 for <linux-nvdimm@lists.01.org>; Tue, 06 Aug 2019 21:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=53CVu6nkMcwWcWethACyNRgLyQL3v5f91offjpqNJ2Y=;
 b=Sos6KU0EByI+GdIj+zesAaN4T1xT+u5KZY3x1MZuvFnbDecWHCrxPBWzAMmRncYYiB
 t0wR9Txjs90Hqk78b3/9UQW2y1mWsiuqJTzWDrrxFLz9ukseyaOnBLdzWq8n3M1txp8j
 JXCyJd4TPKXXsqaEKix1njwuMq2tUDZR+pSQEQ+FHDQ2RJUzzUxRrHHW1cODRiyqqrZw
 F+CInaxhlavYCALv/jyTHv47GT7hYk0A/Mo/iY8jgYJs4lFYuS+Bl6aS32V+MAS9Z8U9
 KZX7cC3tPP3dLDepxHZbpDGO2KHhMeavs4d665Zem6KyiUDbHoMN62JmrAFf6wotSzOw
 ImEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=53CVu6nkMcwWcWethACyNRgLyQL3v5f91offjpqNJ2Y=;
 b=Ni+YD00sx3LZ9WpEOiH0gobl5HpJsRMZlpLO+OkNH4Cm1z0vD5C+LsyHCZg7g6NkWm
 HvdhzXn9TLNdEhIfn7oB3HYka0sUsG0efkojUhmPMT2JAER/apHZTldFOp8wuK44zKVz
 EYNLDkNBhpTNcV3x5cInMkI06ykkMWnQdc7eNc7UC1P/ozBAb4YpphW0/WGGR0+1b32Y
 xCHMdEvFmDVpRRmDDDKwJ1mRpQwqAqky1r5EM8D/F4q376lo/wnTskCgSXx3LIHY4IZ5
 ZjmU9DJffxu029QP0WEbHq7F4hoTaMpENeWo8pn11qcgHdcDEXvQmrPT589wkbhk4Y9h
 lEfw==
X-Gm-Message-State: APjAAAVjIixRE2kTxtBAA6asKglxvRWSRVHzcJGJ7D+qguAP1i4gv40Q
 2g5iypprCWpf+oygyEbyyGwFQPgj3MF3jEmK/EpTbQ==
X-Google-Smtp-Source: APXvYqw2kdbG+cFiOIZegAx1eXDK/tUf/N7gRvYUA6TNNQFIGvh+9mEAG9J7TCpBWEvv/cr+etN0lMV78VVIsK/sqC4=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr5762903oto.207.1565151197271; 
 Tue, 06 Aug 2019 21:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190807040029.11344-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190807040029.11344-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Aug 2019 21:13:06 -0700
Message-ID: <CAPcyv4haXOjn7K-HgPV_WLqbfqRQbbiq=LvLt5Ue=OPAaBWN6A@mail.gmail.com>
Subject: Re: [PATCH] nvdimm/of_pmem: Provide a unique name for bus provider
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 6, 2019 at 9:00 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> ndctl utility requires the ndbus to have unique names. If not while
> enumerating the bus in userspace it drops bus with similar names.
> This results in us not listing devices beneath the bus.

It does?

>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/of_pmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index a0c8dcfa0bf9..97187d6c0bdb 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -42,7 +42,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         priv->bus_desc.attr_groups = bus_attr_groups;
> -       priv->bus_desc.provider_name = "of_pmem";
> +       priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);

This looks ok to me to address support for older ndctl binaries, but
I'd like to also fix the ndctl bug that makes non-unique provider
names fail.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

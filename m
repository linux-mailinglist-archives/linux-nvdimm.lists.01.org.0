Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1532109236
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 Nov 2019 17:53:40 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8E05C1011330C;
	Mon, 25 Nov 2019 08:57:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 62DDF1011330B
	for <linux-nvdimm@lists.01.org>; Mon, 25 Nov 2019 08:57:00 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id d5so13222138otp.4
        for <linux-nvdimm@lists.01.org>; Mon, 25 Nov 2019 08:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/qxpzOJtDWC5JzL6+agRpnBrTG66PoUWAKL6ZfgviE=;
        b=E9XgRFLRdRopuunkKUMJ+f2T58qqwUyZn4R3rGqvUhOj5wMsWDuGHU2xkCExMTN9uq
         tzxItSGOPWgPVD3Z5C0943o3dcX7CNfmNa7eVUgLQcDM6ND/pwThML24S7gdRhAmeozK
         a2XVlbu6fBIJh2N+M5jbQZfhxduEtTCZK/pk645jLvG/C2lVO9V25LbzseQyjHUrNpAC
         89LHRVxCfqUGb2/fTopYLnncKEstB7UBmQcrlNoMIs7RE3zJU1j6uNyVwJ+v4sHbLbSu
         BqeH/Wgek4WPOh+zzUeV7EQM5xxjALc/X3SZa7Yg+v2Q1m2uK+E90JmakSOMQWmDI/Rk
         UMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/qxpzOJtDWC5JzL6+agRpnBrTG66PoUWAKL6ZfgviE=;
        b=SKdlY/Fudbe1BOQSXbbEngYnZbdsQR+VqTjtJfz17G9vxSjJEFghy8XLTq4wflvXt8
         ++pUBi71lSfNKe9Jxw3sqe0CQluPYxPAQzhxQZNwH+qPWE5DN+NqfA+AO52U3l5oFGiH
         uGCS0VPgH3VkQJ1Ab2/rVHE7dVgSos38EDr2e42COIbtrpz8oMvTEZuS/c/0rPdEP8Bd
         6j4Q6F6Wu+TznoG3rGGfnpWV3McLhbtF5bvpNRal+UAhGFXN6nCrl91raQFsgarVtR1R
         sM0hcvNIicwFFvO6HDtbr1kQ10Us5n6TF67HlPH8jySK3YythjEtQxoenDyo47qZkQzJ
         AQeQ==
X-Gm-Message-State: APjAAAW1GPJIH/wJw6kwk8VzRPy/8Riix4tzMX5XRIuUKwAqS28jE3xh
	zvXFGxTNuuumfh9XZtjNFX0FdxNq9ctlb1t/TM7+djXw
X-Google-Smtp-Source: APXvYqwmYCBYfjhFPWJPBcLzZqhm0yIMq0FahWE7nD8PZ56lHPIuQewYVQ23nsgs8IO/uRgiXdS3A3FygX/fmk+BTas=
X-Received: by 2002:a05:6830:1af7:: with SMTP id c23mr20153222otd.247.1574700816778;
 Mon, 25 Nov 2019 08:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20191125155919.84706-1-kilobyte@angband.pl>
In-Reply-To: <20191125155919.84706-1-kilobyte@angband.pl>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 25 Nov 2019 08:53:25 -0800
Message-ID: <CAPcyv4jpT2vFdQ_cq3SppYtSVqwzJ-z0oC7rRzwqWUrFH0UDzQ@mail.gmail.com>
Subject: Re: [ndctl PATCH] Documentation: fix a typo in the
 ndctl-create-namespace man page
To: Adam Borowski <kilobyte@angband.pl>
Message-ID-Hash: F62HXVJ67XAQPOVHHC2JJ3DJVYXZE2Y4
X-Message-ID-Hash: F62HXVJ67XAQPOVHHC2JJ3DJVYXZE2Y4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F62HXVJ67XAQPOVHHC2JJ3DJVYXZE2Y4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 25, 2019 at 7:59 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> "namepsace".
>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  Documentation/ndctl/ndctl-create-namespace.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
> index e29a5e7..bf7486b 100644
> --- a/Documentation/ndctl/ndctl-create-namespace.txt
> +++ b/Documentation/ndctl/ndctl-create-namespace.txt
> @@ -97,7 +97,7 @@ OPTIONS
>         suffixes "k" or "K" for KiB, "m" or "M" for MiB, "g" or "G" for
>         GiB and "t" or "T" for TiB.
>
> -       For pmem namepsaces the size must be a multiple of the
> +       For pmem namespaces the size must be a multiple of the
>         interleave-width and the namespace alignment (see
>         below).

Looks good, applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

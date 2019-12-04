Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8C112183
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Dec 2019 03:42:57 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 17C7D100DC2D9;
	Tue,  3 Dec 2019 18:46:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42127100DC2C3
	for <linux-nvdimm@lists.01.org>; Tue,  3 Dec 2019 18:46:16 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id x3so4952968oto.11
        for <linux-nvdimm@lists.01.org>; Tue, 03 Dec 2019 18:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1MjoCyCAlz0t78xzRKiUK+wIFXtJ0bmt73Su/pMHfc=;
        b=igJxuQeSjDtUWTR8gpXe6sEtWh93F0RSs1EIyYB9HjXh81fqEVRv+rnlvLTfGxIG15
         MMLnf9/fBVwH/P3dRoYMyr5K7FrNFh+9Xwhda2dtTmzR3iMJxHBq5Jk6oqfMxagttbvY
         TO+QzROzhYIi2rg/c2QSzsbXUA48L+8zxiwLQfA03YOQXzp8HvzQwpploDrHBRTELQir
         UKYpBxV/4jATSIGX0dWx0zLBZDgEBxO1G/1r2APzYiHU23/htOrWkxke0i1tbqnnI+lf
         IHthj4LuFsZPSJNGuFAt2/vCjavpENHInklXOWY+LbylCZ4CcG4nQWT9RZlJw4tFfQVV
         xTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1MjoCyCAlz0t78xzRKiUK+wIFXtJ0bmt73Su/pMHfc=;
        b=ieWSZZE1rHEM32tdHCF6VZTOULOgBGUqIjxU3NaXOF3qbXqGNEk6cQn6kHBaaroBkV
         /WUKv7Rh7kg7QVNWr2hkwQS9V6aENV/9AIUsHQBmuZoQztRoJ/fs/mTV/o1+NSbSOisM
         uxqSqyfuPNGDA3TAWLp6uzK/ftwg/PPw1g38aBUn6s6qkYPM35mGvk3UFwdj8b1Li5Hc
         2Vqt6kbNILEvpJZbKDvMidxa8zNY3c9ChmMk/9SE6Do6t5V0KaPHHkgcAAJHpAzo0MHD
         qQVC5ZM9k/Y2H+XnY716mm/iBW8Y54HieZ/6cZyDnI+iLwsH0pLnbnc4pNBOzqPZLNay
         lz5A==
X-Gm-Message-State: APjAAAVczEqBNUV+VWaI8G/iAcPm8rh0Tt+9Lc7JNBc4SRHLoUohYLDk
	YYAk6/0FP8GDSKMg/GciLqq9wNGEEHCmt6NRgM7SQg==
X-Google-Smtp-Source: APXvYqw0clJQD5/G5PJhTm8ostU/80iIvyseSLNS3CE4iTEo1Si9pGS3AtIKBc0arheZED7RlG/PM71x85G010FwQVU=
X-Received: by 2002:a9d:24c1:: with SMTP id z59mr661726ota.207.1575427373010;
 Tue, 03 Dec 2019 18:42:53 -0800 (PST)
MIME-Version: 1.0
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
In-Reply-To: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 3 Dec 2019 18:42:42 -0800
Message-ID: <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
Subject: Re: [PATCH] daxctl: Change region input type from INTEGER to STRING.
To: "Li, Redhairer" <redhairer.li@intel.com>
Message-ID-Hash: ZKQ3DPUEDWY7E3OB3MVF7NDCIJO4SE6O
X-Message-ID-Hash: ZKQ3DPUEDWY7E3OB3MVF7NDCIJO4SE6O
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZKQ3DPUEDWY7E3OB3MVF7NDCIJO4SE6O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Nice! You got mail working!

On Tue, Dec 3, 2019 at 6:33 PM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> Allow daxctl to accept both <region-id>, and region name as region parameter.
> For example:
>
>     daxctl list -r region5
>     daxctl list -r 5
>
> Link: https://github.com/pmem/ndctl/issues/109
> Signed-off-by: Redhairer Li <redhairer.li@intel.com>
> ---
>  daxctl/device.c | 11 ++++-------
>  daxctl/list.c   | 14 ++++++--------
>  util/filter.c   | 16 ++++++++++++++++
>  util/filter.h   |  2 ++
>  4 files changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/daxctl/device.c b/daxctl/device.c
> index 72e506e..d9db2f9 100644
> --- a/daxctl/device.c
> +++ b/daxctl/device.c
> @@ -19,15 +19,13 @@
>  static struct {
>         const char *dev;
>         const char *mode;
> -       int region_id;
> +       const char *region;
>         bool no_online;
>         bool no_movable;
>         bool force;
>         bool human;
>         bool verbose;
> -} param = {
> -       .region_id = -1,
> -};
> +} param;
>
>  enum dev_mode {
>         DAXCTL_DEV_MODE_UNKNOWN,
> @@ -51,7 +49,7 @@ enum device_action {
>  };
>
>  #define BASE_OPTIONS() \
> -OPT_INTEGER('r', "region", &param.region_id, "restrict to the given region"), \
> +OPT_STRING('r', "region", &param.region, "region-id", "filter by region"), \
>  OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats"), \
>  OPT_BOOLEAN('v', "verbose", &param.verbose, "emit more debug messages")
>
> @@ -484,8 +482,7 @@ static int do_xaction_device(const char *device, enum device_action action,
>         *processed = 0;
>
>         daxctl_region_foreach(ctx, region) {
> -               if (param.region_id >= 0 && param.region_id
> -                               != daxctl_region_get_id(region))
> +               if (!util_daxctl_region_filter(region, device))
>                         continue;

There's a bug here, can you spot it?

This causes:

     make TESTS=daxctl-devices.sh check

...to fail.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

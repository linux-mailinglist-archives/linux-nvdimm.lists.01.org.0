Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C8D25C5F7
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Sep 2020 17:58:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C3F113A1CFA1;
	Thu,  3 Sep 2020 08:58:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6072F13A1CFA0
	for <linux-nvdimm@lists.01.org>; Thu,  3 Sep 2020 08:58:29 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g13so3321137ioo.9
        for <linux-nvdimm@lists.01.org>; Thu, 03 Sep 2020 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzsZxPAPwSm808o5F4eOYmcOwcd/ZqMzTg6W424t1fA=;
        b=tr25y7cD90q3kQQrXO74FKc9lnjIQToYYp1L16DBmDVKwrm0D72Y/QJG/ruDW5XAjr
         V7EnbPJbw/qbUb84NDnaYBD9VFJadIYOCffsLVmHUwG4UWMhr6speeuzu9GTT9QhFl4D
         J37hjyZ/wH849tKEu0M7S6ZzSRGJm+PQM+nM9dTuJoJXjfh46FrJFIptaQBVUeEuEWga
         p38yc4dtFUE9YE74AcuH0DUki8YUoxxv/l/w8h/2Rzb9jx5PxKQymb955qPWkP3E75i+
         Ub7119pnqCEtoatEZqCMgUUNisLeqOA+1ysixkXmEl/OBkaFL10hbfLAbFeYm2JyNgbe
         x2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzsZxPAPwSm808o5F4eOYmcOwcd/ZqMzTg6W424t1fA=;
        b=qE6jS7vj3/91crJu+0b1yjawoIKq7AhFlrt6Ox5i2zYpT/RkE4iLcaORBpDGdzpoMO
         DuISyw0pOcm5QOCayhoB9ec9+cWlQMvc/IOCdXb21lC9BlPJhRjoDrrPwINTTnwvzH0C
         i0Q7kxn7/P6QtRPqk5JxsrJIexGGs6YF4KP/xis/4q1RUtqbn66MtL1X0l6Htue3oIr/
         rbQ6rzF21Qu9z0UXQfUG5g1WRp+rJ65/fvG+sEeWjy3JbrV6ZjVC9eCH5jn6jHzFFGat
         NejyuZAxW8pe/tuhfu43fQKfDPuBTktaQxFT+ui4uIAkqfO98eDInZAmcJcA0jI/gBET
         gCwQ==
X-Gm-Message-State: AOAM533QqRrqbRporlQOcBmHvX+o4Ye6iEWeQycOwDKwXtaXzRfBM31p
	04qXLPQQqqqDyGMrZV6FRBn2SGfbLmnMIznTuU4=
X-Google-Smtp-Source: ABdhPJwgzp7rHAgdPicgGPO+hWGzjxg6OMTflLGRmrMzJlTUmdC8s4mUzfFSGH/HIuxsFChtSKCyuQLp0qalHGOtp8o=
X-Received: by 2002:a05:6638:220c:: with SMTP id l12mr3808083jas.139.1599148708378;
 Thu, 03 Sep 2020 08:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200903152839.19040-1-colyli@suse.de>
In-Reply-To: <20200903152839.19040-1-colyli@suse.de>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 3 Sep 2020 17:58:17 +0200
Message-ID: <CAM9Jb+gsmU-TsT99a7Kp=2owhYZFgROqHYr1aDoza0VApzAQLg@mail.gmail.com>
Subject: Re: [PATCH v2] dax: fix for do not print error message for
 non-persistent memory block device
To: Coly Li <colyli@suse.de>
Message-ID-Hash: RVCAJ7RW6NRXMT7TPKWYYNT62OIW526D
X-Message-ID-Hash: RVCAJ7RW6NRXMT7TPKWYYNT62OIW526D
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, dm-devel@redhat.com, Adrian Huang <ahuang12@lenovo.com>, Jan Kara <jack@suse.com>, Mike Snitzer <snitzer@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RVCAJ7RW6NRXMT7TPKWYYNT62OIW526D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> When calling __generic_fsdax_supported(), a dax-unsupported device may
> not have dax_dev as NULL, e.g. the dax related code block is not enabled
> by Kconfig.
>
> Therefore in __generic_fsdax_supported(), to check whether a device
> supports DAX or not, the following order should be performed,
> - If dax_dev pointer is NULL, it means the device driver explicitly
>   announce it doesn't support DAX. Then it is OK to directly return
>   false from __generic_fsdax_supported().
> - If dax_dev pointer is NOT NULL, it might be because the driver doesn't
>   support DAX and not explicitly initialize related data structure. Then
>   bdev_dax_supported() should be called for further check.
>
> IMHO if device driver desn't explicitly set its dax_dev pointer to NULL,
> this is not a bug. Calling bdev_dax_supported() makes sure they can be
> recognized as dax-unsupported eventually.
>
> This patch does the following change for the above purpose,
>     -       if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
>     +       if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
>
>
> Fixes: c2affe920b0e ("dax: do not print error message for non-persistent memory block device")
> Signed-off-by: Coly Li <colyli@suse.de>
> Reviewed-and-Tested-by: Adrian Huang <ahuang12@lenovo.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jan Kara <jack@suse.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> ---
> Changelog:
> v2: add Reviewed-and-Tested-by from Adrian Huang.
> v1: initial version.
>
>  drivers/dax/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 32642634c1bb..e5767c83ea23 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -100,7 +100,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>                 return false;
>         }
>
> -       if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
> +       if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
>                 pr_debug("%s: error: dax unsupported by block device\n",
>                                 bdevname(bdev, buf));
>                 return false;
> --

Looks good.
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

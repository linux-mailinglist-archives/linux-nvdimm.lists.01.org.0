Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 371372252E3
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Jul 2020 19:02:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 184C4123226C5;
	Sun, 19 Jul 2020 10:02:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C83AF123226C2
	for <linux-nvdimm@lists.01.org>; Sun, 19 Jul 2020 10:02:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id a12so15207438ion.13
        for <linux-nvdimm@lists.01.org>; Sun, 19 Jul 2020 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFK3UwaE42KGyP2Sj/KDZP66HrN27BuyK6YsPPWFya0=;
        b=AiibJWOSwD/dYiJf3aNeBimDtzvUn5PHGdo3XB22I+DbmosUj2Eu8zmFyjWBZtpvTQ
         sj+xpDaPSP6MW++zBUpYmXrjv7e6c12YUWbDAFYJe2oiX8++Rzd1aoDbSTbMRbErq+sL
         BO4kgBZZPx0J2ZccGt6r/Jog4weFzjGc+Hh+pvdr1WW4o9ZDNxnI291l75EYhNrjOVhQ
         qqEeR9RW4t/U5AkS75gMQ3N23w3YK/KXM/aPdiATNOycA51i10F4Tvwhajrr4mKY23JP
         Lf0zneuGJwptdaBuganlxeaMy7emtxGXfdyYcsFt4G180auX1Ql13ULHROIvVFemiqkF
         ijuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFK3UwaE42KGyP2Sj/KDZP66HrN27BuyK6YsPPWFya0=;
        b=CgJ9tQ6wockPP3zO4KXvAIy8nTDgH7gGXtwgI4DwEzBmOg/lRPsPP+5S18XFdJkKmu
         jQ5HDpIoHeomC0eIRzQvTsmQ9fA0jpN/z21YIvIo1bGtDQh9ppXoTLNtRoIpC77MKcD2
         IN/CqjrG0Ln8ZMfHevSZ4GbbdHG6ifVZ56BBd2kMVW/akTdsnrGHOiFF+iBsh+zCPdW7
         3Qjo0Kl4TxJgkLwwDGPBQDoAnwYaqOhPfBPVEQfFxEFArYCUV5msz+LlSrDzMOcLdiRA
         sKXKhyQHVyZj4E8MQQ9LDPJoeL9HmnfkXjmgSdBwTg0b0F6BnLo2ikz7b8gTLeaVpGGK
         ZuOQ==
X-Gm-Message-State: AOAM532maJSw2csDW/uEAi+lG2Ly7yk9eNQGxzSnQcwUSz7NbxH7BdcH
	pVPMSFAmxq+zyoK1fPGJPLSyFSRmXJrjlwX0W94=
X-Google-Smtp-Source: ABdhPJyHKB2QMyusNGZ4VMgZnDlkZDqzr9cDgBNQhyS1Fi0W+4WtwPHl6Kb6UvPVVucOYG7sedF7PhV2504OsJPoGDI=
X-Received: by 2002:a6b:7c02:: with SMTP id m2mr19221018iok.49.1595178145663;
 Sun, 19 Jul 2020 10:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <9e4e6445-9d57-3b7f-6a2a-ddad750ef11c@suse.de>
In-Reply-To: <9e4e6445-9d57-3b7f-6a2a-ddad750ef11c@suse.de>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Sun, 19 Jul 2020 19:02:14 +0200
Message-ID: <CAM9Jb+i+XBfrX3_H_p6jXjRnMHHycUp_2owvJDR2-kQBdDFv8g@mail.gmail.com>
Subject: Re: [RESEND] [PATCH v2] dax: print error message by pr_info() in __generic_fsdax_supported()
To: Coly Li <colyli@suse.de>
Message-ID-Hash: WFM2M3CUI4UGPUMJP7DH6ZDQUOLZMLW3
X-Message-ID-Hash: WFM2M3CUI4UGPUMJP7DH6ZDQUOLZMLW3
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Michal Suchanek <msuchanek@suse.com>, Jan Kara <jack@suse.com>, Anthony Iliopoulos <ailiopoulos@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WFM2M3CUI4UGPUMJP7DH6ZDQUOLZMLW3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> In struct dax_operations, the callback routine dax_supported() returns
> a bool type result. For false return value, the caller has no idea
> whether the device does not support dax at all, or it is just some mis-
> configuration issue.
>
> An example is formatting an Ext4 file system on pmem device on top of
> a NVDIMM namespace by,
>  # mkfs.ext4 /dev/pmem0
> If the fs block size does not match kernel space memory page size (which
> is possible on non-x86 platform), mount this Ext4 file system will fail,
>   # mount -o dax /dev/pmem0 /mnt
>   mount: /mnt: wrong fs type, bad option, bad superblock on /dev/pmem0,
>   missing codepage or helper program, or other error.
> And from the dmesg output there is only the following information,
>   [  307.853148] EXT4-fs (pmem0): DAX unsupported by block device.
>
> The above information is quite confusing. Because definiately the pmem0
s/definiately/definitely
> device supports dax operation, and the super block is consistent as how
> it was created by mkfs.ext4.
>
> Indeed the failure is from __generic_fsdax_supported() by the following
> code piece,
>         if (blocksize != PAGE_SIZE) {
>                pr_debug("%s: error: unsupported blocksize for dax\n",
>                                 bdevname(bdev, buf));
>                 return false;
>         }
> It is because the Ext4 block size is 4KB and kernel page size is 8KB or
> 16KB.
>
> It is not simple to make dax_supported() from struct dax_operations
> or __generic_fsdax_supported() to return exact failure type right now.
> So the simplest fix is to use pr_info() to print all the error messages
> inside __generic_fsdax_supported(). Then users may find informative clue
> from the kernel message at least.
>
> Message printed by pr_debug() is very easy to be ignored by users. This
> patch prints error message by pr_info() in __generic_fsdax_supported(),
> when then mount fails, following lines can be found from dmesg output,
>  [ 2705.500885] pmem0: error: unsupported blocksize for dax
>  [ 2705.500888] EXT4-fs (pmem0): DAX unsupported by block device.
> Now the users may have idea the mount failure is from pmem driver for
> unsupported block size.
>
> Reported-by: Michal Suchanek <msuchanek@suse.com>
> Suggested-by: Jan Kara <jack@suse.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> Reviewed-by: Jan Kara <jack@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Anthony Iliopoulos <ailiopoulos@suse.com>
> ---
> Changelog:
> v2: Add reviewed-by from Jan Kara
> v1: initial version.
>
>  drivers/dax/super.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 8e32345be0f7..de0d02ec0347 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -80,14 +80,14 @@ bool __generic_fsdax_supported(struct dax_device
> *dax_dev,
>         int err, id;
>         if (blocksize != PAGE_SIZE) {
> -               pr_debug("%s: error: unsupported blocksize for dax\n",
> +               pr_info("%s: error: unsupported blocksize for dax\n",
>                                 bdevname(bdev, buf));
>                 return false;
>         }
>         err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
>         if (err) {
> -               pr_debug("%s: error: unaligned partition for dax\n",
> +               pr_info("%s: error: unaligned partition for dax\n",
>                                 bdevname(bdev, buf));
>                 return false;
>         }
> @@ -95,7 +95,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>         last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
>         err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
>         if (err) {
> -               pr_debug("%s: error: unaligned partition for dax\n",
> +               pr_info("%s: error: unaligned partition for dax\n",
>                                 bdevname(bdev, buf));
>                 return false;
>         }
> @@ -106,7 +106,7 @@ bool __generic_fsdax_supported(struct dax_device
> *dax_dev,
>         dax_read_unlock(id);
>         if (len < 1 || len2 < 1) {
> -               pr_debug("%s: error: dax access failed (%ld)\n",
> +               pr_info("%s: error: dax access failed (%ld)\n",
>                                 bdevname(bdev, buf), len < 1 ? len : len2);
>                 return false;
>         }
> @@ -139,7 +139,7 @@ bool __generic_fsdax_supported(struct dax_device
> *dax_dev,
>         }
>         if (!dax_enabled) {
> -               pr_debug("%s: error: dax support not enabled\n",
> +               pr_info("%s: error: dax support not enabled\n",
>                                 bdevname(bdev, buf));
>                 return false;
>         }
> --
> 2.26.2

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EDC8F24D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Aug 2019 19:34:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F185202F73D8;
	Thu, 15 Aug 2019 10:36:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 42513202EDBB1
 for <linux-nvdimm@lists.01.org>; Thu, 15 Aug 2019 10:30:38 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q20so6359798otl.0
 for <linux-nvdimm@lists.01.org>; Thu, 15 Aug 2019 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L0GqPPZ3ptyjBkt7aBOY+B9eZEmSOFdqgFUkWXmTO1k=;
 b=elMBytnSkJObtOhpcJ7Xs6NSK2Zels7ZXnuvJKtDo7E/y+sRTtehbpYEgdfEqVVQAe
 KqeV+Z/+6xSDjCkXSbhKtJON1HD6dEg1WDp7qu0NyKIMHY5WsaUDYZlEZacJsR4pyi8Q
 pPMcC4GNOtrTkW3MLpbzTNHtf+c/XjrlNS7OteTSuWtNE6x+0XFsOYDqGE+Qy89vO/b5
 ciRfccITYue+8mjdkhKDrJAbD+tZMNI/plcncKU6yK+YbrNSQdoX/jyJ+qIIAYeUHtSk
 lBVKTMSqji4XkczEOouA5UsRHjFT2PCvgxarNlqjY80Dk52+BQLUJpFREPWdLB8oxDiO
 GLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L0GqPPZ3ptyjBkt7aBOY+B9eZEmSOFdqgFUkWXmTO1k=;
 b=T1dtAQqsBXJS++asH6xMobtgB/H+hLLjWUEnkFuMG/xjIPEvkgU8mM19Dg4W2hwcO0
 SAXKnPO2yMfrSriLrZ5X6/dswN2pa0FubkNpCGIcqRHhZRou3Z6wn8MttG2cGXBxac/K
 HLUdOwHgfI6VUImv/tp90PRQJWaZQoVOU01EGxXux/p00x/JqZfGDnMPEhymcn/qmE4a
 GeWLePsvAeZ4DJPLjbyY8gJBtJ+vqdQhfE61dgp7Ls1iwdBViqVI3pnjsx7gDYqrA2nE
 yjXp34j03lHXLBUPjkotSosH7Vsj5MpbILvq9dH+caKxck9ws9izOYZ9rkBoFlrjvuMl
 LLvQ==
X-Gm-Message-State: APjAAAVzDMxYwW8k68q08md+sVw7Xr7NSiQMLYfhwXb9zhMyZWmFHz6e
 kx3CDKluQtY7xMIhrNX+ryBM05MmLV32aPJ7RwX0Jg==
X-Google-Smtp-Source: APXvYqyBTBaI9eJbvDjqXYBo8fRWxyThpItUw1gVkcDVt08Xz/Q10OjpEU3cZtbZCeecsS0S9fRvt9+7d9K6qfNXZo0=
X-Received: by 2002:a05:6830:458:: with SMTP id
 d24mr4109027otc.126.1565890121099; 
 Thu, 15 Aug 2019 10:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190731111207.12836-1-pagupta@redhat.com>
In-Reply-To: <20190731111207.12836-1-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 15 Aug 2019 10:28:30 -0700
Message-ID: <CAPcyv4gLqd43CLDuGYrDdx4xR1_oc3D0hzdETz8uQmV1C2Dp_Q@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: change disk name of virtio pmem disk
To: Pankaj Gupta <pagupta@redhat.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 31, 2019 at 4:12 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds prefix 'v' in disk name for virtio pmem.
> This differentiates virtio-pmem disks from the pmem disks.

I don't think the small matter that this device does not support
MAP_SYNC warrants a separate naming scheme.  That said I do think we
need to export this attribute in sysfs, likely at the region level,
and then display that information in ndctl. This is distinct from the
btt case where it is operating a different data consistency contract
than baseline pmem.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/nvdimm/namespace_devs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index a16e52251a30..8e5d29266fb0 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -182,8 +182,12 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
>                 char *name)
>  {
>         struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
> +       const char *prefix = "";
>         const char *suffix = NULL;
>
> +       if (!is_nvdimm_sync(nd_region))
> +               prefix = "v";
> +
>         if (ndns->claim && is_nd_btt(ndns->claim))
>                 suffix = "s";
>
> @@ -201,7 +205,7 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
>                         sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
>                                         suffix ? suffix : "");
>                 else
> -                       sprintf(name, "pmem%d%s", nd_region->id,
> +                       sprintf(name, "%spmem%d%s", prefix, nd_region->id,
>                                         suffix ? suffix : "");
>         } else if (is_namespace_blk(&ndns->dev)) {
>                 struct nd_namespace_blk *nsblk;
> --
> 2.20.1
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

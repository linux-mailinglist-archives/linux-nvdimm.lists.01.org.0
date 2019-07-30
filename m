Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06967B417
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jul 2019 22:15:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B77CE212E4B78;
	Tue, 30 Jul 2019 13:17:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A453C212DD378
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 13:17:36 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id r6so67679186oti.3
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5RzApq6XFoztBnIqNk8vSnTrtbUfODyGJJfunMohfoM=;
 b=Zwx0RQpMg/Mqj/9z5S89A3ZEJVMpYC9h+xxOXAaZcuU5PCAM8m9Gqaz//RnKDBGDqW
 9liyDLB1BwWzU+ZNcxIkUlAhEM4dwaxEWMetA5zngGXxvLUm9KzmX8yqMCHjIc+8qA1I
 4Kz3jT1Z/FAcCfiuMTNuiLT9z2kiwc9S0x8YZz6OVlR8h69bqZIY4y5U2CziwyfAHt6S
 8CcPZTmDK53Mwk0qwS3iX6X/MjsfAEfTAQNYo9qJOCNeLP9BFCn9fMgZ4bp/B5yi3zOB
 uh6pK4X9QLjcA5W2PzdnflMG8qYA3C40MW87vpeyNAEv23qLtzsWi1Ofnp3dkIf+XH59
 Buzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5RzApq6XFoztBnIqNk8vSnTrtbUfODyGJJfunMohfoM=;
 b=pbAmnMTWuUdCLgj3PWS4elvDMEq914ZTRuuaXFrvVrQZMm5rB6qoMvs8MYo9+7iKwz
 IMCgFk9Dz0lKOpjKr9OaNW/zKqFFZdJZPh1QVKvQbx9MDUrHHag33dXVlJ6YAsQXK7ZL
 0vvXRi3kqVHU6XgkKNAntdob1lUHFtITsBFaiuV+0pBgvdTpZ/ZrpNowYLChUUckZC2n
 7LsmXLzj/3Y4tlBbtzDCJu3yVHc5EqGY1ndTBrKtNAahzMkkD3QkhPv7Czcyl2CjyvZG
 +MqrzFg9cfpEqVdDsophtDrnRXB7MFsKbWQpZvfrOOBA7AtEecN7tXy6ZZD17a5vZ7B4
 aWcw==
X-Gm-Message-State: APjAAAViUmrhkI1ZSXkSH1JKWk2xk5i1LSjEKwbv9B/m7KIHgkguvXH5
 bzt6OhbBTLTPhtoXhkHEJYp97oZPDZhzLIciF1nkPg==
X-Google-Smtp-Source: APXvYqw9ObVuL9+XuGR4o0J2QBLrDkVcN3aYitNJvsGPbv5ZPcYvxRI6eCPCNx+pUD4yOvd0Fq+ICTQ9s+BKXhNpUpI=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr23671169otk.363.1564517704838; 
 Tue, 30 Jul 2019 13:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730195819.901457-1-arnd@arndb.de>
In-Reply-To: <20190730195819.901457-1-arnd@arndb.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 30 Jul 2019 13:14:52 -0700
Message-ID: <CAPcyv4i_nHzV155RcgnAQ189aq2Lfd2g8pA1D5NbZqo9E_u+Dw@mail.gmail.com>
Subject: Re: [PATCH v5 13/29] compat_ioctl: move more drivers to
 compat_ptr_ioctl
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: linux-iio@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 linux-remoteproc@vger.kernel.org,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, sparclinux@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 linux-rdma <linux-rdma@vger.kernel.org>, qat-linux@intel.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Jason Gunthorpe <jgg@mellanox.com>, linux-input@vger.kernel.org,
 Darren Hart <dvhart@infradead.org>,
 "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 linux-nvme@lists.infradead.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 David Sterba <dsterba@suse.com>, platform-driver-x86@vger.kernel.org,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Wireless List <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 tee-dev@lists.linaro.org, linux-crypto <linux-crypto@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-btrfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jul 30, 2019 at 12:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The .ioctl and .compat_ioctl file operations have the same prototype so
> they can both point to the same function, which works great almost all
> the time when all the commands are compatible.
>
> One exception is the s390 architecture, where a compat pointer is only
> 31 bit wide, and converting it into a 64-bit pointer requires calling
> compat_ptr(). Most drivers here will never run in s390, but since we now
> have a generic helper for it, it's easy enough to use it consistently.
>
> I double-checked all these drivers to ensure that all ioctl arguments
> are used as pointers or are ignored, but are not interpreted as integer
> values.
>
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: David Sterba <dsterba@suse.com>
> Acked-by: Darren Hart (VMware) <dvhart@infradead.org>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/nvdimm/bus.c                        | 4 ++--
[..]
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 798c5c4aea9c..6ca142d833ab 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -1229,7 +1229,7 @@ static const struct file_operations nvdimm_bus_fops = {
>         .owner = THIS_MODULE,
>         .open = nd_open,
>         .unlocked_ioctl = bus_ioctl,
> -       .compat_ioctl = bus_ioctl,
> +       .compat_ioctl = compat_ptr_ioctl,
>         .llseek = noop_llseek,
>  };
>
> @@ -1237,7 +1237,7 @@ static const struct file_operations nvdimm_fops = {
>         .owner = THIS_MODULE,
>         .open = nd_open,
>         .unlocked_ioctl = dimm_ioctl,
> -       .compat_ioctl = dimm_ioctl,
> +       .compat_ioctl = compat_ptr_ioctl,
>         .llseek = noop_llseek,
>  };

Acked-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

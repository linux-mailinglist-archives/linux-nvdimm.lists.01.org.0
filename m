Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E1580113
	for <lists+linux-nvdimm@lfdr.de>; Fri,  2 Aug 2019 21:38:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F04B2130C4AC;
	Fri,  2 Aug 2019 12:40:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 680BC21306CC2
 for <linux-nvdimm@lists.01.org>; Fri,  2 Aug 2019 12:40:41 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z23so50924489ote.13
 for <linux-nvdimm@lists.01.org>; Fri, 02 Aug 2019 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NwrICNfG+GCVC2f/Yrdzm2/WYF4KoqGDjXcdvaB1OtA=;
 b=B8yMMyk/3D2IW436VNHGsU7Cvj/2avp+aArFfUAMzCAYlyYeXqAi5B5EsDX04+vpKU
 EWMo0kTqkDZaPX20uvAW8/WCWDDlDl9lQkmb1tV/T3Ghf52lYWNGIFzhsOh49114ekUj
 1Tyrl+DrneBuVh2cpBRQfCLwZyOMy5rpH/5OhsyQAT40rLdrmvlyRaUUi8tjiTIXAtBY
 uHo97VuhitN/8yUM4bESCiTEqJv8UVSCTaHWE0D0otWhoIVkiyJ5KtxGzACfN4rq7CM3
 neH0i8AvQdA8em4dDsL/lro4wDa/g0FawQrGeDSWAaPAQA2Infbdgtocs1Jl5zck3ZSR
 qCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NwrICNfG+GCVC2f/Yrdzm2/WYF4KoqGDjXcdvaB1OtA=;
 b=bmyGvvmlpc9UUtZeeEdmbcvayFOm0ck0SKEJo8/gMGGo12ejKUXWTOXSDzaFqWwCfn
 aqHTseav6kwsOdTWH5QFDOXjnktw/R12Hkc1qhgVhOPOrc5FIpARdQRYjOY7cz16yhMO
 2/9aYCOirE8XyYyt0K9No5xxNE+ZWAIYqTs7zucLo/CJKiWCEjz0s62UvNqzNJ72jtkE
 z36tpFTNl/H5q2WALNZiQkITiwaZ9DWwmqYnscdqpf+yp0Bftb9wahX//4YWZPx5iPlw
 eJt6Bu8qbbdkYbsi5xAxHqrTr2syfKih+B98z0Dog+jfEMiX1fo9DW90+Mb5e9Q4hr+q
 FYjA==
X-Gm-Message-State: APjAAAU80rtde0btsw8hpOby/5IxI5KtLCBPYxzDjiPXwoEv19SmwMc9
 Vos3YvX4DF7u7zBAtKgPIC99x9gpziQA8MKctFtr6w==
X-Google-Smtp-Source: APXvYqyiRYVPZCKtgu6aKGN1DeSsZ4iFecb4Qs0NnkAtTcCGmn5QuxDMYcb114ECJmSkrHVwaUgDseaNNIQy0K+oTwc=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr39456078otk.363.1564774690435; 
 Fri, 02 Aug 2019 12:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190802192956.GA3032@redhat.com>
In-Reply-To: <20190802192956.GA3032@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 2 Aug 2019 12:37:59 -0700
Message-ID: <CAPcyv4jxknEGq9FzGpsMJ6E7jC51d1W9KbNg4HX6Cj6vqt7dqg@mail.gmail.com>
Subject: Re: [PATCH] dax: dax_layout_busy_page() should not unmap cow pages
To: Vivek Goyal <vgoyal@redhat.com>
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
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, virtio-fs@redhat.com,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Aug 2, 2019 at 12:30 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> As of now dax_layout_busy_page() calls unmap_mapping_range() with last
> argument as 1, which says even unmap cow pages. I am wondering who needs
> to get rid of cow pages as well.
>
> I noticed one interesting side affect of this. I mount xfs with -o dax and
> mmaped a file with MAP_PRIVATE and wrote some data to a page which created
> cow page. Then I called fallocate() on that file to zero a page of file.
> fallocate() called dax_layout_busy_page() which unmapped cow pages as well
> and then I tried to read back the data I wrote and what I get is old
> data from persistent memory. I lost the data I had written. This
> read basically resulted in new fault and read back the data from
> persistent memory.
>
> This sounds wrong. Are there any users which need to unmap cow pages
> as well? If not, I am proposing changing it to not unmap cow pages.
>
> I noticed this while while writing virtio_fs code where when I tried
> to reclaim a memory range and that corrupted the executable and I
> was running from virtio-fs and program got segment violation.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: rhvgoyal-linux/fs/dax.c
> ===================================================================
> --- rhvgoyal-linux.orig/fs/dax.c        2019-08-01 17:03:10.574675652 -0400
> +++ rhvgoyal-linux/fs/dax.c     2019-08-02 14:32:28.809639116 -0400
> @@ -600,7 +600,7 @@ struct page *dax_layout_busy_page(struct
>          * guaranteed to either see new references or prevent new
>          * references from being established.
>          */
> -       unmap_mapping_range(mapping, 0, 0, 1);
> +       unmap_mapping_range(mapping, 0, 0, 0);

Good find, yes, this looks correct to me and should also go to -stable.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

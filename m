Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7767211041
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 18:08:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 35CED11460B27;
	Wed,  1 Jul 2020 09:08:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A2B0E11460B26
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jul 2020 09:08:29 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id z17so20467039edr.9
        for <linux-nvdimm@lists.01.org>; Wed, 01 Jul 2020 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgtGRFNzMUt8UwQnpVLH6Q0lK3Q/pmzbcISwUTSvZp4=;
        b=sgyWg0odMXUUNA+ymUvc43LaYs2s/aJwbFyXWRoPjxwdAxwM/8NDCnpUaFI4p3liR0
         gB3SPFv0A/WozVPJacrsy3TT9HIOMMCESTpphsqE92coNdoMTDE/jB5/k99TrA7k0WXT
         HwfvYQsx393r8hZTsu6RX5RUEhIafmeLpfC5Xxvgan8YQB6lIclWByvvZYmq9DcmZLWN
         JlL5WK7hHhUXeDny6LC8Ts2exiDWCHCRjEx+DVoYVUZMCGpeUSrXG6yeqYlDTXCkU+hk
         g1qHbmn4FwKHi5mTo+XYno4GD6wFdoeaM1etI9G0XSOMB6JxPVUPvp1yv+DnjQn7iHAQ
         vT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgtGRFNzMUt8UwQnpVLH6Q0lK3Q/pmzbcISwUTSvZp4=;
        b=PpliuQ9+9+Gt1gAVG2R88lsB44oIvVLZDuf9rR9E8G5+ns7+RxsSDrlSF66OBE/Ov7
         mky22kYqNsCLJsTS0EdAcPMtcHW9rSF8JpaVhSXniqYceRdZKBB17WPKQgV3TPT4A2qu
         YSbEAydEc0phdBYVI7Zvl6K86kbQhVV1racrGMXrUythbDw/nE0YpeBj7bXGdUFnOUBp
         BXbzH9GufWMUO744AWMi8e74N3qY120aiF0gDqwTnBrskbMSCiRjUPLGD9BHH4jKatlx
         kYtnkEbiIKAvVf63VZs382NjeGQ+2vo1iWh730A5mWRKAzcbLnpWBlU2afob5wnIGjrF
         myWQ==
X-Gm-Message-State: AOAM532XuwKeBeJv3xf+p+BsaIBWHxOPt3uW0EWZkwX37moJb6yMmCW5
	97EiDGXXBGmGZ+srIa8Gj18I+OW32djn4D+3Cmx/9Q==
X-Google-Smtp-Source: ABdhPJwTtEaJeqUJmjVrnga0zb3T87bQXg/qHVHNHjeT7uurwTRSLAeKnsyE6dqNxhAJ1jQ5OrZ9KB+p0GzE9WKAsFg=
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr29609575edb.296.1593619707927;
 Wed, 01 Jul 2020 09:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200701085947.3354405-1-hch@lst.de> <20200701085947.3354405-17-hch@lst.de>
In-Reply-To: <20200701085947.3354405-17-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Jul 2020 09:08:17 -0700
Message-ID: <CAPcyv4hELsX=dnqppbL72Tg2k8xMm-5ZaEsxM98eQ7XPoG5NGg@mail.gmail.com>
Subject: Re: [PATCH 16/20] block: move ->make_request_fn to struct block_device_operations
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: HYHVSP6WY2W6Y3GCCLICP3NZDEKCRPPE
X-Message-ID-Hash: HYHVSP6WY2W6Y3GCCLICP3NZDEKCRPPE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jens Axboe <axboe@kernel.dk>, device-mapper development <dm-devel@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-bcache@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-nvme@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HYHVSP6WY2W6Y3GCCLICP3NZDEKCRPPE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 1, 2020 at 2:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The make_request_fn is a little weird in that it sits directly in
> struct request_queue instead of an operation vector.  Replace it with
> a block_device_operations method called submit_bio (which describes much
> better what it does).  Also remove the request_queue argument to it, as
> the queue can be derived pretty trivially from the bio.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
[..]
>  drivers/nvdimm/blk.c                          |  5 +-
>  drivers/nvdimm/btt.c                          |  5 +-
>  drivers/nvdimm/pmem.c                         |  5 +-

For drivers/nvdimm

Acked-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

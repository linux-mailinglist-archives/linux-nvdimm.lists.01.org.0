Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FFA214746
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 18:09:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F2CC111AFBB8;
	Sat,  4 Jul 2020 09:09:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=jic23@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8870F1118BAEB
	for <linux-nvdimm@lists.01.org>; Sat,  4 Jul 2020 09:09:11 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id DDA2B20739;
	Sat,  4 Jul 2020 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593878951;
	bh=X+m5w31XgirTMtq+0fLAVoWC/VZ/4PksqUd3bRP4osw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PBrbiXvDtehCfX5k4RSS1bunkU9TjzLHpz75ntSnDLev19/7BPsM8T2FwwUBkb8GX
	 BgT16U9iJujXeGG4tieMLxIgRkWiZo7qej694rBvYa31S5rjRhuhwxpPyBz5yq1h1+
	 cCyJ/oei5B7r6m0I06g/K/Mn5qcrUcLIdnvEYixY=
Date: Sat, 4 Jul 2020 17:09:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/17] Documentation/driver-api: iio/buffers: drop
 doubled word
Message-ID: <20200704170905.7e596707@archlinux>
In-Reply-To: <20200704034502.17199-8-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
	<20200704034502.17199-8-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Message-ID-Hash: POPEPE5INQKXFAPOT2CQYSVK727WDYWW
X-Message-ID-Hash: POPEPE5INQKXFAPOT2CQYSVK727WDYWW
X-MailFrom: jic23@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/POPEPE5INQKXFAPOT2CQYSVK727WDYWW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri,  3 Jul 2020 20:44:52 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Drop the doubled word "struct".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  Documentation/driver-api/iio/buffers.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/driver-api/iio/buffers.rst
> +++ linux-next-20200701/Documentation/driver-api/iio/buffers.rst
> @@ -88,7 +88,7 @@ fields in iio_chan_spec definition::
>  The driver implementing the accelerometer described above will have the
>  following channel definition::
>  
> -   struct struct iio_chan_spec accel_channels[] = {
> +   struct iio_chan_spec accel_channels[] = {
>             {
>                     .type = IIO_ACCEL,
>  		   .modified = 1,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

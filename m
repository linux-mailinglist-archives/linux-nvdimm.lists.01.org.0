Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 721FD2151DB
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 Jul 2020 06:48:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7CD5611043786;
	Sun,  5 Jul 2020 21:48:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=vkoul@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9A0911003F508
	for <linux-nvdimm@lists.01.org>; Sun,  5 Jul 2020 21:48:30 -0700 (PDT)
Received: from localhost (unknown [122.182.251.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4F0A420720;
	Mon,  6 Jul 2020 04:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594010910;
	bh=saajXkjFZV5Ysay/V5yS2+LctG2zyPPXgCNYyixmBgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8QMvTN/gVISdfC7gmwMxMOxgudEVlVFrB9e4xhjcdL6RTBc/mgQM7pZj72Gtycmv
	 ohIo6GAY8xfkvM0ae8iHztQNqQL9SJopoEchCTMXAx+6NrAxmWhxIHuEb3w7k8MNZl
	 ObXOA/9Fe0bv3YA6Qd3KXpJCm1Yzo6/moH2aUJ+k=
Date: Mon, 6 Jul 2020 10:18:24 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 01/17] Documentation/driver-api: dmaengine/provider: drop
 doubled word
Message-ID: <20200706044824.GB633187@vkoul-mobl>
References: <20200704034502.17199-1-rdunlap@infradead.org>
 <20200704034502.17199-2-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200704034502.17199-2-rdunlap@infradead.org>
Message-ID-Hash: DQJUVQ4QHYKOZQ3W7W5TCW45AVOZ7XTQ
X-Message-ID-Hash: DQJUVQ4QHYKOZQ3W7W5TCW45AVOZ7XTQ
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DQJUVQ4QHYKOZQ3W7W5TCW45AVOZ7XTQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 03-07-20, 20:44, Randy Dunlap wrote:
> Drop the doubled word "has".

Applied, thanks

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> ---
>  Documentation/driver-api/dmaengine/provider.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/driver-api/dmaengine/provider.rst
> +++ linux-next-20200701/Documentation/driver-api/dmaengine/provider.rst
> @@ -507,7 +507,7 @@ dma_cookie_t
>  DMA_CTRL_ACK
>  
>  - If clear, the descriptor cannot be reused by provider until the
> -  client acknowledges receipt, i.e. has has a chance to establish any
> +  client acknowledges receipt, i.e. has a chance to establish any
>    dependency chains
>  
>  - This can be acked by invoking async_tx_ack()

-- 
~Vinod
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

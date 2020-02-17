Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E0161369
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 14:30:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8194A10FC3537;
	Mon, 17 Feb 2020 05:34:04 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A25B210FC3419
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 05:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U11A+++4LKK51+4tdSmvbusBvC9USfeT04f6UKr3pAE=; b=Y6quXZyQbtJGHAqQouPU/RR9fr
	pQtX4bvumSbjtm5YOIkW/pRMaKU2libxHzttIOHrS54dg/Coan3bHDoOF+inP1AulxTy5/w7X/Rx2
	DSyhT+xq98ZNuWP1+j0wIfM89xtTm9YgCm1wE8UXid3ZQFIRK6QqjtB9rhbxduG2hh3l6fFlYiFtd
	7fcIiVv68pn5+YP7LMH+ldRhkQRyhTrv2hEaBKgPS5qZVitXJkg0FclicZqDPPuiPr1zv/2y+rwKP
	YvCVp8HN1H+G4mwIT1UpYW1zsbQ+mC0I7b2Cw+LpfHDenYSYZ6yM/25dGOJ9XrLwk131QjCz4qCbp
	g8TUo6hA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j3gTz-0007JC-7K; Mon, 17 Feb 2020 13:30:43 +0000
Date: Mon, 17 Feb 2020 05:30:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/6] dax: Define a helper dax_pgoff() which takes in
 dax_offset as argument
Message-ID: <20200217133043.GA20444@infradead.org>
References: <20200212170733.8092-1-vgoyal@redhat.com>
 <20200212170733.8092-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212170733.8092-2-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: VHK6GFB3GARMOTMMBSE4I3GN2X6BHGRE
X-Message-ID-Hash: VHK6GFB3GARMOTMMBSE4I3GN2X6BHGRE
X-MailFrom: BATV+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VHK6GFB3GARMOTMMBSE4I3GN2X6BHGRE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 12, 2020 at 12:07:28PM -0500, Vivek Goyal wrote:
> Create a new helper dax_pgoff() which will replace bdev_dax_pgoff(). Difference
> between two is that dax_pgoff() takes in "sector_t dax_offset" as an argument
> instead of "struct block_device".
> 
> dax_offset specifies any offset into dax device which should be added to
> sector while calculating pgoff.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/dax/super.c | 12 ++++++++++++
>  include/linux/dax.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0aa4b6bc5101..e9daa30e4250 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -56,6 +56,18 @@ int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
>  }
>  EXPORT_SYMBOL(bdev_dax_pgoff);
>  
> +int dax_pgoff(sector_t dax_offset, sector_t sector, size_t size, pgoff_t *pgoff)

Please add a kerneldoc document.  I can't really make sense of what
dax_offset and sector mean here and why they are passed separately.

> +{
> +	phys_addr_t phys_off = (dax_offset + sector) * 512;

							<< SECTOR_SHIFT;

> +
> +	if (pgoff)
> +		*pgoff = PHYS_PFN(phys_off);

What is the use case of not passing a pgoff argument?

> +	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> +		return -EINVAL;
> +	return 0;
> +}
> +EXPORT_SYMBOL(dax_pgoff);

EXPORT_SYMBOL_GPL, please.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

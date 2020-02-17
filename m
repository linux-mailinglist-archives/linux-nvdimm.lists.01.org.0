Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E016133B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 14:23:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8EC6710FC3381;
	Mon, 17 Feb 2020 05:26:58 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E4D8310FC3374
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 05:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ByxHNx18slAjQKwWQOPPOSwhUVNs5MumxpbzTsFX1YE=; b=Wg1XDz5aNxcq5v1gyNrnTidPVe
	8HqRWPY8J3R0MOaBmB84CGVgjJW8Wkm26X9SxtIyNA23KgARIHqBYzhF7l5Xe5CPKp6zeIvMBLSSo
	Zp/KPaNj/+C5aTS1vM8gSadnQ0MtWm+OQtWROKv1HSCV6fgOy9s0fCfGuJSdV/ko28taJVN4QMeDw
	TvcYwpurjpczt6e6i1epwKNk544VeTVuBOqrynLRMIGHbumNS4rvWcryZ/unl9DonoDWAtau5G6zx
	7m2E/xMW+pIO739uAVglRnCPOJ9hu0fInTTEkea6UsQdAXsetRo/Jax9ZOmDTCQaO61PK+AC2kQDB
	4wFeg11w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j3gMf-0002bB-FE; Mon, 17 Feb 2020 13:23:09 +0000
Date: Mon, 17 Feb 2020 05:23:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 2/7] pmem: Enable pmem_do_write() to deal with
 arbitrary ranges
Message-ID: <20200217132309.GC14490@infradead.org>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-3-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: EN6HPZDH3CAJAL5XTYSGWNMOHX2KB72D
X-Message-ID-Hash: EN6HPZDH3CAJAL5XTYSGWNMOHX2KB72D
X-MailFrom: BATV+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EN6HPZDH3CAJAL5XTYSGWNMOHX2KB72D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 07, 2020 at 03:26:47PM -0500, Vivek Goyal wrote:
> Currently pmem_do_write() is written with assumption that all I/O is
> sector aligned. Soon I want to use this function in zero_page_range()
> where range passed in does not have to be sector aligned.
> 
> Modify this function to be able to deal with an arbitrary range. Which
> is specified by pmem_off and len.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/nvdimm/pmem.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 9ad07cb8c9fc..281fe04d25fd 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -154,15 +154,23 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
>  
>  static blk_status_t pmem_do_write(struct pmem_device *pmem,
>  			struct page *page, unsigned int page_off,
> -			sector_t sector, unsigned int len)
> +			u64 pmem_off, unsigned int len)
>  {
>  	blk_status_t rc = BLK_STS_OK;
>  	bool bad_pmem = false;
> -	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
> -	void *pmem_addr = pmem->virt_addr + pmem_off;
> -
> -	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
> -		bad_pmem = true;
> +	phys_addr_t pmem_real_off = pmem_off + pmem->data_offset;
> +	void *pmem_addr = pmem->virt_addr + pmem_real_off;
> +	sector_t sector_start, sector_end;
> +	unsigned nr_sectors;
> +
> +	sector_start = DIV_ROUND_UP(pmem_off, SECTOR_SIZE);
> +	sector_end = (pmem_off + len) >> SECTOR_SHIFT;
> +	if (sector_end > sector_start) {
> +		nr_sectors = sector_end - sector_start;
> +		if (unlikely(is_bad_pmem(&pmem->bb, sector_start,
> +					 nr_sectors << SECTOR_SHIFT)))
> +			bad_pmem = true;

I don't think an unlikely annotation makes much sense for assigning
a boolean value to a flag variable.

> +		/*
> +		 * Pass sector aligned offset and length. That seems
> +		 * to work as of now. Other finer grained alignment
> +		 * cases can be addressed later if need be.
> +		 */

This comment seems pretty scary.  What other cases can you think of?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

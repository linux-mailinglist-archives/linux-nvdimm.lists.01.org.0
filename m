Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED9162B97
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 18:09:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED92A10FC33E6;
	Tue, 18 Feb 2020 09:10:22 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+407f53ceaa3a8fe198ff+6022+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B2D6B1007B1E3
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 09:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Leb7QTqh5fSW+ghKsnBixVziPFOkNZgzg9WjmOIRDnA=; b=ZyMmRzVP1vAuptylmoI4D/y6pR
	c4MJTWlmjsmnzq3bEIbq8d39WbgTuWQY2jSSU7TvIE1r7alHmSKszYGuDv9yea7Y8Zp0+UoHn2qWh
	2axbaQ4c8jqqf5g2FeMX7dJ6FKt+hiQBmgXR+xifdl+AtkqH9+w8MSZS8JgPGSvfzjF3gZCnuRdah
	xQtdFd5IVuSrZ/vaRE3j6rf0KZ1QMX8FcNMsEFT6IY2l8D/5v134HM5wxZ93VRsiL0vXxfvdiGyzd
	+m0k6BpVsch+HU+PHVi3EnsXuOAzkMU1Ct3TQrM8BdzGNWsroU4gUi6qGN23BdSXMfsRO4nXDLH5E
	pOXPEfDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j46NE-0000Ag-MC; Tue, 18 Feb 2020 17:09:28 +0000
Date: Tue, 18 Feb 2020 09:09:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [dm-devel] [PATCH v4 2/7] pmem: Enable pmem_do_write() to deal
 with arbitrary ranges
Message-ID: <20200218170928.GB30766@infradead.org>
References: <20200217181653.4706-1-vgoyal@redhat.com>
 <20200217181653.4706-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200217181653.4706-3-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: VA3HRZ5DXYHZFKIJGA57DVDA56WLUXSK
X-Message-ID-Hash: VA3HRZ5DXYHZFKIJGA57DVDA56WLUXSK
X-MailFrom: BATV+407f53ceaa3a8fe198ff+6022+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VA3HRZ5DXYHZFKIJGA57DVDA56WLUXSK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 17, 2020 at 01:16:48PM -0500, Vivek Goyal wrote:
> Currently pmem_do_write() is written with assumption that all I/O is
> sector aligned. Soon I want to use this function in zero_page_range()
> where range passed in does not have to be sector aligned.
> 
> Modify this function to be able to deal with an arbitrary range. Which
> is specified by pmem_off and len.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/nvdimm/pmem.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 075b11682192..fae8f67da9de 100644
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
> +		if (is_bad_pmem(&pmem->bb, sector_start,
> +				nr_sectors << SECTOR_SHIFT))
> +			bad_pmem = true;
> +	}
>  
>  	/*
>  	 * Note that we write the data both before and after
> @@ -181,7 +189,13 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
>  	flush_dcache_page(page);
>  	write_pmem(pmem_addr, page, page_off, len);
>  	if (unlikely(bad_pmem)) {
> -		rc = pmem_clear_poison(pmem, pmem_off, len);
> +		/*
> +		 * Pass sector aligned offset and length. That seems
> +		 * to work as of now. Other finer grained alignment
> +		 * cases can be addressed later if need be.
> +		 */
> +		rc = pmem_clear_poison(pmem, ALIGN(pmem_real_off, SECTOR_SIZE),
> +				       nr_sectors << SECTOR_SHIFT);
>  		write_pmem(pmem_addr, page, page_off, len);

I'm still scared about the as of now commnet.  If the interface to
clearing poison is page aligned I think we should document that in the
actual pmem_clear_poison function, and make that take the unaligned
offset.  I also think we want some feedback from Dan or other what the
official interface is instead of "seems to work".
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

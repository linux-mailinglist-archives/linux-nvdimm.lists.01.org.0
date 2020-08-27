Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D67E32540F9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Aug 2020 10:36:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 17DD61257EA99;
	Thu, 27 Aug 2020 01:36:01 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+811462fdb5f870f212f0+6213+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BE7281257EA95
	for <linux-nvdimm@lists.01.org>; Thu, 27 Aug 2020 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1MBOvjB+9m0M7w4PQdZ2NOCfksOiohzbEbMFMspbqoc=; b=QW3Qe/NlFGPNasZPafhuJ7jcdn
	8OHUxL+KZ3L/ZK90HAdySeBpBxqH+oQMwUYY2ybWhjl6ySP4LXESV9Ky+fFPP+kBPufC5QuRsX5Op
	5WS0EzX3egRn8JFShjXtd9q1PF9BfDdMq/HKI5ZtUVspNwVs6O38Dw2b/zGCBgxyOE9rLkxAGk0Wk
	gUt+9/HB0x5wLyg0ZnvHLDuG58nqnVFFeVCqcdILhDiVP/ndQEh4jmuyz/h+vUhmO+F4X6mjFKca/
	JuBA8ecVSCcH+nbv/AtSxmFZgBKgl/bK58IBvsF1yDv77smtLkq3766whaoQMmr9pLSG/3+LBnYfW
	JSQ2cCyQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBDNw-0003ns-Gs; Thu, 27 Aug 2020 08:35:52 +0000
Date: Thu, 27 Aug 2020 09:35:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 6/9] iomap: Convert read_count to byte count
Message-ID: <20200827083552.GC11067@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-7-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: Y6RQV6RHLHUGQGSJU276BKRK7AVQ453M
X-Message-ID-Hash: Y6RQV6RHLHUGQGSJU276BKRK7AVQ453M
X-MailFrom: BATV+811462fdb5f870f212f0+6213+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y6RQV6RHLHUGQGSJU276BKRK7AVQ453M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> @@ -269,20 +263,17 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	if (ctx->bio && bio_end_sector(ctx->bio) == sector)
>  		is_contig = true;
>  
> -
>  	/*
> -	 * If we start a new segment we need to increase the read count, and we
> -	 * need to do so before submitting any previous full bio to make sure
> -	 * that we don't prematurely unlock the page.
> +	 * We need to increase the read count before submitting any
> +	 * previous bio to make sure that we don't prematurely unlock
> +	 * the page.
>  	 */
>  	if (iop)
> -		atomic_inc(&iop->read_count);
> +		atomic_add(plen, &iop->read_count);
> +
> +	if (is_contig &&
> +	    __bio_try_merge_page(ctx->bio, page, plen, poff, &same_page))
> +		goto done;
>  
>  	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {

I think we can simplify this a bit by reordering the checks:

 	if (iop)
		atomic_add(plen, &iop->read_count);

  	if (ctx->bio && bio_end_sector(ctx->bio) == sector)
		if (__bio_try_merge_page(ctx->bio, page, plen, poff,
				&same_page))
			goto done;
		is_contig = true;
	}

	if (!is_contig || bio_full(ctx->bio, plen)) {
		// the existing case to allocate a new bio
	}

Also I think read_count should be renamed to be more descriptive,
something like read_bytes_pending?  Same for the write side.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

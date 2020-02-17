Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6184B16132B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 14:21:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E83110FC3374;
	Mon, 17 Feb 2020 05:25:07 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3601410FC3180
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 05:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D5TyLgd0jRYPWavRlJvo3pOwK15lw15o14H3IXOmbJo=; b=YJpaCvYwPOT6yndq/bHvy9tOdc
	xFrtP5YNz5t64Xkw7PR2QZoAGAjBWPa4DV5et7wKneH3NQYRSWiZBf+fBMjrGz0QpVNvzfgVOpNSy
	EsQZGGrLTq3VqLL6YVQ25nAqEwAn0JNmoXf1YDZbxsJqHYZ12At2Hmr6RAq4iW2CSPIaaZHrWl4SP
	+J7L+M6fegLGJ4kkISoLkQTs2Y8rU1vHT/oa7IJJySp8JgZYTvlvYDQUA3Mnku2L3y1mitg0elIar
	Aq9W4LP7d5Rm7A5F2RwqLHrtcw8tLpneKJZgcH1V/k7V89Mdviz2+1a+42yg20UoUX9FHpxx3ZTkS
	oC0fcrSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j3gLC-0002Jr-K2; Mon, 17 Feb 2020 13:21:38 +0000
Date: Mon, 17 Feb 2020 05:21:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 1/7] pmem: Add functions for reading/writing page
 to/from pmem
Message-ID: <20200217132138.GB14490@infradead.org>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-2-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: OGM5F4UQW2JETK6G3L7SHNYEIZEC6FTF
X-Message-ID-Hash: OGM5F4UQW2JETK6G3L7SHNYEIZEC6FTF
X-MailFrom: BATV+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OGM5F4UQW2JETK6G3L7SHNYEIZEC6FTF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 07, 2020 at 03:26:46PM -0500, Vivek Goyal wrote:
> +static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
> +			unsigned int len, unsigned int off, unsigned int op,
> +			sector_t sector)
> +{
> +	if (!op_is_write(op))
> +		return pmem_do_read(pmem, page, off, sector, len);
> +
> +	return pmem_do_write(pmem, page, off, sector, len);

Why not:

	if (op_is_write(op))
		return pmem_do_write(pmem, page, off, sector, len);
	return pmem_do_read(pmem, page, off, sector, len);

that being said I don't see the point of this pmem_do_bvec helper given
that it only has two callers.

The rest looks good to me.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

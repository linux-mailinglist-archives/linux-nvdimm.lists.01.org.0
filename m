Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A84FFF45
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 Nov 2019 08:04:32 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1567A100DC3EE;
	Sun, 17 Nov 2019 23:05:31 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+189483ff2217bb486f00+5930+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 183A6100DC3EA
	for <linux-nvdimm@lists.01.org>; Sun, 17 Nov 2019 23:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=S5SJMQSrl08VJMJjYFzoGqDV3
	30jVobNTl9dUYCycICm/1mmfg1fvf1IMgR78at3v4stXeLUEWfeO0OyAJ2eZtD8OuRCnMzamRDjWJ
	BhVPq2nv/WraPZNm9NgAEV4jssHxmJWWlUu5FXAiqoKRj8d62NaubXTx8ZKM0aB0q0QjRk8Q5IdvY
	2hKmbyjnIpSPe4qPQUwMhYfHmQpX7Kjdc3Kk1h2Jm+72R7hym/yb+m/tQF2oJmzRODv76bcK0JMG4
	yK1+ZcHv+H4IDPBeLkUSKj95z5WynKSkAqfK8S2F5kwzqblaTsMEZeZQsCpgpFxGvOIXtzYxn4TiL
	iKzcPhnNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iWb4r-0000sk-Gp; Mon, 18 Nov 2019 07:04:01 +0000
Date: Sun, 17 Nov 2019 23:04:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/2] mm: Cleanup __put_devmap_managed_page() vs
 ->page_free()
Message-ID: <20191118070401.GA3099@infradead.org>
References: <20191115001134.2489505-1-jhubbard@nvidia.com>
 <20191115001134.2489505-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191115001134.2489505-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: R4AJ5Y6443PQKTZVGVF2NH4SXA7VVAEM
X-Message-ID-Hash: R4AJ5Y6443PQKTZVGVF2NH4SXA7VVAEM
X-MailFrom: BATV+189483ff2217bb486f00+5930+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-nvdimm@lists.01.org, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R4AJ5Y6443PQKTZVGVF2NH4SXA7VVAEM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

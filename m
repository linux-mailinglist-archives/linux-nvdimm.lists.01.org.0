Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD4E161345
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 14:26:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2A4410FC338A;
	Mon, 17 Feb 2020 05:29:56 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0873B10FC3381
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 05:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1g8gUNk4QZmb7qpe3MRgs3En9cghrTnYOXb1h6i0Ozs=; b=CsdmLYjlaqfr0EqLEfYRnKiJhP
	pWnSzFoQnJ8J5UvRzZRX+G66HYFWsdbr7qBCzeKS3YbJaTqEyuPcXGIvM/wFq+7Ut/uhXvyizvHvP
	vVDjeOz6fMPUJIk54s3ccJS11CQtA71624DOqRLNUq5+xlzxiiQ7itTaGLljzFMnSSQgVrI9LcGLC
	/zb4sy5Bn53taswxhaTb1RtfLSYgwuihnLC5dpxhjHURhY90aMPtDYtHE/B9VZV6T1umevGaTD1ub
	zwvG0Ur1qOWcax7mfUGhyjrmDPIDrsk5UTEp2r65Be4OkkpaUBv4iZdSby44qAI+XdkUJf6RpE/6R
	8aVypBvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j3gPX-0004Yx-6K; Mon, 17 Feb 2020 13:26:07 +0000
Date: Mon, 17 Feb 2020 05:26:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 3/7] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200217132607.GD14490@infradead.org>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-4-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: FL2MOFCPL4W4IL4Y3PRNRX5MKHANUBHU
X-Message-ID-Hash: FL2MOFCPL4W4IL4Y3PRNRX5MKHANUBHU
X-MailFrom: BATV+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FL2MOFCPL4W4IL4Y3PRNRX5MKHANUBHU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +	int rc;
> +	struct pmem_device *pmem = dax_get_private(dax_dev);
> +	struct page *page = ZERO_PAGE(0);

Nit: I tend to find code easier to read if variable declarations
with assignments are above those without.

Also I don't think we need the page variable here.

> +	rc = pmem_do_write(pmem, page, 0, offset, len);
> +	if (rc > 0)
> +		return -EIO;

pmem_do_write returns a blk_status_t, so the type of rc and the > check
seem odd.  But I think pmem_do_write (and pmem_do_read) might be better
off returning a normal errno anyway.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

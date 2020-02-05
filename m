Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6F8153833
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 19:33:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C12310FC33ED;
	Wed,  5 Feb 2020 10:37:16 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+a2b935cbc3c12af13a1b+6009+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2341510FC33ED
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kCaUjwxLyxoE0RNdCEgG1o8G9nXdq6WoXoKYNVIpnOU=; b=t0EF1vH+aRuezWyirREnxroEMA
	jYT3bxspZ8xkSTUYIFlkrCGH7qk9Pg8rlegbclD4rrMV/XOZeZYJ5hk6tLJ8cgGirnpUSq3eCTRUJ
	1p3YvGIWyg3pp15kIBp7S9+rIAx5x1fpGBsHHY6DyqyTbWRRgK5yIhFK+Iq1tUUWSQbpYXwewlp2s
	AoJpkGZRpVExG6cMS0G0Mob+SSN1US1s8ZuFyYtSPn+inYKk0TnN1CWkd5phBy3Oo8UM27QjVKCnt
	qfhX7WO0XCfJeeusaBtC+XWDC2R/R2BbJmRljxw5Dr0XCfoPmj1e0eVPRrJ9tTTM77R1mx9tqtK+0
	zo9YuEfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPUq-0001ds-4s; Wed, 05 Feb 2020 18:33:56 +0000
Date: Wed, 5 Feb 2020 10:33:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/5] dax,iomap: Start using dax native zero_page_range()
Message-ID: <20200205183356.GD26711@infradead.org>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-5-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200203200029.4592-5-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: F2RT2NLCM4I3IN76UVUIPW5L3C6NTXOO
X-Message-ID-Hash: F2RT2NLCM4I3IN76UVUIPW5L3C6NTXOO
X-MailFrom: BATV+a2b935cbc3c12af13a1b+6009+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F2RT2NLCM4I3IN76UVUIPW5L3C6NTXOO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 03, 2020 at 03:00:28PM -0500, Vivek Goyal wrote:
> +	id = dax_read_lock();
> +	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
> +	dax_read_unlock(id);
> +	return rc;

Is there a good reason not to move the locking into dax_zero_page_range?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

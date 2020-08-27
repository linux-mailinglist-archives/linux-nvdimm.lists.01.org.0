Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864882540FD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Aug 2020 10:36:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D69A1257EA9A;
	Thu, 27 Aug 2020 01:36:30 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+811462fdb5f870f212f0+6213+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E90D11257EA96
	for <linux-nvdimm@lists.01.org>; Thu, 27 Aug 2020 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o5+xPEQxoEEyAdnso83ls1nfUNx+yX31JYi8krguPtk=; b=UK69VdUqhTbBTdlbAAxYMJtxrl
	entONaNmGq3w0fuYxiC9Tjlpd+IhsF4BIQ0MiASfoj9j2ql78Jaqh1V3HwyO1hsMnFfJayIL9oPQS
	aAFZTzXMprC4RwQYFKBSzISZ0FzIZryxYKojdslclEqMr2gmc6PHD2bmbYhCRkCO1cvjOPGf5TKdw
	3rtdVl6HR8OJUQ34E2dmxOZm/i+KXH1mYQI7FMWH0Fc1wO224Y7IpYp6xIIbDjLcVQ8G+8425ygry
	ohbiO+F3qMGneAOLudfVIQ8QQknoVuXTH/wb4RXGKNvzZrzb0vO8iPbDz0iw5NBQY/bnevpbdOaJA
	2S3RuaWQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBDOS-0003qi-L9; Thu, 27 Aug 2020 08:36:24 +0000
Date: Thu, 27 Aug 2020 09:36:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 7/9] iomap: Convert write_count to byte count
Message-ID: <20200827083624.GD11067@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-8-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: VGQJDUATD44B3ANDLNJSCI3QOHA5ZFZP
X-Message-ID-Hash: VGQJDUATD44B3ANDLNJSCI3QOHA5ZFZP
X-MailFrom: BATV+811462fdb5f870f212f0+6213+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VGQJDUATD44B3ANDLNJSCI3QOHA5ZFZP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 03:55:08PM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of counting bio segments, count the number of bytes submitted.
> This insulates us from the block layer's definition of what a 'same page'
> is, which is not necessarily clear once THPs are involved.

Looks good (module the field naming as comment on the previous patch):

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

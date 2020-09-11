Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32D52658DD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Sep 2020 07:37:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7EF2D143B947C;
	Thu, 10 Sep 2020 22:37:01 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+8b03dcf5e621e88c3391+6228+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3192D143B947B
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gQphWQCU5VjNrWDqCFqtQ550fk5he6cvU1opUnwp6c8=; b=TtW8Tw/Awwjlz9gH0OBnuKs1qy
	7ZLv4Qt3qKqoCfvga77I2/h5nvdFdHI9hpnYnu3Z9U0gdWLfS1wccy9ndxj/OGxCCy/w3dZm2/NqO
	VBRvwCWm9c4caIpKq4MW1M7BaX3GTDleILIrKUDRZ0AcDLXqQF5ylxpch3CePtqA4upeRwm5bOsLk
	KZDpL5J5/9rWDAwBp4mxpxL/QZmDvVgkeWDKlKnz9xZX3nOsZJ9I5AHk24TzOsfwvm6bR1TOM+lqP
	MOvya4XR6dE4YqtiRtFIdMEbjVNKiKFuCaoVeooODCme9uI8WHd++HAXBJSwGBh9hrkT1UoibW9nQ
	G7J6otAA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGbjv-00040M-0T; Fri, 11 Sep 2020 05:36:51 +0000
Date: Fri, 11 Sep 2020 06:36:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 6/9] iomap: Convert read_count to read_bytes_pending
Message-ID: <20200911053650.GB15114@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-7-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910234707.5504-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: E7UFH5AU2WN6HM4PE5CEJIV5YMKD2X2Z
X-Message-ID-Hash: E7UFH5AU2WN6HM4PE5CEJIV5YMKD2X2Z
X-MailFrom: BATV+8b03dcf5e621e88c3391+6228+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E7UFH5AU2WN6HM4PE5CEJIV5YMKD2X2Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 11, 2020 at 12:47:04AM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of counting bio segments, count the number of bytes submitted.
> This insulates us from the block layer's definition of what a 'same page'
> is, which is not necessarily clear once THPs are involved.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

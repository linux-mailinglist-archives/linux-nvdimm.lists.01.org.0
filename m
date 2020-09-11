Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD792658D8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Sep 2020 07:36:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33816143B947A;
	Thu, 10 Sep 2020 22:36:21 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+8b03dcf5e621e88c3391+6228+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 438B7143B9479
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 22:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p/cH8MXuZzCKuPPmti7QDphLipv+FPQX4l4ZWjjEoYc=; b=ZlUs99gwDP63poq1V7RJnCx15p
	GWPQsJznaLYXI9GyHVKOaB8NeHGK5Z1gQw0WPGRQA/IEz1LiPfuGL3sWL0qN8l8AgtKkwA+1ijU7W
	cAP3oU+VdgXVRyPhUvsT5LFAWByJJCVp/o2lPoHyvCCYSC6eWPMrPChgHKQhUV0/mfw3YZm7PGdOq
	XOY0a+NkAGuyMbMqvUrY3DvZqppcMD5NT/viDmKRSt2GTTM4iSk0x+T60nV70CD2i5x1BYiD1iBk7
	ROVK4/sUFa2JzzkoAvahQIxqSE27aFRRdK9kWAESBAQgi7uBRT1dIwUjcire7ZxyUCnCg4152+PjK
	jz7Q2b1g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGbjG-0003xg-Ur; Fri, 11 Sep 2020 05:36:11 +0000
Date: Fri, 11 Sep 2020 06:36:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200911053610.GA15114@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-6-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910234707.5504-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: T42MZWEIX2JOX2BFCZ5JWRO7BDLQCRM7
X-Message-ID-Hash: T42MZWEIX2JOX2BFCZ5JWRO7BDLQCRM7
X-MailFrom: BATV+8b03dcf5e621e88c3391+6228+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Dave Chinner <dchinner@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T42MZWEIX2JOX2BFCZ5JWRO7BDLQCRM7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 11, 2020 at 12:47:03AM +0100, Matthew Wilcox (Oracle) wrote:
> Size the uptodate array dynamically to support larger pages in the
> page cache.  With a 64kB page, we're only saving 8 bytes per page today,
> but with a 2MB maximum page size, we'd have to allocate more than 4kB
> per page.  Add a few debugging assertions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

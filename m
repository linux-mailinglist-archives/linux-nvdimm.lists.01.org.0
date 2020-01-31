Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1E014E87D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jan 2020 06:42:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 789CB10FC3172;
	Thu, 30 Jan 2020 21:45:34 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+64ee32028001ca15ca6b+6004+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 474C710FC3171
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 21:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=udHIVECbwgewO/B7hI58+fnOCQ11HCZyJMj+2DknM+A=; b=tnz/bNS+8HzQiJ0ryBjLNjBlp
	IDpm4lctGxVLRLEqGBHuxR4IRvF72dtPTnhtbcgDUA0we/nfnLFu9lNs7myv3nJNTOmKSApnqrWib
	7hpGVIyRKx1MvR5KKuoeKFDf23l28AIuXw/VBwqSlFrGKUtP0QY5yAACzGQnFNU1A8jxLc+rzqeJ/
	c5A5Wr619puIV9ihKesW4xrqKpN+OxwooS8fBust3xwtEaCViFd+y2BvzbxkNX/9+BQ/yIsFgu7Ou
	XpTNgVr9YMZrNO/jZdpHRkRODfwJmY5zMd32R8Id5Ri6tNpjC92V2L1qpJTZ1+47XX0wcxxHZDh0J
	nw7rKfXcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixP4H-0006xR-Va; Fri, 31 Jan 2020 05:42:13 +0000
Date: Thu, 30 Jan 2020 21:42:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC][PATCH] dax: Do not try to clear poison for partial pages
Message-ID: <20200131054213.GA26489@infradead.org>
References: <20200129210337.GA13630@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200129210337.GA13630@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: LNSDQJKXRWCWIYCBRQYMQYJZMD4J5TTQ
X-Message-ID-Hash: LNSDQJKXRWCWIYCBRQYMQYJZMD4J5TTQ
X-MailFrom: BATV+64ee32028001ca15ca6b+6004+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LNSDQJKXRWCWIYCBRQYMQYJZMD4J5TTQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 29, 2020 at 04:03:37PM -0500, Vivek Goyal wrote:
> I am looking into getting rid of dependency on block device in dax
> path. One such place is __dax_zero_page_range() which checks if
> range being zeroed is aligned to block device logical size, then
> it calls bdev_issue_zeroout() instead of doing memset(). Calling
> blkdev_issue_zeroout() also clears bad blocks and poison if any
> in that range.
> 
> This path is used by iomap_zero_range() which in-turn is being
> used by filesystems to zero partial filesystem system blocks.
> For zeroing full filesystem blocks we seem to be calling
> blkdev_issue_zeroout() which clears bad blocks and poison in that
> range.
> 
> So this code currently only seems to help with partial filesystem
> block zeroing. That too only if truncation/hole_punch happens on
> device logical block size boundary.
> 
> To avoid using blkdev_issue_zeroout() in this path, I proposed another
> patch here which adds another dax operation to zero out a rangex and
> clear poison.

I'll have to defer to Dan and other on the poison clearing issue,
as it keeps confusing me everytime I look into how it is supposed
to work..  But in the end we'll need a path that doesn't realy on
the block device to clear poison anyway, so I think a method will
ultimatively be needed.  That being said this patch looks nice :)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

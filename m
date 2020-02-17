Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FA3161355
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 14:29:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 50A1210FC3419;
	Mon, 17 Feb 2020 05:32:16 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AB83610FC3410
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tfAOwYcGbGkV/cjxNr8rykRLpMwyGl5pU2nNL+7tbzs=; b=sg9X51UqV5bnAwmYKk2fMUtoRJ
	j2XJhN9A1ZLfjK85y3oYxsxO+LRnJPnk/YnCrZ/ymWxP8a3WpmI5dvQY3fOa2Qiw+G/yVl4lo6tXn
	24vkmsAGHEXAdpBNeUMmEirOXzpGrSBdWFxBREyXJtKri2ORJm4g48vFwrXxSpemHKD+/MpBIEUxV
	2wCtAunQeC75orQqk54ZjVGIFxqHmfgx438L5/2iLEZjkz6LuzTWWi30KdKM1ny5NU59M0QkHY4BD
	C0euscwnZhpz3Tp3IT/s/uAXJFzjb6o1VPXjQNjVb73B3zC/XeBfS/yhTOv3KukikfmzvLzLjK69e
	Ld8G7Mcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j3gR3-0005AS-AB; Mon, 17 Feb 2020 13:27:41 +0000
Date: Mon, 17 Feb 2020 05:27:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 7/7] dax,iomap: Add helper dax_iomap_zero() to zero a
 range
Message-ID: <20200217132741.GF14490@infradead.org>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-8-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-8-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: ZSWMMMSPI65DIYH57BGCA2WBBP7S3TBB
X-Message-ID-Hash: ZSWMMMSPI65DIYH57BGCA2WBBP7S3TBB
X-MailFrom: BATV+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZSWMMMSPI65DIYH57BGCA2WBBP7S3TBB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 07, 2020 at 03:26:52PM -0500, Vivek Goyal wrote:
> Add a helper dax_ioamp_zero() to zero a range. This patch basically
> merges __dax_zero_page_range() and iomap_dax_zero().
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c               | 12 ++++++------
>  fs/iomap/buffered-io.c |  9 +--------
>  include/linux/dax.h    | 17 +++--------------
>  3 files changed, 10 insertions(+), 28 deletions(-)

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

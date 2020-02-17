Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3E516138A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 14:31:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E9D510FC33FF;
	Mon, 17 Feb 2020 05:34:47 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C19810FC341A
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 05:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dJ4Zkxvpvz5W+pY+zDjAJt/JTwqlyPBBYfHm14egUVA=; b=qkeFFr9lh/8KJMax3DFt0itzaf
	BypRniQZWts27SXNLLmWKtXtQ484kFWJZHD70Yeai5ElvP4naO9RkDdMsQTy8sq6UxmJcSGjfvQ4m
	7n1qN+ZZ9dzShGPCps+6Va+jNrf9EWVhMRSn2NNViWvChjbMVTODf6khUs5LL2Jcfc8fgxFTbukNc
	YZp/PfiDXqNhr3pHAQ5ZNCSHpWJW3fvKAkikoseL5209WN3fhp9gXaIBjXVhMf0GdrdIkt1/7eYzJ
	5Rj0DV8XbNc5cEsdJrOEak76hRMMkXlox0rFFTY+0qxVkbERzOh/lxlLIXu/rIlbzXwzaO02+enDV
	YyVU5kZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j3gUX-00082j-MB; Mon, 17 Feb 2020 13:31:17 +0000
Date: Mon, 17 Feb 2020 05:31:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/6] dax,iomap,ext4,ext2,xfs: Save dax_offset in "struct
 iomap"
Message-ID: <20200217133117.GB20444@infradead.org>
References: <20200212170733.8092-1-vgoyal@redhat.com>
 <20200212170733.8092-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212170733.8092-3-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: FLVP3KPEJU2NUTTWBYKIPW2OTHQWEV3W
X-Message-ID-Hash: FLVP3KPEJU2NUTTWBYKIPW2OTHQWEV3W
X-MailFrom: BATV+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FLVP3KPEJU2NUTTWBYKIPW2OTHQWEV3W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 12, 2020 at 12:07:29PM -0500, Vivek Goyal wrote:
> Add a new field "sector_t dax_offset" to "struct iomap". This will be
> filled by filesystems and dax code will make use of this to convert
> sector into page offset (dax_pgoff()), instead of bdev_dax_pgoff(). This
> removes the dependency of having to pass in block device for dax operations.

NAK.  The iomap is not a structure to bolt random layering violation
onto.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDFE1326BA
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jan 2020 13:52:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18C0710097DFF;
	Tue,  7 Jan 2020 04:55:26 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+8fb6299afee2cb8bc501+5980+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D6F1110097DFC
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 04:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=2kBnL5gA8Hu2OCxhQ/ljIeIBv2eKrh+kqk+I83yZiPg=; b=ZWBdCh+xKxFQSUSue/qfzQHsj
	6T5S7vMsw+xLZ62ufe9Nw3VxsvMHHudJaF8KytEMMXsDhKtJIMWpsjy+CQ2AaJlNh+CZM7spuk1qi
	/GG/VNY7ofqvL8y2h70Tkp7c2xkCRxKZ1rFFxsF9ewZVdfm5fMyeHS7JZqUgbOIVcUM4enC/7CPfL
	YvahSVPFgA+tsvy8E7FsjcEDyCoXQ7NeHHA9vZPIY3RKwvTq97SGhEeSWoA7Sbe4ZJF+SklJGS433
	rfYX021bytGaEdqU7+9n2lMTY4eAmfRy/GoDNiu+qsLx1wh+rUf9RelcB0PwHzVtNjAEn/Sepic4P
	CyVpuzEdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iooL1-0005j8-N5; Tue, 07 Jan 2020 12:51:59 +0000
Date: Tue, 7 Jan 2020 04:51:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200107125159.GA15745@infradead.org>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org>
 <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com>
 <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191216181014.GA30106@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: EGRRXR3ZLGTHH4RM63RCTGUPNZM7HP4U
X-Message-ID-Hash: EGRRXR3ZLGTHH4RM63RCTGUPNZM7HP4U
X-MailFrom: BATV+8fb6299afee2cb8bc501+5980+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EGRRXR3ZLGTHH4RM63RCTGUPNZM7HP4U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > Agree. In retrospect it was my laziness in the dax-device
> > implementation to expect the block-device to be available.
> > 
> > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > dax_device could be dynamically created to represent the subset range
> > indicated by the block-device partition. That would open up more
> > cleanup opportunities.
> 
> Hi Dan,
> 
> After a long time I got time to look at it again. Want to work on this
> cleanup so that I can make progress with virtiofs DAX paches.
> 
> I am not sure I understand the requirements fully. I see that right now
> dax_device is created per device and all block partitions refer to it. If
> we want to create one dax_device per partition, then it looks like this
> will be structured more along the lines how block layer handles disk and
> partitions. (One gendisk for disk and block_devices for partitions,
> including partition 0). That probably means state belong to whole device
> will be in common structure say dax_device_common, and per partition state
> will be in dax_device and dax_device can carry a pointer to
> dax_device_common.
> 
> I am also not sure what does it mean to partition dax devices. How will
> partitions be exported to user space.

Dan, last time we talked you agreed that partitioned dax devices are
rather pointless IIRC.  Should we just deprecate partitions on DAX
devices and then remove them after a cycle or two?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

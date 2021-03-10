Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D12AF33404B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 15:26:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3C258100EB347;
	Wed, 10 Mar 2021 06:26:57 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E39CC100ED49E
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fMRcAUQViDFbKSMCzio+nZwR3R7d5z+5tJ4oYqUVAyM=; b=DX3yw+7jm8vk9+eflfEViPntiM
	iSRvWHzc9BxqlUmr+6/Vkm+qr6xjowBVUFsKtF0EEGRn5WNMMNKA79ysVFg64GdBFelo3aUDgyq7p
	cGt+Z/bf01+Wl4HA0Bk1VjCX/q3YZs3OAVLSWY3XSqWG2a7L34LbeaMH3hHvdwodIvUfKxym4i9l7
	umdcaXJUac96k4gdNzC2XXyI8murWFW7EfACp9WA3JFUGr+iogourTMBlCtmFEh7Uutlb6qXjRXlW
	vw2UZ/8FJ1hREoKp3KcvS6Z7hici2aTs/J5tJ6YKg1N8rongRZND9sgpPrZbkQDxKnX+sxE29HOrw
	9PoWbUvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lJznP-003gjI-VB; Wed, 10 Mar 2021 14:26:45 +0000
Date: Wed, 10 Mar 2021 14:26:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210310142643.GQ3479805@casper.infradead.org>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org>
 <20210310142159.kudk7q2ogp4yqn36@fiona>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310142159.kudk7q2ogp4yqn36@fiona>
Message-ID-Hash: KITLHWWEFOITYGQL3NSQU6R6WSC5XKB3
X-Message-ID-Hash: KITLHWWEFOITYGQL3NSQU6R6WSC5XKB3
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Neal Gompa <ngompa13@gmail.com>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, darrick.wong@oracle.com, jack@suse.cz, viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KITLHWWEFOITYGQL3NSQU6R6WSC5XKB3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 10, 2021 at 08:21:59AM -0600, Goldwyn Rodrigues wrote:
> On 13:02 10/03, Matthew Wilcox wrote:
> > On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> > > Forgive my ignorance, but is there a reason why this isn't wired up to
> > > Btrfs at the same time? It seems weird to me that adding a feature
> > 
> > btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX support.
> > 
> > If you think about it, btrfs and DAX are diametrically opposite things.
> > DAX is about giving raw access to the hardware.  btrfs is about offering
> > extra value (RAID, checksums, ...), none of which can be done if the
> > filesystem isn't in the read/write path.
> > 
> > That's why there's no DAX support in btrfs.  If you want DAX, you have
> > to give up all the features you like in btrfs.  So you may as well use
> > a different filesystem.
> 
> DAX on btrfs has been attempted[1]. Of course, we could not

But why?  A completeness fetish?  I don't understand why you decided
to do this work.

> have checksums or multi-device with it. However, got stuck on
> associating a shared extent on the same page mapping: basically the
> TODO above dax_associate_entry().
> 
> Shiyang has proposed a way to disassociate existing mapping, but I
> don't think that is the best solution. DAX for CoW will not work until
> we have a way of mapping a page to multiple inodes (page->mapping),
> which will convert a 1-N inode-page mapping to M-N inode-page mapping.

If you're still thinking in terms of pages, you're doing DAX wrong.
DAX should work without a struct page.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

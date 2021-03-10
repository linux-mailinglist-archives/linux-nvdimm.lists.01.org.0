Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A638C33449A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 18:04:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DEE2B100EB35C;
	Wed, 10 Mar 2021 09:04:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=rgoldwyn@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EADC6100EB35B
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 09:04:05 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 77CE3ABD7;
	Wed, 10 Mar 2021 17:04:04 +0000 (UTC)
Date: Wed, 10 Mar 2021 11:04:23 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210310170423.beagx4sowxpa25no@fiona>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org>
 <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310142643.GQ3479805@casper.infradead.org>
Message-ID-Hash: 4D326INQECKTIULH2BRC3ANQKHPIXD3I
X-Message-ID-Hash: 4D326INQECKTIULH2BRC3ANQKHPIXD3I
X-MailFrom: rgoldwyn@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Neal Gompa <ngompa13@gmail.com>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, darrick.wong@oracle.com, jack@suse.cz, viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4D326INQECKTIULH2BRC3ANQKHPIXD3I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14:26 10/03, Matthew Wilcox wrote:
> On Wed, Mar 10, 2021 at 08:21:59AM -0600, Goldwyn Rodrigues wrote:
> > On 13:02 10/03, Matthew Wilcox wrote:
> > > On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> > > > Forgive my ignorance, but is there a reason why this isn't wired up to
> > > > Btrfs at the same time? It seems weird to me that adding a feature
> > > 
> > > btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX support.
> > > 
> > > If you think about it, btrfs and DAX are diametrically opposite things.
> > > DAX is about giving raw access to the hardware.  btrfs is about offering
> > > extra value (RAID, checksums, ...), none of which can be done if the
> > > filesystem isn't in the read/write path.
> > > 
> > > That's why there's no DAX support in btrfs.  If you want DAX, you have
> > > to give up all the features you like in btrfs.  So you may as well use
> > > a different filesystem.
> > 
> > DAX on btrfs has been attempted[1]. Of course, we could not
> 
> But why?  A completeness fetish?  I don't understand why you decided
> to do this work.

If only I had a penny every time I heard "why would you want to do that?"

> 
> > have checksums or multi-device with it. However, got stuck on
> > associating a shared extent on the same page mapping: basically the
> > TODO above dax_associate_entry().
> > 
> > Shiyang has proposed a way to disassociate existing mapping, but I
> > don't think that is the best solution. DAX for CoW will not work until
> > we have a way of mapping a page to multiple inodes (page->mapping),
> > which will convert a 1-N inode-page mapping to M-N inode-page mapping.
> 
> If you're still thinking in terms of pages, you're doing DAX wrong.
> DAX should work without a struct page.

Not pages specifically, but mappings.
fsdax needs the mappings during the page fault and it breaks in case both
files fault on the same shared extent.

For Reference: WARN_ON_ONCE(page->mapping && page->mapping != mapping)
in dax_disassociate_entry().

-- 
Goldwyn
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

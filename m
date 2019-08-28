Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D43A0DCB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 00:53:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F6902021B704;
	Wed, 28 Aug 2019 15:55:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.246;
 helo=mail104.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au
 [211.29.132.246])
 by ml01.01.org (Postfix) with ESMTP id 04C1021A07A80
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 15:55:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au
 [49.181.255.194])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CA12A43CCB6;
 Thu, 29 Aug 2019 08:53:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1i36oc-000593-22; Thu, 29 Aug 2019 08:53:22 +1000
Date: Thu, 29 Aug 2019 08:53:22 +1000
From: Dave Chinner <david@fromorbit.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20190828225322.GA7777@dread.disaster.area>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org>
 <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190828175843.GB912@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
 a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
 a=7-415B0cAAAA:8 a=9z1Z1eSXHuCprvNSzKUA:9 a=1iKJgKlgsSbnEZhc:21
 a=ky3KFAHSX3wxvuwk:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: virtio-fs@redhat.com, linux-nvdimm@lists.01.org, miklos@szeredi.hu,
 linux-kernel@vger.kernel.org, dgilbert@redhat.com,
 Christoph Hellwig <hch@infradead.org>, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 28, 2019 at 01:58:43PM -0400, Vivek Goyal wrote:
> On Tue, Aug 27, 2019 at 11:58:09PM -0700, Christoph Hellwig wrote:
> > On Tue, Aug 27, 2019 at 12:38:28PM -0400, Vivek Goyal wrote:
> > > > For bdev_dax_pgoff
> > > > I'd much rather have the partition offset if there is on in the daxdev
> > > > somehow so that we can get rid of the block device entirely.
> > > 
> > > IIUC, there is one block_device per partition while there is only one
> > > dax_device for the whole disk. So we can't directly move bdev logical
> > > offset into dax_device.
> > 
> > Well, then we need to find a way to get partitions for dax devices,
> > as we really should not expect a block device hiding behind a dax
> > dev.  That is just a weird legacy assumption - block device need to
> > layer on top of the dax device optionally.
> > 
> > > 
> > > We probably could put this in "iomap" and leave it to filesystems to
> > > report offset into dax_dev in iomap that way dax generic code does not
> > > have to deal with it. But that probably will be a bigger change.
> > 
> > And where would the file system get that information from?
> 
> File system knows about block device, can it just call get_start_sect()
> while filling iomap->addr. And this means we don't have to have
> parition information in dax device. Will something like following work?
> (Just a proof of concept patch).
> 
> 
> ---
>  drivers/dax/super.c |   11 +++++++++++
>  fs/dax.c            |    6 +++---
>  fs/ext4/inode.c     |    6 +++++-
>  include/linux/dax.h |    1 +
>  4 files changed, 20 insertions(+), 4 deletions(-)
> 
> Index: rhvgoyal-linux/fs/ext4/inode.c
> ===================================================================
> --- rhvgoyal-linux.orig/fs/ext4/inode.c	2019-08-28 13:51:16.051937204 -0400
> +++ rhvgoyal-linux/fs/ext4/inode.c	2019-08-28 13:51:44.453937204 -0400
> @@ -3589,7 +3589,11 @@ retry:
>  			WARN_ON_ONCE(1);
>  			return -EIO;
>  		}
> -		iomap->addr = (u64)map.m_pblk << blkbits;
> +		if (IS_DAX(inode))
> +			iomap->addr = ((u64)map.m_pblk << blkbits) +
> +				      (get_start_sect(iomap->bdev) * 512);
> +		else
> +			iomap->addr = (u64)map.m_pblk << blkbits;

I'm not a fan of returning a physical device sector address from an
interface where ever other user/caller expects this address to be a
logical block address into the block device. It creates a landmine
in the iomap API that callers may not be aware of and that's going
to cause bugs. We're trying really hard to keep special case hacks
like this out of the iomap infrastructure, so on those grounds alone
I'd suggest this is a dead end approach.

Hence I think that if the dax device needs a physical offset from
the start of the block device the filesystem sits on, it should be
set up at dax device instantiation time and so the filesystem/bdev
never needs to be queried again for this information.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF9F9F058
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Aug 2019 18:38:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A8FE20216B7E;
	Tue, 27 Aug 2019 09:40:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 20A082020D339
 for <linux-nvdimm@lists.01.org>; Tue, 27 Aug 2019 09:40:43 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F11E3082E55;
 Tue, 27 Aug 2019 16:38:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 087345D70D;
 Tue, 27 Aug 2019 16:38:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 9207122017B; Tue, 27 Aug 2019 12:38:28 -0400 (EDT)
Date: Tue, 27 Aug 2019 12:38:28 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20190827163828.GA6859@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190826115152.GA21051@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 27 Aug 2019 16:38:34 +0000 (UTC)
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
Cc: miklos@szeredi.hu, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 dgilbert@redhat.com, virtio-fs@redhat.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 26, 2019 at 04:51:52AM -0700, Christoph Hellwig wrote:
> On Wed, Aug 21, 2019 at 01:57:02PM -0400, Vivek Goyal wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Although struct dax_device itself is not tied to a block device, some
> > DAX code assumes there is a block device.  Make block devices optional
> > by allowing bdev to be NULL in commonly used DAX APIs.
> > 
> > When there is no block device:
> >  * Skip the partition offset calculation in bdev_dax_pgoff()
> >  * Skip the blkdev_issue_zeroout() optimization
> > 
> > Note that more block device assumptions remain but I haven't reach those
> > code paths yet.
> 
> I think this should be split into two patches.

Hi Christoph,

Ok, will split in two patches. In fact, I think will completley drop
the second change right now as I think we might not be hitting that
path yet.

> For bdev_dax_pgoff
> I'd much rather have the partition offset if there is on in the daxdev
> somehow so that we can get rid of the block device entirely.

IIUC, there is one block_device per partition while there is only one
dax_device for the whole disk. So we can't directly move bdev logical
offset into dax_device.

We probably could put this in "iomap" and leave it to filesystems to
report offset into dax_dev in iomap that way dax generic code does not
have to deal with it. But that probably will be a bigger change.

Did I misunderstand your suggestion.

> 
> Similarly for dax_range_is_aligned I'd rather have a pure dax way
> to offload zeroing rather than this bdev hack.

Following commig introduced the change to write zeros through block
device path.

commit 4b0228fa1d753f77fe0e6cf4c41398ec77dfbd2a
Author: Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu Apr 21 15:13:46 2016 -0400

 dax: for truncate/hole-punch, do zeroing through the driver if possible

IIUC, they are doing it so that they can clear gendisk->badblocks list.

So even if there is pure dax way to do it, there will have to some
involvment of block layer to clear gendisk->badblocks list.

I am not sure I fully understand your suggestion. But I am hoping its
not a must for these changes to make a progress. For now, I will drop
change to dax_range_is_aligned().

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

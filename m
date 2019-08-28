Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC06C9FAF0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 08:58:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A683D20218C4D;
	Wed, 28 Aug 2019 00:00:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+49d2e20b56fbda768dd7+5848+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DCBEE20212CBD
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gHAYFZOmvRYM0q5YzZ/Rq3ghbsnPUKY97o37njE3F0A=; b=hAWJjeHx+hNMC5YoNxadSMBM3
 sdDqJJjTWleRyRhEJ7ePzLuc7msw6ISoYkvFXw80WuNWQXbJCeCYxKh223xdAAJWTqlcRja1Eumpg
 JVwQxwDaSQh/o95aGDdFq1VXJauhtsNrV/atCrIpyq1pQkBhinB5oR2cX39Y+bBhRioWq3pStDmk7
 RE1gB4b2FrlPJdCIWkB5+XiuQmTdQOrpHqNveR9/Gp+Pg8r5grdJpKAetwfYWyhpSr6C8uhP3t9kg
 0nnkg/kNnDtLWsbLSCxKYiaHKJd2OQZaSKtPpZMCzcUnTYRgYKCF0U3E8gYsJMpXNNheXI+3lBUZ6
 bdoRCMpKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i2ruD-0007S7-4i; Wed, 28 Aug 2019 06:58:09 +0000
Date: Tue, 27 Aug 2019 23:58:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20190828065809.GA27426@infradead.org>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org>
 <20190827163828.GA6859@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190827163828.GA6859@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

On Tue, Aug 27, 2019 at 12:38:28PM -0400, Vivek Goyal wrote:
> > For bdev_dax_pgoff
> > I'd much rather have the partition offset if there is on in the daxdev
> > somehow so that we can get rid of the block device entirely.
> 
> IIUC, there is one block_device per partition while there is only one
> dax_device for the whole disk. So we can't directly move bdev logical
> offset into dax_device.

Well, then we need to find a way to get partitions for dax devices,
as we really should not expect a block device hiding behind a dax
dev.  That is just a weird legacy assumption - block device need to
layer on top of the dax device optionally.

> 
> We probably could put this in "iomap" and leave it to filesystems to
> report offset into dax_dev in iomap that way dax generic code does not
> have to deal with it. But that probably will be a bigger change.

And where would the file system get that information from?

> commit 4b0228fa1d753f77fe0e6cf4c41398ec77dfbd2a
> Author: Vishal Verma <vishal.l.verma@intel.com>
> Date:   Thu Apr 21 15:13:46 2016 -0400
> 
>  dax: for truncate/hole-punch, do zeroing through the driver if possible
> 
> IIUC, they are doing it so that they can clear gendisk->badblocks list.
> 
> So even if there is pure dax way to do it, there will have to some
> involvment of block layer to clear gendisk->badblocks list.

Once again we need to move that list to the dax device, as the
assumption that there is a block device associated with the dax dev
is flawed.

> I am not sure I fully understand your suggestion. But I am hoping its
> not a must for these changes to make a progress. For now, I will drop
> change to dax_range_is_aligned().

Well, someone needs to clean this mess up, and as you have an actual
real life example of a dax dev without the block device I think the
burden naturally falls on you.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

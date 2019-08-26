Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B12369CE96
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Aug 2019 13:51:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2247620212CB1;
	Mon, 26 Aug 2019 04:54:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+64c9f4a429f346f2dac5+5846+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B5E692020D33A
 for <linux-nvdimm@lists.01.org>; Mon, 26 Aug 2019 04:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1TviH4OE9g0ePmo1qrMkYXUOeKWbt5qrTfsr6aQ4WxU=; b=O5LzO9tgN9SeWoWyNekXsB84f
 z4Ph/BrpqE+paC2R4jl2cl2TzLbtp+2yxI/fOw+MeqKPMnQK4QJX02locG6ZNxYahWDmjweD6nnpg
 nva5LPAg0YFTr0PZea8YcP/FFVV1VzDZD6JvgezWruy98VHRS+ZkdjTBpAK3iq45ziNpZGN+BQfyS
 aQYxVxYIk/0VrRqweGa/QpVtUNU4zCDyPzo8JtaUeYsE38Q/BoMXY9yLOwEoeGoA+o4oHh7VfCKDf
 kZKrL8CCks1psw19Ta4SajwqsffaKQBtg+wngaRH25bXkw9vP0oY6UM4WHCmXkT7MQvhJ118VjupW
 hmWIo3Yzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i2DXM-0007qP-IW; Mon, 26 Aug 2019 11:51:52 +0000
Date: Mon, 26 Aug 2019 04:51:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20190826115152.GA21051@infradead.org>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190821175720.25901-2-vgoyal@redhat.com>
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
Cc: miklos@szeredi.hu, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 dgilbert@redhat.com, virtio-fs@redhat.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 21, 2019 at 01:57:02PM -0400, Vivek Goyal wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Although struct dax_device itself is not tied to a block device, some
> DAX code assumes there is a block device.  Make block devices optional
> by allowing bdev to be NULL in commonly used DAX APIs.
> 
> When there is no block device:
>  * Skip the partition offset calculation in bdev_dax_pgoff()
>  * Skip the blkdev_issue_zeroout() optimization
> 
> Note that more block device assumptions remain but I haven't reach those
> code paths yet.

I think this should be split into two patches.  For bdev_dax_pgoff
I'd much rather have the partition offset if there is on in the daxdev
somehow so that we can get rid of the block device entirely.

Similarly for dax_range_is_aligned I'd rather have a pure dax way
to offload zeroing rather than this bdev hack.

In the long run I'd really like to make the bdev vs daxdev in iomap a
union instead of having to carry both around.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

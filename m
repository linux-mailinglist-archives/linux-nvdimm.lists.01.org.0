Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A909CE9C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Aug 2019 13:53:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E93A20213F22;
	Mon, 26 Aug 2019 04:55:36 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 899F72020D33A
 for <linux-nvdimm@lists.01.org>; Mon, 26 Aug 2019 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lZnBdyi3U2JinlfRXPGTK6Ot4IAtObs74Nrk19Et59I=; b=h4nljASh9KzABQmHDW5KPiI5y
 rYfaQ9ckmtTLidzXqdVCp0kF98xjf4iYIvzChMQ+kZPX5dFnceTCsbzUIUgXzefxzhTIey+QON6E3
 HdKAyQOYx2zGew4MWxorz2O/U4UXjDKU8vLrNzb/YCEO23oqRpsSvaQ+xzPFCXiGigwnO51UQU8Ng
 c2nipNf141NY7vJYW1pgnwmI3CJ2N2UQXsUkB8/CWGoqHPEmwsC99YcpjCUNrRkng2qqYkxwezrRV
 bdEm2DiIK+AbKnMruJeHndTGfb4h0UTWaRATbqcGJPhWonnBXPiaTIWTzgA5TCnXYX7nZzgLDuvGR
 A5CXgO69w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i2DYi-0008I5-1i; Mon, 26 Aug 2019 11:53:16 +0000
Date: Mon, 26 Aug 2019 04:53:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
Message-ID: <20190826115316.GB21051@infradead.org>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190821175720.25901-3-vgoyal@redhat.com>
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

On Wed, Aug 21, 2019 at 01:57:03PM -0400, Vivek Goyal wrote:
> Right now dax_writeback_mapping_range() is passed a bdev and dax_dev
> is searched from that bdev name.
> 
> virtio-fs does not have a bdev. So pass in dax_dev also to
> dax_writeback_mapping_range(). If dax_dev is passed in, bdev is not
> used otherwise dax_dev is searched using bdev.

Please just pass in only the dax_device and get rid of the block device.
The callers should have one at hand easily, e.g. for XFS just call
xfs_find_daxdev_for_inode instead of xfs_find_bdev_for_inode.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

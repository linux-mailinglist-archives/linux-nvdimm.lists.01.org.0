Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C09FA1503
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 11:32:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 353172021B71C;
	Thu, 29 Aug 2019 02:34:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+c7f673d4bdabd04d2ac5+5849+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E1E592021B700
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jXWv6rxcD/Ytdxuw9oCBSvjHqSotwy8H8FiFgT6NRRg=; b=eNdor4/fygoZH6Xvs2bMeOvXp
 tLJNYDfk1cimf7+kbTn2BtXDWxLqRI4BEoxvkM59QMQwbcBMvCELCNq/zJkLCXbTBzuB4qK60s7R/
 haWdRVRaEqnJlYuCV4UwO8CFnpN8keiifEYRocm9hSV7hdJbuhyANoVbu4fvGSZZTtQWctl+4PkEQ
 /oN+phe7MFMf78kAF3jl7VDQ4vwdv93FRJN87qRsxSrA+o2vNKwsWkTPjLWfJ6jdO987prP1KZI6Z
 19zNadIV1LWue77KVSIM1O13lgtmraWBA1EkdjuK6SDKTpSqH94t7Ag5Ad+KKj2s3isfBEvJQ6hgD
 xAZ0rNRsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i3GnG-0007NX-Pm; Thu, 29 Aug 2019 09:32:38 +0000
Date: Thu, 29 Aug 2019 02:32:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20190829093238.GA23102@infradead.org>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org>
 <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com>
 <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
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
Cc: virtio-fs@redhat.com, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Dave Chinner <david@fromorbit.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Christoph Hellwig <hch@infradead.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 28, 2019 at 05:04:11PM -0700, Dan Williams wrote:
> Agree. In retrospect it was my laziness in the dax-device
> implementation to expect the block-device to be available.
> 
> It looks like fs_dax_get_by_bdev() is an intercept point where a
> dax_device could be dynamically created to represent the subset range
> indicated by the block-device partition. That would open up more
> cleanup opportunities.

That seems like a decent short-term plan.  But in the long I'd just let
dax call into the partition table parser directly, as we might want to
support partitions without first having to create a block device on top
of the dax device.  Same for the badblocks handling story.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

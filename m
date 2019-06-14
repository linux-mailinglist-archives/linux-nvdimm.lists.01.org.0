Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73571454DC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 08:39:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0D79D2129DB87;
	Thu, 13 Jun 2019 23:39:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 81ACE2129707B
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 23:39:55 -0700 (PDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id D92E768B02; Fri, 14 Jun 2019 08:39:26 +0200 (CEST)
Date: Fri, 14 Jun 2019 08:39:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 17/22] mm: remove hmm_devmem_add
Message-ID: <20190614063926.GL7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-18-hch@lst.de> <20190613194239.GX22062@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190613194239.GX22062@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 07:42:43PM +0000, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 11:43:20AM +0200, Christoph Hellwig wrote:
> > There isn't really much value add in the hmm_devmem_add wrapper.  Just
> > factor out a little helper to find the resource, and otherwise let the
> > driver implement the dev_pagemap_ops directly.
> 
> Was this commit message written when other patches were squashed in
> here? I think the helper this mentions was from an earlier patch

Yes, it was written before a lot of bits were split out.  I've updated
it for the next version.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

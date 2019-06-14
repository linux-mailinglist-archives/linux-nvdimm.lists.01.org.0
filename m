Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E14549B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 08:20:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D436421297079;
	Thu, 13 Jun 2019 23:20:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EE7F421297071
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 23:20:14 -0700 (PDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 4C76A68B02; Fri, 14 Jun 2019 08:19:46 +0200 (CEST)
Date: Fri, 14 Jun 2019 08:19:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 03/22] mm: remove hmm_devmem_add_resource
Message-ID: <20190614061946.GE7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-4-hch@lst.de> <20190613185239.GP22062@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190613185239.GP22062@mellanox.com>
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

On Thu, Jun 13, 2019 at 06:52:44PM +0000, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 11:43:06AM +0200, Christoph Hellwig wrote:
> > This function has never been used since it was first added to the kernel
> > more than a year and a half ago, and if we ever grow a consumer of the
> > MEMORY_DEVICE_PUBLIC infrastructure it can easily use devm_memremap_pages
> > directly now that we've simplified the API for it.
> 
> nit: Have we simplified the interface for devm_memremap_pages() at
> this point, or are you talking about later patches in this series.

After this series.  I've just droped that part of the sentence to
avoid confusion.

> I checked this and all the called functions are exported symbols, so
> there is no blocker for a future driver to call devm_memremap_pages(),
> maybe even with all this boiler plate, in future.
> 
> If we eventually get many users that need some simplified registration
> then we should add a devm_memremap_pages_simplified() interface and
> factor out that code when we can see the pattern.

After this series devm_memremap_pages already is simpler to use than
hmm_device_add_resource was before, so I'm not worried at all.  The
series actually net removes lines from noveau (if only a few).
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

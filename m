Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9952857EB5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 10:52:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 48872212AAB64;
	Thu, 27 Jun 2019 01:52:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4965D2129F0E1
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 01:52:07 -0700 (PDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id B4FDB68B20; Thu, 27 Jun 2019 10:51:35 +0200 (CEST)
Date: Thu, 27 Jun 2019 10:51:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 15/25] memremap: provide an optional internal refcount
 in struct dev_pagemap
Message-ID: <20190627085135.GB11420@lst.de>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-16-hch@lst.de>
 <20190626214750.GC8399@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190626214750.GC8399@iweiny-DESK2.sc.intel.com>
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
Cc: linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 nouveau@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 26, 2019 at 02:47:50PM -0700, Ira Weiny wrote:
> > +
> > +		init_completion(&pgmap->done);
> > +		error = percpu_ref_init(&pgmap->internal_ref,
> > +				dev_pagemap_percpu_release, 0, GFP_KERNEL);
> > +		if (error)
> > +			return ERR_PTR(error);
> > +		pgmap->ref = &pgmap->internal_ref;
> > +	} else {
> > +		if (!pgmap->ops || !pgmap->ops->kill || !pgmap->ops->cleanup) {
> > +			WARN(1, "Missing reference count teardown definition\n");
> > +			return ERR_PTR(-EINVAL);
> > +		}
> 
> After this series are there any users who continue to supply their own
> reference object and these callbacks?

Yes, fsdax uses the block layer request_queue reference count.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

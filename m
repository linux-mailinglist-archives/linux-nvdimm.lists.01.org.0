Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB49B5EB0F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 20:03:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3E46D212ACECA;
	Wed,  3 Jul 2019 11:03:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5812A21290D41
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 11:03:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5C41168B05; Wed,  3 Jul 2019 20:03:08 +0200 (CEST)
Date: Wed, 3 Jul 2019 20:03:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 22/22] mm: remove the legacy hmm_pfn_* APIs
Message-ID: <20190703180308.GA13656@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
 <20190701062020.19239-23-hch@lst.de> <20190703180125.GA18673@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190703180125.GA18673@ziepe.ca>
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
Cc: linux-nvdimm@lists.01.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 03, 2019 at 03:01:25PM -0300, Jason Gunthorpe wrote:
> Christoph, I guess you didn't mean to send this branch to the mailing
> list?
> 
> In any event some of these, like this one, look obvious and I could
> still grab a few for hmm.git.
> 
> Let me know what you'd like please
> 
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks.  I was going to send this series out as soon as you had
applied the previous one.  Now that it leaked I'm happy to collect
reviews.  But while I've got your attention:  the rdma.git hmm
branch is still at the -rc7 merge and doen't have my series, is that
intentional?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

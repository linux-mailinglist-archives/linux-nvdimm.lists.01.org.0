Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084D8CBAA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Aug 2019 08:12:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C209202EDB87;
	Tue, 13 Aug 2019 23:14:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 76DB1202EC07B
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 23:14:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 20CAC68B02; Wed, 14 Aug 2019 08:11:51 +0200 (CEST)
Date: Wed, 14 Aug 2019 08:11:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH 5/5] memremap: provide a not device managed memremap_pages
Message-ID: <20190814061150.GA24835@lst.de>
References: <20190811081247.22111-1-hch@lst.de>
 <20190811081247.22111-6-hch@lst.de> <20190812145058.GA16950@in.ibm.com>
 <20190812150012.GA12700@lst.de> <20190813045611.GB16950@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190813045611.GB16950@in.ibm.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 13, 2019 at 10:26:11AM +0530, Bharata B Rao wrote:
> Yes, this patchset works non-modular and with kvm-hv as module, it
> works with devm_memremap_pages_release() and release_mem_region() in the
> cleanup path. The cleanup path will be required in the non-modular
> case too for proper recovery from failures.

Can you check if the version here:

    git://git.infradead.org/users/hch/misc.git pgmap-remove-dev

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pgmap-remove-dev

works for you fully before I resend?

> 
> Regards,
> Bharata.
---end quoted text---
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC2901B7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Aug 2019 14:36:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C557B202E2907;
	Fri, 16 Aug 2019 05:38:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7CD8320294F31
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 05:38:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8145268B05; Fri, 16 Aug 2019 14:36:07 +0200 (CEST)
Date: Fri, 16 Aug 2019 14:36:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: add a not device managed memremap_pages v2
Message-ID: <20190816123607.GA22681@lst.de>
References: <20190816065434.2129-1-hch@lst.de>
 <20190816123356.GE5412@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190816123356.GE5412@mellanox.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bharata B Rao <bharata@linux.ibm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> > Changes since v1:
> >  - don't overload devm_request_free_mem_region
> >  - export the memremap_pages and munmap_pages as kvmppc can be a module
> 
> What tree do we want this to go through? Dan are you running a pgmap
> tree still? Do we know of any conflicts?

The last changes in this area went through the hmm tree.  There are
now known conflicts, and the kvmppc drivers that needs this already
has a dependency on the hmm tree for the migrate_vma_* changes.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

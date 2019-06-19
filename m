Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E04B6FB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 13:23:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CAE5E21962301;
	Wed, 19 Jun 2019 04:23:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5A36821962301
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 04:23:33 -0700 (PDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 9FA61227A81; Wed, 19 Jun 2019 13:23:02 +0200 (CEST)
Date: Wed, 19 Jun 2019 13:23:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm: Enable unit test infrastructure compile checks
Message-ID: <20190619112302.GA10534@lst.de>
References: <156080474760.3765313.13075804303259765566.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <156080474760.3765313.13075804303259765566.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: linux-kernel@vger.kernel.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 17, 2019 at 01:52:27PM -0700, Dan Williams wrote:
> The infrastructure to mock core libnvdimm routines for unit testing
> purposes is prone to bitrot relative to refactoring of that core.
> Arrange for the unit test core to be built when CONFIG_COMPILE_TEST=y.
> This does not result in a functional unit test environment, it is only a
> helper for 0day to catch unit test build regressions.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I'm still curious what the point of hiding kernel code in tools/
is vs fully integrating it with the build system.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

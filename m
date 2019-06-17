Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B4F48A82
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 19:40:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4022521297059;
	Mon, 17 Jun 2019 10:40:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DE54A21296049
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 10:40:48 -0700 (PDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id AA7D667358; Mon, 17 Jun 2019 19:40:18 +0200 (CEST)
Date: Mon, 17 Jun 2019 19:40:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 06/25] mm: factor out a devm_request_free_mem_region helper
Message-ID: <20190617174018.GA18185@lst.de>
References: <20190617122733.22432-1-hch@lst.de>
 <20190617122733.22432-7-hch@lst.de>
 <CAPcyv4hoRR6gzTSkWnwMiUtX6jCKz2NMOhCUfXTji8f2H1v+rg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4hoRR6gzTSkWnwMiUtX6jCKz2NMOhCUfXTji8f2H1v+rg@mail.gmail.com>
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
Cc: John Hubbard <jhubbard@nvidia.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 17, 2019 at 10:37:12AM -0700, Dan Williams wrote:
> > +struct resource *devm_request_free_mem_region(struct device *dev,
> > +               struct resource *base, unsigned long size);
> 
> This appears to need a 'static inline' helper stub in the
> CONFIG_DEVICE_PRIVATE=n case, otherwise this compile error triggers:
> 
> ld: mm/hmm.o: in function `hmm_devmem_add':
> /home/dwillia2/git/linux/mm/hmm.c:1427: undefined reference to
> `devm_request_free_mem_region'

*sigh* - hmm_devmem_add already only works for device private memory,
so it shouldn't be built if that option is not enabled, but in the
current code it is.  And a few patches later in the series we just
kill it off entirely, and the only real caller of this function
already depends on CONFIG_DEVICE_PRIVATE.  So I'm tempted to just
ignore the strict bisectability requirement here instead of making
things messy by either adding the proper ifdefs in hmm.c or providing
a stub we don't really need.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

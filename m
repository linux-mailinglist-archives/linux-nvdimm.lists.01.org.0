Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 656A2454F6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 08:47:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5FEB2129DB8C;
	Thu, 13 Jun 2019 23:47:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 78EB52194D387
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 23:47:45 -0700 (PDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id CC60468B02; Fri, 14 Jun 2019 08:47:16 +0200 (CEST)
Date: Fri, 14 Jun 2019 08:47:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 21/22] mm: remove the HMM config option
Message-ID: <20190614064716.GN7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-22-hch@lst.de> <20190613200150.GB22062@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190613200150.GB22062@mellanox.com>
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

On Thu, Jun 13, 2019 at 08:01:55PM +0000, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 11:43:24AM +0200, Christoph Hellwig wrote:
> > All the mm/hmm.c code is better keyed off HMM_MIRROR.  Also let nouveau
> > depend on it instead of the mix of a dummy dependency symbol plus the
> > actually selected one.  Drop various odd dependencies, as the code is
> > pretty portable.
> 
> I don't really know, but I thought this needed the arch restriction
> for the same reason get_user_pages has various unique arch specific
> implementations (it does seem to have some open coded GUP like thing)?
> 
> I was hoping we could do this after your common gup series? But sooner
> is better too.

Ok, I've added the arch and 64-bit dependency back in for now.  It does
not look proper to me, and is certainly underdocumented, but the whole
pagetable walking code will need a lot of love eventually anyway, and
the Kconfig stuff for it can be done properly then.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

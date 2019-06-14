Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24BB45485
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 08:13:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF43621297075;
	Thu, 13 Jun 2019 23:13:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6B71921296B2A
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 23:13:16 -0700 (PDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 0B9D068B02; Fri, 14 Jun 2019 08:12:48 +0200 (CEST)
Date: Fri, 14 Jun 2019 08:12:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: dev_pagemap related cleanups
Message-ID: <20190614061247.GB7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613141622.GE22062@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190613141622.GE22062@mellanox.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 02:16:27PM +0000, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 11:43:03AM +0200, Christoph Hellwig wrote:
> > Hi Dan, J=E9r=F4me and Jason,
> > =

> > below is a series that cleans up the dev_pagemap interface so that
> > it is more easily usable, which removes the need to wrap it in hmm
> > and thus allowing to kill a lot of code
> =

> Do you want some of this to run through hmm.git? I see many patches
> that don't seem to have inter-dependencies..

I think running it through hmm.git makes sense.  While there are not
actual functional dependency and just a few cosmetic conflicts keeping
the hmm stuff together makes a lot of sense.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

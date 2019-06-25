Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0B54E16
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Jun 2019 13:59:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 759DC2129F0F7;
	Tue, 25 Jun 2019 04:59:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=213.95.11.211;
 helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5A6DD2194EB77
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 04:59:53 -0700 (PDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id D3FF468B05; Tue, 25 Jun 2019 13:59:21 +0200 (CEST)
Date: Tue, 25 Jun 2019 13:59:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Message-ID: <20190625115921.GA3874@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de> <20190620192648.GI12083@dhcp22.suse.cz>
 <20190625072915.GD30350@lst.de> <20190625114422.GA3118@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190625114422.GA3118@mellanox.com>
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
 Michal Hocko <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jun 25, 2019 at 11:44:28AM +0000, Jason Gunthorpe wrote:
> Which tree and what does the resolution look like?

Looks like in -mm.  The current commit in linux-next is:

commit 0d23b042f26955fb35721817beb98ba7f1d9ed9f
Author: Robin Murphy <robin.murphy@arm.com>
Date:   Fri Jun 14 10:42:14 2019 +1000

    mm: clean up is_device_*_page() definitions


> Also, I don't want to be making the decision if we should keep/remove
> DEVICE_PUBLIC, so let's get an Ack from Andrew/etc?
> 
> My main reluctance is that I know there is HW out there that can do
> coherent, and I want to believe they are coming with patches, just
> too slowly. But I'd also rather those people defend themselves :P

Lets keep everything as-is for now.  I'm pretty certain nothing
will show up, but letting this linger another release or two
shouldn't be much of a problem.  And if we urgently feel like removing
it we can do it after -rc1.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

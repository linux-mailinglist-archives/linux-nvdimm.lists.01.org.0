Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C0A561D0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 07:46:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3EADF212A36FA;
	Tue, 25 Jun 2019 22:45:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Softfail (domain owner discourages use of this host)
 identity=mailfrom; client-ip=195.135.220.15; helo=mx1.suse.de;
 envelope-from=mhocko@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6AC43212A36F5
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 22:45:57 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A851EAF25;
 Wed, 26 Jun 2019 05:45:55 +0000 (UTC)
Date: Wed, 26 Jun 2019 07:45:54 +0200
From: Michal Hocko <mhocko@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Message-ID: <20190626054554.GA17798@dhcp22.suse.cz>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de>
 <20190613194430.GY22062@mellanox.com>
 <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
 <20190613195819.GA22062@mellanox.com>
 <20190614004314.GD783@iweiny-DESK2.sc.intel.com>
 <d2b77ea1-7b27-e37d-c248-267a57441374@nvidia.com>
 <20190619192719.GO9374@mellanox.com>
 <29f43c79-b454-0477-a799-7850e6571bd3@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <29f43c79-b454-0477-a799-7850e6571bd3@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Ralph Campbell <rcampbell@nvidia.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue 25-06-19 20:15:28, John Hubbard wrote:
> On 6/19/19 12:27 PM, Jason Gunthorpe wrote:
> > On Thu, Jun 13, 2019 at 06:23:04PM -0700, John Hubbard wrote:
> >> On 6/13/19 5:43 PM, Ira Weiny wrote:
> >>> On Thu, Jun 13, 2019 at 07:58:29PM +0000, Jason Gunthorpe wrote:
> >>>> On Thu, Jun 13, 2019 at 12:53:02PM -0700, Ralph Campbell wrote:
> >>>>>
> >> ...
> >>> So I think it is ok.  Frankly I was wondering if we should remove the public
> >>> type altogether but conceptually it seems ok.  But I don't see any users of it
> >>> so...  should we get rid of it in the code rather than turning the config off?
> >>>
> >>> Ira
> >>
> >> That seems reasonable. I recall that the hope was for those IBM Power 9
> >> systems to use _PUBLIC, as they have hardware-based coherent device (GPU)
> >> memory, and so the memory really is visible to the CPU. And the IBM team
> >> was thinking of taking advantage of it. But I haven't seen anything on
> >> that front for a while.
> > 
> > Does anyone know who those people are and can we encourage them to
> > send some patches? :)
> > 
> 
> I asked about this, and it seems that the idea was: DEVICE_PUBLIC was there
> in order to provide an alternative way to do things (such as migrate memory
> to and from a device), in case the combination of existing and near-future
> NUMA APIs was insufficient. This probably came as a follow-up to the early
> 2017-ish conversations about NUMA, in which the linux-mm recommendation was
> "try using HMM mechanisms, and if those are inadequate, then maybe we can
> look at enhancing NUMA so that it has better handling of advanced (GPU-like)
> devices".

Yes that was the original idea. It sounds so much better to use a common
framework rather than awkward special cased cpuless NUMA nodes with
a weird semantic. User of the neither of the two has shown up so I guess
that the envisioned HW just didn't materialized. Or has there been a
completely different approach chosen?

> In the end, however, _PUBLIC was never used, nor does anyone in the local
> (NVIDIA + IBM) kernel vicinity seem to have plans to use it.  So it really
> does seem safe to remove, although of course it's good to start with 
> BROKEN and see if anyone pops up and complains.

Well, I do not really see much of a difference. Preserving an unused
code which doesn't have any user in sight just adds a maintenance burden
whether the code depends on BROKEN or not. We can always revert patches
which remove the code once a real user shows up.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

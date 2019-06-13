Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D8D44DC3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 22:48:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BDFC621296715;
	Thu, 13 Jun 2019 13:48:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=akpm@linux-foundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4FE4A21296705
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 13:48:33 -0700 (PDT)
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8B3942133D;
 Thu, 13 Jun 2019 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1560458913;
 bh=QBKFiYL+IE6QfIxDxWONJrMHcfZVbZUqMyER/iI/i+c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=W8RFMGE2XEBfIMgZiJVLDJlgDCfrRRk8a5YMGm6NJWq3iOW7BFqDgEcE3jR3EzuxH
 6mecnfow3Qth0X+c0FNOd8EU7Tgs7NtIzjtvm3fET+fi8GtnZHvccohCORja+Kjvbx
 qMyCzCY6jdHR6rPl/G9MUU/Sgsma/isYN3+x1ZvE=
Date: Thu, 13 Jun 2019 13:48:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: dev_pagemap related cleanups
Message-Id: <20190613134831.a7ecb1b422a732bff156ec50@linux-foundation.org>
In-Reply-To: <d0da4c86-ef52-b981-06af-b37e3e0515ee@deltatee.com>
References: <20190613094326.24093-1-hch@lst.de>
 <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <283e87e8-20b6-0505-a19b-5d18e057f008@deltatee.com>
 <CAPcyv4hx=ng3SxzAWd8s_8VtAfoiiWhiA5kodi9KPc=jGmnejg@mail.gmail.com>
 <d0da4c86-ef52-b981-06af-b37e3e0515ee@deltatee.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 13 Jun 2019 14:24:20 -0600 Logan Gunthorpe <logang@deltatee.com> wr=
ote:

> =

> =

> On 2019-06-13 2:21 p.m., Dan Williams wrote:
> > On Thu, Jun 13, 2019 at 1:18 PM Logan Gunthorpe <logang@deltatee.com> w=
rote:
> >>
> >>
> >>
> >> On 2019-06-13 12:27 p.m., Dan Williams wrote:
> >>> On Thu, Jun 13, 2019 at 2:43 AM Christoph Hellwig <hch@lst.de> wrote:
> >>>>
> >>>> Hi Dan, J=E9r=F4me and Jason,
> >>>>
> >>>> below is a series that cleans up the dev_pagemap interface so that
> >>>> it is more easily usable, which removes the need to wrap it in hmm
> >>>> and thus allowing to kill a lot of code
> >>>>
> >>>> Diffstat:
> >>>>
> >>>>  22 files changed, 245 insertions(+), 802 deletions(-)
> >>>
> >>> Hooray!
> >>>
> >>>> Git tree:
> >>>>
> >>>>     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup
> >>>
> >>> I just realized this collides with the dev_pagemap release rework in
> >>> Andrew's tree (commit ids below are from next.git and are not stable)
> >>>
> >>> 4422ee8476f0 mm/devm_memremap_pages: fix final page put race
> >>> 771f0714d0dc PCI/P2PDMA: track pgmap references per resource, not glo=
bally
> >>> af37085de906 lib/genalloc: introduce chunk owners
> >>> e0047ff8aa77 PCI/P2PDMA: fix the gen_pool_add_virt() failure path
> >>> 0315d47d6ae9 mm/devm_memremap_pages: introduce devm_memunmap_pages
> >>> 216475c7eaa8 drivers/base/devres: introduce devm_release_action()
> >>>
> >>> CONFLICT (content): Merge conflict in tools/testing/nvdimm/test/iomap=
.c
> >>> CONFLICT (content): Merge conflict in mm/hmm.c
> >>> CONFLICT (content): Merge conflict in kernel/memremap.c
> >>> CONFLICT (content): Merge conflict in include/linux/memremap.h
> >>> CONFLICT (content): Merge conflict in drivers/pci/p2pdma.c
> >>> CONFLICT (content): Merge conflict in drivers/nvdimm/pmem.c
> >>> CONFLICT (content): Merge conflict in drivers/dax/device.c
> >>> CONFLICT (content): Merge conflict in drivers/dax/dax-private.h
> >>>
> >>> Perhaps we should pull those out and resend them through hmm.git?
> >>
> >> Hmm, I've been waiting for those patches to get in for a little while =
now ;(
> > =

> > Unless Andrew was going to submit as v5.2-rc fixes I think I should
> > rebase / submit them on current hmm.git and then throw these cleanups
> > from Christoph on top?
> =

> Whatever you feel is best. I'm just hoping they get in sooner rather
> than later. They do fix a bug after all. Let me know if you want me to
> retest the P2PDMA stuff after the rebase.

I had them down for 5.3-rc1.  I'll send them along for 5.2-rc5 instead.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

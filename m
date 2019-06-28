Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 438825A1EC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 19:08:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA09E212AB4F4;
	Fri, 28 Jun 2019 10:08:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 96B8C212AB4DE
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 10:08:41 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j19so6710885otq.2
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 10:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LA7BcUYMgiPM4LhkTkot3xLWQxZ9GymJ/I3cshi8054=;
 b=aWEsAGzc2Yh3JREBeLfqCnbjuH6gFhlIwpqtRUdyIB6fGEGjp0c/9cteoNu7mVTPYk
 k7v3tmKRFxuMhqWzggOKwBghog33HajwgNHqZGgt7yBZssqkujvFSdmZ6oFP073o8bd1
 ZFWE8m7Q/mY3rKQ0JO12vTiImwp/mNsQn0+1FPDFmxgJqZwFVHptf+HajNjWmdXZdyi/
 sXfT7o1lOMP8oP6O1xqR5I5TKSGwy+YYZ/aXoZ4EnNCmm8t/FhivsI3LpEb/JP77AiWP
 Hl/nPelTzud50IIzNwJksYSVmktcqKvzLaRjqqynqcF7HJ5XeVfEHEzsPm9koUpO7D/j
 z+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LA7BcUYMgiPM4LhkTkot3xLWQxZ9GymJ/I3cshi8054=;
 b=UnLYhgJe5jxTyuzHqIsZKeAjf5WgBFSTm4C0B1wRyGxERs8ygowi9jwM04XpCvK/Sb
 Ja8q9ADZpQLC3RYzV0rCcUD074DZnNpElX+UV+zvY0YlSGjCq3+3EtSNm6Uj+Ilvxc0n
 qt8pQSUkVlOqHNkVRkp2GQKpB259gZSvwKbyUCrIw7KUPBegf+h51A6my8ysEqZuMd9n
 TRvXdr3eA8/rwfNEBJ4id0y38gGx3lXjXaarWAy72jPRD1XeoCTwGhFMkykcteB0xBhL
 sG/JjXg0ZZxTf+PTP9TicSY/EKQETk48iEUGOWOF+U8b9AlMidSr5Om4HFx+3CC7PLci
 FY6A==
X-Gm-Message-State: APjAAAUAF5R9k1stEXQEOsvqvMEQanbVl1tb0KppkZAY3QnIAy9ZNE8e
 LIXy1/Bu4BsWi35lZ9IQ4IbE2XfLhgL3A7K3vjjYFg==
X-Google-Smtp-Source: APXvYqx9NDQoyUwfceLcBzkU2NvzJ3YM6qn8RS5E95TlC5H3OILwJGHGUQARUz+LN1VfbIDPOiU7HWfaHbo1PzKN6QA=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr8719655oto.207.1561741721035; 
 Fri, 28 Jun 2019 10:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com>
 <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com>
In-Reply-To: <20190628170219.GA3608@mellanox.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Jun 2019 10:08:30 -0700
Message-ID: <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
To: Jason Gunthorpe <jgg@mellanox.com>
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
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 28, 2019 at 10:02 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Jun 28, 2019 at 09:27:44AM -0700, Dan Williams wrote:
> > On Fri, Jun 28, 2019 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> > > > The functionality is identical to the one currently open coded in
> > > > device-dax.
> > > >
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > >  drivers/dax/dax-private.h |  4 ----
> > > >  drivers/dax/device.c      | 43 ---------------------------------------
> > > >  2 files changed, 47 deletions(-)
> > >
> > > DanW: I think this series has reached enough review, did you want
> > > to ack/test any further?
> > >
> > > This needs to land in hmm.git soon to make the merge window.
> >
> > I was awaiting a decision about resolving the collision with Ira's
> > patch before testing the final result again [1]. You can go ahead and
> > add my reviewed-by for the series, but my tested-by should be on the
> > final state of the series.
>
> The conflict looks OK to me, I think we can let Andrew and Linus
> resolve it.
>

Andrew's tree effectively always rebases since it's a quilt series.
I'd recommend pulling Ira's patch out of -mm and applying it with the
rest of hmm reworks. Any other git tree I'd agree with just doing the
late conflict resolution, but I'm not clear on what's the best
practice when conflicting with -mm.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

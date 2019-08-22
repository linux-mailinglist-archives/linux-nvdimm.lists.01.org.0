Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B0A989EB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Aug 2019 05:39:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 633F420213F2F;
	Wed, 21 Aug 2019 20:40:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6C17620213F1C
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 20:40:51 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id n1so3317538oic.3
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DcgDXQJ7Sbm8FXh01qFeLyuuK1Iph1Tzrxc/aBWGcaU=;
 b=eXE3475xcHKKW5d+UZ3aQkd3F+q2lJG32c4rQx+Ll5k/X1A8KvcDqn+zrnRMvF2zXu
 DvqY89e1izlDq1R7kc5hmQRlOI+bJRAO1zmN4/b3qaKNzXZEkGJlRFKeT4CTOupOuefj
 zg9VgInCIVMy17OpVT7sSsuEFLnfkPgH4Gpr0vKEB8Vx/2OPR6n/2+AhC+sMP0CDaZU/
 FdO6j0esA09TtJJjBjWhXyr0/bc6Xz85XfBzDl4KZ06k2rGr/ypYbAv5CJMHqZLXIPHd
 tFqZvTuZvIngmIS+OxaCARJSeAjrwdpjWtfnrGylPxg7K5loiMiHMpdLjy2Eaq/1cmyW
 dn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DcgDXQJ7Sbm8FXh01qFeLyuuK1Iph1Tzrxc/aBWGcaU=;
 b=LkSQ20MsS0dCp+lEuKRGeJ6se+a3U0dkAm5XUIyiBa8YQ5XeIwTrNOClQy60BHtZlr
 lhesMKJ49DjMvqBchFXiANYHP3FFf+O3BUMyZuhZ+87UBsRmuTjW+sUhuWJDXCL8TBDs
 JPNEstMnY+vUToKyYJdRl2ey9N82aGFWVo1TL7jNwrWzQt3DJKr3aJe+gzgBSLKscPhf
 Kph3c+hesOSoppq3rUcLz4jaz4MJUiBp2hcb74BaCm3cwPcxRuoRV4UP/pTDTwXu0YZj
 RvnurVbHBQ3mgDL/W0qX7o/l2Mcf9KFdc2ZE/QQFwUbPTU/ZPEVJ2qJ86kEUi3nDbiwp
 MnuQ==
X-Gm-Message-State: APjAAAVvqw43kZ+w9heBhXFMWxr+ZF/fGmJL6xHM74k+ETonL7ASxdDn
 SSZLvTkZirPMjcCVPUBWCxXVYZHkMSXrNJxKd1RUyg==
X-Google-Smtp-Source: APXvYqzSAJh90ed5uEoS1LSslo2SckTHl8JI7KY/tC5msX3Q9Ql8Er8WnuH87s+JOWBY8v+KaWLN9APIZd2VEdUR1OM=
X-Received: by 2002:aca:d707:: with SMTP id o7mr2421106oig.105.1566445183805; 
 Wed, 21 Aug 2019 20:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de>
 <20190818090557.17853-3-hch@lst.de>
 <CAPcyv4iYytOoX3QMRmvNLbroxD0szrVLauXFjnQMvtQOH3as_w@mail.gmail.com>
 <20190820132649.GD29225@mellanox.com>
 <CAPcyv4hfowyD4L0W3eTJrrPK5rfrmU6G29_vBVV+ea54eoJenA@mail.gmail.com>
 <20190821162420.GI8667@mellanox.com> <20190821235055.GQ8667@mellanox.com>
In-Reply-To: <20190821235055.GQ8667@mellanox.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 21 Aug 2019 20:39:32 -0700
Message-ID: <CAPcyv4iiuFD+5qNEpU9Cpg7ry-tLu2ycvLv8Hfomnuu+857sww@mail.gmail.com>
Subject: Re: [PATCH 2/4] memremap: remove the dev field in struct dev_pagemap
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bharata B Rao <bharata@linux.ibm.com>, Linux MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 21, 2019 at 4:51 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Wed, Aug 21, 2019 at 01:24:20PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 20, 2019 at 07:58:22PM -0700, Dan Williams wrote:
> > > On Tue, Aug 20, 2019 at 6:27 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > >
> > > > On Mon, Aug 19, 2019 at 06:44:02PM -0700, Dan Williams wrote:
> > > > > On Sun, Aug 18, 2019 at 2:12 AM Christoph Hellwig <hch@lst.de> wrote:
> > > > > >
> > > > > > The dev field in struct dev_pagemap is only used to print dev_name in
> > > > > > two places, which are at best nice to have.  Just remove the field
> > > > > > and thus the name in those two messages.
> > > > > >
> > > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > > >
> > > > > Needs the below as well.
> > > > >
> > > > > /me goes to check if he ever merged the fix to make the unit test
> > > > > stuff get built by default with COMPILE_TEST [1]. Argh! Nope, didn't
> > > > > submit it for 5.3-rc1, sorry for the thrash.
> > > > >
> > > > > You can otherwise add:
> > > > >
> > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > >
> > > > > [1]: https://lore.kernel.org/lkml/156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com/
> > > >
> > > > Can you get this merged? Do you want it to go with this series?
> > >
> > > Yeah, makes some sense to let you merge it so that you can get
> > > kbuild-robot reports about any follow-on memremap_pages() work that
> > > may trip up the build. Otherwise let me know and I'll get it queued
> > > with the other v5.4 libnvdimm pending bits.
> >
> > Done, I used it already to test build the last series from CH..
>
> It failed 0-day, I'm guessing some missing kconfig stuff
>
> For now I dropped it, but, if you send a v2 I can forward it toward
> 0-day again!

The system works!

Sorry for that thrash, I'll track it down.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 946255A1F6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 19:10:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 21912212AB4F5;
	Fri, 28 Jun 2019 10:10:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 696D6212AB4DE
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 10:10:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id b7so6649969otl.11
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qddKJwRb2cnRQ/FqFwYrdLbb8wYT8FUIpp0K6iYqKlE=;
 b=UnNjKOhDg6JhNrF0ffG6CmZkREW7rw22qwft9R1X5G1Y463lGz745qKb1Cpvvz1sEl
 zLMecGaZR5ynK6GE8f7Ml3Ex/6APldy0qkkzEaBAkhcBHC+GivS+i5qPLFaYjJ5IxfYg
 Ix0HdpLCjBnqAz9m39WW1jharT+5YOHNU4YfrM8Ah8R+FrEe4b6pxjgCmbbqGgh3sqcB
 2VYQ2agoAbSDUL/b0JhCGJa4iHWfU4XJrqUvTFK2MBTunnoIIjMYIkxDb4U+7zHLnerF
 GdJi7b5u2PxxVuLRhm8fJldQb7CTmEb8WCfsS3hc/y78yAwulmlFeUWonzJRUQpwECvp
 g/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qddKJwRb2cnRQ/FqFwYrdLbb8wYT8FUIpp0K6iYqKlE=;
 b=Zc0btvsoV8cQKFriI8YlqMt2eR94kw3slg7QnLbUQjDjNmbpu3AJ4yKw1qqUSCIbXd
 8M8iVsOOsSs/fGkr1Vo7VR+eitfpic0Av2QScOY1Qn8vgAy52fyRllMVHN0eZGKVUCRR
 edSCSfKFHe5vT1yDf9ulek4yEHEYy23WAyGnXEmp+1jigJyrFgDlyQ9/5B2UBi9eli9a
 Bx7TI6soCt4Tcs2sImGRFNuaP0ubiu5yawZoH/xosXFx73ZLVqMxLE+ku5nVwxSVYz9n
 X42eCI/K3rQwZk5PXDYp1myZEQtMfkqiZkJLMvlJBRfhF+6Y55yNPDVsL+MFs6uE/E/8
 NQoQ==
X-Gm-Message-State: APjAAAX7+PpzMY9LqKEMSVy8b1SqLEeRoWFYEmSq4y7PSLfWv1asRIyb
 XsmGRp10dVXGKx11p7rqbaBC4U+sD8ouin/J+ltMOQ==
X-Google-Smtp-Source: APXvYqziEb+tNzkKv17KjDDhi4UpD13NUfzT1yqPT34PEQGi0shpxcj8jFfercRLfAyVoLhNe8H8Bkb71Cnf2tL/n+k=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr8124495otn.71.1561741823760; 
 Fri, 28 Jun 2019 10:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com>
 <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com>
 <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
In-Reply-To: <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Jun 2019 10:10:12 -0700
Message-ID: <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com>
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

On Fri, Jun 28, 2019 at 10:08 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 28, 2019 at 10:02 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Fri, Jun 28, 2019 at 09:27:44AM -0700, Dan Williams wrote:
> > > On Fri, Jun 28, 2019 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > >
> > > > On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> > > > > The functionality is identical to the one currently open coded in
> > > > > device-dax.
> > > > >
> > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > > >  drivers/dax/dax-private.h |  4 ----
> > > > >  drivers/dax/device.c      | 43 ---------------------------------------
> > > > >  2 files changed, 47 deletions(-)
> > > >
> > > > DanW: I think this series has reached enough review, did you want
> > > > to ack/test any further?
> > > >
> > > > This needs to land in hmm.git soon to make the merge window.
> > >
> > > I was awaiting a decision about resolving the collision with Ira's
> > > patch before testing the final result again [1]. You can go ahead and
> > > add my reviewed-by for the series, but my tested-by should be on the
> > > final state of the series.
> >
> > The conflict looks OK to me, I think we can let Andrew and Linus
> > resolve it.
> >
>
> Andrew's tree effectively always rebases since it's a quilt series.
> I'd recommend pulling Ira's patch out of -mm and applying it with the
> rest of hmm reworks. Any other git tree I'd agree with just doing the
> late conflict resolution, but I'm not clear on what's the best
> practice when conflicting with -mm.

Regardless the patch is buggy. If you want to do the conflict
resolution it should be because the DEVICE_PUBLIC removal effectively
does the same fix otherwise we're knowingly leaving a broken point in
the history.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

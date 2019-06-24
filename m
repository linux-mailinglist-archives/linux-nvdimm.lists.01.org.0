Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCD651A74
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Jun 2019 20:25:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 945532129670B;
	Mon, 24 Jun 2019 11:25:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BB8EE2194EB75
 for <linux-nvdimm@lists.01.org>; Mon, 24 Jun 2019 11:25:00 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w7so10513533oic.3
 for <linux-nvdimm@lists.01.org>; Mon, 24 Jun 2019 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NsFsqmCeB4cJxbUvEFO6xcZSO/kARHjBGNTe6zm2OGk=;
 b=ISIKS+QlpEyn1hNfgdDi5hMHKw8iit0945EcE3yN7j+0wsgacWlTs5VS/2eHyNPn4P
 zFzHaSyW66Yiy2RhkTwuJ3InCkBlGpTPkGdBxkYOWHXgUlVbX7KrnXrnxhmbl79B80YX
 fCQYLMQ6T4q3GxjWwuuuag5EPhpGhA+skRXUiofVA4jxcOoybEtzKs47HHrVewo4aeOH
 xEgr2mAYq4kDK9twlyulxuXtH8x20UgS6h2b36rjnfm3Zpe3kyRxJhg0wXN2sl5N3Gx9
 a1ANzgYTbnIct0aX4IAsj7uocTALXH4slbfh3ZtWL5Y9qp3yWn0Ovu6E52I1ME72busN
 XZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NsFsqmCeB4cJxbUvEFO6xcZSO/kARHjBGNTe6zm2OGk=;
 b=h33jHXwS5o+yg1Cjzz3ktfrZ740xrZrHJEdM96tXwOyvBqh29utDd58p1s7W6dkfT2
 gZ6TFrX0zL9yy4s/0h5xPsRIc8ZfWArYN3R4cPAE7sgKFYAtcuszxiKo2PGYf0vuB9n4
 cxn7/qbGlr59GLl8/V0ju2/MmBAQMMhPkBfk1pjrRbhu1E8gh6AHul2iK7VHx8c/NbnN
 /vdXsKCDe+WpU+QCFZkSdPfHy1RHT0z5DLpU1ub3BodUyvIwAfBvvbWlcGAXPNcAcBnj
 iPnf81huT51b4Ko3amBJDK2c/Wfct672J/iyRs++XsWSXs9jL0mM2fOKQDYPX6TkCtPq
 0u2w==
X-Gm-Message-State: APjAAAV5JfMYOHibeu+7pH6bwKcCTU4J5KPWdI18eRT9ZaS8V0SJcHzQ
 Sv9gZKQSVX7jCvY7Vnnm0MNnRt03avkbYXqt34nGAw==
X-Google-Smtp-Source: APXvYqxMfIu+2D2MtYcv2E7EXzI2zB57kKNYjO9p4H9g9zR42W2XzhT13YcbI1eS8VOBT1jN50QqXbLB+mAAmyIYdBg=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr11696883oii.0.1561400699583; 
 Mon, 24 Jun 2019 11:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz>
In-Reply-To: <20190620191733.GH12083@dhcp22.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 24 Jun 2019 11:24:48 -0700
Message-ID: <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
To: Michal Hocko <mhocko@kernel.org>
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
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 20, 2019 at 12:17 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 13-06-19 11:43:08, Christoph Hellwig wrote:
> > noveau is currently using this through an odd hmm wrapper, and I plan
> > to switch it to the real thing later in this series.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  mm/mempolicy.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 01600d80ae01..f9023b5fba37 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2098,6 +2098,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
> >  out:
> >       return page;
> >  }
> > +EXPORT_SYMBOL_GPL(alloc_pages_vma);
>
> All allocator exported symbols are EXPORT_SYMBOL, what is a reason to
> have this one special?

I asked for this simply because it was not exported historically. In
general I want to establish explicit export-type criteria so the
community can spend less time debating when to use EXPORT_SYMBOL_GPL
[1].

The thought in this instance is that it is not historically exported
to modules and it is safer from a maintenance perspective to start
with GPL-only for new symbols in case we don't want to maintain that
interface long-term for out-of-tree modules.

Yes, we always reserve the right to remove / change interfaces
regardless of the export type, but history has shown that external
pressure to keep an interface stable (contrary to
Documentation/process/stable-api-nonsense.rst) tends to be less for
GPL-only exports.

[1]: https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2018-September/005688.html
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

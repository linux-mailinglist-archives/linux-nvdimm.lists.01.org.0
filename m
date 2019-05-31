Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCE30790
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 May 2019 06:17:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 95BF82128D698;
	Thu, 30 May 2019 21:17:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2FA9C21281EE5
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 21:17:21 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y6so3116954oix.2
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 21:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/b7zMtPyyoD7Z9H0ZcAMOMDecBLUC3B4wOXIPVDeoac=;
 b=CS6BO+r0JW9ceL73927ELSkUvJTEKgXX5d2GEA9im/bil/5XILFxf2n+JoVpDxAOQg
 p56uLAxZzgOfT0XX0L20Vm5uXC0SUX5RuImjl8jA820vIjcXM8U+KaCcdTSJ2YzayXm5
 ZUgMZ9kBllyvxZiqB6VnZORFA0fvmvRsC5pPOpXZ/w9W6WVqD55gBeW2Hz6ohgTEyc4w
 Dq2w3csJ0lnkSAzAvNlNOyD4zHirgUaJ1ds2y/C0e4G9GrZEDD88y1aN5TaFgceavrGg
 vpL/4OC1IOPY4HHqpSusL5qd2VVww8l+sTRupWy8p8rLplToV7VLd9ZoGdQGLY0xyhev
 VEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/b7zMtPyyoD7Z9H0ZcAMOMDecBLUC3B4wOXIPVDeoac=;
 b=C6YYWVkDvsBixTvlj++8wlijKDsunt9MijYKk50t6vUhCckqQrgjhepG6yehw4nsNh
 7a36AobRooZU9aslNIzHgwGbZe31aWsQFdFAR718ymlY1n41CQLhQ6TH/6V3KRgUDVL6
 A3OUJ9hV/6YBJFDIARmQLP1S0/+dqRYL0SODsDi1s2isvbr3msPf15ej/LTQYX3tF7uE
 hN69gp+NttymEof53NG5zwUr4VBvA8LxPC/PuvvHXRkl0K07Y4+fJJLKtxHeyAeXId8E
 bYFiIjGne2ssW+gFWN28tJObqIPi0v2ywui0o6kFtjOeEAGG2qVL6DctxgmI+xYCkVYX
 3ROA==
X-Gm-Message-State: APjAAAVJfYuwLOS7b2PiBgXm/F+lb8I4szeLMoAsWwYRKnUx6zbeQFX0
 ANsD438zZ3cHCevPdw4+SiN3KU+R6gF0mj7naYvBdA==
X-Google-Smtp-Source: APXvYqwzamlHcYCuE3bgAAH931eEoiZhZTHrMpm39gRZfwR3xH7d4NpA97rBUXSRJY8nTk5JwxAjuIV9SwroNgxQ3Wk=
X-Received: by 2002:aca:6087:: with SMTP id u129mr4677154oib.70.1559276240560; 
 Thu, 30 May 2019 21:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <059859ca-3cc8-e3ff-f797-1b386931c41e@deltatee.com>
 <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
In-Reply-To: <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 May 2019 21:17:09 -0700
Message-ID: <CAPcyv4jJjCwbWJH648x04Cms1kXY2Cd36bxpgmDGRh+5Van1fQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
To: Logan Gunthorpe <logang@deltatee.com>
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, May 13, 2019 at 12:22 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-05-08 11:05 a.m., Logan Gunthorpe wrote:
> >
> >
> > On 2019-05-07 5:55 p.m., Dan Williams wrote:
> >> Changes since v1 [1]:
> >> - Fix a NULL-pointer deref crash in pci_p2pdma_release() (Logan)
> >>
> >> - Refresh the p2pdma patch headers to match the format of other p2pdma
> >>    patches (Bjorn)
> >>
> >> - Collect Ira's reviewed-by
> >>
> >> [1]: https://lore.kernel.org/lkml/155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com/
> >
> > This series looks good to me:
> >
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> >
> > However, I haven't tested it yet but I intend to later this week.
>
> I've tested libnvdimm-pending which includes this series on my setup and
> everything works great.

Hi Andrew,

With this tested-by can we move forward on this fix set? I'm not aware
of any other remaining comments. Greg had a question about
"drivers/base/devres: Introduce devm_release_action()" that I
answered, but otherwise the feedback has gone silent.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

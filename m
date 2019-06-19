Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1A64C1AC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 21:46:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9DE6D21296B0B;
	Wed, 19 Jun 2019 12:46:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EA9EC21296403
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 12:46:13 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n5so285820otk.1
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AppOhepgnEe0jjnJnZQBJyzyqCwLm69rPfFkLY+t1bc=;
 b=L+LW3co1OBHWplV01UpK1fvt6NIcRF2qR2+gyrISeEZDbLPi91YZXqNIJExJQhxjVL
 7NO7u5O4wqUQFCjZA8X/xN5IC6nTONNL0PLEmadz1t01bknVW+LPFjhIpUDlZICWj1OK
 Gog3pb+AQtERVqv6j7fTaoTVYFpk5W1Hfef0DgmAjMPes0MNZ9hclPMHOd3R6z/1niZy
 xhltfPQTbipOo4AOyWvfdtdcgObLiRuElMk7blxcxcA8+NrVrohUYIrXM1xWntr04dh1
 fdyvcy8a9IUZO0qDkJUM7+nBLab/Ub+ZVWPgR39zFgOFrotnlWhaK61bEldeFuweA1TX
 hgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AppOhepgnEe0jjnJnZQBJyzyqCwLm69rPfFkLY+t1bc=;
 b=L0GkRwhztxaJLjbjcvj2wYc36ronXHvIgqzO4+aRY5pVAJ3use5cMU3iRJFGAx99LO
 us5bmMXjbzUJwhbcCswR3rCLDTFG+VOopX3OscUlkPlXm+Qw6KwmTuC24u7iZI0kPTtx
 r87VAEmptSnALOkIrxPmvjshgFpVX/atJPCf+qWtgVY0c0y42zldyMD2CirTylrP3sEt
 8/aj/IRUfQyDzR844U/dCH28ar0eNtxsbcEAVD1L757K8thghkrqgwov3gbv9k9V+y1d
 slA37HTR3+vNCGsynu5NBrMYqYrE32N60i9VIV+FOpV8zwyTmVkZ4KEj30Ala3/1TquF
 fkyg==
X-Gm-Message-State: APjAAAUeJWyaA+4PXdn3CGfFiSlSSs3yXAG8kc0gOtyS7hHuSlA3VUPX
 4bMHDpl9dOEypx7lg0hWiMmNoNJ5hU7o18ty+CnO3g==
X-Google-Smtp-Source: APXvYqyF4/fQjVQSHjLx0TTlLSRvNfoC1XWgfZBLjCA5t1eNPRU75djqD3lZLhJzoRPj37ekmpc9LL5nqKSkBxWsIsE=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr36193657otf.126.1560973572970; 
 Wed, 19 Jun 2019 12:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de>
 <20190613194430.GY22062@mellanox.com>
 <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
 <20190613195819.GA22062@mellanox.com>
 <20190614004314.GD783@iweiny-DESK2.sc.intel.com>
 <d2b77ea1-7b27-e37d-c248-267a57441374@nvidia.com>
 <20190619192719.GO9374@mellanox.com>
In-Reply-To: <20190619192719.GO9374@mellanox.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Jun 2019 12:46:01 -0700
Message-ID: <CAPcyv4j+zk_5WvFXbUbQ7bWisjWSwzwLsXide1AuVL4kLX8iyQ@mail.gmail.com>
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
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
Cc: Ralph Campbell <rcampbell@nvidia.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 19, 2019 at 12:42 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jun 13, 2019 at 06:23:04PM -0700, John Hubbard wrote:
> > On 6/13/19 5:43 PM, Ira Weiny wrote:
> > > On Thu, Jun 13, 2019 at 07:58:29PM +0000, Jason Gunthorpe wrote:
> > >> On Thu, Jun 13, 2019 at 12:53:02PM -0700, Ralph Campbell wrote:
> > >>>
> > ...
> > >> Hum, so the only thing this config does is short circuit here:
> > >>
> > >> static inline bool is_device_public_page(const struct page *page)
> > >> {
> > >>         return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> > >>                 IS_ENABLED(CONFIG_DEVICE_PUBLIC) &&
> > >>                 is_zone_device_page(page) &&
> > >>                 page->pgmap->type == MEMORY_DEVICE_PUBLIC;
> > >> }
> > >>
> > >> Which is called all over the place..
> > >
> > > <sigh>  yes but the earlier patch:
> > >
> > > [PATCH 03/22] mm: remove hmm_devmem_add_resource
> > >
> > > Removes the only place type is set to MEMORY_DEVICE_PUBLIC.
> > >
> > > So I think it is ok.  Frankly I was wondering if we should remove the public
> > > type altogether but conceptually it seems ok.  But I don't see any users of it
> > > so...  should we get rid of it in the code rather than turning the config off?
> > >
> > > Ira
> >
> > That seems reasonable. I recall that the hope was for those IBM Power 9
> > systems to use _PUBLIC, as they have hardware-based coherent device (GPU)
> > memory, and so the memory really is visible to the CPU. And the IBM team
> > was thinking of taking advantage of it. But I haven't seen anything on
> > that front for a while.
>
> Does anyone know who those people are and can we encourage them to
> send some patches? :)

I expect marking it CONFIG_BROKEN with the threat of deleting it if no
patches show up *is* the encouragement.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B35BE340E10
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Mar 2021 20:20:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86933100EB33B;
	Thu, 18 Mar 2021 12:20:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D0C27100ED49C
	for <linux-nvdimm@lists.01.org>; Thu, 18 Mar 2021 12:20:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w3so5724479ejc.4
        for <linux-nvdimm@lists.01.org>; Thu, 18 Mar 2021 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlSGkcpM7n93m2NXphTK+vfx2de8ofv8+tDkCjG9ugo=;
        b=p/21plRAKA00kj+4T75adsXsHf7ZMRaTa6UQJA+aiTXKTKoJGKvFVVPd87riYeNbO2
         VLV8soOgZV/G2xwT2z9cHO24i01oXFMff+s8U1CR/rvN9JouweHtAIU6uwQQsXvdckBZ
         Y7cdycazCcBx6tiqhxz8Ah+aRpQt8okOu+vyORg93c53B9vtIedJpnoLY6q+bdGXOqFt
         2WV6Lz2QiXpnDvRXuvWg7v2he7R12PxPNY+WPDH/3uPX1aHxHUMoxO/XcLS1IGjFDhkd
         ioIkshiLQpkMwlllG15YsAY+YriO+Pr9psWo3IYgNga/aKHZM4oHxIr9jGz+GV7iXMaP
         XGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlSGkcpM7n93m2NXphTK+vfx2de8ofv8+tDkCjG9ugo=;
        b=SLBkcK2MkLzeR3RJYIjH/6HoXlVAIToI4LB/pnXX5YUzpPg65WsG4YHb/YcndLDfs/
         UVP9v1WQTZM8oOJ7gFeJOgkoB5XXAhyds4CBWbsTJ4jxMQkrzZRs+1GCp5u0W0xBWO8t
         uBGDcgnOxr/cp7UisWyVdUsB6heRozAR6lt1yTXqaUopDi9x+eBBi5sjRiGFtxKaJn3A
         0td8yjrVaADE1BguZ+tQPIIGGTZXh9A39mF7O8PHZS94TyA++Fe4tZ4F0BDSzzsGcTPs
         AQ5c1F/si3sb1WJOwZgNysvtBpRMg3Gxfek1EKxdQ0wmcos0lIN+MHCi2OxB1AhGU1kK
         BbmA==
X-Gm-Message-State: AOAM533bKs7ZtKKps8L1U/suoFBkaBfzYyFV8jHSQc5NMQdC+d4qSMKe
	p9T/CHEZwyDoEC26K+A2MNsfypZ+o3DnIN0N3QE23g==
X-Google-Smtp-Source: ABdhPJxRNGn4R/MIQXf81dMHl00dEjUonY0A7VmKcQlICTbSL7uZYo2B373F7ZimvVTaIRpw34I5bjaerwpg4JQsQ/k=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr116007ejz.341.1616095241325;
 Thu, 18 Mar 2021 12:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210318045745.GC349301@dread.disaster.area>
In-Reply-To: <20210318045745.GC349301@dread.disaster.area>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Mar 2021 12:20:35 -0700
Message-ID: <CAPcyv4iPE_MB08PFM-DZig8g35YH_VTKydeFyffN+QovfXx7HA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm, dax, pmem: Introduce dev_pagemap_failure()
To: Dave Chinner <david@fromorbit.com>
Message-ID-Hash: F66W2JDDVFWENEBRZQADOVOR4LGVXYRH
X-Message-ID-Hash: F66W2JDDVFWENEBRZQADOVOR4LGVXYRH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>, "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F66W2JDDVFWENEBRZQADOVOR4LGVXYRH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 17, 2021 at 9:58 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Mar 17, 2021 at 09:08:23PM -0700, Dan Williams wrote:
> > Jason wondered why the get_user_pages_fast() path takes references on a
> > @pgmap object. The rationale was to protect against accessing a 'struct
> > page' that might be in the process of being removed by the driver, but
> > he rightly points out that should be solved the same way all gup-fast
> > synchronization is solved which is invalidate the mapping and let the
> > gup slow path do @pgmap synchronization [1].
> >
> > To achieve that it means that new user mappings need to stop being
> > created and all existing user mappings need to be invalidated.
> >
> > For device-dax this is already the case as kill_dax() prevents future
> > faults from installing a pte, and the single device-dax inode
> > address_space can be trivially unmapped.
> >
> > The situation is different for filesystem-dax where device pages could
> > be mapped by any number of inode address_space instances. An initial
> > thought was to treat the device removal event like a drop_pagecache_sb()
> > event that walks superblocks and unmaps all inodes. However, Dave points
> > out that it is not just the filesystem user-mappings that need to react
> > to global DAX page-unmap events, it is also filesystem metadata
> > (proposed DAX metadata access), and other drivers (upstream
> > DM-writecache) that need to react to this event [2].
> >
> > The only kernel facility that is meant to globally broadcast the loss of
> > a page (via corruption or surprise remove) is memory_failure(). The
> > downside of memory_failure() is that it is a pfn-at-a-time interface.
> > However, the events that would trigger the need to call memory_failure()
> > over a full PMEM device should be rare.
>
> This is a highly suboptimal design. Filesystems only need a single
> callout to trigger a shutdown that unmaps every active mapping in
> the filesystem - we do not need a page-by-page error notification
> which results in 250 million hwposion callouts per TB of pmem to do
> this.
>
> Indeed, the moment we get the first hwpoison from this patch, we'll
> map it to the primary XFS superblock and we'd almost certainly
> consider losing the storage behind that block to be a shut down
> trigger. During the shutdown, the filesystem should unmap all the
> active mappings (we already need to add this to shutdown on DAX
> regardless of this device remove issue) and so we really don't need
> a page-by-page notification of badness.

XFS doesn't, but what about device-mapper and other agents? Even if
the driver had a callback up the stack memory_failure() still needs to
be able to trigger failures down the stack for CPU consumed poison.

>
> AFAICT, it's going to take minutes, maybe hours for do the page-by-page
> iteration to hwposion every page. It's going to take a few seconds
> for the filesystem shutdown to run a device wide invalidation.
>
> SO, yeah, I think this should simply be a single ranged call to the
> filesystem like:
>
>         ->memory_failure(dev, 0, -1ULL)
>
> to tell the filesystem that the entire backing device has gone away,
> and leave the filesystem to handle failure entirely at the
> filesystem level.

So I went with memory_failure() after our discussion of all the other
agents in the system that might care about these pfns going offline
and relying on memory_failure() to route down to each of those. I.e.
the "reuse the drop_pagecache_sb() model" idea was indeed
insufficient. Now I'm trying to reconcile the fact that platform
poison handling will hit memory_failure() first and may not
immediately reach the driver, if ever (see the perennially awkward
firmware-first-mode error handling: ghes_handle_memory_failure()) . So
even if the ->memory_failure(dev...) up call exists there is no
guarantee it can get called for all poison before the memory_failure()
down call happens. Which means regardless of whether
->memory_failure(dev...) exists memory_failure() needs to be able to
do the right thing.

Combine that with the fact that new buses like CXL might be configured
in "poison on decode error" mode which means that a memory_failure()
storm can happen regardless of whether the driver initiates it
programatically.

How about a mechanism to optionally let a filesystem take over memory
failure handling for a range of pfns that the memory_failure() can
consult to fail ranges at a time rather than one by one? So a new
'struct dax_operations' op (void) (*memory_failure_register(struct
dax_device *, void *data). Where any agent that claims a dax_dev can
register to take over memory_failure() handling for any event that
happens in that range. This would be routed through device-mapper like
any other 'struct dax_operations' op. I think that meets your
requirement to get notifications of all the events you want to handle,
but still allows memory_failure() to be the last resort for everything
that has not opted into this error handling.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BA5290D9A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Oct 2020 00:12:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 34BB9154518F6;
	Fri, 16 Oct 2020 15:12:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D299213FDF60C
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 15:11:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p15so5426085ejm.7
        for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/1gvPq9ABO+DLME7JqBB+oA4SLyXFjfXGkzpl3gc3c=;
        b=pcZSwZipujNJCrfM4BfqKwSqTOO1tlVYDfGgPLS5HMjSaaFti2Es6Ws8L0Vp4BR0qh
         V71HRk4m6HBbQwP316nTLWmc9NtPWjJoKiZpDvVhYVTbaYa/iDspy0qQC3pPHUUbAxEP
         zx3rQt9TI6QwN7gwLb0sg0V8vWNYZRCctVPbbEN7+CaURNJuIJN6h3o7SOdhd6XWdAop
         RRqvh6nC7BWdaTGvYZdPr7glVwHYKPJHm19PsrI3BQgLw3/cc2+Y+AP+97Z/dyQ/9T2R
         wAMzEqSRy9Wjy5kcby+9zvQUhPtHVm/pArQ2K+jUYkJk0ofEaV3TM5Zw1LOaKF/TNQie
         BoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/1gvPq9ABO+DLME7JqBB+oA4SLyXFjfXGkzpl3gc3c=;
        b=af9JL1Bt+F49QOTTkOH87pdcM1I5uG4hJQKa+neZMDCEC5N9Bl2OXrYvPrb5Wn80pA
         X5o5TKDrXm5jo6P9vkmahV1M/s8Lgp0AaFxVmh9WiZf4HIaLPXBdlCqE2EHPjyfnucCR
         mK/G4bFq3JKOGixp/8gU/Slcswk84v2zy9T5L+TY5z+hYftFVCwztZPFNrheQZiYwHIN
         m5WvBy/iEFodijkb4/RZgjegxL3Kc3IIcdXS2L3VHJmUal8P+z9rnKwcrcAADQrlIMkA
         OxJZeWiq+bPh46O6ejlexrbNzSltEZMuqWnqM0zusDlWpNsTnJW72ZsCf8JvJXYkqh6Q
         SPhA==
X-Gm-Message-State: AOAM533T205YQ96Sv5gz5cxJH99H0u1BfPl9H8XQyIf/N05GAZuduR0o
	r1tzl0sRLZ1aOI7/D7TPP3ib4JUP6BZrlUwkrY8SRw==
X-Google-Smtp-Source: ABdhPJxsSOm3B4N0u0qHPPJOfUxJ1kby8jXT5wG1X7DBdcrTYVmjnEFqodQltQhk0823yfa2RC70ioRF0pDuj3vqDrA=
X-Received: by 2002:a17:906:b88f:: with SMTP id hb15mr5934428ejb.45.1602886318070;
 Fri, 16 Oct 2020 15:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Oct 2020 15:11:48 -0700
Message-ID: <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To: "Nabeel Meeramohideen Mohamed (nmeeramohide)" <nmeeramohide@micron.com>
Message-ID-Hash: D2X2VVOMBICGRBGZEN5B2YOZLDXKW4TL
X-Message-ID-Hash: D2X2VVOMBICGRBGZEN5B2YOZLDXKW4TL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Steve Moyer (smoyer)" <smoyer@micron.com>, "Greg Becker (gbecker)" <gbecker@micron.com>, "Pierre Labat (plabat)" <plabat@micron.com>, "John Groves (jgroves)" <jgroves@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D2X2VVOMBICGRBGZEN5B2YOZLDXKW4TL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
(nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> On Thursday, October 15, 2020 2:03 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > I don't think this belongs into the kernel.  It is a classic case for
> > infrastructure that should be built in userspace.  If anything is
> > missing to implement it in userspace with equivalent performance we
> > need to improve out interfaces, although io_uring should cover pretty
> > much everything you need.
>
> Hi Christoph,
>
> We previously considered moving the mpool object store code to user-space.
> However, by implementing mpool as a device driver, we get several benefits
> in terms of scalability, performance, and functionality. In doing so, we relied
> only on standard interfaces and did not make any changes to the kernel.
>
> (1)  mpool's "mcache map" facility allows us to memory-map (and later unmap)
> a collection of logically related objects with a single system call. The objects in
> such a collection are created at different times, physically disparate, and may
> even reside on different media class volumes.
>
> For our HSE storage engine application, there are commonly 10's to 100's of
> objects in a given mcache map, and 75,000 total objects mapped at a given time.
>
> Compared to memory-mapping objects individually, the mcache map facility
> scales well because it requires only a single system call and single vm_area_struct
> to memory-map a complete collection of objects.

Why can't that be a batch of mmap calls on io_uring?

> (2) The mcache map reaper mechanism proactively evicts object data from the page
> cache based on object-level metrics. This provides significant performance benefit
> for many workloads.
>
> For example, we ran YCSB workloads B (95/5 read/write mix)  and C (100% read)
> against our HSE storage engine using the mpool driver in a 5.9 kernel.
> For each workload, we ran with the reaper turned-on and turned-off.
>
> For workload B, the reaper increased throughput 1.77x, while reducing 99.99% tail
> latency for reads by 39% and updates by 99%. For workload C, the reaper increased
> throughput by 1.84x, while reducing the 99.99% read tail latency by 63%. These
> improvements are even more dramatic with earlier kernels.

What metrics proved useful and can the vanilla page cache / page
reclaim mechanism be augmented with those metrics?

>
> (3) The mcache map facility can memory-map objects on NVMe ZNS drives that were
> created using the Zone Append command. This patch set does not support ZNS, but
> that work is in progress and we will be demonstrating our HSE storage engine
> running on mpool with ZNS drives at FMS 2020.
>
> (4) mpool's immutable object model allows the driver to support concurrent reading
> of object data directly and memory-mapped without a performance penalty to verify
> coherence. This allows background operations, such as LSM-tree compaction, to
> operate efficiently and without polluting the page cache.
>

How is this different than existing background operations / defrag
that filesystems perform today? Where are the opportunities to improve
those operations?

> (5) Representing an mpool as a /dev/mpool/<mpool-name> device file provides a
> convenient mechanism for controlling access to and managing the multiple storage
> volumes, and in the future pmem devices, that may comprise an logical mpool.

Christoph and I have talked about replacing the pmem driver's
dependence on device-mapper for pooling. What extensions would be
needed for the existing driver arch?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

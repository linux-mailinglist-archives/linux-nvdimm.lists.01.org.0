Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16193320271
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 02:19:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A7DA100EC1E3;
	Fri, 19 Feb 2021 17:19:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8B37A100ED484
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:19:00 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id p2so12852721edm.12
        for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8I/++zqgWe2vZKzB2I3EDGwNh2FcyG9ignZ4r6L3DZY=;
        b=w4aQQRje/jerTeZglVuAtAD8RzQVEbuKDYLK7xJfV681Dqh3LGBt/VgLQ0AIvOdX/O
         Q3RGmg6wctRTBw2/2RqK8xyi32T4YzA/IYjuJDALNl2Kd6+KVqOiFhE46UDZVJTTEd6t
         uZDswIbehTiCRBllrGM3L8S/XNMokHkIfTi+4PtkdTi3CM9bUjnZMUlWxALfm4/uvhTY
         ewdBHWR2oDbEGBRaO7E4tIReG4brzSwgqP2R7Sn/A5h6YdU2Sqq02aEQUceYNQe1NrNJ
         X3xtH8rHRDzz8/KIixO4PiCwgj5i7OFR1jEwhZgMNE/QDaqquna64D+1T0PW2PSgr5bJ
         y5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8I/++zqgWe2vZKzB2I3EDGwNh2FcyG9ignZ4r6L3DZY=;
        b=Soc3xPSWBe3NraP4Tu+iZQBY6SVZKBqoZFmZYI/NuEPUDTi3zLT24eVDcmdUGv2cag
         VeBql68NPWrrApkaiXu3k3MFzzRHobkjh/+BmugskU70M12apcu1G6gTcFIGQYZYlhrs
         09Ur5GERh7rX41dFNccm7axBXXyuZBUoXJlqgH2akjIG3MwE6YMQ6RodCUQHtWn/NJ2T
         KLJnf4XwI9Bc1EMixLfZC4sRwY9TNyVm9tAsK+j5tZCO2qPL2cNX7sPPnm6EnFk4RDSx
         s4PtKy2MSxHktwKjmrCUdoVByl1NBtMivKjXEAwrUOmeYFxh9XuF8UxOU5BkejxLsKYB
         eV4Q==
X-Gm-Message-State: AOAM531V4wJRAerCINNRuykZRX34L0Rw3WIPBMXtp6bGpfo0h+KbhurF
	UY8uF1bhEySDCjetb/7b+QUpRB/C5FDin7aC7kxv8g==
X-Google-Smtp-Source: ABdhPJwGcgVw8LZGjLQwH8vQSWkjNN7/CtuprkImbJhEapBBfAjZp4GCVOHgmxwHw9iipUama/sr+PVi/PiU+Ak2KEA=
X-Received: by 2002:aa7:d315:: with SMTP id p21mr10307428edq.300.1613783938776;
 Fri, 19 Feb 2021 17:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Feb 2021 17:18:51 -0800
Message-ID: <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: 7AIC2U63DJDJHGA2PPJ6UVBL4MQ5WGM2
X-Message-ID-Hash: 7AIC2U63DJDJHGA2PPJ6UVBL4MQ5WGM2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7AIC2U63DJDJHGA2PPJ6UVBL4MQ5WGM2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Hey,
>
> This small series, attempts at minimizing 'struct page' overhead by
> pursuing a similar approach as Muchun Song series "Free some vmemmap
> pages of hugetlb page"[0] but applied to devmap/ZONE_DEVICE.
>
> [0] https://lore.kernel.org/linux-mm/20201130151838.11208-1-songmuchun@bytedance.com/

Clever!

>
> The link above describes it quite nicely, but the idea is to reuse tail
> page vmemmap areas, particular the area which only describes tail pages.
> So a vmemmap page describes 64 struct pages, and the first page for a given
> ZONE_DEVICE vmemmap would contain the head page and 63 tail pages. The second
> vmemmap page would contain only tail pages, and that's what gets reused across
> the rest of the subsection/section. The bigger the page size, the bigger the
> savings (2M hpage -> save 6 vmemmap pages; 1G hpage -> save 4094 vmemmap pages).
>
> In terms of savings, per 1Tb of memory, the struct page cost would go down
> with compound pagemap:
>
> * with 2M pages we lose 4G instead of 16G (0.39% instead of 1.5% of total memory)
> * with 1G pages we lose 8MB instead of 16G (0.0007% instead of 1.5% of total memory)

Nice!

>
> Along the way I've extended it past 'struct page' overhead *trying* to address a
> few performance issues we knew about for pmem, specifically on the
> {pin,get}_user_pages* function family with device-dax vmas which are really
> slow even of the fast variants. THP is great on -fast variants but all except
> hugetlbfs perform rather poorly on non-fast gup.
>
> So to summarize what the series does:
>
> Patches 1-5: Much like Muchun series, we reuse tail page areas across a given
> page size (namely @align was referred by remaining memremap/dax code) and
> enabling of memremap to initialize the ZONE_DEVICE pages as compound pages or a
> given @align order. The main difference though, is that contrary to the hugetlbfs
> series, there's no vmemmap for the area, because we are onlining it. IOW no
> freeing of pages of already initialized vmemmap like the case for hugetlbfs,
> which simplifies the logic (besides not being arch-specific). After these,
> there's quite visible region bootstrap of pmem memmap given that we would
> initialize fewer struct pages depending on the page size.
>
>     NVDIMM namespace bootstrap improves from ~750ms to ~190ms/<=1ms on emulated NVDIMMs
>     with 2M and 1G respectivally. The net gain in improvement is similarly observed
>     in proportion when running on actual NVDIMMs.

I
>
> Patch 6 - 8: Optimize grabbing/release a page refcount changes given that we
> are working with compound pages i.e. we do 1 increment/decrement to the head
> page for a given set of N subpages compared as opposed to N individual writes.
> {get,pin}_user_pages_fast() for zone_device with compound pagemap consequently
> improves considerably, and unpin_user_pages() improves as well when passed a
> set of consecutive pages:
>
>                                            before          after
>     (get_user_pages_fast 1G;2M page size) ~75k  us -> ~3.2k ; ~5.2k us
>     (pin_user_pages_fast 1G;2M page size) ~125k us -> ~3.4k ; ~5.5k us

Compelling!

>
> The RDMA patch (patch 8/9) is to demonstrate the improvement for an existing
> user. For unpin_user_pages() we have an additional test to demonstrate the
> improvement.  The test performs MR reg/unreg continuously and measuring its
> rate for a given period. So essentially ib_mem_get and ib_mem_release being
> stress tested which at the end of day means: pin_user_pages_longterm() and
> unpin_user_pages() for a scatterlist:
>
>     Before:
>     159 rounds in 5.027 sec: 31617.923 usec / round (device-dax)
>     466 rounds in 5.009 sec: 10748.456 usec / round (hugetlbfs)
>
>     After:
>     305 rounds in 5.010 sec: 16426.047 usec / round (device-dax)
>     1073 rounds in 5.004 sec: 4663.622 usec / round (hugetlbfs)

Why does hugetlbfs get faster for a ZONE_DEVICE change? Might answer
that question myself when I get to patch 8.

>
> Patch 9: Improves {pin,get}_user_pages() and its longterm counterpart. It
> is very experimental, and I imported most of follow_hugetlb_page(), except
> that we do the same trick as gup-fast. In doing the patch I feel this batching
> should live in follow_page_mask() and having that being changed to return a set
> of pages/something-else when walking over PMD/PUDs for THP / devmap pages. This
> patch then brings the previous test of mr reg/unreg (above) on parity
> between device-dax and hugetlbfs.
>
> Some of the patches are a little fresh/WIP (specially patch 3 and 9) and we are
> still running tests. Hence the RFC, asking for comments and general direction
> of the work before continuing.

Will go look at the code, but I don't see anything scary conceptually
here. The fact that pfn_to_page() does not need to change is among the
most compelling features of this approach.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

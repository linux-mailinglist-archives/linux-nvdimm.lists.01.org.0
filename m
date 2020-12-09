Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD332D3F2F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 10:52:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB301100EC1FC;
	Wed,  9 Dec 2020 01:52:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1044; helo=mail-pj1-x1044.google.com; envelope-from=songmuchun@bytedance.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15A09100EC1FA
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 01:52:47 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id hk16so618512pjb.4
        for <linux-nvdimm@lists.01.org>; Wed, 09 Dec 2020 01:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYLUp063N+P4ILCANVlMNV7exC1SxroeMaAJDlYDQXE=;
        b=OKvmW2PGwcRhdZsMul0LgigQJ5zvB9mvhuKvkAgcfENaPzZ84f8evxicQRDynew0uF
         7PzRWymZXkWLxf2f8i7UcyxlkgClLPOn4spRIwyZI3UAVBsyMHyG0TQWfadv85gDXxWK
         1cnvC1Id7JMjzxxtskqzGP5mwEcvram5VrSVZ/zOjMldttbfZsWMA7ul2Cq82BwSlESg
         BPPNT0LpykmA+sAjjSjzW9e7aJ1CUnS6HbLAci9NeHphbIs+eXCVv+59n7+C0GD5iP+9
         5vU9BlKVAcs+n4udWtO4fMKy6uMW5Yw0Z8RfL4UCmo1HIlCxpRQllSLQYNN4611Mtrfv
         HcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYLUp063N+P4ILCANVlMNV7exC1SxroeMaAJDlYDQXE=;
        b=NNjCbiehGYfnr86eKMoyeeZ2km+gQa0JBY1PRhOpR6DeK6XJSLeNB1O4JeEKHHbUxU
         6uUgxR+stEIRVQ8E7KfZT68g60v7hIQeqzD+Y1jHlbhBPkwxkOt7Y9/s5tznKZfeUPrE
         r/HfSj/fXz9xbbWQkXsU0YxTyEhEfZ5hpjHs5iP2xE8d+qwEfAlcGY6njC+rzhF9OP6j
         B3ocOanzTYP41HVxTmRXBKx46iEvpewx7l6MOMqXsBFw/X0X7Uy6AScKfM9ueaRlrI+m
         SpnDZmcYeMd9QUfyJ8NwKCSz+oPiqLlXFUR9Sh6soWF9D+FZIrCauKk3BoX6PG2HiS6G
         LKYw==
X-Gm-Message-State: AOAM530QnXNTo1rvqxz2wjamInAUSdtnm7rVO0fMkZolE6dIj5wj8IHQ
	2r/i67qQGQUnpugZxFyBEI+X14dGEgpv+kuU3zWJ0w==
X-Google-Smtp-Source: ABdhPJy1c43K8e2ufgvW8ThbcgNeT6Dhfk9iQncxofSb++wOFR9+7YfAvW+TFCS94Up2C3RquU/2domtD0UGwfv9yt0=
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr1438070pjr.229.1607507567152;
 Wed, 09 Dec 2020 01:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
In-Reply-To: <20201208172901.17384-1-joao.m.martins@oracle.com>
From: Muchun Song <songmuchun@bytedance.com>
Date: Wed, 9 Dec 2020 17:52:10 +0800
Message-ID: <CAMZfGtXLcOPZ6Frwj574ZzcZ3Qr5Kzv2t-FCDDDONUvPymYQLA@mail.gmail.com>
Subject: Re: [External] [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: W4FO4UE3EZ2636BNWWMEGULNYPUMA4GB
X-Message-ID-Hash: W4FO4UE3EZ2636BNWWMEGULNYPUMA4GB
X-MailFrom: songmuchun@bytedance.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux Memory Management List <linux-mm@kvack.org>, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W4FO4UE3EZ2636BNWWMEGULNYPUMA4GB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 9, 2020 at 1:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Hey,
>
> This small series, attempts at minimizing 'struct page' overhead by
> pursuing a similar approach as Muchun Song series "Free some vmemmap
> pages of hugetlb page"[0] but applied to devmap/ZONE_DEVICE.
>
> [0] https://lore.kernel.org/linux-mm/20201130151838.11208-1-songmuchun@bytedance.com/
>

Oh, well. It looks like you agree with my optimization approach
and have fully understood. Also, welcome help me review that
series if you have time. :)

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
>
> Patches apply on top of linux-next tag next-20201208 (commit a9e26cb5f261).
>
> Comments and suggestions very much appreciated!
>
> Thanks,
>         Joao
>
> Joao Martins (9):
>   memremap: add ZONE_DEVICE support for compound pages
>   sparse-vmemmap: Consolidate arguments in vmemmap section populate
>   sparse-vmemmap: Reuse vmemmap areas for a given page size
>   mm/page_alloc: Reuse tail struct pages for compound pagemaps
>   device-dax: Compound pagemap support
>   mm/gup: Grab head page refcount once for group of subpages
>   mm/gup: Decrement head page once for group of subpages
>   RDMA/umem: batch page unpin in __ib_mem_release()
>   mm: Add follow_devmap_page() for devdax vmas
>
>  drivers/dax/device.c           |  54 ++++++---
>  drivers/infiniband/core/umem.c |  25 +++-
>  include/linux/huge_mm.h        |   4 +
>  include/linux/memory_hotplug.h |  16 ++-
>  include/linux/memremap.h       |   2 +
>  include/linux/mm.h             |   6 +-
>  mm/gup.c                       | 130 ++++++++++++++++-----
>  mm/huge_memory.c               | 202 +++++++++++++++++++++++++++++++++
>  mm/memory_hotplug.c            |  13 ++-
>  mm/memremap.c                  |  13 ++-
>  mm/page_alloc.c                |  28 ++++-
>  mm/sparse-vmemmap.c            |  97 +++++++++++++---
>  mm/sparse.c                    |  16 +--
>  13 files changed, 531 insertions(+), 75 deletions(-)
>
> --
> 2.17.1
>


-- 
Yours,
Muchun
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

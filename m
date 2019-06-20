Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835164D45D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Jun 2019 18:56:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18FC22129F03E;
	Thu, 20 Jun 2019 09:56:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6CDF921290DC5
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 09:56:52 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d17so3421957oth.5
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fOYLp6hgueM9IndZ4EN5g0OtG+v2NmbcnIaY4S6F39U=;
 b=L68JUZMsU50kQvIyjv7hYWpW6X5xm6ttiDbx+i1flV2loGovu9oLWT0/Oq0wGyvjeF
 fDEHYCjmDgMEzsqFCqfiwLyn1WQa64ztrAwo98O+v66/orGKTWwb8digBS49x4Pflf0Y
 GwbN3GlvDERuyFfH3JoFUUNtodv7ywBBM2TNpqAPqosJAz3+HCLcKrjjimfxbGpOg1yh
 IhpZaJAeuld4fCSpSEEQG7eW9hIzMlX+fOOfur9Rk2uW98EI4n5HVk+orDvRtVpaeJBG
 tFfo8SvN6kMdSRGx7QadqpWCbafgyp8LgUUrcNOCgoFyaIAfeIsdRck4L783SXqbI9Af
 3HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fOYLp6hgueM9IndZ4EN5g0OtG+v2NmbcnIaY4S6F39U=;
 b=SqQocR5v3HrhV/RMWh61KtsHx2+1AdUaVC2KXT+LVipB0cx2+8sOUur6c9L+sYHDO/
 s3eGZbqMXXPSDzKu2WcAxQ1NJENuXkAFZ3rvu4/B/KJaW9eTe+vhZvI9s+tpH3W7BgH+
 M5Jer9zg2r5wK6K0UCAyHgOVT95+yaZjNHtj0KxnOVit9nxy71Nuo7VOEQ7ph+lwQ/ox
 i9cVt6BHUgXmmBrPVvnBuYoRjMx+7ldGFs8i6LLIhAMoe6Qz5pdViudnZPrLVmBdEdc/
 838ojZjsrBIZnMfe+NqbQd4woGOQBqRiDR0ZDTTn2wcf3TLvdQiZ6hxjn36tSMOgK0qC
 NDdQ==
X-Gm-Message-State: APjAAAV7ZjL70hU+pP9AEkFmq/6GaJQ9Mhk5m0+jrxbEdbhWtAgLSpkA
 qrmWL4CmmUsy6MJN+4Yx22x+J7a9aVg/Zpc1hflLBg==
X-Google-Smtp-Source: APXvYqz6ECdin+kIXbEiVFPFwyQWlqLQpDqZZas2KQgUhlFbQVpZ8YHHJuT5Ae4Hj9wp2NSwJaLXdBacSsagD2vdyWg=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr200928otn.247.1561049811653; 
 Thu, 20 Jun 2019 09:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156092353780.979959.9713046515562743194.stgit@dwillia2-desk3.amr.corp.intel.com>
 <70f3559b-2832-67eb-0715-ed9f856f6ed9@redhat.com>
 <CAPcyv4jzELzrf-p6ujUwdXN2FRe0WCNhpTziP2-z4-8uBSSp7A@mail.gmail.com>
 <d62e1f2f-70db-da84-5cc3-01fab779aeb7@redhat.com>
In-Reply-To: <d62e1f2f-70db-da84-5cc3-01fab779aeb7@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 20 Jun 2019 09:56:40 -0700
Message-ID: <CAPcyv4j-XxP_8kWbZpv2z94kDjxTB8RBMYGkKr1WopqsfhqdmA@mail.gmail.com>
Subject: Re: [PATCH v10 08/13] mm/sparsemem: Prepare for sub-section ranges
To: David Hildenbrand <david@redhat.com>
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
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 20, 2019 at 9:37 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.06.19 18:19, Dan Williams wrote:
> > On Thu, Jun 20, 2019 at 3:31 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 19.06.19 07:52, Dan Williams wrote:
> >>> Prepare the memory hot-{add,remove} paths for handling sub-section
> >>> ranges by plumbing the starting page frame and number of pages being
> >>> handled through arch_{add,remove}_memory() to
> >>> sparse_{add,remove}_one_section().
> >>>
> >>> This is simply plumbing, small cleanups, and some identifier renames. No
> >>> intended functional changes.
> >>>
> >>> Cc: Michal Hocko <mhocko@suse.com>
> >>> Cc: Vlastimil Babka <vbabka@suse.cz>
> >>> Cc: Logan Gunthorpe <logang@deltatee.com>
> >>> Cc: Oscar Salvador <osalvador@suse.de>
> >>> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>> ---
> >>>  include/linux/memory_hotplug.h |    5 +-
> >>>  mm/memory_hotplug.c            |  114 +++++++++++++++++++++++++---------------
> >>>  mm/sparse.c                    |   16 ++----
> >>>  3 files changed, 81 insertions(+), 54 deletions(-)
> > [..]
> >>> @@ -528,31 +556,31 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
> >>>   * sure that pages are marked reserved and zones are adjust properly by
> >>>   * calling offline_pages().
> >>>   */
> >>> -void __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> >>> +void __remove_pages(struct zone *zone, unsigned long pfn,
> >>>                   unsigned long nr_pages, struct vmem_altmap *altmap)
> >>>  {
> >>> -     unsigned long i;
> >>>       unsigned long map_offset = 0;
> >>> -     int sections_to_remove;
> >>> +     int i, start_sec, end_sec;
> >>
> >> As mentioned in v9, use "unsigned long" for start_sec and end_sec please.
> >
> > Honestly I saw you and Andrew going back and forth about "unsigned
> > long i" that I thought this would be handled by a follow on patchset
> > when that debate settled.
> >
>
> I'll send a fixup then, once this patch set is final - hoping I won't
> forget about it (that's why I asked about using these types in the first
> place).

It's in Andrew's tree now, I'll send an incremental patch.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

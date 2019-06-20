Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB124D385
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Jun 2019 18:20:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 928AC2129F031;
	Thu, 20 Jun 2019 09:19:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0563821296706
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 09:19:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id m202so2586129oig.6
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yuGyF1gaAxnc5NCYYEX6kiZekDv13zqB0UQA2n5aQis=;
 b=TyqKBNvBRHg2N7hM9S8c6U4FOJz5mxm6Kd+KBEMqs2GVrceDbu2B5Yv+Tpqg9S34ys
 MaHgCO6/ySGOZphnnrTbgImRuL2QMVoCGG2VWkmL5W3Uon95vGsNjpaeOGPEgMJOT3L9
 5WEJx442dDZs/YbNnY0UQilkmAx8XpdOKM4CFfFFAge3HyxFPgiIP95x0HYvSNAaMKy6
 1mXvvW5okLy4jiD7hQSkY3gSwkQy7MxiqZoOpVEppM+LOHSdZJYPl7dVTiAul4GD3HrH
 y9JAaW9RA4lNlRmSX3HsfKvWxmHRadsFz/qNFrGo4+gaTh+E4u2Ot15NvBhXkJk5Bz/Z
 edQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yuGyF1gaAxnc5NCYYEX6kiZekDv13zqB0UQA2n5aQis=;
 b=R+jljCjv7lPxRogrjEjH3PG9b/c7Px6Prtft+ZrcGUUXOG5rUOWIjRG5TZhQWzPGhy
 s3K/2yu//cydUNjBHqTR+zqXDbVMI5vFMJvbKa/smchxnNDxl6/ZCR6EDDy2d/1oVBRp
 TekBAk109an6ERBHPF9/ovwGJjzxRYPQ9NXBR6Ls4MSLWIScgoej5HuAfsc8itMp7+XA
 TAVrKmocNRu8Ep0ritqPNK2Fo/YHYhe/X2HTwJBEA0qvdbckP1s4L8JokNfU1H1hiXXm
 lKIdxNbI/evVCPhasBuimOw0+vVxHYCRIGhEn0DgV+pjlr8Y3IWrK1/2WYygvCh1t/JV
 Jmig==
X-Gm-Message-State: APjAAAVMDNiQ/tXnnLiGOI8jK4sU6j3T48/6Y0iVDLR5jOY51tkaTIlC
 U1XM/Wp4eM3b6I7LSfzrJTRlg4l7/AjtHlCdYkckAg==
X-Google-Smtp-Source: APXvYqycTrfFCdUGQlxbLBM8sq/vvF4AR0qE564N7NnNzy2gB1lQelj0Er/vC+yiQUqqVAU2Tj/69BOUevu0+1dRykA=
X-Received: by 2002:aca:d60c:: with SMTP id n12mr4630027oig.105.1561047595403; 
 Thu, 20 Jun 2019 09:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156092353780.979959.9713046515562743194.stgit@dwillia2-desk3.amr.corp.intel.com>
 <70f3559b-2832-67eb-0715-ed9f856f6ed9@redhat.com>
In-Reply-To: <70f3559b-2832-67eb-0715-ed9f856f6ed9@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 20 Jun 2019 09:19:43 -0700
Message-ID: <CAPcyv4jzELzrf-p6ujUwdXN2FRe0WCNhpTziP2-z4-8uBSSp7A@mail.gmail.com>
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

On Thu, Jun 20, 2019 at 3:31 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.06.19 07:52, Dan Williams wrote:
> > Prepare the memory hot-{add,remove} paths for handling sub-section
> > ranges by plumbing the starting page frame and number of pages being
> > handled through arch_{add,remove}_memory() to
> > sparse_{add,remove}_one_section().
> >
> > This is simply plumbing, small cleanups, and some identifier renames. No
> > intended functional changes.
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  include/linux/memory_hotplug.h |    5 +-
> >  mm/memory_hotplug.c            |  114 +++++++++++++++++++++++++---------------
> >  mm/sparse.c                    |   16 ++----
> >  3 files changed, 81 insertions(+), 54 deletions(-)
[..]
> > @@ -528,31 +556,31 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
> >   * sure that pages are marked reserved and zones are adjust properly by
> >   * calling offline_pages().
> >   */
> > -void __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> > +void __remove_pages(struct zone *zone, unsigned long pfn,
> >                   unsigned long nr_pages, struct vmem_altmap *altmap)
> >  {
> > -     unsigned long i;
> >       unsigned long map_offset = 0;
> > -     int sections_to_remove;
> > +     int i, start_sec, end_sec;
>
> As mentioned in v9, use "unsigned long" for start_sec and end_sec please.

Honestly I saw you and Andrew going back and forth about "unsigned
long i" that I thought this would be handled by a follow on patchset
when that debate settled.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

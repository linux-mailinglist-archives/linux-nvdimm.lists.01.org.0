Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6294B07C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 05:40:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84A1B21962301;
	Tue, 18 Jun 2019 20:40:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 62E5921295CB9
 for <linux-nvdimm@lists.01.org>; Tue, 18 Jun 2019 20:40:48 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b7so17779003otl.11
 for <linux-nvdimm@lists.01.org>; Tue, 18 Jun 2019 20:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4V43vNNP9UR/YMy0iUrU7kUuUwSqcmG602S5hpOD5NE=;
 b=BQ7vWgHmVXoWfX5W8xsL12ik15mXugB0SaJil+xQI3I0WxyylMDSZVjeFIBqrMpPVJ
 Tgiut3d49qvcxdiNlr/Wuqhf5OYmZDTD6pJsL4uc8B7AvZ8wwh8aPM4n71HSolE5Oxc3
 FA9Ld6qDcf1gl5dm9y3qsfehBHljHi5HXuDdd7/icxI+t/oHdrlAmeDiUP/Kmr+DiaXd
 ygMke+1L3EJ6jv6Or7J7ka07JnJyzYJ6usnlq/hrYPaTv2PCenHPThlG9fXMEyQo3ktq
 qYnDyLZfzEglV0V7mhDK4JYNDdtBeedbRy3nXiodLZw2O63uvgAs/frjTUrFddu2fdwk
 1G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4V43vNNP9UR/YMy0iUrU7kUuUwSqcmG602S5hpOD5NE=;
 b=tFA9/25SaqX/zG7Kw0uyLx+6CFqoPnKcnNv4ceKJFH53QAApWZDpBf/cVnHzD6KahO
 g93mWMoSyLdOeHXCdRmD57gGj6l2JnBsgtuOlnv15i+N+PDjH/SoETyWjYK0WWVZ63nO
 BdHsf8Rze6Kz3PI/gm6Tn+z7dHyU4lDNLmAjJVVrzLphsc5gmGgFStvu1XhdsNWatvFG
 bwnsMbqUehA0i0guSNjLbizf6AMHh/Vq/4iNdP5yWqnJi2xV5mAYtsDVaOblQTG2tIGr
 wk5iOVcNGZaIrhFUyR7HQebrJ86htnbJUZqu6CATcS00syoHFvSVgz8/Jt23zJazuKpd
 TmVQ==
X-Gm-Message-State: APjAAAXmGYzIcw8oVUWn71FJNAjkvME1qvsh5W0zHbYSLVzq1NUDgt0P
 fyAiuC8LqCk8LfsO20SYEzIyedW40B7wpCOrrojrJg==
X-Google-Smtp-Source: APXvYqzSIN9dPRssFnDKf+ysKlqbDab6DghA3P8E1YBeqgXp36cJF4wdWJZxF+5DmxoFz1Yx1IYT0Jk4KmWR0apXjnU=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr59223453otn.71.1560915647227; 
 Tue, 18 Jun 2019 20:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977188458.2443951.9573565800736334460.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190618014223.GD18161@richard>
In-Reply-To: <20190618014223.GD18161@richard>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 18 Jun 2019 20:40:36 -0700
Message-ID: <CAPcyv4gXzNgghUq337foa3ywB0R4g1e1atnXX-=KJCjCacv0TA@mail.gmail.com>
Subject: Re: [PATCH v9 03/12] mm/hotplug: Prepare shrink_{zone, pgdat}_span
 for sub-section removal
To: Wei Yang <richardw.yang@linux.intel.com>
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

On Mon, Jun 17, 2019 at 6:42 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> On Wed, Jun 05, 2019 at 02:58:04PM -0700, Dan Williams wrote:
> >Sub-section hotplug support reduces the unit of operation of hotplug
> >from section-sized-units (PAGES_PER_SECTION) to sub-section-sized units
> >(PAGES_PER_SUBSECTION). Teach shrink_{zone,pgdat}_span() to consider
> >PAGES_PER_SUBSECTION boundaries as the points where pfn_valid(), not
> >valid_section(), can toggle.
> >
> >Cc: Michal Hocko <mhocko@suse.com>
> >Cc: Vlastimil Babka <vbabka@suse.cz>
> >Cc: Logan Gunthorpe <logang@deltatee.com>
> >Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> >Reviewed-by: Oscar Salvador <osalvador@suse.de>
> >Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >---
> > mm/memory_hotplug.c |   29 ++++++++---------------------
> > 1 file changed, 8 insertions(+), 21 deletions(-)
> >
> >diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >index 7b963c2d3a0d..647859a1d119 100644
> >--- a/mm/memory_hotplug.c
> >+++ b/mm/memory_hotplug.c
> >@@ -318,12 +318,8 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
> >                                    unsigned long start_pfn,
> >                                    unsigned long end_pfn)
> > {
> >-      struct mem_section *ms;
> >-
> >-      for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SECTION) {
> >-              ms = __pfn_to_section(start_pfn);
> >-
> >-              if (unlikely(!valid_section(ms)))
> >+      for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SUBSECTION) {
> >+              if (unlikely(!pfn_valid(start_pfn)))
> >                       continue;
>
> Hmm, we change the granularity of valid section from SECTION to SUBSECTION.
> But we didn't change the granularity of node id and zone information.
>
> For example, we found the node id of a pfn mismatch, we can skip the whole
> section instead of a subsection.
>
> Maybe this is not a big deal.

I don't see a problem.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

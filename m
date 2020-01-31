Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CF014E7DB
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jan 2020 05:27:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D30C610FC3169;
	Thu, 30 Jan 2020 20:30:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A7A9310FC3167
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 20:30:18 -0800 (PST)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 88C6D2063A;
	Fri, 31 Jan 2020 04:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580444820;
	bh=fvmiIudZIDgLsHd/wjsv1325fO3ooc1JALICQXNnilI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RlL/CyGRKQUGV79pbye1AjD87OnTajU1dYeo0ZwklLxfSD4WGbOxfzJvss+umehcV
	 w8nDC+9eRvUAXFf2m+C2+opJaj8ilkRktnmETXnWtwpHRhqBbbhNKmzWGSCxNYfigD
	 2llTm6Mr+a7/iuLbKO3+01Yzm3mKgVWHz0WVhc/g=
Date: Thu, 30 Jan 2020 20:26:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v6] mm/pgmap: Use correct alignment when looking at
 first pfn from a region
Message-Id: <20200130202659.c3e745d31b29d2e7b7af6447@linux-foundation.org>
In-Reply-To: <f7a1b3f7-bfbb-e13c-7e8b-c76316bae8e4@linux.ibm.com>
References: <20190917153129.12905-1-aneesh.kumar@linux.ibm.com>
	<20190919122501.df660f0d23806a3f46d11b61@linux-foundation.org>
	<8736glowyh.fsf@linux.ibm.com>
	<20191130151317.26c69ef711dba28ff642cca3@linux-foundation.org>
	<CAPcyv4i_ZsSKpYADbT46_9ab3GuRf=z3DzVCjkSdswF8PgG4dg@mail.gmail.com>
	<f7a1b3f7-bfbb-e13c-7e8b-c76316bae8e4@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: UDN3GGPLE6W4EXK5DDLWEWW2GJZAEYZO
X-Message-ID-Hash: UDN3GGPLE6W4EXK5DDLWEWW2GJZAEYZO
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UDN3GGPLE6W4EXK5DDLWEWW2GJZAEYZO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2019 15:42:28 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> On 12/3/19 6:20 AM, Dan Williams wrote:
> > On Sat, Nov 30, 2019 at 3:13 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>
> >> On Wed, 25 Sep 2019 09:21:02 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >>> Andrew Morton <akpm@linux-foundation.org> writes:
> >>>
> >>>> On Tue, 17 Sep 2019 21:01:29 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> >>>>
> >>>>> vmem_altmap_offset() adjust the section aligned base_pfn offset.
> >>>>> So we need to make sure we account for the same when computing base_pfn.
> >>>>>
> >>>>> ie, for altmap_valid case, our pfn_first should be:
> >>>>>
> >>>>> pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);
> >>>>
> >>>> What are the user-visible runtime effects of this change?
> >>>
> >>> This was found by code inspection. If the pmem region is not correctly
> >>> section aligned we can skip pfns while iterating device pfn using
> >>>        for_each_device_pfn(pfn, pgmap)
> >>>
> >>>
> >>> I still would want Dan to ack the change though.
> >>>
> >>
> >> Dan?
> >>
> >>
> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> >> Subject: mm/pgmap: use correct alignment when looking at first pfn from a region
> >>
> >> vmem_altmap_offset() adjusts the section aligned base_pfn offset.  So we
> >> need to make sure we account for the same when computing base_pfn.
> >>
> >> ie, for altmap_valid case, our pfn_first should be:
> >>
> >> pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);
> >>
> >> This was found by code inspection. If the pmem region is not correctly
> >> section aligned we can skip pfns while iterating device pfn using
> >>
> >>          for_each_device_pfn(pfn, pgmap)
> >>
> >> [akpm@linux-foundation.org: coding style fixes]
> >> Link: http://lkml.kernel.org/r/20190917153129.12905-1-aneesh.kumar@linux.ibm.com
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> Cc: Ralph Campbell <rcampbell@nvidia.com>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >>
> >>   mm/memremap.c |   12 ++++++++++--
> >>   1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> --- a/mm/memremap.c~mm-pgmap-use-correct-alignment-when-looking-at-first-pfn-from-a-region
> >> +++ a/mm/memremap.c
> >> @@ -55,8 +55,16 @@ static void pgmap_array_delete(struct re
> >>
> >>   static unsigned long pfn_first(struct dev_pagemap *pgmap)
> >>   {
> >> -       return PHYS_PFN(pgmap->res.start) +
> >> -               vmem_altmap_offset(pgmap_altmap(pgmap));
> >> +       const struct resource *res = &pgmap->res;
> >> +       struct vmem_altmap *altmap = pgmap_altmap(pgmap);
> >> +       unsigned long pfn;
> >> +
> >> +       if (altmap)
> >> +               pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
> >> +       else
> >> +               pfn = PHYS_PFN(res->start);
> > 
> > This would only be a problem if res->start is not subsection aligned.
> 
> Kernel is not enforcing this right? ie, If i create multiple namespace
> as below
> 
> ndctl create-namespace -s 16908288 --align 64K
> 
> I can get base_pfn different from res->start PHYS_PFN
> 
> Yes that results in other error as below with the current upstream.
> 
> [   17.491097] memory add fail, invalid altmap
> 
> 
> 
> > Is that bug triggering in your case, or is this just inspection. Now
> > that the subsections can be assumed as the minimum mapping granularity
> > I'd rather see a cleanup  I'd rather cleanup the implementation to
> > eliminate altmap->base_pfn or at least assert that
> > PHYS_PFN(res->start) and altmap->base_pfn are always identical.
> > 
> > Otherwise ->base_pfn is supposed to be just a convenient way to recall
> > the bounds of the memory hotplug operation deeper in the vmemmap
> > setup.
> > 
> 
> Is the right fix to ensure that we always make sure res->start is 
> subsection aligned ? If so we may need the patch series
> https://patchwork.kernel.org/project/linux-nvdimm/list/?series=209373
> 
> And enforce that to be multiple of subsection size?

No response here?

This patch has been floating around for rather a long time.  I think
I'll drop it for now - please resend if still interested?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ECB24948
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 09:47:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 853A7212746F7;
	Tue, 21 May 2019 00:47:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F339F2194EB76
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 00:47:48 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r136so12056902oie.7
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VnNxGfo8OcqUG0djFgBhBET2kQpbkm/tIE8oQa/BNZw=;
 b=atFNJxGKx5nr0wfgMSn6a0RTyfq2Fh7KOKEYPxov5zlzNFhhIYe1dDNUgjJWatnVu3
 TQY7uuBSU/kDC6jobnCJYnj/QC+XChDwidnJlVmLT+MQmUmFq1bEEchLhCjWuzgKwyju
 A+qqR0Oh6V+JS6PRPujGPjIyVyL+OoUBTYAMMcVVJFycuEmeOjMY+4s6bfyLPECB8sfq
 LACDTc/1TBb3ba22twzTF60fVdcTjQgaSNGrXT7IOZ01fPet6WWPb3T1jtZ9Y1dHCtQL
 JAXyMeMqcCl+bNQjZkMKAndf7SfNg7p/q7JyueeAO1zPLX2PEzfzLbMoYqMvaB232JBG
 1OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VnNxGfo8OcqUG0djFgBhBET2kQpbkm/tIE8oQa/BNZw=;
 b=CRb9ZRWFCCgVNoKKgIxg12zOfstmnhRWYpwbw1ORFNUHdfjWu37Iguov/rWMyHiJlu
 +4oEEurW+hH2RQbYP140PkxDxPcHYU8zUuLNHmOqB3Padvak2L3q7xLjWbXNX3T5hKtp
 qZmPD3NErdzeLdR5Nak8cl9hR9VpRjexGhdIjyciib/Q5wJteXy3/jtKaIE6+MdW0MBU
 OYW6ahAmteDrU55rSymZg8MWDM1M8V94/gy7T0Jef93BvMindH03mYLd6lWxXElGQbE9
 V/LIiBhrHV7KaKLyZSo3FiMH2lPWB0CpZZV7zoaAvE/px/srEvkxv74OPprh0U8IYkAq
 C4HQ==
X-Gm-Message-State: APjAAAVRNeX98XyA4HGeC9YsQjjajoa8jRgJATs2SYsRL3ix2BKqNYhQ
 IAChVoXAqL8t/aOm5nrCQ9egcydEvrqrs2PCbP5nQg==
X-Google-Smtp-Source: APXvYqyMSmQsHlkHNQttDiH4AI9D7Vum2+q5m/RkOEYGvfvIfr5P741zQF/NrlP+XEOoZIXxeRZzuwTUqFQl8EEQY58=
X-Received: by 2002:aca:6087:: with SMTP id u129mr453263oib.70.1558424867222; 
 Tue, 21 May 2019 00:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190514025604.9997-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4iNgFbSq0Hqb+CStRhGWMHfXx7tL3vrDaQ95DcBBY8QCQ@mail.gmail.com>
 <f99c4f11-a43d-c2d3-ab4f-b7072d090351@linux.ibm.com>
 <CAPcyv4gOr8SFbdtBbWhMOU-wdYuMCQ4Jn2SznGRsv6Vku97Xnw@mail.gmail.com>
 <02d1d14d-650b-da38-0828-1af330f594d5@linux.ibm.com>
In-Reply-To: <02d1d14d-650b-da38-0828-1af330f594d5@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 21 May 2019 00:47:33 -0700
Message-ID: <CAPcyv4jcSgg0wxY9FAM4ke9JzVc9Pu3qe6dviS3seNgHfG2oNw@mail.gmail.com>
Subject: Re: [PATCH] mm/nvdimm: Use correct #defines instead of opencoding
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Linux MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, May 13, 2019 at 9:46 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 5/14/19 9:42 AM, Dan Williams wrote:
> > On Mon, May 13, 2019 at 9:05 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 5/14/19 9:28 AM, Dan Williams wrote:
> >>> On Mon, May 13, 2019 at 7:56 PM Aneesh Kumar K.V
> >>> <aneesh.kumar@linux.ibm.com> wrote:
> >>>>
> >>>> The nfpn related change is needed to fix the kernel message
> >>>>
> >>>> "number of pfns truncated from 2617344 to 163584"
> >>>>
> >>>> The change makes sure the nfpns stored in the superblock is right value.
> >>>>
> >>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >>>> ---
> >>>>    drivers/nvdimm/pfn_devs.c    | 6 +++---
> >>>>    drivers/nvdimm/region_devs.c | 8 ++++----
> >>>>    2 files changed, 7 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> >>>> index 347cab166376..6751ff0296ef 100644
> >>>> --- a/drivers/nvdimm/pfn_devs.c
> >>>> +++ b/drivers/nvdimm/pfn_devs.c
> >>>> @@ -777,8 +777,8 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> >>>>                    * when populating the vmemmap. This *should* be equal to
> >>>>                    * PMD_SIZE for most architectures.
> >>>>                    */
> >>>> -               offset = ALIGN(start + reserve + 64 * npfns,
> >>>> -                               max(nd_pfn->align, PMD_SIZE)) - start;
> >>>> +               offset = ALIGN(start + reserve + sizeof(struct page) * npfns,
> >>>> +                              max(nd_pfn->align, PMD_SIZE)) - start;
> >>>
> >>> No, I think we need to record the page-size into the superblock format
> >>> otherwise this breaks in debug builds where the struct-page size is
> >>> extended.
> >>>
> >>>>           } else if (nd_pfn->mode == PFN_MODE_RAM)
> >>>>                   offset = ALIGN(start + reserve, nd_pfn->align) - start;
> >>>>           else
> >>>> @@ -790,7 +790,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> >>>>                   return -ENXIO;
> >>>>           }
> >>>>
> >>>> -       npfns = (size - offset - start_pad - end_trunc) / SZ_4K;
> >>>> +       npfns = (size - offset - start_pad - end_trunc) / PAGE_SIZE;
> >>>
> >>> Similar comment, if the page size is variable then the superblock
> >>> needs to explicitly account for it.
> >>>
> >>
> >> PAGE_SIZE is not really variable. What we can run into is the issue you
> >> mentioned above. The size of struct page can change which means the
> >> reserved space for keeping vmemmap in device may not be sufficient for
> >> certain kernel builds.
> >>
> >> I was planning to add another patch that fails namespace init if we
> >> don't have enough space to keep the struct page.
> >>
> >> Why do you suggest we need to have PAGE_SIZE as part of pfn superblock?
> >
> > So that the kernel has a chance to identify cases where the superblock
> > it is handling was created on a system with different PAGE_SIZE
> > assumptions.
> >
>
> The reason to do that is we don't have enough space to keep struct page
> backing the total number of pfns? If so, what i suggested above should
> handle that.
>
> or are you finding any other reason why we should fail a namespace init
> with a different PAGE_SIZE value?

I want the kernel to be able to start understand cross-architecture
and cross-configuration geometries. Which to me means incrementing the
info-block version and recording PAGE_SIZE and sizeof(struct page) in
the info-block directly.

> My another patch handle the details w.r.t devdax alignment for which
> devdax got created with PAGE_SIZE 4K but we are now trying to load that
> in a kernel with PAGE_SIZE 64k.

Sure, but what about the reverse? These info-block format assumptions
are as fundamental as the byte-order of the info-block, it needs to be
cross-arch compatible and the x86 assumptions need to be fully lifted.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

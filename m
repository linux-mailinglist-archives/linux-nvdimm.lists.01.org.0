Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B883254DC
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 18:07:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 036E9212746FE;
	Tue, 21 May 2019 09:07:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B076F211E092E
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 09:07:14 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id f4so13232359oib.4
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qHnInBfAX+GoWjJM5B+1a+Vw2rTdSHZyw1ZFE7z7NrY=;
 b=fR9U+EFoXp6HhXYT9l+xkijMGif7K3fz6bincJ22ZbB0d6OaUaMGrTRXdelLknFbfs
 W+ZLsKJExrH5KaDHoKhSWCC0/MjPf0uktzpjdZekcC4BUpuM8dhQqEakhcSRzwfEdR3W
 jdIEyi0RF68bIxCaFkl2lXnmRjr9DXLFTvqkBJCMLZxu0mjAr03gDUfxrgObVP4QkZIe
 XwmJkmntN9CT1/uHTWvoG53gNa+73/obZEpIGYFxHczx8aaM2A6Zmax3vR9Zc+q3Ft8s
 Qob6I/4L4bOjfPB2cVs9qYt4TPBKLg2RM962LdsC2KdYawUOqjKbIHg4YRO45qE0w3Wz
 MrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qHnInBfAX+GoWjJM5B+1a+Vw2rTdSHZyw1ZFE7z7NrY=;
 b=S3liJnvgQ4trlZJP1Sc9if9DOkgDY3lcyM1X5L+1r3cVzRm3vYQB2ksHrUa4zPiA3B
 96l/3fV6mD1InCuQ2xiZQCRLhc/HGyyB54PlxREHLkD+ykHTUPjO/e+NXGOigipTV8Qt
 /DzvHuW8uHALhzT75YiulMG9fj1/kB55zaPNt3FVB0Jnv4EJvR3mfyk56itYhrfN5W6N
 uNx8aTGhqXZEqb103eEaSX+NOx/M6DNY0rd7W+sroXdWUgGlcQaMOCaR1CvDUfGYU62J
 J/0FK1fDpjAoMmm9INTi99vwaxj5SHKQQXLRKrf3+12t9+l7sldRFeqp0UTK+F2e8Vth
 gH9A==
X-Gm-Message-State: APjAAAWqFq3cRCShU9wx/QmB2EXo6wP9w6tjnEiPLLKOpu53sN4A2B6T
 DZk1ziqr1O2U2lVQWVEytg0qhq3KaBekR0g+EYDYRQ==
X-Google-Smtp-Source: APXvYqyu5x5mrKlEIasKp1NxpDGYmQJsGvrx6mxQiUGAiiyjZAOGd76nwvRmcYQhvDtlfylqQ/dEPb7N7a77yrnQFHQ=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr3889695oie.73.1558454833247;
 Tue, 21 May 2019 09:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190514025604.9997-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4iNgFbSq0Hqb+CStRhGWMHfXx7tL3vrDaQ95DcBBY8QCQ@mail.gmail.com>
 <f99c4f11-a43d-c2d3-ab4f-b7072d090351@linux.ibm.com>
 <CAPcyv4gOr8SFbdtBbWhMOU-wdYuMCQ4Jn2SznGRsv6Vku97Xnw@mail.gmail.com>
 <02d1d14d-650b-da38-0828-1af330f594d5@linux.ibm.com>
 <CAPcyv4jcSgg0wxY9FAM4ke9JzVc9Pu3qe6dviS3seNgHfG2oNw@mail.gmail.com>
 <87mujgcf0h.fsf@linux.ibm.com>
In-Reply-To: <87mujgcf0h.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 21 May 2019 09:07:02 -0700
Message-ID: <CAPcyv4j5Y+AFkbvYjDnfqTdmN_Sq=O0qfGUorgpjAE8Ww7vH=A@mail.gmail.com>
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

On Tue, May 21, 2019 at 2:51 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Mon, May 13, 2019 at 9:46 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 5/14/19 9:42 AM, Dan Williams wrote:
> >> > On Mon, May 13, 2019 at 9:05 PM Aneesh Kumar K.V
> >> > <aneesh.kumar@linux.ibm.com> wrote:
> >> >>
> >> >> On 5/14/19 9:28 AM, Dan Williams wrote:
> >> >>> On Mon, May 13, 2019 at 7:56 PM Aneesh Kumar K.V
> >> >>> <aneesh.kumar@linux.ibm.com> wrote:
> >> >>>>
> >> >>>> The nfpn related change is needed to fix the kernel message
> >> >>>>
> >> >>>> "number of pfns truncated from 2617344 to 163584"
> >> >>>>
> >> >>>> The change makes sure the nfpns stored in the superblock is right value.
> >> >>>>
> >> >>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> >>>> ---
> >> >>>>    drivers/nvdimm/pfn_devs.c    | 6 +++---
> >> >>>>    drivers/nvdimm/region_devs.c | 8 ++++----
> >> >>>>    2 files changed, 7 insertions(+), 7 deletions(-)
> >> >>>>
> >> >>>> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> >> >>>> index 347cab166376..6751ff0296ef 100644
> >> >>>> --- a/drivers/nvdimm/pfn_devs.c
> >> >>>> +++ b/drivers/nvdimm/pfn_devs.c
> >> >>>> @@ -777,8 +777,8 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> >> >>>>                    * when populating the vmemmap. This *should* be equal to
> >> >>>>                    * PMD_SIZE for most architectures.
> >> >>>>                    */
> >> >>>> -               offset = ALIGN(start + reserve + 64 * npfns,
> >> >>>> -                               max(nd_pfn->align, PMD_SIZE)) - start;
> >> >>>> +               offset = ALIGN(start + reserve + sizeof(struct page) * npfns,
> >> >>>> +                              max(nd_pfn->align, PMD_SIZE)) - start;
> >> >>>
> >> >>> No, I think we need to record the page-size into the superblock format
> >> >>> otherwise this breaks in debug builds where the struct-page size is
> >> >>> extended.
> >> >>>
> >> >>>>           } else if (nd_pfn->mode == PFN_MODE_RAM)
> >> >>>>                   offset = ALIGN(start + reserve, nd_pfn->align) - start;
> >> >>>>           else
> >> >>>> @@ -790,7 +790,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> >> >>>>                   return -ENXIO;
> >> >>>>           }
> >> >>>>
> >> >>>> -       npfns = (size - offset - start_pad - end_trunc) / SZ_4K;
> >> >>>> +       npfns = (size - offset - start_pad - end_trunc) / PAGE_SIZE;
> >> >>>
> >> >>> Similar comment, if the page size is variable then the superblock
> >> >>> needs to explicitly account for it.
> >> >>>
> >> >>
> >> >> PAGE_SIZE is not really variable. What we can run into is the issue you
> >> >> mentioned above. The size of struct page can change which means the
> >> >> reserved space for keeping vmemmap in device may not be sufficient for
> >> >> certain kernel builds.
> >> >>
> >> >> I was planning to add another patch that fails namespace init if we
> >> >> don't have enough space to keep the struct page.
> >> >>
> >> >> Why do you suggest we need to have PAGE_SIZE as part of pfn superblock?
> >> >
> >> > So that the kernel has a chance to identify cases where the superblock
> >> > it is handling was created on a system with different PAGE_SIZE
> >> > assumptions.
> >> >
> >>
> >> The reason to do that is we don't have enough space to keep struct page
> >> backing the total number of pfns? If so, what i suggested above should
> >> handle that.
> >>
> >> or are you finding any other reason why we should fail a namespace init
> >> with a different PAGE_SIZE value?
> >
> > I want the kernel to be able to start understand cross-architecture
> > and cross-configuration geometries. Which to me means incrementing the
> > info-block version and recording PAGE_SIZE and sizeof(struct page) in
> > the info-block directly.
> >
> >> My another patch handle the details w.r.t devdax alignment for which
> >> devdax got created with PAGE_SIZE 4K but we are now trying to load that
> >> in a kernel with PAGE_SIZE 64k.
> >
> > Sure, but what about the reverse? These info-block format assumptions
> > are as fundamental as the byte-order of the info-block, it needs to be
> > cross-arch compatible and the x86 assumptions need to be fully lifted.
>
> Something like the below (Not tested). I am not sure what we will init the page_size
> for minor version < 3. This will mark the namespace disabled if the
> PAGE_SIZE and sizeof(struct page) doesn't match with the values used
> during namespace create.

Yes, this is on the right track.

I would special-case page_size == 0 as 4096 and page_struct_size == 0
as 64. If either of those is non-zero then the info-block version
needs to be revved and it needs to be crafted to make older kernels
fail to parse it.

There was an earlier attempt to implement minimum info-block versions here:

https://lore.kernel.org/lkml/155000670159.348031.17631616775326330606.stgit@dwillia2-desk3.amr.corp.intel.com/

...but that was dropped in favor of the the "sub-section" patches.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

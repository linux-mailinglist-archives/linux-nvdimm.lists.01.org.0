Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D9A99F4
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 07:16:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6503A21962301;
	Wed,  4 Sep 2019 22:17:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4F00620260CF7
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 22:17:10 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b80so740677oii.7
 for <linux-nvdimm@lists.01.org>; Wed, 04 Sep 2019 22:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ANhLYAgQ2zCWY2vllIvc9e5G3lO6EoINw8yyuu02p0I=;
 b=hS0iaKXNIbotJ+Fjgi1/OUgawZQUWZTYSUmhPvi3DURqLT1lmHweT0Mm9pWTBXzCMG
 JuORyrCopHp/A7Pv2z5ddLAbuNfwNtEIdF/uciR8X3gv1kZfEchsRqs+cWukNVKJNS+s
 4HmSLbGXcbWIgVvY/i8yyrW5nf/9N/XDJJhdDMhsgj2UAyeZUUHetwmZ1PaSE9yEFlJ4
 wI9agMu+PPRxyjzkaARo+swU106HGYUJUnzDKS6ckFvHvukxT1rBlq/XCxQe3NW+3vbs
 pHdOAHM99oipC+0kELDhrpGkcAb5WXqh8SFCdGtQKZwEehCbkzuRQB8NjIf0hoAE9ZD/
 xUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ANhLYAgQ2zCWY2vllIvc9e5G3lO6EoINw8yyuu02p0I=;
 b=nV7ulqvpJ8pD7Hrgs8hfrJ0y+HNZh/BPwdLLbwXSQz8Isnomm3EjdcALtGdus9JW/G
 fBLXwivs/T2qTgN7Zdyi9Ri+uFyj27BqNRko+R4ZeN5lijz6ld7spseiUKGYHSosEcnH
 nuKpm4wbXH18l3Otw6CAs50Sv9s/DLH8KJuwsmGXw7zUXa5dE5b9G/0X7VUlF0UJ4lXW
 DMvh2dBanuvDd6dJQlQCitQnK6wllWA3+0CL3MvshJreCuii1AhObOPh0Xf6p4iLsDId
 xCt6MYBbhjnj6pu3pNgUuln3qVhA3QDlMoe7/DaHswCfhHbs9JVEDuwm1uPB88LUbdA3
 d8lw==
X-Gm-Message-State: APjAAAWhV1vW7H7MlHr2MuxiSY3a6yOh+6U4Y/AjpL68r8OuLZ/vjPWo
 SxqFX/ARb13BXCNsy/owzusGiXSVin+rtRtE6Pm+lmDCY1U=
X-Google-Smtp-Source: APXvYqycF0lLajdtVSDJ/9mSRESb/gnmYCZAkHRCTFQQQl6Q4b+o9jzD3IOoxCwZchC5glo463Ur6N0lTu7KnxGWDW8=
X-Received: by 2002:aca:5dc3:: with SMTP id r186mr1119653oib.73.1567660569341; 
 Wed, 04 Sep 2019 22:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190904065320.6005-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hD8SAFNNAWBP9q55wdPf-HYTEjpS4m+rT0VPoGodZULw@mail.gmail.com>
 <33b377ac-86ea-b195-fd83-90c01df604cc@linux.ibm.com>
 <CAPcyv4hBHjrTSHRkwU8CQcXF4EHoz0rzu6L-U-QxRpWkPSAhUQ@mail.gmail.com>
 <d46212fb-7bbb-3db8-5a65-2c8799021fd6@linux.ibm.com>
In-Reply-To: <d46212fb-7bbb-3db8-5a65-2c8799021fd6@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Sep 2019 22:15:57 -0700
Message-ID: <CAPcyv4impX2OEd3ZATz_4_UjOvC4N78uU+PBPRK+id3Nh0EPCw@mail.gmail.com>
Subject: Re: [PATCH v8] libnvdimm/dax: Pick the right alignment default when
 creating dax devices
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
Cc: Linux MM <linux-mm@kvack.org>, "Kirill A . Shutemov" <kirill@shutemov.name>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Sep 4, 2019 at 9:10 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 9/5/19 8:29 AM, Dan Williams wrote:
> >>> Keep this 'static' there's no usage of this routine outside of pfn_devs.c
> >>>
> >>>>    {
> >>>> -       /*
> >>>> -        * This needs to be a non-static variable because the *_SIZE
> >>>> -        * macros aren't always constants.
> >>>> -        */
> >>>> -       const unsigned long supported_alignments[] = {
> >>>> -               PAGE_SIZE,
> >>>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>> -               HPAGE_PMD_SIZE,
> >>>> +       static unsigned long supported_alignments[3];
> >>>
> >>> Why is marked static? It's being dynamically populated each invocation
> >>> so static is just wasting space in the .data section.
> >>>
> >>
> >> The return of that function is address and that would require me to use
> >> a global variable. I could add a check
> >>
> >> /* Check if initialized */
> >>    if (supported_alignment[1])
> >>          return supported_alignment;
> >>
> >> in the function to updating that array every time called.
> >
> > Oh true, my mistake. I was thrown off by the constant
> > re-initialization. Another option is to pass in the storage since the
> > array needs to be populated at run time. Otherwise I would consider it
> > a layering violation for libnvdimm to assume that
> > has_transparent_hugepage() gives a constant result. I.e. put this
> >
> >          unsigned long aligns[4] = { [0] = 0, };
> >
> > ...in align_store() and supported_alignments_show() then
> > nd_pfn_supported_alignments() does not need to worry about
> > zero-initializing the fields it does not set.
>
> That requires callers to track the size of aligns array. If we add
> different alignment support later, we will end up updating all the call
> site?

2 sites for something that gets updated maybe once a decade?

>
> How about?
>
> static const unsigned long *nd_pfn_supported_alignments(void)
> {
>         static unsigned long supported_alignments[4];
>
>         if (supported_alignments[0])
>                 return supported_alignments;
>
>         supported_alignments[0] = PAGE_SIZE;
>
>         if (has_transparent_hugepage()) {
>                 supported_alignments[1] = HPAGE_PMD_SIZE;
>                 if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
>                         supported_alignments[2] = HPAGE_PUD_SIZE;
>         }

Again, this makes assumptions that has_transparent_hugepage() always
returns the same result every time it is called.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

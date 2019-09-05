Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F823A98A4
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 04:59:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A23F020277228;
	Wed,  4 Sep 2019 20:00:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6F45C20260CFF
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 20:00:57 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a127so578775oii.2
 for <linux-nvdimm@lists.01.org>; Wed, 04 Sep 2019 19:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uuS19FigxfakDYnvbAFxrtuUuHeM+v/iuERCHWfI3vo=;
 b=VqOYx8x1bDNUzmv9Rw4i2vA/owzg0BIpRGl9KWN5ZYTQ27gaRH2CxrCzmKRr3NVWov
 XYbG3g9POX2CAkk4HAmEOmBN9Hzd6CuhdrYYitVBZ39DB9vDRPmoREMcmNR8aDKrHqXA
 OAlDFtTq5tyRApJRImhGhc7a8emPQqeTZJke00cVRZ2qgq96qJKSvIcJpuSELk/Q/AiR
 NW3hk5ytezFM+9nDWo0gxTCAA5p3PFpIVqVE4MAjXPPzp82Kitr/+w/0nVOeaH0LDAC/
 i6BBj+81jkeKNqObQIR5qou/n0lSoovua+2VT+Pzgvu05EIw79XEXXUXyWYXcTPWarTB
 tImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uuS19FigxfakDYnvbAFxrtuUuHeM+v/iuERCHWfI3vo=;
 b=YJhe+qXorW7J/PocnGvkOMWHtrBF/CdIN1JT2lvIyx3HhYVb6g5VETwPNWC+AUNcEH
 hzqqDDfFLypa9aQZ2X1zINnMrhwIF0jD/YJY0ey2BY0H2Z7xxI/2YLJkSP7Ck5l7JHAb
 bb+UfP/0/h6+vSm8hYMV/OvoEGhqywlmGuTX7KfSkpeA7iotu47fzi9jDZ7A4qfAmxU9
 C0bsBxc/iaENp480qynad5T575dgS6sk1E84v0sTvlnD9rJvfDaq09uz1e7+pxmdhlVL
 iYiGbRyp1NnXpOozchj3KMIn7Zv5EC/9+Xo1CVWUp2WWiSoo+Jjgzwp1vLVyIudElCrm
 06sw==
X-Gm-Message-State: APjAAAUl6HUn5KYevJ3hkkvhzLqGKSN1K1JEEibKw2YzR0POrFYAERQz
 CfHmdf3t80Tg47SlsNmNfJnJRHiqAYqsrH1cStADrpKSC1Y=
X-Google-Smtp-Source: APXvYqyxamQwBtVbn3EMfEbVBXSL/c/+KSoAeh7HrSM0V3HubzqEYm/MZVDIH+yfZMW+BWDzv8S8C51R2d+6E2Dq2sw=
X-Received: by 2002:aca:62d7:: with SMTP id w206mr940739oib.0.1567652395683;
 Wed, 04 Sep 2019 19:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190904065320.6005-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hD8SAFNNAWBP9q55wdPf-HYTEjpS4m+rT0VPoGodZULw@mail.gmail.com>
 <33b377ac-86ea-b195-fd83-90c01df604cc@linux.ibm.com>
In-Reply-To: <33b377ac-86ea-b195-fd83-90c01df604cc@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Sep 2019 19:59:43 -0700
Message-ID: <CAPcyv4hBHjrTSHRkwU8CQcXF4EHoz0rzu6L-U-QxRpWkPSAhUQ@mail.gmail.com>
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

> > Keep this 'static' there's no usage of this routine outside of pfn_devs.c
> >
> >>   {
> >> -       /*
> >> -        * This needs to be a non-static variable because the *_SIZE
> >> -        * macros aren't always constants.
> >> -        */
> >> -       const unsigned long supported_alignments[] = {
> >> -               PAGE_SIZE,
> >> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> -               HPAGE_PMD_SIZE,
> >> +       static unsigned long supported_alignments[3];
> >
> > Why is marked static? It's being dynamically populated each invocation
> > so static is just wasting space in the .data section.
> >
>
> The return of that function is address and that would require me to use
> a global variable. I could add a check
>
> /* Check if initialized */
>   if (supported_alignment[1])
>         return supported_alignment;
>
> in the function to updating that array every time called.

Oh true, my mistake. I was thrown off by the constant
re-initialization. Another option is to pass in the storage since the
array needs to be populated at run time. Otherwise I would consider it
a layering violation for libnvdimm to assume that
has_transparent_hugepage() gives a constant result. I.e. put this

        unsigned long aligns[4] = { [0] = 0, };

...in align_store() and supported_alignments_show() then
nd_pfn_supported_alignments() does not need to worry about
zero-initializing the fields it does not set.

> >> +       supported_alignments[0] = PAGE_SIZE;
> >> +
> >> +       if (has_transparent_hugepage()) {
> >> +
> >> +               supported_alignments[1] = HPAGE_PMD_SIZE;
> >> +
> >>   #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> >> -               HPAGE_PUD_SIZE,
> >> -#endif
> >> +               supported_alignments[2] = HPAGE_PUD_SIZE;
> >>   #endif
> >
> > This ifdef could be hidden in by:
> >
> > if IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> >
> > ...or otherwise moving this to header file with something like
> > NVDIMM_PUD_SIZE that is optionally 0 or HPAGE_PUD_SIZE depending on
> > the config
>
>
> I can switch to if IS_ENABLED but i am not sure that make it any
> different in the current code. So I will keep it same?

It at least follows the general guidance to keep #ifdef out of .c files.

>
> NVDIMM_PUD_SIZE is an indirection I find confusing.
>

Ok.

> >
> > Ok, this is better, but I think it can be clarified further.
> >
> > "For dax vmas, try to always use hugepage mappings. If the kernel does
> > not support hugepages, fsdax mappings will fallback to PAGE_SIZE
> > mappings, and device-dax namespaces, that try to guarantee a given
> > mapping size, will fail to enable."
> >
> > The last sentence about PAGE_SIZE namespaces is not relevant to
> > __transparent_hugepage_enabled(), it's an internal implementation
> > detail of the device-dax driver.
> >
>
> I will use the above update.
>

Thanks.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

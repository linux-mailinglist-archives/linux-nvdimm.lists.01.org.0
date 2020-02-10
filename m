Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8422F158224
	for <lists+linux-nvdimm@lfdr.de>; Mon, 10 Feb 2020 19:18:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9EB991007B189;
	Mon, 10 Feb 2020 10:22:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0AFA1007B189
	for <linux-nvdimm@lists.01.org>; Mon, 10 Feb 2020 10:22:07 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id j20so7323500otq.3
        for <linux-nvdimm@lists.01.org>; Mon, 10 Feb 2020 10:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sChepdk/YRCs175rH+BlGbDcDcJGkfdLslqExTb4U1g=;
        b=d+3c2VIOvcKpD1iC4w32tg1QuhpLzU51h/HM6XcbN433+JUsDqFG2Qx0edoUXCFafr
         jfWxRFfRvg56AaKAiVzr+eGt/v+rqb8/x1bGPk2Sj+igIx6Yk6Y5mGrgE0Fkia/mC10o
         0WJnXETrkVxIArvWeTLJCo57ea8AlILEl7EjWKMkzbyLmkSJVmSAenV0z4a0Ro9/Dnmv
         RsVv7iUNI/Dywc8nlEpHL4+pe5UDByGU6RrDf5jw96fUvGrVlohdShByE7KcXD/cxHCa
         dYrMXaE2hAiAoENR22SpbnL3IKy9UGXpwNaK9+avYdM8rYve36W+4uQttpacr+XZIb4h
         kyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sChepdk/YRCs175rH+BlGbDcDcJGkfdLslqExTb4U1g=;
        b=n2Hczdi6NZJSRvEDrG9bVg4nN6nETtfxzkpj9s7oAZXBhuquI7ISEVihqoikzQmG1K
         IKsQUriwDvAqfWkSoO4JD8Jqc77lf/XBDQ9g/W1HBedQis2q297VA6t0DDP4Q27HUVLf
         HFK18CZROY5wXtD4omQ5xCdzJ0Vp/LSWCfvSRBxu9puOJ0lJ+8uI28iVZVCydZvF+dtm
         rxtA0CoPs083RknL1SN+d9MrhthPYkx+JA63MVKcTZ6fN94FrUBU1pgnTC8GAyfucZGm
         GJ3Qft5q5TzqMgCgvNQv7gYtaOVPXSDl7O2NIF204ZRRPdyRXlnf0EcPAQ5OaUp7Dkpc
         0qjw==
X-Gm-Message-State: APjAAAWdTR8clIsuhoHNhD2js0rPRMnPp2IRxqjnIHtmKRFhe3u6VIVW
	VAkRHOPD70S/L0mzwgJtfMWTmwy4d6vB/3NvlOtoyA==
X-Google-Smtp-Source: APXvYqw5dqlbFTDvCEPFe2LoGhASJEseZ0YYyWL4QJ9Xa9w78JPVLSL/kfwVyCTB+RCGG1wYY0Truua6n8OTOyd8Tb0=
X-Received: by 2002:a9d:1284:: with SMTP id g4mr1983799otg.207.1581358729382;
 Mon, 10 Feb 2020 10:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20200205052056.74604-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hBAk-dwO4=AT7cQm5YUwCBg0AECsZsiCjRJ_ZGWvWUAw@mail.gmail.com> <87y2ta8qy7.fsf@linux.ibm.com>
In-Reply-To: <87y2ta8qy7.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 10 Feb 2020 10:18:38 -0800
Message-ID: <CAPcyv4hNV88FJybgoRyM=JuKgrwYaf+CLWfFWt5X3yFMrecU=Q@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm: Update persistence domain value for of_pmem
 and papr_scm device
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: 4LS5QXNQNT2BJFLERJ4AAFG4LYNTFU34
X-Message-ID-Hash: 4LS5QXNQNT2BJFLERJ4AAFG4LYNTFU34
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4LS5QXNQNT2BJFLERJ4AAFG4LYNTFU34/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 10, 2020 at 6:20 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Tue, Feb 4, 2020 at 9:21 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> Currently, kernel shows the below values
> >>         "persistence_domain":"cpu_cache"
> >>         "persistence_domain":"memory_controller"
> >>         "persistence_domain":"unknown"
> >>
> >> "cpu_cache" indicates no extra instructions is needed to ensure the persistence
> >> of data in the pmem media on power failure.
> >>
> >> "memory_controller" indicates platform provided instructions need to be issued
> >
> > No, it does not. The only requirement implied by "memory_controller"
> > is global visibility outside the cpu cache. If there are special
> > instructions beyond that then it isn't persistent memory, at least not
> > pmem that is safe for dax. virtio-pmem is an example of pmem-like
> > memory that is not enabled for userspace flushing (MAP_SYNC disabled).
> >
>
> Can you explain this more? The way I was expecting the application to
> interpret the value was, a regular store instruction doesn't guarantee
> persistence if you find the "memory_controller" value for
> persistence_domain. Instead, we need to make sure we flush data to the
> controller at which point the platform will take care of the persistence in
> case of power loss. How we flush data to the controller will also be
> defined by the platform.

If the platform requires any flush mechanism outside of the base cpu
ISA of cache flushes and memory barriers then MAP_SYNC needs to be
explicitly disabled to force the application to call fsync()/msync().
Then those platform specific mechanisms need to be triggered through a
platform-aware driver.

>
>
> >> as per documented sequence to make sure data get flushed so that it is
> >> guaranteed to be on pmem media in case of system power loss.
> >>
> >> Based on the above use memory_controller for non volatile regions on ppc64.
> >>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> ---
> >>  arch/powerpc/platforms/pseries/papr_scm.c | 7 ++++++-
> >>  drivers/nvdimm/of_pmem.c                  | 4 +++-
> >>  include/linux/libnvdimm.h                 | 1 -
> >>  3 files changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> >> index 7525635a8536..ffcd0d7a867c 100644
> >> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> >> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> >> @@ -359,8 +359,13 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
> >>
> >>         if (p->is_volatile)
> >>                 p->region = nvdimm_volatile_region_create(p->bus, &ndr_desc);
> >> -       else
> >> +       else {
> >> +               /*
> >> +                * We need to flush things correctly to guarantee persistance
> >> +                */
> >
> > There are never guarantees. If you're going to comment what does
> > software need to flush, and how?
>
> Can you explain why you say there are never guarantees? If you follow the platform
> recommended instruction sequence to flush data, we can be sure of data
> persistence in the pmem media.

Because storage can always fail. You can reduce risk, but never
eliminate it. This is similar to SSDs that use latent capacitance to
flush their write caches on driver power loss. Even if the application
successfully flushes its writes to buffers that are protected by that
capacitance that power source can still (and in practice does) fail.

>
>
> >
> >> +               set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
> >>                 p->region = nvdimm_pmem_region_create(p->bus, &ndr_desc);
> >> +       }
> >>         if (!p->region) {
> >>                 dev_err(dev, "Error registering region %pR from %pOF\n",
> >>                                 ndr_desc.res, p->dn);
> >> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> >> index 8224d1431ea9..6826a274a1f1 100644
> >> --- a/drivers/nvdimm/of_pmem.c
> >> +++ b/drivers/nvdimm/of_pmem.c
> >> @@ -62,8 +62,10 @@ static int of_pmem_region_probe(struct platform_device *pdev)
> >>
> >>                 if (is_volatile)
> >>                         region = nvdimm_volatile_region_create(bus, &ndr_desc);
> >> -               else
> >> +               else {
> >> +                       set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
> >>                         region = nvdimm_pmem_region_create(bus, &ndr_desc);
> >> +               }
> >>
> >>                 if (!region)
> >>                         dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
> >> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> >> index 0f366706b0aa..771d888a5ed7 100644
> >> --- a/include/linux/libnvdimm.h
> >> +++ b/include/linux/libnvdimm.h
> >> @@ -54,7 +54,6 @@ enum {
> >>         /*
> >>          * Platform provides mechanisms to automatically flush outstanding
> >>          * write data from memory controler to pmem on system power loss.
> >> -        * (ADR)
> >
> > I'd rather not delete critical terminology for a developer / platform
> > owner to be able to consult documentation, or their vendor. Can you
> > instead add the PowerPC equivalent term for this capability? I.e. list
> > (x86: ADR PowerPC: foo ...).
>
> Power ISA doesn't clearly call out what mechanism will be used to ensure
> that a load following power loss will return the previously flushed
> data. Hence there is no description of details like Asynchronous DRAM
> Refresh. Only details specified is with respect to flush sequence that ensures
> that a load following power loss will return the value stored.

What is this "flush sequence"?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

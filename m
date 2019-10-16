Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF81AD9654
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Oct 2019 18:04:20 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C35F10FC5F97;
	Wed, 16 Oct 2019 09:07:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C71BD100EEB81
	for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 09:07:15 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id g81so2310816oib.8
        for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3i66R1nQF4BW5QIELn4LwAoODMFrx9PUNoCb2KoP4M=;
        b=HRx6N9AWDW0uf3nQC/FYAC3VGKrrXrdifoEojF2JvAMRip3Vq06StLDy1LjP+G/yJz
         F+QohsXwEQTyi0njCwav9cKCUDeP8dxZvDpsAQL1VjlhWozziZ7xCQDf59KehwCMkhWO
         ZHsHBCpNN+okeNWdc506GfhqqMx5xbpW0GLyBlVSKtYfe76zw5fP5DTrGLCkPQFczUQd
         3b5huI81DUtDDCF/L9e96obwiHaCF+JgR6OCZrOUApb/zMIz1Sc8PMsE6I21Qm5svXw/
         rkiJ1L0J3iTeTFg9MZRc2JVYW49hu4oB8Gg1ksGDi+D2MxHrPteOPNiK4JFO2oCMvUK+
         I3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3i66R1nQF4BW5QIELn4LwAoODMFrx9PUNoCb2KoP4M=;
        b=lajf8CSKSyzi5XBqHilbUPL/UC3sYqkgrvMji7G+N+ZYA8vO7XIzW6ljVrvO+Png+z
         7uVo42xCfFp4IysjGPhtBTAAAP0/5pZ289PBPpBz6J/FVmoG5o/2Fm06iyNj90efWwqD
         9dO3wfxTHc2Grf7x9223n5lSJT8fIdfpBD2+7evepJ4h6F7h6SfAjwzK1YJJ0HhwLvqm
         v4+gfizoD+QXfgbth5QsNWR8CTXvWKJ75m8p2/cso7vxryryzGXRJr1IyOzvURYQQDNT
         iF541EctA+ym+s41Uimj6nEyfiyImA2ti98nnNfzzscZDpF9/44PyfBsAMnnQIqaSHgd
         m4LA==
X-Gm-Message-State: APjAAAXgjYxOQ0RAbgRN+OoXPF1c92maNcGeclm7dqBEWsJ6zXgODkgS
	4KkHTMvCHZhzUWIphfIh8PMKHfjQ7qOA2MB9q92L5g==
X-Google-Smtp-Source: APXvYqwt7vrqiXms8zM1YILhBxYHC3PYHY3wAPcpFhWjvhSlbxxQAqvcI08zeflbqHUs5c2qmlcnEGpK1WjFR5weiXU=
X-Received: by 2002:aca:620a:: with SMTP id w10mr4258641oib.0.1571241855564;
 Wed, 16 Oct 2019 09:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ihjGGAOF0NK_23yuOpsdBY7M=UZWNt1KN3WnP_e9WZOg@mail.gmail.com> <7376f286-0947-61aa-7ebf-c50f32642ed8@linux.ibm.com>
In-Reply-To: <7376f286-0947-61aa-7ebf-c50f32642ed8@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Oct 2019 09:04:02 -0700
Message-ID: <CAPcyv4jrdAAxtrre4Ypt-+ZpuqKia5kLwCO4qfryshhxVj6eFA@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] libnvdimm/nsio: differentiate between probe
 mapping and runtime mapping
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: TMH7MMSINIMGN7UMICIKNERNZ563T3NH
X-Message-ID-Hash: TMH7MMSINIMGN7UMICIKNERNZ563T3NH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TMH7MMSINIMGN7UMICIKNERNZ563T3NH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 15, 2019 at 10:29 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 10/16/19 3:32 AM, Dan Williams wrote:
> > On Tue, Oct 15, 2019 at 8:33 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> nvdimm core currently maps the full namespace to an ioremap range
> >> while probing the namespace mode. This can result in probe failures
> >> on architectures that have limited ioremap space.
> >
> > Is there a #define for that limit?
> >
>
> Arch specific #define. For example. ppc64 have different limits based on
> platform and translation mode. Hash translation with 4k PAGE_SIZE limit
> ioremap range to 8TB.
>
> >> nvdimm core can avoid this failure by only mapping the reserver block area to
> >> check for pfn superblock type and map the full namespace resource only before
> >> using the namespace. nvdimm core use ioremap range only for the raw and btt
> >> namespace and we can limit the max namespace size for these two modes. For
> >> both fsdax and devdax this change enables nvdimm to map namespace larger
> >> that ioremap limit.
> >
> > If the direct map has more space I think it would be better to add a
> > way to use that to map for all namespaces rather than introduce
> > arbitrary failures based on the mode.
> >
> > I would buy a performance argument to avoid overmapping, but for
> > namespace access compatibility where an alternate mapping method would
> > succeed I think we should aim for that to be used instead. Thoughts?
> >
>
> That would require to have struct page allocated for these range and
> both raw and btt don't need a struct page backing?
>

I was thinking a new mapping interface that just consumed direct-map
space, but did not allocate pages.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFFED99AD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Oct 2019 21:05:51 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BBDA510FCC4D9;
	Wed, 16 Oct 2019 12:08:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A032C10FCC4D8
	for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 12:08:46 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a15so21024496oic.0
        for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDNsQLxUUkr4WV/+njtErwHGyCeLATLfTiDLP7OEdhs=;
        b=RerZ/bM8GMWNoY3IDcCUn4nxeDYPYOF9UTKSF2m9KGkIvcUCFk3F6lTgo7FvE4quC8
         XgHkpqZNYU4c5DUnaeVNptngq8lIpAIvjBYniI7kScjT+le0dWJC5d0jUPUaNAeQl2zk
         /ovrB+SugnC31MqHIFjMFgmXFV5trFKCN3+FfA10jXtFsdlwnOX4IwGv9J7HVGXQ/a/A
         ErT7SXK1OuMoznnRmW4GBN8MvlU4AnPrcYEiAHPQsvaDgxoVwgsPIb2YGCPAHDXVMig4
         3f4nVSLbNoxSOA4YYXeFL4WFqwIjy56biLmOF6QAMQd4beGXLTI4U2tx9ymC236/loMr
         0q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDNsQLxUUkr4WV/+njtErwHGyCeLATLfTiDLP7OEdhs=;
        b=POwk5BhKBA+xsLix0fJWC5mYl4sBsXPHB26JRUJm0NQ1oUUuvNVfKwM39bNCNCKQz1
         jfygHxXSZa/xU/HG+njuDJOJ5S/ImSZT4eHUnzDTorXACuP3NEhZ4KP7HFmYaeBizESB
         obRJmoLwGxsVOT3RRoZzXNaTTeluRfZvRttpb/Mzm3PcC1fkDZEDmGcURC2W3U1wUOnR
         7aGBXbznYLLm0Gf04MTRESyBAhLcYr0xMQLoTJWC4rynZUZG+QIFsl1gUSrslTb98Um3
         Wt6jS90/nR24x8jto7lKLsVR/8hTP4smEtIZd3+F7c/fUKhmhJdfVyy4gGENoxHuzGfB
         WWhA==
X-Gm-Message-State: APjAAAUE5JTCjAwsKHG2pLLUhINXK2XnGqlBRHNS2q5K2UveM4sNlTWq
	tfDASQPvRi8w4C5wEbTeWFD+qR84K7qhOMwT3d4NkaPG
X-Google-Smtp-Source: APXvYqwWylI1HNv1rAXZdz4gHBznmjdnPoT94vivUltVd0l/pmKQqeGWkmpFL65HPprNwKXqGwehxtgyLxE5wMKVndI=
X-Received: by 2002:aca:5dd5:: with SMTP id r204mr4540060oib.73.1571252746636;
 Wed, 16 Oct 2019 12:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ihjGGAOF0NK_23yuOpsdBY7M=UZWNt1KN3WnP_e9WZOg@mail.gmail.com>
 <7376f286-0947-61aa-7ebf-c50f32642ed8@linux.ibm.com> <CAPcyv4jrdAAxtrre4Ypt-+ZpuqKia5kLwCO4qfryshhxVj6eFA@mail.gmail.com>
 <2144f6dc-faab-3e93-d049-cc146c38258a@linux.ibm.com>
In-Reply-To: <2144f6dc-faab-3e93-d049-cc146c38258a@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Oct 2019 12:05:34 -0700
Message-ID: <CAPcyv4iAz1OSDCKhNt+weBOTg1OsKbs6h740vG8P2NxRHbUrPw@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] libnvdimm/nsio: differentiate between probe
 mapping and runtime mapping
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: 2Z6FLAI53JOJFKECFBZRG32WQ72EQQMW
X-Message-ID-Hash: 2Z6FLAI53JOJFKECFBZRG32WQ72EQQMW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2Z6FLAI53JOJFKECFBZRG32WQ72EQQMW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 16, 2019 at 9:59 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 10/16/19 9:34 PM, Dan Williams wrote:
> > On Tue, Oct 15, 2019 at 10:29 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 10/16/19 3:32 AM, Dan Williams wrote:
> >>> On Tue, Oct 15, 2019 at 8:33 AM Aneesh Kumar K.V
> >>> <aneesh.kumar@linux.ibm.com> wrote:
> >>>>
> >>>> nvdimm core currently maps the full namespace to an ioremap range
> >>>> while probing the namespace mode. This can result in probe failures
> >>>> on architectures that have limited ioremap space.
> >>>
> >>> Is there a #define for that limit?
> >>>
> >>
> >> Arch specific #define. For example. ppc64 have different limits based on
> >> platform and translation mode. Hash translation with 4k PAGE_SIZE limit
> >> ioremap range to 8TB.
> >>
> >>>> nvdimm core can avoid this failure by only mapping the reserver block area to
> >>>> check for pfn superblock type and map the full namespace resource only before
> >>>> using the namespace. nvdimm core use ioremap range only for the raw and btt
> >>>> namespace and we can limit the max namespace size for these two modes. For
> >>>> both fsdax and devdax this change enables nvdimm to map namespace larger
> >>>> that ioremap limit.
> >>>
> >>> If the direct map has more space I think it would be better to add a
> >>> way to use that to map for all namespaces rather than introduce
> >>> arbitrary failures based on the mode.
> >>>
> >>> I would buy a performance argument to avoid overmapping, but for
> >>> namespace access compatibility where an alternate mapping method would
> >>> succeed I think we should aim for that to be used instead. Thoughts?
> >>>
> >>
> >> That would require to have struct page allocated for these range and
> >> both raw and btt don't need a struct page backing?
> >>
> >
> > I was thinking a new mapping interface that just consumed direct-map
> > space, but did not allocate pages.
> >
>
> Not sure how easy that would be. We are looking at having part of
> direct-map address not managed by any zone and then possibly archs need
> to be taught to handle these ? (for example for ppc64 we "bolt" direct
> map range where as we allow taking low level hash fault for I/O remap range)
>
> Even though you don't consider the patch as complete, considering the
> approach you outlined would require larger changes, do you think this
> patch can be accepted as a bug fix? Right now we can fail namespace
> initialization during boot or ndctl enable-namespace all.
>
> For example with ppc64 and I/O remap range limit of 8TB, we can
> individually create a 6TB namespace. We also allow to create multiple
> such namespaces. But if we try to enable them all together using ndctl
> enable-namespace all, that will fail with error
>
> [   54.259910] vmap allocation for size x failed: use vmalloc=<size> to
> increase size
>
> because we probe these namespaces in parallel.

The patch is incomplete, right? It does not fix the raw mode namespace
case, and that error message seems to indicate to the user how to fix
the problem. I was of the impression it was a fixed range in the
address map. Could you instead try to autodetect the potential pmem
usage and auto increase the vmap space?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F89DA416
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Oct 2019 05:04:22 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6298C10FCDE5C;
	Wed, 16 Oct 2019 20:07:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 01B3C10FCDE5B
	for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 20:07:17 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g13so591351otp.8
        for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bD+vvNiHzF7NDW368hIfDOcWDZ7Gue2jGED+KmWHKf4=;
        b=tw5g26dPRSAdb1Q7Gt3cECsqDGehvKaiJtXLeY5Wi8j45sXQE9mmfczJjWxsiOxB0B
         sKepEsLSddYFpqpPcO6bhMdPd5/CKti687zwiMqox/g329NLnBgX1Zyv+d6HTfv7Kcfo
         HrCFp0CN7rwIAnDCtIOXDyype0S+mxB+LSfdi0SAI6QVENbOlguC1EO3TAOGmjUJgFQx
         o48z1pWXIp0misS/jORscqkRc4crRlRIpP/vH7mTHXN5ca5pikksiLXDa6pj5FeuwUgc
         9ZG1BW4J2RWUXi35TmgYQsX0OHihRHAL2fdJK9zlHO63VYmweVALUMoixZ1k7k5w1nzz
         xjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bD+vvNiHzF7NDW368hIfDOcWDZ7Gue2jGED+KmWHKf4=;
        b=K4cnBkfY+1Kmi5z/CYFCHCq7CAS9cdoOclcpKk/rkhghm2U2r46fUZcfgtD6V17iao
         FS8H5RGvRQMaKJNvWGEzA+WLxyj2dbpCqALm1733s/8yIq4bP2D47oBu+bKEBCpDeFf/
         LW0eDCt7rwECp8DZjlZ5Jk8wX++Z+XYVRf4/U1j5/HwEWtDIsmA4oJjPBNNztnqBb2Gf
         HaStY/VNa4bUkxU/Buu1iVNWLCTglnHvTNY2az5E+zqZP5wnsK4fe2/RqUC1GM/UetRA
         fIL5pFnC5uZ6LdbAMWXIKdVWz50k4dwIwlx+Qmm/zKv77EorPWj4R7zKn5SE246i5m2W
         BNqQ==
X-Gm-Message-State: APjAAAURD7w6hY8WFv8AYNDBN73xRmp0PiRE/1Q7Tpn2RwIqhWArQR+O
	q6WfzyUpQdTox5hU3uQIfDZVaqTwUue7zcKyHTAdPPW1
X-Google-Smtp-Source: APXvYqz6NcXYmVwsHRgG0oB0UfvOPf7DxgH0vaFTjxCa9tm9/P8Y1L1yO4UnGK0ui/JHQr7L85lYRGaGcg9LTkhn1Ms=
X-Received: by 2002:a05:6830:15ca:: with SMTP id j10mr1072043otr.247.1571281458274;
 Wed, 16 Oct 2019 20:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ihjGGAOF0NK_23yuOpsdBY7M=UZWNt1KN3WnP_e9WZOg@mail.gmail.com>
 <7376f286-0947-61aa-7ebf-c50f32642ed8@linux.ibm.com> <CAPcyv4jrdAAxtrre4Ypt-+ZpuqKia5kLwCO4qfryshhxVj6eFA@mail.gmail.com>
 <2144f6dc-faab-3e93-d049-cc146c38258a@linux.ibm.com> <CAPcyv4iAz1OSDCKhNt+weBOTg1OsKbs6h740vG8P2NxRHbUrPw@mail.gmail.com>
 <07a4dd71-65f0-a911-60be-e3ea1ce8305b@linux.ibm.com>
In-Reply-To: <07a4dd71-65f0-a911-60be-e3ea1ce8305b@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Oct 2019 20:04:06 -0700
Message-ID: <CAPcyv4grR0o5jRH+hqPNqDW8rCmU4bUfctzPxGUg+mZN9h_8TQ@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] libnvdimm/nsio: differentiate between probe
 mapping and runtime mapping
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: QHSLQEOMFIDHK5K7XEBGOPAOMXLMWB2E
X-Message-ID-Hash: QHSLQEOMFIDHK5K7XEBGOPAOMXLMWB2E
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QHSLQEOMFIDHK5K7XEBGOPAOMXLMWB2E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 16, 2019 at 7:43 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 10/17/19 12:35 AM, Dan Williams wrote:
> > On Wed, Oct 16, 2019 at 9:59 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 10/16/19 9:34 PM, Dan Williams wrote:
> >>> On Tue, Oct 15, 2019 at 10:29 PM Aneesh Kumar K.V
> >>> <aneesh.kumar@linux.ibm.com> wrote:
> >>>>
> >>>> On 10/16/19 3:32 AM, Dan Williams wrote:
> >>>>> On Tue, Oct 15, 2019 at 8:33 AM Aneesh Kumar K.V
> >>>>> <aneesh.kumar@linux.ibm.com> wrote:
> >>>>>>
> >>>>>> nvdimm core currently maps the full namespace to an ioremap range
> >>>>>> while probing the namespace mode. This can result in probe failures
> >>>>>> on architectures that have limited ioremap space.
> >>>>>
> >>>>> Is there a #define for that limit?
> >>>>>
> >>>>
> >>>> Arch specific #define. For example. ppc64 have different limits based on
> >>>> platform and translation mode. Hash translation with 4k PAGE_SIZE limit
> >>>> ioremap range to 8TB.
> >>>>
> >>>>>> nvdimm core can avoid this failure by only mapping the reserver block area to
> >>>>>> check for pfn superblock type and map the full namespace resource only before
> >>>>>> using the namespace. nvdimm core use ioremap range only for the raw and btt
> >>>>>> namespace and we can limit the max namespace size for these two modes. For
> >>>>>> both fsdax and devdax this change enables nvdimm to map namespace larger
> >>>>>> that ioremap limit.
> >>>>>
> >>>>> If the direct map has more space I think it would be better to add a
> >>>>> way to use that to map for all namespaces rather than introduce
> >>>>> arbitrary failures based on the mode.
> >>>>>
> >>>>> I would buy a performance argument to avoid overmapping, but for
> >>>>> namespace access compatibility where an alternate mapping method would
> >>>>> succeed I think we should aim for that to be used instead. Thoughts?
> >>>>>
> >>>>
> >>>> That would require to have struct page allocated for these range and
> >>>> both raw and btt don't need a struct page backing?
> >>>>
> >>>
> >>> I was thinking a new mapping interface that just consumed direct-map
> >>> space, but did not allocate pages.
> >>>
> >>
> >> Not sure how easy that would be. We are looking at having part of
> >> direct-map address not managed by any zone and then possibly archs need
> >> to be taught to handle these ? (for example for ppc64 we "bolt" direct
> >> map range where as we allow taking low level hash fault for I/O remap range)
> >>
> >> Even though you don't consider the patch as complete, considering the
> >> approach you outlined would require larger changes, do you think this
> >> patch can be accepted as a bug fix? Right now we can fail namespace
> >> initialization during boot or ndctl enable-namespace all.
> >>
> >> For example with ppc64 and I/O remap range limit of 8TB, we can
> >> individually create a 6TB namespace. We also allow to create multiple
> >> such namespaces. But if we try to enable them all together using ndctl
> >> enable-namespace all, that will fail with error
> >>
> >> [   54.259910] vmap allocation for size x failed: use vmalloc=<size> to
> >> increase size
> >>
> >> because we probe these namespaces in parallel.
> >
> > The patch is incomplete, right?
>
> Incomplete with respect to the detail that we still don't allow large
> raw and btt namespaces.
>
>
> > It does not fix the raw mode namespace
> > case, and that error message seems to indicate to the user how to fix
> > the problem. I was of the impression it was a fixed range in the
> > address map. Could you instead try to autodetect the potential pmem
> > usage and auto increase the vmap space?
> >
> The error is printed by generic code and the failures are due to fixed
> size. We can't workaround that using vmalloc=<size> option.

Darn.

Ok, explain to me again how this patch helps. This just seems to delay
the inevitable failure a bit, but the end result is that the user
needs to pick and choose which namespaces to enable after the kernel
has tried to auto-probe namespaces.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

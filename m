Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE66FF4C7
	for <lists+linux-nvdimm@lfdr.de>; Sat, 16 Nov 2019 19:50:46 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AFCF7100EA529;
	Sat, 16 Nov 2019 10:51:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 107E0100EA63E
	for <linux-nvdimm@lists.01.org>; Sat, 16 Nov 2019 10:51:54 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 94so10927430oty.8
        for <linux-nvdimm@lists.01.org>; Sat, 16 Nov 2019 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoYFZW9R1d8a2jA7OF9LL6qxm9ECdf9uJSjSEMDuhDQ=;
        b=npL0W9KgorQAYQRc87V3l+lkInNdHmoUmlKoaS30Qz8h1kbbszoWt+depF0Asu7mxl
         aqcsnvAYqLcf7/ASn7KEcz1nvZT+6EhXPwSFHVsh4UhMXGm/NbCH/WT5iF83p1KwmVdU
         mQcUOdNWqu8v8GtDHZmjwOL8D9F+qoBq5eXZ7HRjT5UEiVHxHnVa+vNAWpy7kswffPO1
         bwgXM6UixEyqVPlL2Wom470LfwdUXvvP6QVfk3q/t0wJGgMcqDuZt8bh6oc9k6L3q9t2
         yW/ZV4PTuSEdqXMed4ig6v5vfF9zhU+7WSjTNI2tIeOu7n7O2Y5HJYZ4/BpCKFv8jFDa
         ni4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoYFZW9R1d8a2jA7OF9LL6qxm9ECdf9uJSjSEMDuhDQ=;
        b=J0nvbsdA86GvrSrG5fcqRqjtBZTHHSVctj/JwKUSYvVM0xahiJgBNJuDFUiNfb0MYv
         jEe7MUJkOb7U55RMIY/hq2MxJInB0uj71FBePi/HyGXORtThMmDOCONSg15k8tGvmOPl
         Vtr+m99Nt45oC2uZjkBQLuOSPVsvbCn8sHOsz72te60kmDaUrpMgP/joJEUdRWdZgU/G
         GN8zI1OqGgmPVVWEf99KxSUEQ3keA/+e2dHzfK2HaAMQacqs0Nz+yAj1Djaob3qi05lU
         AVKJGTbuSVJX4GdwgWMfaq90oo3ruS7oLQO4Nl2oQzBWRsO45zAnRWhE/m5+PxMoJhoo
         cvXg==
X-Gm-Message-State: APjAAAXIri76x1mELpRrnGpuDQ6Z7ggZPfpZwAdL0bV8bleFYcaeKyTT
	xpEdb3IBvQU59O/5frSkEt7UHdhz4K4y9oiXPAtbJQ==
X-Google-Smtp-Source: APXvYqyV/cgXxJSpVo+ep5Esuuu5uBbs9hzmhs5nbRzcUIbnZl99SOr9AdH9+7qoOn5QBj9jKBAQfldWgdn4Wt7pPjc=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr2604806otb.126.1573930240792;
 Sat, 16 Nov 2019 10:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4gZ=wKzwscu_nch8VUtNTHusKzjmMhYZWo+Se=BPO9q8g@mail.gmail.com>
 <6f85f4af-788d-aaef-db64-ab8d3faf6b1b@linux.ibm.com> <CAPcyv4gMnSe26QfSBABx0zj3XuFqy=K1XaGnmE3h3sP3Y76nRw@mail.gmail.com>
 <4c6e5743-663e-853b-2203-15c809965965@linux.ibm.com> <CAPcyv4h42_1deZDaaW1RqX0Ls+maiFO_1e=6xJuHTa3wdWvVvA@mail.gmail.com>
 <87o8xp5lo9.fsf@linux.ibm.com> <8736eohva1.fsf@linux.ibm.com>
In-Reply-To: <8736eohva1.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 16 Nov 2019 10:50:29 -0800
Message-ID: <CAPcyv4hroohsrXT1YHQB-L8ZFa2kUW+bKy03We4Mt7afeJgu3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: G2GOOB7SC47SB7HAUGRKQKDEHTDNPD2X
X-Message-ID-Hash: G2GOOB7SC47SB7HAUGRKQKDEHTDNPD2X
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G2GOOB7SC47SB7HAUGRKQKDEHTDNPD2X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Nov 16, 2019 at 4:15 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
>
> Hi Dan,
>
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
> > Dan Williams <dan.j.williams@intel.com> writes:
> >
> >> On Wed, Oct 30, 2019 at 10:35 PM Aneesh Kumar K.V
> >> <aneesh.kumar@linux.ibm.com> wrote:
> >> [..]
> >>> > True, for the pfn device and the device-dax mapping size, but I'm
> >>> > suggesting adding another instance of alignment control at the raw
> >>> > namespace level. That would need to be disconnected from the
> >>> > device-dax page mapping granularity.
> >>> >
> >>>
> >>> Can you explain what you mean by raw namespace level ? We don't have
> >>> multiple values against which we need to check the alignment of
> >>> namespace start and namespace size.
> >>>
> >>> If you can outline how and where you would like to enforce that check I
> >>> can start working on it.
> >>>
> >>
> >> What I mean is that the process of setting up a pfn namespace goes
> >> something like this in shell script form:
> >>
> >> 1/ echo $size > /sys/bus/nd/devices/$namespace/size
> >> 2/ echo $namespace > /sys/bus/nd/devices/$pfn/namespace
> >> 3/ echo $pfn_align > /sys/bus/nd/devices/$pfn/align
> >>
> >> What I'm suggesting is add an optional 0th step that does:
> >>
> >> echo $raw_align > /sys/bus/nd/devices/$namespace/align
> >>
> >> Where the raw align needs to be needs to be max($pfn_align,
> >> arch_mapping_granulariy).
> >
> >
> > I started looking at this and was wondering about userspace being aware
> > of the direct-map mapping size. We can figure that out by parsing kernel
> > log
> >
> > [    0.000000] Page orders: linear mapping = 24, virtual = 16, io = 16, vmemmap = 24
> >
> >
> > But I am not sure we want to do that. There is not set of raw_align
> > value to select. What we need to make sure is the below.
> >
> > 1) While creating a namespace we need to make sure that namespace size
> > is multiple of direct-map mapping size. If we ensure that
> > size is aligned, we should also get the namespace start to be aligned?
> >
> > 2) While initialzing a namespace by scanning label area, we need to make
> > sure every namespace in the region satisfy the above requirement. If not
> > we should mark the region disabled.
> >
> >
> >>
> >> So on powerpc where PAGE_SIZE < arch_mapping_granulariy, the following:
> >>
> >> cat /sys/bus/nd/devices/$namespace/supported_aligns
> >>
> >> ...would show the same output as:
> >>
> >> cat /sys/bus/nd/devices/$pfn/align
> >>
> >> ...but with any alignment choice less than arch_mapping_granulariy removed.
> >>
> >
> > I am not sure why we need to do that. For example: even if we have
> > direct-map mapping size as PAGE_SIZE (64K), we still should allow an user
> > mapping with hugepage size (16M)?
> >
>
>
> Considering the direct-map map size is not going to be user selectable,
> do you agree that we can skip the above step 0 configuration you
> suggested.
>
> The changes proposed in the patch series essentially does the rest.
>
> 1) It validate the size against the arch specific limit during
> namespace creation. (part of step 1)

This validation is a surprise failure to ndctl.

> 2) It also disable initializing a region if it find the size not
> correctly aligned as per the platform requirement.

There needs to be a way for the user to discover the correct alignment
that the kernel will accept.

> 3) Direct map  mapping size is different from supported_alignment for a
> namespace. The supported alignment controls what possible PAGE SIZE user want the
> namespace to be mapped to user space.

No, the namespace alignment is different than the page mapping size.
The alignment is only interpreted as a mapping size at the device-dax
level, otherwise at the raw namespace level it's just an arbitrary
alignment.

> With the above do you think the current patch series is good?

I don't think we've quite converged on a solution.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

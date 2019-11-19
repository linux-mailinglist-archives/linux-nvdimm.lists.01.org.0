Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88F6102B48
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 Nov 2019 18:58:35 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 47770100DC437;
	Tue, 19 Nov 2019 09:59:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DCBD100EEB86
	for <linux-nvdimm@lists.01.org>; Tue, 19 Nov 2019 09:59:21 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id n14so19756553oie.13
        for <linux-nvdimm@lists.01.org>; Tue, 19 Nov 2019 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W70Dd9++ZO+cJQuc5kJAdml8AzpMFX92tNHeKLr25d4=;
        b=aSUTdUSRb84RDwuBj3LwL4hJWu/PMg141sk/jVAQXSSvAo9TxqDQL9usQEZCSvUubx
         +aVCzipgjxxXZVC5ZdcxnYbDsznecvkJsY2CYHhCnSed0nfMb2e6JfgVIRCb4AzgFsM3
         2EnztEkuKAdcNFE9y0B0QffvwAPbqjDcThcRMO8LdtGfAp6qpspqAPeqPoXcDXwG2mSB
         OcLFX3DaqyrY2SUJ+ebqiPDgAyql2yYgUN9bcObrAC5tCy2MMGgsROECPpqg8SrKsMaY
         WanejoLjUYkk9LyWU4dK6u5taGxQ52diDwe8kPjwVChus/KnISMyKQFJrLxww2riJ7R9
         352w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W70Dd9++ZO+cJQuc5kJAdml8AzpMFX92tNHeKLr25d4=;
        b=ZHWf5TqhqIxPp+LS3jGNHBqA/LPTGqQwqhZJRyasZZACFj9Bc0P66BSy/j3YFdt9aT
         P18MI2Fsb5DDhMb+rknhRewEz5/5k/3ik3c3IbkU3H638C1Uvp8lZddN7E4FdX/UIo9o
         nPFoiM0w9darDBcNESavMAKt4b5g5PDJC03hHd0Ef+6XY0vemCBSLXW8ROun62MdUpZt
         oK3V+PY4EdDPkLBzgW5dCU0K/7rQHQr1Vt0a/JSJeS1r1z20Pp8p7EC55grAF1T3w1aF
         L06t5S+3JxR7EZmYLKAkwYEk4tG0iWRn6IM8yf5GNyRUC2hTfdDd8VxKIqd7n5OFX6kv
         3t/A==
X-Gm-Message-State: APjAAAU/3Ptr7DPp6/r5T+8DoQwv/t3ZkCNFUssjIUiO1ewWKdhQJf4I
	4xTIS0TpJckYgcPWdhIb2oHkIKWpksq67vq60WhXyQ==
X-Google-Smtp-Source: APXvYqxkb/ytJxhm3fBx0vpuOTOr6uVOwTucEuRFfFGAk5DEmSaBE8Dublz/uwuCgG1VY0XdBdv+bQsMJt4kiHYBono=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr5525622oib.105.1574186310882;
 Tue, 19 Nov 2019 09:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4gZ=wKzwscu_nch8VUtNTHusKzjmMhYZWo+Se=BPO9q8g@mail.gmail.com>
 <6f85f4af-788d-aaef-db64-ab8d3faf6b1b@linux.ibm.com> <CAPcyv4gMnSe26QfSBABx0zj3XuFqy=K1XaGnmE3h3sP3Y76nRw@mail.gmail.com>
 <4c6e5743-663e-853b-2203-15c809965965@linux.ibm.com> <CAPcyv4h42_1deZDaaW1RqX0Ls+maiFO_1e=6xJuHTa3wdWvVvA@mail.gmail.com>
 <87o8xp5lo9.fsf@linux.ibm.com> <8736eohva1.fsf@linux.ibm.com>
 <CAPcyv4hroohsrXT1YHQB-L8ZFa2kUW+bKy03We4Mt7afeJgu3Q@mail.gmail.com> <87o8x9h5qa.fsf@linux.ibm.com>
In-Reply-To: <87o8x9h5qa.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 19 Nov 2019 09:58:19 -0800
Message-ID: <CAPcyv4gv52NK4+=3wcJ2uKX7xnaYVaF-H6O-XfJK8MiRX60SBg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: E5MZMR5VSGZQ7QZULLJ37XTXDXIM7SS3
X-Message-ID-Hash: E5MZMR5VSGZQ7QZULLJ37XTXDXIM7SS3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E5MZMR5VSGZQ7QZULLJ37XTXDXIM7SS3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 18, 2019 at 1:52 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Sat, Nov 16, 2019 at 4:15 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
>
> ....
>
>
> >>
> >> Considering the direct-map map size is not going to be user selectable,
> >> do you agree that we can skip the above step 0 configuration you
> >> suggested.
> >>
> >> The changes proposed in the patch series essentially does the rest.
> >>
> >> 1) It validate the size against the arch specific limit during
> >> namespace creation. (part of step 1)
> >
> > This validation is a surprise failure to ndctl.
> >
> >> 2) It also disable initializing a region if it find the size not
> >> correctly aligned as per the platform requirement.
> >
> > There needs to be a way for the user to discover the correct alignment
> > that the kernel will accept.
> >
> >> 3) Direct map  mapping size is different from supported_alignment for a
> >> namespace. The supported alignment controls what possible PAGE SIZE user want the
> >> namespace to be mapped to user space.
> >
> > No, the namespace alignment is different than the page mapping size.
> > The alignment is only interpreted as a mapping size at the device-dax
> > level, otherwise at the raw namespace level it's just an arbitrary
> > alignment.
> >
> >> With the above do you think the current patch series is good?
> >
> > I don't think we've quite converged on a solution.
>
> How about we make it a property of seed device. ie,
> we add `supported_size_align` RO attribute to the seed device. ndctl can
> use this to validate the size value. So this now becomes step0
>
> sys/bus/nd/devices/region0> cat btt0.0/supported_size_align
> 16777216
> /sys/bus/nd/devices/region0> cat pfn0.0/supported_size_align
> 16777216
> /sys/bus/nd/devices/region0> cat dax0.0/supported_size_align
> 16777216

Why on those devices and not namespace0.0?

> We follow that up with validating the size value written to size
> attribute(step 1).
>
> While initializing the namespaces already present in a region we again
> validate the size and if not properly aligned we mark the region
> disabled.

The region might have a mix of namespaces, some aligned and some not,
only the misaligned namespaces should fail to enable. The region
should otherwise enable successfully.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

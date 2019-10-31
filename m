Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F22EAA9F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 07:30:34 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB494100DC401;
	Wed, 30 Oct 2019 23:31:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 24871100EA55F
	for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 23:31:00 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u13so4441495ote.0
        for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qgpzQ0JhjLVnJIOjjWL6Mowx327SPlx5pn1SoNDC+c=;
        b=1iqBC0jzqdA13DrnN43K3m1+K1ZNqhq6x3w5m8hY9nmbnUHOC0YmFxMimWdsAHYbnI
         Ft3Rhnr8sPfxIofC44Z/7Qrj4UgcXvACmnJp8eml2arLILt+rcSesmzbCxOvC50+LHHO
         DRsbi1+URJb3jRF4UQ489hhz9yx/vlAHsDk1NJuVPeke2fBxAofoORk7sCTY86yK9iov
         oI+I2WxAr10EvAm4jP5oXZzbFKSp1ClKqT3PJvht0xi7G3Ah9qNlEuxnXG/frHYS0Rzn
         nBdTpaYB4akqfyViaE/3xWJe1VWVmWbjSHsDKvUMpr5f1CosZc8fd527iFHZbuXM/3Mi
         1cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qgpzQ0JhjLVnJIOjjWL6Mowx327SPlx5pn1SoNDC+c=;
        b=RCsb2tWCCgQKqROpotU0KcIjZcSb14VZMrDo5e1aNQ1lGN+t6QQr8pjskAdDXlHJ+7
         HilHrqTS8fi4a15VVaDtlwkAr9MJAUh0aPA2JAAs7bA7Yulhwo7lpIXAke9lHSBfz+mY
         jWyHM7TQfVdiu52PYTZf6ugdW8oPD7uVKxDLr2zQGOxRFM9denCS7FefRIQpWUTkZ/RI
         piO39s3G9TukfcDtGtt5zXZzYvvNuivAo5PeHdPrm3deAFAlD4p/WzQHMoKCOT5tMrf7
         5gfGhMWbrBf1InQ7AgSToCswFjskc+c4lTM9hWvrEgO6+91Q/FomRnGC5uU9jBmibNrV
         lJbg==
X-Gm-Message-State: APjAAAVyo8adxa+DZumawWBI03dt2Hfd73ZpkPn72pr/TDJd4eezimgU
	4xR67LX+7q1ZUo+95AjTKVTGd5g3R9gB3ezrBBcxyw==
X-Google-Smtp-Source: APXvYqwsCcmEYbccy1+yhmtPx5o8k4Qn3ow1DuGI5ZSJal+v+fE3sTW9IHilS6kah7NkRLnkK2a0NND6knXg87rdbe4=
X-Received: by 2002:a05:6830:18d1:: with SMTP id v17mr2928239ote.71.1572503430036;
 Wed, 30 Oct 2019 23:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4gZ=wKzwscu_nch8VUtNTHusKzjmMhYZWo+Se=BPO9q8g@mail.gmail.com>
 <6f85f4af-788d-aaef-db64-ab8d3faf6b1b@linux.ibm.com> <CAPcyv4gMnSe26QfSBABx0zj3XuFqy=K1XaGnmE3h3sP3Y76nRw@mail.gmail.com>
 <4c6e5743-663e-853b-2203-15c809965965@linux.ibm.com>
In-Reply-To: <4c6e5743-663e-853b-2203-15c809965965@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 30 Oct 2019 23:30:19 -0700
Message-ID: <CAPcyv4h42_1deZDaaW1RqX0Ls+maiFO_1e=6xJuHTa3wdWvVvA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: MM3RYADNPUK4RGGV3JZXA43LFIDJWNS3
X-Message-ID-Hash: MM3RYADNPUK4RGGV3JZXA43LFIDJWNS3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MM3RYADNPUK4RGGV3JZXA43LFIDJWNS3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 30, 2019 at 10:35 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
[..]
> > True, for the pfn device and the device-dax mapping size, but I'm
> > suggesting adding another instance of alignment control at the raw
> > namespace level. That would need to be disconnected from the
> > device-dax page mapping granularity.
> >
>
> Can you explain what you mean by raw namespace level ? We don't have
> multiple values against which we need to check the alignment of
> namespace start and namespace size.
>
> If you can outline how and where you would like to enforce that check I
> can start working on it.
>

What I mean is that the process of setting up a pfn namespace goes
something like this in shell script form:

1/ echo $size > /sys/bus/nd/devices/$namespace/size
2/ echo $namespace > /sys/bus/nd/devices/$pfn/namespace
3/ echo $pfn_align > /sys/bus/nd/devices/$pfn/align

What I'm suggesting is add an optional 0th step that does:

echo $raw_align > /sys/bus/nd/devices/$namespace/align

Where the raw align needs to be needs to be max($pfn_align,
arch_mapping_granulariy).

So on powerpc where PAGE_SIZE < arch_mapping_granulariy, the following:

cat /sys/bus/nd/devices/$namespace/supported_aligns

...would show the same output as:

cat /sys/bus/nd/devices/$pfn/align

...but with any alignment choice less than arch_mapping_granulariy removed.



All that said, the x86 vmemmap_populate() falls back to use small
pages in some case to get around this constraint. Can't powerpc do the
same? It would seem to be less work than the above proposal.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

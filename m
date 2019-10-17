Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744D4DA489
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Oct 2019 06:12:57 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 059D910FD49C2;
	Wed, 16 Oct 2019 21:15:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DCECB10FD49C0
	for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 21:15:18 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c10so689637otd.9
        for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 21:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3ibgL4TUKuZHBtqz2IXFcYfALlcUQnSyIxMKaXmlBg=;
        b=jkdPOQW2w3D0PMomKhNJNoqKHmzY0ecVe9iPz9v52bCh0bjUSLOckshiT+tXaOeVTG
         i2Zo6LVAdY6XjpiJ6TKB6nMe57nZgH9NOANZ88SC+kMGia2fZFoZ62kMDbwM5QOjHczY
         Rzs2ue92zEY39EkPgtsWcNg3NsNKwy+ioYaWC7sskSdw9uDHKawsgq2wasJlktLJvyJc
         ikD3rXf33fZq8n3SAMwWordqYaUVGykpsNWZrwNNYryTWSR/L+WiYw2Ty2ovmtawFe1z
         gZevJhUS/Z0lfE4VN/xs+RH7L/X/G8Xg4HxSnRd+X4jViNiZs5NhFmnn7HYSA4Apy+oU
         sKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3ibgL4TUKuZHBtqz2IXFcYfALlcUQnSyIxMKaXmlBg=;
        b=n5jVW0OarExsafUHNK/LiI9WKTjGMCQeJyug4mIgeSJSi6WizQKHiQUA8G2cc3o95Y
         riJFLDB/Z0PjDgQciuRBbV7fyKaJiVZQh9uwvb+lX8dvcmNP7LnNsRIprS0XmMlwJppQ
         Y6DvHhZVZ/JXDBosqWytlo5YJe3mBr9jdJ1AampEicZMjaH3BbncfYcB+S+LlP+iJxaP
         WvIz/nVCk/EtYFMaJL7xkmFj2pLn1fWfkl/GVtR4xvt1R0g47GWsOOJsHkl2caM0OgYh
         xpVGGLtnYZGNX2X2MrLgs6Hv6KB7oiYJXFrjhi1WOnvsfNZhSO+f7OlDGUGPw/CHJyNT
         Rp9g==
X-Gm-Message-State: APjAAAWJf27p3U8J7pqt6NYb1b+0N8o0VYRI8mIXnA+sM6We7YDnm+Re
	CTytnuTzQni2pt/qMrMmkyvjtWCv3O6rU4E9INEc7w==
X-Google-Smtp-Source: APXvYqwdxjFLHYai2RgMcWhRz/KLuQTGihhu6eJBiLzTtf62LQwzpOUtKka4FLNHyZw/iNQTaKwlM0GGG9Fh5t5TJkA=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr1308314otn.363.1571285539376;
 Wed, 16 Oct 2019 21:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ihjGGAOF0NK_23yuOpsdBY7M=UZWNt1KN3WnP_e9WZOg@mail.gmail.com>
 <7376f286-0947-61aa-7ebf-c50f32642ed8@linux.ibm.com> <CAPcyv4jrdAAxtrre4Ypt-+ZpuqKia5kLwCO4qfryshhxVj6eFA@mail.gmail.com>
 <2144f6dc-faab-3e93-d049-cc146c38258a@linux.ibm.com> <CAPcyv4iAz1OSDCKhNt+weBOTg1OsKbs6h740vG8P2NxRHbUrPw@mail.gmail.com>
 <07a4dd71-65f0-a911-60be-e3ea1ce8305b@linux.ibm.com> <CAPcyv4grR0o5jRH+hqPNqDW8rCmU4bUfctzPxGUg+mZN9h_8TQ@mail.gmail.com>
 <d99770e8-ae29-c38f-9daf-6965d5eab2cb@linux.ibm.com>
In-Reply-To: <d99770e8-ae29-c38f-9daf-6965d5eab2cb@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Oct 2019 21:12:08 -0700
Message-ID: <CAPcyv4hVTHMJ9FQsDs-iCecK0VXqSReeDnz0vF9vwQMMDhY2Pw@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] libnvdimm/nsio: differentiate between probe
 mapping and runtime mapping
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: 56O7HKNNYSAQJY6VKJHBDCLHE5QENCJU
X-Message-ID-Hash: 56O7HKNNYSAQJY6VKJHBDCLHE5QENCJU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/56O7HKNNYSAQJY6VKJHBDCLHE5QENCJU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 16, 2019 at 8:19 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 10/17/19 8:34 AM, Dan Williams wrote:
> > On Wed, Oct 16, 2019 at 7:43 PM Aneesh Kumar K.V
>
>
> ....
>
> >>>
> >> The error is printed by generic code and the failures are due to fixed
> >> size. We can't workaround that using vmalloc=<size> option.
> >
> > Darn.
> >
> > Ok, explain to me again how this patch helps. This just seems to delay
> > the inevitable failure a bit, but the end result is that the user
> > needs to pick and choose which namespaces to enable after the kernel
> > has tried to auto-probe namespaces.
> >
>
> Right now we map the entire namespace using I/O remap range while
> probing and if we find the namespace mode to be fsdax or devdax we unmap
> the namespace and map them back using direct-map range. This temporary
> mapping cause transient failures if two large namespaces were probed at
> the same time. We try to map the second names space in the I/O remap
> range while the first one is already mapped there. ie,
>
> If we have two 6TB namespaces with an I/O remap range limit of 8TB. We
> can individually create these namespaces and enable/disable them because
> they are within the 8TB limit. But if we try to probe them together,
> and if namespace1 is already mapped in the I/O remap range we have only
> 2TB space left in the I/O remap range and trying to probe the second
> namespace at the same time fails due to lack of space to map the
> namespace during probing.
>
> This is not an issue with raw/btt, because they keep the namespace
> always mapped in the I/O remap range and if we are able to create a
> namespace we can enable them together. (we do have the issue of creating
> large raw/btt namespace while other raw/btt namespaces are disabled and
> trying to enable them all together).
>
> The fix proposed in this patch is to not map the full namespace range
> while probing. We just need to map the reserve block to find the
> namespace mode. Based on the detected namespace mode, we either use
> direct-map range or I/O range to map the full namespace.
>

Ah, ok, you're not trying to address the case where raw and btt
namespaces don't fit you're trying to fix the case where raw and btt
namespaces *do* fit in the vmap, but pfn / fsdax namespaces exceed the
vmap.

I would highlight that in the changelog, namely that an otherwise
working configuration with two namespaces (one btt and one pfn), where
the btt namespace consumes almost all the vmap space, will fail to
enable due to needing too much temporary vmap space to initialize the
pfn mode namespace.

Let's also make this a bit more self contained to devm_nsio_enable()
and add a length parameter. Then when btt is ready to start accessing
more than the initial 8K it can be just be called again with the full
namespace size. Then devm_nsio_enable can notice when the mapping
needs to be expanded vs established.

Although btt should not be making assumptions about the underlying
namepsace type so it would need to call a new devm_ndns_enable()
wrapper that calls devm_nsio_enable() for nsio namespaces and is a nop
for ndblk namespaces.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

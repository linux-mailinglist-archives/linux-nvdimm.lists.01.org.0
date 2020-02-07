Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE69155C94
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Feb 2020 18:06:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 26B3910FC3585;
	Fri,  7 Feb 2020 09:10:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3F71C10FC3584
	for <linux-nvdimm@lists.01.org>; Fri,  7 Feb 2020 09:10:02 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id p125so2623481oif.10
        for <linux-nvdimm@lists.01.org>; Fri, 07 Feb 2020 09:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeTa1kMSEl3fLJZjvubhBF7lLU+TSysbdNVa6LXQMGs=;
        b=xOuwqNiXcHB10xcosisChgV9ONSo/c2Qus/rR544MZlBpD5Ay7hfJC9WVKAzaAd+7f
         U/ogZnw+r/oWo8eLbbH1uz2FRsW4ncL3QQaYOXB5tMGUNUgy9QHudVLVGzSGf8tXQiLG
         G6FWY4st3CWg8CfeGHSGW+U0i4wcqLAm7c9T7Azgx+NnGbBA+0LfgBRgJ8ftSQl4fhml
         Ib9zZx/YscmftDwtkfPV4UTOHlsHGOZr/rD9r64BmBjyAr0bHE9Q0BvufvvHXSJLVzc9
         NuNjDbXAE4Jh3nBxliXXwfSgHCDqAqeTlhhwOsS2lluLxXV//IML04qYltBOcwek/+nD
         vPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeTa1kMSEl3fLJZjvubhBF7lLU+TSysbdNVa6LXQMGs=;
        b=q7WUdJ3o9cwDR7UJJUxR0kZfF7nsEb60DzztZwIWKqr4r8Tw4AZHyw9KpccHpQQTJF
         YA0eQlrSIfs8VKorrwFnUpEz2eBH0DsfS2+8x30ChQ6GysbgY8voiFW2I5mCSXxqzNz5
         XJy9V38YS+coHskmXzy7uLJ9bhhvoXSlckUQi0fQxygwmGvokUeEEKx5eWyVF8E/qXUz
         35uPgyg0PtXzqIOYZI84bIo1Tgdt3iqj9gl56BiXVlVpTq0JnAoOkckzka2uoaE9i4l8
         xAKUpaNzmiXOy3qDzo/KZ0i98OQ1Vb+kiHTOSzj4Yjz5O2xv3iXpO50lw2iadowzJUjk
         05Lg==
X-Gm-Message-State: APjAAAWRbvCBv/ILI4TeZS1fW0+trt0DiDgG6rZKRSwaeCCh6AZQgmR2
	Su13P4EKqOcRY/yyTc9/lsUCQiyjYcNL0N0PqGi5Gg==
X-Google-Smtp-Source: APXvYqyM78u7JQAugFgv5zZBfNuG8N7zn04ejIqfum6zEtPcj48HqoBLg00kLaeSxn3H7xzZslVIa+EkM26FbgU/wvs=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr2851359oij.0.1581095203775;
 Fri, 07 Feb 2020 09:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20200203200029.4592-1-vgoyal@redhat.com> <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org> <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
 <20200206074142.GB28365@infradead.org> <CAPcyv4iTBTOuKjQX3eoojLM=Eai_pfARXmzpMAtgi5OWBHXvzQ@mail.gmail.com>
 <20200207170150.GC11998@redhat.com>
In-Reply-To: <20200207170150.GC11998@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 7 Feb 2020 09:06:32 -0800
Message-ID: <CAPcyv4g8jUhaKXhoh-1cvE4oi2v0JQcLrnFUW9zsRiC4F-7-zQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: JEPU4FP7T3HFLQH6XOQDZ34YKUFQVDWV
X-Message-ID-Hash: JEPU4FP7T3HFLQH6XOQDZ34YKUFQVDWV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JEPU4FP7T3HFLQH6XOQDZ34YKUFQVDWV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 7, 2020 at 9:02 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Feb 07, 2020 at 08:57:39AM -0800, Dan Williams wrote:
> > On Wed, Feb 5, 2020 at 11:41 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
> > > > > I don't have any reason not to pass phys_addr_t. If that sounds better,
> > > > > will make changes.
> > > >
> > > > The problem is device-mapper. That wants to use offset to route
> > > > through the map to the leaf device. If it weren't for the firmware
> > > > communication requirement you could do:
> > > >
> > > > dax_direct_access(...)
> > > > generic_dax_zero_page_range(...)
> > > >
> > > > ...but as long as the firmware error clearing path is required I think
> > > > we need to do pass the pgoff through the interface and do the pgoff to
> > > > virt / phys translation inside the ops handler.
> > >
> > > Maybe phys_addr_t was the wrong type - but why do we split the offset
> > > into the block device argument into a pgoff and offset into page instead
> > > of a single 64-bit value?
> >
> > Oh, got it yes, that looks odd for sub-page zeroing. Yes, let's just
> > have one device relative byte-offset.
>
> So what's the best type to represent this offset. "u64" or "phys_addr_t"
> or "loff_t" or something else.  I like phys_addr_t followed by u64.

Let's make it u64.

phys_addr_t has already led to confusion in this thread because the
first question I ask when I read it is "why call ->direct_access() to
do the translation when you already have the physical address?".
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6841313CD66
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 20:48:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 48B6610097DD3;
	Wed, 15 Jan 2020 11:51:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B16FE10097DD3
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 11:51:40 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id 18so16599095oin.9
        for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 11:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUOzn9+9UaVvL6o/mAbP91IHRP08NJIA3dh59ibHU2I=;
        b=SnfOC48TtXuess7VSwWZvuY0YhR/oID3OWYVCwwmTTiY60WA/bSrM69Hpe22VSYfgJ
         F7uTwPL7NZnkrweGWzvFu1mZ9lOTYHJS3wjvSJzY5ouMw8bRCjxxvnWRzEKGBigBxX2W
         NBxTa/GkOWhGRNcdaD1rylOIQzlR8zh73btfdW2DDG6i+WnJlAoUwX8pz4e8T58isW1v
         xIj5HgX1IHbipliiVOeO/DjfsMC9OfxyG7D7QrfT6ih5+PTy43DNEms9a8hJlvXziHs5
         VBV00AGJjSCi45HNPMWXjXn7E8qXuO628Djdy0Ugu8VT73QyWtvqK62YexCGRR5KkeeI
         4kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUOzn9+9UaVvL6o/mAbP91IHRP08NJIA3dh59ibHU2I=;
        b=nND3HesfKGpAcJzgM+gDI9ICWJkg5RFx0RpbX+zbXzYDonpMTo9OVoar/jAqR7g3/N
         mN88Vdn7VnGemo7in+8fYsqIjh7uyWpiSgknEdwR0q6ploOZoNozKABjgvIJra62nv+O
         rir9UQUfaxzG+fh3jVmslprwT32WBOHDUMbcit2IapHBhrvJZAChfhZKYyi69fnLZlYh
         xbaWZK32UzVCxKbv7icvUGU/cTjn8ldublc0+lrZ0LgmfGJ3jJ9GVEJ/HK60cdPJ+wTP
         rruOffYwCF/F9/1fKSNDNuL5bRVA0IhU5vw7QFAHDuohJ4qVaV+6pG6KRebwxnJpgyQf
         OpRA==
X-Gm-Message-State: APjAAAXXejBxTu3oPSJxldl9Pg8HEFgshxAYymRW+GsMr5e+auJn6Xj8
	KiwAiavirZtOtc5G3jnG7wE43u1d7clutbZ5V+8/ew==
X-Google-Smtp-Source: APXvYqwXaaBAxsZvdbOsj6e8kAJVDZXi9AGsocqUogB/i/ZgKzt2ya0mTiQ8iayrqVjMM8B93KZO66zK2iItNXQk+/A=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr1125980oia.73.1579117700453;
 Wed, 15 Jan 2020 11:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20200108064905.170394-1-aneesh.kumar@linux.ibm.com>
 <x49o8v4oe0t.fsf@segfault.boston.devel.redhat.com> <a87b5da8-54d1-3c1a-f068-4d2f389576c9@linux.ibm.com>
 <x49k15soc5v.fsf@segfault.boston.devel.redhat.com> <3184f0f6-1dc7-28b8-0b29-b2b9afa490d3@linux.ibm.com>
In-Reply-To: <3184f0f6-1dc7-28b8-0b29-b2b9afa490d3@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 15 Jan 2020 11:48:09 -0800
Message-ID: <CAPcyv4i9rvDmFW09A6uChhsiRAgENVp6KTPUmDcUrO5haan6=g@mail.gmail.com>
Subject: Re: [RFC PATCH] libnvdimm: Update the meaning for persistence_domain values
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: DGNPUZYE2MUAA6LPMGMRGSYUE7KGRJZD
X-Message-ID-Hash: DGNPUZYE2MUAA6LPMGMRGSYUE7KGRJZD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DGNPUZYE2MUAA6LPMGMRGSYUE7KGRJZD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 15, 2020 at 9:56 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 1/15/20 11:05 PM, Jeff Moyer wrote:
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >
>
> >>>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> >>>> index f2a33f2e3ba8..9126737377e1 100644
> >>>> --- a/include/linux/libnvdimm.h
> >>>> +++ b/include/linux/libnvdimm.h
> >>>> @@ -52,9 +52,9 @@ enum {
> >>>>             */
> >>>>            ND_REGION_PERSIST_CACHE = 1,
> >>>>            /*
> >>>> -   * Platform provides mechanisms to automatically flush outstanding
> >>>> -   * write data from memory controler to pmem on system power loss.
> >>>> -   * (ADR)
> >>>> +   * Platform provides instructions to flush data such that on completion
> >>>> +   * of the instructions, data flushed is guaranteed to be on pmem even
> >>>> +   * in case of a system power loss.
> >>>
> >>> I find the prior description easier to understand.
> >>
> >> I was trying to avoid the term 'automatically, 'memory controler' and
> >> ADR. Can I update the above as
> >
> > I can understand avoiding the very x86-specific "ADR," but is memory
> > controller not accurate for your platform?
> >
> >> /*
> >>   * Platform provides mechanisms to flush outstanding write data
> >>   * to pmem on system power loss.
> >>   */
> >
> > That's way too broad.  :) The comments are describing the persistence
> > domain.  i.e. if you get data to $HERE, it is guaranteed to make it out
> > to stable media.
>
> With technologies like OpenCAPI, we possibly may not want to call them
> "memory controller"? In a way platform mechanism will flush them such
> that on power failure, it is guaranteed to be on the pmem media. But
> should we call these boundary "memory_controller"? May be we can
> consider "memory controller" an overloaded term there. Considering we
> are  calling this as memory_controller for application to parse via
> sysfs, may be the documentation can also carry the same term.

I don't see how OpenCAPI or any other transport has any bearing on the
"memory_controller" term. It's still a controller of persistent memory
and it needs to have the write data received at its buffers / queue to
ensure that the data gets persisted, or, as in the cpu_cache case,
some other agent takes responsibility for shuttling pending writes
that have hit the cache out over the transport to be persisted.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
